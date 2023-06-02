Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4426B71FB93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjFBILS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFBILQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:11:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96ED3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685693475; x=1717229475;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=89yt4bZSCiNDaJgp5wd9slPspfbbeDG4O6M+ty5nXrI=;
  b=RdTasYzlzY62awHPaAi9/cwqSBkxR4gGgyMO9by2o3wqf56Ym5bap1of
   DxHmyFhjJ0yf+P64104fCbY5JRJH340Dd2JFXMriHw9yOvde1oj4cv8kZ
   xdCq5V8FmR7hke2XtdU58qGIAErwyuK8C6t7lFH0XItIDXjhHxqfkKXag
   cfRG47dUQRhKwoGGD9zKaHV3HV4p76f6yk0lgQCkb8v4qXlhtn6+uH96F
   Z8UJxjPoEW/OY3RZRXLqQJ2ygsrdF+5TFfj739cjFjkvvXyRqWoMiVECM
   d5b6vhnpjs51uYGG0pc+28QNpKA9zsjQsxcOqH1SjMEnwD1sTriqhFB1W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358241586"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358241586"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 01:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="685215813"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="685215813"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 02 Jun 2023 01:10:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 01:10:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 2 Jun 2023 01:10:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 2 Jun 2023 01:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWc09W/xXix2XeEhy+IUBAkOtqTVClb4ZrJuxga9TcZTyK8ij4Vhu3QmkEloQ/7lVOSFz94RiRjh62wWZOkvEqR35wkRiWjt4JRROEL/gcAiM1DcEOjyFrCw4ZGn5z+pNVt4hX7ms4XRK4vhjsRlM7t4rovqh37WHMc5N0gb0Dhz7VtqqJ5Q7ZAn7bllvQ4hoiSrsLdDgKrxFcSn5/La/UNs9lctanQl0fyOupvqSa/4KO+ZM7AM08jQh8K0l20EHQuS4fSwkqH/3gcMsdPKXqBEYSxgegzOqVM4cDm598g4JiOkHyFZstmyTVU2YKG4oVx1LPyhdmvRL1CqXm0EAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGb6/jhcvycgL6kkDlvuKo8heUMUgUXiERZ+uJCgD14=;
 b=ad1GQooMOrsZXAdOhmJJnKB7FDSnFAkiRq1xKBcU4MYUW7NBLUUZqrA9PvqW5GPI3fHbPNjRKdBNtF0opfTDE+JobGKEFrBpU9KNmjyPdPQ1oOxLFPfA9NDbwjkCHswQnzZcEUZ7uP2hFt6RmeGOtbAOXptlAg8B6LbnfiJaubkwWdgMC0ID851tY7WafjWgq4+4oNVN1fcJlTzsLC7OFqurhZzmi+AuTaAu4OvFugfIFqNAAwbumX5dDBY0yQ0aOAPjRdUfN1LFo1ueRmmQt4Gi2VwvrZm7PW1zWQcXp5p4JFs8w9plGYpJCmtQk2hBg7e3Gl5dLktd/yIdjgm5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 08:10:48 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 08:10:48 +0000
Message-ID: <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
Date:   Fri, 2 Jun 2023 16:10:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 481ecefb-62f3-49f7-6b30-08db6340df54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iH/e7DKmQjYXppZ/jurSgOVGSf3A0tYG75wgEzFVmG+3E8AvHX9fmPHBxScGxngVOtEk00LTSFUlD3ysWrFEwusKVFxBXvlNLXachwhZ+IsBuHjIZqKZ9stjjJI4AFppSqbd/e5RBfQPs6j+PJw0KS0jq1t6BKauaLtBj0ZJdmPJJIBo11aNEQ1asv8uMWI2hFsDjuz+7VSQ7zwzm4qkBJmcgHxpifirBZMO0XUSMBTSS5CghGjfaZvzMnGgXuZOoeFTxa0wgPjGg02zt7Dh9TGgFF3sxyNZZDbfB/tlrS8Ow1zydH+NvoeNY9gfZA5DknvY5+5qvg/hKVBPj8ZADW1Ugki7i1T8BnI0zcS5lJDFlvjacVLKXjqCek7RRFU138fWdG3i99rVW5gsm4xWxjaDP9xQWbIV9HpK6yp4ZY28eC5pNzD50nBuif9PJ8943pOm1N8NsHglJbQx+bD3FU5swnbi/iuH5ZjFhEbSjdBRSjTU6wj1NiX5ORg10iG07mTJ6lrr92XPieXsxQXNAy6decv8wN2lnpKlCnFiAjg/R6EZi7/8O0FFAkl6LCSx/NEftgLptMkbvpvBesnZHpOCUIQSjGlKLXw2nnsx3Tx+f8vEH9LK6lGclr8A5pKY5ru5xVoBfYOtJffnuo0zQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(66946007)(2616005)(83380400001)(186003)(66556008)(4326008)(66476007)(6486002)(316002)(478600001)(6666004)(8676002)(110136005)(2906002)(6512007)(107886003)(6506007)(53546011)(5660300002)(26005)(966005)(8936002)(41300700001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnU3cThlZ2h0ck85YjdFbnBibiszVHlLcHdadURFZHZnVWdGbEFIeXRldUFR?=
 =?utf-8?B?VmdjRGkzSUNDQTc3eSsvRVhhY01peUFsbG4wdk45N2czMEJtWFVCR0o1eWdI?=
 =?utf-8?B?T2Z2NldSL091N2NneXhROEhUQ3JXSUFiOEpzeUh3MGlveERrcGxZNW5nellX?=
 =?utf-8?B?VEtNVUkrdHFlUGdhUGJOZ0tvU2xsa3FuYnFrZ3pVLzhmOWdlVHU4TjFrVUFh?=
 =?utf-8?B?d0owTEhaaGQyNCtzdWNsT25nN0lYeFZNSDlFMzhSeXdZbkVFQXdZVnBORjNh?=
 =?utf-8?B?eTg2N3p0SmNMQmw3YVcrRitWR3F5djI1L3lwaHJodDdIWU51VUdBVWcvb1N3?=
 =?utf-8?B?MUFxeGVvTTA2a2ZYcStCOFh1VGExaThQS3VDd21yVzVsQ2Z0ZW9DeFRUcVVr?=
 =?utf-8?B?NmJjTjNCYWU4c09DbDMxY3JXaEdzSmxoZU83clV1YnkyYzhSZktMbmdJN0w4?=
 =?utf-8?B?amlsOCtsZkt4b3dsVVZHK1Brb1Z1d0JKTUJEbkpNdndYOEl1aGVLeGJ0WWJY?=
 =?utf-8?B?NWhSR2lpeXBDaCsxTFJpRkI2RTlGZGh1WWNlaTRmTVZvUFRYWWQ3VjZCckpj?=
 =?utf-8?B?QzUxTFFwMVB0cG40UFN1aXFEeHZNY09pMUZ3Z0Eyc3BhS0FEcFZXOXM0N2dH?=
 =?utf-8?B?YUtaNnNKQVlVTjJVTHArRjdza2QyMzZkOGJjRC9ZUVJJcUZSbC9GcXUrZ3hL?=
 =?utf-8?B?UlNGM0NDdlFlNCtPcDUzNmN0NVJEVnplM1V3SC94TnB5SWNUUDQ0d2FGUXhx?=
 =?utf-8?B?aGF5RWpxMXJYTGdIekVxUmNSczBLcDl1TElmYjkrNmhIOWpSbmFvejZEZTdq?=
 =?utf-8?B?UlNWdnVjdWFuOXRuWk5VTUVPeU1RMXJ2TUsxUTNIcE5ZOEVydGtRUkdEbXNR?=
 =?utf-8?B?bUNSdHNhaVplS3lPQjZvRnpiOHQ2VHdLbGxPM29KNnFCSXBBeE5lZXN3Zk4w?=
 =?utf-8?B?YnpVbWsxNStXL0RiN3B0NUk5SmRjVEYvbmpUd2hMZkhaMnVKNkdLYkdtOHlj?=
 =?utf-8?B?bUJOdmZUTDR5SkZkTCs3ZWhrOUtiVm5GNUZiWHEzbVdJTisxZDJPOHVJWmVj?=
 =?utf-8?B?VVl3UDNobnZXdStQTFVuOUEyM295R0hqRmFZTEtmQ1AwcVJ3RWRyYmRSSXl0?=
 =?utf-8?B?aHRtZmViRWQyRHpDb0l2SWpMcTczVEJzbDI3ZDhMWFl2V3pZaEg3OHNpcy9J?=
 =?utf-8?B?OUpKeDVlQitnbGswWFl2aVZqVzkzMlNTN3hhd3RucjhqdWNsb1ZBZjR5OEVX?=
 =?utf-8?B?VXcwRkwwWmxsbFhwL0ZnUU5nL3hDVDhKUnZtS3EvVmhaZEMyMUNjRGhzUy9Q?=
 =?utf-8?B?VENNTmxhaFc2RDBzTks5RzlkcUFiZmhXMVhHa2pML0NTcThVMHRpR3c1OEMv?=
 =?utf-8?B?TDRaSHl3ODJucVoyRkYwTXRQM1lJdXVTdlRqK1lQV0hBUlhWRk51RzRmbUZm?=
 =?utf-8?B?bzF1c01CaVIzMW1yRmdlMEw2cENRZkRnUysyalc3d0ovOWdtZ2JTaDBPZXkz?=
 =?utf-8?B?aHl4R3oyRThMdFRoMVgrYlBvdkM3aFlZZWV3eWlUeG96WnhqZ05JcVhEZDA0?=
 =?utf-8?B?dUcxSVpJcGdjb3lxU05hMUlkT1pzclRZOWdXNFQ0cU9uOVF4TVNKWEtpRmdO?=
 =?utf-8?B?ZzlFUGE3Slp3c2ZnTmVycStiRzJlUlZoM3RPUGVCVFNnTCtnNXFoeWo4a1hm?=
 =?utf-8?B?K1hNNjZhdFRpOENmbUJoUWF6cmxzRDRMRk1NOVM1Q0xvajdrLzZoUGw2ekk1?=
 =?utf-8?B?OVhpMWx1dW90M2wrNzFtNmxSb3MvdVQvSmVYc1Rmbk1nVThPay9OUWJubENi?=
 =?utf-8?B?Q1A3a2YzcWZ3NlU5YnRDdnAvTUZhMjQxd3NKdEFRTzFQaVRQR3Z2a2RGNmxV?=
 =?utf-8?B?M1hMZVpQaHB6WS9ETjBSRUltYTRMM1lhZHZrK3N6emQrTVhvNFV0Z3AwZ2Ey?=
 =?utf-8?B?U2tScHdxdE5SZFFCQ2Zqd01kS3VOY3NsbkZEMzBQZnUxRGVRMDFaZTY2bXJ5?=
 =?utf-8?B?aHdkc2k5K00vUVdpVXc2aDc3TS8yWVdOOXh2MlZybWhkakdwbHJIYkhKRmVG?=
 =?utf-8?B?NFZ2MDBSTHNnL3pjdlRJVDRNbGphdm14dVFML3VmRCs3SzhUV1Z0a0dSdlF3?=
 =?utf-8?Q?eFpzWRJPQP0b4x5TXOAdMTejk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 481ecefb-62f3-49f7-6b30-08db6340df54
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 08:10:48.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEn+kIqNWbNkQq0rDlVm88cWVPOKRddHDJuS7iWFPU4UEX8iQ/0cBA1ajz+jPaX8eiM7YP9QorLw1xGEPocuHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
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
> Patches are in the following order:
> 0001-0002: Testing framework for benchmarking some operations
> 0003-0004: Reduction of maple node allocation in sidetree
> 0005:      Small cleanup of do_vmi_align_munmap()
> 0006-0013: mas_preallocate() calculation change
> 0014:      Change the vma iterator order
I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
this patchset.

The result has a little bit improvement:
Base (next-20230602):
  503880
Base with this patchset:
  519501

But they are far from the none-regression result (commit 7be1c1a3c7b1):
  718080


Some other information I collected:
With Base, the mas_alloc_nodes are always hit with request: 7.
With this patchset, the request are 1 or 5.

I suppose this is the reason for improvement from 503880 to 519501.

With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
mas_alloc_nodes() call. Thanks.


Regards
Yin, Fengwei

> 
> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
> 
> Liam R. Howlett (14):
>   maple_tree: Add benchmarking for mas_for_each
>   maple_tree: Add benchmarking for mas_prev()
>   mm: Move unmap_vmas() declaration to internal header
>   mm: Change do_vmi_align_munmap() side tree index
>   mm: Remove prev check from do_vmi_align_munmap()
>   maple_tree: Introduce __mas_set_range()
>   mm: Remove re-walk from mmap_region()
>   maple_tree: Re-introduce entry to mas_preallocate() arguments
>   mm: Use vma_iter_clear_gfp() in nommu
>   mm: Set up vma iterator for vma_iter_prealloc() calls
>   maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>   maple_tree: Update mas_preallocate() testing
>   maple_tree: Refine mas_preallocate() node calculations
>   mm/mmap: Change vma iteration order in do_vmi_align_munmap()
> 
>  fs/exec.c                        |   1 +
>  include/linux/maple_tree.h       |  23 ++++-
>  include/linux/mm.h               |   4 -
>  lib/maple_tree.c                 |  78 ++++++++++----
>  lib/test_maple_tree.c            |  74 +++++++++++++
>  mm/internal.h                    |  40 ++++++--
>  mm/memory.c                      |  16 ++-
>  mm/mmap.c                        | 171 ++++++++++++++++---------------
>  mm/nommu.c                       |  45 ++++----
>  tools/testing/radix-tree/maple.c |  59 ++++++-----
>  10 files changed, 331 insertions(+), 180 deletions(-)
> 
