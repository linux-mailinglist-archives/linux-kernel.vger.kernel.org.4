Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DE369EE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBVFog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBVFoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:44:34 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA2A2056E;
        Tue, 21 Feb 2023 21:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677044673; x=1708580673;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iBM/FVSV10AlIZ5e2IW4MS1ep9CnJ95q5e0PAac4ajY=;
  b=nete2yt74HEPd9785hZU1164nH1Spnnxw8tXBewT+OyvNFtLbdYKSqrR
   PS/BnKsstSm8oLHTRBfLlTiCpS0Id9xVRH2EpuM+8EetU/EV0eAYSjqOq
   nyrXDUvGcO9GLdWvpEscZQpiHg51IBaH8bJj6SyzUCr53kONoHEo/eEGB
   D0MRwBA10QbuI+FDx1MXOqSK7A5ZPP+0uSEKymaQiUxZY1r6VQG5cVWf7
   +7QYWaoEnVcjwfAf+O2eoWAbG7de7jwa2z3+ybe4308zRkdOdmn1hmICf
   k7MGCENOnacSOx7NkLN9zbYdfzNx++57oCIzlJPo80aDr8qfeyC8RSus9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="313215205"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="313215205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 21:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="845995339"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="845995339"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2023 21:44:32 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 21:44:32 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 21:44:32 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 21:44:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz5y4xGZ2NjRE3FQq/9dT9xqENfApmeiT/ehnuBf8kXvZflKz/Wp4kMqX7HHOjj18MGw132NiIxQnJdiwUzR5YAYGMjIyGjAG3DntHVNVQL5/im9o4uQ3WrP21MtgTeYoviG1KHkmcucqiUoQGTBTtCn/zg0fNJhlPBQiY1KV/X950WN2TycEXx6A3qEMq7vJr1G7vFNLGGqdctS3ISnIvBLibvOlVGzQidymIPluYKdGmusEC4vETMKoa82aupuQ1YVlvsFQVV/zcyOtRFKFtADqhC+jdeox5mpGpxSbNBCCYHXslhtT87waelm7dN92VSP3dTG6908sQT/jVfoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNU9CzDKdewxpRKOoLk5epcb7NjgNngZJaKQaXBD99c=;
 b=IX+mVFlz6Mm5su+xEnMzO9rU2mtXqzvijTo4JwZajzLd0my7IfKcFDEJSbiZ1Um93BsDppHNpn8VG47ltRVh3z5I99B5IH2A1f8GYECddD5ZKG1WS/3EWsAYSASNW2Yl5ZKVBHl4loFOn8srYO6XfGf7PnHfaGI2Vm8DIAXptEcZE8KFE0gTkh8sJ4zAf1BpARXnYyKcoTgk8WVxfIhm+xYaCGOX81LuipDPgexRW8ekHvJCYelRsWjIeMkWP43/z211BmuhkGcV6zLL2tWiDJyRa920VWrQl4ii9vhYcmwy0WJLFHJU91X9ziwshNukHgi0avrI/gQA7P/BeeRGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 05:44:30 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%6]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 05:44:29 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Allow RCU-Task trace stall warning dump late
 IPI CPU stacks
Thread-Topic: [PATCH] rcu-tasks: Allow RCU-Task trace stall warning dump late
 IPI CPU stacks
Thread-Index: AQHZRazT+oKQOzOvU0e8GfBR7P59h67adK9Q
Date:   Wed, 22 Feb 2023 05:44:29 +0000
Message-ID: <IA1PR11MB61710677ACB74D5D0AED929689AA9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230221043219.2384044-1-qiang1.zhang@intel.com>
In-Reply-To: <20230221043219.2384044-1-qiang1.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH0PR11MB4773:EE_
x-ms-office365-filtering-correlation-id: 8193d63f-b740-44a9-833c-08db1497dd82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lfYcK5EXFEXGhAtyMM2d8fobX4axVGMbOGca84L9zfFXNAGDifyJkGdcSRDvM3KSjvXqjN4567z3VABTq0XDY50d1jcr4HfJ/m1UWox3taLlxB9QCkjhh+bXRJ+3n8gCMcEHxjJY1IwSkQi26hG13lfnqE40UIJIHqD6J+U6biW2aLKbEvSo4ygLImkVZ9FtonftaV3F+m+eCrNv0QRNv/2LoR3kWGvvHub4uIWzvGOfwb1Pg5FGmoD/5wn1Unsr+5P1krqRiItU0LDipgGUoXtFk6GVVFT3pAyIWd6TQMG9UNZVli7PrwGoNBodITCqhkAMxPOXNRv1q3bQnImtkL7YqM8I9bvfKDoAhlsUlZTC86mJfEzroaMjZPNY3Jvz2BZJk5EnUgqIPY/8idS59G9p6ZIAY6sUL6nXd5fo7Um7oFMUoU4yO4vF29qcnhT1VkBJhMoKcwkk/ERYeM6NCNX+JqTUq5XgppO4oocua2sOcfCWYKvS1P25CcA9UXsIt2aKWeHH/brBHIsJJ+AljXfIEvRUFYFLLHf7t5yB4fgeItok1NRcstEPnAslhtTwF1JoQoIdCNogb20yBq6tAzXWOtktJWqZWSbGNMhLAWhdqkgbnOopdqv5S7woQU4q4cQcLlGMclRKCm0nsMzrsqQyYl2YXsewItKNXmAtlcMzrBd71eWdBBIsNV7Q2iHOuKVyDyA1qYuGg0YAVx7oLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(478600001)(71200400001)(7696005)(82960400001)(122000001)(38100700002)(86362001)(2906002)(33656002)(38070700005)(316002)(110136005)(54906003)(41300700001)(5660300002)(52536014)(8936002)(83380400001)(55016003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(4326008)(26005)(186003)(9686003)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GaP2Hu6ZV/0yvTMVDZ/AySIAZWzNc4pOe0FNGufGCueNamucTnY/zFYV+ku2?=
 =?us-ascii?Q?NIkrwnlU7S9ekNc5QxQDWhBphOIXpa2xEZKu7rCAhahHCEuTMIeMQcDIq/xL?=
 =?us-ascii?Q?u/Rv5qOXsEgwXlYXlFdfZaPiTMe/M4Fj0+U835TBVyCyzqWAGph+85q/B+us?=
 =?us-ascii?Q?2Ui9WQK/onoaLbYDDjKVNpYAvTwYZQaZakmQwjLkpDYe70qgHu1+Jl5zwxEG?=
 =?us-ascii?Q?6NvD4F3E0AN4tyhI5F0xst4zku/dDoaJZ0oLg5pABKORDO+d5RStqAuIGsua?=
 =?us-ascii?Q?b4PG6v4qS2Go7y2KQmA87Uw8kUeqy1QEoesHg2T2zMavpB1dHtLRrkkc7rpC?=
 =?us-ascii?Q?PKmPanc8Jh2VAG2mTTIchxnDsVjXFM5TLTgcvveNw9zDpF9Ns4Z9hweWVs9S?=
 =?us-ascii?Q?Xo0NcUXnjt2KBenCowbhXddf/KYQ8OCTpHm1hZcqEwpC8eHL/Eg59ZNSDLWw?=
 =?us-ascii?Q?HOUevPb6ci9yRmXlKS9aNH8hnTd2JEjQcqbtuWJqdmJzQxb7orhHPbl6u8Dw?=
 =?us-ascii?Q?gsGb5rftlbZ8DtapJJszyHZ6PLBn2H8DmXO9KjuT1znBumgOhoKJXwN4fRca?=
 =?us-ascii?Q?hJBATnEex6Vi7IO4tgaoVzDZQT3SmaUcvbkWt0FQmNnZqc5wlZTL78W9Ya/r?=
 =?us-ascii?Q?KloiMxrt6AtLO0TSYDd3NmNr4tyv1z3AyKgp4rmWgYBPHD/tzOU9lJ/WGGYm?=
 =?us-ascii?Q?bAUi9XhU458Wtqsh41BeLn244R9jmBDmXzftLnPpjdhg4fm3Uwottl2/dr4e?=
 =?us-ascii?Q?xEq8YFMbx8H6eySXf+xNGX5k4iGIgkxFG1khshM6WbzoAMCs3jFk8H8NTuyw?=
 =?us-ascii?Q?hgQ4c/68jvchr0qqtfCilSRnV9nWakS7wo51grHvpVYU25qvi9uTwKiXGNna?=
 =?us-ascii?Q?5juOQCSCRA9actfsGRLYg/XGt0ubzv+zue6TWUFSBUTox0WW6nprvxlUj7FP?=
 =?us-ascii?Q?EpqlKNBgqVp3Mef++RczjUkj7zZ+7z7q+ZNTFk9Ffz/zcx8taMynJfeJbLV0?=
 =?us-ascii?Q?PgCwmT+4kSGIPZzuL3yhCxKjXSm5dM66L/qM6m2Y73/wWbzcGtoSm/zZ96lZ?=
 =?us-ascii?Q?KyBpCNaofAeXLzvyH62ZhMBA0s8k5pgiVm6cpa1BwjQXS1CFlQqv43KzOWYa?=
 =?us-ascii?Q?4xgETdHDECBvTvQlpWWAF/PdHySEsN6LNc9u+FX2BALOtauov17PpYV0/+pi?=
 =?us-ascii?Q?pQp32yB/D7jA1dPbwX+f2H8FmOQLCQfAUmDweXRH2bjKsrjrUoskw509U8vY?=
 =?us-ascii?Q?gwisjgnaFa+a672D8epNBDYoo32aTOCgwWjdbMB+PxZZTVdcbSpzHpYJLTGH?=
 =?us-ascii?Q?o/d3gFBQc7qNer3BMIKkKhf9CQgHBYb1pyghB44RE9s8kH9nFHJxb/TSq16k?=
 =?us-ascii?Q?9bxK/8sZsczRV1NJ1oYDjkt8pFnbdUjOvI0IffRmFKBtvbIOIlcCNgH+DHEv?=
 =?us-ascii?Q?nTYp9rf7hmi3F9v375CwEm7R1HoRtKab5JSUf4VQ+jUiMCN6fBUWGPLZ1F/b?=
 =?us-ascii?Q?QRi+XdRkDQbTRG0+qQ/SJfuoDrCYE0Pnpl04jKXE57LCRGUWw9YiB50ZNPQT?=
 =?us-ascii?Q?n9r2KEvre9c4SIVdQ88WygkMAzpJXZxvoBL/ypcz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8193d63f-b740-44a9-833c-08db1497dd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 05:44:29.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JVh3Tn3qYh7DsXrWyA2PLYItc7gC7Z/+VGhHZh6D+L3Retdgu/54pvb1p4sr0dExYX4GPxyS4SAeIK0XGVjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4773
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Zqiang <qiang1.zhang@intel.com>
> Sent: Tuesday, February 21, 2023 12:32 PM
> To: paulmck@kernel.org; frederic@kernel.org; joel@joelfernandes.org
> Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] rcu-tasks: Allow RCU-Task trace stall warning dump late =
IPI
> CPU stacks
>=20
> The task structure's->trc_ipi_to_cpu and percpu trc_ipi_to_cpu is used to
> record whether the IPI is completed, if the percpu trc_ipi_to_cpu is true=
 and
> task structure's->trc_ipi_to_cpu is non-negative value, indicates that IP=
I is not
> completed, if the IPI is unresponsive for along time for some reason, the=
re
> will be a possibility of causing RCU-Tasks trace stall. this commit there=
fore
> allow dump late IPI CPU stacks to show the path that current CPU is execu=
ting.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  In the real world, the IPI delay will be very small, so the  probability=
 of
> triggering dump_cpu_stack() may be very low,  so if I makes noise, please
> ignore it.
>=20
>  kernel/rcu/tasks.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> baf7ec178155..85237fc1d0f0 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1658,8 +1658,13 @@ static void show_stalled_ipi_trace(void)
>  	int cpu;
>=20
>  	for_each_possible_cpu(cpu)
> -		if (per_cpu(trc_ipi_to_cpu, cpu))
> +		if (per_cpu(trc_ipi_to_cpu, cpu)) {
>  			pr_alert("\tIPI outstanding to CPU %d\n", cpu);
> +			if (cpu_is_offline(cpu))
> +				pr_alert("offline CPU %d blocking gp\n", cpu);
> +			else
> +				dump_cpu_task(cpu);

check_all_holdout_tasks_trace() -> show_stalled_task_trace() has already sh=
owed the states/traces of tasks stalling the current RCU tasks trace GP.
Perhaps we don't need to dump these tasks again here.

> +		}
>  }
>=20
>  /* Do one scan of the holdout list. */
> --
> 2.25.1

