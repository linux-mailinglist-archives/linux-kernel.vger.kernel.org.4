Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61836C5B74
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCWAlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCWAlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:41:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E401A656;
        Wed, 22 Mar 2023 17:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679532063; x=1711068063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OFXW6LMWC7MM8HmWSBZET0aFigbwosADho9WRawvINY=;
  b=SvYQHjpLzkkS1jN2F7yDGTvSgmjvANi8DkA+Dwp0lhvoO28QGpixPjnu
   1jAi0swMAgHFe5Huf8JrKTeAD3uOK/S3XX6w7evZ7v1vwuJU1NumlZ9rl
   0jAjLXFS8rvdsfmd9MhVad6IaoSgGtBs7R0YnpBKvrjvYFK7jHrUwcQNC
   pFVVFbhglVFtEImEkPAy93cs2v8sgh8bTu83umJRE5nDlvY2Gv11UBuYB
   cJMxNrQQz5b/l2whoLmn6JuGvtHN83IQE9uBzmUEPFGKW7uRcd03VWqfV
   8McW3D60eL02+0ZQ+iIwaCBMGqsc7anOSuMoD83Xbp27GVXlQRSsIep3P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="327743098"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="327743098"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 17:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="746520628"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="746520628"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 22 Mar 2023 17:41:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 17:41:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 17:41:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 17:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6hudfnZjF4sz5vSSzX+VI2UzY+YyFqPPUjDir+Nul1kptBEW3sTIaXn9OUxwLZ9tOK6xXUN0M36Ul8HcxyMCmoYRUbNSu7On2uZmJW9q7BxLtoQWku2LAfICXPdwp8WtYiXQefV9FiL/bDBjazz6tIihP35gHSy1MfelXGkFbCZMHeCrKc85iOF7TwSgAgtkJEs6ae3zjs3wMhmo/I0JlXQUcD9QVFr+g5aH6jynt7IILzMza1TqTbOa1/+DYumARlt9VuoR1+mvz4g7OIEl03TZ8Bf+1gSyZhHZ1OqW7Z0XuBjM1Y/ZD1Fwt1gWDCKnmz5tEG8/e4DmU+yP1clVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgYghcHB/6cIRRkvqrrI0bxgcW2IBWU95ClPgdmRk6o=;
 b=AVwz+AOYhd1/UbnsClKjKAikPdG1XynpS1JeYckb8eZTNGIdOK9LUaD/9sSGEkSXon9XwJf+yUrXiVrbrw+Kyv/fND4Ba/QAgmsDkFxttPBVacvC849YpmBuxzPHmiHK4USBY++f9Oev5pzAB3YYqbvKG1RHo/LNNdnzphckM69qKceEILmfy/FoyJzsr/tAsR/nhE2nX6fzCx67f1wOq0O2q0foAghGsW6P6VaEurHA8mcCNPv+/qg73IiKyDGJjSFZ5b9P+qF9FHPLJr/ezgyBKRpE6/7y+EAyJd8J9B67hDAI4RSQ0EwZkTt5SKPucdmbIpLu/IsohHtPdF+aNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM4PR11MB7759.namprd11.prod.outlook.com (2603:10b6:8:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 00:40:59 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 00:40:59 +0000
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
Thread-Index: AQHZW8x3wcHPlwuNM0Wizzk5AGbgwq8FVToAgAClkaCAADGigIAACIWAgACwsYCAAHV/oIAAFDsAgAAGXDCAAARcQIAABUEAgAAIZMA=
Date:   Thu, 23 Mar 2023 00:40:59 +0000
Message-ID: <PH0PR11MB58807E8A7FCF686F87079BAADA879@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230321081346.192000-1-qiang1.zhang@intel.com>
 <e7951c31-4a24-4493-be4b-603fec0730ff@paulmck-laptop>
 <PH0PR11MB588087645FE02C9F2C113CC8DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <f13e878f-65c3-40cb-aa3f-eb87ae6c9d6b@paulmck-laptop>
 <PH0PR11MB5880CAE4D4A58BD71AE984CFDA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <dc8b5a44-02ca-4e5a-bd4a-644af3e7c11e@paulmck-laptop>
 <PH0PR11MB58804435C08AEADF23B095D1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <4a9525f8-30a3-4ca9-87ec-355cde7f6ed6@paulmck-laptop>
 <PH0PR11MB588085478B4E13DD48C4B7C1DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807A0B060B84C4159A16C0DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <80edb753-c8d4-4279-853e-201076949bd7@paulmck-laptop>
In-Reply-To: <80edb753-c8d4-4279-853e-201076949bd7@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM4PR11MB7759:EE_
x-ms-office365-filtering-correlation-id: 5cc4e6b6-9cc5-40c3-3a49-08db2b3745c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: feLohXAAO18X/yW594h8lncLvbABdlpXuO9H8G63i4CHth0M214cW/M6g37+l/PWVj8jWZt9+Tzdx5Du/tL+DFvbpjS23/y9zheh1/B5GdU+2UIwhEOkvO5fRYEHGLxkZ6IEnKVQncH9ZtkznNjkCnpRCCf5Zi//YprqeXteu8r7vJPx1oSZgD1rQmCM5NgEDXjtgMrcxp8SFfq3wblP/JcTKD21PCufgxWe93GTlhlcaSNCF2lwfFdo1vVAGNkE+sVL3KNp4foin5flFpusSF1zAKlhq/CmKg2aMP4wGXciTLDsAKFebAp+qT75k3RNxHlgYjHDKIu44Z1KgYCgXJFtywMhN/L7HUTdJ+c69ipKG8meTY7IyUl9TBBNVc7DaggLAQ6Vwd1Y89ja1DuiKNJ/pxm04NVjs339M/2iD/YOTsQTOVqx+CYUljkBQVi2RiiGtDxT1o/M5cRCyCb3xRacQArzI+i+giiECyAEssqoYzfFVz7ch2QwSbcpE8oOILUWwg3NA1cSpMg3mh+lslY/q3AavD6XhTbrTc3wecB1DUUhtKJZbrKs1n06alvOLfFbS1jNWdpLInxIVXZTgn1L7EjWOA66p1eWuAjH3/a3sN1I6WuiCHXTX6qDHJ30fEuLst3u0qFb1rJCOW6vTk1wIipUp+jdW46hRBTVIeujT0JioW1jePVGhzTwb+kkKc7qiGyt49RHR0qkZaV3nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199018)(41300700001)(30864003)(66556008)(5660300002)(66476007)(66446008)(64756008)(8676002)(6916009)(4326008)(2906002)(52536014)(38070700005)(82960400001)(33656002)(86362001)(38100700002)(122000001)(71200400001)(7696005)(26005)(54906003)(45080400002)(478600001)(76116006)(6506007)(316002)(8936002)(55016003)(66946007)(83380400001)(186003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dr3PPnGB4z1GQpkf0Id9h/nO0ioDw8LKPlsfCBf0XtA67/2mboPFB7eYIRZE?=
 =?us-ascii?Q?YU2LXOsXcFwoHaiypzRMWRma9c8fV+oB6EjiiMSGssZxaZrdrsKwIg6Q8WB4?=
 =?us-ascii?Q?kW+0nReqUOWmbSV40R8c3FNthqlzx+kuJCMtz5SSDGT1OMyFk6HDiqFUXEaO?=
 =?us-ascii?Q?ES9PnUrM2YMHqgImMm+eUQQRr+gZ+8/LSwC7yE1zeZdYKSknWp+91ccT0/vR?=
 =?us-ascii?Q?F27bDHKdmYF3OsR31BDACX3dc6RG/4+BiM1IKCF6JivmkSroKK+VPm7M6hK5?=
 =?us-ascii?Q?OO44PMJimuBByLChXzWeIwcMp6dHNHlVQbsM/aVE6qHgFME+JRmzH1fc7M44?=
 =?us-ascii?Q?YsNAVxPoC6MhwN5ErVAqZSXZCYxXKuhd9XmeaWbWZFrEYhWl/9yVIzu1yGKJ?=
 =?us-ascii?Q?ncqFi3xbVRU2b06C6ma718wsveZDZUtFzVi2BsAhYdyRlBT3eb70jQlRn3Kn?=
 =?us-ascii?Q?t+iCMDJ1jopBvClARI+xof9yg8bEkhSUYdHifQA3og1KDpxrMrmL8D2UUFlh?=
 =?us-ascii?Q?giZUGoTdg399o8L4FH09dEVl4GxKrd1XrExF9lru5+b3sbmFF/bqGtInb5S7?=
 =?us-ascii?Q?cRu/tEQHvB5AvZT3qM3GUBVEqZMnFc6fe//yTc7SA+gsdRlBGhbOrTESzXUd?=
 =?us-ascii?Q?iCBZ9xKY3bWyh4UzS0cNRhzen7FcglZTjndP3Xj6pZjv1WDOlX2mxiaYn70E?=
 =?us-ascii?Q?dmfjD3kvmCsrKY1rmSREzuVAJDEj6qWDgzIThp5jStRJSOCIPzJ//w0m08A+?=
 =?us-ascii?Q?g6CEPmAnEvBHIYJHZtajqaKNAd3jEaa6jyDeZYP0JjBwBGOZebeEuQACKwnc?=
 =?us-ascii?Q?IYXoTMgEp+E+SOb1DEmbyDYmCKwQUQWs+b4r5K5DOXMxd0cjHX1vxRKm6aon?=
 =?us-ascii?Q?bMqB7Mmyp48ONhZrkWGVVsowABaSIA+Wg+4r6zLrquFVLYfMr+a1GnL5C4kr?=
 =?us-ascii?Q?G+0euf2CNkmU96iDQP5x/fOTvPeGPTFc169i5aErXDfqtjrRUi6xdGW/ljDE?=
 =?us-ascii?Q?7BLeMV5oQQi6lcvAAeyazidBiHGlqWqFvF6HE2GVjguA19ZQOiHdwjVKbZWE?=
 =?us-ascii?Q?NtAM5ORD+mxZdHCJkbPd9aUc11kyiXyydpRdaPRHkDHRQ6sqO4dMSMJ6u50k?=
 =?us-ascii?Q?sHhysPqcL+uRR0LV8EEl9e8YOMpOGZoT70Twwl3og9dLsCdA7D97eqFdqto2?=
 =?us-ascii?Q?zC0V7aHM2o6v4RmoRXxWeS4J8W3C+IqTUWWDNrNS5mjJcs/8mLHw3Hy0svuH?=
 =?us-ascii?Q?40icL0xG4Enc8fv4ALlq9uosDiTXFEmxLlFAssWscLreVRG/tJAcMiG2JIvx?=
 =?us-ascii?Q?eDBmOX0enq5Xy+czfKKQ058OpZVzcCitRd5gzKEb2aNEhVuOyy2PE4x0M0fy?=
 =?us-ascii?Q?M3Z42kvQ3E5MZ5zoNFGC3Hpr/2t3H+D4aDOeFpKczM0xk3OYy20+vriDnpfl?=
 =?us-ascii?Q?Qan4YZpjw2P5o7Y/6dDUUBjDj3cvCtxnQ2MzDy41t25bSghnFUqkd/Uwk4zv?=
 =?us-ascii?Q?H0abgoUYuNgIMoHzhGFgJ51xiparuQXw/20oS6jPh0RCKK1N//3nfZXir++y?=
 =?us-ascii?Q?s5CIO/89Z5H8fcyEzed8GnkzGd+AD1A7sdcK1t4O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc4e6b6-9cc5-40c3-3a49-08db2b3745c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 00:40:59.6674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPOk7Ev0L8eWmcNbVBXbFmyCx6VmHm1yWEjgne0bsq/lBg24/8FgJidnYL5oHB1FLPtBs5FkcI3pnOFFDrte+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7759
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Wed, Mar 22, 2023 at 10:08:54PM +0000, Zhang, Qiang1 wrote:
> > > > > insmod rcutorture.ko
> > > > > rmmod rcutorture.ko
> > > > >=20
> > > > > [  209.437327] WARNING: CPU: 0 PID: 508 at kernel/workqueue.c:316=
7=20
> > > > > __flush_work+0x50a/0x540 [  209.437346] Modules linked in:=20
> > > > > rcutorture(-) torture [last unloaded: rcutorture] [  209.437382]=
=20
> > > > > CPU: 0 PID: 508 Comm: rmmod Tainted: G  W  6.3.0-rc1-yocto-standa=
rd+=20
> > > > > [  209.437406] RIP: 0010:__flush_work+0x50a/0x540 .....
> > > > > [  209.437758]  flush_delayed_work+0x36/0x90 [  209.437776] =20
> > > > > cleanup_srcu_struct+0x68/0x2e0 [  209.437817] =20
> > > > > srcu_module_notify+0x71/0x140 [  209.437854] =20
> > > > > blocking_notifier_call_chain+0x9d/0xd0
> > > > > [  209.437880]  __x64_sys_delete_module+0x223/0x2e0
> > > > > [  209.438046]  do_syscall_64+0x43/0x90 [  209.438062] =20
> > > > > entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > > > >=20
> > > > > For srcu objects defined with DEFINE_SRCU() or DEFINE_STATIC_SRCU=
(),=20
> > > > > when compiling and loading as modules, the srcu_module_coming() i=
s=20
> > > > > invoked, allocate memory for srcu structure's->sda and initialize=
=20
> > > > > sda structure, due to not fully initialize srcu structure's->sup,=
 so=20
> > > > > at this time the sup structure's->delaywork.func is null, if not=
=20
> > > > > invoke init_srcu_struct_fields() before unloading modules, in=20
> > > > > srcu_module_going() the __flush_work() find
> > > > > work->func is empty, will raise the warning above.
> > > > >=20
> > > > > This commit add init_srcu_struct_fields() to initialize srcu=20
> > > > > structure's->sup, in srcu_module_coming().
> > > > >=20
> > > > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > > >
> > > > >Good catch, and thank you for testing the in-module case!
> > > > >
> > > > >One question below...
> > > > >
> > > > >							Thanx, Paul
> > > > >
> > > > > ---
> > > > >  kernel/rcu/srcutree.c | 11 ++++++++---
> > > > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c index=
=20
> > > > > 1fb078abbdc9..42d8720e016c 100644
> > > > > --- a/kernel/rcu/srcutree.c
> > > > > +++ b/kernel/rcu/srcutree.c
> > > > > @@ -1921,7 +1921,8 @@ static int srcu_module_coming(struct module=
 *mod)
> > > > >  		ssp->sda =3D alloc_percpu(struct srcu_data);
> > > > >  		if (WARN_ON_ONCE(!ssp->sda))
> > > > >  			return -ENOMEM;
> > > > > -		init_srcu_struct_data(ssp);
> > > > > +		if (WARN_ON_ONCE(init_srcu_struct_fields(ssp, true)))
> > > > > +			return -ENOMEM;
> > > > >
> > > > >Wouldn't it be better to simply delete the init_srcu_struct_data()=
?
> > > > >
> > > > >Then the first call to check_init_srcu_struct() would take care of=
=20
> > > > >the initialization, just as for the non-module case.  Or am I miss=
ing=20
> > > > >something subtle?
> > > >=20
> > > > Hi Paul
> > > >=20
> > > > Maybe the check_init_srcu_struct() is always not invoked, for examp=
le,
> > > > In rcutorture.c,   here is such a definition DEFINE_STATIC_SRCU(src=
u_ctl),
> > > > but we use torture_type=3Drcu to test,  there will not be any inter=
face=20
> > > > calling
> > > > check_init_srcu_struct() to initialize srcu_ctl and set =20
> > > > structure's->delaywork.func is process_srcu().
> > > > when we unload the rcutorture module, invoke cleanup_srcu_struct() =
to=20
> > > > flush sup structure's->delaywork.func, due to the func pointer is n=
ot=20
> > > > initialize, it's null, will trigger warning.
> > > >=20
> > > > About kernel/workqueue.c:3167
> > > >=20
> > > > __flush_work
> > > >      if (WARN_ON(!work->func))   <---------trigger waning
> > > > 	return false;
> > > >=20
> > > >=20
> > > > and  in  init_srcu_struct_fields(ssp, true), wil set=20
> > > > srcu_sup->sda_is_static is true and set srcu_sup-> srcu_gp_seq_need=
ed=20
> > > > is zero,  after that when we call
> > > >  check_init_srcu_struct() again, it not be initialized again.
> > > >
> > > >
> > > >Good point!  In the non-module statically allocated case there is ne=
ver a call to cleanup_srcu_struct().
> > > >
> > > >So suppose the code in srcu_module_coming() only did the alloc_percp=
u(), and then the
> > > >code in srcu_module_going() only did the the matching
> > > >free_percpu() instead of the current cleanup_srcu_struct()?
> > >=20
> > > But in modules, for srcu objects defined with DEFINE_SRCU() or DEFINE=
_STATIC_SRCU(),
> > > when a module is unloaded, we usually don't call cleanup_srcu_struct(=
) in the module
> > > unload function.
> > > If in srcu_module_going() only do free_percpu(), the srcu_sup->node m=
emory maybe
> > > can not free and also lost the opportunity to refresh the running wor=
k.
> > >
> > >
> > >But in the module case, isn't the srcu_sup->node also statically
> > >allocated via the "static struct srcu_usage" declaration?
> >=20
> > static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_f=
lags)
> > {
> > 	sp->srcu_sup->node =3D kcalloc(rcu_num_nodes, sizeof(*ssp->srcu_sup->n=
ode), gfp_flags);
> > 	...
> > }
> >=20
> > Regardless of whether the srcu object is declared in the module or not,=
 sup->node is dynamically allocated.
> > right?
> >
> >You are absolutely right, thank you!
> >
> >There are a couple of ways to resolve this.  One is to simply add
> >a check_init_srcu_struct() before the call to cleanup_srcu_struct()
> >from srcu_module_going(), as shown below.  This seems a bit silly,
> >potentially initializing fields for no good reason.
> >
> >Another way is to make cleanup_srcu_struct() do the same check
> >that check_init_srcu_struct() does:
> >
> >	rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))
> >
> >If the value is non-zero, then cleanup_srcu_struct() should skip
> >consistency checks that complain about things that cannot happen if
> >there never was an RCU grace period.  Maybe something as shown after
> >the second line of dashes.
> >
> >Thoughts?
> >
> >							Thanx, Paul
> >
> >------------------------------------------------------------------------
> >
> >
> >/* Initialize any global-scope srcu_struct structures used by this modul=
e. */
> >static int srcu_module_coming(struct module *mod)
> >{
> >	int i;
> >	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> >	struct srcu_struct *ssp;
> >
> >	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> >		ssp =3D *(sspp++);
> >		ssp->sda =3D alloc_percpu(struct srcu_data);
> >		if (WARN_ON_ONCE(!ssp->sda))
> >			return -ENOMEM;
> >		init_srcu_struct_data(ssp);
> >	}
> >	return 0;
> >}
> >
> >/* Clean up any global-scope srcu_struct structures used by this module.=
 */
> >static void srcu_module_going(struct module *mod)
> >{
> >	int i;
> >	struct srcu_struct *ssp;
> >	struct srcu_struct **sspp =3D mod->srcu_struct_ptrs;
> >
> >	for (i =3D 0; i < mod->num_srcu_structs; i++) {
> >		ssp =3D *(sspp++);
> >		check_init_srcu_struct(ssp);
> >		cleanup_srcu_struct(ssp);
> >	}
> >}
> >
> >------------------------------------------------------------------------
> >
> >void cleanup_srcu_struct(struct srcu_struct *ssp)
> >{
> >	int cpu;
> >	struct srcu_usage *sup =3D ssp->srcu_sup;
> >	bool wasused =3D !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_g=
p_seq_needed));
> >
> >	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
> >		return; /* Just leak it! */
> >	if (WARN_ON(srcu_readers_active(ssp)))
> >		return; /* Just leak it! */
> >	flush_delayed_work(&sup->work);
> >	if (wasused) {
>=20
>   If   wasused=3Dfalse  It not need to invoke   flush_delayed_work(&sup->=
work);
>   this trigger WARN_ON(!work->func)) .
>
>Again, good catch!  I will pull that flush_delayed_work() into this
>"if" statement.
>
> >		for_each_possible_cpu(cpu) {
> >			struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
> >
> >			del_timer_sync(&sdp->delay_work);
> >			flush_work(&sdp->work);
> >			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
> >				return; /* Forgot srcu_barrier(), so just leak it! */
> >		}
> >	}
> >	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D =
SRCU_STATE_IDLE) ||
> >	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->src=
u_gp_seq_needed) ||
> >	    WARN_ON(srcu_readers_active(ssp))) {
> >		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n"=
,
> >			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
> >			rcu_seq_current(&sup->srcu_gp_seq), sup->srcu_gp_seq_needed);
> >		return; /* Caller forgot to stop doing call_srcu()? */
> >	}
> >	kfree(sup->node);
> >	sup->node =3D NULL;
> >	sup->srcu_size_state =3D SRCU_SIZE_SMALL;
> >	if (!sup->sda_is_static) {
> >		free_percpu(ssp->sda);
> >		ssp->sda =3D NULL;
> >		kfree(sup);
> >		ssp->srcu_sup =3D NULL;
> >	}
> >}
>=20
>=20
> If we have not invoke check_init_srcu_struct() ,  that means call_srcu(),=
  synchronize_srcu(), srcu_barrier(), start_poll_synchronize_srcu() are als=
o not invoke, so Is there no need to check
> srcu_readers_active()?
>
>The module might have had lots of SRCU readers, but no updaters, and
>a bug in that module might mean that that readers are still active.
>For example, the module might have passed the srcu_struct structure
>to some function in the main kernel, and then forgotten to tell that
>function to stop doing srcu_read_lock() and srcu_read_unlock() on it.
>
>Or the module might have created a kthread that did SRCU readers, and
>then have forgotten to stop that kthread.
>

fully understand.

>
>Please see below for an untested patch.

I will test the following modification.

Thanks
Zqiang

>
>And yet again, thoughts?  ;-)
>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index 1fb078abbdc9..fe04214ce84c 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -645,22 +645,25 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
> {
> 	int cpu;
> 	struct srcu_usage *sup =3D ssp->srcu_sup;
>+	bool wasused =3D !rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp=
_seq_needed));
>=20
>-	if (WARN_ON(!srcu_get_delay(ssp)))
>+	if (WARN_ON(wasused && !srcu_get_delay(ssp)))
> 		return; /* Just leak it! */
> 	if (WARN_ON(srcu_readers_active(ssp)))
> 		return; /* Just leak it! */
>-	flush_delayed_work(&sup->work);
>-	for_each_possible_cpu(cpu) {
>-		struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
>+	if (wasused) {
>+		flush_delayed_work(&sup->work);
>+		for_each_possible_cpu(cpu) {
>+			struct srcu_data *sdp =3D per_cpu_ptr(ssp->sda, cpu);
>=20
>-		del_timer_sync(&sdp->delay_work);
>-		flush_work(&sdp->work);
>-		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>-			return; /* Forgot srcu_barrier(), so just leak it! */
>+			del_timer_sync(&sdp->delay_work);
>+			flush_work(&sdp->work);
>+			if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
>+				return; /* Forgot srcu_barrier(), so just leak it! */
>+		}
> 	}
>-	if (WARN_ON(rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D SRCU_STATE_I=
DLE) ||
>-	    WARN_ON(rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->srcu_gp_seq_nee=
ded) ||
>+	if (WARN_ON(wasused && rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)) !=3D S=
RCU_STATE_IDLE) ||
>+	    WARN_ON(wasused && rcu_seq_current(&sup->srcu_gp_seq) !=3D sup->srcu=
_gp_seq_needed) ||
> 	    WARN_ON(srcu_readers_active(ssp))) {
> 		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
> 			__func__, ssp, rcu_seq_state(READ_ONCE(sup->srcu_gp_seq)),
