import os
import asyncio
from hume import AsyncHumeClient
from hume.expression_measurement.stream import Config
#from hume.expression_measurement.stream.types import StreamLanguage
from hume.expression_measurement.stream.socket_client import StreamConnectOptions

# Set your Hume API key here (or via env var)
HUME_API_KEY = "K1qPxVYFDOJNrCH4fq6t9o6HfPRW3HqoLf0IaP0IxMvM5zJz"
# — or: HUME_API_KEY = os.getenv("HUME_API_KEY")

async def analyze_text(text: str):
    # Initialize the async client
    client = AsyncHumeClient(api_key=HUME_API_KEY)

    # Configure the streaming measurement (default language)
    config = Config(language={})
    options = {"config": config}

    # Open a streaming socket, send the text, and await the response
    async with client.expression_measurement.stream.connect(options=options) as socket:
        # truncate to 2000 chars to stay within limits
        result = await socket.send_text(text[:2000])

        # Extract the list of EmotionPrediction objects
        preds = result.language.predictions[0].emotions

        # Build a name→score dict
        emotions = {emo.name: emo.score for emo in preds}
        print("Emotion breakdown:")
        for name, score in emotions.items():
            print(f"  {name}: {score:.3f}")

if __name__ == "__main__":
    sample_text = "Woke up this morning with the same heavy weight in my chest—as if I’m carrying the entire world and can’t put it down. I barely made it out of bed; my limbs feel like lead and every movement takes twice as much effort. I managed two bites of toast before the nausea set in, and now my stomach just aches along with everything else.  I tried to distract myself, scrolling through my phone, but every notification felt like a reminder that nobody really cares. The messages I sent yesterday still hang unread, and I can’t find the courage to press “resend” or even “delete.” I stared at the screen for fifteen minutes before giving up and closing my eyes. Even silence feels too loud.  I thought about going for a walk—but the idea of stepping outside, facing late winter’s chill, scared me more than staying inside and facing my own thoughts. I’ve lost track of what brings me joy. Music feels hollow. Reading feels empty. And writing this down feels like admitting defeat. But I have to try, even if it hurts. Maybe tomorrow the weight will lift a fraction. Maybe tomorrow I’ll feel something other than this unrelenting ache."
    asyncio.run(analyze_text(sample_text))
