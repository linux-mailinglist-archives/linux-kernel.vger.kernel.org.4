Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716366D2BB0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjCaX3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaX26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:28:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F41A471
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305337; x=1711841337;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FHoKWhOnG4mvryw36GKkhU23pPHcHfBJRRPxQi7Vw2M=;
  b=N/BcK0MHOQ3pK3Ls5SQpmxsiYp9YbFMYmbwpkIc9MCmgSYDeP82J4Ftf
   ispc2JRUhqYSgxsTddnS00J7B/waefYD2WN+0Tyn1yw80ZbaZh9WRfELT
   5ge4Gts0JXwQBQeUYnGgTQA2AMS7BllDwHYVXs0ZVRKOAxF3BZAyqUHA/
   5woEJ/KMR95pzB8nSyI6PKVZFeMrax6dn/ORVVsMGL0m3m7ZWenlXXadV
   YroRdSb3XLZcmDkGuFTstv6rialNrHlLJtQ6a63hEMMkbwxdlAevl27iI
   3L3ttiVkQJTaTTHUQVyzTWJF+DkpUX28Z6a0KMjP2Pn5hYSxPMIynUmQo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="427855446"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="427855446"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931350575"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="931350575"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 16:28:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:28:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:28:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJQz4Udh7Kyx2h/UBUsHMAKxejWwBjhMSAXI7mUc50ysbZJtbELF198erIprtRQwgOOkBMpyUH7Z8aJU8k7/GJwLl+mwTIbKT2yCqP3kKTNmdIO10yNOkihHiZZwZpfr6mJoP7eKG1WOe9QlLl9nJTEw7jwMJ08hj1So5MH6rXs7Gas63lvmU+SPXvUwLHLO3IAUtvWrUIHlV5w0FYuLO9CMnwsuBJ1loW53jZjyuKifALeUuUliQJCI8FutxhzlS7cgGhXUY+vicrECf3OYmvVCGA0WLC6l6Ne/gBFxK3YEmLJmYF7JEZtbULloRTSskT/gUFAdlYRo9Vi4UKmQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCoWVvFB6eZ3QOAZItiBYfFsXHIbZemsRuke6WJj5q0=;
 b=Vf3/Mn1/0KIskqoneNM2wAjkkeErMhIlqm2okmfAhuhyrQs5fajNTRoPVSuCggXtyV3kKnr+vdzwTZebuRHaIsHHYnYPlT9hp+zrH4I4iUGSE6ftHAp1AsYEWBGD4xfUPGG1zAusmAfHtVwYuJXV9K3NIQdmK3FyIRzadPufHdMTKGqdX0Dmr3KTUAnhz42J4qe17Qpi1EnBbqUxqwwpuyAJh4dnUjVqbbQa5mnKUa/+MNnGj+Fao9sletQZzWCpNaUqgWNKY0kB1tPlEc49FDJjpgxLPgT1lWb+FZ1AlW4G9hvd84vGw5+l/m9TX0Rcyj1C5ofuRYh4/AGFvMA9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:28:54 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:28:54 +0000
Message-ID: <94b54f42-a70b-498b-ca05-62528a98cea8@intel.com>
Date:   Fri, 31 Mar 2023 16:28:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 12/19] x86/resctrl: Make resctrl_mounted checks
 explicit
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
References: <20230320172620.18254-1-james.morse@arm.com>
 <20230320172620.18254-13-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-13-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0151.namprd05.prod.outlook.com
 (2603:10b6:a03:339::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 199d6115-a76c-4b4a-a7e5-08db323fb118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFLMQzHee+PNOThF4Y57mRR5h6Na46Cj3oIhd0oEXHIOt0vcQgf2qj4BL7Rht1vZJsOh3EomfMNnDDmgrzDmGNop0N0xdIizieknu9YFJNOkDaRiMRWV9b4FCIVzohNqcJDSmRGfyHKNAwlhvo9ruB/XCFojmplawTprbcPDicigG1KOWT4lC1cbiWOKP+bpOxa590flKMXSM+PkaRrXNckS1pH/TaZZZNhEFmOl+hYV4z2RPHDxp4kiq3W0+ONo4i2AXElBv4Ow+X0zwOFR8kEiwnBsaMOxd5Y6JTaITKneJchQfBTtpMAeEY5tZb2zJ6ESivx6cIB0DRj7cTI9Zi4Hbsa+3yl7pepbJ8Fs6pEIuPoJsa2M9EU1nIkANDrdofZwo++Pvi2Kh4+lJe6WqBb8KM6Oa2Yes7xdGUOrM0SFUfZGOjJdQ5OzbLZP6Lk5LMsH92DI9hdgNeg+5BftU1QKlaw87uDoAMSzxhgzhFyB4RDEtHlkme3b4nqx/tCor6JR8OqgbtmxXsaMV99jycNzxrDkenO6PCb5S8SjT2jEGT092Ez8lVjZq5bJz+2t0LJlYvjuKiaA6HnLPOOTgrcwg794mtwdc4LP9wWkLqTOmN/8usX2SNgVIn82kjxjLjC9SQ4X7zAE5iGp8s+MFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(6666004)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(83380400001)(82960400001)(41300700001)(186003)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTl3Mlp6U2habHlaRHlzTERNd2VwcjkwZEdHOXlyWTRkYjI4S3MzR0FTTHdo?=
 =?utf-8?B?V3RZV0lFWXU0THlySWVQVUZ6WG4wV2xzVVhvbEtpMHZwZ3I1bWhlNHplWU03?=
 =?utf-8?B?NW5kWEppNU45RGF6OEJFRTE1SXJGK1NpdENUMWF0NFlkcDVWandsVytRdHJy?=
 =?utf-8?B?cWR0TGR2TXlBaDBGQmlPTmt3OFgya1NNdkFEYnR4bURiMFloeG5NelVRUlUy?=
 =?utf-8?B?Tmwxek9USldmbFdUc3ZnZm8zUEZIdmFYTXBYUHJ5dlBzM1pEM0gzMDJkZHZH?=
 =?utf-8?B?eVAxWE9FVkxscVhxRFdzRDFORUVRRmhoR2dRb3JXeTN0US9qYWVuWS9OKzBm?=
 =?utf-8?B?TFJQcGNmdEdQZlUwZnltL1I1N2FCUUhUL1c0cDk3RFIzNUVUOGRab01JZi8x?=
 =?utf-8?B?cDNNUjlTV0EzYVp1cGVhNU9OWWtIR1B6NGowRWRHM2xmKzRkTnh0b0FWcXBQ?=
 =?utf-8?B?Mk43UVM3WEFqU1BnNGc3MDBCN3VJSnFxOWdLSGwzclBTcUhaRVdmc1RIT3Ew?=
 =?utf-8?B?dThsNUdHZ1FIWXpCOUdkODZnNFQyQ1dLLzY4T1BSVVpUeDZ5VDQ5T2UyOWE0?=
 =?utf-8?B?K3o5anRuZVJTQlpMZEZRR1Y1ejVjTTdRbW4zdmlBNUx1eXpBQytxemgrRTVq?=
 =?utf-8?B?NjdTSXVKNUFTS05UekxzSWVyU0dvT0REdURocnY1MjM3aW9PbHdKNkRzaS83?=
 =?utf-8?B?ajhZMVhGVHAxYnJHeVhCUFNvVlZVdWcvNDhWWlFJWWE0dk9najhVU3MzSERE?=
 =?utf-8?B?dFUwbTFhb1RaZjRndmIwUldUZ2xJVWsrUWdaeUFqY1Vzc3hsUHZ4NVBhQUkx?=
 =?utf-8?B?dTRIV05ObTlQaHRVR1V3bnpNeFZudFJGK0hnVm90dVVXckozWUlQRUIybmhB?=
 =?utf-8?B?NWc1N2w3eGl0NFdxaDBEYmM1amJjTVExUk5NMGR1eHc4UWg0RzJwRTVobzJS?=
 =?utf-8?B?N0sxYlFsb3V4VWJpekN0dzFiZkJLQlpTRGJ6R29NMGkyOGROOTIwUmRrdGdh?=
 =?utf-8?B?NlFkcGhFMjVhdGdOUVRWQWJvOGlCSE1pNlFIbUpMV1IyQ3RiU0dSUWE5L0xZ?=
 =?utf-8?B?dFIwRTVxSHRJZ2lhQ01kbnl4Y3ZNRXhrVDQ5TzQwQW9LWW9QZ1NyK21sUlZv?=
 =?utf-8?B?ZWI3NmU4RFh5cFBVcGVjS1UzbVc5TGtuZEF2NmtCS0ovbk9EcjZsM1NQU1ps?=
 =?utf-8?B?bXFPYnBDRVpmYTZZcUFIWEU4RWR5VWdJNFBYNkRQU0hrL2hrNEdwaE1IRlNI?=
 =?utf-8?B?clpQanFuZldWbldaZUNIamZ0anlKak1YeWQvZmRzMGw1YlpuOWVKSDhVV084?=
 =?utf-8?B?M1o3VW1adXllMU5lTS9uN0JXMDBjQkdkWTR6Zm8xY1BTa2JFaGpCaTVySXcw?=
 =?utf-8?B?ajdPNTZFUk1sb1VUVnpGWlY3S1ZXK3Y2Z1htSTBtNXhpUHZzRDEzYW9kR05t?=
 =?utf-8?B?VjJBVXBYWEpYUVF5OUltMUxjRDdOLzV2THdhTmIwZW1rV2RTTWpKbHBvMWpw?=
 =?utf-8?B?dTdjMVYzenc5dGNETlpuUzlHd0QrUWFzWHlLcTEvWjV0aE43akg0N1ZVblMz?=
 =?utf-8?B?V2QzMzRPcWd0M0xscVh1LzR6WU1FL2FaQ2hiSWhseExTQkZiY0hJN29UMGtn?=
 =?utf-8?B?OG1ndlhqTXBiYS9Nbjh2ZjhpVzhYbkU0SDZ6V2EwM1BtMmh2NW5HSDhEaWdH?=
 =?utf-8?B?OGljM2M2ZFU3T280ZjF1eWlxOFh1bjNHdDAyZXh4aEkxL2ppM3crTGtQclNL?=
 =?utf-8?B?anhQSExxUjRudWZuWVVaV25WdUpCTklJTnNjN2tVQkRSQTZRUktoRm5jSVhY?=
 =?utf-8?B?ZTRlNFBRMmFMTHh1ZmRSRnNoWURNRStPV28zS21EMnRpK2d5dnF5Umh4SFZV?=
 =?utf-8?B?VE5ydjBlZnFsbUhkK3JiTTRvWjRjM1lUMmFXcGdVZndHSUhULzNxVUJ2Q3l0?=
 =?utf-8?B?NHFOZy9uV1RmdWVjSHpGNnpZbkU4RHJPOWVaUnA0bHdqTU91MXlyR3MwYjJy?=
 =?utf-8?B?WFVzL1luUU8wQUJIR2dSQmFHQ1VTd2RERElBR0NzK1BNV3Jqdk1uLzUyT0Jj?=
 =?utf-8?B?MGZZQTVjMjRZZUhkOXhpa3E3UFZFWlJRU2NkSjVoNFovd1lhK2hNR21jNFZE?=
 =?utf-8?B?ditJTWJ1a000cHRHT1Y2UjVma0ppZDNPRnNPcTFFNnJYRWxNSHFhWndBTWF0?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 199d6115-a76c-4b4a-a7e5-08db323fb118
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:28:54.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3Hcu0mhDCYzwpKVD5IRGuGHWaQ5gr5ugFmuL3FwnXt8X/tM7Wr8P+z63xPfM/LAHaIg7inLz2qkZPxeeHJ6a0Aza0zmC0+JqJAyFS8a3N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/20/2023 10:26 AM, James Morse wrote:
> The rdt_enable_key is switched when resctrl is mounted, and used to
> prevent a second mount of the filesystem. It also enables the
> architecture's context switch code.
> 
> This requires another architecture to have the same set of static-keys,
> as resctrl depends on them too.
> 
> Make the resctrl_mounted checks explicit: resctrl can keep track of
> whether it has been mounted once. This doesn't need to be combined with
> whether the arch code is context switching the CLOSID.
> Tests against the rdt_mon_enable_key become a test that resctrl is
> mounted and that monitoring is enabled.

The last sentence above makes the code change hard to follow ...
(see below)

> 
> This will allow the static-key changing to be moved behind resctrl_arch_
> calls.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  5 +++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++------
>  3 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 7262b355e128..7d5188e8bec3 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -142,6 +142,7 @@ extern bool rdt_alloc_capable;
>  extern bool rdt_mon_capable;
>  extern unsigned int rdt_mon_features;
>  extern struct list_head resctrl_schema_all;
> +extern bool resctrl_mounted;
>  
>  enum rdt_group_type {
>  	RDTCTRL_GROUP = 0,
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f38cd2f12285..6279f5c98b39 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -834,7 +834,7 @@ void mbm_handle_overflow(struct work_struct *work)
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> -	if (!static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))

... considering the text in the changelog the "resctrl_mounted" check seems
unnecessary. Looking ahead I wonder if this check would not be more
appropriate in patch 15?

>  		goto out_unlock;
>  
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -867,8 +867,9 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>  	int cpu;
>  
> -	if (!static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
>  		return;

same here

> +

This seems unnecessary.

>  	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>  	dom->mbm_work_cpu = cpu;
>  	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2306fbc9a9bb..5176a85f281c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -42,6 +42,9 @@ LIST_HEAD(rdt_all_groups);
>  /* list of entries for the schemata file */
>  LIST_HEAD(resctrl_schema_all);
>  
> +/* the filesystem can only be mounted once */

Please start sentences with capital letters and end with period.

> +bool resctrl_mounted;
> +
>  /* Kernel fs node for "info" directory under root */
>  static struct kernfs_node *kn_info;
>  
> @@ -796,7 +799,7 @@ int proc_resctrl_show(struct seq_file *s, struct pid_namespace *ns,
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	/* Return empty if resctrl has not been mounted. */
> -	if (!static_branch_unlikely(&rdt_enable_key)) {
> +	if (!resctrl_mounted) {
>  		seq_puts(s, "res:\nmon:\n");
>  		goto unlock;
>  	}
> @@ -2463,7 +2466,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  	/*
>  	 * resctrl file system can only be mounted once.
>  	 */
> -	if (static_branch_unlikely(&rdt_enable_key)) {
> +	if (resctrl_mounted) {
>  		ret = -EBUSY;
>  		goto out;
>  	}
> @@ -2511,8 +2514,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  	if (rdt_mon_capable)
>  		static_branch_enable_cpuslocked(&rdt_mon_enable_key);
>  
> -	if (rdt_alloc_capable || rdt_mon_capable)
> +	if (rdt_alloc_capable || rdt_mon_capable) {
>  		static_branch_enable_cpuslocked(&rdt_enable_key);
> +		resctrl_mounted = true;
> +	}
>  
>  	if (is_mbm_enabled()) {
>  		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -2783,6 +2788,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_enable_key);
> +	resctrl_mounted = false;
>  	kernfs_kill_sb(sb);
>  	mutex_unlock(&rdtgroup_mutex);
>  	cpus_read_unlock();
> @@ -3610,7 +3616,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	 * If resctrl is mounted, remove all the
>  	 * per domain monitor data directories.
>  	 */
> -	if (static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
>  		rmdir_mondata_subdir_allrdtgrp(r, d->id);
>  
>  	if (is_mbm_enabled())
> @@ -3687,8 +3693,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  	if (is_llc_occupancy_enabled())
>  		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>  
> -	/* If resctrl is mounted, add per domain monitor data directories. */
> -	if (static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
>  		mkdir_mondata_subdir_allrdtgrp(r, d);
>  
>  	return 0;

Above also, the resctrl_mounted check does not seem to be needed.

Reinette
