Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4466C594E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCVWJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCVWJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:09:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41051B324;
        Wed, 22 Mar 2023 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679522946; x=1711058946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Beqt7bNtD/s17Ya4WYBdjcA+A1QA72goqE3JJ0TFLuY=;
  b=FEpDSLHk+7u+vBT1efF96RXCZpFL/tePFoP/V2cb1i5BI7eQDjATSoQp
   HFI5amOH6FVCUbFMIXpvZTCxJxEz16RqEl5VvyH+Eo75qDkWHGdkjcm4p
   0H7nXUzAqnVcGRPpyvika52gOSokI4VDshy2VsWyIrYzFPf6NwxUpzQVY
   QZ34F3rmuT2ck66S7/n8jxg1Be8CNWSEqhjU0vyYvXjJmPbvSWZ013SLc
   3h6WocMNlPhswRXoGvNzXhg1L/z6ywS5uDDCZxf4kB9LLfcJ5R8oXekVk
   kKgpSgFojUumcfpUWeyASWzRm48NKSgUTprW9I8u8ERhvQfaAAiQkQXTT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338064960"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="338064960"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 15:09:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="675459416"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="675459416"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 22 Mar 2023 15:09:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 15:09:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 15:09:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 15:08:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9RTsFvpkUZd/OnlDBvt1FYyFjM2oYGJEyyL8wxzOs0Qgh3ou2zdBPEKYMiiNBtLo+gNQEKhRu7Uibs/MI3J0vAY2dxZfVCikOF+ChTJh8tOW7l1A6Q/0YzN9ibVOfKniAvOFbunTucM0Ay+QWl/6kblnu5rTXepRphyPhdS41WqTDLWeeC9GI6AILY9hL8a4GAQf0qOk5w9ZNDJnYoBEB1NDHhD+YTidOh1EppNrf5ulkKPS22nLtI0Hum1jXc67fptevVaEsXEc9hiwOpikIm0OJlrPJAskc67W+urcS32VwVRvlLHZPJU7tSTEAE09lwsZXLmqvszvKJooWlHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Bkt725bCnpF8Ow8O+WFJzOOa3IWthEiLuSFwOPXeo=;
 b=SXZrJOYPfCnyVCQ8Gha0q8BfROgC/sKN937xrJQaYQD2LNujLS3QtWLqB2Y18Jfumc+beyiSjCuNM7Lpfau2Kz0pwf4p3uE6csQbnx9Gtm7MlHC3Ha/f+EPuO8xwOWQqYfEg/XDpPzh6kxNmTitn8z9JNuGNnwat4PbTFJnwopyUYhNjDWfkatS+2vzlLC7vR7aI+I8g90B0BLpQZpJsdxZXzx0B7g0ddFinJbBXdCvGrouu7nvHchpupo5ZsEXGqWkEBh2jqvO47onQ6WQENuUgch7Lgy4mBSEnfbVDlLZDbgPaCE/xQh0t3JkuJAvoKAPFKn2sue+HdoHa6rZpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA1PR11MB7131.namprd11.prod.outlook.com (2603:10b6:806:2b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 22:08:54 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 22:08:54 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Thread-Topic: [PATCH] srcu: Fix flush sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaCAADGigIAACIWAgACwsYCAAHV/oA==
Date:   Wed, 22 Mar 2023 22:08:54 +0000
Message-ID: <PH0PR11MB58804435C08AEADF23B095D1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
In-Reply-To: <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA1PR11MB7131:EE_
x-ms-office365-filtering-correlation-id: 0ff1a17e-5bb3-48e1-e129-08db2b2206a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upWvrAwPYvhr/TsEXHGh8y5O6v5noUl9mXqxFcMd+26gWwOAQXl6gqWlGj7BiQQpAUzWy7FyeJhjKM9EGhaJXF9JWSuvkEwKP1JsQyj+X53zW9lXQcD6pejeLYOCP+/5SUMtUCxciPpEDtcYkA1M76P4DeLjzPhN6QLRZbtGYAC4gRyN6+GdxuJlGRvnU1tQ9h49ufajo5AIrdJKRRvjkF4fzMYAUaehVNdZAMNZlaunw0vh7s5AcJWexquZDo5kQnlB0mPWOJak1WqSdXUoLzY3oXssUpxJ4h07o9fSpqQihyS7zOoLoIfJ9gkVku+Q6jii9SCDDJu6Ci0VxEoOAatHjNqNcrmEt0C3Ay6xsIhdXrS+nHiAiWUbdu1T20YNlL10zPvabApmgJTManERzOo3UpKtZXtxu4X5kKaZETZxO2QczUnAcGWK9VAL43aKFecs7tRTHF9WzUOj+gqrz78eZCDcGy3VU9TPwg3w2ErjxZp8/ydaTKnNPX640Xsmn6bZrtlhs3+bc2RdvZCCISDGwxMH5fMzr0RqRa7m+49w4xMtQooG1todwDf1cLOYn2wALPOurCnKiYQp111BP1uNx9gU9iYRMmtxsl/Pwpi6+0lB2TEu5Tk/SDXG5oGn05UASnd6b0nsARENUa4PFal8KkDKSJF19T2oKBiRTksaC13aYZGccIbaOli4UhL7RgLqTkeXFlCrc/juXSZWag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199018)(71200400001)(478600001)(45080400002)(7696005)(6506007)(83380400001)(54906003)(316002)(66446008)(66946007)(4326008)(8676002)(66556008)(64756008)(66476007)(76116006)(26005)(9686003)(122000001)(8936002)(186003)(52536014)(5660300002)(41300700001)(38100700002)(6916009)(82960400001)(2906002)(38070700005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kLLDQrwify/empMcrnPsCsyLT3Q0GBVQPGB7Wa9WVUgtmJ9b/BIJPFHDjGu7?=
 =?us-ascii?Q?ifGckZi5BA1/PYTTJCddYytDddOOpdUBmmhRe9rxktB7kg0DOF4tioDzjm/Y?=
 =?us-ascii?Q?4upO+/eUHmhdflwpSprL8T8nw/FSlERlrNic/f1DsK6n0YatYmmFYE8jdQxm?=
 =?us-ascii?Q?VeUWVQkTSVS0JWQgc9YebENGEvHx7FWsSCQkE5esHKVPbUF8jn/cLmHoCApD?=
 =?us-ascii?Q?9skZzEan/kao95ywiEk1HGIMrQolXDFABXqqd7VPNpC0TJWxxjywESxE5QbN?=
 =?us-ascii?Q?R/UwmTDGWdSywcyU52R1c/EuDEti3jOXcGWSx/uV7u74AZm+Bt55N5yfRNGn?=
 =?us-ascii?Q?PECy8SHtH41z3k0g7RK9qEj8SlCwMVfCsJ+6tdsax1RuWtCT9QoQdEJBf0IO?=
 =?us-ascii?Q?VVKgpgwrG7uRn8Lm2K4fTKeF0QXWRFDmfFt78QFJ+TP0fP6oJ7aSaSGHjILS?=
 =?us-ascii?Q?AcfaDyIc/txFHMuj2of2+R95EEB/ZD7kOGGf3WZjSJpllLtYgR5ac/ibyRFj?=
 =?us-ascii?Q?0jmaR80oQbiRZRiBf/xLY7+TXIVCEAe5ypHYJjg92+km0w7G7CXbJbqju19Y?=
 =?us-ascii?Q?ZcxGyCZ50Gqj5DgNveeKHdAtGJSvsz5za77YcQTuWsDPfzL0fHm6k0+P9EFD?=
 =?us-ascii?Q?g42uNC+nkhUyl09Mc8XcendYy1TxHFUmOOz93XSP5mWJ91O1Zone3OvF4Ubl?=
 =?us-ascii?Q?9S1yLFX7mHn0+QkTSsdxEtDEBVOZ5baJIIuQbdCK6tqZS7AQ7CWJ23oFP4KU?=
 =?us-ascii?Q?z82pvU4A/sfMX/mciyQ9DHtXIw8nPHvrKoWJDsZFZdi3ahyyeb/fQ3BNAPmz?=
 =?us-ascii?Q?74K/BxFs8A3nn+9V+pTVBPuflryq+7zzfA5EKWpo+Ec+mJnt0VeyAvomczE+?=
 =?us-ascii?Q?uV11aWXh1td1ikwyqnAH4/oDdB+Nti9zSKvMCNe+ZgAOcmor2tGkzDGufKB/?=
 =?us-ascii?Q?BErdh9tHXHO0cjvoUKJCVEnQCZ1E30/8uo1EmEb+D9Rj+PnYSMa8gVdaH826?=
 =?us-ascii?Q?QfZUb5JFgtqrElYWNdpu+CofrQ3FwwfztL2ut/E1TWQs5snxanIyxwIaiwX1?=
 =?us-ascii?Q?i8hFVkjPYWh9QPwMOWh1FhjTDUr5zhYMjAs1kmk8z5pW5TrT2L1APhpyu/bZ?=
 =?us-ascii?Q?MejNB0F+jYvdZjq3hSM/lSYu2oKn8ur8Y0YlwbLy9TIMjIebPLEsTlw3mcLM?=
 =?us-ascii?Q?y1BkcMU7ZQZx4xkMucM5MaF2kKL6gYCGLUgDO4U2yHyq4Nf8v/7OEyjXpGxJ?=
 =?us-ascii?Q?psaBakOuAjgSXF7T27B/2thzIVFClxseq/PQfMbF3hNo8XNk6EIYtWpyAOP1?=
 =?us-ascii?Q?PzhbjmyOA/bXquXrAxGYucy2AY/4KNQ2ImOXs+TnZQytDT32yDIGQ/WQJ8zS?=
 =?us-ascii?Q?DkRUdinD42ITwzyqIrwsGxlQXgj2DqcJCjXjh/emQEKQ/ES/yzWhjKJkOxFt?=
 =?us-ascii?Q?gJDYd5K+BLSVqXPtwjvYdBRYpDE9t+F13EVjo110B97Nb6X9vAFcLHYF+xLa?=
 =?us-ascii?Q?Pkk0sSfJ3a/+rhJ2JBxP+upe8YFK/ves/P4BOOutX9BqAlP8sfmndr6Cirvt?=
 =?us-ascii?Q?R0wnR7KYnIPN9rjBUXe8QxWL7new44tZvaFadfYF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff1a17e-5bb3-48e1-e129-08db2b2206a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 22:08:54.2667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5l1NSIrbNKAm78FBcuHFo2HTMFxQ4CUkCx8AEofeK0gMkc8U28SMKf0tCwYbXoOnPOR7m3orWl+L8JLn0Q0rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > insmod rcutorture.ko
> > > rmmod rcutorture.ko
> > >=20
> > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167=20
> > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in:=20
> > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382]=20
> > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard+=
=20
> > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776] =20
> > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817] =20
> > > srcu_module_notify+0x71/0x140 [  209.437854] =20
> > > blocking_notifier_call_chain+0x9d/0xd0
> > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062] =20
> > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > >=20
> > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU(),=
=20
> > > when compiling and loading as modules, the srcu_module_coming() is=20
> > > invoked, allocate memory for srcu structure's->sda and initialize=20
> > > sda structure, due to not fully initialize srcu structure's->sup, so=
=20
> > > at this time the sup structure's->delaywork.func is null, if not=20
> > > invoke init_srcu_struct_fields() before unloading modules, in=20
> > > srcu_module_going() the __flush_work() find
> > > work->func is empty, will raise the warning above.
> > >=20
> > > This commit add init_srcu_struct_fields() to initialize srcu=20
> > > structure's->sup, in srcu_module_coming().
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > >
> > >Good catch, and thank you for testing the in-module case!
> > >
> > >One question below...
> > >
> > >							Thanx, Paul
> > >
> > > ---
> > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=20
> > > 1fb078abbdc9..42d8720e016c 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *mo=
d)
> > >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> > >  		if (WARN_ON_ONCE(!ssp->sda))
> > >  			return -ENOMEM;
> > > -		init_srcu_struct_data(ssp);
> > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > +			return -ENOMEM;
> > >
> > >Wouldn't it be better to simply delete the init_srcu_struct_data()?
> > >
> > >Then the first call to check_init_srcu_struct() would take care of=20
> > >the initialization, just as for the non-module case.  Or am I missing=
=20
> > >something subtle?
> >=20
> > Hi Paul
> >=20
> > Maybe the check_init_srcu_struct() is always not invoked, for example,
> > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(srcu_ct=
l),
> > but we use torture_type=3Drcu to test,  there will not be any interface=
=20
> > calling
> > check_init_srcu_struct() to initialize srcu_ctl and set =20
> > structure's->delaywork.func is process_srcu().
> > when we unload the rcutorture module, invoke cleanup_srcu_struct() to=20
> > flush sup structure's->delaywork.func, due to the func pointer is not=20
> > initialize, it's null, will trigger warning.
> >=20
> > About kernel/workqueue.c:3167
> >=20
> > __flush_work
> >      if (WARN_ON(!work->func))   <---------trigger waning
> > 	return false;
> >=20
> >=20
> > and  in  init_srcu_struct_fields(ssp, true), wil set=20
> > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_needed=20
> > is zero,  after that when we call
> >  check_init_srcu_struct() again, it not be initialized again.
> >
> >
> >Good point!  In the non-module statically allocated case there is never =
a call to cleanup_srcu_struct().
> >
> >So suppose the code in srcu_module_coming() only did the alloc_percpu(),=
 and then the
> >code in srcu_module_going() only did the the matching
> >free_percpu() instead of the current cleanup_srcu_struct()?
>=20
> But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE_STA=
TIC_SRCU(),
> when a module is unloaded, we usually don't call cleanup_srcu_struct() in=
 the module
> unload function.
> If in srcu_module_going() only do free_percpu(), the srcu_sup->node memor=
y maybe
> can not free and also lost the opportunity to refresh the running work.
>
>
>But in the module case, isn't the srcu_sup->node also statically
>allocated via the "static struct srcu_usage" declaration?

static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags=
)
{
	sp->srcu_sup->node =3D kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->node)=
, gfp_flags);
	...
}

Regardless of whether the srcu object is declared in the module or not, sup=
->node is dynamically allocated.
right?

Thanks
Zqiang

>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>#ifdef MODULE
># define __DEFINE_SRCU(name, is_static)								\
>	static struct srcu_usage name##_srcu_usage =3D __SRCU_USAGE_INIT(name##_s=
rcu_usage);	\
>	is_static struct srcu_struct name =3D __SRCU_STRUCT_INIT_MODULE(name, nam=
e##_srcu_usage);	\
>	extern struct srcu_struct * const __srcu_struct_##name;					\
>	struct srcu_struct * const __srcu_struct_##name						\
>		__section("___srcu_struct_ptrs") =3D &name
>#else
># define __DEFINE_SRCU(name, is_static)								\
>	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
>	static struct srcu_usage name##_srcu_usage =3D __SRCU_USAGE_INIT(name##_s=
rcu_usage);	\
>	is_static struct srcu_struct name =3D							\
>		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
>#endif
>
> Thanks
> Zqiang
>=20
>=20
> >
> >							Thanx, Paul
> >
> > Thanks
> > Zqiang
> >=20
> > >
> > >It should also be possible to eliminate duplicate code between the=20
> > >in-module and non-module statically allocated initialization cases,=20
> > >come to think of it.
> > >
> > >  	}
> > >  	return 0;
> > >  }
> > > @@ -1931,9 +1932,13 @@ static void srcu_module_going(struct module=20
> > > *mod)  {
> > >  	int i;
> > >  	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> > > +	struct srcu_struct *ssp;
> > > =20
> > > -	for (i =3D 0; i < mod->num_srcu_structs; i++)
> > > -		cleanup_srcu_struct(*(sspp++));
> > > +	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> > > +		ssp =3D *(sspp++);
> > > +		cleanup_srcu_struct(ssp);
> > > +		free_percpu(ssp->sda);
> > > +	}
> > >
> > >And good catch on another memory leak with this one, looks proper to=20
> > >me.
> > >
> > >  }
> > > =20
> > >  /* Handle one module, either coming or going. */
> > > --
> > > 2.25.1
> > >=20
