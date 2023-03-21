Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD646C31B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCUM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjCUM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:27:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2501EFD0;
        Tue, 21 Mar 2023 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679401653; x=1710937653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CQcHoxU8Z8mD5cwCSc91CXHlli0NJBjztTc+peaseGU=;
  b=R/QxZ6P/3LCf1FfjvFYKLBFq2IlbZGbcy+NlDDGPV6rn24W+CQ3CxlQg
   1hQ9zxbTaqDLcEN9FeZGybWL1H2IZDJtChqGGlE3AMIw8wxS3YGlx76eu
   vCdMJDK1y+3wG/hIdW5N2tQtKtkFmtxo6f4ZniPoH01S8NYdq/TCnZsJp
   O1qaywAqEj7ZOcrGVnEWOFkK6ZGkdWPwKmJzQIQJx1iJMr8AodNnFYqfj
   x2C2sWFbx+Bna8y8i8jbVxpipXqCMoVLXxVnebbt7vn3HEigXYegM7JQ3
   Ew18wtdKRWCU66SoLR9tIHyZsE92vhVghseVi/0fIDlsEILTD+B3QeQu9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="366654347"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="366654347"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 05:27:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770611863"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="770611863"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Mar 2023 05:27:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 05:27:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 05:27:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 05:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJSTIqdObdHnsDNexF37xmQ8JRVfGcSbof1M57l1+SWyu9jOg3FuxBtvneSCIXX472sTDOyENxsjmMtxUonLLYvN+9e25NHbfKmTJ2iDF9F0LMidjXWTEb8fIilLv+iOefSrM5sH7iMVF6TrBk6SXISmt1rmyuH+ZSIFl5lCXbDjmHxBFYWUiFVMHHHu/ieZDCgkwmCbdHinryBsGQJMwT7mKHh2hUnM++PB9KJqKN4wL3kOeKphiUMzZUrYV/u15nPBP6XLciKjoYcMoWZ92D0bS9VfauUsXaUFl6SBrxQWy84HthgEUB6UukRIgR/9cVg9qL+caynrWql3TNYnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTwx5DHxo9KJ4041rgvrzjMH8q643zGUEMhcrpXQR2k=;
 b=AdVquqc8EwOS2fcdr6ayYaY5GC8Qi52MgT4dKS7LYO2UGhNzHmcfp+OvmuggMjNwREMzitX0OHy36VWwZf42GmMu68nAmWUsS2ftyUb8K8WinzNt0wVTJyKZtxK0wnVpPyCVurfNoFGQXTIL35yZBTZnZvbt1j2G5L84agYJQKvme9ONbetb/xV+XooeX40oDCm/ePOs997BqdmZSDcxrmz5uIgj6YgR9HYIB4LCw+29//BIinHQluda1zaTRKy1Gyd+isupro4JTBweSReH9jqQANoJ8Y2tAw5HSBYlJhbQLPjLKk30W2dnOcGF0oDx7nM76RoMgfpxIPUdKgSnyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH0PR11MB7657.namprd11.prod.outlook.com (2603:10b6:510:26c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 12:27:15 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 12:27:14 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcutorture: Convert schedule_timeout_uninterruptible()
 to mdelay() in rcu_torture_stall()
Thread-Topic: [PATCH v2] rcutorture: Convert
 schedule_timeout_uninterruptible() to mdelay() in rcu_torture_stall()
Thread-Index: AQHZWtsElwxz/KN2NEOd8ANQA4i0X68EHJQAgAAulYCAAAh2AIAAmvHQ
Date:   Tue, 21 Mar 2023 12:27:14 +0000
Message-ID: <IA1PR11MB617139069496A8E9FD84BF1689819@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230320032422.4010801-1-qiang1.zhang@intel.com>
 <7a414721-25fa-485c-91a5-13d3149073fe@paulmck-laptop>
 <PH0PR11MB58806032CE88C9E6BE61059CDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
 <5a887ca6-10e9-4026-b792-164deb80d0a8@paulmck-laptop>
In-Reply-To: <5a887ca6-10e9-4026-b792-164deb80d0a8@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH0PR11MB7657:EE_
x-ms-office365-filtering-correlation-id: 5aee2714-15ca-42d9-d09a-08db2a079a59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0SVa8KkPXaiCnEG8DLZ7jRn3mGnyPiEfDVPKIcOojch40x52VtrBFiZONsppmXykiU5Ir/Lp8XUIyJlODEcDNivoTMEBQUzPlGd7E8N09qOoBuvYKR97U74cEQlFy4dKUlfB0YoNmC6TKNbFJ5KyahuFI3bzYnegeyrhqNpVX39dcLdmmmopECKSXfG6JoVom5GU5jhc+yUCRXGANzvlEtGYp5y4TIM9//6x9gjnMwAjxGEeBVeW0NIQM87pg08cQTAB+FYYNfbcwK1+WiPizEkroUgEIAuj90plKOw50jAL0XwsVxRVnjH4sbkPoBmc2FUM+mcIe67oap3WkyDBxunx1D47DAr48d0kJRxAZFd15mVn8HMV1Qp+O0babkb1EJtg7gpyMUsYG/wXzBUXk9ljVJAWLbPmddb2JTB7qjZFsyGeU+r2FxgXSwfJLj1xwr49xu9fPq+x83I6M+lGCZVXdD11m7Cw1E3EyiApfjpS9lYsUB84fbmKpIrxaojGkwi8Ld5t77Rl3x9h0y20RlMnwFiUZMemZwW6BqTNPqPgRrppJ9PcVUG620Hit0HbYqR90WSmr6slIkGCVht/P3QoLfYCs42xX3UiPnChGf5yM7rKlmLXt6nPPC0ptk+pimzA+Dt2ipem+F3G8M++7zK2/PbhXLDvt2yPV2bqTbE/tYI5T5hidqBn+2BYTeLYOarfqSrUxzavVyyxQh3qsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(376002)(39860400002)(451199018)(26005)(6506007)(9686003)(83380400001)(54906003)(64756008)(4326008)(66946007)(66476007)(66446008)(316002)(186003)(478600001)(76116006)(110136005)(8676002)(6636002)(66556008)(5660300002)(41300700001)(122000001)(2906002)(8936002)(82960400001)(52536014)(38070700005)(71200400001)(7696005)(38100700002)(86362001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aV/eJ2wKMYIbAcE/X9dY3Z8fPTtf8G/h5mT3rY987AXaBOnp6ethiN4gFv0A?=
 =?us-ascii?Q?bsbAnMMcpqoK7gomns/XoZO1fMYR17sYeyaT4lIf3mQHx50YvUMxqab9sHVQ?=
 =?us-ascii?Q?xo3ff0VAp72VQTcMrp/ON/LwyC2fDEFQdTjlLDvBbeicVVwIUx3WR4Q/6d3l?=
 =?us-ascii?Q?9ntIb+/Y4qm5XeGQ2tLj02zWwY9k/v8S4S0+Be0cryf26DnHPXZEcFJIAz9I?=
 =?us-ascii?Q?X3didzECklN+THc9IymlTGVIADZ0xvRENol/ap2vvKHBXOOqbhvFkuLuex6I?=
 =?us-ascii?Q?HJBmYwp4glp+vf7xVZ0shDB3sa9Q7GlALzr2FRSkekohSuQJB1mDV6Crzacq?=
 =?us-ascii?Q?fFjZ0/TCawF2KdH9pP6ELiaMf74bCgiWCg4TeF/MUNG/iDMb7yZIK+lBYjkN?=
 =?us-ascii?Q?RwJEmgtckdSZnVSW5aT40kUZVVEBj2x6+xcdfk7E/gCXYgBUH04M/Z+0bm21?=
 =?us-ascii?Q?6Je7Ceyn4CR5eUOxS2wos2Re/xbu/KuhXlVaaICI6NOrcZg7RXRTSgKPbhG2?=
 =?us-ascii?Q?ve1nlY07F5qsepCwxT4fwPw7W4zkz0YWFfF/8IMw7iCkNPYwZxfDPj0F/kSq?=
 =?us-ascii?Q?Pe3q7vUtobZJtig6SepRxiNthI88EN89RZ04OYqW9Uj3fpCReScqfEbeCULI?=
 =?us-ascii?Q?OpbcRWVAYbJUHbwlfX+90he36ekME7nRR4ywU5Thj5CphCBJYxqirk6Oor/L?=
 =?us-ascii?Q?7IY1q8qpv8xs3tB1ApSTfQGTiio5jt1b5upxGtaQ7T9I6JNqA5d0P0Ql7Ua8?=
 =?us-ascii?Q?c6OXFHI0OPitT5qKWGLkEAK5JAsQLLW1Rm+JnvL88JzXlK+Cy3If29s2TuHM?=
 =?us-ascii?Q?6AFM9iGk6L5/H6sMoONnywBAuJfykhORNzdz7nju3eC8lbDQu70iFAvgCC3h?=
 =?us-ascii?Q?nbTM4UXdmYl7HpZbkJUzvZtCiQFErUOxJF3T0EcHheZZkbFKHMitgPgYsURN?=
 =?us-ascii?Q?Q0ywMtReBOq7ygyAofpJIp5bpqz5H/Lm+2vTxmn6rElCCNR2gCTxBPmJBgSN?=
 =?us-ascii?Q?afNfv+ROVeoFmy7T76TvSpZjYTEuctkss3z/whFl4DmYxMfh91z+Se/9WWuG?=
 =?us-ascii?Q?uii99DuFeu1fZKG0cwQSVYRlB/GvUrwyQ63wTIdsU05EJlliMYqqM2R+G4hO?=
 =?us-ascii?Q?jbH6rmFoOZkeVE4Ps6VIwzdw2xbMskq7eEu/4idwq3l3/Wn+8SGcTSse4gMB?=
 =?us-ascii?Q?ecieMH1RlCn8db13hdQPZEivzGAloArrBduLVsjIHR5oD9Zz2f8NTu+ftsot?=
 =?us-ascii?Q?ozlKE4jfpUE3BWcYPiwmp/0AZ3+1inYByhNKjxw1SjwuwMRWRDoSj8MD4kyD?=
 =?us-ascii?Q?ORFE/fg6BkQD4/W+QHoHKIjwNxno36nrrXhqdvw3hS2CGln3mxZZNd2Shs7b?=
 =?us-ascii?Q?556LzHNCYXBmdNwXatnOGoHZV94majJ1bAkKU+59Pvdw5TduyIwm9GhxN5jH?=
 =?us-ascii?Q?Qj1ADatDRUcULsQrewyeutvAsSF/4Jeu1UocgRYJTN2mv5pHZL/7M2Ra1fiG?=
 =?us-ascii?Q?dITaqt0V7Efagq3UMzYss3UgV0cboSMm6mVoqCXvyeyuEXu2y+fQ6kzp9I14?=
 =?us-ascii?Q?b5GPjzGry5xk7QODIKDeWO3cM2W2DdaAr3EqBe35?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aee2714-15ca-42d9-d09a-08db2a079a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 12:27:14.5615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4NgJF3bCouDRs+JzcMDF/mlqcoRVAqRmFF8HM35Y4QAfAkpJqYtblsK5+rFmZhURPUf1uOX7fVycOVHhyH7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7657
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> [...]
> > But invoke schedule_timeout_uninterruptible(HZ) implies a quiescent
> > state, this will not cause an RCU stall to occur, and still in the RCU =
read
> critical section(PREEMPT_COUNT=3Dy).
> >
> > It didn't happen RCU stall when I tested with the following parameters
> > for
> > rcutorture.stall_cpu=3D30
> > rcutorture.stall_no_softlockup=3D1
> > rcutorture.stall_cpu_irqsoff=3D1
> > rcutorture.stall_cpu_block=3D1
>=20
> Understood.  If you want that RCU CPU stall in a CONFIG_PREEMPTION=3Dn
> kernel, you should not use rcutorture.stall_cpu_block=3D1.
>

Verified.

if rcutorture.stall_cpu_block=3D0, it can trigger the expected RCU CPU stal=
l for either=20
torture_type=3Dsrcu or torture_type=3Drcu.=20
=20
> In a CONFIG_PREEMPTION=3Dy kernel, rcutorture.stall_cpu_block=3D1 forces =
the
> grace period to be stalled on a task rather than a CPU, exercising a diff=
erent
> part of the RCU CPU stall warning code.
>=20
> In a CONFIG_PREEMPTION=3Dn kernel, using rcutorture.stall_cpu_block=3D1
> forces the CPU to go through a quiescent state, as you say.  It can also =
cause
> lockdep and scheduling-while-atomic complaints, depending on exactly what
> type of RCU reader is in effect.
>=20

Verified.

If rcutorture.stall_cpu_block=3D1:
    There were lockdep and scheduling-while-atomic complaints for torture_t=
ype=3Drcu.
    No lockdep and scheduling-while-atomic complaints for torture_type=3Dsr=
cu.

> So these are test-the-diagnostics parameters.  The mdelay() instead makes
> rcutorture.stall_cpu_block=3D1 do the same thing as does
> rcutorture.stall_cpu_block=3D0 for CONFIG_PREEMPTION=3Dn kernels, right?

Good to know that these are test-the-diagnostics parameters and their expec=
ted behaviors.  ;-)
Thanks!

-Qiuxu

> 							Thanx, Paul
