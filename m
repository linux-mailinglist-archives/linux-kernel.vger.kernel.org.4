Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3262D492
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiKQIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQIDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:03:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF1DF57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668672191; x=1700208191;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=22h3Aa7keEftVA8CX1dRrbeLmwNuchCslyN8BMiAi4I=;
  b=DrprppZa6o08Q4pQhNRooLiQxrxAczDRy3Ise5wb7yj9qtabPCorAgxo
   BwvOEkbhsRTmjyJcSGJJpVj2HXJXt5PGOjYd/Rmd1WIOMnKkDvXG+5gqM
   wxlYSudooMDoLSVeUr0q2Et43GlbDtL0CsaVGnz3ZTql6vDFLauk5bbBO
   gSu+V2fKmZZ7ZKs0Z567BndxbR0hrLNIyrvMeFiXVvQk9y8Metdzl7jT/
   vrfZ2VXfzSbDVy2irdn8eqX11yNKHGVXyDZhRQRrp7naIFoCdVCQcq0IT
   7u4uD3zwjNlMbhrozwQYglY7PmaygIPLKHYR0WIc8V0DY9mKWjfStb9ca
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296151130"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296151130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:03:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639711134"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="639711134"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2022 00:03:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 00:03:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 00:03:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 00:03:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE7aFMI+TWxa2Z7+nzhKfdC+9cu+SIxnUqphEWoZEugeO7Z5THQJyAQiiRiZ7jXonuleD8EyVTRaCi0uIYqdMjqa493BixoNUY7C5/M9jcH7gWA/r+dJCJIRenvbX0XDcXWlCaOMpJCVunJ0/jjtR+2K6caDeKP6569r1S9yLwVd37jCix2UtT1Js9mk4G+34bI3qbAB9RVWQJJYoxpQkXQ2Mr+6o7MEzx8R00e6pWzlokg16UYh6fHGo3zbbKpqRQ67+AQ5AvhoRDXAK9pGTd+yOSt/dpQxaoqrQ5OIbDq8bExuO4LBFqrSnK8x9SFfQZm8oATQT7q9phW8Nfq2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Nwcz2gQxQZDmFNlvFNCsaEsrDYt5fqKFn28j15B8QA=;
 b=h0MgglBfleLhoDbPlnHGM6OFSn48ycO4YGAfi5LIOqimHYjAlm5sj6ZSJivyoxorr+fIOKHXgertXoWlc12vBNny4XnA3UEYEkBdKwN/jBcTKOyjBa69N5fEdfr11E9kZqRzQxUvoyzSOopnFU9UEyPXfJHZCwwCPZJ1LaWLjYMpmnBEau/s8bRtxNhiw7oAq+TwSXu/Sf23ObUygpMjXWrHcaFBJhfk7swOrI3+z273RC6LV50XvNd2+94+t99gIrtfH/etj1bYvrakuvSBRK8RDrblbeoDALsP/ObmTY7eEqrv3vOgyI0OZfyFIa6n8xJz+wDcSswAYDq6aTAbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4092.namprd11.prod.outlook.com (2603:10b6:5:192::24)
 by MN0PR11MB6160.namprd11.prod.outlook.com (2603:10b6:208:3c8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 08:03:07 +0000
Received: from DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::eb15:8484:2adb:5521]) by DM6PR11MB4092.namprd11.prod.outlook.com
 ([fe80::eb15:8484:2adb:5521%7]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 08:03:07 +0000
From:   "Sun, Yunying" <yunying.sun@intel.com>
To:     "Tang, Feng" <feng.tang@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clocksource: Print clocksource name when clocksource is
 tested unstable
Thread-Topic: [PATCH] clocksource: Print clocksource name when clocksource is
 tested unstable
Thread-Index: AQHY+ZJ1xXsis4rp9kmS/pgu4XQ8G65CrZgAgAAQ0GA=
Date:   Thu, 17 Nov 2022 08:03:07 +0000
Message-ID: <DM6PR11MB4092BD02BEB543EB4A28489FF2069@DM6PR11MB4092.namprd11.prod.outlook.com>
References: <20221116082221.25243-1-yunying.sun@intel.com>
 <Y3XY2shpqb3Nn9ZI@feng-clx>
In-Reply-To: <Y3XY2shpqb3Nn9ZI@feng-clx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4092:EE_|MN0PR11MB6160:EE_
x-ms-office365-filtering-correlation-id: 750ed92b-afa7-49a7-94a2-08dac8722977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gbUrAvrJLlgUjvHM/9DVXMrncQ338bWJ6mOQc/txkmwLk9AXvwyZp0Pau2HojRcK4yFzgIIf3e/n637tW7yJbE2PPBt4zo7XOkNldt7D4bj1fvUOM3v35KzHphyd6u024QW5pNerY/zIP1hSsD2RxdHDZ/Rj39+OS+hMIgvi/96iIUXO2X6/uTouEAmA1By7T96ODoq/HXbNzDZJ5xwXlJU20MUBDwnEG+v4t6AynjI+bxeB+uk7DZeBsN+04xxZb8FLLSb/Y6iMs7ejuZCZHUgpFpiVJJ2rsjhn56zOJ+7S7OA9TS/pZf7KQ9WGfnhl+ZAwmSg/0ZzY+FXLTs5N6DTYuFEYIVpEFTIq61SBe42ANJTRkBVD0vjpRQ0+sflmjm8EaZuLLL95iyKDX93s7j2s7zS6Jeqf5wsulx4AUwyS4FOosjiCKWMz5fXdNgqcszsVBKUy9XCRV6o2j5E2rWTQRReP0dXEZgF2sbh5TsjT7WmtxQ0JgdnBA8RDws5HcWvRQkpQjumgER6z/bnwtbCPw8gBzsEyk2tweh8BbUk/tJKgPYT7vDvhPyStySQu5qbRPmrHJqxwc4kF3ffnMczJqqM5JqpsscY7ICU9dLgYKfhadbr/G9d40HRfpOO3wQl8402/tWTIcnWB3wEERG/7OuAIV8W6Hf40esUTZVnUFG6PE45wzE9P3aG0dCc0ZzAnsVdfPYP9cQ+BaOePfzc2mUoMoKlipsosBR3NDss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4092.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199015)(9686003)(6636002)(54906003)(86362001)(26005)(53546011)(55016003)(316002)(83380400001)(966005)(6506007)(7696005)(478600001)(33656002)(2906002)(8676002)(41300700001)(186003)(71200400001)(66556008)(6862004)(5660300002)(8936002)(76116006)(38100700002)(38070700005)(82960400001)(66446008)(52536014)(64756008)(66476007)(122000001)(66946007)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIfQNa2/RE1zcm4KCbaIAFdRzZzPh14SY5G0px2XKATvB8Af3JOQCemzGrNo?=
 =?us-ascii?Q?z52L8Qk3QAStEyfXPvtgvYF9tmTWQxlL73aefn8fsP7cF01F1wMBamhdnPWd?=
 =?us-ascii?Q?vX1+UZb7JfPcVAUZnL9UjFR/P0NtRO6RQjfwyQ3otB+WNudArH8ERVuz1LqC?=
 =?us-ascii?Q?ZNUL2/9xcbZxKuU08uteU/i0mYEWL0mFw65y/WU5Zu2+AxTsqEXDP3w+S9jx?=
 =?us-ascii?Q?M9q82NMwraIu9iN35tNSNbXwOFJwXA45P+SkC6PRn+SiZmIDpq0j5X82M0Nv?=
 =?us-ascii?Q?DI7gz0vxXzOKbRn0SPeBvJvWST1E8ykMWMHSTfE0ZAv0R2PBB85hy6HXh6SE?=
 =?us-ascii?Q?jAgA6pvT/qnULgBo4KQekfA0CMPN1yMNUfLoU15dTS7fLVJCT5EvErMA1d9l?=
 =?us-ascii?Q?LS68eXy5iqj6jL3w/lTyaQskuMMOCQDiBDVCT171/JJzO7loV+FbPvuzbsru?=
 =?us-ascii?Q?kSyZxM0KCZmeJ4UeXANoHVU0FGw8cVMvxYHHn74mADrGM97iYH0KQH/XtIfx?=
 =?us-ascii?Q?g3nO+uAPVPKiLDy74wD0WnKk2JkcD56Qf5pE1mPEYHpImj6jHFI0Jes+RD+b?=
 =?us-ascii?Q?iD3na7L+Rv5Dc1/Zdb7iLjeVoRHNL1VTMVpeW5+f+et5CTNxw7ld+UJ1lVb6?=
 =?us-ascii?Q?EoshOIKd/ZdXc254Eok9ABeywGMZDgW1LcTigEh02ZxpU3O7/1yDj0frc1LQ?=
 =?us-ascii?Q?665U/CNS/MVbBHDSe1fxh/N+niEFnfqSFNmc5/kUPMwvcwnsHbBiu8UISBq2?=
 =?us-ascii?Q?lWS2tnXuALYYCUAfwnVEV6TxwUzplZt4gip1Oq69cuaD/lOs5AW1qsVNVEMA?=
 =?us-ascii?Q?Ip4qLOoJj/dXQJ8Y0xDHmFiMcT2zhX98s2K5bSfp/5zdwrNEJHRt+pPWdBZd?=
 =?us-ascii?Q?V3rp7XhUoVY5K1yI3GZsJLaEE8pBUzP0oKIdh45giwYhecnGEqzfunoou6/I?=
 =?us-ascii?Q?WonHrWZ8Cex/DXWtrQzYO+t33jKBfKykJGNpUlJmwPVi9pT6N7l15fUk5wZk?=
 =?us-ascii?Q?IzNaTGjDpsTWLwLhuYGUhjerghu4ut/Rg7iiusI6gfMjClcPfV2AzcVOAblH?=
 =?us-ascii?Q?TZw09I7sQBfVv2dywfJgiqRn6s/nZUfWRRazhoNsrIgY8GN8ryNm8PxQnLuh?=
 =?us-ascii?Q?cI1lDFSaSS2vaYbDwQc70YdPwUWjgz5LKWu1co2tewwKDKAZ7olDuQHvUqZs?=
 =?us-ascii?Q?TDJCqXpG4PJzxik1xnJqurWr0oYDqs2W17T8sbsH9q1tIWEqYlMpKT/hPIMl?=
 =?us-ascii?Q?qGunpgrAG3nxs2zciRwMHH59ZUteJNPX9MHA91wKre8tQyX577KQc6fhd26e?=
 =?us-ascii?Q?HwUJgD9fNWwZNJWaH7+0N/HiYJ8ufivVPiAejwDuNe/lGIi5F4EQ7sw4QIdU?=
 =?us-ascii?Q?EUvLEd39yGoG94/zITbnniSo793QlwTdeUWyeGs6eyLLqQje4sexWePKK9um?=
 =?us-ascii?Q?rf8H/XY9hTP5tYBG1su3bgklJ00NRKp5+vB6swp+EnTg5QUV8CUKaGHfE3np?=
 =?us-ascii?Q?g/e4u7yDiTSPqnPLjFIqxMV9Tbj1hbhcNSIEfySr59qn0UaZgS0mUJrJzOaY?=
 =?us-ascii?Q?m0ji+E/qyMQ3a63LCdz7qU5eGrUxWZBQBb7tJFEk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4092.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750ed92b-afa7-49a7-94a2-08dac8722977
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 08:03:07.3407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNVF3VctHL24uHq+8/TWFi3Hqwvrr1lzy/iQuw9f6X3PrzT5I4o6WPo8jcyG6vgsPoQoTH9/3lqK8wmjyHGn4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6160
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Feng,

For the "tsc fall back to hpet" issue, thanks a lot for pointing me to the =
fix proposal patch earlier:
 https://lore.kernel.org/lkml/20221021062131.1826810-1-feng.tang@intel.com/=
 .

I shared this patch set to our customer yesterday.=20
Just got feedback that customer has verified the "tsc fall back to hpet" is=
sue does not appear anymore with this patch set, after 24hrs stress test on=
 8 servers.

-Yunying

-----Original Message-----
From: Tang, Feng <feng.tang@intel.com>=20
Sent: Thursday, 17 November, 2022 14:47
To: Sun, Yunying <yunying.sun@intel.com>
Cc: tglx@linutronix.de; peterz@infradead.org; paulmck@kernel.org; longman@r=
edhat.com; x86@kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Print clocksource name when clocksource i=
s tested unstable

On Wed, Nov 16, 2022 at 04:22:21PM +0800, Yunying Sun wrote:
> Some "TSC fall back to HPET" cases are seen on systems that have more=20
> than 2 numa nodes. When this happens, in kernel log it has:

Hi Yunying,

If the system's physical sockests number <=3D 2, I would suggest you to try=
 the patch https://lore.kernel.org/lkml/20221021062131.1826810-1-feng.tang@=
intel.com/,
which is still under review and discussion.

Thanks,
Feng

> clocksource: timekeeping watchdog on CPU168: hpet read-back delay of=20
> 4296200ns, attempt 4, marking unstable
>=20
> The "hpet" here is misleading since it prints only the name of=20
> watchdog, where actually it's measuring the delay of 3 reads: wd-clocksou=
rce-wd.
>=20
> Signed-off-by: Yunying Sun <yunying.sun@intel.com>
> ---
>  kernel/time/clocksource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c=20
> index 8058bec87ace..fac8c0d90e61 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -257,8 +257,8 @@ static enum wd_read_status cs_watchdog_read(struct cl=
ocksource *cs, u64 *csnow,
>  			goto skip_test;
>  	}
> =20
> -	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, a=
ttempt %d, marking unstable\n",
> -		smp_processor_id(), watchdog->name, wd_delay, nretries);
> +	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %ll=
dns, attempt %d, marking unstable\n",
> +		smp_processor_id(), cs->name, wd_delay, nretries);
>  	return WD_READ_UNSTABLE;
> =20
>  skip_test:
> --
> 2.17.0
>=20
