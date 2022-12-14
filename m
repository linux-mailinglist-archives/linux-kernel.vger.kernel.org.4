Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5F64CFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239105AbiLNTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiLNTRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:17:51 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886591B1CE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671045470; x=1702581470;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z+Cg/CUw2SP0ojeP/+rnC+1A9xsU4A+XqGCymvuCwS8=;
  b=CN+reiWPRryJ0EEkACqm8EkmNAYAjmY6u/YMUpQlQnSQ7/m5SA2MTsko
   9IaETQ26wN9aUm2BcC+0u5BJTUyvaHnNn4Dxc2gkDmgHNMBpnYOmcC8Nw
   yj+yQY8AjfmPmgMRtaZs2OWUd1DMfjRR5aynpWQWeOX6tDZJH+V6NDV7k
   8rlby5iUCZyyuXYUNMSknoMAD6lOcBsxj2p4E68TWRjP0eKfWOnwNGVAG
   2wOof8dXNZhVyxClsD5uxqHN7liMDH9l6rd6UEkkGe4ouHpwAOElMnziI
   M/tRIA80vnrkdx4aNI+y3qrd5Ukdou48VUhWh2KPzbi28+MSotd2huDOW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="404764104"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="404764104"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 11:17:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="737805454"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="737805454"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Dec 2022 11:17:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 14 Dec 2022 11:17:47 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 14 Dec 2022 11:17:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 14 Dec 2022 11:17:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLYMvfih2aHow1pfs663Rua6xLvMPFQjTL+cIUIMF9pSeKQo0WR30kgPSx/swmrM6cuPcc0fGEGxg0q6TRHxutCwc4PrBQPPGRr1NOQ1HorxtkiqJWlsqIM43iuG1U7S1DsdBkirsjqvdQHqWT3Xrd6sdXiV0LxGMcMFYgaeKhvL1/PC9euS1rJ77yuCGSNejD07STyqx8b/zC74/eR+j4kkM5vwdotPI18biphpJxvggqtskbLOrjAZ62e/7RPTAyNaOxQfHoGJFwkwks2bKOwiHbd1LmE59iO5iDpGvzXEGOJXyOoC1Cpbv8tvEYN/SwqKQ25FuT1RARJOYFrkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qF7JSDMPpWh9MIN7KWXbTg6uVHwgdMqkL0sfPgoSr80=;
 b=GeAlFxQ+mM/QSr1LTKOPlyNxKSjL27xJYHCAZWFEa9vVMBsTaHszFDfCfr0NvLz3mFtjvQQgbarXKFEyYGglyA3Wc2Sk5ZeL0oFDLMIvIVQTfgX+dFcMSh5hqicunite8JOG5K7G3ziNRfyjZbhZqCQSsMXiWZtoX/kvExSaEtKMbObNUJNpSEygs9O2o+H7AfuMquSSAy60G36DeJAd0JzAxQd572zOeYO01rgX4CDOrrtYNYDsyoTOPB9smo20nCasCuUSwpXrgu+41rdycak5NZ5VV+s16grSJrEFQd50BexK7e5zfg6gZD5fRdH+E4Q4qeglS0j8XXLZXlU+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 14 Dec
 2022 19:17:25 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 19:17:24 +0000
Message-ID: <6f0f4c45-039b-ffaf-b30a-d9e2aae0cc74@intel.com>
Date:   Wed, 14 Dec 2022 11:17:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20221207112924.3602960-1-peternewman@google.com>
 <f58e6af2-aa16-9461-d40d-1e4e52ee6943@intel.com>
 <CALPaoCiB-vOuXJYkaLLsxSKHcjT55q1RSNBjhHUWmPL9rFdF8A@mail.gmail.com>
 <74cfd689-3c03-5f41-d01c-efab04ce4197@intel.com>
 <CALPaoChbJNYBXvOwftSxApo_ca6BLC7Ej21cDAaKdj9LOJumxw@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoChbJNYBXvOwftSxApo_ca6BLC7Ej21cDAaKdj9LOJumxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::37) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BL3PR11MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 728f32e0-242d-41f2-273a-08dade07d50c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rx+YWv1NMQXi1DkRTH6PFnGR/m9OmP3G2gzRJ/IXkCZ0mLCTbcEFT748Mv58N4+XJt1wYFR8vHATwkdv2WvxyKGpfoGX8dbE2KUxhjrxXzxHidxYVf+bj31NOiHBdOrkVP7uJkkDsOkkuHY/Z4krxxiwNWt3NTWUYVtTlRxUXhJzP/bEgYIxMtECArJOeSNxoDvDk6hl6dipaM/l+2D094T6w2XskjwWelKk5n1PJ5PMmr6KgASK1IDMfwdPwRmTdSa0ytiiXLlvValj2zysXDChQKNPFb32UTJtIbgU7c1Da9MBX17DDlCWOamJSPduhr0l++UIhKMqUF4uSXths0qBQZmaT1ztln5Oe5QdY1eFES9FFooEiAU1RFrp+0l7mrinIgciVn2id0IMjImuJwX2meEazgcYH47zYrAPbFQGCICFdhv9TSd0IZyn8iWMcXlnBW3xiBNiivjQoE2A/qh3YD2cLtVc3hXD8xYeZbsQHMAzM3UxvWmZZDx2ZViqlFAkmkhhCQhiUe3yJ5ibgOVQsbjsiUCxoxBw1RIb7XTnn5xOTcybZqzC315NlWlRYmLG6yQh6s8AnEkRoEc9Y7QWJZuq3FS0eWLvpIibsfl8by2ChHJzAKIAWxeU+OxaAkUk7iFLPQMoxUSC1EEVS0uMMcGNuI+AbhACKuzESNcpg6FmAprb+uSLscFhDB/4TatTG9/IM2YuGaMmEAXWYUcAbiZARfe+OEM4jW2f2pXfIj+VKeu9cMvY9SioShcG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(2906002)(6666004)(82960400001)(966005)(38100700002)(36756003)(66476007)(66946007)(41300700001)(4326008)(66556008)(186003)(83380400001)(6512007)(44832011)(53546011)(26005)(8936002)(5660300002)(6506007)(7416002)(2616005)(6486002)(31696002)(316002)(54906003)(31686004)(86362001)(478600001)(6916009)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clgybFNvYlRvSWQ2eWZSRDJsR1R0ZUFBbDg3Y0NLSSttcTlJOGVYUjQxZ3Fj?=
 =?utf-8?B?b2RIeXVpK2xqWUI2RVdBaW5PUUxtbDYxTHhrS0FpTkNSNnMzcURPeVg3S0pk?=
 =?utf-8?B?ck9xcC9aNWpGUWhOcHczL3hlQUMwemMzWDZWeityUHdiRlQyd2JjMEQ5dG9Q?=
 =?utf-8?B?d3JvUC9ibHMyTm5TaUg5dkwvUWRzT0tnTDBlRjFnRkM5UG10ME9tVnM0ajB6?=
 =?utf-8?B?U0Z5em1mNDRGd0VmbzRZWUxhdXRIbzJ2MmVNdlhDT3grWHA0bjYxTy9HR01F?=
 =?utf-8?B?Uy8wQmx2Zy93ZG5taEo5UFlyTzBPTHMwWkhOVkU1SWJTMWhaNUc4MmVQaHRX?=
 =?utf-8?B?QmNqbkM1Vk1Fby9sVW05K3IyZjN3MEFPc0dmV2U1TlBpRURwRVRtbGZkbWFl?=
 =?utf-8?B?NWw2YWlYYVJFK1pkYUx4OCtzdDBOWWl5NnZrRksyNGk3VEJrL1dXR2gzekRO?=
 =?utf-8?B?LzN6OHVTQStpZWErZ2k4QjA0RGxPNG9DV0tWSGlDVzVkWmU1aFhvVjZWZ1pq?=
 =?utf-8?B?RzVKRmFIbHBqSmdxTExjSmxPQkZwcDVyZksycXMxbUVIMTMvc3J1dzQzc3FN?=
 =?utf-8?B?eCt1OURJeVA4VnlORS94UTdoMDErM3ZPdm8xNkxZRG9ZTVk0TXV6bGMzOHdj?=
 =?utf-8?B?bHpyV2E2ckpOVGxHTTQ4bW9rNlA2ZEFmRUtMWk5wRnR2NkUxcldhb1lXQ3p2?=
 =?utf-8?B?SkVtNTRXUVE3VzBWSXppQ1NaWGkyS013ODFzZm1CVHJKZDkvUzRISTdGcUIr?=
 =?utf-8?B?Z0VSYmRwT3EzcUNoN25vbVZYano4bkRDY1RxUldxY0EzSDVKNEdlVi91bDdx?=
 =?utf-8?B?djFwMFhNUjJVVDVuSUhDUVpIMHVXZ3JnNy94STBhMXhGd3RwNmNZU2VFU1Nw?=
 =?utf-8?B?K3hmSzF0eWVkN1BPWkJ6RHhYRWpkTTMwMmJUblprR3RQTjNqNFJKQ3BBcHpt?=
 =?utf-8?B?S1IyZWFNZTRjUGlGYWJrT2dIYWI3dlNLNEdIbDBOVUxBLzJ3RitYZVZpdXFV?=
 =?utf-8?B?VnFpY3RkMTJJejNSNis1elpUajIxYjd0ZDlRczRmOVF5RFRUSFE4QnpYMnBW?=
 =?utf-8?B?VXhvSWswN2gxeHpLZEtQSERyY01nM1BZa1crMk1NWjRGSUgxRjU3bTBuSDA4?=
 =?utf-8?B?UTMzUWswOUFrOXlQTERPTE9SMUI4ejVnY2RqK2k5Njl4K0JJWDI4Ly8yY2pY?=
 =?utf-8?B?LytnNmVSY01idTdGOVdmMWFkU3NyQTNVcHlzVjhpem4vd25WUDUwQzVjWEtj?=
 =?utf-8?B?UWFmY2Z0ZmJOTnIvTkJxUTdKUEFIUUtRN0FmclZ1SFdFZ1ptS08wd2xFNUY4?=
 =?utf-8?B?eTVtTC9CbTdxRU9iTEUvR1dEN1V2NllGV1MwZlgzZVEzQ0p5WEhkZG5KR29n?=
 =?utf-8?B?aG1BcXBYZlQ1TnNMZHhJcTNId3ovR25Gam1aTlRCdjM5QzVKSFVRb3JUSHZT?=
 =?utf-8?B?SGdZT0I3Rk1WMTRjUDBhL2hDSSt1VWhoSE5JQ3B1Q2k5eUpFSTE4QmsrcDFs?=
 =?utf-8?B?aXNsNG81dFdQa0t3cW5hZit1NlFsMERMQ0tZeFd2bFU2WlJ5NzRRUTRhcVZD?=
 =?utf-8?B?TjRMQmIyemxwVUdtNmhwZm9Edm9XaURnM3lZYzFCOWVyN2xKdFEwaDRxNVhw?=
 =?utf-8?B?Qm93MnRkYytOSUdwa202OWNFUFBRKzNIaXBhM0FOazJ4MlM4cEd1ZnJ4akN6?=
 =?utf-8?B?VEtqV0E4bk83SlVHOWt1dXZocXVndzZGNlB0NGI0VEpGNkR5eXM5bEEyWWtP?=
 =?utf-8?B?RE9xNzFrdzgwUVpZbXF1M29HSUpkTG52dzg2ZjdKbCtWT2VRRERpUjkzZXZq?=
 =?utf-8?B?UGVjS2Zna24vTDdCemVidHBIRnVlemwvVHhJNGVrck5YUi82QitGUG4vYWJi?=
 =?utf-8?B?Z3JRK3NINWFML1RRVm5YSlJUY29vZ2VnYzJmcGtRSkhpd1VDd3VXQkNPNEJT?=
 =?utf-8?B?UzNLa3Ntdmxod3o2SDd2LzQzRTZqQzhBVXpzTE1iRkJpZVV0ampWamlnQWNL?=
 =?utf-8?B?bWpqbWhLdHhVY0ZsNDU4Y3p4dldYL0tuRVJ4SytQMlBrc1JycDh0R0dTN0JK?=
 =?utf-8?B?eEJHa002TC8zR1FPS3JVeUV4UGNlTDhUS0FQd2ZDNkNGM05ab1MycklINll1?=
 =?utf-8?B?THlxRFBGOHB0bUZOVEFRK2pXRkcxZVNITGtEemhQekFLOGFvRUtBeVpIcnBB?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 728f32e0-242d-41f2-273a-08dade07d50c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 19:17:24.8702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0j5HkDBTSZGAxRRreVn96avounjA0qcuAKrqQwjLApE4c3EPXVFII5QCAKiUc8RJzwdRVm9RyYA6OPAwyefGqJrohY37/hvDJVoIV6k3j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
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

On 12/14/2022 6:21 AM, Peter Newman wrote:
> On Thu, Dec 8, 2022 at 7:31 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>>
>> I think this can be cleaned up to make the code more clear. Notice the
>> duplication of following snippet in __mon_event_count():
>> rr->val += tval;
>> return 0;
>>
>> I do not see any need to check the event id before doing the above. That
>> leaves the bulk of the switch just needed for the rr->first handling that
>> can be moved to resctrl_arch_reset_rmid().
>>
>> Something like:
>>
>> void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d, ...
>> {
>> ...
>> struct arch_mbm_state *am;
>> struct mbm_state *m;
>> u64 val = 0;
>> int ret;
>>
>> m = get_mbm_state(d, rmid, eventid); /* get_mbm_state() to be created */
> 
> Good call. When prototyping another change, I quickly found the need to
> create this myself.
> 
>> if (m)
>> memset(m, 0, sizeof(*m));
> 
> mbm_state is arch-independent, so I think putting it here would require
> the MPAM version to copy this and for get_mbm_state() to be exported.

You are correct, it is arch independent ... so every arch is expected to
have it.
I peeked at your series and that looks good also - having cleanup done in
a central place helps to avoid future mistakes.

>> am = get_arch_mbm_state(hw_dom, rmid, eventid);
>> if (am) {
>> memset(am, 0, sizeof(*am));
>> /* Record any initial, non-zero count value. */
>> ret = __rmid_read(rmid, eventid, &val);
>> if (!ret)
>> am->prev_msr = val;
>> }
>>
>> }
>>
>> Having this would be helpful as reference to Babu's usage.
> 
> His usage looks a little different.
> 
> According to the comment in Babu's patch:
> 
> https://lore.kernel.org/lkml/166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu/
> 
> + /*
> + * When an Event Configuration is changed, the bandwidth counters
> + * for all RMIDs and Events will be cleared by the hardware. The
> + * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> + * every RMID on the next read to any event for every RMID.
> + * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> + * cleared while it is tracked by the hardware. Clear the
> + * mbm_local and mbm_total counts for all the RMIDs.
> + */
> + resctrl_arch_reset_rmid_all(r, d);
> 
> If all the hardware counters are zeroed as the comment suggests, then
> leaving am->prev_msr zero seems correct. __rmid_read() would likely
> return an error anyways. The bug I was addressing was one of reusing
> an RMID which had not been reset.

You are correct, but there are two things to keep in mind though:
* the change from which you copied the above snippet introduces a new
  _generic_ utility far away from this call site. It is thus reasonable to
  assume that this utility should work for all use cases, not just the one
  for which it is created. Since there are no other use cases at this time,
  this may be ok, but I think at minimum the utility will benefit from 
  a snippet indicating the caveats of its use as a heads up to any future users.
* the utility does not clear struct mbm_state contents. Again, this is ok
  for this usage since AMD does not support the software controller but 
  as far as a generic utility goes the usage should be clear to avoid
  traps for future changes.

Reinette

