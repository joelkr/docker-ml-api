import unittest
import flask-web

# This should test operation and validity of algorithms
# inside the container. The operation of interface should
# be tested from a separate container.
class TestCase(unittest.TestCase):

  def setUp(self):
    flask-web.app.config["TESTING"] = True
    self.app = flask-web.app.test_client()
  def test_sentiment_query(self):
    q = '{ "text": "REST services could be dangerous" }'
    page = self.app.post("/api/sentiment/query", data=q)
    assert page.status_code == 200

if __name__ == '__main__':
  unittest.main()
