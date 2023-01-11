Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470876650D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAKBCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjAKBCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:02:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8281B26D7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673398928; x=1704934928;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A1l2dksFdvG45jbT4myeFpqA5sbTdvmge7Gfz07ujCs=;
  b=i+EvMpjud4el08/R9c9g34yMUQVG1BM38u7Wb6Z0WOiR14J6jtqAG2Pq
   PvfEhQ2VShRJumc/OJ10icFQxQo4Hy5R2XXNDTv6qDdi4/4m23VwrKbsw
   aWxspNWEkHy/OOGVfNWOSLSBHzUduajCzQSu7cXzlekRdB3H+HqiC8keP
   QomWFn/xzupx6DL1vpoWQVGaeT7Ig2tUe6TheegjtFntBc3X57U+zWY0S
   R6HH8x2zOp5EkSyINMMJ9n4izr+oDkOxI3HRN65cfvhbepiLCYHbOk52M
   YJUHKWNIg11CRGDBdsgDsZPS2fkczhqHruH6BUYwL08ujDY6i7/kdX5YE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306815702"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306815702"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 17:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607174250"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="607174250"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 17:02:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 17:02:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 17:02:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 17:02:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfTUNECJQMNZyEPvEBOD8kUoOyI4KNRq1eORFv7Wd63ekg2NpmLzfsfUSNkV6Mp5VPR//uCcwBzXB827e0XIkqVdHQAAiG4D+ZcAf0CpTYgqZuB+g9frMkaKi18nFwdLlk83k+cptmW7bihNR3pxt4TjcNzYQnW1aSknk8ZBzbBGwmBGRDhXsVh+/+irQ3BdN5xfTm3qCQHijbTGy8ppxWAHNfui9sWKoIkWhaZZUNHHNT2+SM0b2vmcTVfk3iDW7emiEBNC6LVjp6rEck53/uV2W/L0elZwOm0fYi/bZjT7ybMHlRqxsjru3giDHwbNaEutjEe+nEJ6koyKQRkIxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl6d7LsJalYNvXu3TiyxRLNisiUFR8cNReeJyTkXovc=;
 b=PvluFiY7LTBtsz0adaC/91gAR08n3kcrVgXDV1KTmSBBteQ0GjLTdqaGo6iuwXOPLlTd4PTbjLDiT8GYhpiC/OE+dyChvpPXhmShJ/gJbA2VI0slKIh61IsbU0s0N8oDNCgQFHJuWeJ+uhdxT+oYe7ADkUmEVLkmVEPEc2+ySuoYqXdNB22nHirM6I6hAI4MX4tkn1dATMTRziOgZ/elzBLMGY1XwRAOGd6ybuSUNQio1tbmh1E0lKawnGiGdNEF8/yCvDqdjdwPoY1MxbkPamp8YdryVaJWxKkaTN7t4pMF6usjy9tZni7suhtgB/Y/2anQyxuyIno+CO/R78PwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by SJ0PR11MB6695.namprd11.prod.outlook.com (2603:10b6:a03:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 01:02:02 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::1fe5:3ce9:9a3a:7de7%4]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 01:02:02 +0000
Message-ID: <34600873-3716-eedd-84d0-dada88dc1a70@intel.com>
Date:   Tue, 10 Jan 2023 17:01:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
 <Y73S56t/wDIGEPlK@hirez.programming.kicks-ass.net>
From:   "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <Y73S56t/wDIGEPlK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|SJ0PR11MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: cb857ce9-8563-45c0-4527-08daf36f730c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZJvBR/VXlgiHswqzXhi3BpToh0La7QI7Z4O1CkEhHotJOpI1WdkOlRvd1MC+t2lKIBD+HR1LxX5jPSdmxKIGQMRN3vSuCwkmeukWEyhJtf1IzntDz0yZeRMi+QJECCvrqiWQ08OPpY3dN9Ti5PveBT9fbcwBGoZITYYHFF1a6WqfieHfsjN00IqjjFnWGiPM6NSgm+btX0JMUwp3XSCdalYDlgDiR/1SntNH7JmJy5SbL54N8oBIPChtt0JqgAyKu0Tqc5e3mQvvWilkvxwW0BVYUYpXF9vG2n4w4LBNJ2USy/9n+Go+2GBqvJqfQ2WtBAucGjqnSB8mopQrL7eVQIO11WUBfELBxIHjRs/KL6DQQ90CHmOrYH/UuDKNAGNLRKvB28lQ9HY0z9I8p7as64OZdjHNxrO0F9v1gDd4mGA18zIVxOC0PjgP2MdM6ESsnNYOloXhZ/h+JIPQwsB827JJgmlJ04fH+xVBhBlJEKEPlZkR8S+dm+DJAw4ZreQZnhiceegQmck0YqtbTGo9zSclXo5Wq2CB0oKfpuFkFlpm0i8vbj5vuG0emw22S1y4sjkp/z3yRxcTluonRO6H6dWu0YMLkhMFy17MJ+HF+5e24mvL3RdSFbTFRjxToVB/BDxj0SgctsuV6TUNQe13wV0qa4tpoixt7xI/THNxV16rOzb4X0BVepIFwy4N+2N78ab8pyqjGOqeOa1bEdRB8V8z+O7LmrG2UqBBOjrmoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(41300700001)(66476007)(4326008)(54906003)(8676002)(2616005)(6916009)(36756003)(66946007)(66556008)(86362001)(31696002)(82960400001)(8936002)(38100700002)(83380400001)(5660300002)(316002)(2906002)(53546011)(6506007)(31686004)(186003)(6486002)(6666004)(478600001)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkJiT2dOYTF6eEQvazVUTXdUaVVPdGszbk1vQ0VTUUg1SSsyTlhYWGozb3ZM?=
 =?utf-8?B?QVdudWxhbXlqeGo3MVFDMW9WUW5iSTR0QkNBL2t1cnU3dW5lZmRDL3JOa0ZR?=
 =?utf-8?B?dTVPTVBRRTc1MHhCZHNTZmYwUzA3c2tIS3h0czJnbnRmSmlHUkRqQVlKaUtJ?=
 =?utf-8?B?V2dZM2N3K0lvenhkU0tpUWJkOUw0Y3Q5K00wNHgzdFNKaGRTM09VZUQ1bE1x?=
 =?utf-8?B?N1IwTmF2UkM1dzZDV0FGeUxudGFWMlBycG0vYk9xdkdYRVliVFUxNDVQT0RD?=
 =?utf-8?B?ME1GTjNLdU92L2hSbVFiSFBRNDR4S09kS3A1MnVkMTNBdlpDVENHTHJJTnA1?=
 =?utf-8?B?b3NLVkdlWitJeC9vQUI0MFc2cENWT2cwcXgxMnNuM2EzaGNyamhzU1FxTUpV?=
 =?utf-8?B?QW5MSWFWL2IrNnlBc2VBbFJWaWVrN0pEcWJMcjdTK041K1NkRzlGb2x2NU5p?=
 =?utf-8?B?ejRlSkE0aGcvV003OW1QMlIxQmwxT1l0RHBDK1I5SFJWVzZsREUvQ2ZUcWI0?=
 =?utf-8?B?ZHhEaEU4MnFESWUzaXdQZUQ3S3BOVHJKZHd6WVNCTlM0NEJYUVdPN3VnbFFL?=
 =?utf-8?B?cjZXVHJEcjBqSkUxZGswZDVTdldDNnlvU3JRSHlUbTlIYWNweVBTZXp3NTE4?=
 =?utf-8?B?dEFYNkJhcC9OdjlGRUpHTlB2a1VBNldQNEEyU2VpQ2ZOTXU5SXBSbnduMkxE?=
 =?utf-8?B?NTViR2ROT29QMDQ4M3hJS2Zvbld3KzZKN09MZVJ2cFA3aEp6T3lGSXpDa1cr?=
 =?utf-8?B?TzhuemdpMWJzcEN1NDg3ZDdOK2VIRjF3Y3Z4bzYxL0cwSk5VOHRhSGp4eldZ?=
 =?utf-8?B?ejUxMU1SNzNIdnk1azd1KzZSSldBNnZ1d2E3a29OWW5DK0VjRWc4WjFqNE52?=
 =?utf-8?B?L200QjJQdFRDMko3eWErd2Q1TC95MEw1UFh4VkIxSHVZcjY3dTAvb2hqMTNB?=
 =?utf-8?B?MlB4dElYKzFSaDkvN3dEVG0zWm9zQllyRXhSMmZDOElsQ1VMM0Y5R0paSEZK?=
 =?utf-8?B?TUZYanFmaDc2Y0VDbGx5dEdNRnBCaS8yUzRlZTgxZU56THBkTkgvM1JDOTFL?=
 =?utf-8?B?aWxieUoyUDdtQzFYZWc1M20vaDhVT25oa3Q5eFdSYkRVdldTUlpScTgwaDhS?=
 =?utf-8?B?RXpRZTRRNU9kWDlXOHNEdm5KSWlkS1ozM3J0RWFaUndVejNPd2Jha2tYazgz?=
 =?utf-8?B?eEF5dGIvY1MwRElFZkFDakRkcXpaMDYwazJ6a2pTeEUzVjNTVmpqeUFIYjdI?=
 =?utf-8?B?elNNczFWb3BJa1B5bDZsdmE1OUdHUDFXaDNSUlhtcTBteUVTaXpoZUNGMmxR?=
 =?utf-8?B?blV4bk5SY1A0U0JyZHNzanpUekxnVEY4bVBtUENCMlJKVEtSTWVjNVZQMFNR?=
 =?utf-8?B?YnE1WU1CSkhkLytYUEVHNnJybTR2L0lZd3cwRU8xRGJKT09nck1aYjhOZHBR?=
 =?utf-8?B?SFVhMFZpQUhWK1BLbnZQZXFFOTRWejRseGlYUGoyaEdFUzVvcVlCN3VrNkcz?=
 =?utf-8?B?dTZ2dENRdzhZTGV6UHh2b0xkejVPaUVSSWxkVUxVMjRMcFJSTUZUazVFQ2VB?=
 =?utf-8?B?eDNXWGVBeDVucmcvSlljaXprazFHcHljZHpJUHZCVlRoc3dvUU1iS0hyR1FQ?=
 =?utf-8?B?SXdFeUFUZjFSbU9zdk13R2FheDVaSEhCdmQwR292S2luV3lGUHhFL0NlMzdy?=
 =?utf-8?B?QnI5alhVb2hoOXplRWxxL1dITUVHa0EvR2pQWklsT2cxb29lT3BtTFVTZXRO?=
 =?utf-8?B?K0pEY1Nnb21laXkxYm82YTRBZzF0eUpuNGVGQzJ6TVdGMnZrb3RXODB1dTEx?=
 =?utf-8?B?NHNyc2taMFNwTGVsTTlRL0xidHZRVEdySnpOUnJJZmxLTTEraVdvQTh5TG1L?=
 =?utf-8?B?ZlN4dytDNjdwck1Cem5zMSszZDJ3RktMcTFtamdGTENUTmJwOVVsVlk4aTZX?=
 =?utf-8?B?SFZ5NGhJeXFpd2Qxbm9Na3cremdEck1QS2VxNGQ2NzMyZVI0ZDhyZ3pnRGNu?=
 =?utf-8?B?dm52eUE2dTNBa3U1ck5RVmRtOGpBTXNCazJkVjRCaVVhQVJreUFPMERzaElz?=
 =?utf-8?B?RnJBYVZzZkFmRFJFaHNjYU56dVMyVituT2dpQVBDbXIvUUhES3hjOG5CcytX?=
 =?utf-8?Q?WzW4JbbmLc6H1u/E6JS3GJH0O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb857ce9-8563-45c0-4527-08daf36f730c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 01:02:02.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZEF3PsnYZY4WmF06wf5sbUGAUs9KdYTM0Gk+02X8SeF4CqXF6K80jehVoh9TwrfbuU7utsbjDsNSV9GAS6vtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6695
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/2023 1:04 PM, Peter Zijlstra wrote:
> On Mon, Jan 09, 2023 at 09:52:00PM -0800, Yian Chen wrote:
>> Most of the kernel is mapped at virtual addresses
>> in the upper half of the address range. But kernel
>> deliberately initialized a temporary mm area
>> within the lower half of the address range
>> for text poking, see commit 4fc19708b165
>> ("x86/alternatives: Initialize temporary mm
>> for patching").
>>
>> LASS stops access to a lower half address in kernel,
>> and this can be deactivated if AC bit in EFLAGS
>> register is set. Hence use stac and clac instructions
>> around access to the address to avoid triggering a
>> LASS #GP fault.
>>
>> Kernel objtool validation warns if the binary calls
>> to a non-whitelisted function that exists outside of
>> the stac/clac guard, or references any function with a
>> dynamic function pointer inside the guard; see section
>> 9 in the document tools/objtool/Documentation/objtool.txt.
>>
>> For these reasons, also considering text poking size is
>> usually small, simple modifications have been done
>> in function text_poke_memcpy() and text_poke_memset() to
>> avoid non-whitelisted function calls inside the stac/clac
>> guard.
>>
>> Gcc may detect and replace the target with its built-in
>> functions. However, the replacement would break the
>> objtool validation criteria. Hence, add compiler option
>> -fno-builtin for the file.
> 
> Please reflow to 72 characters consistently, this is silly.
> 
Sure. I will format the commit msg guideline.

>> Co-developed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Yian Chen <yian.chen@intel.com>
>> ---
>>   arch/x86/include/asm/smap.h      | 13 +++++++++++++
>>   arch/x86/kernel/Makefile         |  2 ++
>>   arch/x86/kernel/alternative.c    | 21 +++++++++++++++++++--
>>   tools/objtool/arch/x86/special.c |  2 ++
>>   4 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
>> index bab490379c65..6f7ac0839b10 100644
>> --- a/arch/x86/include/asm/smap.h
>> +++ b/arch/x86/include/asm/smap.h
>> @@ -39,6 +39,19 @@ static __always_inline void stac(void)
>>   	alternative("", __ASM_STAC, X86_FEATURE_SMAP);
>>   }
>>   
>> +/* Deactivate/activate LASS via AC bit in EFLAGS register */
>> +static __always_inline void low_addr_access_begin(void)
>> +{
>> +	/* Note: a barrier is implicit in alternative() */
>> +	alternative("", __ASM_STAC, X86_FEATURE_LASS);
>> +}
>> +
>> +static __always_inline void low_addr_access_end(void)
>> +{
>> +	/* Note: a barrier is implicit in alternative() */
>> +	alternative("", __ASM_CLAC, X86_FEATURE_LASS);
>> +}
> 
> Can't say I like the name. 
Indeed, there are alternative ways to name the functions. for example,
enable_kernel_lass()/disable_kernel_lass(), or simply keep no change to 
use stac()/clac().

I choose this name because it is straight forward to the purpose and 
helps in understanding when to use the functions.

Also if you look at bit 63 as a sign bit,
> it's actively wrong since -1 is lower than 0.
>This could be a trade-off choice. While considering address manipulation 
and calculation, it is likely an unsigned. I would be happy to get input 
for better naming.

>> +
>>   static __always_inline unsigned long smap_save(void)
>>   {
>>   	unsigned long flags;
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 96d51bbc2bd4..f8a455fc56a2 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -7,6 +7,8 @@ extra-y	+= vmlinux.lds
>>   
>>   CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
>>   
>> +CFLAGS_alternative.o	+= -fno-builtin
>> +
>>   ifdef CONFIG_FUNCTION_TRACER
>>   # Do not profile debug and lowlevel utilities
>>   CFLAGS_REMOVE_tsc.o = -pg
>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> index 7d8c3cbde368..4de8b54fb5f2 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -1530,14 +1530,31 @@ __ro_after_init unsigned long poking_addr;
>>   
>>   static void text_poke_memcpy(void *dst, const void *src, size_t len)
>>   {
>> -	memcpy(dst, src, len);
>> +	const char *s = src;
>> +	char *d = dst;
>> +
>> +	/* The parameter dst ends up referencing to the global variable
>> +	 * poking_addr, which is mapped to the low half address space.
>> +	 * In kernel, accessing the low half address range is prevented
>> +	 * by LASS. So relax LASS prevention while accessing the memory
>> +	 * range.
>> +	 */
>> +	low_addr_access_begin();
>> +	while (len-- > 0)
>> +		*d++ = *s++;
>> +	low_addr_access_end();
>>   }
>>   
>>   static void text_poke_memset(void *dst, const void *src, size_t len)
>>   {
>>   	int c = *(const int *)src;
>> +	char *d = dst;
>>   
>> -	memset(dst, c, len);
>> +	/* The same comment as it is in function text_poke_memcpy */
>> +	low_addr_access_begin();
>> +	while (len-- > 0)
>> +		*d++ = c;
>> +	low_addr_access_end();
>>   }
> 
> This is horrific tinkering :/
>
This part seems difficult to have a perfect solution since function call 
or function pointer inside the guard of instruction stac and clac will 
trigger objtool warning (stated the reasons in the commit msg)

To avoid the warning, I considered this might be okay since the poking 
text usually seems a few bytes.

> Also, what about the EFI mm? IIRC EFI also lives in the user address
> space.

I didn't encounter EFI mm related problem while I tested the 
implementation. I will update you later after I investigate more around 
the EFI mm.

Thanks,
Yian
