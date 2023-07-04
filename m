Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55F47468DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGDFXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDFXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:23:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA57BD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688448196; x=1719984196;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4wjsgakdzZ85ZzUO5/XWLYua0/Vny6HHetiff2M2PhI=;
  b=ATHlgug4l6uD/iHdaA0Mb6O9Ss+5p2xSg0U2ZGxQIAMEk9ax/ypIURnV
   jf2EVcOD7700vyJG95BkY+m9dc9U952Qu+hafpsRPog75PuagFidmjzhd
   AZXURrAfe+G4nQwUufVaOcosjmHF/3Mn4WY8RdqJr/RQob3vSRV/oI9rh
   GdDB4XAw3to9yUl1Tne2Lft0hzD0Krp4wTdc9Kka2QGDlSKVZbiHoyaSg
   3CvDR9UZerKXzJSmBCavJ3SEZ5nlZNX5Jl2Hf91Y2swRgs8U5eJEAJb2K
   vq2CW++z8zMk31A6hCuC63SMDhlomYl0QTHvMv++4rUS259aXtPjmRs6k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366517531"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="366517531"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 22:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="753946817"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="753946817"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2023 22:23:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 22:23:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 22:23:15 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 22:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwJPcNTLB6P9LqpPk3O0C9TvXd/LiF45OiHMEkim3ZnwARyEDTu4tQgq3a7p9A7RPsvBtE+EbHkCFmEcC/uQVwIlyOPyDPYQsp18rsymrFlekaIRCyfrLeRrqYnMf6aZNFr3U93kPDKaDfe6ItkBSuHsZAOlHOicxpLBeHLCuq3K8XKEWyN9WJ7VntN1/Y+yxcBbPVw4FoYo/C//fr/AODABiXQVTMKLVaDjo6MoPn3GY5a7AMX0IFEmURbM720eE/zSpZMM4G3yltFGumzdA3nLw7vzRsoVIBNrNCeOFrK0KtN8IgaCmemF4rlvmKvfIZK6/4OKQq8WKDOXXf3pbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upp8E+G1Bogo0DZaLbZctqOhoi0GZlqF0PbBweSgf5Y=;
 b=FI7yX5AXZFyktugPvB3ZzEtCh+bS62a6OCSsGIiJHJ3cQbQ5WDbBOQ5xi42OxHhDBagLXrmGBZ4dWifOQUG23jjhlFuarCm7D8KT0H4jB7bJ6GCE4UmLHLL4WaeVNqxc4GPzqE44Jjs/ID8Q4r3frEHzgsDYjEHLXbMBcb5SmjVJ4YWzcRmRSg+Tl8BicWSPPcyREgvpCMfTL7q64alzi6UHAJw2yK0Frfc9tjN1WVGSTA8GRdwM/3u6cDUfwZd/BNq8DMppVaCnfVYIwFil44mv8z1TjiGWqs2YtzuVW2E4ppH7e/Qyt7a/KOdw+zLm6m8V7aSfXp1ddBHbGXsiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 05:23:13 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 05:23:13 +0000
Message-ID: <4f86fa34-11d0-8a11-5adf-d099fc9e46b8@intel.com>
Date:   Tue, 4 Jul 2023 13:22:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com>
 <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
 <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
 <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SJ0PR11MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: d6adc0a5-a17e-4fe8-aa27-08db7c4ec323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SU8Bcdj96g5BuYykmcxSQ5co6iovFA5EmAobugOsw9Pz1NmBVkstRoIutLfWag32Ze/yWpEDH6X15qg492kt5wDl4VUP5/b6geAsoKzhLFpLLrfDme3A/R1sGh/fZgnRNXHsXcZcR9mrZP2zpDfsTg23ti0pOSSfW8rGI/PLU3FuYMI6Rii+qz+R46t+jq7gyOI9SAVtM7D7ULu7rVIB8bzsTjFtDjTTDLDRdoyPR2j9EBClXanBPpoHwpqp+WdKoHpLFGr0ypBujmp8bucuJl9earTvaX5Gy3XT+ZkOyC9t/BDSE8nxIRKXfvxQ5hydGAH8gxRNuO9ZkomqgD2DF7tkS9khczOGYehu3XNS+uY8ytLzd3O+A8yxHRQNk7iLcW7InyoiN2LyeSnWkJFy4TnIO+kRk1/ORkumSLQ6n7SLoTOS3qm3bPrJbYy+K7f+H4Cs96ptOKCVY0bDuj4tL+RE8EmSkBb0IEYLW4s0c3/MDwMsKym6q/6irsDUG3WcrrPy7pzH4ofg3q7caJKYErqlfH7dH7frPxHNvKH3O9M+7BU7ySHPn8rIQiikYjgJaEjk+usa3wnsj6VkO18CGZggGBHEE1Gg1oCFszqdVoSAxZE2mtCiNsyhf6leifDaG6E+v6UTcQ7jqakPhjxLGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(2906002)(41300700001)(8936002)(8676002)(7416002)(36756003)(5660300002)(86362001)(31696002)(186003)(2616005)(31686004)(478600001)(26005)(6506007)(6512007)(6666004)(82960400001)(53546011)(6486002)(316002)(66556008)(4326008)(66946007)(38100700002)(54906003)(66476007)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lGNFZrNGlUZTlKQnJNZUdwdXNwdGZiNWF1NUUxQ0lkblM0MTZ1NHQwQlBN?=
 =?utf-8?B?M2ZBUWFLOVZyVWtsTnNmQjhvK245ODZNbjBWY1NwSzhNUXo0Z09sMlplb2Nq?=
 =?utf-8?B?NXh5WTFUODM4bVBIN0xCTWVOQU1McFNBeTg0WlFvc05sSzR6QWR5SHBwSllj?=
 =?utf-8?B?RWRGYkRnUm5FdW9KbC90V3FIWkw1eW96S3hQWVc2WmdwdlhkUE9iVnZpdTRO?=
 =?utf-8?B?RlR2cE9Qc1BjUW9YakpSTnNyR0tWUWNPTTBFT0lJb3Zjc2pNTmV0QzlJTVFm?=
 =?utf-8?B?MFBTYkNaQkFFZzQ3T1NobDA0cjRwNWdVQW5FMWJIK2lTeVBPSDc2QnNjRXdx?=
 =?utf-8?B?V0RMbzc1RmhaYVRicm1rOHVWR3lha0ZnNnJLUC9jR0lzZDMvM1JWc2Y1bFNr?=
 =?utf-8?B?WXE5dSswa0VGSG82TUE5U2wyb09IN2E5a3hEbUlsUC9hSmxHVmVsYW5kOFNL?=
 =?utf-8?B?eHRzWG1kRm5rcGZDVW9PY2R2ZmRIeHBUTThCTVA4Q0pacGJQTC92N29EYjQ1?=
 =?utf-8?B?OE45S0g3anlsZUJyT3FPZXNwM3Yxd0VJNVMrSkUySEM4UkIvUlgzb1hFKzgv?=
 =?utf-8?B?Yi9yY1d2MG9qWUhXUFNkdjNvWnZUMHVjM1RGYmZjak1NV2JGdFh2dnN6cUZT?=
 =?utf-8?B?cmVxMGJmb3FBK3Y1Q3FpUTZtMHd5dUhGWll2bWdBTmZGZGhXazlvc1RUcFFY?=
 =?utf-8?B?T25Pa0xpWHJzZ0RwSVN5Z0ZBeXROdkwwVFdvQ0MxZmVuYU15YnRDcUVuaEU1?=
 =?utf-8?B?SlRxdWhNbm53TzVLN1NJeFpvblhmb05qejhoZ1hrTmorVk9OdTZiVEZmUm9m?=
 =?utf-8?B?MlJpTUtXTGs1NUR0TU1DWXlpaFk0SzRReEFQN2xsM0xpZStWdzFMY1dDYndi?=
 =?utf-8?B?UytOWnNTK1REWktoa3hWL3lpZytPOWs4MStXM0ZJZmI2RDVmT2JUM0ZxVVF0?=
 =?utf-8?B?Mk9weVd4Y1dpWm5xVmlBV0RrNDdZSGxweTgyOWVnNEdxMkpZZGdtM05kM3JJ?=
 =?utf-8?B?T1NNd1hNNTArQ0pqaUwrVEUzUHRSNlhKRTNON0NleDdSRGZFMlN3NjBDVHla?=
 =?utf-8?B?MlJocDZHbE1SOGRZL0FFM3hYZytJdHYyMGhaYjl1YW5ZKzZCNUd3RjlQbmt1?=
 =?utf-8?B?Nk9BMDdXMFJ2ZzNNTTMxeHpIYWlMbFdoN3FCd0NOM3dCdGJJUXRPMU1Kang0?=
 =?utf-8?B?UWhmeFFPZ09vOG96N3p5amYwNHV6MjdHUmFMeU9CWU5zRUZBY1dISkpydGd0?=
 =?utf-8?B?TE5Ha1lSNHFqeHRmbDNOU0lOR3lHUnU4V0RCK3JHS2xPcTdWR3RtVUVKaGxq?=
 =?utf-8?B?MVlUSzVpOFh4cEFzeGNwa2JxeW9OdVRzcmk4c3ljSkdFNmlPcCs2RStNK3hr?=
 =?utf-8?B?M0J1NjRZbTNQalAydjY1OXBzNTRKUkpwaE5xZVRvWGt5SEI0aXRBVlFkbnZC?=
 =?utf-8?B?NkJwZkZ2b2xHTklUOFd3WFBsdXN2K3hDQkFXUUttM3VRRkUwWW0xeEhrbEQv?=
 =?utf-8?B?WFlmVGRCWlA5VWcvcE9KQ0FuMUJ0djZOeEw4V3Y5ajhzYW5OenEybUJsOERN?=
 =?utf-8?B?eUdvTXlxQ0dJdlFSUnUvUlR6cFpSS0N6cUphSHA3ZHJzWXlBQXBSRnVXOWQv?=
 =?utf-8?B?Tk9aZmplUFVjbGtHWXpJUGVycTFYVGhhd241YWdCY29VUUJvaG9jS201VEFm?=
 =?utf-8?B?WXY0L2VHcURwWjZWbFVwMVU0Sk1oVm1HTmhVK3U2Zm1POWtBVGpKY2tTOTdS?=
 =?utf-8?B?eHN2UnFjV2dpM2FCbXlTVGlDYk40RW5GNWJNVkdYdlUzUVpXUnlFT1o0eUZT?=
 =?utf-8?B?eG5YUTZHMU1Ua2lKNzVRSWJ6L1hpdSsrNkJ2QzNRRS80SkdSdUxYUjBPNU5w?=
 =?utf-8?B?OGQ1QUU1aWI1N2hydzNFbm1tQmRnd3VmR1pTcUNOcWdtVFVsVDBGUW9kak0w?=
 =?utf-8?B?SGQxMzBDTlUvMmdOYXN0SGtkSllnQ09QSERETXU1ZTVKWmR5THBMWis2SHhN?=
 =?utf-8?B?azZhS3Jmb1ovWnhxSGg0Vmg0ZlhEKzFJdGNoTFVSTHU2cGlCRGxKZGlqbzFK?=
 =?utf-8?B?RWNBQ3Y2aE9tbk9vS3BMUUhPZWc0Z1JKeEhDTW84N3Z0MGVabEZ6SEE1d2Zw?=
 =?utf-8?Q?1IlEadghAt/X8xNJgVhHTc6O6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6adc0a5-a17e-4fe8-aa27-08db7c4ec323
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 05:23:12.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQjsFpzuCgkkgFl3t4Utn6b0Q8O+9NcU7/5NHG6DSLVK2XayW9OFJE44wNrGEBxsAJy3IjrDK3sy+Hn4btRGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2023 11:59 AM, Yu Zhao wrote:
> On Mon, Jul 3, 2023 at 9:02 PM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Mon, Jul 3, 2023 at 8:23 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>>
>>>
>>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
>>>> arch_wants_pte_order() can be overridden by the arch to return the
>>>> preferred folio order for pte-mapped memory. This is useful as some
>>>> architectures (e.g. arm64) can coalesce TLB entries when the physical
>>>> memory is suitably contiguous.
>>>>
>>>> The first user for this hint will be FLEXIBLE_THP, which aims to
>>>> allocate large folios for anonymous memory to reduce page faults and
>>>> other per-page operation costs.
>>>>
>>>> Here we add the default implementation of the function, used when the
>>>> architecture does not define it, which returns the order corresponding
>>>> to 64K.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/pgtable.h | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index a661a17173fa..f7e38598f20b 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -13,6 +13,7 @@
>>>>  #include <linux/errno.h>
>>>>  #include <asm-generic/pgtable_uffd.h>
>>>>  #include <linux/page_table_check.h>
>>>> +#include <linux/sizes.h>
>>>>
>>>>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>>>>       defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
>>>> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
>>>>  }
>>>>  #endif
>>>>
>>>> +#ifndef arch_wants_pte_order
>>>> +/*
>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>> + * to be at least order-2.
>>>> + */
>>>> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
>>>> +{
>>>> +     return ilog2(SZ_64K >> PAGE_SHIFT);
>>> Default value which is not related with any silicon may be: PAGE_ALLOC_COSTLY_ORDER?
>>>
>>> Also, current pcp list support cache page with order 0...PAGE_ALLOC_COSTLY_ORDER, 9.
>>> If the pcp could cover the page, the pressure to zone lock will be reduced by pcp.
>>
>> The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
>> s/w policy not a h/w preference. Besides, I don't think we can include
>> mmzone.h in pgtable.h.
> 
> I think we can make a compromise:
> 1. change the default implementation of arch_has_hw_pte_young() to return 0, and
> 2. in memory.c, we can try PAGE_ALLOC_COSTLY_ORDER for archs that
> don't override arch_has_hw_pte_young(), or if its return value is too
> large to fit.
Do you mean arch_wants_pte_order()? Yes. This looks good to me. Thanks.


Regards
Yin, Fengwei

> This should also take care of the regression, right?
