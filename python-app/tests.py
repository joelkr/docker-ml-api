import unittest
import flask_web

# This should test operation and validity of algorithms
# inside the container. The operation of interface should
# be tested from a separate container.
class TestCase(unittest.TestCase):

  def setUp(self):
    flask_web.app.config["TESTING"] = True
    self.app = flask_web.app.test_client()
  def test_sentiment_query(self):
    q = '{ "text": "REST services could be dangerous" }'
    page = self.app.post("/api/sentiment/query", data=q)
    # page is a Response object, does not seem to have anything but status.
    # "flask unit test rest api"
    print(page.content)
    assert page.status_code == 200
  def test_sentiment_json(self):
    q = '{ "text": "REST services could be dangerous" }'
    page = self.app.post("/api/sentiment/query", data=q)
    page_json = page.get_json()
    assertIsNotNone(page_json)
  def test_sentiment_has_polarity(self):
    q = '{ "text": "REST services could be dangerous" }'
    page = self.app.post("/api/sentiment/query", data=q)
    page_json = page.get_json()
    assert 'polarity' in page_json
    

if __name__ == '__main__':
  unittest.main()
