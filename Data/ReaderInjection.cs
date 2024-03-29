﻿using System;
using System.Data;
using MRGSP.ASMS.Core.Model;
using Omu.ValueInjecter;

namespace MRGSP.ASMS.Data
{
    public class ReaderInjection : KnownSourceValueInjection<IDataReader>
    {
        protected override void Inject(IDataReader source, object target)
        {
            for (var i = 0; i < source.FieldCount; i++)
            {
                var activeTarget = target.GetProps().GetByName(source.GetName(i), true);
                if (activeTarget == null) continue;

                var value = source.GetValue(i);
                if (value == DBNull.Value) continue;
                if(activeTarget.PropertyType == typeof(PoState?))
                    activeTarget.SetValue(target, Enum.Parse(typeof(PoState),value.ToString()));
                else
                activeTarget.SetValue(target, value);
            }
        }
    }
}