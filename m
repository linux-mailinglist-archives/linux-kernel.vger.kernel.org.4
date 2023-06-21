Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A3737C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjFUHaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjFUH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:29:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A53128
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687332588; x=1718868588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T7AnKJjYbLDfm8X49QddO3M5KOgCw8pgEkCReOOqeb8=;
  b=fFBXmsSEjD11q6aYWGZRyW/aqQj+wO9ijF1Z7mmH9JQG8pOt/lW31lze
   16e3KqE8pvWrLZPh66fnLylaKPvj8tRkGbGhcLN7p22PTI7716B23fw0h
   pNjKdyvv08WtAKKywyDvc1jJZdEA5gGvzSy8igtbP3qncho9TVKLjUR9i
   lSYNHJZHuaLobSGJYPfmufjmZ6sylat5r5zIAYHq4jGGGqmwxLmYrF7KA
   QaGlNczTgVMNZ0TJt3Sv+QQV70hjUiF4dgCdQVf2nYsAUnRUL7V46ayrj
   MURl6E0OYvzuosHu7IKpMKmxS4bowuxLV3jt+p63koN80F+W0XWIbWr0o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="339712326"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="339712326"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 00:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="779742751"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="779742751"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2023 00:29:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 00:29:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 00:29:47 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 00:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWgK1um3mS1ZW9MzBB+8lhLDLAmt7URKV8r5KcrPcFwo7UJaTrUcYXdYtVxnLpX0TLqtR/VFC5ktLhi8ypHhUmL6A0ZC9nn5XMJWCt/5fTlGhezAhbeY5t0x87kb7Xht1I2MgaXcDfZhKhBnJrzsmzVZUIINcvTZvvzloTIJOV5qGHrFd6IopQpNbYwS9cV436BQpHtxro+HXFO1YVWNp0oUOyYVNhK3zLpdGxvEXdp7L16AXdvJycb/Rq9eO0u/43m6oDDhM1PIbjIXg8OnEE2XJwcP9iPgm/LIyl3Q/tE+0aBkBCsXt8QkboPU/zeP/lCD2XDGi0JEEGYsb+FwdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca9wwjQQ8JDauQL5kYApnSHv9deArYHkIX8ZiW6V960=;
 b=EqJfrT20nTRDBeD2/yUFyILAyP1CyZEfsX8JphMQDmnPMqUjk74oA+L9NZJihC+6VYw8VNjNCm19R3YnbWTUxMSvzhsUEa+cx+r92t6wuE50uPZiRhaqL9QXnkQuiHNu1fB+jFqLuaz5J/v6YdaYrOur0nRsV/YOhLcdxK9K3gs+f+6NoImrSKS5AJ/kzhWMFMhhjMcW1TipwNW+3yx9Q0n+al7qML9umvJXnLe2w9KEyljW6D55dOF3Moel7STY2f7Mp8FkrYUKbaUW09Gaq6ouzPliOtwVcua41wvfk+b7/6G4vmB4cSn1j78TFseTGRsqQI9o5gdQ5mPe05r5Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5072.namprd11.prod.outlook.com (2603:10b6:a03:2db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 07:29:45 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 07:29:45 +0000
Date:   Wed, 21 Jun 2023 15:29:27 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        "Yicong Yang" <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZJKm195gy7X80wjm@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
X-ClientProxiedBy: KL1PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::18) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: b07ef4c9-f18b-42b1-a5d9-08db7229493b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWiJCpLVSSNk08NifiQn2sHI/XNyUrLuj0Hjopj7y0jTlwbufscSTtdF+ui5r3G/FfB26R1hc3Rs2nnMrX1bwe1soEGMcIFxC76mtzqKyme0+9L15zRPwungLQhTYwy7rr52CRds2gxqU/0h5DeZhbmILVYJK/wlU6inVepdhJpjJTXbs9+PsLNqoau/B+63jDC5ZekMoXYhOHJXcmqx45EpqsleC5AkwY5hTkPTWJjsl8pj3fsVX1q2QG2I5k4PLmOPCUR5BRxKOIuvPZ0x3Aj41nE0W6NmQGO0+eL6bhtVEs4jC79JAAIQm/26Mx05YaXUfapqnJLJkuu5wzH+90b8ZqH+4E1gIwnqCdjCKicNhrxXGpSJWCkNT6K1ddfCZ0Ky2c/n0Mghn+78RnP7tp2QckG88JPZoB3lh5JBMbO2m1lXomkXPlZNIREVyOompoUxCQltV2fex2H2QrnyDTZnb1N7gyP9NveYLa8q41YudCB4XFaQJ2rlGc9XoU7GHJr63/hujhALCzCnRv6f2LgNIZ7JYTH/o7tQHDerJPhQtgWCORShZWz/r4U5a5MN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(6512007)(53546011)(7416002)(5660300002)(66556008)(66476007)(41300700001)(8676002)(6916009)(8936002)(82960400001)(38100700002)(86362001)(4326008)(316002)(66946007)(6506007)(6486002)(26005)(2906002)(186003)(478600001)(54906003)(83380400001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZjmWxCDSAb0JbNkfAYilWYlAIawUnGU2sDK6gWaUzlu9fIbw7dEebB0jPYVw?=
 =?us-ascii?Q?j/NDLgbcBlDZf0Nv/gh0ENGYHSiNq4vSSSdNcGR/pcjWUGEv6oJiamxfSDiv?=
 =?us-ascii?Q?qMkeAslXtsQxiEgtYw6aCWhK8OvZRwj48UMO7r+s9ovEtZu9zfpIJW7voY29?=
 =?us-ascii?Q?76u8pgVEeI8LhYAV6i/tWXYuhg+h/M99+mFsSFVCWG9g9M51jtAbt5Xk3UHR?=
 =?us-ascii?Q?GT2uZeeBZCNvVDz4COYAyHJWoAVgqxIh+Wq7k5yoPsbu+hIvxE9M/DbUeq5w?=
 =?us-ascii?Q?NBCSUVtxUfQkcpQR0giTrdBCEXtkAYEJYaDniml1Ih27aCId9zyQaRuA3qmJ?=
 =?us-ascii?Q?LuJ1Hrv6d09gQfBrh20O+RNgGPUUSuwZWh4kcROiMALUMRxcF59hu5Sb1uom?=
 =?us-ascii?Q?I9vUkqD6RYyEWFGuUim0Uzk7K22XNTlBj6swTDDjxTU/YjB9hw4+XPZykIZ1?=
 =?us-ascii?Q?U5NBx6MU7fsg8XLhtjnr62wyuHH3pAUoz+QBRLkB52ncwGr13zFscmf8gDCM?=
 =?us-ascii?Q?xB1m+KS6XnVlzfGtut8SntpQyZnQNGBrWPGX2otiTSRNcXvl829WHDqYTyO6?=
 =?us-ascii?Q?fML4aKig1W80q+WZH/XhJ9YOx1UIcClGGcHKkaWUu4k2KeTiJgiJFxoIMSWC?=
 =?us-ascii?Q?hYtpgpkY/lmUxjKBOmXI6+RdDeZ4pyNqsP50Yt7jp4IJSpZbeUwmRt510lZK?=
 =?us-ascii?Q?KHxeq0shNwr7/aNH+myN6VHWZMPguIh7dM4VFHzobyQZIpMiskt6Fxw+pi8a?=
 =?us-ascii?Q?jE79jYBbCNJA2gcShtYQO1HajPnFhXlvh2fh+1to//FnUdERzEASh325Dg4I?=
 =?us-ascii?Q?DNcW/k+DsjNr6FpGsptAaumEInbft5CfMDN/B748o/1r+LzGWuXCebWIQvD4?=
 =?us-ascii?Q?euU3d/rPTOEIC+cdeyQKaB90wReu5mPApDn7uqVu96eQnuo8SzrBW7JqlCWF?=
 =?us-ascii?Q?yvfjgfiJ76QEOo5MlISUMVzL50KbtjlX5IFYTgl/23nghP2FI0Z9XqMJ771b?=
 =?us-ascii?Q?shbTm7l0o9ah3s4Yc5A+B9XuSgVxmrSnhgZPJhjT6ESijkFyXhI1Pn+FkgvH?=
 =?us-ascii?Q?aNAY3T+7QVeIQGOwFR4dfohi2+kyj1J9ykz3nCUxdF3Ziv+/Z0CsxQkgvah2?=
 =?us-ascii?Q?D/WshDLEi3CrXCdZ0akeVC9NIgkJ5tqiO7DD/3T0/4K2v4A3EeO+lBnswdQ9?=
 =?us-ascii?Q?4DWse+oirniEo49KlK2K+4YrLUItFfb+o08QgV+ZmNXN4+aTwntl1Pi112YP?=
 =?us-ascii?Q?lqO9DnhdmadtMcwXiMYDv0c42EwdQauQWHosgPLKMfXXoe7r2J4e0zx1OsV/?=
 =?us-ascii?Q?GjjT9W0pUdHHkXGTFjoFRMFJakoYSQHSOOLDVYP56SJg5HhZK7zsP+QvZFnX?=
 =?us-ascii?Q?zYgpku2kMmfHZEBFzAh2FqXdDaRDPayk+K+hy2hELQpmoCEXJQkxK2FIo5VP?=
 =?us-ascii?Q?v39wTdpYHSWMSh/FfcyspUJwevaGM3rM9qkh5TiSG/+wwlR1R5kyaaBoaUnr?=
 =?us-ascii?Q?Y1LvGtSpNX9tu9tpIdFsxgFmrzmsFbrWryrxGt2klGEp4seFNE16OqLjvuQd?=
 =?us-ascii?Q?xweS+mYUsXyTIJy3T/QZpt2trPm42VoYb70NVayl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b07ef4c9-f18b-42b1-a5d9-08db7229493b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 07:29:45.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaQ8SPVldWrDlY14GYsLL54iYVI+79DbP9obHlIdZ1eW2llT6UEKUqI5yywDi6oWgQvXD0Nn3KzWNG04kDeJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gautham,
On 2023-06-15 at 11:31:07 +0530, Gautham R. Shenoy wrote:
> Hello Chen Yu,
> 
> 
> On Tue, Jun 13, 2023 at 12:18:57AM +0800, Chen Yu wrote:
> > When CPU is about to enter idle, it invokes newidle_balance() to pull
> > some tasks from other runqueues. Although there is per domain
> > max_newidle_lb_cost to throttle the newidle_balance(), it would be
> > good to further limit the scan based on overall system utilization.
> > The reason is that there is no limitation for newidle_balance() to
> > launch this balance simultaneously on multiple CPUs. Since each
> > newidle_balance() has to traverse all the CPUs to calculate the
> > statistics one by one, this total time cost on newidle_balance()
> > could be O(n^2). This is not good for performance or power saving.
> > 
> > For example, sqlite has spent quite some time on newidle balance()
> > on Intel Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs:
> > 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> > 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> > 
> > Based on this observation, limit the scan depth of newidle_balance()
> > by considering the utilization of the LLC domain. Let the number of
> > scanned groups be a linear function of the utilization ratio:
> >
> 
> Is there any particular reason why this is being limited only to the
> LLC domain ?
> 
> On architectures where the LLC domain may not be so large (POWER9/10,
> AMD), the additional cost is usually paid at the higher domains where
> the number of groups is greater / equal to the number of groups in the
> LLC domain and where sd_span is pretty large. It would be good to
> explore avoiding the scan cost on those domains as well, right?
> 
> > nr_groups_to_scan = nr_groups * (1 - util_ratio)
> 
> If we can extend this logic to higher domains, on a Zen3 1 Socket
> server with 128 CPUs at the DIE domain containing 8 groups, we can
> expect a significant reduction in the time spent doing
> update_sg_lb_stats() at higher utilizations.
> 
> util_ratio     nr_groups_to_scan        nr_cpus_scanned
> ========================================================
> 0.9              1                       16     (-87.5%)
> 0.75             2                       32     (-75%)
> 0.5              4                       64     (-50%)
> 0.25             6                       96     (-25%)
> 0.1              7                      112     (-12.5%) 
> 
> 
> On a Zen 4 1 socket server with 192 CPUs at the DIE domain containing
> 12 groups, values will be:
> 
> util_ratio     nr_groups_to_scan        nr_cpus_scanned
> ========================================================
> 0.9              1                       16     (-91%)
> 0.75             3                       48     (-75%)
> 0.5              6                       96     (-50%)
> 0.25             9                      144     (-25%)
> 0.1             10                      160     (-16.7%)
>
I have an idea to limit scan depth for newidle balance for big domains.
These domains should have CPUs higher than/equals to LLC(MC domain).
However it seems that in current kernel only domain with SD_SHARE_PKG_RESOURCES
flag set will have the shared struct sched_domain_shared among the CPUs in this
domain. And this is reasonable because the cost to access the struct sched_domain_shared
is lower if the CPUs share cache. Since ILB_UTIL relies on the sched_domain_shared
to get the scan depth, I removed the restriction of SD_SHARE_PKG_RESOURCES
during sched_domain_shared assignment.
If non-LLC domain's sched_domain_shared is only used for ILB_UTIL,
the overhead should be not too high(only periodic load balance would
write to sched_domain_shared). Here is a untest patch which shows what
I'm thinking of, and I'll do some refinement based on this:

thanks,
Chenyu

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 67b573d5bf28..ce7ffbb7b3f8 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -82,6 +82,10 @@ struct sched_domain_shared {
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
 	int		nr_idle_scan;
+	/* ilb scan depth and load balance statistic snapshot */
+	int		ilb_nr_scan;
+	unsigned long ilb_total_load;
+	unsigned long ilb_total_capacity;
 };
 
 struct sched_domain {
@@ -152,6 +156,7 @@ struct sched_domain {
 	struct sched_domain_shared *shared;
 
 	unsigned int span_weight;
+	unsigned int nr_groups;
 	/*
 	 * Span of all CPUs in this domain.
 	 *
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d724215826ae..34619dbb2f4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10162,6 +10162,54 @@ static void update_idle_cpu_scan(struct lb_env *env,
 		WRITE_ONCE(sd_share->nr_idle_scan, (int)y);
 }
 
+/*
+ * Get the domain shared information of dst CPU.
+ */
+static struct sched_domain_shared *get_sd_shared(struct lb_env *env)
+{
+	/*
+	 * Do not consider the domains smaller than LLC because those
+	 * small domains have low cost on idle load balance.
+	 */
+       if (env->sd->span_weight < per_cpu(sd_llc_size, env->dst_cpu))
+               return NULL;
+
+       return env->sd->shared;
+}
+
+static void update_ilb_group_scan(struct lb_env *env,
+				  unsigned long sum_util,
+				  struct sched_domain_shared *sd_share,
+				  struct sd_lb_stats *sds)
+{
+	u64 tmp, nr_scan;
+
+	if (!sched_feat(ILB_UTIL) || env->idle == CPU_NEWLY_IDLE)
+		return;
+
+	if(!sd_share)
+		return;
+	/*
+	 * Limit the newidle balance scan depth based on overall system
+	 * utilization:
+	 * nr_groups_scan = nr_groups * (1 - util_ratio)
+	 * and util_ratio = sum_util / (sd_weight * SCHED_CAPACITY_SCALE)
+	 */
+	nr_scan = env->sd->nr_groups * sum_util;
+	tmp = env->sd->span_weight * SCHED_CAPACITY_SCALE;
+	do_div(nr_scan, tmp);
+	nr_scan = env->sd->nr_groups - nr_scan;
+	if ((int)nr_scan != sd_share->ilb_nr_scan)
+		WRITE_ONCE(sd_share->ilb_nr_scan, (int)nr_scan);
+
+	/* save the statistic snapshot of the periodic load balance */
+	if (sds->total_load != sd_share->ilb_total_load)
+		WRITE_ONCE(sd_share->ilb_total_load, sds->total_load);
+
+	if (sds->total_capacity != sd_share->ilb_total_capacity)
+		WRITE_ONCE(sd_share->ilb_total_capacity, sds->total_capacity);
+}
+
 /**
  * update_sd_lb_stats - Update sched_domain's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10170,11 +10218,17 @@ static void update_idle_cpu_scan(struct lb_env *env,
 
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
+	struct sched_domain_shared *sd_share = get_sd_shared(env);
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	unsigned long sum_util = 0;
-	int sg_status = 0;
+	int sg_status = 0, nr_scan_ilb;
+	bool ilb_util_enabled = sched_feat(ILB_UTIL) && env->idle == CPU_NEWLY_IDLE &&
+	    sd_share && READ_ONCE(sd_share->ilb_total_capacity);
+
+	if (ilb_util_enabled)
+		nr_scan_ilb = sd_share->ilb_nr_scan;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -10192,6 +10246,17 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
+		if (ilb_util_enabled && --nr_scan_ilb <= 0) {
+			/*
+			 * Borrow the statistic of previous periodic load balance.
+			 * The data might be stale and it is a trade-off.
+			 */
+			sds->total_load = READ_ONCE(sd_share->ilb_total_load);
+			sds->total_capacity = READ_ONCE(sd_share->ilb_total_capacity);
+
+			break;
+		}
+
 		if (local_group)
 			goto next_group;
 
@@ -10239,6 +10304,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	}
 
 	update_idle_cpu_scan(env, sum_util);
+	update_ilb_group_scan(env, sum_util, sd_share, sds);
 }
 
 /**
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..8f6e5b08408d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -85,6 +85,7 @@ SCHED_FEAT(RT_PUSH_IPI, true)
 
 SCHED_FEAT(RT_RUNTIME_SHARE, false)
 SCHED_FEAT(LB_MIN, false)
+SCHED_FEAT(ILB_UTIL, true)
 SCHED_FEAT(ATTACH_AGE_LOAD, true)
 
 SCHED_FEAT(WA_IDLE, true)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..98bfac5f7836 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1023,7 +1023,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 	struct cpumask *covered = sched_domains_tmpmask;
 	struct sd_data *sdd = sd->private;
 	struct sched_domain *sibling;
-	int i;
+	int i, nr_groups = 0;
 
 	cpumask_clear(covered);
 
@@ -1087,6 +1087,8 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!sg)
 			goto fail;
 
+		nr_groups++;
+
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
@@ -1100,6 +1102,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		last->next = first;
 	}
 	sd->groups = first;
+	sd->nr_groups = nr_groups;
 
 	return 0;
 
@@ -1233,7 +1236,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	struct sd_data *sdd = sd->private;
 	const struct cpumask *span = sched_domain_span(sd);
 	struct cpumask *covered;
-	int i;
+	int i, nr_groups = 0;
 
 	lockdep_assert_held(&sched_domains_mutex);
 	covered = sched_domains_tmpmask;
@@ -1248,6 +1251,8 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 
 		sg = get_group(i, sdd);
 
+		nr_groups++;
+
 		cpumask_or(covered, covered, sched_group_span(sg));
 
 		if (!first)
@@ -1258,6 +1263,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	}
 	last->next = first;
 	sd->groups = first;
+	sd->nr_groups = nr_groups;
 
 	return 0;
 }
@@ -1641,14 +1647,12 @@ sd_init(struct sched_domain_topology_level *tl,
 	}
 
 	/*
-	 * For all levels sharing cache; connect a sched_domain_shared
+	 * For all levels; connect a sched_domain_shared
 	 * instance.
 	 */
-	if (sd->flags & SD_SHARE_PKG_RESOURCES) {
-		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
-		atomic_inc(&sd->shared->ref);
-		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
-	}
+	sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
+	atomic_inc(&sd->shared->ref);
+	atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
 
 	sd->private = sdd;
 
-- 
2.25.1

