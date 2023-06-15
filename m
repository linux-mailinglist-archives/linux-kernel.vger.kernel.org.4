Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB0731238
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbjFOIdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbjFOIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:33:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2255E2959
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686818003; x=1718354003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PlPaNdRXSNMeeyA+JzYoiEzKa94XuGmtn1TGf6ipNIs=;
  b=Yy4WXWzrDk7xstpFonlLbuvhQOWT/RHpKQniuL1LG7YFzah/4+/zDsA7
   VJcXqO3QpXG1vuIz6S39tdf/vWptTKxcHYlTuysNbhxof8ynu+OD6l+M3
   aVNE+9U61BQrHYAnaIoFcG4Q7JfHvqEae21XdVOvtowzUOdUgB4B4Bd0G
   SrnXOacSiqBIf+Hm1K655Saf9pi1Wa/TH3gJUAizsYOPVLLlUHPb74ZUp
   5Uu/taimRTVqoBYf0uCZldb5xqPhjA63ff5AnWC3eDS2V5fm9kzWJUkDV
   zQoWAl/26ZZwcKR3shsiuS93GlfdcZPJ6w0iGnOUBsBR5gr3EWmKO12Ll
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="424744342"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="424744342"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 01:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="802257920"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802257920"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 01:33:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 01:33:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 01:33:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 01:33:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0CXWg2cwyAfhqz+MZIlaF1b62jvx7kp6ysL14X9HbMcP2INTYLjTd8r3diTE0SYwDz+Mzct9qEzVCJzLNlxWSuvFa0mut4APg0H3CH0BFu0R/5872NZJfyebl/Xh6urtk12JpLyweILPiX7wZriIuHcoGJczBOJzI0ITTml7Mg8GfqKT6teqMIev/+3ELPagP1ASWQp/2gy/DihAcciD642QHKNWnR4bo6tzSupfCpB0PNvkHqh+rpzd6rnExTntgDrHTBO5mKkHYZiPGQi8TgGle/p8og00adveMQvWN/Dwdf+KYwtvLCZDQNff524tf3jxoKq9zc8B+RliMy8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UVKZvb5+27m+7t3rvcH34yLT0aFt3Rr90jOBrdKc/o=;
 b=kEon6GF+puOUqfbyRNhKVkVsKJ3+5rwflNCYsFaBmX0ykcLkiRlIGGrqy/CCl4KnCZq6tXNLI+m0mOe2OFErKkDknTGjIercLkO3Fi8yp3N42hWxqsjx8zQFLAxEBmkruJhH5dwWjgd1CRb+PRFdf1JNIpj35QaUxju8yuJIXN/vMsB1vPfV9JIvdn7D+wxRGcaHdxxuXSBq2i446Pp8YwLTBwmvvSManWxMdUM2mb4BZhy48GvkZq3myPyIdrcPuwKXSyVcwntF1jJbmiEmO7mAeUy+tg9yJuF1wpe/y8fMmovr+8Jx7l/fNz7sBTxkavmUSpY1mrQtK8guxpZ6iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.25; Thu, 15 Jun 2023 08:33:16 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 08:33:16 +0000
Message-ID: <5d1631e0-22a7-a310-8078-75b9088164ce@intel.com>
Date:   Thu, 15 Jun 2023 16:33:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v2 00/16] Reduce preallocations for maple tree
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>
References: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230612203953.2093911-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS7PR11MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6c055a-b1d6-4a9f-1833-08db6d7b2a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urYMVUQmW+yte1CVr3D3B5IHUifO2I4yttfiKSGU7Wij9wfhEcQNWoz/F02LWrd/4FW+HO25X49qSQ0GD2yPbIWCBCy258i+YOQjzOm+3NS6b4kZy1IeKfSLwCNeE/D0BvQAf4CyMczvjE3VagypCFOhSf5mmo+yWPRvDtul/ytG4pjdwfTpDT2hRH7FQLocaYHnJTUH8azr1Wt1tYMW90p+fsxPsOEKK/QLZ9Flxp2waO8xu1ptTDx7Dxj1kYIyvHExzhhwuAuFszU15CM9NxBr5M8/mVxjQBOuwe6iGqQGJIvTvLuoeItD30MZlmXB/gf5re/FaowAUjlBjGJhg4J57GMwZ1X7e8EBxntFg7SHxQrh7kC6WjOjKztriT1u1L2xbR8wyQ3pHEH7q9zSNneApk5VSjJDCsp5SYRgr1LHqgr4Zfk4DHiGP+JoILuj0nLYOXKG+8AMgXlpnGgx8yuwApterWIwAJ66moaUZNWXHoBeM19kcYGrGqQhHpofw03H8fYmJofzCXqJcuQejiFkSRUI79r/3DIKMefjwun6+esGDPAFN5o6yDm76eNeTpCFstd4ugIpIyH1fPPY/wKWox1ExTzLCn9WJH2KTlfq/xCVuqLpTXedmMFltp7SjkX0wvu6H/TPnwZBcmKabHR8X2X+h37fQKHNV10VeezwBhJ+oG8Fe53zS9h/Pi9o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(31696002)(38100700002)(82960400001)(8936002)(8676002)(6486002)(316002)(966005)(41300700001)(5660300002)(478600001)(31686004)(110136005)(66946007)(66556008)(66476007)(6666004)(4326008)(53546011)(26005)(6512007)(6506007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNrM2N4SkFlZVRhSlB4UWNDSC9Za3ZDVmpiUGFNZDZGN05TaXkxeVpIWUp1?=
 =?utf-8?B?TmNzWjNHNG1UWktsM1VZTjdJQkM1Y1cvWXN5cVQ0VVJ0UTdsVGU4RU5PYmJC?=
 =?utf-8?B?aitHSzJ5Sjc4bnpWNGZiTUpoOStGVjlsaGNNQ0w3SlZSTnZEQTdBam80ZE9t?=
 =?utf-8?B?SDZJeTdkWlhzQVBYYXUrNEhhdkw0S05rY2VtTzJyOVZxTFVKZDhybWt4clNt?=
 =?utf-8?B?UkdUZjYxUnp5RXhoRGJ6VnBlc0lYaG5ZeDlIcjlrM1B6RVVMT2lmakdDT1BW?=
 =?utf-8?B?S0haQXp1Nzhubkl2Y1NQY2pMVi9xZjU0aVhjbk5xUWdtZDVRTnVnVmd1UEJq?=
 =?utf-8?B?aUkrdUtvT0FVZmlBWnRsOUppZ2kxaEd5ZTNqOHhLcU9WM0daS2Jiejk0R05I?=
 =?utf-8?B?WTJCam4wUlRONCtLTDVMU29iejFaTHZDUTJOSnREalZ3dkszbDQyZjBBY0RB?=
 =?utf-8?B?MEdxZDhzamZUTUdBa0w5RVgzUUZFVHhrVnZNS2RlMWlLUkxXSVJtUHdLb09O?=
 =?utf-8?B?dUEwRWQ3SHFjQXM4cUhta2pvQ1Y3eUVDc2hVTDZMendrczBnMzdSQ2pPTEVN?=
 =?utf-8?B?OVhWOS9ZaHNlN3E4YmRsSXU1RzcvS0RDZnM4d0JqaERVcGZRclRsaWtoQUNG?=
 =?utf-8?B?TUNwaWFZZzdnMWpwcExEQXpTZXhsek5HZTluNStLZzlXMjRVRDRaMTA0em9o?=
 =?utf-8?B?WFlCWnZxbnBkb2QvZEo3ZTk3WWhNVkhRd0dWcmZBaWp0WmFBMG94TzNjU2NI?=
 =?utf-8?B?eTBmZEozMVpBUWllakY0ZFFmUVI3N1Z0N21PRGE4b2tVamkwZUVYMVEvMGtY?=
 =?utf-8?B?QUZldktMRkwvM2xNTTJuUlNqOEQvT0wzczdweDdraDhydnRzZHJBNllMYUZM?=
 =?utf-8?B?S2JLUU92MWQ1dFBNZzc1ckVXVmFMRmpDemZzNkhOeVRmeFcvdGJ3ZWlIWDk3?=
 =?utf-8?B?RTZYS0pvUXhpU0VITHhNSi9mVVU5djZWUGZBZXd0NDdoK2RxMkpqOXVMZ0li?=
 =?utf-8?B?QUVJM014a3JYdy9RQjNGQ2JFeGt1WUFQcjdBMXFtZHdkWWlFdHE0Ymc3Q1JG?=
 =?utf-8?B?RzYyc1hHa1pOV0VHYWJoOUtlSmV3NDVTTWcwVVpYUXd2RERxSXRDM0U0dUxS?=
 =?utf-8?B?bU5BL1JDUzBwSzZxSzRtcVhDeVpMNmhIWVpxemk3ekZueE8yT003YWJ4aWFw?=
 =?utf-8?B?ZmdBM1BCTVNZTWoxcDBEQ0poa2prOHRtVkpXVVRyT0ZRd3V2QmFQRHpjOGxw?=
 =?utf-8?B?WjFycEJVMm9DSkxMNG9jdmo0eDZ0NDJnYmhXczZlNXhBaEkzVFIvVUZvSzZC?=
 =?utf-8?B?WGlpZUgxQUtFdlNZdnprM0xLazY2M1dUSUxLMy9jdEF6MlJBNmtuRnJvWmU5?=
 =?utf-8?B?SFVOS2w1SE5vaUpPMTNCa0dMc0d5Mlc2RmYwUVQ5VEY1QzV5aUJIR0x1RUgv?=
 =?utf-8?B?RVkxYzBHSGg2MkFCVUcvV2hFSnZVbUFMZzlrSFdPb1hEcThYcHBxRytaQlVP?=
 =?utf-8?B?eGl3Z2ZyME5GdWN6cy9iaXlXeUdNK2dqMzRYcm16YlpnTVBQWjdNc2JIMzU4?=
 =?utf-8?B?L2kzS1M0c1dIQ1NzQmxnQTBqWUlwT1hVV01OSDJrNXBLZE9XSWptdzJCRHpL?=
 =?utf-8?B?eVcyK3NhdWRyMTdtOGxZVlNZVERBaVpzcjNndkpycFo4S04rV0o0QVZVR25O?=
 =?utf-8?B?eFJKemVpT200a0czaE84dFNvM05STGlaam54S0p0b1hJNzdrOENQWHcrZHRr?=
 =?utf-8?B?bHh1c1ovUDFZRW5CNFE3ZjNGSzhrV3lGWEI1RmhUUjgwN3JacjBoaTIzVDI2?=
 =?utf-8?B?VHNxT2NIZ0syd1hCQnIwbGtGU1lyOHJTR0VzK0xkS2p2WDZQQ1JsM0ZNNjFo?=
 =?utf-8?B?d0hRYmdRbG1mUXVoNVRFRGd6UTZLUGNMbFpxaUR0YWhWcEV1WW82R2czTG82?=
 =?utf-8?B?VE92UWppRzh5d28rOHNKc3ZQYSt3VmJMZDJPUnZrcWUzTTlMYWlGSjhMZGJy?=
 =?utf-8?B?VFRwR1kvbGlRYXdDRTBteUVuQ1puc1ZGTW9FVG0wUE5nNVllL2JITzZVYThI?=
 =?utf-8?B?SHRYc3czZzduTmVINUd6THVQL3Q1US9HQmQvUFY4MUZPNThVS0syWXlvWi8v?=
 =?utf-8?Q?vZ9ovhdBtl12ezeqZzILnOYjW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6c055a-b1d6-4a9f-1833-08db6d7b2a65
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 08:33:16.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pObIMAKqmHw4kL8JrDFRuIMZ1j/XqLLLT36Mg2X5r48oEJWT6TdErtSO+TQan/dgtPimwNJ8dofiLOzB/v/6yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On 6/13/2023 4:39 AM, Liam R. Howlett wrote:
> Initial work on preallocations showed no regression in performance
> during testing, but recently some users (both on [1] and off [android]
> list) have reported that preallocating the worst-case number of nodes
> has caused some slow down.  This patch set addresses the number of
> allocations in a few ways.
> 
> During munmap() most munmap() operations will remove a single VMA, so
> leverage the fact that the maple tree can place a single pointer at
> range 0 - 0 without allocating.  This is done by changing the index in
> the 'sidetree'.
> 
> Re-introduce the entry argument to mas_preallocate() so that a more
> intelligent guess of the node count can be made.
> 
> During development of v2 of this patch set, I also noticed that the
> number of nodes being allocated for a rebalance was beyond what could
> possibly be needed.  This is addressed in patch 0008.
> 
> Patches are in the following order:
> 0001-0002: Testing framework for benchmarking some operations
> 0003-0004: Reduction of maple node allocation in sidetree
> 0005:      Small cleanup of do_vmi_align_munmap()
> 0006-0015: mas_preallocate() calculation change
> 0016:      Change the vma iterator order
> 
> Changes since v1:
>  - Reduced preallocations for append and slot store - Thanks Peng Zhang
>  - Added patch to reduce node allocations for mas_rebalance() (patch 0008)
>  - Reduced resets during store setup to avoid duplicate walking (patch 0015)

AIM9.page_test in my local env:
  before-preallocation:                   763812
  preallocation:                          676600
  preallocation fixup v2 (this patchset:  734060

For this specific test, the v2 patch works perfectly. Thanks.

Regards
Yin, Fengwei

> 
> v1: https://lore.kernel.org/lkml/20230601021605.2823123-1-Liam.Howlett@oracle.com/
> 
> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
> 
> Liam R. Howlett (16):
>   maple_tree: Add benchmarking for mas_for_each
>   maple_tree: Add benchmarking for mas_prev()
>   mm: Move unmap_vmas() declaration to internal header
>   mm: Change do_vmi_align_munmap() side tree index
>   mm: Remove prev check from do_vmi_align_munmap()
>   maple_tree: Introduce __mas_set_range()
>   mm: Remove re-walk from mmap_region()
>   maple_tree: Adjust node allocation on mas_rebalance()
>   maple_tree: Re-introduce entry to mas_preallocate() arguments
>   mm: Use vma_iter_clear_gfp() in nommu
>   mm: Set up vma iterator for vma_iter_prealloc() calls
>   maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>   maple_tree: Update mas_preallocate() testing
>   maple_tree: Refine mas_preallocate() node calculations
>   maple_tree: Reduce resets during store setup
>   mm/mmap: Change vma iteration order in do_vmi_align_munmap()
> 
>  fs/exec.c                        |   1 +
>  include/linux/maple_tree.h       |  23 ++++-
>  include/linux/mm.h               |   4 -
>  lib/maple_tree.c                 | 121 ++++++++++++++++------
>  lib/test_maple_tree.c            |  74 +++++++++++++
>  mm/internal.h                    |  40 ++++++--
>  mm/memory.c                      |  19 ++--
>  mm/mmap.c                        | 171 ++++++++++++++++---------------
>  mm/nommu.c                       |  45 ++++----
>  tools/testing/radix-tree/maple.c |  59 ++++++-----
>  10 files changed, 364 insertions(+), 193 deletions(-)
> 
