﻿using System.Linq;
using MRGSP.ASMS.Core.Model;
using MRGSP.ASMS.Data;
using NUnit.Framework;

namespace MRGSP.ASMS.Tests
{
    public class FarmerRepoTest: BaseRepoTest
    {
        readonly FarmerRepo repo = new FarmerRepo(new ConnectionFactory());

        [Test]
        public void Insert()
        {
            var id = repo.Insert(new Farmer() { Code = "1234", Name = "name" });
            (id > 0).IsTrue();
        }

        [Test]
        public void Get()
        {
            var id = repo.Insert(new Farmer { Code = "1234", Name = "name" });
            (id > 0).IsTrue();
            
            repo.Get(id).Code.IsEqualTo("1234");
           
            repo.Get(-1).IsNull();
        }

        [Test]
        public void Count()
        {
            repo.Count(null, null);
        }

        [Test]
        public void GetPage()
        {
            repo.GetPage(1, 10, null, null).ToList();

        }
    }
}