Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F674DA01
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjGJPha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGJPh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:37:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C195A103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689003446; x=1720539446;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zFp99VeDLb0msQfUk959B0WT503EZZOd87m6Z17H8VM=;
  b=BQ23cLskq3GrRiQiA2cUE6EfYqaVf3NO56dbzbT+Qu/lItt25eVdoeX9
   U37lmzHyLPfZmD8UpEcMxxDbBV5vrDyd5UeCcEvoqbfNuICp1siWaIloG
   wnByXvmIpW/+IH/StEg3J1dgzoMDnzLtegKSMrEkd87M7EDfONHT1vXu3
   5fMT77TVp+pqcH/NN3OnTHvpPQGYBg7MgV7EilGrirT+01AQKeBA+YiqH
   c5Lg9ArxEwTZsieD/WQ+im6ri4GxZIWLbTcaNJtvHXpZu3Nic/VOZzUd8
   Nmt3Rbdx056L8NJnlPpUAPR+noEWgWw+RiGJlbQexWKjh7MPzpGweMC9r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="366951519"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="366951519"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 08:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="714849481"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="714849481"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 10 Jul 2023 08:37:25 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 08:37:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 08:37:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 08:37:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyleNKwMm5wczeKgKOMKuNKS0v/E4NZM51PkHYc49IgWbDuRuBKIgXYNVr0rYyYEUPv/ToptJ/QdibbyoysjW9prMOF/h/PfhbcLTXTrrpmEJ4CuOZUQmd3+Wri9tArMPpJWGFhBMKdaHNDNMOOkJXcr2ttL5Hpo6Dq5xiyXr/Xf6bFni8y4p3xlVOO54AHrehzbtiF3pXdpwlcM821iM+n9gbJ+i77EPK6gionCHz+dVjtEGfR50cMLmI6PMzoUpfN1nJ6lGVebSZ1Kp/xmO9GvB00P6JTAF47l9MKptudO/hKgTRoUB2GMs0m9Q26mHz59Tz0G1FM0Xkvy8FYSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PkIPUKB/qAtE2mKAz9OA8NcPmBLyMEHT3AVVGZcUFk=;
 b=n9H8UXpPfSkuHJJFmxkSmDMvAPqWMBL6Y1ClveL+U+PEoEIMGR50pgciEW0gcyjN7FarcT1SpMYxQ8YCrxnB3TIG5TLMh2caD36oqArKYWoHRVL2DKxql69VxdQP5IJ7DMY1F5rHQgcgx3U9/wI7XgXe3X9ssLDhGb9IOg7/Wufw2eHkFFTx+HlsJgC6/C/ORWDwPCMixhxI3BB1TjoYKAtLKfuCZ/K4+dyKumf/LJ4y2n+gdOfAxuXOFGeha7UmV1AcTGVDeyDHvCB6t1h3R1j2xJzvzZWX1GaeOK6DnvZ7TkxjO97vUt9IMjxItuk+WrSIMrT7wgLBQ5FyfcayUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Mon, 10 Jul
 2023 15:37:23 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:37:22 +0000
Date:   Mon, 10 Jul 2023 23:37:06 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] sched/fair: Calculate the scan depth for idle
 balance based on system utilization
Message-ID: <ZKwlomD5Xez7TRhy@chenyu5-mobl2>
References: <cover.1686554037.git.yu.c.chen@intel.com>
 <bc96b53efb712337a645e2c2a340975545ed5a28.1686554037.git.yu.c.chen@intel.com>
 <ZIqpI0ScCT5pmrAO@BLR-5CG11610CF.amd.com>
 <ZJKm195gy7X80wjm@chenyu5-mobl2.ccr.corp.intel.com>
 <7e31ad34-ce2c-f64b-a852-f88f8a5749a6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e31ad34-ce2c-f64b-a852-f88f8a5749a6@amd.com>
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: c28ee099-931a-4bf0-eca3-08db815b8dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChM2TjFYCQzIPfEOI4AO89bNocYxQOVeFCz2qfwzbwzvh/3qzS4nxY1eC3uUp+VukS1WkNhKmY9rlKuwKG3G4kX2F0Xx2cxQC5IyaDKhfQDte4gaKvA2xMbW0tH2zRlgsgdk+OBoAktMqHMBLm6/R9KbfndPZklpCMhJNz7L6JmFhRv3SSfQwxR03DP1RGZ0GoN2zea0gDFFS+KbQcp5N63rQNw4D4rQYUqMGISBBfknQwak4uDKX9z787Od5lmCxi+n4tNDpqZisLnog2hIctf80MwVL+F1v12qXHTEDOWB/nYnbCHQTbCm62mgKZfMg82+RMhaDxdriF1DamJNvNdu/WHKElq0NZqcnE9evz7F93+gDMmBRx+VzvyyY8Yanl3NSyCSNCOr3MT45bKwS73jV4FQ371o6EmDjIg6BuU2iTnSZvqs+XcIobflAJH/Zi1oQ3BevljxPeamXvWimlQhmtwFaOx8OklVsrUkX43dhB3FKjChpqIJBUeHkXCC01ezEYB8Z4dIYzZMsBS+XC7v4P7HxzKyfp5OS8SxAIc+Fm1WCET3kd2wilys3TjG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(6486002)(478600001)(6666004)(54906003)(26005)(186003)(6512007)(53546011)(66946007)(41300700001)(9686003)(33716001)(8676002)(66556008)(6916009)(66476007)(4326008)(5660300002)(8936002)(316002)(7416002)(38100700002)(82960400001)(2906002)(86362001)(83380400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXsfqb0FgGLweIfh32T74SkSHfSMDTkUGBwX/n2O1vaL+Mp0FgVjQ60lSx+7?=
 =?us-ascii?Q?DghfN0e7mTVckzzyIlZKbbbGhK42xLe/LaEJaJq4A/UMgvtmD7mmwoIlZwIs?=
 =?us-ascii?Q?Cj7e4WzE8zIV+7zSLLuB+dQcjZ/r91n6KJbnNNfdp5eftp09x5/ia9hE3ZPf?=
 =?us-ascii?Q?xZSLYM+Yj7Zt9ezr0zFBxonOqxFoVB1OHfgjxCIVXx+U1UYdKUlu5fmnCavB?=
 =?us-ascii?Q?+vjdOPuWhXlazsWiMpnroqXWuS2OYh54cpW0gO40sDFFvGc7SmF6KqgyVGZK?=
 =?us-ascii?Q?hp0x4Mvetlvg721R0SB8Tf/KBQ9pPIHydNJGNF0Z3EVzwTtmYbzlxhIgSNSq?=
 =?us-ascii?Q?jF3y0A6FBu8qsgbvfkxLYVTw2MufT1QiwGBPxlAUX7bvwUypTmSjRI3BmDUQ?=
 =?us-ascii?Q?HcJwUVaNayHfrzAX9wumnYvKGMRQdPj+Ir6xP1GIG8rHyu1s98bzEIkwL56i?=
 =?us-ascii?Q?nuuNPbJrNqBYzKmlnP2singgfFu+LwvvfaMceG/XvptUGFc1KN2kUSJUKqxD?=
 =?us-ascii?Q?j7dzjNI3/SPs4Jhw2pbsPpdUKjkgYt08nKwCiA4MwxAXwyREqHemwt8sNfTI?=
 =?us-ascii?Q?EC1QGt4tQ7Nt9q9Kzvy+xPji3AS5tZ6DdNUoy0ohoVP75FlY9Bmp5C2lfVBj?=
 =?us-ascii?Q?qAnPpKRJBye4wTJhYWePs1xKTFFB7SZFfFJ/cW9M+x+UM28kbh1y98BDny0n?=
 =?us-ascii?Q?9Q85GknbYQr7s1b623Q2BX8jEq4MDZxRo42vO8TJN39nqGCq1Cv0VfpLDTzd?=
 =?us-ascii?Q?xF7ypeCfiPSNRUhFkeyMVNOxpM1jx6NS2A5Cez2m1WWDUAswDKto3q3qwEXu?=
 =?us-ascii?Q?45RI+U42TUZLRWbVbkLsyIgucfwmAzHjCpSdu8l31KPoIt8pwd8VUi8DqqHx?=
 =?us-ascii?Q?rZBiit4mEdvjvOtQ8SduJIMHK5sFAaZig4MNG8DlqWiKF8bLnfXzpqj6Rr5p?=
 =?us-ascii?Q?Ae+0z02/fn8hr8Yxn5kWUjNIi18ZnJtzODhwEaUUvfTjYrw0h3tTcF6TlAy+?=
 =?us-ascii?Q?5e6hNOVjXZ06hQ96amGnYriWviEdtLLBEmVO418iBk0knz/L1qhPa6uGSNgr?=
 =?us-ascii?Q?eJ217ARSlqzAJa5sPv8XI7MUmda/AoQc8qjDXMpzGnBOIUJdm0QNsXiGFEE3?=
 =?us-ascii?Q?Y+KfcY12s+SDlnc/xTJ6c1eyAjzaP9SrWQwopl0aPNt6uxTZGWxDnmuE/bJ1?=
 =?us-ascii?Q?lObetUwXdagXhl2/clYGX0Se31s061qY8ZFick51UM6xxH09oNfkbZ5nf8d9?=
 =?us-ascii?Q?NRALl0AAiCQXKQzgDosLg325syyoiSSH7YN5iMBQ8Un72Dwzo1eiNSE37LlW?=
 =?us-ascii?Q?2FnfnTiU0gUFR0r7UXF9lMwIn3Lai8YpUitmQlneNjMUEVv8wAxXEnPiZIh6?=
 =?us-ascii?Q?b12XyGv/Ef4t4wikxCoJBf5Wd3XDeseadSJYzp9B4KYDbyfmrSx/MUNhGoYB?=
 =?us-ascii?Q?fioksTK4mxtcY6gKnVt7iTBliHcpfzZEy1APJeqUIsMeniQiDrcsIV2vcGlu?=
 =?us-ascii?Q?Tg6aq7T4XRBNN7eRgZ6JlE11mcel9ITP4kPaejzwMbaTm2c87g3LgrJN0Alq?=
 =?us-ascii?Q?9QoYH5z75jUwiwJREoL1W8cHuCr4kBDM4leDUhcZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c28ee099-931a-4bf0-eca3-08db815b8dbf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 15:37:22.6524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xCDs0N7Mt7KNDfvwBfiHiobQKr3fMQSpQCDwKpbvQRa+Z378sdkVlj4RtgBDna+QfQAvkMrezFROw1+ctNtuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

thanks for testing this patch,
On 2023-07-10 at 16:36:47 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> Thank you for sharing this extended version. Sharing the results from
> testing below.
> 
> tl;dr
> 
> - tbench, netperf and unixbench-spawn see an improvement with ILB_UTIL.
> 
> - schbench (old) sees a regression in tail latency once system is heavily 
>   loaded. DeathStarBench and SPECjbb too see a small drop under those
>   conditions.
> 
> - Rest of the benchmark results do not vary much.
> 
>
[...] 
> I have a couple of theories:
> 
Thanks for the insights, I agree the risk you mentioned below could impact the
performance. Some thoughts below:
> o Either new_idle_balance is failing to find an overloaded busy rq as a
>   result of the limit.
> 
If the system is overloaded, the ilb_util finds a relatively busy rq and pulls from it.
There could be no much difference between a relatively busy rq and the busiest one,
because all rqs are quite busy I suppose?
> o Or, there is a chain reaction where pulling from a loaded rq which is not
>   the most loaded, will lead to more new_idle_balancing attempts which is
>   degrading performance.
Yeah, it could be possible that the ilb_util finds a relatively busy rq, but the
imbalance is not high so ilb decides not pull from it. However the busiest
rq is still waiting for someone to help, and this could trigger idle load
balance more frequently.
> 
> I'll go back and get some data to narrow down the cause. Meanwhile if
> there is any specific benchmark you would like me to run on the test
> system, please do let me know.
> 
Another hints might be that, as Gautham and Peter suggested, we should apply ILB_UTIL
to non-Numa domains. In above patch all the domains has sd_share which could
bring negative impact when accessing/writing cross-node data.
Sorry I did not post the latest version with Numa domain excluded previously as
I was trying to create a protype to further speed up idle load balance by
reusing the statistic suggested by Peter. I will send them out once it is stable.

Thanks again,
Chenyu
> --
> Thanks and Regards,
> Prateek
