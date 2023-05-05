Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148D96F8AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjEEV0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjEEV0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:26:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658FC2681;
        Fri,  5 May 2023 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683321991; x=1714857991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7GlUjgQt+bOCXopwYkl4tNsN6uomGqlE59IPA82HlGc=;
  b=WjhI+sTrZdVed4CDtruvZt3meEn9s3+D6Cz/w92xATx109IRm2Vnn1qY
   ysMRO7bb3N37rzFYpBqpUm+GUHAlWtMHNCe8Js7hNgUL5tVOFue/iTkK/
   AIGB8Sm8+bFSL2gsqcyqnMpLmHvMJrvALHK2dmfn4K66+ZFLuQBAr63b4
   HTmiZdPQRncGvh6qmAEpCyQAeQmENLjj1tesZf/HTgxor4G6lMasfuAWL
   Ni0e8AKdIzqZ/Ky9MxpZzPVHgiD3CV2bv7P914oB68YrZRo70Wzm6LeP4
   mQ1CVRiDKJoHVGKQvlq0xavnWP4Ln8xCmkGuNOXgWLwgCyN4e7CW7zv6v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="333730541"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="333730541"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="809420129"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="809420129"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 05 May 2023 14:24:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 14:24:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 14:24:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 14:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2jIyIGdgcSyGxjWkllpG92HZhyEGQZZUo8G5q1zGjNERLTE4KASQ+O3m1Wug+eDUwgiFdE2v+PkepIm4KXlif1UDcV3WeXJSFFv7SY/7rTa3E1eEfE7qyYjvxN2xo9hTRZHBcFZaR2NEugOCDCeVjILKJ7M3B+EKjJD5XECqJsDsmuwKcIwwpYe39xFW3bovZc1ADlE/yqvAlIq/cBTp8IstIS83lLPq0m16YeZNuDmKLQmJL286xy1MxrqeC+/2Hc4mhlWos9m7dgGRsV7ZK1H0ykozYpqZHTyqsLZ+toxXstQToiOqAl9xVwEfduhVpie5nYcfRd0NX6XcQovJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRT3pxtCyAjCxybSnV7QCaNFpm1LqT0236q68tX/Ojw=;
 b=Q3pyM5GoQA6zo2KT/oDY9oXD3BYdBWaFyphfQoghYJSMuV5pyO7w/+h6CpH7Lg/msf/d6KGeKF1VZ80Ep+VB6j3+MbxAnQxJv3YN93aQ4YyzbgfHh5lKYV1PxVUbDKrz/c3/yo+/eBJyoY63M034ifnD/kVrOPF0v+oZAkIC6tqP7Pw4gROAxTHIqmgxFA1wYJiEeZtiTd17NngijduK04Hx/YHcANjT1TpwoyKffNFuWCv5njiSRDQc6RqBwfk0HkNbZVw/MEtAx+Rdv4bLZs2IMyXTfSXFgGzKOhX8redE1RBAstyKBkIZm4REax2htu//G26vgXYqAl40YVPjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 21:24:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 21:24:49 +0000
Message-ID: <3da8d7aa-8a43-bd11-b7cf-824e1a7e1fd1@intel.com>
Date:   Fri, 5 May 2023 14:24:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 3/7] x86/resctrl: Rename rftype flags for consistency
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177446947.1758847.11380042804869155387.stgit@bmoger-ubuntu>
 <0a2bb59f-769e-42b0-9277-10a4b04a03ed@intel.com>
 <232c8e85-0d5b-8e24-33d0-eab5eee186f0@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <232c8e85-0d5b-8e24-33d0-eab5eee186f0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 020431ef-4e0b-40b9-0a1c-08db4daf27fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5UUpUkqEM+w4JOZzt9odFEdxFxcPeEayDz3FYNqbrjMZsia0MqByn7xNx8ea7cvUemBUTRmENas7+XWKus5FG83oHY6nD3whdSSO1UC3LYN77//IxIcxHjxHMjv1uACbrhJt1H+hMhrryQc5AOUAPlYu+YYPFx+Jp+hoJBUlBSzDCBCBo3Cil863ifx8sGkTVrLrRFNmBK8hCnqvV0cRjwJX6YUZ4IzEfMy8rIbjpgEfsWXqc25jvtz1krtdQd+qk3LhtqP0B0JttyIwm8nNgORWEXy59B9010B4/PYbw1cdbt52+VNR4277X5KnSFl6NqktS/hCKjewEwqJwQb7VP+mu4y7qzZIMH5RXkL5ZfUPrLgytg8cDPE8h3WEaClLt5FG8/ko7K17k3yXYskp5HzgK284rMWcgEyRnyWOQAeVPKAQDhoRc+WUVSaWFElu3dmd/RzSrGv7dyVzi44RBk6OLkEUR4IsizIcnDyRP4+LhL0BZLtkfdIfle6Q6kpzM+cUPuLX0lmZ6ghIOv4XESWRU8R11j2TsreaIwF3HpGPHfIcyiU67zronOhztAEVLLYhRPsZQ0nnaRGxdh6di5vYSG5i2Mcx9enkUs95sShphUKwiQuDXv56kntYmMutEQJW8htQEQ8bDA7adBP/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(2616005)(186003)(2906002)(31696002)(38100700002)(82960400001)(36756003)(86362001)(8936002)(8676002)(5660300002)(7406005)(7416002)(44832011)(4326008)(66476007)(66556008)(66946007)(41300700001)(6486002)(478600001)(31686004)(6666004)(316002)(6512007)(6506007)(53546011)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHRBZFVad3BSREFIU0FEMHFJZk00TVh5QlExc1dJLzI2d2x4c0RjcVVTRGF1?=
 =?utf-8?B?OXJXN3EyUlZFcnhTYVdtWE05aHA1aDFybU4vMGk3VERmWlFQQ2puRXptaWlo?=
 =?utf-8?B?RmtWSjB0Yk1XeFJRSWtLWjBkZEpKdis1RkZaOVQ3c2ZOVENRNnNZV2xITFN4?=
 =?utf-8?B?RnI0K3FueUZoSm4zRytVNnlmeUwwOVNCQ2Z2VUFkS0QrL0k5b1hLTGd5RGNC?=
 =?utf-8?B?a2NJQlNLd09LT0JzYWlsRHNtdDk0MGg2VmlkSWlCTmFEeXMvUmxpUkNBL0pm?=
 =?utf-8?B?Y1ZTdUt5bUoyYkdKVFZKTWdXUkMzMllXajFtdnkvMDVacWpOUzNEZWVwUFYr?=
 =?utf-8?B?UDFCdVlueXhmckV3c25Kc0QrL0ZHYUJpUjdUN1BBa2wrQ1F3L29raEM2K2pq?=
 =?utf-8?B?Ulp1RHlzdTRseGdZMzFITUFGejhMY1B0TjV6QnFnMTZCV0toais2SStCd3ps?=
 =?utf-8?B?MFlLdjd2TEl3bXJpRVhSOFdHRkR5TDJVNUxZSW0wa2w5ajVZTGxyWndMaHQ2?=
 =?utf-8?B?WmQ1VjRsaTdPR2JwdDIxaGltOHhoeEFKOEc1ck5Fb1ZiUnMzM1pPNFF1M0R5?=
 =?utf-8?B?cnlHU2RISDhuSjN3ZWFJa0Q1WGUwMm5PNjlYNDNGOGM4M0NhSHFqSWF0QVVv?=
 =?utf-8?B?RkV5K3ZxdW5acnVsaVU4blhjdS81NzlzUmw2NHlwdENqREhUNGRVczduQ0w3?=
 =?utf-8?B?ZXlDaVZiQmkvcU1qVnZ2Ykk4MkllVWRkUmIwVERmYm5aZURXK0NFVVAzOVV0?=
 =?utf-8?B?YUhzNFF1U2lBS2xNSDVSNFdTczRBS3RiTE1nODJJa1JNQng4MlVibGQrRUJM?=
 =?utf-8?B?bW5nL1E1ekZXVHpSRWxXdHVqTGdiUm9oRWtUMlhyK0lUdGNqS0l5OHVoQ0s0?=
 =?utf-8?B?dTJsK1J4NlNvdHdVRHFGTjVOZU1kZ3B4clVVVmFwMmZMWmR4THFvT1VXUnIw?=
 =?utf-8?B?cjFDZ0pFeW5NRTFJWlBHbWhsdTkvRXVpdnRjQmRmdyt1dGgzbFdUTjArN05l?=
 =?utf-8?B?WHFBVFhIZlJLK3dNTG8xWkkyZzV0M3JJZUJ4M2IwZzFiVWJmMzN6eWpxU2VV?=
 =?utf-8?B?Q3BHK3prOTRCMkNxb0NpSzJmMmNyOWdjTWFKc0VyOGNDQnhtMFY3WDh2Y2xx?=
 =?utf-8?B?aEVYcnFQbDF0eFQzdFQraDg4Mm1Sb2o5THpFRy9HSURKbDZIdUF0Qk5tdWdn?=
 =?utf-8?B?a2JveEF3Z1BlK3ZYQzhXVEU0NlJRSk9TTytJOSs5RmlYYnJnM2xsMm5JUGFs?=
 =?utf-8?B?T0VkY01lM0xUTlBtOGtKVVlCM21HRjdvRGp0UVI4VTltbkNLb0hIS2haNXl5?=
 =?utf-8?B?WnBRVFQ2VGdyclFDc0FFZVVBaVFTUG9jbE9DbWg5N3JDaHhmMUlCTTkrLzlu?=
 =?utf-8?B?WDJCZTJkc2ZCaEkxTjNjK21tdllsUGplSWJsaVIwQSsrQUI3VnRMZVY2c1hr?=
 =?utf-8?B?V1l3dnNhdzl5RUdwTG5RbkRwM0ViQ3JqYWRRTGdFZGVGaEhEUFlwUU42NnJQ?=
 =?utf-8?B?aVNUSzFnTEhnZDlrTkRsQUpkbFEwRDdQa2txYjA0ZytTdVFNc1duMFJXUlBo?=
 =?utf-8?B?eFgxaVJIRk9MSG5VRHJCbnNQalRTTDVuVDFIT2JJK1JqczVrMDc5Zzg0Si8x?=
 =?utf-8?B?MXF6ZXF3ZGw0UHRnRjA4Ymx3Qktaejh4WFg1VjgySTd2a0V3a0NVY0pUMzFu?=
 =?utf-8?B?Tm1MWlVwR3BlOU5ZZ0crN2RYeDRBcDUyTStZUFlJKzJuenV5NjlsajBOQnk3?=
 =?utf-8?B?VkdwWHU5ejhCby9zQVF5eHlIY1dLRGs5cDEvdXVua1NiOElGQktoTitXSklo?=
 =?utf-8?B?NHRTUkxCeVE2RFdLWWpINWlXMC81c1E1b0ZtNjdPQm5iZTI0U1ZhK1NKdUFM?=
 =?utf-8?B?K2NZeTcyL3VmYWw0WEZHU0JIb1NZdEZweWpmMW9nWnlCbjRxSmw3V1plTVVJ?=
 =?utf-8?B?dUZDaGpWZGk4cHFPaytKRFdXR2RWUnhYQkFNdTVLbXRTZEZnSEcyOFJzbmdF?=
 =?utf-8?B?UVJzcTNGNUtVSHhad3FmRGVBT2xtRjZSQXlmbkdvbDFVVjdRQS9YR20yVllN?=
 =?utf-8?B?NDUwalVqOWFMMHExMVpkTU9IUHMvNjdpZGo4anJrR3ZWL0NZQjExNEtJb2w5?=
 =?utf-8?B?V3A3eHdRSlIrRmRPV2QzMmZieTRQbWl3UEtUc2lNMG5DRlNnWmRLdU1BVGZY?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 020431ef-4e0b-40b9-0a1c-08db4daf27fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:24:48.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IprsBLOxGTUCphi+P86ye/F+c19vbRpUTRybXSdDxl5j4LPHb6F3lzE7FAgbzPiME35g6ranW39F63AcWvuynThFsPYbbflV3wQOp3RA5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/5/2023 1:16 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 5/4/2023 2:00 PM, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>> The rftype flags have two different prefixes even though they are used
>> Could this changelog please start with some context about what the
>> rftype flags are? Please note that the changelogs are required
>> to comply to the x86 requirements as documented in:
>> Documentation/process/maintainer-tip.rst (there is a whole
>> section on changelogs).
> Thanks
>>
>> After a context the problem could be made specific with something
>> like "rftype flags use the RF_ as well as RFTYPE_ prefixes."

> I can say start with "rftype flags are used for creating the files
> under resctrl filesystem. These flags  use the RF_ as well as RFTYPE_
> prefixes.
> 
> Change the prefix to RFTYPE_ for all the flags to be consistent."> 

I would be careful with the term "rftype flags" since it is
not clear what is meant by this. Note that there are RF_*, RFTYPE_*,
as well as RFTYPE_FLAGS* flags and the reader may easily think that
you refer to the latter.

"resctrl associates flags with its files so that files can be chosen
based on the resource, whether it is info or base, and if it is control
or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.

Change ..."

(A shortcut I used was to look up the commit that introduced the change
and borrow some text from it.)

Reinette



