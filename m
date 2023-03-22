Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97F66C5AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjCVXwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVXwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:52:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565A2886D;
        Wed, 22 Mar 2023 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679529138; x=1711065138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oLmiyGZ96tbpe3pnyU9UFYcXUH6HYZ9nr+plIHc3hNE=;
  b=O7l0x/4lZ4Fj78sHEnxfS+LWBnuN4+x6+AJAYaPDZyjsP4jJm3J916o0
   mGvrlf3dxC5VKD8Q0i13SbiYVzNoyeWYc6sUbhpRSUEXDlUGayigHmvaC
   Vd/kFI2qOQi096dR/G2XGZ2WtB5Hnn62/kZ8SpMDlLgExhMGFB8JB/hKL
   tgafKFAbEq9YQ8S5RXqgEvmAVVFYNzCqMc5RHsuhLAiUI5ZIh/k9xtJBp
   nIb5LxdAYGpOJzcak0irdiKpu5kQHlFFbJ/rJhc3gEwrssbYaMfn/0xQH
   Okm1J4rm9SiaCtOgjEQ204I2VC1yErKedRwGqjeEwlVc/zc8LjLIn3XTj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="425645611"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="425645611"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 16:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="659368498"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="659368498"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2023 16:52:18 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 16:52:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 16:52:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 16:52:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO0gPnBEtlNUa0XvdseQead9JJv9hmZ5YpeQe8YRHrlb01n+REPaapiVCzHww2yktk3fFFP4cg8yfIn3HeLRcNEorqRhQX/as1lO6h/fYbH/8Q15BvaOJtwUJiRBJfR6xO2bJxbn934oB3Qci+tE6FCt+uQgR6P+ZiaP+1/qbhnqx9wKBThaviYY4cT3yL+EJgKF/j8/SaWr/ivb1Yx96MAXd8UDy+jCR2nDP/By5M+Wd7X20QAg7s7pBq+SigYBgAhRgsR89FARTeLuqsWOmS0Yr1qEW38FryDH+ATBlFdoJSUp3RFBFZP3UKbqSpGKz2nDKfWyw3uXvxU/gV5D7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l8Pd/P2AMVgBwy/yHDhihGW4BXzHbE0sRi1iNOk558=;
 b=dYHcY3wbO8hqYJfA0AUlPjQPpIDKpvhzkzcsKJOD6Kf0X3zdvQZ/4h9FRAB0fIglMnNyMSc9fXU1icgnEPRb+1iYpiWb9pKAqoSflMnjt4kaMCVp/dXROiiBK2G3KZOHn3E+L4TvmyY58/DJZeJ0z88Q/8TdoY/2M+S84tnRW8V6ZQULRx+QMREthgG6VTLaoFSv+PdLRfE7QalQ4aMFQrX1NJiztmf3UV/nM0F6jZb8v0oZ58pcYm+CTxl6Mdw2qFLmYifVoEtv5fxWvyPM/mZ/AYgeX7UF3WoE1Gn622Uw+5uTxAQgNeZDmrzod4nfITK8ltvyOjZWzoeMpt2OmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS0PR11MB7558.namprd11.prod.outlook.com (2603:10b6:8:148::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 23:52:15 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 23:52:14 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH] srcu: Fix flush sup work warning in cleanup_srcu_struct()
Thread-Topic: [PATCH] srcu: Fix flush sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaCAADGigIAACIWAgACwsYCAAHV/oIAAFDsAgAAGXDCAAARcQA==
Date:   Wed, 22 Mar 2023 23:52:13 +0000
Message-ID: <PH0PR11MB58807A0B060B84C4159A16C0DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
 <PH0PR11MB58804435C08AEADF23B095D1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a9525f8-30a3-4ca9-87ec-355cde7f6ed6@paulmck-laptop>
 <PH0PR11MB588085478B4E13DD48C4B7C1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB588085478B4E13DD48C4B7C1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS0PR11MB7558:EE_
x-ms-office365-filtering-correlation-id: c48e077d-9525-4951-a330-08db2b3075e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zQyP8CvbY6A8YdJTO0ZBFAGgI9YezpH8U/bCSbSNaNC7JlmyGNIWB1vJUCTY637Iu64wDQam6e9umTeJC05b0byuw9Mt7O6FshKpVw0NZyrpeCENS1ibB7Eno83/KpOyVXeC/nVSb0gTdK3td6SN3dIaj3SGCU/OBNZxORoibjhj/tG7blQQSQWM3204AqrfF30aAFq31e/2br8NU8Q1b2j69NfqbbdirpJ1j0r2sIjcXq55DeiJVf+vKRpBj2MtVG0UnqsaSFssbncdVpKL5Jl1vUQuNXSk9Mz9uNZ78qVrw1Zgchf8cygijsA/wcB3OyEBb6GCZnhpEyhjW9ios2d7UEfhh9ingZ9JXOoV2v6VL2qAJkNSjdXwxr80XL3DkDbj6iSuiqkuI9jyPHtU0eZLUANXG064yk+EICkrVDNqsfvvnFfkEFkdd/MGBGZRXr3zT4UD/zR0gDuzkP/AVuYBf2GL/5JKK19TaNFmK5w/9LT5bh/W1qyCKSUFF6xAECPwZOy740Uw8bAjGgGG2Px43CILlFwZ9ANtWu0wPJw0z/y6wSFeArwSNtiMoUoNNAgjBUob33pH0K67Ag0iHTjeG0blDozMPP4ODsyqjrwZxdWtS+7W4JIacY0u5nIeZf1RR2Gby3rIqRCap18Rg04Jz9FFP6+fTg67ZKbn0dCsdRKI6CChtQ1WVDhoORFLF7VFAOoN3eGAUGXsggH/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199018)(38070700005)(41300700001)(66556008)(8676002)(66446008)(64756008)(66476007)(4326008)(38100700002)(82960400001)(52536014)(122000001)(55016003)(2906002)(76116006)(66946007)(8936002)(6506007)(86362001)(5660300002)(26005)(7696005)(71200400001)(2940100002)(33656002)(54906003)(9686003)(478600001)(110136005)(186003)(83380400001)(45080400002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?215jEFu5Fh+gno5p831vBWr/cK+18d9dnUvbOXxKGH6N5jjIvmMTh6SWHer6?=
 =?us-ascii?Q?vCdfjpYuWu2kNrsp7c/SIvzCd1IqvPm4uDVJKDhCiYAsSNvq3/RoxNTlJZMM?=
 =?us-ascii?Q?X5zPCbL3waE75zd3xY04RuyM18FbBZz4F7QFDi95HWYovkOltvo/GpjwfRHZ?=
 =?us-ascii?Q?IVIGxAM5DfNdNhj/mx9XEdKn29bRpocfhACNdvl5XDHA5EcQVAItaj+5mGU9?=
 =?us-ascii?Q?gdihzpqtGuCaKpoK404Om6dsYMPzQechGgKv4fBSe9h9Rbt+krSEK9zdmpVF?=
 =?us-ascii?Q?ZHjI5pRKegncZyAUfILVTN4lJlTHXrXTF4f4DHTc6fpMMPw/+hFPv1reCp9W?=
 =?us-ascii?Q?Lj7gzZQn4ARJLcGxX+te1nZZzA4iMPS8cgjfcVxsFj1YCGgZwxEHJMHC0mZO?=
 =?us-ascii?Q?bLY9vg0KimDvdLrcZFNr36DJB2ZoK7z02iLQvObARl+oB9vPh68o8q4QwVFh?=
 =?us-ascii?Q?ZZppDh8H7o7tR9wsnjI4B6EyLeCRRtelPiBYorNiErNLav2LUtNUCvGC6pxK?=
 =?us-ascii?Q?KiQLpSJVT9tP5ZBlcPgXzC/qmUpLe718SjDzG4fpgD/9oQl5ORWFLtC/aIcn?=
 =?us-ascii?Q?yiMxrcOzA0b32wGed145Q0rECVdN8OrHhUu5voycXfC2WICmfop7rWA68/uY?=
 =?us-ascii?Q?4ZVpMuW7T1qffKvBHXp8T13dBm446ye7+yvlchhRlAIIudnLrd2t4T0PqmGG?=
 =?us-ascii?Q?9MqnL+5uASiN8Hz7UVPFlYAmv55TTdrrx4mGsBWYr/A+bpTFdZ9PHULlC6Cm?=
 =?us-ascii?Q?4/iTQY4BCuj0HeNaGrs1ZA2LO4oBmhkO9V3aLkYJeC/t2Jho7zSiQVSI6DYc?=
 =?us-ascii?Q?6Lxpqxg4UXp/HPVbJAREf758UBPdUdarJ+hkTyt/Ko5gk9DV9x6vZrePsraG?=
 =?us-ascii?Q?uHO7gpt3LuHUY4i7yD9I4NEK0cjJEiBe5bNkMGjHsm8qUmnzZ/+PrfNII1WV?=
 =?us-ascii?Q?HDJ23rS9tx2Z2UmytRnqBiT2cSWgbS3JuSnSX7VjIqZ7fxlgHwY/Eeojqu+z?=
 =?us-ascii?Q?y1jRxgCBFQc9x3YYipwpHf+Z4F66qrG3b72A+i4a1TIPrZNSkl42zRfanI0e?=
 =?us-ascii?Q?xFb1SiXI8n9kUouqZh7kgNKI5sUzeGV7mBY0ETmyC2BCBnP89dtJaM6UBhAq?=
 =?us-ascii?Q?+TEOX4T9pBN30jnbY49KZ8ODC6ZIk9AxmM86w4TNX1Z/+UgeJ58jey9PZP9w?=
 =?us-ascii?Q?N9FZh++3LQfFIkU77sFfg7hl7a11sGqf4efOBQlGKb7xjLSLIVZDuuUNezOD?=
 =?us-ascii?Q?TqQeLf+gxL8A08mlb+InCD9QcmO7D2fGYMVkJ0oSs0di4Y24S+V0mMOzv+l9?=
 =?us-ascii?Q?8GU9CxVx3M9RmIJd/fGo1tPti3HjCJLGjsKLAJRjjWmuSqFo/6pUdgFds6EU?=
 =?us-ascii?Q?AAXw2HtljPUfW7O5NPPIIgmg79K0TiuvgKpRktqrmcf/HSciUgBRIzKe4ae2?=
 =?us-ascii?Q?kTgM3G7Y4hCJp3SUfC/AgJG1ytFV1H77NOPO5LqrUR+zKQwAB4pRf7/kZvV1?=
 =?us-ascii?Q?szDqLTQpADg2SjVvlvRpVhKlW4GoTo33IfQB4aj/zRbvyxTGqQEmBILd2f8z?=
 =?us-ascii?Q?2gdM6loh8vEsmolM++U6Nu/82/qXNpkaRkC8fRXw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48e077d-9525-4951-a330-08db2b3075e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 23:52:13.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoDZ163Oqi/44zbI+KMBraqYVY0rOA//vhl3nbCVy0rRG5XwtFVEOM1yP5mOBh1j3G/HBuSUpjeqrsjbr7V3Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7558
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

>On Wed, Mar 22, 2023 at 10:08:54PM +0000, Zhang, Qiang1 wrote:
> > > > insmod rcutorture.ko
> > > > rmmod rcutorture.ko
> > > >=20
> > > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3167=
=20
> > > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in:=20
> > > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382]=20
> > > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standard=
+=20
> > > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776] =20
> > > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817] =20
> > > > srcu_module_notify+0x71/0x140 [  209.437854] =20
> > > > blocking_notifier_call_chain+0x9d/0xd0
> > > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062] =20
> > > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > >=20
> > > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU()=
,=20
> > > > when compiling and loading as modules, the srcu_module_coming() is=
=20
> > > > invoked, allocate memory for srcu structure's->sda and initialize=20
> > > > sda structure, due to not fully initialize srcu structure's->sup, s=
o=20
> > > > at this time the sup structure's->delaywork.func is null, if not=20
> > > > invoke init_srcu_struct_fields() before unloading modules, in=20
> > > > srcu_module_going() the __flush_work() find
> > > > work->func is empty, will raise the warning above.
> > > >=20
> > > > This commit add init_srcu_struct_fields() to initialize srcu=20
> > > > structure's->sup, in srcu_module_coming().
> > > >=20
> > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > >
> > > >Good catch, and thank you for testing the in-module case!
> > > >
> > > >One question below...
> > > >
> > > >							Thanx, Paul
> > > >
> > > > ---
> > > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=20
> > > > 1fb078abbdc9..42d8720e016c 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module *=
mod)
> > > >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> > > >  		if (WARN_ON_ONCE(!ssp->sda))
> > > >  			return -ENOMEM;
> > > > -		init_srcu_struct_data(ssp);
> > > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > > +			return -ENOMEM;
> > > >
> > > >Wouldn't it be better to simply delete the init_srcu_struct_data()?
> > > >
> > > >Then the first call to check_init_srcu_struct() would take care of=20
> > > >the initialization, just as for the non-module case.  Or am I missin=
g=20
> > > >something subtle?
> > >=20
> > > Hi Paul
> > >=20
> > > Maybe the check_init_srcu_struct() is always not invoked, for example=
,
> > > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(srcu_=
ctl),
> > > but we use torture_type=3Drcu to test,  there will not be any interfa=
ce=20
> > > calling
> > > check_init_srcu_struct() to initialize srcu_ctl and set =20
> > > structure's->delaywork.func is process_srcu().
> > > when we unload the rcutorture module, invoke cleanup_srcu_struct() to=
=20
> > > flush sup structure's->delaywork.func, due to the func pointer is not=
=20
> > > initialize, it's null, will trigger warning.
> > >=20
> > > About kernel/workqueue.c:3167
> > >=20
> > > __flush_work
> > >      if (WARN_ON(!work->func))   <---------trigger waning
> > > 	return false;
> > >=20
> > >=20
> > > and  in  init_srcu_struct_fields(ssp, true), wil set=20
> > > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_needed=
=20
> > > is zero,  after that when we call
> > >  check_init_srcu_struct() again, it not be initialized again.
> > >
> > >
> > >Good point!  In the non-module statically allocated case there is neve=
r a call to cleanup_srcu_struct().
> > >
> > >So suppose the code in srcu_module_coming() only did the alloc_percpu(=
), and then the
> > >code in srcu_module_going() only did the the matching
> > >free_percpu() instead of the current cleanup_srcu_struct()?
> >=20
> > But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE_S=
TATIC_SRCU(),
> > when a module is unloaded, we usually don't call cleanup_srcu_struct() =
in the module
> > unload function.
> > If in srcu_module_going() only do free_percpu(), the srcu_sup->node mem=
ory maybe
> > can not free and also lost the opportunity to refresh the running work.
> >
> >
> >But in the module case, isn't the srcu_sup->node also statically
> >allocated via the "static struct srcu_usage" declaration?
>=20
> static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_fla=
gs)
> {
> 	sp->srcu_sup->node =3D kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->nod=
e), gfp_flags);
> 	...
> }
>=20
> Regardless of whether the srcu object is declared in the module or not, s=
up->node is dynamically allocated.
> right?
>
>You are absolutely right, thank you!
>
>There are a couple of ways to resolve this.  One is to simply add
>a check_init_srcu_struct() before the call to cleanup_srcu_struct()
>from srcu_module_going(), as shown below.  This seems a bit silly,
>potentially initializing fields for no good reason.
>
>Another way is to make cleanup_srcu_struct() do the same check
>that check_init_srcu_struct() does:
>
>	rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))
>
>If the value is non-zero, then cleanup_srcu_struct() should skip
>consistency checks that complain about things that cannot happen if
>there never was an RCU grace period.  Maybe something as shown after
>the second line of dashes.
>
>Thoughts?
>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>
>/* Initialize any global-scope srcu_struct structures used by this module.=
 */
>static int srcu_module_coming(struct module *mod)
>{
>	int i;
>	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
>	struct srcu_struct *ssp;
>
>	for (i =3D 0; i < mod->num_srcu_structs; i++) {
>		ssp =3D *(sspp++);
>		ssp->sda =3D alloc_percpu(struct srcu_data);
>		if (WARN_ON_ONCE(!ssp->sda))
>			return -ENOMEM;
>		init_srcu_struct_data(ssp);
>	}
>	return 0;
>}
>
>/* Clean up any global-scope srcu_struct structures used by this module. *=
/
>static void srcu_module_going(struct module *mod)
>{
>	int i;
>	struct srcu_struct *ssp;
>	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
>
>	for (i =3D 0; i < mod->num_srcu_structs; i++) {
>		ssp =3D *(sspp++);
>		check_init_srcu_struct(ssp);
>		cleanup_srcu_struct(ssp);
>	}
>}
>
>------------------------------------------------------------------------
>
>void cleanup_srcu_struct(struct srcu_struct *ssp)
>{
>	int cpu;
>	struct srcu_usage *sup =3D ssp->srcu_sup;
>	bool wasused =3D !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_=
seq_needed));
>
>	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
>		return; /* Just leak it! */
>	if (WARN_ON(srcu_readers_active(ssp)))
>		return; /* Just leak it! */
>	flush_delayed_work(&sup->work);
>	if (wasused) {


  If   wasused=3Dfalse  It not need to invoke   flush_delayed_work(&sup->wo=
rk);
  this trigger WARN_ON(!work->func)) .
 =20

>		for_each_possible_cpu(cpu) {
>			struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
>
>			del_timer_sync(&sdp->delay_work);
>			flush_work(&sdp->work);
>			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>				return; /* Forgot srcu_barrier(), so just leak it! */
>		}
>	}
>	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D SR=
CU_STATE_IDLE) ||
>	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->srcu_=
gp_seq_needed) ||
>	    WARN_ON(srcu_readers_active(ssp))) {
>		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
>			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
>			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
>		return; /* Caller forgot to stop doing call_srcu()? */
>	}
>	kfree(sup->node);
>	sup->node =3D NULL;
>	sup->srcu_size_state =3D SRCU_SIZE_SMALL;
>	if (!sup->sda_is_static) {
>		free_percpu(ssp->sda);
>		ssp->sda =3D NULL;
>		kfree(sup);
>		ssp->srcu_sup =3D NULL;
>	}
>}


If we have not invoke check_init_srcu_struct() ,  that means call_srcu(),  =
synchronize_srcu(), srcu_barrier(), start_poll_synchronize_srcu() are also =
not invoke, so Is there no need to check
srcu_readers_active()?

Thanks
Zqiang

