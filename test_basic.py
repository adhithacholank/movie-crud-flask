import os
import unittest

from movie import app, db

TEST_DB = 'test.db'
project_dir = os.path.dirname(os.path.abspath(__file__))

class BasicTests(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        app.config['WTF_CSRF_ENABLED'] = False
        app.config['DEBUG'] = False
        app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(project_dir, TEST_DB)

        # Push the application context
        self.app_context = app.app_context()
        self.app_context.push()

        self.app = app.test_client()

        db.drop_all()
        db.create_all()

        self.assertEqual(app.debug, False)

    def tearDown(self):
        db.session.remove()
        db.drop_all()
        # Pop the application context
        self.app_context.pop()

    def test_main_page(self):
        response = self.app.get('/', follow_redirects=True)
        self.assertEqual(response.status_code, 200)


if __name__ == "__main__":
    unittest.main()
