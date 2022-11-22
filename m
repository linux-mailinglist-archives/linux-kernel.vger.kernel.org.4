Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12206348F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiKVVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKVVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:13:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA571606AB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669151616; x=1700687616;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K5UMD4JxYHtqdaeMCD0EdcVMOLR7FEGcFhmbD6V7aV8=;
  b=XEqfuAddQRH+VPQKmWtT2hvoQymuolIPisfC74WEWDOhpNLr6sXFSVi5
   2t628w7ldUW70KDc+pAo5RFVtFuB2mfHORa/pj37cqOGGWJpcMYyMlTsX
   Wl73alNTAjcgAdTx82HK/Ic+zMac3J0YLhAYMaB8di0kakwwZFc5HoULd
   thssGu22o1wfv3IyEWa7qrFj3SCW6/gEedntbWE5cZGOlWLnZdG+B67Rz
   COSpMQsVrBhGJtfYfnDL5tlyr3spaFsQQNTriRd3UNw0VhzzCcStI1uXn
   8VRm9n6TtLFKqchPER0T2WLgrLrCSSwv/U0rqO5UDbQR1ztO8pn1JK7D3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="294305499"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="294305499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 13:13:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="641553878"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="641553878"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 22 Nov 2022 13:13:35 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.13; Tue, 22 Nov 2022 13:13:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 13:13:35 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 13:13:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kkf+0O5Xmanf9vv913CSUggV2eUxWYCYfFqmP+5cl7yFD2nP4kqScI7bf9JF7ixhoQs3+rrG1ykMDlkzpwlyiSaqaDUcgGo4xNr46xvmnGR483YirffJ2SUktFapWQXsIIzvW8N7ak5ZTjcAUo4P6jARzG9XeUOWl85lmHHujIu1Yv8yq9TcD0K2S7qAnyGoOy9l/97Te5H01LyFI7zQPXogNH0LwSdnebwMSuvJNmBa5wti312Ap5IFyRFYuF2GPoiRtF9LogdHYINiUA27dREhb2v91Tfp7PAZBnE7q4+FhGg7Iym/vwG0SfJIoBDTT8L1XsyUoObl/MsSh5ZR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWrul/psVho/wiM326iZYBBNDseMQrI9XZIf4AEzDSM=;
 b=H7rd4E+baVYWQMT8NT/6IwTZRo5m9AUcrGnrYwP8YAjupJnGMjXA1T+ADTGQLr8lzmFnII+vZrLcv/8lmidhqoW/DbPhKTiLKXJc78c1dyPW163xubldX8I1Dal3RRsK6Ckphj5HU9aPEqhMMOTPUi+OULS8+Yo2cZEn/Yu5VXOdI8vPrkIDBNcX6n4Vki38ejKLnCQMJ3wDbNguYwWk8yoJkKOLTqnyn6LlMBaQotfxS1EkS3Gxz3iY/c4RSp0iojkm0u8KfZmuIVg7pTlE8ATWwS0BsxirlzdCRDLwtcHYKvWnVwEEQt2rSqKfnWQMzOv+/wde4D3X5guFKAVDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY5PR11MB6116.namprd11.prod.outlook.com (2603:10b6:930:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 21:13:32 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Tue, 22 Nov
 2022 21:13:32 +0000
Message-ID: <79ec0082-1813-77f2-f23e-5a10784c3212@intel.com>
Date:   Tue, 22 Nov 2022 13:13:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/2] x86/resctrl: update task closid/rmid with
 task_call_func()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <bp@alien8.de>, <derkling@google.com>,
        <eranian@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <jannh@google.com>, <kpsingh@google.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <tglx@linutronix.de>, <x86@kernel.org>
References: <20221115141953.816851-1-peternewman@google.com>
 <20221115141953.816851-3-peternewman@google.com>
 <85e9d499-5393-f388-7d23-aa68248e5037@intel.com>
 <CALPaoCjiDw5WaQG+yJHgKr9=WrNw606Z8oDwt47Yx+cWZBf6eA@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCjiDw5WaQG+yJHgKr9=WrNw606Z8oDwt47Yx+cWZBf6eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY5PR11MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a42b5e-e4dc-4a31-0923-08daccce687f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTqiSgQpY6PUrH3Q4wmt2rzObNaSAL3/Eg4H83pHgK4z+M6FUsWz9tfVDegg/o2dVXpuyN4e3HooF/1dHXthnF1sKFnzAAhWnNKsomfWKfuvsiqFvioBnssCg6EBAb5K/IspTe7gz35GKqzY6mN7Vt9Z45ERd4IRIP2CHvFb/temEI1zEx/GmyuwuVxu1split60Tg6iumP/pf6SEyNsw0JtqC77faS2VjDLTSKePQiIJwwMFqVhHvHNxkNM+CA2ZIZ56qJ2pU4J2J4Hhm5+wfF9BqwHhQLDXYq+z6if7WE8fELW2iRP5jnARvGas8heyU+L8gHxs81y/pF0lTbWrtUq5WcE2zsYRQ3AfolpsatA01D/uTiZ+CYDo4FqxGJ8IOvczehYt0cXhDTKdxLtpja1QdS/h52/eCWadhdaX/9FE/NGzHvrHBiRwrBxPumApV5s3ss2B5ZHSE4hQUWBJRba+zaYqK20OXZdJXuDBgAtvfQfhs6Dx3qjliZUSbLY84WO2iwKo6t7TwCsfJ93EKLoCtO711x8IQSTn0CR4rDcQ7eobai2IbHqmN7QOLJJYllRY2WKokMonG5oU6AWskHNNqPAWynp3reQOfUmr9BjJZWo5S5oGvQshQkpeLwG3ry3ocVyJuB8mTbOjU13idlJ+e1Op7LohOKhqm6l7lrIpPJMmHnSEl9Yu2FYjd6ZnSD8F5bj7lhbBwfuNcULaCJGz+qSvzAmflmiCLcwybQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(478600001)(6486002)(36756003)(6666004)(83380400001)(186003)(2616005)(26005)(5660300002)(86362001)(6506007)(6512007)(53546011)(8936002)(44832011)(31696002)(41300700001)(2906002)(15650500001)(82960400001)(38100700002)(31686004)(7416002)(66476007)(4326008)(8676002)(66556008)(66946007)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVvS2xlSVdaa3hmTWVGbFhTR0RFL1JwQXM5c0EzQ2xiYUxUdHRUMWJ2ZTFB?=
 =?utf-8?B?SUVMWVlOaFlwNEtsblJnTmlSdSswNjdGNDNSVSt6cnQzbkUydHVLS29SZjdj?=
 =?utf-8?B?alBmSHl2bWRENkRnR1d5TmhkUHJxWitLejh6L2RyUHpZNlRVM1luaDA5Zyt4?=
 =?utf-8?B?Y00vTDZIako3Ui9VZEdkQndybVYwbGYxSm9QckYxRWZHcHJTTjBTSkdqTzBM?=
 =?utf-8?B?QUdydWdRM2VRL2hOT25ZbjdCWWtLbTJEVXlicDlES1lKSWFJY2lCeU9LM2Ji?=
 =?utf-8?B?L2JNQVFhVWZhUVErbm5wOFRKOXAxQXBHTmlzMDhnN0ZaazRVY0liRDZFYzZm?=
 =?utf-8?B?eHJuZXZNd09nbzNZeVZYQWNSU1JVSGVOSmpKOHlVZnJSalBST3ZaaUU1Z3hZ?=
 =?utf-8?B?Z2pzS3hDTERHb0FrNnZVL2U1NjByVWpYUURLZk4vczZaSTl4RDFvUUJMZ0Uw?=
 =?utf-8?B?UUowTzdlS0x1Qm1OVGNXVytJcUp6YmJ5K251bHN6ZjVQdjV1SEdZZk9RK0I3?=
 =?utf-8?B?VERibmJEUjkrTkRBMmFJMWVmMFlRL3QzSm1SMCtVT0JwenNyWTNXU3J0bnBz?=
 =?utf-8?B?STF1RlZxNHJkVFYzMDFYbTNUYWNaMXRkV2JrbjAxSkgweVk1d2diOHVWYVkr?=
 =?utf-8?B?Mzd1OGpBS2w0Uk44T3A5bC9BeDluQ216L0lOVmZaWkVZeWdrSGhwMlNyYzNv?=
 =?utf-8?B?akd6MzVDV1F5VDRwSTROZ25OU0pMVzlQYW1ZNWFuSjRuOGU2Z1FFWlRyczRr?=
 =?utf-8?B?ZlU0VzNIcEhqMzhVUGVKSGVoNHV6eVZPSGJpNTFCS3ZsWWNvcmlKNFhQdzZu?=
 =?utf-8?B?aWd3ZHJmcjVOTmMvODI2U3k1VTlMZ1k3Wk1qYzcrZHg5b0JHRXBvMHBkMFdD?=
 =?utf-8?B?a2lnZHBKU1Fac3VZV2h4ZVVwYXpjRVQ3WGpKZ3I3MCt6dkVPY2RyTTNCZGNj?=
 =?utf-8?B?eG9GSTRMZ3p5SGpueEhFYUFBaXRvZzJENlpwN1NEdjVGSGJWRUxJYXZ6ZFI2?=
 =?utf-8?B?eWQ4ZEkwVjR2alZkSjU0MGUxMExOdHZrVFRXa2hxcm9KUWd0cXAybWNXOVEw?=
 =?utf-8?B?UHhyNVB6RkJ2MVZxNUNuYkNvdHJzR2cxYXhnc3QvUkhCa29xZWVuQUhNRk1U?=
 =?utf-8?B?dklRT0hKU1VHUnZJdU1WWG5YcDkxRENSWU05RDRaaHlEMTV5VkRzLzlpWkV1?=
 =?utf-8?B?Um0zUkpTcU1LeXMxUk9pSFpmYm5FV3J0dlluWHVMMGIvOUFwYmk0VEpwZlE0?=
 =?utf-8?B?VHgyaHp4aTNTU21FeHJaejZFRnhnUGkvNlVLbzUxbVhDTzFVdVhvWVpzS3lj?=
 =?utf-8?B?UXI1N2tSVjlMaUcvcGFGYjJoTmorSUk3RmlwTG8vQ2RpcXJkYlp6QitEeTZy?=
 =?utf-8?B?ZzV4Vy83UzRCckZNTExCUXlaWmdUSmtmd0VGcUcwUzRJNjNnbDA4MGFwYXFa?=
 =?utf-8?B?ZlJZUTlzT2p6YUEwTEdVUmJUQzhRSDlBOTJ0VnY0SnZ1R1hyWlpHeEF4VERi?=
 =?utf-8?B?ZHh3eHNaazNqNmEydjdZM2hvRzJpQ1JQcTZ0dC90K0RrQ1dxc1hLUEE2Qkpl?=
 =?utf-8?B?Z1J3VGJCcU9uY2dqVUgwSU1hOEtOUzBVZWxBQXN6MzllOWRWcDVVMXFreXhN?=
 =?utf-8?B?MWJ3d1RJWG9odlRPL2s4M1ZWeTg4N1F0UHZQazZYb09Qc2ZINEhiRkFmQUpC?=
 =?utf-8?B?NWZ3Q2FReVdrYk4wZUJlbTJzbGVMSHRGVTkrQVNKY0pYZ1JIRDRveG0vNTNH?=
 =?utf-8?B?d3FDM2RYWGozbnVsNkpadmMvWTBQaEpDMFJ4ZGdDLzNpUmR3OE1YbmZvc25C?=
 =?utf-8?B?NkxGVTArWDFzeXlmZU5VQzBoT1BROXVtcHgrNk42WFVhT3c4UURmSkxtVkFr?=
 =?utf-8?B?V1dnd0xhYm5FYUNoQXlDTHdSUm5PU2h0YmtndzlaeEhtaWRSaHFMRE5jL0h4?=
 =?utf-8?B?K3lnMGZxUm5LR2d4ZVVHTDFqdy9TVlN2eHVqT25SL1pyUnErTXhNN1NqWVJP?=
 =?utf-8?B?NmN6TnFhL3JIS0JBaXpUK3lIWDZpMVVrdVpQZ25tb0J2bVI1U1FFbDRJK1dM?=
 =?utf-8?B?WW9tazBHcXZqL1NFSUJZOXdEaEgyOGpHTGZlT1hmNXc0VnpMZUhqTi80bVRG?=
 =?utf-8?B?RU1kTXZiemJTQnZrVHdSMjI4VE9UWmkwOHRPd1A3eEpoVGsrMFF1c3BxSUxS?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a42b5e-e4dc-4a31-0923-08daccce687f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 21:13:32.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmh2JDuNKfm86IUOFV3AJr5dOwFhFdg3q9f2wrBgMjVfRoBDnA7l1ZrY40D9pTlwoU7P0hU7I7N752Xmst2foJXqknqb47XP2jJUGmNwPI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6116
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

On 11/22/2022 7:17 AM, Peter Newman wrote:
> Hi Reinette,
> 
> On Mon, Nov 21, 2022 at 10:59 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> Patch description in subject should start with upper case.
>>
>> On 11/15/2022 6:19 AM, Peter Newman wrote:
>>> When determining whether running tasks need to be interrupted due to a
>>> closid/rmid change, it was possible for the task in question to migrate
>>> or wake up concurrently without observing the updated values.
>>
>> Mixing tenses can quickly become confusing. Please stick to imperative tone.
> 
> Sorry about this. Looking at how other bug fix commit messages are
> worded, they describe the bug as the present behavior of the kernel
> rather than how the kernel used to behave before the patch was applied.
> It seems I've been consistently wording problem statements as past
> behavior.

No problem. There is a good section in the tip handbook about changelogs. 

>>> +static void update_task_closid_rmid(struct task_struct *t,
>>> +                                 struct rdtgroup *rdtgrp)
>>> +{
>>> +     /*
>>> +      * Serialize the closid and rmid update with context switch. If this
>>> +      * function indicates that the task was running, then it needs to be
>>
>> What does "this function" refer to? Please replace with function name to be
>> specific since there are a few functions below.
> 
> Ok.
> 
>>
>> /was running/is running/?
> 
> The task is no longer locked here, so it doesn't seem correct to say "is
> running" when it could have already stopped running.

ok, how about "was running during its closid and rmid change" or similar?

> 
> Also, maybe related, I was considering moving the task_curr() call out
> of update_locked_task_closid_rmid() to avoid giving the misconception
> that the result is current, because the value is used after releasing
> the task's pi/rq lock.

I think task_curr() should stay within update_locked_task_closid_rmid(). It
is an appropriate usage per description of task_call_func() and from what I
understand it is the most accurate way to answer the question "was task
running while its closid/rmid changed?". It cannot be guaranteed that the
task is still running when the MSR changing code gets its change to run but
_update_task_closid_rmid() as well as resctrl_sched_in() have that covered.

Reinette
