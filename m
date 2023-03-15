Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E0E6BB5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjCOORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjCOOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:16:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32976A0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678889803; x=1710425803;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lA3O49d2WIXDyEJEq+YmPqnkFw8xX91M+vZBev+iVxM=;
  b=Lvz5J1N37i5O2k4XoFI0kgvoqeaFMYwDTcfivZgxjP98H8Wt80SwlY97
   my7rmTX2nT3o1fkfc3wJRPCHXKPFxyyNR4jOgIzMOL7miv2ZoZFvlJRI+
   EPKFxWcRO0ujmibzJcIZ2OgIfgSjB0LcDDvUoQqTUjR6bWxHSBir5GWR/
   zezCGvih/XSTUFCeAOy8/TS9GVZiDHYnJA97asprw59g69ePeLlrjP8tB
   7+ROEqTu4FxQZcEv+kKv5WM2dq3wYXv85hcW787Bx0k5Bd7/3N8565nV+
   57wlz7UMH9Q8T//NUe3u1y0CegZS3Am3yX5Rqm7Cu/QkM5wzql/ZR4934
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="365395831"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365395831"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="822785007"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="822785007"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2023 07:15:01 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 07:15:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 07:15:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 07:15:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X77kxav54Ga5HVnF38SfdpsvnJCUSTTcXGXeecex99fhXG5AEQNgGkAaclNLkQRD74t7YjuVEJ535hUGpVbc7303+k42zT2MN9ZDgP6bYIDvPtJixGsV4BEolW/3Hpg9FPqvRnKLm1aAvjOP/PEujSnv+tt55Nf5Uhb8iakahbK5whuknMNJTCU+lcxM6xzx/LDB0VVZjC7oA48JiptLeBdR17ZVu9cSvL1K7Su6tyfIBgsSFOEW3wjd6gT80PbBD7rTfEk7OffyCJJwdoQi5JAQqcTsbF8r3rZvZrlZ3yoMnPNDmxOTEMSJRxQbU2wzjqQycKPd+EGrANtVKP2DRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2o+r35JZid62Q1hYgZatGJRMUce8RD+ksvJvVCNl8o=;
 b=aE+3b3DlIZ0mWo3lDhAPbxoCffzrkFp6KNOP9yuS5BksNLXc39wjTfEcR6lLXd9E4YKSRm5dpbzfmRn+mRY+Cgp8u/vFOVqi8OaRIQFokehVRbLLlBmoYmCW/o+7Qd2yYHIMaDQjKcRk97mkKr2bjEE9gWWLoqp567j2Ebk9PxCg6e8WvyoVffkFz4yNvfFq6vnk452c/tBDisfkAP+gdG+mHOzYXCPU9Ueml0C9+JETUvpcLsTmV0/wtQyPhTCGZk0//rn1aD+fzA/rB1QrYBNYCGKodBPL0NDRu28geUJiexQBFBrx72I33pPYXzn+oFZiBgyuy6zSUCq37tun2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB5517.namprd11.prod.outlook.com (2603:10b6:5:388::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 14:14:57 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::4381:c78f:bb87:3a37%9]) with mapi id 15.20.6178.024; Wed, 15 Mar 2023
 14:14:57 +0000
Message-ID: <2a3cfe80-9403-9289-cf14-b88b31000c0a@intel.com>
Date:   Wed, 15 Mar 2023 07:15:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/split_lock: Enumerate architectural split lock
 disable bit
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
References: <20230302011946.211696-1-fenghua.yu@intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230302011946.211696-1-fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB5517:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a6a9a8-fe12-41db-7241-08db255fa7d3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TEsf/SkTYcLSUwTQDABS+4CkV1MQKZew1QStB1WyyMAJu7qgDjP2p9gwgVPAL1OO2Ubz5UCAo/kfq1tdRUZj+Db1fMQkwBOVEAQvYjRZ+qSmLI5ttjlQpO7e3QkzKEF5RyoLCqhoUk+lmRUK2lehhjmwRHbmJ57VE2vJ9VWzjj3lwL6PVheB7tTpb1pQSKVT4cAAayvF/P2M9E4WoDUGHNVK9o6ppY8M0Mhx/bobufCjdZMptKZZs/loQOcaZBvhrqsiXHR0gHvbH5ZYNxiYi0LBz4kYVrtK0mjwnqmjB7EK/Raj2mOUPa6w01evysjwU1jAAHWekCMXoRe6HRQ/j8pctG2o1p9qfR46UkGEI6RED5wH07lpQCeX7M1UtunvFBOH83w8Ok7atms5PO/fQID2bN2XokBKPTi/9Xmsq3v+ChnzwLHd6LanISpJ1ykPbY6Vr4EMfUQr6voRiytrmEEU4tU/6CPhAWOOhyhsYONgJzOUIB9Xp5teaWYa59RNrNsOcbOK/ZK5jVU8E5CQKrEGraK1WlV6nMOOxOwoIpZnIu6Q1Hrj2aFXWNeUin4ExVfpzi/qlBTL7Mu+5JpkmxjMqKvC3tiEIv3C8MigzwfBRYvjVYjYJE9m2Y/QQ6xKPX2zyYMRFUIuFxGk5e2wFLXTDWn45EYXKiSxu5DWry7z1Aw6ZhIohdJmzAlVsH604V/iEYLbluPrd0HZbBekrDuiX+RNsWDgkn/iw+wEjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(86362001)(31696002)(36756003)(82960400001)(38100700002)(66946007)(66556008)(8676002)(66476007)(4326008)(41300700001)(110136005)(8936002)(478600001)(83380400001)(2906002)(44832011)(2616005)(6486002)(186003)(6506007)(6512007)(26005)(53546011)(6666004)(5660300002)(966005)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejlXMzhLRHRHbE5lVEFOZTljVkw2ai82RFlYaDlHc0ZEdFJqVlBzVGpDOEE4?=
 =?utf-8?B?QlBYbG5LZk85aXFrenlnemVkTUVkditrb2RGMC95dmxYbWZLVGpRTHBaVldn?=
 =?utf-8?B?ZjNyaFMzeXo4c1hOb0c1a2V0MzBITE0ySTRwKzljZkovZGNyakFhaklYVGJu?=
 =?utf-8?B?QUd4MlJ6Tm5GSjdxY0NzTGNJcG5QaXVZWWdyTUx1WkhKOCt0djBNcURlbmNr?=
 =?utf-8?B?TXk5REFTK0JkUlJvOW0yVWFHNjBuY0RoOXhSdlhTL1lZUzVlN0s4bzR2SFF2?=
 =?utf-8?B?R2dNeGpiWkNaMWdYMHpoU3J0L3NjdHpQM1BMMmVrTit3dC9YUG1KY2YvQjlB?=
 =?utf-8?B?TG4wZ096V3lENGZ3RDJZNWpxNlJuenM5RnVHMkdIOG9Za3NZYnNIczcvYU9Y?=
 =?utf-8?B?NWFoMU9kZy9BcU9ZN0hNY2M5a2NBMk1RTko0RUw2K2d3ay9EZm0wajA1T1pM?=
 =?utf-8?B?VVpSemZVSzc2OWN2QUZ4TUZUVURBSXdBeDZLdXVQV1NnTUFkM1FNYmlEUjZt?=
 =?utf-8?B?T2xpMTVTcGltOXU0SG15WnBVQXI1WGo0YkdjbktrUVY1S3UxWk9TZG92eWNy?=
 =?utf-8?B?N3pEYURFaDNraFk4MzEvS0M0citvLzU0V0U4NFB4NVFXeXNvajlJc3B3MUcy?=
 =?utf-8?B?eWVsa05GWThTMFk2M3VNenlWbnlDRjhvZXVRQzVsQXp2WFBqR0RLZkY3Tkdn?=
 =?utf-8?B?enhreVU3WEEwZ3YrWjl6NlJxK09GS3ZvVnRwSWtBalhIRjY2Zlo3U3dIUGtX?=
 =?utf-8?B?RG1yYlFGYWQyTkRrY0xDcTB3RjhleXAzK0lPcm5DM0ZDOGI4b0g2dkFaNEhC?=
 =?utf-8?B?bWVmbE5lYUptMHJySjVjWDVzZ1I5bGdvZXIwbWI2NVQ3bHcxcDhWcERWZHV5?=
 =?utf-8?B?bjlKSEFOakd4VzZxSGRyRVlLTXFYa3QvZTZSckR0eEpLWTRObmxVSGRXZ0Mr?=
 =?utf-8?B?VjRONGl4VHhPemJPdGVaZnlFVzFwekxJNEVPSnVKYzFybUV2ZUJvRWJIRVZr?=
 =?utf-8?B?Q2pOU2pCMHFJK25La3EzV3VGeURXQXpnOGlyT0pMTGZjZ0l0SnlodlpFOWF2?=
 =?utf-8?B?LzlWOTZBZHR4Q1cyWERGMUVUbDgrVG5qUXNvZ1RvMWVBa0ZtTi9oSDhnaVdu?=
 =?utf-8?B?MVo2OXh3RndkWG1xZ0RvbUFTWUlkSTBndFNhVHorOGRuaS95Z3Qwa3JsRlU5?=
 =?utf-8?B?S0FJQmc4TnZqbVFtTnFqcVNFekRMcUR4SGhkaEVBVUFRSTAvdHlBMjhXMHFm?=
 =?utf-8?B?cC9lVHJ4cXBVZWhVdTdCY0hEdW1zbFJ1T0RWNW5RUFNjN2dmZFJDOTUwUkNF?=
 =?utf-8?B?dmwzZEJVZjhnbS9EeWk1cWFxcmVWeFc5VU02dWs5dlNnNzVOUExVZ0xWTnF2?=
 =?utf-8?B?N1F6M1FMTXE5emtZUWo3YUtqdCtrNzI0WEZyL3h1Mzhva1E5NkFzb2JDNWZC?=
 =?utf-8?B?TW15M3JxU01xdTVGSEZ4ZXRndlBIcDZGVm4vZ082emltZElBOGdySkhWTEdX?=
 =?utf-8?B?Tkt3K21DT1JjK0dnOFY3YTJVN0lRMjlvRDh1TC82SVRsWVZqbXYrcWVHeUZ6?=
 =?utf-8?B?bzNVY01YRUJVeHpudW01T09yc1BTa1VtRDF3bkQ3Z1o2VE5QdlRKYVl3QTdH?=
 =?utf-8?B?dXUxS2JISUc1ck8xOHVMWHZWbW9oZHdVOHFNRE5hQXVXeGxxaWJIZWtrNjdo?=
 =?utf-8?B?ZnI0V1lKbStRSzFxV2tleW41cU5XbVR3UDdhTGpHRUhndlpoMGRsQitINXc0?=
 =?utf-8?B?THg0QmxTOWhDR0F5cVNsbDVCOFdNcEdEZGpjYllTYXRGbWVTVndnc01jT1Ux?=
 =?utf-8?B?QVNDTnF3ZVlNcjZvRTYzeHdCdmlhQVZuSXJDcWZiSjFIbnY4WGEwcjFtOU01?=
 =?utf-8?B?TG9kVFkzbVJyOXVpWXBNL3hjUWcvSzBZdjdQaUwzSk1IaGhnK21vWXp0bmhW?=
 =?utf-8?B?WXJhZDBOaUtxUEdoRGNlNzkwdkt5dVN2L1lOaVo0L2xTcTMrWFMvaFpjeE51?=
 =?utf-8?B?T2REV1FrRE0xS3RiQ2d6ajJtODJOT1FqcFRkeEh0TEhlUGxwcWJxMGhTVkFJ?=
 =?utf-8?B?eTgrTzJYbzErRXY5d3hKdHhFazcrZ2tZUVViZElCeldqZzdCWHBkWVdNWW93?=
 =?utf-8?Q?ajeDVpRb4ETjBU9weM1vivSlt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a6a9a8-fe12-41db-7241-08db255fa7d3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 14:14:57.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVmUPOO2RpRIU2wh+pLxy5Gq5VmjCQqULA5Ux8v9CIl435Sxro3+RLsrW4nufc8iaMEAU0a7dWWR3VZ6H8vu2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dear X86 Maintainers,

On 3/1/23 17:19, Fenghua Yu wrote:
> The December 2022 edition of the Intel Instruction Set Extensions manual
> defined that the split lock disable bit in the IA32_CORE_CAPABILITIES MSR
> is (and retrospectively always has been) architectural.
> 
> Remove all the model specific checks except for Ice Lake variants which are
> still needed because these CPU models do not enumerate presence of the
> IA32_CORE_CAPABILITIES MSR.
> 
> Link: https://lore.kernel.org/lkml/20220701131958.687066-1-fenghua.yu@intel.com/t/#mada243bee0915532a6adef6a9e32d244d1a9aef4
> Originally-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/kernel/cpu/intel.c | 59 ++++++++++++++-----------------------
>   1 file changed, 22 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 2d7ea5480ec3..d27f8973b58f 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1266,31 +1266,13 @@ void handle_bus_lock(struct pt_regs *regs)
>   }
>   
>   /*
> - * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they should
> - * only be trusted if it is confirmed that a CPU model implements a
> - * specific feature at a particular bit position.
> - *
> - * The possible driver data field values:
> - *
> - * - 0: CPU models that are known to have the per-core split-lock detection
> - *	feature even though they do not enumerate IA32_CORE_CAPABILITIES.
> - *
> - * - 1: CPU models which may enumerate IA32_CORE_CAPABILITIES and if so use
> - *      bit 5 to enumerate the per-core split-lock detection feature.
> + * CPU models that are known to have the per-core split-lock detection
> + * feature even though they do not enumerate IA32_CORE_CAPABILITIES.
>    */
>   static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
> -	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
> -	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		0),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
> -	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
> -	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
> -	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
> -	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
> -	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
> -	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		1),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,	0),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,	0),
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,	0),
>   	{}
>   };
>   
> @@ -1302,24 +1284,27 @@ static void __init split_lock_setup(struct cpuinfo_x86 *c)
>   	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>   		return;
>   
> +	/* Check for CPUs that have support but do not enumerate it: */
>   	m = x86_match_cpu(split_lock_cpu_ids);
> -	if (!m)
> -		return;
> +	if (m)
> +		goto supported;
>   
> -	switch (m->driver_data) {
> -	case 0:
> -		break;
> -	case 1:
> -		if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
> -			return;
> -		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
> -		if (!(ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT))
> -			return;
> -		break;
> -	default:
> +	if (!cpu_has(c, X86_FEATURE_CORE_CAPABILITIES))
>   		return;
> -	}
>   
> +	/*
> +	 * Not all bits in MSR_IA32_CORE_CAPS are architectural, but
> +	 * MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT is.  All CPUs that set
> +	 * it have split lock detection.
> +	 */
> +	rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
> +	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
> +		goto supported;
> +
> +	/* CPU is not in the model list and does not have the MSR bit: */
> +	return;
> +
> +supported:
>   	cpu_model_supports_sld = true;
>   	__split_lock_setup();
>   }

Any comment on this patch?

If this patch is in upstream, we won't continuously send model specific 
enumeration patches for future processors.

Thanks.

-Fenghua
