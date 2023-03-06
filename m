Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D2B6AC349
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCFObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCFOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:31:29 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943D5210A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678113047; x=1709649047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oEtFFhO84olo6nf75Oh7ZVlcWiroTD7SIvQLO7p7S6U=;
  b=JC8Uh+emmKm973jcYdG3fjFB5pBs7VzWqJed3SEWSB4ivycFZj6cTq/q
   7ngdCIHL8jHepmihu+LgtZd4nOdajMkh2PyBvk1ZmRdEBJzNWTnNHcqBA
   lkXelJI0+LMxouatd7wGmkSdDwkscVpjQe6zftOUdUnm3d9861egI+ZnV
   fq6Zcfwcy9zZq2S8MCpwJD4d+1OIZqHMoFWq2adlJhC/24iClyoaxGhUN
   X8L0OMJlnxRlgY3imHbxpRPyNRGZhONEQTtVkhPshCOf61+xzZRR15eGd
   Ef8uM6McG8dwrXGVdd5AlJL56I1v0IGWUw9c7x9nobVHGgCINQqbE1P8b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="319394688"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="319394688"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="678493501"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="678493501"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 06 Mar 2023 06:27:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 06:27:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 6 Mar 2023 06:27:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 6 Mar 2023 06:27:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRrf8qwNDAf/s/zIOQJo87KrS7i1f7ybjHcXf2jKvCqLpOhUx3FPQVAFV/mYESp8g8sroCtvJ4FjH3hWKvSUmU5320ri/t0DT4oaAmlTLWLvkkRk3TnMZb9ytn4X8qqGKKTok5/XjlMoZvYivfVo8QyRMqkSZhgqLwjUpSDgpXaECZdJfC8w8RpcD9CMXRVT1qpUKzx49at/sHGI574kicNRxc7PHbURyWAXM/0ukYz1bF/Ds1VXw+I25RvHZgclcCXAgQ2nbx5S5RRUNMs8PY1uP5MD+v0b5WA/1Z6i3aGPNvN94JUttR4dUzsrVc55odJkWhCRZAIouEiPPiWeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9kCWIK8Sk38N7w61nCzGWawWvG5PmTTgTA/H3V/tuY=;
 b=O74K01QjJKmrZTIVSwNJZM6pVf+rtePNb2c34KbAKdSA10sCxj5EdNpUFpzTtY5yCk6lk/McHJi1Bbp0XDf8sZrUFCgQ3QLS0PauAOk57OB6DimvxbrAESQqloJx7TvC5xbcv+BThLzTjwWSOjGabRU8+XyE36D1fTB+/5P0ZFhBpg/OMlIyQ/MIwxQgEaxFudASAK71OywK7AqYU/gkbYw7C9hbp09de/EWjkIyNS7X8i8/cye87Yz82GXvzXUkTtN7dhJ/1KUesBBN2hmzpmj1IVzX7xIsMNuniOUwbAw0aucrElG35YHhMyxJSgRgfxlS9Vi8RSfM0EFzwqNatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW4PR11MB6839.namprd11.prod.outlook.com (2603:10b6:303:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 14:27:41 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 14:27:41 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched/fair: Make hrtimer callback execute in the hard
 interrupt context
Thread-Topic: [PATCH] sched/fair: Make hrtimer callback execute in the hard
 interrupt context
Thread-Index: AQHZT/n3qfMUi8dWmUq1jZFZUkYwxq7tl1uAgAA3xCA=
Date:   Mon, 6 Mar 2023 14:27:41 +0000
Message-ID: <PH0PR11MB5880550ED109DC115FC0EE17DAB69@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230306070938.3099273-1-qiang1.zhang@intel.com>
 <20230306110609.GA1267364@hirez.programming.kicks-ass.net>
In-Reply-To: <20230306110609.GA1267364@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW4PR11MB6839:EE_
x-ms-office365-filtering-correlation-id: 85ce521b-deb3-40c3-1021-08db1e4ef182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOd5Ub39LGyogGYnnnxoRk4aXiydnu4av2+m02LquqbFiKd3Cr7JO6l6sy45MZsubMKHICTfDdHjXWxmlPcOfB0CAGWjJJeXJTJAsW/R46OkCwYsDZUu4jQQ/td+oLKMsToIcAdUkxJaDhEWsyS3Cs3NZ9yJawEex5z0ZawIg3YUeCotekvjVNFUxiRHc1QK8jzxisi36jScghS8gBSxBDTYOYO822NesNFtzXK7TOY8uLwKR/UvFyhnZudr9D/nj43OjC/Kq2Ib+wce48hClvZR3+QVCUlfst9Q/Td4LXi2c16jMaLfSm0CR/FyucIanRvxNapnQehu6CstWdK2m6B7HZi+NwRpaRPVZqVaLlhEVb9xnxdVQ1K/6Bqe132dQ+qWKPbATsO2gTXwvnqN9mTyYaD5C8mHHSWB3kEy3lf5VgPmmGLKeDX6oeLMxltusUu6JxU3XXRs3FaJlxBX1AE2iTFykHA/dQKPMnT6qIKTfcJ/sbDd6uioWYlygMx7LaiRpVBs9QAuqSgkviZDttPYHMm+C2/soap8527M3HImPpbNP4X7TlzWA6SY3DGBuAff4Tn/FLHLlfXL1FbXoPNUqf6BhsR3mJrOZD2Y1VeDEqL68dUVN0Jdwd6K1FX99pYD3vZDRspyrldVj/ZPXiYbgOlq3TGgBQD+6qDNScM7cPRE0uubirOsaDWX3VUE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199018)(38070700005)(71200400001)(41300700001)(8676002)(55016003)(52536014)(7696005)(83380400001)(54906003)(33656002)(316002)(8936002)(86362001)(64756008)(66946007)(4326008)(76116006)(66476007)(66446008)(66556008)(478600001)(6916009)(966005)(5660300002)(2906002)(186003)(122000001)(82960400001)(9686003)(6506007)(26005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K4ssMxBqim75eVDMLcMknit7fB6Ho31OPliLOS5ydfekSq/tgK2Dca+J6sq0?=
 =?us-ascii?Q?Z7GlPSiP+mSPIm+LzshYUXBF7ipZwpLjYO9Sr4IBSUY1h8mMO6lkHyFxD/PF?=
 =?us-ascii?Q?V00SqvJnOsO9DrLletK1QosHajmdg2Nvq78mcnAzxhXMOQjOZfowehksdGec?=
 =?us-ascii?Q?sl11j3f8v99aTxcIJ7ua+MtdHU17pWyWWCP8gZSErG4pZdxH7MQXG1TgroEK?=
 =?us-ascii?Q?CynYV61Xzilpl5UqGmZqRFKC7u1UNCopBypdB/NBGrTkSdvFtvnPgnA7/BvG?=
 =?us-ascii?Q?xjOtr7o+Vhc6/2lOVtbfZ4Hjiyk2A3r+bR8cJ78WC3LdjAA1Po8hvjqHZORR?=
 =?us-ascii?Q?6nRQu29DsKMuYo1SZMKNVtyTo0bwKO7Md9p5vigDqzWXKqxBichZLN4yPv3H?=
 =?us-ascii?Q?bqxQG41Sm2SQOsJZqGG7otpUqbmOTpO4/qiW0ieuvegB0qun6TGJdqq6MsOb?=
 =?us-ascii?Q?z1muCDWu/kQtpLexi2tUuNkCDk6wLpi5ctS1fZSVL/zs7h2pGfwsPk+aJvab?=
 =?us-ascii?Q?nW2wVI5kReDE7BH/3fMwM9OHLD+ebWphe0IDK76J2LjU1Y9LOEc7+hZtFSZD?=
 =?us-ascii?Q?cXxXa6sduTBgO+Bvnsdv98XSjGzdViW4Qo6NOzZei5JuaF7vEPE4OhkEBfLl?=
 =?us-ascii?Q?m1c5yXRHP7rGRkQHr/OXKj2HKgUMM1DK+RR2I0cI4Ma9r8CkiQ7kr9SAK1Li?=
 =?us-ascii?Q?5LfLt8/5w7rkQ18CqSQW82oC1VeDwfzK1DKiUJnARKW+x0L/TMDXMfErm4RB?=
 =?us-ascii?Q?Lfk9jExGeIXwVlpcxxllJxCViG8+RHpr3p8OZMGukS3KTsM9Vr7o1xqaX2Oq?=
 =?us-ascii?Q?p1/qZdY3p/ugLURPJ8Q14VHBaNEh3+hTnDMhMWEgFH0FIIdsZHD7ptHjsnXG?=
 =?us-ascii?Q?uPGQhrD0AvkWMB9jWcvQZA/9bY13fz15xKdhJwav5x+vqq25yu5x+k/xnGz4?=
 =?us-ascii?Q?AzSEKnmwUYovsPOUvNJcUp1bxtz80p+K8Qvz0olfx0qEPs9/rUXBfoZuCdin?=
 =?us-ascii?Q?Bg0v5T6a+RTtr9zQbVpvjc3s4V0fabHqBjNc8wBBHV1bfLZm8JlZq/t6YQs4?=
 =?us-ascii?Q?M8zlctUm5Kcoyidnr3IL9aU0cbXILFAFSR1JeXdZ17DGB3PgyW7k6Mhj1GRC?=
 =?us-ascii?Q?szU84n9AG2gwsFqeH2+CWKtKNSzObRQbhIjKGZ2C4R+zzBzrowu1tsjeW229?=
 =?us-ascii?Q?3DAi6jnQpgPnsH0dSp6KJOzXAyy1xS488n4TTrD6kdhshnsjikZh2jVkGntc?=
 =?us-ascii?Q?EMs6Rq95Ls12Xg5QC91zzhoYshUNbSyiDSUeSwo4BA/CwHuztqnAwK2ltVjj?=
 =?us-ascii?Q?uPvH2bnoOfuWTYDvZVYoYhxkHBafAZF+wAekcW+FGo0a1aG52/9fC0VAPdNy?=
 =?us-ascii?Q?+7br8iwnsXA6+317u09cPiAV80VbKF6fSmR6VdkmVPROXjq8vawCn2RMS2Pl?=
 =?us-ascii?Q?xJqrNu/5DYJ9tETDhEzhPzA5AneVZr8/hZIdCrGFMMSZjiH404cn2aUdWtCD?=
 =?us-ascii?Q?0iyIteO5AGGNdc5D0OdQ1p9FsxIqzYQCqGWvN8NZ3tcza9yR+79B1BBNDZ5T?=
 =?us-ascii?Q?SgovdLGcejFBYuhN1TfGrtotrRAWZ+YJc/GCzzcN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ce521b-deb3-40c3-1021-08db1e4ef182
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 14:27:41.0547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAmdv2qXVxq9uPxIY4Pb9q9ViRtomKuS30+4B+UNNiD5dM9IgO7i7jLcZBCjZzKsTdtVcm4VjJ9Rckkih6BHyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6839
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The scheduler related hrtimers callback will be executed in softirqd=20
> context for PREEMPT_RT enabled kernel, this commit therefore mark=20
> hrtimers as harded even on PREEMPT_RT enabled kernels, there is no=20
> functional change.
>
>There very much is a functional change, also your reasoning is non-existan=
t.
>
>Also:

Thanks for  reply,  I will reorganize the reason and resend

Thanks
Zqiang

>
>  https://lkml.kernel.org/r/Y1F5sDVGen7ZVW+U@hirez.programming.kicks-ass.n=
et
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index=20
> c36aa54ae071..98c48d144089 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5610,7 +5610,7 @@ static void start_cfs_slack_bandwidth(struct=20
> cfs_bandwidth *cfs_b)
> =20
>  	hrtimer_start(&cfs_b->slack_timer,
>  			ns_to_ktime(cfs_bandwidth_slack_period),
> -			HRTIMER_MODE_REL);
> +			HRTIMER_MODE_REL_HARD);
>  }
> =20
>  /* we know any runtime found here is valid as update_curr() precedes=20
> return */ @@ -5813,9 +5813,9 @@ void init_cfs_bandwidth(struct cfs_bandwi=
dth *cfs_b)
>  	cfs_b->burst =3D 0;
> =20
>  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
> -	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PI=
NNED);
> +	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC,=20
> +HRTIMER_MODE_ABS_PINNED_HARD);
>  	cfs_b->period_timer.function =3D sched_cfs_period_timer;
> -	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC,=20
> +HRTIMER_MODE_REL_HARD);
>  	cfs_b->slack_timer.function =3D sched_cfs_slack_timer;
>  	cfs_b->slack_started =3D false;
>  }
> @@ -5835,7 +5835,7 @@ void start_cfs_bandwidth(struct cfs_bandwidth=20
> *cfs_b)
> =20
>  	cfs_b->period_active =3D 1;
>  	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> -	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> +	hrtimer_start_expires(&cfs_b->period_timer,=20
> +HRTIMER_MODE_ABS_PINNED_HARD);
>  }
> =20
>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> --
> 2.25.1
>=20
