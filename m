Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5579653DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiLVJsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiLVJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:48:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63EAA;
        Thu, 22 Dec 2022 01:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671702497; x=1703238497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C3QT4IaDm70kIzscU6EcieKxBdhYK/pYk4iMvzEVM4I=;
  b=Xokb/jhyDe1qlicIaxgEOM5YtpnvLc+pYOziC+mg5uwP0Hat/G332djT
   hoIjVFI8k+eAiVHyuQolbIWLw0WRKIkJK9kBvynOeM5ShRK1qafBMZQBD
   alfulKlXSz1VsZEJALERj5P9dzS8v+iOKHMTao3OhxlLaJNRH3rJ5eRaB
   ++xOOBy+3zAd4DsAIVDDjts7ACDGTzKN69Blhlg98iz5lvrEs6h7IhI6s
   691Lu/kpPmvLHVStFuUY+4XGsQ8vyKluzAzz5s8B9hBC+ACB5Hua/pw9c
   zoxAbXo+eXLawDflq4KB0CRJXAYdXyUxPePb9zg2sv+4MTGLsZ0SxRDz7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321272312"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="321272312"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 01:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="601833384"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="601833384"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2022 01:48:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 01:48:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 01:48:16 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 01:48:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V25fDI0M6GsB8fvSh/t4jpXUJiJou1Cf5b+8BjMlRcEXFfbpQkWS2aM5oRLrTpjZqNaQloe/L14yGiNYVC2SfwAe/PPIKJDDwnSV6hrF70Lhq/ydHLBae1dmCJfJfJIpwoUGCJ3HV+t1WXjmUvo1g8ccV80RyvFN97eCotbQtMJpTyiRp9zXA26Y09wEsRUiKfTMrzlBpZ2AoaJWdotQNZk9PU64sP0VtnTw1tFfzC6cjxGss9gtEt2qfCsmL56MkeWLGEdaIXDjal6u6HBASk9mhJa+ZX4IbVAEI3wiKk2wTJcXVPVNKAcebJoaLdQ5CFr0BFhxh0uW1D9tEySxLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMwSNrGm8voxGMHI/S9LpTc6cIdeF0AsOFSa2uxvyHE=;
 b=MkBPkjsy8/HpMURLIHC8eriDQFSs+KBV/yVTbZ0IyLS6uhxuogm+tvMbkimcZmSoQXxxkaIJ8MbjPz2035xQZzpSNmv+YtuJ9pwf2TqBE+h5X5OtD1rLd1zI0Az1LNzE3P+ebEocOfgNijKM0BqsFHxoCa2wlu6VsXms5CywAIglxUxKsYaKpNyu4LRk32Ysc99gJfU01UHDtHmB3kfnaZxXUnztBSWFtXv5SjxDsAgjQlRtvz+bogxsqmfykxGhWO64rHwuDA1HEuHj6VCOUXRgXpEWzlX/MOe+C/pwbk6JcLI1n6a02B/hPvnNZf6YkD077XGxR92xYElmvbBuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5662.namprd11.prod.outlook.com (2603:10b6:a03:3af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 09:48:14 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 09:48:14 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Thread-Topic: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP
 bitmask
Thread-Index: AQHZFGUUOrkEkQdHgkyyhC/0ix1REa54x0mAgADkn5A=
Date:   Thu, 22 Dec 2022 09:48:14 +0000
Message-ID: <PH0PR11MB58806135271427BC1A13AF34DAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221220112520.3596920-1-qiang1.zhang@intel.com>
 <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221221200849.GG4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB5662:EE_
x-ms-office365-filtering-correlation-id: deda7f00-9738-4d9a-661d-08dae401a548
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMdyVNWt4W0xhL7IODh7sLlctIfA2NUs+o+6WQ5U8eElNVyJCc2aP79ts3DLlNcgpgx162nBnBelTTP+QR6ZJxug0sUnX7yNn8FW000L9LHBZxno2A43oj79VrUPoCwNfZ81CazzQsXSbMqrM5GmljpsbvfERpUYw6B2MSskM654VgLHtlu8BybtWDWAKQH6MN6jKMv/bGqyRDPBmVNsSR45gJsMacZTdSpviAQxal0fnal4u0zhx3esSNRYzFzQf8/zYctIlt0GyoafD3oTfvWxkRixLK+JhSR0OoPQ8MfL574bTT0SALpRUy51fHVJM9VRIgGW091DqzY87uaRM/m7JvSxGyDyxIy0XIsLJiTrGwN1TMxWRWb/ZnPr7mdBbT3z0bC8FNQH5QwEMEyXMw5fA6sBrGnkt4nK/zOjUaIUhQP98HRBjJXNFTeO9wIfHFl6pL5GcXmoctN8Z9/eNg/wJoAtBctiKn5PoiIOH7diTXv+wa508g4K60dDrN+IYJNzxGagMReaFcfkh/zO6sWgy1l/vW11tlAUVENlkBDy1hk6G2c0jdV+JYY7htvJ/dTFjPmVXYnRtEHofLte7u8X1RPpVRwJCJPXvrjmiecPED55+NwRYSuR0Cl9emM88KRV1QWAyrTPOYs3juLHcmK5nZpSW1OYNhQ3wkDZ8OzzruraQVNxvsLJq3A5YUcVWanL3Ks1BxIWI9DMKVCwxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199015)(478600001)(6506007)(7696005)(71200400001)(55016003)(186003)(2906002)(86362001)(38070700005)(26005)(9686003)(76116006)(54906003)(66476007)(8676002)(66446008)(4326008)(66946007)(66556008)(64756008)(8936002)(6916009)(122000001)(66574015)(41300700001)(83380400001)(33656002)(38100700002)(82960400001)(316002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5pzgTeXrQDWEghve0TGUe3CwQ5NZWbxz0bx3mSITXIQKHS9NCwgn8PxZNG/7?=
 =?us-ascii?Q?MIE2dtQP2asplZpM+7kADlP7I+INJfFcXoa8JDTKdvoq4dgdy7zTD2HKXSvg?=
 =?us-ascii?Q?aFVW4md68ZW/vEXqjtF4dVydmaem70idoI6sq08zDzrVYU2GHTEWerwEN76A?=
 =?us-ascii?Q?76WCDIp6PNIidzlxtgGVPcRDl3KyNQVC4YGFmWkZ9CGthS2AvLXNUSp6V2ng?=
 =?us-ascii?Q?mQdmNQ/yJwRVwLrfUinxz7KP/mBySOnM2VhitCkXPIA5dpGWHf/h+8Ctjzrk?=
 =?us-ascii?Q?D/fewXmlzBzcKpbPXU3mmwQhGV4jhlY/KT9tZpiXTS/i6cCVi7xP6fFR8ld9?=
 =?us-ascii?Q?RwJOPgVr5jFk+vFkkyGAa/6BwHfCqc3U3ojc8mkUX6cGpyGcLWsCuEshmceq?=
 =?us-ascii?Q?gfG4uI0Rgms7xgCnHNs7M7S2iJt1VIIrYZ+6z0ACn9OQ4FrwLh0bOp77gC/D?=
 =?us-ascii?Q?4qMgJS2mR5/xSUlAvidKK/GAToBnKDng+s6COiJZZRjzkQRUAz9jh7vtdOOC?=
 =?us-ascii?Q?NPJbaVvJ9kiMUsI8A2VLx7rfdGxlakjNi/xTwlMgCx30gAXSrgb7ta7OdBiR?=
 =?us-ascii?Q?ljYF6Ym732LywBuAyXgWPPHyOnYeeYL/Z7KyIwxam6beHOpHSJs3bfTtO/2C?=
 =?us-ascii?Q?U/nfX7ky0XVP9+sLW1iysJfVaRoY1G7KLGsEr0KQcy+/7ju3g2AE6Yqs4V/b?=
 =?us-ascii?Q?5g880IpAjkmOIC6ZxKlf26WzXOvF6nl6qJYgqPEQM1y79HIQXu4XPqaKCnW5?=
 =?us-ascii?Q?xux+Xeqja6dBFrU7ZcYsKwPDnjc1CaTlj5cOoPBtrNerG1S+XowDYGojHr7G?=
 =?us-ascii?Q?C8C5Nx2tUNWyHEAD2T+g2Ye5J2QQQqYau3SF+3fRJa6xPVU0ZTXGUwZBv4N8?=
 =?us-ascii?Q?ymrKOQWC+P6Aa+3dNhtLpRAxFSP7I54ICEDz16P04Ui2zGwUk6FR+ZGIz0uv?=
 =?us-ascii?Q?UWW4WN11usb1B4GLHRn7PfYOkEVAsp/SsdS1cYfL8Ya4yPYu1zgosSOreX4Q?=
 =?us-ascii?Q?umV7yJTzkOS0y6YLBX4E2a3Jw1lFv+4jAS3k4ukVhuMF6z44k3OT21DVahYS?=
 =?us-ascii?Q?LsfhTILBJufC9MWs10sbCcsH3moNEV/ZhPo8xRauDpfjeRMpUYXylCiwxlcM?=
 =?us-ascii?Q?REfSLG5Q4I7WBURIDSI2dzDCqR5/tEuHSM1Pu3BJ+6vzLkvFqWpedTcbLa7F?=
 =?us-ascii?Q?UXXJWTGJGvKiCpyU1o/XsjlK2/vVEe1Y9+UgHcJSjw2h7ZUjsaz6oR3rtBzB?=
 =?us-ascii?Q?tXy0yg++yHk8V5i1YkuKWjP88O7ZPYIbDb14UdKNEgIIJnVWIXY6mt15seK0?=
 =?us-ascii?Q?ZMAbxSUfny6KmIPROGIDkEFkk9duzfiaW4Ifhyklg2Wt0cpBE+mU9mc9+BNI?=
 =?us-ascii?Q?W9m07mS1VeZeiMOhYviQGppbHBe/c6FEYO3OyhJZIjR7wJ01BfDF+Hro6xNP?=
 =?us-ascii?Q?Y2v+AH6EvYfjSa+Iv1W4/qhYi8iE601NgYLBxnyJfbFCc+ZfjdOvrZ05IMqx?=
 =?us-ascii?Q?REnAC2P96V+zAH7mp0dG6FpdT8VsKYXOM/peASZZyxLm20tm2W7DThDLVCos?=
 =?us-ascii?Q?UB5BQKy1rOX4YOfCFoMHI6jGz3Xhb1TIPL8qRqJg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deda7f00-9738-4d9a-661d-08dae401a548
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 09:48:14.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYn229u0OUxQWZT+cHZkepKlsnBwCJRFDJ4Yv4LGrVahI86AmMshDHtFcHvpoJoWOUcB3D7yaenKrXCNbCyaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5662
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For the kernel bulit with CONFIG_NO_HZ_FULL enabled and the following=20
> cpus is nohz_full cpus:
>=20
> 	CPU1                                                 CPU2
> rcu_report_exp_cpu_mult                          synchronize_rcu_expedite=
d_wait
>    acquires rnp->lock                               mask =3D rnp->expmask=
;
>                                                     for_each_leaf_node_cp=
u_mask(rnp, cpu, mask)
>    rnp->expmask =3D rnp->expmask & ~mask;                rdp =3D per_cpu_=
ptr(&rcu_data, cpu1);
>    for_each_leaf_node_cpu_mask(rnp, cpu, mask)
>       rdp =3D per_cpu_ptr(&rcu_data, cpu1);
>       if (!rdp->rcu_forced_tick_exp)
>              continue;                                 rdp->rcu_forced_ti=
ck_exp =3D true;
>                                                       =20
> tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);
>=20
> In the above scenario, after CPU1 reported the quiescent state, CPU1=20
> misses the opportunity to clear the TICK_DEP_BIT_RCU_EXP bitmask, it=20
> will not be cleared until the next expedited grace period starts and=20
> the CPU1 quiescent state is reported again. during this window period,=20
> the CPU1 whose tick can not be stopped, if CPU1 has only one runnable=20
> task and this task has aggressive real-time response constraints, this=20
> task may have one of the worst response times.
>=20
> Therefore, this commit add rnp->lock when set TICK_DEP_BIT_RCU_EXP=20
> bitmask to fix this race.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Good eyes, thank you!!!
>
>Queued for testing and further review as follows, as always, please check =
for errors.
>

It looks more clear now, thank you!

Thanks
Zqiang

>							Thanx, Paul
>
>------------------------------------------------------------------------

commit acfe689f2e473fb59b6d2c95af5fe36198bb9a84
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Tue Dec 20 19:25:20 2022 +0800

    rcu: Fix set/clear TICK_DEP_BIT_RCU_EXP bitmask race
   =20
    For kernels built with CONFIG_NO_HZ_FULL=3Dy, the following scenario ca=
n result
    in the scheduling-clock interrupt remaining enabled on a holdout CPU af=
ter
    its quiescent state has been reported:
   =20
            CPU1                                                 CPU2
    rcu_report_exp_cpu_mult                          synchronize_rcu_expedi=
ted_wait
       acquires rnp->lock                               mask =3D rnp->expma=
sk;
                                                        for_each_leaf_node_=
cpu_mask(rnp, cpu, mask)
       rnp->expmask =3D rnp->expmask & ~mask;                rdp =3D per_cp=
u_ptr(&rcu_data, cpu1);
       for_each_leaf_node_cpu_mask(rnp, cpu, mask)
          rdp =3D per_cpu_ptr(&rcu_data, cpu1);
          if (!rdp->rcu_forced_tick_exp)
                 continue;                                 rdp->rcu_forced_=
tick_exp =3D true;
                                                           tick_dep_set_cpu=
(cpu1, TICK_DEP_BIT_RCU_EXP);
   =20
    The problem is that CPU2's sampling of rnp->expmask is obsolete by the
    time it invokes tick_dep_set_cpu(), and CPU1 is not guaranteed to see
    CPU2's store to ->rcu_forced_tick_exp in time to clear it.  And even if
    CPU1 does see that store, it might invoke tick_dep_clear_cpu() before
    CPU2 got around to executing its tick_dep_set_cpu(), which would still
    leave the victim CPU with its scheduler-clock tick running.
   =20
    Either way, an nohz_full real-time application running on the victim
    CPU would have its latency needlessly degraded.
   =20
    Note that expedited RCU grace periods look at context-tracking
    information, and so if the CPU is executing in nohz_full usermode
    throughout, that CPU cannot be victimized in this manner.
   =20
    This commit therefore causes synchronize_rcu_expedited_wait to hold
    the rcu_node structure's ->lock when checking for holdout CPUs, setting
    TICK_DEP_BIT_RCU_EXP, and invoking tick_dep_set_cpu(), thus preventing
    this race.
   =20
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h index 249c2967d9=
e6c..7cc4856da0817 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -594,6 +594,7 @@ static void synchronize_rcu_expedited_wait(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root =3D rcu_get_root();
+	unsigned long flags;
=20
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("=
startwait"));
 	jiffies_stall =3D rcu_exp_jiffies_till_stall_check();
@@ -602,17 +603,17 @@ static void synchronize_rcu_expedited_wait(void)
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
+			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			mask =3D READ_ONCE(rnp->expmask);
 			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 				rdp =3D per_cpu_ptr(&rcu_data, cpu);
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp =3D true;
-				preempt_disable();
 				if (cpu_online(cpu))
 					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
-				preempt_enable();
 			}
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 		j =3D READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
