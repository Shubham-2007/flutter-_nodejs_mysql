const { Router } = require('express');
const router = Router();

const mysqlconnection = require('../database/database');

router.get('/', (req, res) => {
    res.status(200).json('server on port 3000 and database is connected');
});

//authenticate user

router.get('/users/auth/:email/:pswd', (req, res) => {
    var email = req.params.email;
    var psd = req.params.pswd;
    mysqlconnection.query('select id from users where email=? and password=?;', [email, psd], (error, rows) => {
        if (rows.length == 0) {
            res.send('no user found');
        } else {
            if (!error) {
                res.json(rows[0].id);
            } else {
                console.log(error);
            }
        }
    })
});

//get all users
router.get('/:users', (req, res) => {
    mysqlconnection.query('select * from users;', (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//get all assigned task of a user
router.get('/:users/:id/asstasks', (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('select * from asstasks where tid=?;', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//get all assigned task by a user
router.get('/:users/:id/asstasksbyme', (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('select * from asstasks where id=?;', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//get all self tasks of a user
router.get('/:users/:id/selftasks', (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('select * from selftask where uid=?;', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//get all numbers
router.get("/users/number", (req, res) => {
    mysqlconnection.query('select id,username,number from users;', (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//get all names
router.get("/users/names", (req, res) => {
    mysqlconnection.query('select username from users;', (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//get all email
router.get("/users/mails", (req, res) => {
    mysqlconnection.query('select email from users;', (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//get a user
router.get('/:users/:id', (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('select * from users where id = ?;', [id], (error, rows, fields) => {
        if (!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//input new user
router.post('/:users/input/:id', (req, res) => {
    const { id } = req.body;
    const { username, lastname, mail, number, password } = req.body;
    console.log(req.body);
    console.log(id);
    mysqlconnection.query('insert into users values (?,?,?,?,?,?)', [id, username, lastname, mail, number, password], (error, rows, fields) => {
        if (!error) {
            res.send('user saved');
        } else {
            console.log(error);
        }
    });
});

//update user
router.put('/:users/update/:id', (req, res) => {
    const { id, username, lastname, mail, number } = req.body;
    console.log(req.body);
    mysqlconnection.query('update set username=?,lastname=?,email=?,number=? where id=?', [username, lastname, mail, number, id], (error, rows, fields) => {
        if (!error) {
            res.json({ Status: 'user updated' });
        } else {
            console.log(error);
        }
    });
});

//assign task to self
router.put('/:users/:id/assignselftask', (req, res) => {
    var id = req.params.id;
    const { title, descp, date, status } = req.body;
    console.log(req.body);
    mysqlconnection.query('insert into selftask values (?,?,?,?,?);', [id, title, descp, date, status], (error, rows, fields) => {
        if (!error) {
            res.send('selftask added');
        } else {
            console.log(error);
        }
    });
});

//assigning task to other
router.put('/:users/:id/assigntask/:tid', (req, res) => {
    var id = req.params.id;
    var tid = req.params.tid;
    const { title, desc, date, status } = req.body;
    console.log(req.body);
    mysqlconnection.query('insert into asstasks values (?,?,?,?,?,?);', [id, title, desc, date, tid, status], (error, rows, fields) => {
        if (!error) {
            res.send("task added");
        } else {
            console.log(error);
        }
    });
});

//completed selftask
router.put('/users/comselftask/:id', (req, res) => {
    const { id } = req.params;
    const { title, date } = req.body;
    mysqlconnection.query('update selftask set status="1" where uid=? and title=? and date=?;', [id, title, date], (error, rows) => {
        if (!error) {
            console.log('completed task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//completed asstask by worker
router.put('/users/comAssWtask/:tid', (req, res) => {
    const { tid } = req.params;
    const { title, date } = req.body;
    console.log(tid);
    console.log(req.body);
    mysqlconnection.query('update asstasks set status="1" where tid=? and title=? and date=?;', [tid, title, date], (error, rows) => {
        if (!error) {
            console.log('completed task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//complete assigned task by owner
router.put('/users/comAssAtask/:id', (req, res) => {
    const { id } = req.params;
    const { title, tid, date } = req.body;
    console.log(req.body);
    mysqlconnection.query('update asstasks set status="1" where id=? and title=? and tid=? and date=?;', [id, title, tid, date], (error, rows) => {
        if (!error) {
            console.log('completed task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//update selftask
router.put('/users/updateSelf/:id', (req, res) => {
    const { id } = req.params;
    const { title, date, utitle, udesc, udate } = req.body;
    mysqlconnection.query('update selftask set title=?,descp=?,date=? where uid=? and title=? and date=?;', [utitle, udesc, udate, id, title, date], (error, rows) => {
        if (!error) {
            console.log('updated task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//update asstask by assigner
router.put('/users/updateAssA/:id', (req, res) => {
    const { id } = req.params;
    const { title, date, tid, utitle, udesc, utid, udate } = req.body;
    mysqlconnection.query('update asstasks set title=?,descp=?,tid=?,date=? where id=? and title=? and tid=? and date=?;', [utitle, udesc, utid, udate, id, title, tid, date], (error, rows) => {
        if (!error) {
            console.log('updated task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//delete a selftask
router.put('/users/deleteself/:id', (req, res) => {
    const { id } = req.params;
    const { title, date } = req.body;
    mysqlconnection.query('update selftask set status="-1" where uid=? and title=? and date=?;', [id, title, date], (error, rows) => {
        if (!error) {
            console.log('deleted task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//delete an assigned task(Deleteing by assigner)
router.put('/users/deleteAssA/:id', (req, res) => {
    const { id } = req.params;
    const { title, tid, date } = req.body;
    mysqlconnection.query('update asstasks set status=-1 where id=? and title=? and tid=? and date=?;', [id, title, tid, date], (error, rows) => {
        if (!error) {
            console.log('deleted task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//delete an assigned task(Deleteing by worker)
router.put('/users/deleteAssW/:tid', (req, res) => {
    const { tid } = req.params;
    const { title, date } = req.body;
    mysqlconnection.query('update asstasks set status=2 where tid=? and title=? and date=?;', [tid, title, date], (error, rows) => {
        if (!error) {
            console.log('deleted task');
            res.send('done');
        } else {
            console.log(error);
            res.send(error.errno);
        }
    });
});

//delete user
router.delete('/:users/:id', (req, res) => {
    const { id } = req.params;
    mysqlconnection.query('delete from users where id=?', [id], (error, rows, fields) => {
        if (!error) {
            res.json({ Status: 'user deleted' });
        } else {
            console.log(error);
        }
    });
});

module.exports = router;


// for (var key in req.body) {
//     var value = req.body[key];
//     console.log(`${value}`);
// }