Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131962D525
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiKQIjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiKQIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:39:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B301D67B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668674337; x=1700210337;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pAiZGVERgYtpFkpfWu2ABSV6vUk7lDpP2fxKjexLTIg=;
  b=DEP+YeYz5K0bDJ1bhHvA3rAuNSfFfJswMrEVBfF3cqgUN2KVVP99jZdK
   aZUZSdBqj+PY1br9T2HXNblzVtP7rVyaX6KSR/qF0ZPmOjdR5aDO2CyCq
   cNGVHw6PJ0ImUKQsljF7GK93D3jj8dCyZGBqwKtz0A3u0qoxlLwss/izs
   dPh6c9MH9sxNS5pRseIlSVnAkJkctp9aC1L3Imqo3j15CmmUVRgPHwM34
   WFt8BlFcSq2phHwkHPZP7SCZPonApwr8/t5KkKFgQ4zMiXUxzMfh5tPpY
   0c2EQT+ubyu7a87kyCbGFJQP/D917xovYs7L881GD2mAY33YU7HdLDhr+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="377061648"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="377061648"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 00:38:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="633980455"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="633980455"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2022 00:38:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 00:38:56 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 00:38:56 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 00:38:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhOv890U9Hiw1F2hMyCKAanIHsccoFPp5D4mtC84uyYOAZhkkcdSpywommKIR1Ze+wkRe4K7Jv6VpYCrmGQgPWEcgQccCgh4dzZVqsS+pcGv9vh2s8Y+wnGxDvm+1nTEOC+WtJ7rXoCEg6VBb5bMu9FhoImd/rjTnVS8Pu0UJIgwEdvpwKh2qhyRVwRaWsu1jNIft5AGHDunvz7sG14ozBAPqSoBWu3UYW8Uc003CjUFV6jaLwjyoKyUGVRP1Ze8xyOZjkf4xLPhI4cKJ2pgeygL9LValAQF0SBwZ5X+oNIm8KX2HMgHUslqPDPWG+tDx5UcDxDnJfBSwfPBiyEm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17n2sga/tmnM2sfgARHyTPsIsWSAYC3nC37eoIfthwg=;
 b=TNRGzKEjs6AgPfw3bklUZW/hhyB81OlBKqkxiC82OEAvOupDSqpPbaIhBDVA44gGjfH727BL/YPLX426Znn+UCAl1tphwND9VCfhWBOylKXvW4WVLf7oW3u6e0yuiton52goe75IKfzQdc6EOLB+PwtKhrmjsNV0SW4jHpRm40o0C7TEXHIN8mAY3xP9PV51qt4Jv0w7Uj3+G4fp52mTIQd2XH4waPwHQkdc5HR6tbDkd68U9SpCzUhvlv/CzhOueE7aAgWdp2+YjJVSwf9QObG+0ZVHABgMF93nqvGbve699z4H7eguw6ql4Ys29C60P77gzI+txIq89ofgucs0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA0PR11MB4605.namprd11.prod.outlook.com (2603:10b6:806:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 08:38:53 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 08:38:53 +0000
Date:   Thu, 17 Nov 2022 16:35:43 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Sun, Yunying" <yunying.sun@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        <dave.hansen@intel.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clocksource: Print clocksource name when clocksource is
 tested unstable
Message-ID: <Y3XyX24/kuafuqGH@feng-clx>
References: <20221116082221.25243-1-yunying.sun@intel.com>
 <Y3XY2shpqb3Nn9ZI@feng-clx>
 <DM6PR11MB4092BD02BEB543EB4A28489FF2069@DM6PR11MB4092.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4092BD02BEB543EB4A28489FF2069@DM6PR11MB4092.namprd11.prod.outlook.com>
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA0PR11MB4605:EE_
X-MS-Office365-Filtering-Correlation-Id: 969fa182-8a3c-4c47-bce2-08dac8772895
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVRA9hPZTECa/6Lz1FDTo82MrXioM+wfji7xoST2L8Wi4spNeFMaMOxVVyqGHUZLl1JuDH8mW5i3W/jrHiwEES635ZokfBM4MehRdJZgOAAoEUDXGhiT3dzXExiodftZkM5ff818ATYlD9mRHyA8BQP0O7c4o680a5LRmnZuHiMEkH7mqYBrx4f86aqrwzyrf2OySzrAM1zyNrB5upur3Z0QNCeHWywIvbmMGMveH2rYTT6dcXnh3Pw6+51KOx6Yv4UOAPD98Tc5yT4KZ6t4fuHGoihUz7GsUshrymkcUu3jCXxzF94nbcevt19tX6fPmePdwimJM0uS7jfSWxaM6bc3NlIzwXfgTbGm2M4zGKnFau7JoSl6Y1qavW4dNHHsjz/Qkq8OxBKl5TgzJDmsW18PS6h6ucfbrSskFhIdAchmzB52QBs7J4lh0pQSJK85EWAux6BgHAdTFIaHEqvEYb7ih8uAY1U/FCpA362vTT+iMBYdHiL5S6g+/0sTe0/3SxUvsBWSmExLQtZt+XHGZn8rrsgKX2RUvaI5E16MfMl3b41/WGb+PUoiMe47WP0W21UjX0EMeUazPaoxfAVIo3tD49RzQ7I1CP6M8Gnx+r4QV+hjzxlNd8PT3dG4A7y6FY+VauPku30C4Ne18g6DH5bY1abEU3Pio0EjL2mEPRdAePX7zvanM4DX8hkMZWrT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(186003)(44832011)(5660300002)(6506007)(110136005)(316002)(54906003)(6636002)(53546011)(41300700001)(8936002)(6512007)(9686003)(26005)(66946007)(66556008)(66476007)(8676002)(4326008)(38100700002)(33716001)(82960400001)(2906002)(83380400001)(86362001)(478600001)(6666004)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y53bNp7XspSmXrAuUZsWNLuFHSgwIycBwn9Cpo/9NJQu/twnJA7+Ai20LZEW?=
 =?us-ascii?Q?MPG3WF1JhU7hIXpV7CV1X6ATpVfNfFtx3WiJPkj/jc/hBUN1tjjRDyRP17rW?=
 =?us-ascii?Q?Tbsb28b/UeQCy34cMk+X7ZBeUChc+HsZEH+8JfN1IUnENTGgwofM147Isuy5?=
 =?us-ascii?Q?ekLmrqt29wdtotK620G50byDfU4zfrFjhrVhipAyX952PYByAmOCQv63sTIU?=
 =?us-ascii?Q?CB84UfFNVpcM+w39w6FOlMfxi1h8iFkk7ipQApj+SXmyzTAeyAAB+N0QzHYs?=
 =?us-ascii?Q?ipkcq5CosICIBHFQJDbm4GNHRzZ9MtGvYDf3KUYJiS4Pt/DjWhWNyvRBFEHo?=
 =?us-ascii?Q?+SkvhZ6TNseGMJ80P+TtocJzty33UUthuGsmHQ7aAH6sVKCG0vRseCf81Mwo?=
 =?us-ascii?Q?trjDCUDNmDqGlZaI3RaPZCPuCTIwzSBEU8oZA28TMuDvPGJy4HcL2FhJzUE6?=
 =?us-ascii?Q?Fm8+1Z0eSCoi74Vs9aeI/MhMBo9KkAkK4TiyynARlGh8e6xLO4GtXB3dh71E?=
 =?us-ascii?Q?iXxLcV7ZtiSs2KoRKLDauM62zx4SBcm1wzmk9p8Cyh1QkWatvHm4K1OuZ/AH?=
 =?us-ascii?Q?P0GdU5QAwSvfOTn2DTXsvA5Y+msVmJdyO9FFvmkXM0/g0nDpB4nSWVjq5sk8?=
 =?us-ascii?Q?eeRMgLNC1OLzbZDXI1THfOkL9EIHOAGuxT5nY7dnr3pmc+pkuFD6nVBn+UTv?=
 =?us-ascii?Q?6/ERc2efqHecQdSeb4Y2Bhp99wuTTYu7DRZUpzfQCVP3mlMP52OLFoCdMZv/?=
 =?us-ascii?Q?tn9Y6Xs0hBMo3+UptB8tijE3Kz/ULtDHGTCPoGDCjP386MJkl9yWJuCcmSoW?=
 =?us-ascii?Q?kDtSErYUibdYw24NvbsnaYJmWA8E7LETQlT06ttj4CbLT2Xyg3y1B0ukPoPu?=
 =?us-ascii?Q?hGb7Jp9ePdJhIEvY34GikiXhYdAkNVRPInYq8dsba8bbSzzGHo5BV9Ju2Zs2?=
 =?us-ascii?Q?ZVE7D75Rij0MRMk7BqPfan7jpzQucmP1gpR7vqrlPKT7fctKUpbplGUCgUwE?=
 =?us-ascii?Q?cylvJLu8w8hyTSCQJzC3ZrHW/+Xm6wed5C/juSzbe5qJkr2LOJCiom6d4Maz?=
 =?us-ascii?Q?hNlfe1Z63Qrd2ulCKrhVthw5CqB90MqbIW75UxKGfaKVu/Hj+KXCQFZ3TJbU?=
 =?us-ascii?Q?nbbEgoN6TUt0C0EnMz/Xwmv7UrYcZZ32xIsMJTlRENBJpQJ6rdEj/cwX5Cip?=
 =?us-ascii?Q?32Hc2mD+RKugZvlvjx5JRigmkrocLFbMeLR+kkmOJG5jZcAQqIgE9lyqvj+l?=
 =?us-ascii?Q?EPzPOsqxzK7/nlZQX69YTkozA4+19Oik+lV845zpZE3UnOr+TDYVDkB6365u?=
 =?us-ascii?Q?1toFXmPERNwKtDH/dqcbaLu+frzF+B9Z/aj/phy5hTMNrOFZrZE5eqXABPJD?=
 =?us-ascii?Q?WZZP+7l7Kod1m98ulqNZuJDa/+OjVyGZiA4T0b/q62BVCxzJLeG92NWXMu54?=
 =?us-ascii?Q?oVFaQnU7tDFseLiu/uXNIMVDN5Tr1RU6h4CV3FQ6oNitOv1BcKJNBac8RzG1?=
 =?us-ascii?Q?jL3ysUwzj4u3zysAjZiTQUQyaLF6ovmac3Ye13HE8Iu/5CoDcZx0rYWGZaak?=
 =?us-ascii?Q?fQnqcmKI+i/sNjJPWf5B6Ebj3Kn40zBWnUAn5KW1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 969fa182-8a3c-4c47-bce2-08dac8772895
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 08:38:53.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyZlwafu6d5Zpkbh7KxbQQkTyjfhVmy7O+azCUlVaK1tDxCPYgzomZoQvvkyU2xW8kjY1QJMYjRrA+HGx7kkkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4605
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:03:07PM +0800, Sun, Yunying wrote:
> Hi Feng,
> 
> For the "tsc fall back to hpet" issue, thanks a lot for pointing me to the fix proposal patch earlier:
>  https://lore.kernel.org/lkml/20221021062131.1826810-1-feng.tang@intel.com/ .
> 
> I shared this patch set to our customer yesterday. 
> Just got feedback that customer has verified the "tsc fall back to hpet" issue does not appear anymore with this patch set, after 24hrs stress test on 8 servers.
 
Thanks for the testing! So your case is a real case that current
'nr_online_nodes' check cannot cover, which Dave concerned about.

Thanks,
Feng

> -Yunying
> 
> -----Original Message-----
> From: Tang, Feng <feng.tang@intel.com> 
> Sent: Thursday, 17 November, 2022 14:47
> To: Sun, Yunying <yunying.sun@intel.com>
> Cc: tglx@linutronix.de; peterz@infradead.org; paulmck@kernel.org; longman@redhat.com; x86@kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] clocksource: Print clocksource name when clocksource is tested unstable
> 
> On Wed, Nov 16, 2022 at 04:22:21PM +0800, Yunying Sun wrote:
> > Some "TSC fall back to HPET" cases are seen on systems that have more 
> > than 2 numa nodes. When this happens, in kernel log it has:
> 
> Hi Yunying,
> 
> If the system's physical sockests number <= 2, I would suggest you to try the patch https://lore.kernel.org/lkml/20221021062131.1826810-1-feng.tang@intel.com/,
> which is still under review and discussion.
> 
> Thanks,
> Feng
> 
> > clocksource: timekeeping watchdog on CPU168: hpet read-back delay of 
> > 4296200ns, attempt 4, marking unstable
> > 
> > The "hpet" here is misleading since it prints only the name of 
> > watchdog, where actually it's measuring the delay of 3 reads: wd-clocksource-wd.
> > 
> > Signed-off-by: Yunying Sun <yunying.sun@intel.com>
> > ---
> >  kernel/time/clocksource.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c 
> > index 8058bec87ace..fac8c0d90e61 100644
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -257,8 +257,8 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
> >  			goto skip_test;
> >  	}
> >  
> > -	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
> > -		smp_processor_id(), watchdog->name, wd_delay, nretries);
> > +	pr_warn("timekeeping watchdog on CPU%d: wd-%s-wd read-back delay of %lldns, attempt %d, marking unstable\n",
> > +		smp_processor_id(), cs->name, wd_delay, nretries);
> >  	return WD_READ_UNSTABLE;
> >  
> >  skip_test:
> > --
> > 2.17.0
> > 
