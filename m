Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792EB6C5F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 07:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCWGVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 02:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWGVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 02:21:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801031ADDE;
        Wed, 22 Mar 2023 23:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679552477; x=1711088477;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1zvUWpkad6EJMsMZK8rltRSnn/Rwh536pezvxvDDnfk=;
  b=M18WIs0K3MBzs0jF43u8N9NniHLOnv/7iQXp4gaPHY29D8GpJ4saCisT
   fH2yepnRROFRC1dF7e44T4awuWr2YieBaoZbD8CS1KFaZ904xmhAJ50Dy
   PERfFkfJHa/tH0Cp6aYtZg1DgIyjPMzpIr5e04YphNU8wPFRIPQFJNkdk
   r6Lgy8Bc00ZQDzBlZ06cf/GNGS4Ps0XDMJ91DoqfPBYCRdHMFq1mMVUWd
   vN3zBahfhJvlkz8zLmdMtQ3IEAy5fwf8g0YukIqzvMI6TOSSKuy88nkYO
   mkcCyEWl+tyIIngBEZNSCew9w+jDD+Q6UA5OxxARLv6W5cNBQaEC+3Kxo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341769860"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341769860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 23:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="825698706"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="825698706"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2023 23:21:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 23:21:15 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 23:21:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 23:21:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ai6VtzC4Xao5eBx0c8GrfhHBaEZw28qz5TtjG/p6QKpQn+ftje3sUJLDO57tFejlQfV70Bsvk0pDSI6tuzmW1DhfdAobOqPfxTgMsS5JsDtfQe1z2d8Upj4DBr8fyNgXOrZbZxDnq3OA3tnV710GyU9Ga415XtlniHDXzehR9mC6IKGlS7SwIv7RLcCZMqnGUIKV9xnJ3e3JavzwGlwerDn0dUfoj0X4509muj9M5npuAXesVP7qtPa9RtfyKAEHlAkfCheNPhSOQs0iASwbnk9YVTOVrycnwgf+JnSenGPgZ2y/OTDxSfaTFLbSaop2px5WXuN25ybzvLt2ErD/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwcLLO+nEGtD6GXNDFkyETw7rmuCoXISGOge9Sr7fr0=;
 b=Z1ukg5Bj6hBb6Br12XXt4lX9uDCswY0aofqD/jEdsbZx0CHJ1nmV00lSveBr17csBzcQl7gxdXWxtjfCIJ/634RcWkVw0UVkYgjPImKYJE1ija3VYNZXVqdpMnp9QFqhbVP/ATyyM+KnrTwGiejMqVOyI3DlQmFdo+GdHs3ksSdRZKi6lgej/cJRl/BRfuS5H1CzBEFMqrfJi1xADNq1auq+0ByG5w+ksXNqGdmj6NjVCrlxTzeBF2xEQvasTyezzXOXU8fCBYtx0nl1a6P7IecP6bJDx2uYSsN3xbfG5+2njq/WH3IrFGFGdbF7/R+8kXxwGLkei1h+Fh7Q9dhJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 06:21:04 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 06:21:04 +0000
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
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaCAADGigIAACIWAgACwsYCAAHV/oIAAFDsAgAAGXDCAAARcQIAABUEAgAAIZMCAADGRAIAAGeCAgAATtOA=
Date:   Thu, 23 Mar 2023 06:21:04 +0000
Message-ID: <PH0PR11MB588029BB8B0C06FBD0E7FE25DA879@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
 <PH0PR11MB58804435C08AEADF23B095D1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a9525f8-30a3-4ca9-87ec-355cde7f6ed6@paulmck-laptop>
 <PH0PR11MB588085478B4E13DD48C4B7C1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807A0B060B84C4159A16C0DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <80edb753-c8d4-4279-853e-201076949bd7@paulmck-laptop>
 <PH0PR11MB58807E8A7FCF686F87079BAADA879@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58805E8C66D55E7CC0239E0FDA879@PH0PR11MB5880.namprd11.prod.outlook.com>
 <6824439a-20c3-4635-a34a-44ef57769cce@paulmck-laptop>
In-Reply-To: <6824439a-20c3-4635-a34a-44ef57769cce@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: a0fda87a-f0e5-4da3-60ea-08db2b66c7e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqqG6yjA2vGgLwMQSAVSkdxb7XL0eUUHjd+JEzMLyzfSC97Y0Czgs08/F3EvmWp1jRfLnTVSABxuzCEIAxpYiSCHoKlfkFdskfbBq56SZvNlVO8I+NzCVXJtSPcear+n0xYs5sfo0zjCB5728f68Fwv1ia8olDgmu0fZfiJrlSB1EkzWt6Og2+KX1GR5kRnQGpUNU7CGoab69WABkzCccG7wwl7Mf5iQ90GTSnn5Dg7feFDqw1nN40d4eoayh+Yoe2yuU9NDJiQu8IL6bxSR9nLCpgKY55M59Pa0BjZvvb5D2yDruihUHtJy7Hmn7SVAQ26YFkdUJVr7jk6Onoh4BFBQxDzIoqXMqboHyPupy6ECP44uAyaKfGbObzjEZsdsMVX+hxte6+Arwv7Zt6wD7+Y9fNyYkzPUkWlzNILoN9yb4SUb/3QyToghJvT0rVITYnkfdwrDxpBRxL35efVgk+KA4CNmBWDiR4f9/OMsoIhihhHVvPAsqmL6ulOn9cPmA9BPwpTUm0U2XBr7o9NKubIJ1x+kSELa2PoUDNdYHgbi0LaNqtetbT9mnai0tHNNVhOuraBz2g2MU+BW8mEiebndzfofVvt/h0w+gMu5aWnQ1glzbL+NH8sLG/FY6kB8hAL35Ayc5CO8talGoE0i2j384SSmE1NGmXU485jmgtBagGhrnoYrt4/SAFWUcJf8hh1l3dpNfiFNCcU/uE425Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199018)(54906003)(316002)(45080400002)(7696005)(478600001)(82960400001)(5660300002)(83380400001)(8936002)(33656002)(52536014)(26005)(71200400001)(41300700001)(38070700005)(30864003)(86362001)(38100700002)(2906002)(122000001)(6916009)(4326008)(66476007)(186003)(66446008)(64756008)(8676002)(66556008)(9686003)(76116006)(66946007)(6506007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B1S/5VV1qDSH0sbZab6cH8ZIECjlNLDZi6/OLy4nOzbNfyq+RP6Q25aJIthO?=
 =?us-ascii?Q?6qn9WxCf2kIWRNsKvQF1B0Yb0qdegW98OHN9DeX+e+bOomlkJ/SYXCetKRVp?=
 =?us-ascii?Q?rjZ87iUl4uMJCOViSaxFzvbLyiyCXwu3cPFn5Mzu7I01Hk3R179VvSV+G+fL?=
 =?us-ascii?Q?aLULYWu1qhTEjrIkkn2Z+QAw5U7wdEiGVGcG8QKge8L4FQ1LZuGkOrBTWiHI?=
 =?us-ascii?Q?4azyuor1hT3BIZeIiWpUS0/8CxBQkIKtQS7jah5lQgG30BXojK8594DhRhl0?=
 =?us-ascii?Q?T5l3a3Ws1nLRDxaIbbDhk+hMnJwo/bBHTSpZzt7HIEcdGNLB0zxegOUPEIh7?=
 =?us-ascii?Q?ZF1Su3Ee6CfQocFizBC8K8qH0FbNcZWviEkyJWDHX/8s2S84+USaiHGzwNUc?=
 =?us-ascii?Q?2v929XZTJDE9Iws+0ANV8zWxaLWHWGq32vvqeDjslaSLGLfEwHXAN0bxRMxf?=
 =?us-ascii?Q?clLfXCtJDOmzNhbx62W5Dm8OZfxh7FPJn5ORgCfXMqdAnMbIJTcv7xfBM9qm?=
 =?us-ascii?Q?DHNetWP546jQo9n9qC9HvI3l9yCQvaHsC9+bZ2C1zxCqnyx0Hlh7wqIqplT8?=
 =?us-ascii?Q?ZuasUfHI3Mg7FKHUeAC9MBAr8bw0y/KaeVappAYRV+//vBPs5cZgW5JFn1Hf?=
 =?us-ascii?Q?Ys4w+lu7l/ZjAgKsukU7TtUkFZI1DRBGEtcAR5fIyclI4Ju/MYoxDvvB9TxU?=
 =?us-ascii?Q?XkDL6qMVS8IstDR5t/qHrMqabduj/zc+LylzE0X7uj4Cn/gETA1ikMIc2Mcj?=
 =?us-ascii?Q?X1cw8cCUd3c3I9ZWUZc0cFM1fVcdiUgYMnX3pZ1l+sidgzaaBTNiA+qT/75H?=
 =?us-ascii?Q?3eykMiUDU2/g03Ot1QUtlPN/934qgm60dMHbSQsAIYuFJz/cj1msO/8eB0lF?=
 =?us-ascii?Q?vM88XWzvnRW1uXvR4COXuJUVCrLYy5vm/LjYqCnCucL4vn1lPt3lEo5DC+BF?=
 =?us-ascii?Q?aPpcm83prusodmqwHnq1KnvfHrwdJIAByc34F0QLTycC3g2pVLhWBJD7HBiH?=
 =?us-ascii?Q?uGYGuCfsRDnpYCMamLrvkT4wsp0P5/kjSqvHqO1reXnHwU/eVYSaWvOK1z3p?=
 =?us-ascii?Q?UBNnWqwUKWRb3CSROQ8AbSKBQn8HjLTPTvnWjaXs06qPt9Vfa1VQO777HQNx?=
 =?us-ascii?Q?MwL1QY2MfimbI7IZ1nBPwpAfJma0CfqKsvK7J8SJf8ilo+dATJ/HCv07j3El?=
 =?us-ascii?Q?B4RHaswCRAWTFAy+3kqMnOuosk8xZmc8U+oLpGk4o3i0iauovKRhtCA1u8LG?=
 =?us-ascii?Q?PpUcAyHER8KDiwg3hbX9SvK+mBSDkvYUkz1dsnx12qLjA9HO3ngcvGRer1vj?=
 =?us-ascii?Q?qWJBV/zDy7BGvth3uHjAQ+5SdeWgwVir68/LPnaTUPXvyhFLBrPnvOmwyBlf?=
 =?us-ascii?Q?xUg3CKWSOX2dATo/Y3S4W+D8RUKif0ak8LQBJBHdvMtqiTwZBJEZVFWIEX21?=
 =?us-ascii?Q?4f2j0p86WPs80/fPdsdCETdhNqjp98/Rr2pdqULKYL7wkg7SOzLXvGTMrGhT?=
 =?us-ascii?Q?Pq0Uqz9zXwrZPQ9z+SpdTZDDwwBqjjZukHiCgzIPIRLcFaSnySHYbbs8LRI8?=
 =?us-ascii?Q?4VTQj0YGLtFOPQGAoKSqjGR3xL5GcKsTlufIuZqC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0fda87a-f0e5-4da3-60ea-08db2b66c7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 06:21:04.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSI3uJTmh4oW1OmfGcmWG5+KTKAY9MDo49pYymSoLC1MaMg7KC/oDZDIBo07nb5fptqCWJmiz26DzsAST5ff5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >On Wed, Mar 22, 2023 at 10:08:54PM +0000, Zhang, Qiang1 wrote:
> > > > > > insmod rcutorture.ko
> > > > > > rmmod rcutorture.ko
> > > > > >=20
> > > > > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:3=
167=20
> > > > > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in:=20
> > > > > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382=
]=20
> > > > > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-stan=
dard+=20
> > > > > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > > > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776] =20
> > > > > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817] =20
> > > > > > srcu_module_notify+0x71/0x140 [  209.437854] =20
> > > > > > blocking_notifier_call_chain+0x9d/0xd0
> > > > > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > > > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062] =20
> > > > > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > > > >=20
> > > > > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SR=
CU(),=20
> > > > > > when compiling and loading as modules, the srcu_module_coming()=
 is=20
> > > > > > invoked, allocate memory for srcu structure's->sda and initiali=
ze=20
> > > > > > sda structure, due to not fully initialize srcu structure's->su=
p, so=20
> > > > > > at this time the sup structure's->delaywork.func is null, if no=
t=20
> > > > > > invoke init_srcu_struct_fields() before unloading modules, in=20
> > > > > > srcu_module_going() the __flush_work() find
> > > > > > work->func is empty, will raise the warning above.
> > > > > >=20
> > > > > > This commit add init_srcu_struct_fields() to initialize srcu=20
> > > > > > structure's->sup, in srcu_module_coming().
> > > > > >=20
> > > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > > >
> > > > > >Good catch, and thank you for testing the in-module case!
> > > > > >
> > > > > >One question below...
> > > > > >
> > > > > >							Thanx, Paul
> > > > > >
> > > > > > ---
> > > > > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c inde=
x=20
> > > > > > 1fb078abbdc9..42d8720e016c 100644
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct modu=
le *mod)
> > > > > >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> > > > > >  		if (WARN_ON_ONCE(!ssp->sda))
> > > > > >  			return -ENOMEM;
> > > > > > -		init_srcu_struct_data(ssp);
> > > > > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > > > > +			return -ENOMEM;
> > > > > >
> > > > > >Wouldn't it be better to simply delete the init_srcu_struct_data=
()?
> > > > > >
> > > > > >Then the first call to check_init_srcu_struct() would take care =
of=20
> > > > > >the initialization, just as for the non-module case.  Or am I mi=
ssing=20
> > > > > >something subtle?
> > > > >=20
> > > > > Hi Paul
> > > > >=20
> > > > > Maybe the check_init_srcu_struct() is always not invoked, for exa=
mple,
> > > > > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(s=
rcu_ctl),
> > > > > but we use torture_type=3Drcu to test,  there will not be any int=
erface=20
> > > > > calling
> > > > > check_init_srcu_struct() to initialize srcu_ctl and set =20
> > > > > structure's->delaywork.func is process_srcu().
> > > > > when we unload the rcutorture module, invoke cleanup_srcu_struct(=
) to=20
> > > > > flush sup structure's->delaywork.func, due to the func pointer is=
 not=20
> > > > > initialize, it's null, will trigger warning.
> > > > >=20
> > > > > About kernel/workqueue.c:3167
> > > > >=20
> > > > > __flush_work
> > > > >      if (WARN_ON(!work->func))   <---------trigger waning
> > > > > 	return false;
> > > > >=20
> > > > >=20
> > > > > and  in  init_srcu_struct_fields(ssp, true), wil set=20
> > > > > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_ne=
eded=20
> > > > > is zero,  after that when we call
> > > > >  check_init_srcu_struct() again, it not be initialized again.
> > > > >
> > > > >
> > > > >Good point!  In the non-module statically allocated case there is =
never a call to cleanup_srcu_struct().
> > > > >
> > > > >So suppose the code in srcu_module_coming() only did the alloc_per=
cpu(), and then the
> > > > >code in srcu_module_going() only did the the matching
> > > > >free_percpu() instead of the current cleanup_srcu_struct()?
> > > >=20
> > > > But in modules, for srcu objects defined with DEFINE_SRCU() or DEFI=
NE_STATIC_SRCU(),
> > > > when a module is unloaded, we usually don't call cleanup_srcu_struc=
t() in the module
> > > > unload function.
> > > > If in srcu_module_going() only do free_percpu(), the srcu_sup->node=
 memory maybe
> > > > can not free and also lost the opportunity to refresh the running w=
ork.
> > > >
> > > >
> > > >But in the module case, isn't the srcu_sup->node also statically
> > > >allocated via the "static struct srcu_usage" declaration?
> > >=20
> > > static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp=
_flags)
> > > {
> > > 	sp->srcu_sup->node =3D kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup-=
>node), gfp_flags);
> > > 	...
> > > }
> > >=20
> > > Regardless of whether the srcu object is declared in the module or no=
t, sup->node is dynamically allocated.
> > > right?
> > >
> > >You are absolutely right, thank you!
> > >
> > >There are a couple of ways to resolve this.  One is to simply add
> > >a check_init_srcu_struct() before the call to cleanup_srcu_struct()
> > >from srcu_module_going(), as shown below.  This seems a bit silly,
> > >potentially initializing fields for no good reason.
> > >
> > >Another way is to make cleanup_srcu_struct() do the same check
> > >that check_init_srcu_struct() does:
> > >
> > >	rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))
> > >
> > >If the value is non-zero, then cleanup_srcu_struct() should skip
> > >consistency checks that complain about things that cannot happen if
> > >there never was an RCU grace period.  Maybe something as shown after
> > >the second line of dashes.
> > >
> > >Thoughts?
> > >
> > >							Thanx, Paul
> > >
> > >----------------------------------------------------------------------=
--
> > >
> > >
> > >/* Initialize any global-scope srcu_struct structures used by this mod=
ule. */
> > >static int srcu_module_coming(struct module *mod)
> > >{
> > >	int i;
> > >	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> > >	struct srcu_struct *ssp;
> > >
> > >	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> > >		ssp =3D *(sspp++);
> > >		ssp->sda =3D alloc_percpu(struct srcu_data);
> > >		if (WARN_ON_ONCE(!ssp->sda))
> > >			return -ENOMEM;
> > >		init_srcu_struct_data(ssp);
> > >	}
> > >	return 0;
> > >}
> > >
> > >/* Clean up any global-scope srcu_struct structures used by this modul=
e. */
> > >static void srcu_module_going(struct module *mod)
> > >{
> > >	int i;
> > >	struct srcu_struct *ssp;
> > >	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> > >
> > >	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> > >		ssp =3D *(sspp++);
> > >		check_init_srcu_struct(ssp);
> > >		cleanup_srcu_struct(ssp);
> > >	}
> > >}
> > >
> > >----------------------------------------------------------------------=
--
> > >
> > >void cleanup_srcu_struct(struct srcu_struct *ssp)
> > >{
> > >	int cpu;
> > >	struct srcu_usage *sup =3D ssp->srcu_sup;
> > >	bool wasused =3D !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu=
_gp_seq_needed));
> > >
> > >	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
> > >		return; /* Just leak it! */
> > >	if (WARN_ON(srcu_readers_active(ssp)))
> > >		return; /* Just leak it! */
> > >	flush_delayed_work(&sup->work);
> > >	if (wasused) {
> >=20
> >   If   wasused=3Dfalse  It not need to invoke   flush_delayed_work(&sup=
->work);
> >   this trigger WARN_ON(!work->func)) .
> >
> >Again, good catch!  I will pull that flush_delayed_work() into this
> >"if" statement.
> >
> > >		for_each_possible_cpu(cpu) {
> > >			struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> > >
> > >			del_timer_sync(&sdp->delay_work);
> > >			flush_work(&sdp->work);
> > >			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> > >				return; /* Forgot srcu_barrier(), so just leak it! */
> > >		}
> > >	}
> > >	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=
=3D SRCU_STATE_IDLE) ||
> > >	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->s=
rcu_gp_seq_needed) ||
> > >	    WARN_ON(srcu_readers_active(ssp))) {
> > >		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\=
n",
> > >			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
> > >			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
> > >		return; /* Caller forgot to stop doing call_srcu()? */
> > >	}
> > >	kfree(sup->node);
> > >	sup->node =3D NULL;
> > >	sup->srcu_size_state =3D SRCU_SIZE_SMALL;
> > >	if (!sup->sda_is_static) {
> > >		free_percpu(ssp->sda);
> > >		ssp->sda =3D NULL;
> > >		kfree(sup);
> > >		ssp->srcu_sup =3D NULL;
> > >	}
> > >}
> >=20
> >=20
> > If we have not invoke check_init_srcu_struct() ,  that means call_srcu(=
),  synchronize_srcu(), srcu_barrier(), start_poll_synchronize_srcu() are a=
lso not invoke, so Is there no need to check
> > srcu_readers_active()?
> >
> >The module might have had lots of SRCU readers, but no updaters, and
> >a bug in that module might mean that that readers are still active.
> >For example, the module might have passed the srcu_struct structure
> >to some function in the main kernel, and then forgotten to tell that
> >function to stop doing srcu_read_lock() and srcu_read_unlock() on it.
> >
> >Or the module might have created a kthread that did SRCU readers, and
> >then have forgotten to stop that kthread.
> >
> >
> >fully understand.
> >
> >
> >Please see below for an untested patch.
> >
> >I will test the following modification.
> >
> >Thanks
> >Zqiang
> >
> >
> >And yet again, thoughts?  ;-)
>=20
> Maybe add the following modification,  otherwise, in cleanup_srcu_struct(=
)
> Kfree(sup) will release ssp->srcu_sup which is statically allocated.
>=20
> @@ -1926,6 +1926,7 @@ static int srcu_module_coming(struct module *mod)
>                 if (WARN_ON_ONCE(!ssp->sda))
>                         return -ENOMEM;
>                 init_srcu_struct_data(ssp);
> +               ssp->srcu_sup->sda_is_static =3D true;
>         }
>
>Good catch and good point!
>
>But the underlying problem is that I am still making things too complex.
>
>How about the following?  The idea is to skip the cleanup_srcu_struct()
>unless there was a call to check_init_srcu_struct(), and to free the
>per-CPU data either way.

I prefer this modification, it looks simpler and clearer, I will test and r=
esend.

Thanks
Zqiang


>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index 1fb078abbdc9..06f8ed1ce272 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -1921,7 +1921,6 @@ static int srcu_module_coming(struct module *mod)
> 		ssp->sda =3D alloc_percpu(struct srcu_data);
> 		if (WARN_ON_ONCE(!ssp->sda))
> 			return -ENOMEM;
>-		init_srcu_struct_data(ssp);
> 	}
> 	return 0;
> }
>@@ -1930,10 +1929,17 @@ static int srcu_module_coming(struct module *mod)
> static void srcu_module_going(struct module *mod)
> {
> 	int i;
>+	struct srcu_data __percpu *sda;
>+	struct srcu_struct *ssp;
> 	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
>=20
>-	for (i =3D 0; i < mod->num_srcu_structs; i++)
>-		cleanup_srcu_struct(*(sspp++));
>+	for (i =3D 0; i < mod->num_srcu_structs; i++) {
>+		ssp =3D *(sspp++);
>+		sda =3D ssp->sda;
>+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)=
))
>+			cleanup_srcu_struct(ssp);
>+		free_percpu(sda);
>+	}
> }
>=20
> /* Handle one module, either coming or going. */
