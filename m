Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6568B459
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBFDJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFDJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:09:39 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9C81A4AB;
        Sun,  5 Feb 2023 19:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675652979; x=1707188979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZmA5U6x2m+mxfNhJoPKcPDoZhqdM43pTij130FVR+WA=;
  b=USvM/e2LFQq6HAubO1K3ZL2lxbG8aZ5G5ZHjeBgSxfR1HN9vCAywNzm3
   rjiArcMN28POitaY230Ph5tJPN3I5w3GkNYuja9ahFb6G7uouF7JmqXWE
   gUG3/pNOzNLKJhO2oUKFZD+z/xauDSmiAce4+XppZ3FZ4BnGudDQMJQdZ
   5G3Tfz+66ucF3eZl36+QpUpCtTNI8IDceVxEct3cFCHfTmqt6cRNy94d3
   paIpp3KFCmQZuHSwicIRZ34EFI8PgvZp/gthl1WHOPNaAwOkumIaVLtIu
   pNE/U8FY0TY76CavbEAutccCkhIU3InK/dUAPP2V43UKA/pknlxnuGMNr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="391518200"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="391518200"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 19:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="659711397"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="659711397"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 05 Feb 2023 19:09:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Feb 2023 19:09:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 5 Feb 2023 19:09:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 5 Feb 2023 19:09:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCayWwKYE9J8A+YOZwI7p8tCN/ShEzkpHKpzb/R5w524p40crjgIrXhWSEhtXCaQBSlqmFNWdPqyOOqeUX6r6f3AYshfmhiz5mw7FmhQ5WCqpUM3yva3r/WZ0ru25oawTBz91JRrnAjq4WZHS6G2iibKRAf1p+aroacL4sj2IdPoBivDfNsXxt++PERLNczUU2Hcw1py2z9qQn98Dk2QVInfSAaR1r53opI1aBNF0UVHk+XygkQM9kl3L6iYbU5lgoPct0jFOEgLn+Eb19f1VGKlU98MhQwc2EfZmWfbKgjDz9izcVmUIndbpTLpJjpd/L2mpnNIYtVO12Ow6qQtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzo+RHAbTda48av4PxWRN3VSMz6O67HrsFPrm4XwlIg=;
 b=CDXLVgTcxCIb6dlAOK7oIddzql0/2V0n0Pun1bLNzsYi1iX55rT2hL757If4HR1BXkkrS0iXTKckeGaMSjI/ljdr8YXTf9ocw/TuU649BloqLVBk/AwdvkS2JJGfFqCByu7/3zt43qI4lVQWUOTufX/bQMBPy/cERKaXh3tT8egjZZgxmeBQ2I7YQwC6cmzFHjZqZIYh77p49Ul05hekie3PAc1v4uKwfQbzeEXfpox+F2+RUW0u7IjSqRyawT161UYfJAkTbhzrVT3qZEAyeXFfDDC6rNFC+bNUANnmjZsqYzg8N8ZvU9V0nPpQv52jFYFRe2mjVoku1YuXqKU9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN7PR11MB7601.namprd11.prod.outlook.com (2603:10b6:806:34a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 6 Feb
 2023 03:09:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Mon, 6 Feb 2023
 03:09:36 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Topic: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
Thread-Index: AQHZOD9ejAi0bsndXU+9RwTFzHNkO67BPBpQ
Date:   Mon, 6 Feb 2023 03:09:35 +0000
Message-ID: <PH0PR11MB58800C6FD1C0DDF8EC67DB5DDADA9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230204022051.2737724-1-joel@joelfernandes.org>
In-Reply-To: <20230204022051.2737724-1-joel@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SN7PR11MB7601:EE_
x-ms-office365-filtering-correlation-id: 2603c9ac-1a8a-4d6d-186a-08db07ef93b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBGopyYRmVSywVfNwX6QMuSyigUQ5m/+wcgpPJMM2oBeattpi4DDhNfFTYx3c5pD3tOq7BrkJzqvLfuqTptEK3ptwRR3/bvz9DnIuaBzCau6+AgLQmuiiuRQ8UwwP1qxOtIDErSuSIdtjOxHmMXkZVSTkhaErvKe1spcMGw+8VDvtEn4eHbL8U/zkNWRH8mA+hLQ20H31XLAvFASQIWQ9AtMV5zhj5V7Po3z9B02JFTh53OGD1QyYlgdg5p6djSA59DxuivFoQFSon7ajKqHXVXDPaO57jsM5vWUynz7a5vfcVfnRtoCOtJ14DvK2EI9k4K8VXp+PcDQbijXlZFfh6uOBtco485dPPFsWUx//PbyLOf1qhitdd7BgVMQXrhY132CGRZjjvSwBz4rcbeWB2lh9LM4mR52RGeYnj3IYzQxbWM6Tp1opSOwE7lytQjHi8jXBml9w03a/c9yaZOiLYyHsPD2fxSsaCHBguMF5Tk0MXoY6dqILUV5a/KwGC9IyvustB/OFIKikMQW9qpY2Z4mIX0Kyz9sQmBiUEtrYN8x55fRJnm/7jfqcQmvVdahZ6eoG4d/SuaKdNXxwfTzx2I5XcNIvJFjXUSO3RU5+rmn36COgLPhLLPxiXVGS0vpRq4OfFzfErs9NkoIDrw0Q5neJQt210v/R/T1eM7db6GC2YtYinrh53sdR6EGovCr8/W2vhBzui2wOINUzfyJ7LiHHeZGPrmZtDJ2CaJs5IY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199018)(41300700001)(64756008)(66899018)(4326008)(66446008)(8676002)(66476007)(52536014)(8936002)(66946007)(316002)(966005)(66556008)(76116006)(110136005)(5660300002)(186003)(54906003)(7416002)(6506007)(55016003)(33656002)(9686003)(83380400001)(38100700002)(66574015)(26005)(478600001)(2906002)(7696005)(38070700005)(71200400001)(86362001)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nUpSKvbRuBlMUFglXLkjCXTdkbf9Gq9smIJjCRV8kL6PuvHI+sBfCrc4ZiSx?=
 =?us-ascii?Q?KzNkiUOcF7vLp2cYTrepQAFr1JCK4o3VRS1hQ/VPfMuzmglVkWetAWJT6RUf?=
 =?us-ascii?Q?s0M8T+DHIWf/QGS7yabd6VEy1J/QHFs5T5y1HCJCIE7I+5fyusvv3KzB0uFK?=
 =?us-ascii?Q?Y87n40V1QhDi2vV9reXttKD1Z0GBaq/Y+ldJ39aPlvyU7BvNUBCMHbRQl3Yk?=
 =?us-ascii?Q?Qv95LT6gSZ8rIKuduouw7Nety0AxBWt65eaOouEskMTLs1LnoarK5nCpLqPa?=
 =?us-ascii?Q?uG1Pjq4UPVgu+kxa8OtZx9dxqUmJf5lKymvncrBmI/NFDbUm1IiVVtB7CrLH?=
 =?us-ascii?Q?h7DRFFKr0XwsU8DVqhSntf2bI8hYLUEijdxuDWWxr7TyQJ8F00HS3SD/Phf1?=
 =?us-ascii?Q?axz4/EYxRxLqnivUX3CUHaSXLdSIUIOCVgix6+2SVTgoA/Si9JxzBLqYM/DF?=
 =?us-ascii?Q?K7rcw8Y2c1BYmVUXcE/2nhireLho+v3YLJI/UHsOUtI6B+sEL6q0mRXrIfDS?=
 =?us-ascii?Q?L4Lyy2A/1tjYcsWMMg4SlgZ89Q3Gvh7HgbFpHpj/aWqquJzeuetsr119xjTf?=
 =?us-ascii?Q?ibOfXRdhV5UIlP2FCT8mI9+2DmBkexC/K3J7JaUOciyL6R8oUbUZ+MK92SFO?=
 =?us-ascii?Q?F1kJoUsgnuGjHNuzNFFPTwKNC7YkXiNi8AGhV0cqqBAiAMppzQWS+m8wUeBK?=
 =?us-ascii?Q?QwfzM6SYPPJpsX9lGvkr06GMD4Jlrk1e0ExjH0pCROF4sie7b2a7bgFMGokR?=
 =?us-ascii?Q?Ux3v8lu79/mm58GeWg146sP7HZMM2DpUoiyqxoI6gW7rct1sDHzRRFG/2TZ/?=
 =?us-ascii?Q?PudS5Ju853P2N2sXO6qp6HJ+YbBbnvwpS8UnKnj2i9N9aNlBxDfo4VemmK6P?=
 =?us-ascii?Q?1yyU2CAONMW+IlHgnYNd9T7M+QZi/RuvlzRudlZ6dIt1PlKpcswQgB4JQ56O?=
 =?us-ascii?Q?ZX0MLg+qZJtm4pUCo+pSVQBw1FGhg2xfWh8J7E2DC1wY0E4fh+4M7kR4oDBY?=
 =?us-ascii?Q?zI430mrQQjuNAgkGaVFAL9mxbxcrMCScP1mSreNDYo/X4/RQIA2jUMncSOqz?=
 =?us-ascii?Q?vRkD2fTYEimpY81JBhnbG0GvgMmjDMluYXnAoFBdgxd9PWMbMrm+8sdTFTAu?=
 =?us-ascii?Q?TZyGssGJAgTplaCSNb5q5mbm391HZGYSgcqQowHAXUdSbiO/JSG6a6YSvuWZ?=
 =?us-ascii?Q?vND2A+hKIZC2TF5KiT1LfnV+FWZUowlkCU2fMkzDy3ihpKVasGhbEI4BUgbC?=
 =?us-ascii?Q?rGRkxdcJf65b/eppigFO1T/RHmAC6ZAW9mX+DwkJ0OgC6jgY+MPR+lTF3TV4?=
 =?us-ascii?Q?aEgH2FoOUhulxFKq1uereOACq6XsU90EemM1i0/K5sM/sh3OCTTtiVxjeNNc?=
 =?us-ascii?Q?lM6i4iweyNJj7MUfsZSNISpXaWvTCZ5N4iWRCebczYA8ozjyW2wlnXjjZ+dx?=
 =?us-ascii?Q?AWkznZtMCnKJ/cm/sfJX7w8N+5Nupt7ICnuCxfQ+dhQsmJhYUq8yalqvPh3H?=
 =?us-ascii?Q?I8to7Xz6Wy6XJrqtLnh7YsqlHQ30L96UOEP6TrGSZ6mlNKTmYox3DTeeXk/q?=
 =?us-ascii?Q?k+Temo6JAcbfCAe1To7UqQ1m8AS+Mxw1Y991amEb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2603c9ac-1a8a-4d6d-186a-08db07ef93b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 03:09:35.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNASBW61MXXbqUvEnL4fkZrm8aq3BUhE6rureCg33G0tsIu5HySmUKE6PUaUoNg2sY80wKMHG2THWvq4SSDbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7601
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>Recent discussion triggered due to a patch linked below, from Qiang,
>shed light on the need to accelerate from QS reporting paths.
>
>Update the comments to capture this piece of knowledge.
>
>Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@in=
tel.com/
>Cc: Qiang Zhang <Qiang1.zhang@intel.com>
>Cc: Frederic Weisbecker <frederic@kernel.org>
>Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
>---
> kernel/rcu/tree.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>
>diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>index 93eb03f8ed99..713eb6ca6902 100644
>--- a/kernel/rcu/tree.c
>+++ b/kernel/rcu/tree.c
>@@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> 	} else {
> 		/*
> 		 * This GP can't end until cpu checks in, so all of our
>-		 * callbacks can be processed during the next GP.
>+		 * callbacks can be processed during the next GP. Do
>+		 * the acceleration from here otherwise there may be extra
>+		 * grace period delays, as any accelerations from rcu_core()


Does the extra grace period delays means that if not accelerate callback,=20
the grace period will take more time to end ? or refers to a delay in the
start time of a new grace period?

Thanks
Zqiang

>+		 * or note_gp_changes() may happen only after the GP after the
>+		 * current one has already started. Further, rcu_core()
>+		 * only accelerates if RCU is idle (no GP in progress).
> 		 *
> 		 * NOCB kthreads have their own way to deal with that...
> 		 */
>@@ -1993,6 +1998,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
> 			/*
> 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
> 			 * if in the middle of a (de-)offloading process.
>+			 *
>+			 * Such missed acceleration may cause the callbacks to
>+			 * be stranded until RCU is fully de-offloaded, as
>+			 * acceleration from rcu_core() and note_gp_changes()
>+			 * cannot happen for fully/partially offloaded mode due
>+			 * to ordering dependency between rnp lock and nocb_lock.
> 			 */
> 			needacc =3D true;
> 		}
>--=20
>2.39.1.519.gcb327c4b5f-goog
>
