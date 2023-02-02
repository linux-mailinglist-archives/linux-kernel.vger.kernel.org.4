Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B96688B20
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjBBXtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjBBXtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:49:14 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF62659F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675381752; x=1706917752;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KUYINCnm8QC4SCx6enojf7rnmepVDqMaRCvq43iFD1E=;
  b=j3zg2cMdDwlbrCJwrivrKw66QuN/rzYPoyiho4CJff1joZKp3oIQuV7u
   SHgj2WEBKZi4LHlORE6kZkKdAA2xR4s5fcMwRm0NT+3fasSb9T2mV+UVF
   og9H445XO/DJ0lw3VntHa3iaOI6wIkWSzOPUOYJ/WcaqPmkLltXBr5Ufl
   WP4333drgnmrULHyhZMmbhfHRxxtpHDmgPArFe3AWs4/Vn7uagfVvG8Hy
   z0DuUXc7FCKf7z1gyGrJyosn++6uixE5coGRJiCHBTO/mLjIQsnBbbuIw
   5dbgeKLS+nWRELBwncnU1KP/p1klYhOCosUFnmLTS371hGG2SecdnHUn7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="327251183"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="327251183"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665509422"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="665509422"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 15:49:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:49:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:49:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:49:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk829Dt6ZullPulFjW7P88S8+N1mU7Z8vNpj6ODMf/06UpUS7HzXD1I6hebfra1RK8TUMzF4C6LW8sZkeVhvJtmCnYfT8VpUshASFnLjBOdvCKgo0zBgyYdly59pmsvxdygPUKVduu/ob3d80KtTQ7Fnj431l+eSoFDm7EsdFo2PQE7u2fN712m7zZZf1TI0oure8UtU6aDluesHNUDBekgPJV0an3nyqDnwLVqSFi+3Eq+tEuM6dSuA4in1fUSfDYMNBg3MEQWC8gtXBCHFXlsKcnhwAibl1nSvEF3d7A/fyU8N9bVdeoDnGhPWZI18Lb4cvB9jf4S6iBHi6QCY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94mTax8ETT09JsxN9Fuyvnwtsw6Pw0dIcMieVubM+S4=;
 b=TU0jTO4WyoOChePZ3ze2KN1iHNmCQClzPOJxeD2KFPYgVKjkAoFjyWVGu1/OR33Pr4J2fG26YC2nRHNblO8PU475YgkSNk/0yYxB0QyQyo2m2nbwIz23ayszkPVqpJk/SMM0NI88Q4Y51ck2y9KrJXx6VHayJhUYFV07S2wquvsJjHeULEZwzSvT2ep3nN3h0jKaWAiY250rHPoZ7rN6VdpcrarpCT15EbqmO6yHvd+KipTAUViH4WWjf6xHt5MJKVGNUvlpSGyj1qshSHZ04/a75TPLl1y0D2+95dzm7dbhY9c2G9MhYNPVULUHey5IYO9GmOrzGvKiQ3bbcIvQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA1PR11MB7295.namprd11.prod.outlook.com (2603:10b6:208:428::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 23:49:08 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 23:49:08 +0000
Message-ID: <ab71c33e-f1e3-63be-ac83-685d11c8b4eb@intel.com>
Date:   Thu, 2 Feb 2023 15:49:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 16/18] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>
References: <20230113175459.14825-1-james.morse@arm.com>
 <20230113175459.14825-17-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230113175459.14825-17-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA1PR11MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d4f2d7-05dd-44ed-f273-08db05781362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Di1pDwtaw+dbj+m/yxWim6Iw44SBejoQpYp13tfktYH67MzdkWVaeyCB/pJnK+MJVajtNBKa1M7eqQq3ayZKBaQlhiMy35yhpn3WaSMz9cHxvFTymRyxJU/lEjLVxEYYCRX3WRPsJNuAzov75XaD6Mldt2SgiZRhGyvYZyffviAAoS44UPNWDc+dEUwY+KXNEKtRrGKuSaZnYkHM1sPqG6lLyxh2QS2sIVKgJhE2Sm4b155u/wWifqS9ls7bDun/jVC4IlRj4vaHwhatOgcIjRyVoREAuKpeAH5XUfZzKLP33IXOMIGFrPbfq9LH8hkFIofB+sIx1XS7lORig0dwNSzRLEgt0d5toikoEJNulRWV16BgnXQSj+StXTSflgK5X7C+GH8wOWujBRDRsDJUlg9Q2QuYuVkTvib3AHrn3FYpsRyhNFtzTFOpx/WTLA85H9j6iYSPZtkE9r4SLAxM4HfSBFAr20HsJK2o5eBHnnLwMr8X0yxD6HBunStzLbtSZyuTe8UTFG9U5F7CIUHhvaHMVH8Q/67kQhYVhICdhmFEaCrxl0ysK3UbFW+ViNa1MD/If2ckWpeb2JHxGOgl+As3y4D35yVHl/iWotMqCFTwsAUeT/2vRuSTx4htq1n+Pv0zfQ1y8NJVJdgfzNFTGIj7Voq6KiDvX6amhvMW8PMN63D6QYMWq6kLopk/oX5kWxFH9TyjHWO4PfRUurWMYyzszmbAo5K7fO7ET2OST+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(36756003)(86362001)(31696002)(316002)(82960400001)(41300700001)(83380400001)(66556008)(54906003)(26005)(478600001)(38100700002)(6506007)(6666004)(53546011)(2616005)(8936002)(6512007)(186003)(66946007)(8676002)(44832011)(5660300002)(4326008)(2906002)(31686004)(7416002)(66476007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2dYcjdpMGRCK2M3bFc0RDdHU1REWkVVNUJ5bWtEWDRFa2s2ZUxyY3lNc0RY?=
 =?utf-8?B?L21PSS9ueFJ2cW9aTlQ1SHZQbW5PK3hnYjYwTFlZOTFUaXRPM2xTTVBSbEly?=
 =?utf-8?B?YXpyYXhYenpHdjFVbVJ0K09xRjVjUFZXRHVybkt6cHZ5TXNjVkxFUiswTDVz?=
 =?utf-8?B?RkF6N0wzMlhhdGJ3UXlBRlRzbTJ1WGdSOE5UTmlYdDYvZ0VyaFNGdndCaGxk?=
 =?utf-8?B?NlFkMGFIcVNPSEJtNUMveG1mVHZrVU9xTE5RTkRlUXJXMVVLU3FuS1ZZaUs0?=
 =?utf-8?B?V0pUQ3MxU3hVcExFbmwzUmJyb2xuSnZoRHZCMkptbEoyd1dGSXArR2pLd0JV?=
 =?utf-8?B?ZllvZWNkekVCaFdrRDlMT3JvVWdXZWczdDdtWE9HTlNQa3N5bFQ3SG9DV3FE?=
 =?utf-8?B?dm4xYUFoNElpeVIySWdGNEs1Umxwam5rTlNYOGZtZHRNUk40Y3hSWW91TDFr?=
 =?utf-8?B?WGRMMjh4V0R1Q2s5bmFHSFBwYi9BdXE5bmFFeFZSYW1hNWdGb2xPRmV5RXpy?=
 =?utf-8?B?T3BlejA3UmdsYzBXZ3l1ZHh0TFl0Vm9Bd3A5Q2JYNVZxMkY1c2d6NTczeExL?=
 =?utf-8?B?bkRGbVBPR2lZT3ZSMUpYZmNuYlYyd1oxNkxWTEJKUmZpZjF0RkJIWitscGFm?=
 =?utf-8?B?T3o5Q1FxTTJOWFYwdFBoRUpoaVR0Y2ZNUVh2KzB2RGNZYk0xTlZydGVFY0Jp?=
 =?utf-8?B?bWVCci84Vno0a3NHSWttQVNBS3p2cFJ4ZFM1UGRWdTVIanpCblFZUmYrSjQr?=
 =?utf-8?B?R3pPdHg2dGUyRitYaXRYcUVheGZnc3ErZkxKVVJHck1zYmhxaXdXZzVUbklZ?=
 =?utf-8?B?QkNuSE1KbFlBOVFzVXVOQVJEVkR6bGE4VGh3ZTRKMzJtOUgyaDdjWStNK2lK?=
 =?utf-8?B?RkVaUkEwY3NQcFBFU2xOeUttZjM0VmRQbTlwc2F1c1RQb1UvcFhLandBN2Ni?=
 =?utf-8?B?aTZwRzU0NEppb0pxWkZLNjJKTEpzT0tTdkxSL0h3NnptWHJKVFJCelMzRFlQ?=
 =?utf-8?B?bzUwMFpmdFh4MEZmMDlRWUhXWHh2VE8rcnliakxDMWYzY1NTN3VyaTVaL013?=
 =?utf-8?B?WmhtdVNXbWRzODhGZDVUMTVYeXE0THgvRjFObkJYWEpRQWREdEhUc0JYSktS?=
 =?utf-8?B?U0paV0hxYUtzM0YrMlExRENuNTZvS2t4N0lsN1lUdHlobWp3eVJvV05PZHk0?=
 =?utf-8?B?bzFHK1pzQkFsSEF5OGsxOTVDV3Vsb09CRXkrbU1hbDB4elZ0cm1Ld3crWnZn?=
 =?utf-8?B?VjQ1N0puc2IycnFNYnIwbnFSenZIY3U1Nmh2OFZHOGZUdXc4OHE5YTR5S3dh?=
 =?utf-8?B?RTBXUzZTZXl1MzRhNVk1WC9ndEdFYStvUGNXbU1MVzdaOVV4YWNGRzZ2WjFh?=
 =?utf-8?B?S2RiTVhiMXYvbVhidnQ2cFN1eVNkK0srWUlTK2RjdENCVWVRSFozck9TQzl1?=
 =?utf-8?B?aUM0UzdqYk9jS2lBQUhNTndTV3RoNVQwckVWek80MWxNdmNtS20rc3dHNnhs?=
 =?utf-8?B?RXpBcGZrZE1DWDhTeVRVdStNVnRIMmlXS0lXTDh0dVJaT1RWRExMNVA0UVlh?=
 =?utf-8?B?K0hDRkZJMFNtdjU1YjFZRkM1bmFhT0cyOFQrSkc5bFkvSVk4dlE5cnJRbllN?=
 =?utf-8?B?cysxZ1Bmb0dyN0tRQzB5L0pwVkhHaXZZV0V1N21XR2JzUkhXeXl2SkZGdzdU?=
 =?utf-8?B?OUc5eU9pOWlRSHozT1Q1TmhiODRvUjdieHByc0lKQWJKZk1GQnZiSTdMK3Fv?=
 =?utf-8?B?bmc2ZjEyWkpJOEpKcHBtaXBvaWNMdkNZZTFySnMvNkZ2WDJ5YVJKaS95UnlK?=
 =?utf-8?B?OUZyUm5CRmJVczRWUGtubkFyU1VKTzNBb0dpNVR3SGNDN0NZNHg4aTJ6NEM5?=
 =?utf-8?B?Tmsxc2FiOUVvS3VaOG0rYTQzOTR4N21OOUpqT2lHaWxqYmdRZFROQlZSYkxh?=
 =?utf-8?B?MzdzdHVzOVoyT0NmWisyQTJML0Fhbjl4T1VoTWs4NHFOSXAyTnlKekZPNGhO?=
 =?utf-8?B?M0FNRGI3anAwc2pObWNXUkx6elF3ZXBtdWF5engyYkRidDBCUEVwMGIzZnBG?=
 =?utf-8?B?Qm1QMEFNQ1pZREFrSnExMXNyK1JzcXJXam13NnA4UXBVaTBSQy84WEJidkZQ?=
 =?utf-8?B?SmdiNmR5L3pra2NBL0pwdk9HWG8xemFJR2ZOUVI3TVR5MjdlcjRoMURDSzFm?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d4f2d7-05dd-44ed-f273-08db05781362
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:49:08.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Up5s3yfyp+A2M6M4wPhZ0220MTEkQ2mNwGUXoM/FI76zOswPfCZvQ7nfFre7REwGfrE0jQaK2QuE1Jfd35bZeiIglxi09FqaefsLvIEZye0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7295
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 1/13/2023 9:54 AM, James Morse wrote:
> When a cpu is taken offline resctrl may need to move the overflow or
> limbo handlers to run on a different CPU.

cpu -> CPU

> 
> Once the offline callbacks have been split, cqm_setup_limbo_handler()
> will be called while the CPU that is going offline is still present
> in the cpu_mask.
> 
> Pass the CPU to exclude to cqm_setup_limbo_handler() and
> mbm_setup_overflow_handler(). These functions can use cpumask_any_but()
> when selecting the CPU. -1 is used to indicate no CPUs need excluding.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> 
> Both cpumask_any() and cpumask_any_but() return a value >= nr_cpu_ids
> on error. schedule_delayed_work_on() doesn't appear to check. Add the
> error handling to be robust. It doesn't look like its possible to hit
> this.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++--
>  arch/x86/kernel/cpu/resctrl/internal.h |  6 ++--
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 39 +++++++++++++++++++++-----
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 +--
>  4 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 749d9a450749..a3c171bd2de0 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -557,12 +557,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>  			cancel_delayed_work(&d->mbm_over);
> -			mbm_setup_overflow_handler(d, 0);
> +			/* exclude_cpu=-1 as we already cpumask_clear_cpu()d */

Please do not use "we".

> +			mbm_setup_overflow_handler(d, 0, -1);
>  		}
>  		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
>  		    has_busy_rmid(r, d)) {
>  			cancel_delayed_work(&d->cqm_limbo);
> -			cqm_setup_limbo_handler(d, 0);
> +			/* exclude_cpu=-1 as we already cpumask_clear_cpu()d */
> +			cqm_setup_limbo_handler(d, 0, -1);
>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a1bf97adee2e..d8c7a549b43a 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -515,11 +515,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>  		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first);
>  void mbm_setup_overflow_handler(struct rdt_domain *dom,
> -				unsigned long delay_ms);
> +				unsigned long delay_ms,
> +				int exclude_cpu);
>  void mbm_handle_overflow(struct work_struct *work);
>  void __init intel_rdt_mbm_apply_quirk(void);
>  bool is_mba_sc(struct rdt_resource *r);
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu);
>  void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 1a214bd32ed4..334fb3f1c6e2 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -440,7 +440,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  		 * setup up the limbo worker.
>  		 */
>  		if (!has_busy_rmid(r, d))
> -			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
> +			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL, -1);
>  		set_bit(idx, d->rmid_busy_llc);
>  		entry->busy++;
>  	}
> @@ -773,15 +773,27 @@ void cqm_handle_limbo(struct work_struct *work)
>  	mutex_unlock(&rdtgroup_mutex);
>  }
>  
> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
> +/**
> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
> + *                             domain.
> + * @delay_ms:      How far in the future the handler should run.
> + * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick any CPU.
> + */
> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
> +			     int exclude_cpu)
>  {
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	cpu = cpumask_any(&dom->cpu_mask);
> +	if (exclude_cpu == -1)
> +		cpu = cpumask_any(&dom->cpu_mask);
> +	else
> +		cpu = cpumask_any_but(&dom->cpu_mask, exclude_cpu);
> +
>  	dom->cqm_work_cpu = cpu;
>  

This assignment is unexpected considering the error handling that follows.
cqm_work_cpu can thus be >= nr_cpu_ids. I assume it is to help during
domain remove where the CPU being removed is checked against this value?
If indeed this invalid CPU assignment is done in support of future code
path, could you please add a comment to help explain this assignment?

Reinette
