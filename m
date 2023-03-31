Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919426D2BAD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 01:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjCaX2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 19:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCaX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 19:27:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65CDE192
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680305277; x=1711841277;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ruhTtNltdxhphbR4r2YMHH81yerTu90vAzHaBTga12Y=;
  b=AxVZZRmPMeqBd/w/IivDdpPlIKJ2MLfxLtn25E9GmrgufLqI/tbv1oVO
   Yj/2j7GM/tH8RAE0YipI+5DcWQi2q7otoilzmvk2pWfuhNTm02Cquu/tK
   8H/ewU8Mu892sn1Hp0UlfzXyycxzdylAQOV289wGluvRJj5+OE/FtH/7C
   UJHWYJl6j5fOGFHEa6mFY74RyaIJolMG0w2SUbaITsGDj6LWPAbWpdUNx
   vaMU8FxtmV5qyIdi/krLiVTrRGUWQFTs/Wc4NCC6A6l12hjAXxrTUcRjW
   V8vu/5JpOLxTSniEvRjqYTwCI4w6p/FnH/ebiDhZaZYv/BI8dmq06IMOh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404311271"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="404311271"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 16:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="662568934"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="662568934"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2023 16:27:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 16:27:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 16:27:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 16:27:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6SOkglhhRNFfK/IcHYFmgl07xNQkR9boFdoT2pAqE5P/1GqBXTBhVYc+yKvWvfzWnpmm005tVX7nBOl/b7f4iHAnKOL+DOSAbMIYkdKTUzqX5RUvs/QqEbijjSBq+MunlWiKKtZ0gvERTSbrVdRWIzRwl0ceI9Bpef8g2RoA/I5bmDnklr+2p2V2L4DAog0Zp+in4vMkpSMjOUsvwWjheMqZw7sLh/GltQhaHbjbDIhTpN0rGkMSgC19sp0mkkHTLA+mrQZ7PoJLOF+lsjW1FlwMsTINgZGawFPGntrGjAIU3hs75PnqPFmkuRMGADw7wgUWopsqCatTvMhr2IIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITe6UGpY4I6tHaE0nZLNLQKUrQcWHRrimny5QqTYwJw=;
 b=k36IzfBDf0Pj7WMIko0sc9LphGuM7e83jwK6xj+W5KESwPnHcNq+T0WxmKPCsUTvSdGZXzlIHw3YmW288aCtLeVKy5W1VnCRRcrA/t2D70eTiZF08s3bZqBKPhlm8EukM6r+hR0TgEjpipnb74ccRVPgAfApXOo+NZdPyeuwSbSuvZ7oyIe0e74Ta806y/UjrRRRjkl8csgM56OtANRvEWKpUmdJcB9eQHxQUQEnjquH0SHgv0cYq4kqTrhxzo8FOnOYrOIzEUXu9l3YSEapmJF0LzH1aQkZeJRZZ2ux0yiGGoX8fM1kzKuK4/EfRI5KnG8L/2Pn/wT1HXA6FAmI+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH7PR11MB6426.namprd11.prod.outlook.com (2603:10b6:510:1f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 31 Mar
 2023 23:27:54 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6254.024; Fri, 31 Mar
 2023 23:27:54 +0000
Message-ID: <36af82d5-0d48-f899-9e95-1ec89be20581@intel.com>
Date:   Fri, 31 Mar 2023 16:27:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v3 11/19] x86/resctrl: Allow arch to allocate memory
 needed in resctrl_arch_rmid_read()
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
 <20230320172620.18254-12-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230320172620.18254-12-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0170.namprd05.prod.outlook.com
 (2603:10b6:a03:339::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH7PR11MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2917cc-70cc-4db9-8da8-08db323f8d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJwbBNHD29ECZ/dWhrcCm7kx3LJGyvSXbvdrBypzSEPWuyCAx7KGQYkU36kLLu0hibIWc0Vq+HOE7pZiK6/0MM4svmlqTAIn5u/aCsnxrkla0qSlY5lALoJKm5HQGqw/yPhWlIvTDh0nl1Pq8EcyP2Gt1/aEl6dwqo+PghuuvfZPEa/HyYHAC1UkR652q9zMAojyuON+YvYpMt6zU08N+cp+iOvwpxpKjjYrPIpsAmMNEb40iFMNAk3xqXXpW+3Dvs8XbEORXWH4F4Zd6ar9V16lAl0U/BV+7Z8oOl4NT3wuXXLeECjK51U8C6ktZN7vQu/mPYAaFynG6l8mHgMRVYwtEvSqAzBQ9bZkxLHE8ggDrEwhgRw6bV5XrvUTunMmfV1zj/DQOuwuRH9vtmDyZbmJazsYKlq6SwVPauKmvqHybeTeX03wxlxmAgLqqhLXv6XQfcUJixgdNoOdPKDIr5cFfiqqcS2BNR5AgX9EGjd/Ha30HY2rF6MYuhAxCKKbU4Feb5ehTWtc290B8ng4nu7LTdnRVpG1gyCfn1XpKffXcuKwY9eM60WPOLXB4tbkMfhZmvKZjXwAoxXFlQ91/uR1Y+L/pMWgRfEKToYG8dvTlayYdg6rXvHf8XRHrUZ2LPQzjat23bvJRCx+PhSLZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(36756003)(66556008)(44832011)(7416002)(8936002)(5660300002)(6666004)(2616005)(478600001)(8676002)(66476007)(6506007)(4326008)(86362001)(316002)(26005)(66946007)(31686004)(31696002)(54906003)(53546011)(38100700002)(6486002)(83380400001)(82960400001)(41300700001)(186003)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW1JUFVlSnZQTDh5OFBsVHU5ZEFqakxncnZnZHZGQ1RXUkVQR25nMnltbzdB?=
 =?utf-8?B?bFcxNXVROXh1M2tuSFBTb3RhVlNFZ3VDLy9PR0hpZmx0NWd1cWtiaVRqQmtE?=
 =?utf-8?B?a0l0aE5DR1JJS0dIZkp3RUE0d0NRcmNZRnBFSWxPMXRVVUdUZUN1KzNZSDM5?=
 =?utf-8?B?OHZ6V1dSaHBsRnp3VzBYeTJ3N1FLUk1vcWtsNURNMnBWZ2ZMb1BNdjdlazUx?=
 =?utf-8?B?TFV3MGgzb2F6WUYrS3hXK0hZcDhMQi9nMWRJV1JNeFFLcG5mNG9TV2tacGpx?=
 =?utf-8?B?MERVTG1EbEZXRHNXajAxSWZaWk9SajZZWURkaE9UYjMzTytQRFduVW9jZmFw?=
 =?utf-8?B?TzJHM2R5OUZheUJWM3pXYXE4bGZlRmVabktRa1dMOFpkaHFMMHlNSzM0SGE0?=
 =?utf-8?B?WGU1b21oRjRPS0daaGVGam91SUQ4dFoxVDFIeFJvSG90VHQ0ejFaMTFwZmxH?=
 =?utf-8?B?VlFCM3ppMFFOZDg1SVA2dTliT2hDL1FWcFZlMkNDa0ZtTi9uUXpMcEdDYlUx?=
 =?utf-8?B?SlkycTlMYjF6UHJranZxU3JhbFJpc0VMbXlYR1BuUEhISVNHSFJoNXY1Y1Bo?=
 =?utf-8?B?bkU1emphMzV0ZGZIWW5Kek9FVjRSQ2VZajhLbEdwOHNSUXhIL2w1ajNFZWVm?=
 =?utf-8?B?dlhSNGVxdU9ZSVJoREtEWjdZMml6V3VZRERuNHg5VU5VSTRjQVo2Y1Yva3pW?=
 =?utf-8?B?bjBOQlRVR2cwNWo5eS9VVWpEeWZUZ2VOYjh3MUlFRzBMWEZkblArWktCdE1r?=
 =?utf-8?B?WXV2VEVCM2pEL2lSMm01WktBQVBveXJXUjFHQUhWRS9aRFVSUVppb3BGeURz?=
 =?utf-8?B?YURqUWdjU002YldlWjYwMEoyd1NPYlkxeUxRcXJpQUJmb1VZL2l2dlpIRlpD?=
 =?utf-8?B?WVFPaDhOazl4ZTRVVCtzcmdmbWR6WndOdlBYMG1OYXc4SFRNYnRxRFp0SVVs?=
 =?utf-8?B?N3M3VEQ2SVdGeXh1S00xbnlQTXpSOHhtUjNPTElGOVovZUpSOGd5Uk9DWmpx?=
 =?utf-8?B?MHJwNm1OTksrb2MwaXRNUVZTdDNOT05yNFdYeGdrc1UwcGtVZ2sycVFyUUVQ?=
 =?utf-8?B?MGdmT2Qwckp1dXEwSld4R1dxV1lzbitDdW9yUnhZYVY4czUxSVdpMXg1MGhk?=
 =?utf-8?B?L0VROThuSURDWldwaUNhOTM5TlZoWWYyeWFpNHM4M045VHpvdjNZNVVDNXR0?=
 =?utf-8?B?WTAwV2RTU2tkVXVpakFTczVscFpFNmVBc0Q0RG05cEJVejhmZ29WckZod0Zs?=
 =?utf-8?B?SXljRi9ibUFEL3BuYnN0WkRISVpnem9Tb2ZyZlRtWng3em5kUlEyL2l0clJ4?=
 =?utf-8?B?UXZFY3ZSTWdXcjBqVHo2NllQdTF6UEZFNk9KRm8weHE2dWpNTmEybjNGcTFp?=
 =?utf-8?B?TFRNdGlySmFvTytSZStNV2xETksvR0p3djg5c2ltcUkzY2VKU1FWL2xIeXRx?=
 =?utf-8?B?TXlkVkRWYzdtRTNvbVdxNmNJMzRBaWg3T1dqNEdDS1FmNGVQMkxOWEN5ZkFo?=
 =?utf-8?B?ZzRzd29KSFRzckxsaTlXZTVBbmFLbWhaRFdtVFcwTzRZOERXUHVFRzU5SjE5?=
 =?utf-8?B?WGJoSXhISXlwRDIzSEFFWUc1dlpZUFNYWElLTnk3SGxhbWQyOTlWUWNJUG80?=
 =?utf-8?B?TWpjNi9hNVVmbTBkcHd3UnhHTVVxSlFpb2YxUXN2T1RBRHNOdHRDSmRwcWpH?=
 =?utf-8?B?dS9rRERBcllGTjluV3oyTUVDZVpETmtzSHJKNEdHMS91SHV1TVVMLytYOVdv?=
 =?utf-8?B?eUFpS2c4WFNFdUtNaXQ2bjZBZVFVcUszUWl4MkE1NW01MzJoSzgrUmdKQWlo?=
 =?utf-8?B?WWZBV09VYkpoK2s2QjA0UW0vNGlLWm5uZmRBM0ZIQlNTZkt6TzJ2SXN1TnZu?=
 =?utf-8?B?ZmxVZmptZXM3UlcySE5pRTBSQzBJT3JlOG5FOW16aGNQRTJWK3BmeWR2bm02?=
 =?utf-8?B?SGozN3oxN3NlbXl0bHA1MEhVemhEcHBMZEpqM0haaTdFaUxMMlB1Qk9CZ0NC?=
 =?utf-8?B?N2FMTno0R3hsbUs1ZksyQnVjODJXNXFocDBNQkdpOEhiLy9vRGJhRnhKZFBx?=
 =?utf-8?B?cTRKTDI4YmNobmoya2ZnZXdPL05WRmZUM0FkWkowUzYyV0dxMUdBMEZIb2hh?=
 =?utf-8?B?eXhkajBzdjljSHplZmpNOFo2THU3ejhaSTNsVHJmbEQ3ZXdjaTArUTN1Rk5i?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2917cc-70cc-4db9-8da8-08db323f8d96
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 23:27:54.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hcySOubd/Kpv4tt+9SMUWCJnoVTtaufQMB/SFElohP7KKnSWrccocpy0GO4Y9FtrRp3xnm9CU3LjN8rxIDEKtU+mYSdyVDlYUisHOLaU00=
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
> Depending on the number of monitors available, Arm's MPAM may need to
> allocate a monitor prior to reading the counter value. Allocating a
> contended resource may involve sleeping.
> 
> All callers of resctrl_arch_rmid_read() read the counter on more than
> one domain. If the monitor is allocated globally, there is no need to

This does not seem accurate considering the __check_limbo() call that
is called for a single domain.

> allocate and free it for each call to resctrl_arch_rmid_read().
> 
> Add arch hooks for this allocation, which need calling before
> resctrl_arch_rmid_read(). The allocated monitor is passed to
> resctrl_arch_rmid_read(), then freed again afterwards. The helper
> can be called on any CPU, and can sleep.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h         | 11 +++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 40 +++++++++++++++++++++++---
>  include/linux/resctrl.h                |  4 +--
>  4 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 752123b0ce40..1c87f1626456 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -136,6 +136,17 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
>  	return rmid;
>  }
>  
> +/* x86 can always read an rmid, nothing needs allocating */
> +struct rdt_resource;
> +static inline int resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
> +{
> +	might_sleep();
> +	return 0;
> +};
> +
> +static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
> +					     int ctx) { };
> +
>  void resctrl_cpu_detect(struct cpuinfo_x86 *c);
>  
>  #else
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a07557390895..7262b355e128 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -135,6 +135,7 @@ struct rmid_read {
>  	bool			first;
>  	int			err;
>  	u64			val;
> +	int			arch_mon_ctx;
>  };
>  
>  extern bool rdt_alloc_capable;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index de72df06b37b..f38cd2f12285 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -15,6 +15,7 @@
>   * Software Developer Manual June 2016, volume 3, section 17.17.
>   */
>  
> +#include <linux/cpu.h>

Why is this needed?

>  #include <linux/module.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -271,7 +272,7 @@ static void smp_call_rmid_read(void *_arg)
>  
>  int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
> -			   u64 *val)
> +			   u64 *val, int ignored)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>  	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> @@ -317,9 +318,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>  	struct rmid_entry *entry;
>  	u32 idx, cur_idx = 1;
> +	int arch_mon_ctx;
>  	bool rmid_dirty;
>  	u64 val = 0;
>  
> +	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
> +	if (arch_mon_ctx < 0)
> +		return;
> +

The vision for this is not clear to me. When I read that context needs to be allocated
I expect it to return a pointer to some new context, not an int. What would the
"context" consist of?


...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index ff7452f644e4..03e4f41cd336 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -233,6 +233,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   * @rmid:		rmid of the counter to read.
>   * @eventid:		eventid to read, e.g. L3 occupancy.
>   * @val:		result of the counter read in bytes.
> + * @arch_mon_ctx:	An allocated context from resctrl_arch_mon_ctx_alloc().
>   *

Could this description be expanded to indicate what this context is used for?

>   * Call from process context on a CPU that belongs to domain @d.
>   *


Reinette
