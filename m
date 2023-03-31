Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982B46D2BA3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjCaXT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCaXT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:19:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF4EBDCA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680304796; x=1711840796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NnqBBRQf7RJdfNvo9AaMzYq5DwE72qbjfoWnHaJfXsI=;
  b=IBSEKolDr4iNlcbPCdom6++XiqdZEV9PZaiC/K3UxEYc6ufkhUBzQjCh
   0IRwOtuXUVffcj67fzMidzvqYZXeOYP18bb4/viQKW7NVABQwuIl0wUQD
   8InSLg67yJivntRek4XjP89T359bfiorWQ6xdNtgH5rceXEQJEpGPklkN
   wCYC2ca0DYMYKtAXsE5JPOCnMJ8ulEIDLg4tZ30KluhFBqxUyDc064vj4
   cYdVDx2VmqfxbzD4ub0nnkWPHe70z5hlGyTJoYVH68WDSbUNlVHlejdJF
   PKSxP9GDfVCTDZ5bMXkQcl2A1vujBqTBaCNqtrqRNRhzHFuZBKUzfQ1U5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404310231"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="404310231"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="809197579"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809197579"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2023 16:19:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:19:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:19:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:19:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMPDN9DwT/sLLDY9OUMB80SfGUqmt6bBkLbeIP17y3wWXt4CLaMtLKG5BC7+x2KulKU3FvTy5JtuTefXXBjzK6lrlXRJpwbkY1E4WrK8tD6dW0UhbqrMAVxRhJ0ah95NuMmnDFbbGDl/etyuVYyrH5C29/Iy0nb/yLejv6xRO2muWcYKoZrBa7dU942B1hCD5DeXEiHJlcnNl2Yz0OHLaJ/3CRm4zLEOBwint+OQzBWvlPrsfzYryX/ahgm0LPnZWFsIT3ZLnxjmeuX6f5qc5YQU5GGCs1beaSiFBwkRs+DYInsxo4vkv9lmd0IR1E/jl/v9P6Opy4WnZmQHMffcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvfLrS/tXSXIUWPShKkcdFdjhafpmWdUj/gIZeTUkxs=;
 b=dISo3Y9N0tHL2tP4GzS33Ywcxk+K1Zzafi1bPTiTe9PuElMypoVzbHpcrmJEnUnh+i1yN78/LuK6sHBqrAYSMmhGpLvwrVlENz3fVYmI15UCRO6t/MOVud9d1mbtZyP+AmiWFkErFdeNUP4Y5u9to6ViUUWPRNE+ASaKQF+41QfuYVeCqVGDswPj2iTy3vGZhk0SXTb9qrh3XGN938kgS7csptFKc/Q2RxdcdQzShXPl9pE0SXDdKIy40/3Oqu3bRwSLuAeE77jnn5AUWsjvImK46iSLpNb/YU6+XEYtQBkz4CKbhlKn4eqsfGrayzimdB6GO1THPBM1PooCVWpdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4701.namprd11.prod.outlook.com (2603:10b6:806:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 23:19:53 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:19:52 +0000
Message-ID: <3b82b55e-0fcf-1fb9-1c07-6b2cb95f6160@intel.com>
Date:   Fri, 31 Mar 2023 16:19:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 02/19] x86/resctrl: Access per-rmid structures by index
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
 <20230320172620.18254-3-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 88eaed09-9c30-4f3e-f0e7-08db323e6de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtBjC9N8J5T8oG/hws4g6xqaGbwopW/UB/YrbztE1nzzbt3jkGQh+dsPSSn/4EzY7P++WnaDvfdvZUtUmOEbH1QRsg1kOM6zFgOtIR0fdzCdfHgj+OmEK7UKPBUZSZu3Ao+/3vzMI9x4JxmF53zTJXSoajBH2ONiaunqaupgBShUmbZ9dIXw/B/ZtP+f5QQb0iVvRn0wUMfL1DidiEQqO8Nt/g7BiwYfDORmIXGAvSYVpp24RUTLeGWFuhidAcJ4fBzyBuY1QifRM4H0DEYtfj65foXvi5zKWB+sB4JNlPaqje2vfEd8VNIRuNtlEcy1HIWi8QGWb2fmT8GY/NB+9otYhm0tmjJZkuqNN5pZ6didGYy5xXsmn3q16wySzmH4eGvINHYnuYwGLc2qL8ekra1HP7Q8Qm4W+f0oOn3eFUb15gu+rUmTTnEZ51wUTVRe0crwDllsndUwcBDb+HFEgximkb9l48GRRfVZLHi9+Dj8QT81qEfe5QpouXjVjCpsnqvqyDr7hpN6hJeoU++OropdhtzcFcuiTR51p3BjiDf4QXa1F83pIblHyzz8W+mP+j9pSPswhC8TAWuDy5sqKXFeCIMSFLjbkbftK8HISa7AzqIyhkbqgC0Cr7HzMwEUtnp0n++/DT685+h0NOCS7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(36756003)(31696002)(66899021)(31686004)(6486002)(6666004)(41300700001)(26005)(82960400001)(38100700002)(83380400001)(2616005)(186003)(6506007)(44832011)(86362001)(316002)(66556008)(6512007)(53546011)(478600001)(8936002)(54906003)(7416002)(4326008)(66946007)(66476007)(5660300002)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emJCeGttaTRhTnI5YkNpOEhDNWZzS1RRYVA2SW1ncExyM1dnQUdOTkdMaTNN?=
 =?utf-8?B?eDBXRGdQTThydnpPOUR4RDJGKzlGRW1vRmFsU014Nlc1Wkh5eEhsNWtWRGJF?=
 =?utf-8?B?S0RRMkpwU3l3L29Wc1NDWkN3TFg4L0RLTFZhK0xTWFJXbkVjVzhiMVZRWVAr?=
 =?utf-8?B?WTE3cjNuMWlydzdDT01KZHYvVE5JaVNrKzlDelAvTVRueXZmMmRIZUFJZ3Jm?=
 =?utf-8?B?dDJQVGp2MWUydHJuc0JjV1BpME1tb1JMY1djcVZJMjFhMGE2dU5tVXFkUHp5?=
 =?utf-8?B?U3oyemNQaHkvU2ZJUTgzYjhvZk0wY21XUDJEQVJQZFdRNmdBZmxuNENORHBt?=
 =?utf-8?B?TEh2aUdmM0RIN3V3Tm1qQ0VWYm11YU02eFZSMVU5anQ3djI0Q1lmWnlUb1Va?=
 =?utf-8?B?YTh0SmhHN0xBY2s3YXJMSkJjVHNRaEpaQzZjbVJITWdWUjNwMWZzZE1KSVBV?=
 =?utf-8?B?dGM5S3dIblFrSjBQenBvei9NWEdpcm5OTE83K0JFYi9abnZhaURVdUEwaVA0?=
 =?utf-8?B?WFRRTG5KV3hsWVpWcUc0cHozdEdQeFZhcnZ2Rld3SzRHVkpVamxwZTlsbmQ5?=
 =?utf-8?B?Qy81a3B1VDE0MkhmYmF0QnhDWHhid2h6UlZTUmNLeDVraTFHOXFkcVpWNFdL?=
 =?utf-8?B?QUxOd3J1QlZkdUpxa3diRW9TVlF1UkpPMWtPTW90UlRBcE1jUzRnelcxU3JR?=
 =?utf-8?B?ZC8ycWI0Y2JHdG8rSEFTWisyeEZYVEswUXJMcFdkSHBHK3d5WUtoRzJNZGdp?=
 =?utf-8?B?aXl3QnozNnd6bEpydnNGS05SQ0dEWkVvMGdaUUthWHh4UG9tVTN2R0o4UnhH?=
 =?utf-8?B?UVBaTjNGbG82MGhiREVWVzVDV25scHByQjg4TklGRlZzT2k5b3JwTjc2OFRm?=
 =?utf-8?B?WlNqSldKNHhSMis2NityMGl3YjNZUTJHRGNsc3crZGlXMlBBR21IeG4zL2FO?=
 =?utf-8?B?MmtSRWkray96WEozYXZBd3dEM2djNDJCdWlPNEhnSll0YVg3TnNHNTdXYktr?=
 =?utf-8?B?Z2x3L2ptd3JTNHBSbWQxaDc0VERJRHUxNCtqakppekF1VTZ6QmIxRll6UTI3?=
 =?utf-8?B?VE1kUU9DcEpxRm1kNHZQeVZ0d291Z1VGWGoxdURiSEZXbDRySTNKRExVcC82?=
 =?utf-8?B?WmlWVFV3YlhuUUhKNGhqM0JzdEVsN0JJeUhEZnpGZU5BbXV3MUhVN1lTRjhx?=
 =?utf-8?B?SzdjV2hQRXRFOW15NWtueU9yRXo5QUlHd3lHZExOK1crV1dWdjdTb3oxQ0U0?=
 =?utf-8?B?cjVDNzBiSk9vQlJlcndLb0lWUkZnMi92b1NnZG9XeUZweWd3MXh6SUJQRlcv?=
 =?utf-8?B?R2tIa1lOZVBPM21sejhjTmhLUTdheVBSZHhxUGZBTWRYVVE1RnBVRjVtaE1L?=
 =?utf-8?B?Ymt0SjMxcGNwRFhUMFppb3ZhZUlURkhzU3Vjbks0OUoxOEdFcXk1dlRIenBk?=
 =?utf-8?B?bkdGTzExalRNOXFXSVNUYmR2Z1VaSHZhNDZKckY2WlpGdWQ0QUVjbEhTNmpB?=
 =?utf-8?B?UXd6RzNwYVo3NUJXbkVPZGl2TkxHVWREdlNVd1NybCtqb1kxOXZrTllHYUxJ?=
 =?utf-8?B?N0VQRFNJRXEzV05kVmR6OWMwbjk1MTJJeUk0NTZ4ek55WVh3K3ZZaXFoaHJG?=
 =?utf-8?B?RGMweVZRNzhhQ2o1K2xCQmwzWVN1c3BLU2d4U3cxN0lZV0hMM3JrcHBLd2dY?=
 =?utf-8?B?OXpnRkx0NGtkc2cxWXZuYkF3cktkQXB3RXBuVDVReGtQbmpGN2drVmgrakY2?=
 =?utf-8?B?OEZjRGpYOS9SRXJ2ZkdGQncvMnZnS1FObDhva29aQ0lEa1REcHRwZ3krcjM2?=
 =?utf-8?B?RUY5RkNpYnU5UzQzRklrekxTSWFqdTBWT2VPdkJlSEN1MytXS3ZTQWd3aVdR?=
 =?utf-8?B?Tkg4ajg1TUs0NnJOVkhRdmtXLzVPQURTZHhlbTdSV1laMEs5Qk9kampsajVR?=
 =?utf-8?B?bEZ6aVh5MzhHZ29pRWoyRU1Edy8yZTFaWGtUc09WZW1WMThTRjhKdEhsU1pj?=
 =?utf-8?B?V3lBN2FSUzJsN2U4RlBLUjV0cW9SV2pYVU5WVHJPRzlDLzZ1b3dEWWx2bmlr?=
 =?utf-8?B?TzVBL2NnOHdzV0ErM05NSkI4Vldud3paR09HQ0JHb012eWErWHEwa2t2N3RY?=
 =?utf-8?B?QzJEVXVkTUNnbXAxYldLWFpmOWh6TGhkRVVTNWV2TE1SQW1OMWlRc0R5anVi?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88eaed09-9c30-4f3e-f0e7-08db323e6de3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:19:52.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: albOyO691afkzOtqsJcxvUURwtVjvCRs21VZbD1JHE0os1tg3Z476r+cbyUjYyv3euMp2AAspucuF0ZUuGm1IpnFgzoHGXcCaxp6HBKvQAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4701
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
> Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
> monitors, RMID values on arm64 are not unique unless the CLOSID is
> also included. Bitmaps like rmid_busy_llc need to be sized by the
> number of unique entries for this resource.
> 
> Add helpers to encode/decode the CLOSID and RMID to an index. The
> domain's rmid_busy__llc and the rmid_ptrs[] array are then sized by

rmid_busy__llc -> rmid_busy_llc

Not a big deal but since you are using [] for rmid_ptrs[] it should
not be necessary to say that it is an array.

> index, as are the domain mbm_local and mbm_total arrays.
> On x86, the index is always just the RMID, so all these structures
> remain the same size.
> 
> The index gives resctrl a unique value it can use to store monitor
> values, and allows MPAM to decode the closid when reading the hardware
> counters.

When you are switching between CLOSID and closid in the same context it
is less obvious that it means the same thing.

> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v1:
>  * Added X86_BAD_CLOSID macro to make it clear what this value means
>  * Added second WARN_ON() for closid checking, and made both _ONCE()
> 
> Changes since v2:
>  * Added RESCTRL_RESERVED_CLOSID
>  * Removed a newline
>  * Repharsed some comments
>  * Renamed a variable 'ignore'd
>  * Moved X86_RESCTRL_BAD_CLOSID to a previous patch
> ---
>  arch/x86/include/asm/resctrl.h         | 17 ++++++
>  arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 83 +++++++++++++++++---------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++-
>  include/linux/resctrl.h                |  3 +
>  6 files changed, 82 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index cbe986d23df6..3ca40be41a0a 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -101,6 +101,23 @@ static inline void resctrl_sched_in(void)
>  		__resctrl_sched_in();
>  }
>  
> +static inline u32 resctrl_arch_system_num_rmid_idx(void)
> +{
> +	/* RMID are independent numbers for x86. num_rmid_idx==num_rmid */

Could you add spaces around the "=="?

> +	return boot_cpu_data.x86_cache_max_rmid + 1;
> +}
> +
> +static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
> +{
> +	*rmid = idx;
> +	*closid = X86_RESCTRL_BAD_CLOSID;
> +}
> +
> +static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
> +{
> +	return rmid;
> +}
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>  
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..351319403f84 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -600,7 +600,7 @@ static void clear_closid_rmid(int cpu)
>  	state->default_rmid = 0;
>  	state->cur_closid = 0;
>  	state->cur_rmid = 0;
> -	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_CLOSID, 0);
>  }
>  
>  static int resctrl_online_cpu(unsigned int cpu)
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c64097947994..47506e2afd59 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <asm/resctrl.h>
>  
>  #define L3_QOS_CDP_ENABLE		0x01ULL
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 18c37d364030..03a7d13dd653 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -142,12 +142,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
>  	return val;
>  }
>  
> -static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
> +/*
> + * x86 and arm64 differ in their handling of monitoring.
> + * x86's RMID are an independent number, there is only one source of traffic
> + * an RMID value of '1'.

"source of traffic an RMID" -> "source of traffic with an RMID" ?

> + * arm64's PMG extend the PARTID/CLOSID space, there are multiple sources of
> + * traffic with a PMG value of '1', one for each CLOSID, meaining the RMID

meaining -> meaning

> + * value is no longer unique.

Reinette
