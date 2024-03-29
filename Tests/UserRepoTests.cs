﻿using System.Diagnostics;
using System.Linq;
using MRGSP.ASMS.Core.Model;
using MRGSP.ASMS.Data;
using NUnit.Framework;

namespace MRGSP.ASMS.Tests
{
    [TestFixture]
    public class UserRepoTests : BaseRepoTests
    {
        readonly UserRepo repo = new UserRepo(new ConnectionFactory());

        [Test]
        public void GetRolesTest()
        {
            (repo.GetRoles().Count() > 0).IsTrue();
        }

        [Test]
        public void Insert()
        {
            var id = repo.Insert("jora".AsUser());
            repo.Get(id).Name.ShouldEqual("jora");
            repo.GetRoles(id).Count().ShouldEqual(2);
        }

        [Test]
        public void Update()
        {
            var id = repo.Insert("jora".AsUser());
            repo.GetRoles(id).Count().ShouldEqual(2);
            var user = repo.Get(id);
            user.Roles = new[] { new Role() { Id = 3 } };
            repo.ChangeRoles(user);
            repo.GetRoles(id).Count().ShouldEqual(1);
        }

        [Test]
        public void GetPageAndCount()
        {
            repo.Insert(new User { Name = "j", Password = "a" });
            repo.Insert(new User { Name = "j1", Password = "a" });
            repo.Insert(new User { Name = "j2", Password = "a" });
            var w = new Stopwatch();
            w.Start();
            repo.GetPage(1, 3).Count().ShouldEqual(3);
            w.Stop();
            System.Console.Out.WriteLine(w.Elapsed);
            (repo.Count() > 3).IsTrue();
        }

        [Test]
        public void GetRolesByUser()
        {
            var roles = repo.GetRoles(1).ToArray();
            roles.Count().ShouldEqual(2);
            roles[0].Name.ShouldEqual("admin");
            roles[1].Name.ShouldEqual("superuser");
        }

        [Test]
        public void GetUser()
        {
            var id = repo.Insert("j".AsUser());
            var w = new Stopwatch();
            w.Start();
            var user = repo.Get(id);
            w.Stop();
            System.Console.Out.WriteLine(w.Elapsed);
            user.IsNotNull();
            user.Name.ShouldEqual("j");
        }
    }
}