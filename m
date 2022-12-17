Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565FC64F69A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLQA7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:59:37 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64525DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671238776; x=1702774776;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NVT/nAE+1SjUskLvKGM4Xnfk8OcR8M0UUXVtrq7MHSU=;
  b=bpOXFXjOLQfqjSqjmZhiJE+Y8sndJRmJZMgnj30gAKv+NtP6ZgnSJ0Wg
   07bjNnhCZ9xMPBEU8SZBTUmiojjwUZf4PafMvd3j4OfQrfNAaE6fHqWn8
   xAdjzjP9yrl54gG6GQhDJBEAmdc758Q9jSVfmxmdSjUcN7bWyyMrJEwQb
   t8i1+MlSvRG/LUzU9XCjVFzJARvS/nJfh5GKR6sciAv/oNRUTzBPXhplk
   fN6eRjJqy1cCZwBPBUys2MNiEcWBsysT3TTSU8G5ErbaAjC/oeyAIw/4a
   LemOq30eTfXRt6ad1ALUVSM7myJh/NGxjYfbNFyPoSlOT6LTJI2VKCWZX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="405341695"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="405341695"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 16:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="824293838"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="824293838"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2022 16:59:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 16:59:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 16:59:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 16:59:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQnd3Zrrid6VzWqlrPvP0KxXHMlyCMPaP7zEz5TLXj6LNysZuNVv9N30fctLzLiRPjjE9vE2RGERZonhGyiNzgZD/PVCEqcNXeA7DpVeDsnVeEDvyKNKy5vyqF8qH8jXd92MFGKpqSZzSl7TgPOFTXWOVtiOVtEwMoeE6uqfYwglZq+dCfhF2FpvYw6QlrEFvyBcA5gYQ4YHGCOkqpsBFjoqDKzhM1ZC7jeD9iRAzsJrW7JxsdGevsBnvcutfomyUxIJ5d+nLIIRQsjoh5eNkC9+29CO/yqUo8+i4OaRD2uvt1jDqokzvziPJVD4mRY51ewxpzUAgT89J8SKmXN08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQpcsFi8mmVnK/oYRIAIxPcIGaHd479FjOC5CdfUq4Y=;
 b=WEa6GZEVjT8q07EU8tyQzB7wQHfjCNb2X620Rj20zGkuOlHgMU3Ql7TU8ERk7chjftCY8m7AOVRoKQ6TG4tRdpx0DctDudcngHz9bOGQ7lsNLteblo86B6LOpgAKwZSyc0j3S2WCHJFq/P1kuo8IldDgDWUn7/tjXwDiyJNuJpvEoHCU2pQAMZ0psHnAqycatIqWJ6jUqy9yt2pSIuR0jaharQCtikMNkDqDQXDgIferk7+rrKlCd9V217lvch9sLNXd8GTnAByiuGeCADHS3ZNoMf2AO/SRZGzIXMGPULkolTQjxhZwpiOcMMTlECfuZZrwo1afLSFMKg0MrK/vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH8PR11MB7071.namprd11.prod.outlook.com (2603:10b6:510:215::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Sat, 17 Dec
 2022 00:59:32 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Sat, 17 Dec 2022
 00:59:32 +0000
Message-ID: <c9bf21a0-3dab-5605-688d-d9de634e88c4@intel.com>
Date:   Fri, 16 Dec 2022 16:59:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] x86/resctrl: Fix event counts regression in reused
 RMIDs
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, <fenghua.yu@intel.com>
CC:     <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <quic_jiles@quicinc.com>, <tan.shaopeng@fujitsu.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221214160856.2164207-1-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221214160856.2164207-1-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH8PR11MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: ca709f80-5fc8-4707-542d-08dadfc9f526
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwdgBsiz9LhQH4xNE9rJqY3s4raMWnB990tr0fXALVy7Ja5jFoYgyM4duzgzTskS8EGSwWAKKZF17fD1T/UYpUj+SojhXpeshJuv0Jdwdu+PX5/HySs2TEeoPluFjTHnATKhBPRXxFRAaxJ0RLs922CkH38MsFZUwkHBUSVx+vhzyhGQrV+v3kJOO2PjCVcuKNMvuzP/RuDJKf5/bINn66DH9R3pPw8uD93qY2cNngIV8NfETs+WvNYi5woJa5iuBsYVMdQ99zggiXj81M22abY0uP/D3o3frjkNkOWBKiRvhjkbutrS0+ZsJpl62ExGJC8bFRnLyCM6JHTeuRpUfcFedLViK/o4qukGpvd6J5AVdYUZ4AVFf0c5lndwoXc0W9PXmLmG+05ag0X3nWS2pY5Vz1LhKy7JGbtMjREM+BL1HH7WHrZeDrH/25AHaaED6JYylzzeQBjLkZf7wMIcPcSWIr+Y2/fbMmumMoztSX9YFcZT3OMCh15kpII9X4YAWKkwwjGl/oLn6PWhLX+b+Hq5pBLhlHiCZVnHnsKUXEFFiowxCzwMqjigKprCrF3yFOLu4cMtY8xmwfVl+IwOlR63xlOZW5Aw5n8aO/mDqtNp58PpJKfu0TxSGy4l4b1y+8spUlii9kSjo0gwSCO/hIL9Sj4rKz27YBMhgqhyvXdZeU9JeJSdZiAgrpaeNe85FzdsoqDW3BlHjpUgw3FaciNnzGBQo9FO/GrlZmXKqAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199015)(82960400001)(38100700002)(83380400001)(66946007)(31696002)(478600001)(44832011)(5660300002)(7416002)(86362001)(2906002)(4326008)(66556008)(66476007)(8676002)(41300700001)(8936002)(53546011)(6512007)(26005)(6506007)(6666004)(2616005)(186003)(6636002)(316002)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZuM1IvdmpLblRVdnlrOEYrV1BvVXllS2F3VWo2WXBmMjkzdWVnMkYvUFVR?=
 =?utf-8?B?bVRQWnRERlY0ZEtXNHFPc0w2M0YvN2ZoQmhsMlhOblFrZURLMGZOdmxFejFy?=
 =?utf-8?B?b2NuZkVhQUQweHc3OHNFL3ZGWTg2ZzdIMWJGck8yY2xaRXZzR0c3TVRYMjc3?=
 =?utf-8?B?YUNZaWQrY1V1b3VNZnNiRHNzMW5FMTlxSmVBdHhPYUQvVUcvM3lYZDRVeUtj?=
 =?utf-8?B?Y2t5K1ZSSVU4YzdIWGhtN25VMzNEMitvb0VVM3ZKMmJ0eCtBcTQvWTU0TjVC?=
 =?utf-8?B?TWRjNDdEQjBGTFE0V3MvcGxqYnNJTVlDb0dtSmlUUEIyWUF2NEUwV2JWL01S?=
 =?utf-8?B?RGd4NDhMMnpkTk1kdWgvRWp5dkdHNVZsdmpDQnZGT0JaY0M1RGY4ek1jV1BH?=
 =?utf-8?B?TWkxZFo5TXNtbU13VFo1b29VUGROUy85WUREODlCSTQ3SkI2RDdlVUZhZHha?=
 =?utf-8?B?L1l2bzZDL0R0NFZtTFAwV0dkWXBud090UnFiSk9tTHp5elFKSDRnTHRqcUJ0?=
 =?utf-8?B?bHJtSjMzbEdrM2svakxqdnZGUWt3c0xNSzVsUmhvakJKNm14WGlkeWVoWlpL?=
 =?utf-8?B?NjZGM2NmUHczY21kN1QyV0ZpTE1KaURyaldCOEN6RzJPc1o2bGV0NU8wVU40?=
 =?utf-8?B?bHRWYnN4V1ZJcXdDYzBpcXJMTDduUmo5T0tIZ1FGYUNYby82MmQ4THNHcUZI?=
 =?utf-8?B?Ukphb0U3RmdreFZPajRJWVA4WjBYSTRRNlhRbVBiSlRlS2ZTcUpINW85Vks2?=
 =?utf-8?B?eU9pbThMSmplZEhuNmgyVzJoT3J1N3B2NUM5VEUwUVdZMGlCMjBYdloyV1JN?=
 =?utf-8?B?NkVMOGdMcnNsWEl4YnRTQ2ZJakt6RUZmZFZFY2RlcUNJNFlEUkFTNXVuMkRD?=
 =?utf-8?B?ZXZBaldQaEh2ZUpqTzB5cWN6YTJDR3liS09FUDhNUWdUWkxmWmRqZmZ3Y25w?=
 =?utf-8?B?Z3Z6dU56Z29Cd0wzZ1F0MFZCdkxlRjAyY3ZmTlVoR0xqMGlQUC9RTzdwQTNv?=
 =?utf-8?B?MStuZ201cG9qcVlEOCtBeStRM0lUZmJoMXAvNnpiMm9RU1RQNFpidnQ0Tk5T?=
 =?utf-8?B?V3Y1SDFRd21QdktOZGZGVFMvRU5WRmh1UGdJTkE2STFpSzVKOVpnRStqMDdz?=
 =?utf-8?B?OFJscm9OTHNvY2ZCaTJRWWxHU29GUlZhQ0h4R2FBMEVnVUtGVjVtbG9pbG1r?=
 =?utf-8?B?VUJBTlA3MERmZHlWVjlaWFVQemN5bElWV2JHQnpxVmlDaDJTZzNzSkc2SnRm?=
 =?utf-8?B?ZytROTU2WExCUjhwZlcwTDc5VE5TOExNT3VROEFnWFNyUlIxSTc4a1QyMEZ0?=
 =?utf-8?B?anFwdzF3MlFxcVczeTZPcVNxRTBCS1NnNjFQWko3OSt3Um5ENkFiTzhvcnVJ?=
 =?utf-8?B?Y2FYTS81Y2Y5U1hDc0hnaWxpelJHRlhqWWdYRko3Qll4OU9rWUFCTHRvUjBo?=
 =?utf-8?B?MmR0YUN6U3lWM3dxS29OcXNiYy9WQ2ZkeXJOeEtBOGdxdC9rQmVmOU9VNTI4?=
 =?utf-8?B?U2N6NlRRODVqL202S2U3cnVKTDl3c1IycHMyK1hNbmZGb1R2WXIvKzU1TTVX?=
 =?utf-8?B?NnlHckt0MVFza1lxWGxwckhiaUdnQTQrUzRQTmlUTE9VZjJEOFRoYkhReGdk?=
 =?utf-8?B?eUZEZmtVby9MOHpVK3ZocWZ3TmdsMi9ROENlZzhhKzNHSEpFd3MvbXdka2xX?=
 =?utf-8?B?QXFTWlNpM3JZMjJiV29ucnVHWVQ3RXNoQ1FSd09PK2ZnbHdwZ3I4VHhIakp2?=
 =?utf-8?B?Q3FHZlM4bHlLNEVXVVpNQVBBZ0x6czcxY1RDdjJnZjR2aVZuMEFwS0dqTU5I?=
 =?utf-8?B?d3FXMndmNDM5Y3Y5UzFNaWNuZ3pWaXRMVFc5eW5xRUcxamphTklHMEZRbzJO?=
 =?utf-8?B?ZmhYOS9TUWhKZEl5Szh5YzFVaXlvSVlySHZQMnAvTTIrNW9NRk9WV2hwR3VR?=
 =?utf-8?B?YnQvTHZ6TEFkWHNvbUhrUWRBdGo0NGZEK1UwYjFmUmg5WWhySkJtUzVnbGFm?=
 =?utf-8?B?dHJ3TE9YREZmZi9xazB0UHRrN3RVSlFLdEU2NllKS3Vta3puWWlzUkJhR2RS?=
 =?utf-8?B?S1RrREc4S01nSjhGMFZaWFdlK29ablIrUHkwbEV1SWMvZHpTRVBtcWZ6SjZN?=
 =?utf-8?B?aU1qN2w1M1BxMENBMFdBSEZVZTFyeS9JOEQ0aGxMUjNqZVBmaERObXBwUk1V?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca709f80-5fc8-4707-542d-08dadfc9f526
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 00:59:32.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezAS97acman0cSKLsAMb1x+QUNZc6RShPmOw0KMRyVyQmeAyDd/XULWcICuiGsZ1eJ7PzjP3gaum72dq16K5FMPxc07jmMQlJLrk0ESLflU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7071
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 12/14/2022 8:08 AM, Peter Newman wrote:
> When creating a new monitoring group, the RMID allocated for it may have
> been used by a group which was previously removed. In this case, the
> hardware counters will have non-zero values which should be deducted
> from what is reported in the new group's counts.
> 
> resctrl_arch_reset_rmid() initializes the prev_msr value for counters to
> 0, causing the initial count to be charged to the new group. Resurrect
> __rmid_read() and use it to initialize prev_msr correctly.
> 
> Unlike before, __rmid_read() checks for error bits in the MSR read so
> that callers don't need to.
> 
> Fixes: 1d81d15db39c ("x86/resctrl: Move mbm_overflow_count() into resctrl_arch_rmid_read()")
> Signed-off-by: Peter Newman <peternewman@google.com>

This does look like a candidate for stable?

> ---

It is helpful to have a summary here of what changed since previous version.

>  arch/x86/kernel/cpu/resctrl/monitor.c | 49 ++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index efe0c30d3a12..77538abeb72a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -146,6 +146,30 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>  	return entry;
>  }
>  
> +static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> +{
> +	u64 msr_val;
> +
> +	/*
> +	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> +	 * with a valid event code for supported resource type and the bits
> +	 * IA32_QM_EVTSEL.RMID (bits 41:32) are configured with valid RMID,
> +	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
> +	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
> +	 * are error bits.
> +	 */
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> +
> +	if (msr_val & RMID_VAL_ERROR)
> +		return -EIO;
> +	if (msr_val & RMID_VAL_UNAVAIL)
> +		return -EINVAL;
> +
> +	*val = msr_val;
> +	return 0;
> +}
> +
>  static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
>  						 u32 rmid,
>  						 enum resctrl_event_id eventid)
> @@ -172,8 +196,12 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>  	struct arch_mbm_state *am;
>  
>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> -	if (am)
> +	if (am) {
>  		memset(am, 0, sizeof(*am));
> +
> +		/* Record any initial, non-zero count value. */
> +		__rmid_read(rmid, eventid, &am->prev_msr);
> +	}
>  }
>  
>  static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
> @@ -191,25 +219,14 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
>  	struct arch_mbm_state *am;
>  	u64 msr_val, chunks;
> +	int ret;
>  
>  	if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
>  		return -EINVAL;
>  
> -	/*
> -	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> -	 * with a valid event code for supported resource type and the bits
> -	 * IA32_QM_EVTSEL.RMID (bits 41:32) are configured with valid RMID,
> -	 * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
> -	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
> -	 * are error bits.
> -	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> -
> -	if (msr_val & RMID_VAL_ERROR)
> -		return -EIO;
> -	if (msr_val & RMID_VAL_UNAVAIL)
> -		return -EINVAL;
> +	ret = __rmid_read(rmid, eventid, &msr_val);
> +	if (ret)
> +		return ret;
>  
>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
>  	if (am) {
> 
> base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476


Thank you very much for catching and fixing this.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
