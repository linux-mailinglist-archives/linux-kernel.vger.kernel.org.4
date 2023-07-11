Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7259A74F80F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjGKSiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGKSiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:38:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873381704
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689100691; x=1720636691;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0QBgpr35Pd6Ol9lwSeUScf1rWq6q1Dz3mY9QHWn8JVA=;
  b=Th8JvNFzNVF7ZNvf/ob+HTFfD+y2CN2Qz4hKVXXIuuMTUwvSDMMAA40N
   tvB0C++duvIVVbaeFtW5u55hrg975m2YVe9rqmS9O7n/ZmpPzACz1gHip
   jnljASCpvZo2zZh/EkarBJL6YfzXrqnjLrXPAa2emPA+TCtTzQ38pxUUp
   fc09ZEOMq2FVFLVM6vbSr27m7JDKfeJHi2WHvx8f2/7POi3x7+K/V1je5
   gSSt6zH5ThdkH8EQnp5nO/vubaFgItw02KxPoZCLp7NNyVINemutg1bMf
   Ta9oRiBsPxWWtv9fWroz1Kbc+Y6IiiRAXwz6zhgtCjrj+aV5pRdM3B3Zm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="362170245"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="362170245"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 11:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="756471600"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="756471600"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 11 Jul 2023 11:38:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 11:38:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 11:38:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 11:38:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bANbPGGMSV9O1htttk3wWa2/re3FfVTqP3wiNpNC9vedwkjeaiDfjioWBEYYeEwbobRY0rlGJrsnw+gqupZnvNnPRz9vs0wJ2Fx3uT5+TEVoBXDVU7uwfaE0XsusRu3ds4O5rGLrJ6o8oZUJTkN6vo3ysK7VQC0fOEOBetcyy/PQO2N4aYl2YKFCdNuUPb5SUvLoM80cGFqzM5MdLMkwD+kJXgb5nSrZdbp60teNxehHkO9ixGingFlxSqM74O3nwI2M3nki1nYQTxbjHnaoVtbljbRZhZ4EDps47PS5sy7bhtfjqEKnXuZhFyh3JkeHdctWKYcXRO7ODAX5EXrr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpMuUD+GiptLjDkx9Fmdb1hWj2B91CyxB3ym0Cpcj/Q=;
 b=kUBFEifXGAmai/BPjdVURGyq1TN+iriUG/ZI2kZ+dCTbTUJsUkLx2ccAMi2JgH7DFZDSyayueRIpe3orOyB13q+04DzkolF6OZde+J9alz+e/5ce3DgizTFqjHbsk0/hMc61Oj+Rmnr5sLd6ELQLMBMlhF7yDX3r9T1neXOYIwHeqy8jrSoCLby8b+p0T6rh1oiF5+Z09pPMMjgJm2VqYNZvt0gCstCiI2LZMVxbzHtkTdLTgLsYVe4FbM3E7GKOeZ5lXCO0J9Fyhw5PXxkdEVMfKrfVdJXC2norbtYHrYju8GgyUq4soN83uGcUu3lYgiYFwnjxvYqJPgKWMuRh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 18:37:57 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8bf3:72a2:a948:8a65]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8bf3:72a2:a948:8a65%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:37:57 +0000
Message-ID: <0837a34c-f66e-aa04-d4a7-b032d3dbab7a@intel.com>
Date:   Tue, 11 Jul 2023 20:37:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [6.5.0-rc1] unchecked MSR access error: RDMSR from 0xe2 at rIP:
 0xffffffff87090227 (native_read_msr+0x7/0x40) (intel_idle_init_cstates_icpu)
To:     Peter Zijlstra <peterz@infradead.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
CC:     <arjan@linux.intel.com>, <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CA+QYu4qSBdhEgFURu+ouAf2d_JNPbZgCSUaxCLoGzMqDQOLWsQ@mail.gmail.com>
 <20230711112421.GI3062772@hirez.programming.kicks-ass.net>
 <CA+QYu4qzJgiiU1qsjtWb9OU3=C=hb_c-Ag5Y4c=Xp_ObfGH=hg@mail.gmail.com>
 <20230711125557.GM3062772@hirez.programming.kicks-ass.net>
 <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230711132553.GN3062772@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|SJ0PR11MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: c0755ea2-678e-4512-c788-08db823df25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yovBrVO7NwNBb6ViAdROwLzqoG9gldE6utGZRIuVPV9PWpPkMwBfa82euhD9wlzrKIPnZUEdD3kI9JGs66NgE/hQWrWF44q4sYSQpKupdpb8o1MOvAxzuTUw9HZs8cfLhMmE14NOc9HkrbsdbQ3v0LiHnyzB/ntWGoGcCNE/oelvTye/3Ozz5YOC/FiM4GqOlLDGaKiRsMW9ELA0rQH2Ps0BeUTre/ARD8A+BFgICZnoZ8IX5kXLFM1535LhtDi6BULP4qsMvAd2bF9kn58p60JFIt9PlhoXl+mM3V/qu88jKxJu5L8jwTgKFyuagSlHVVQkt++QacxCINUtPOwFl7nK+y8HDvIHiMY2vI0QlRitWMl3ppO5MBhDThd7QBcCGQSj6VfpLwuDnrH3+NSOqCvbfcm2qLZ6f9Mya1vboVvK2GcgQnc9BHE+mylDbrqpPMocdvfYpSWuaKRDZGygn1600+3+bAvdzsTKcp0X2VhNRyIdsuxy368pCbSwjHC6eKJq+ycVwwlxc/0pS1emaAY1IEey2G8ei0CgFVqkez6BRAgWcem5tMlttf60w9wD70HAKztkVreMAmJWzavQTHXgN98TPR5hUnV+EddIryEQ3fgYlHb5LC531OMm5vHINE0Hh2fYcWVmJNotLXbazg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(38100700002)(86362001)(31696002)(31686004)(36756003)(6666004)(110136005)(6486002)(82960400001)(26005)(6506007)(186003)(6512007)(53546011)(478600001)(2616005)(2906002)(316002)(5660300002)(66556008)(66946007)(66476007)(8936002)(8676002)(83380400001)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1lObURuR2k2YTc0RHkzRzVSV2JLTnZOaTBHdytiLzZocE9MMXpUdkU5aW9Q?=
 =?utf-8?B?OFliS29KSW43bUtxcFlvdUEzVjZHREpRZFhFYTAvaEZ0U29hbXV2amdzTVA4?=
 =?utf-8?B?Y3E5NXpoeW9GRmQ4NFplc0wxNU90TU1tN1NhZWYzZzZFUHlzQmVIQlpXV2RB?=
 =?utf-8?B?VUtUYVMvNzdIVjlmNU5XVlp4cmxaL3kwZFVUaENzNGVkdzVHakYyOTA5ekFs?=
 =?utf-8?B?QkUzeG1lNEVXd0Z1ZGFWR3pGYlZVNmt1QjR3VDNoZTRxTTI4MkFKeGV6NVRy?=
 =?utf-8?B?UWRWdEtobS9DZjdXa1RxdUZ4MGVHTnZPT3h4Rmt6dXdKTHFjY29zVDNKN3oy?=
 =?utf-8?B?R3JiRk02ZHpBcUFacWJmZWZxRzczWGpranJCVG9SelZ1bmNFS3VTSUJwVncr?=
 =?utf-8?B?clJBbkM4T0MvTzhBWk0xVjY5TWpKR1ArSGt1b005R3ZKQ2pGMWx6L0RwR3Rk?=
 =?utf-8?B?Q3ZPS0ZScTdsN0h1YWFaTlp0aVJBZk0wc1hDV0tQL1ljOFB2c3o5a2tSaXhJ?=
 =?utf-8?B?OXVyL0dKWHdhcXVsTFB6eEpQM0w4dUc3azJ0M2VVMUVsMDkrTlAzS1U5cWFx?=
 =?utf-8?B?L253cXJNR01KNTNkRmczT1FJM3FXNlZza1hDRXZmQlJXeEpkS0NxL0dTUkJt?=
 =?utf-8?B?UHpPQWdwdmZDdHlMU2g3d3F0QmVpbkwvc1FJcUhJdDFKTkNUU3d5VjViZGM3?=
 =?utf-8?B?RjNVWDI3YUNzNTBwVVFaYTB1NEhVZ0RSRE9HUzVLaXZYR3BRSHM4UnU2dlh0?=
 =?utf-8?B?dWRPNzhwN0hqMExHaW5EeDJvT1dhVWh4cTlLYVZwTnFYaEt3djFVaU5KM3Rv?=
 =?utf-8?B?NTIvTGN0dDJsME5SQWNmRUd2Y1J5OGM4a0YzOUhVRjAwMzRPK0liQzJKZlVn?=
 =?utf-8?B?RVJLR0o5d0s4NUZ5TmdlenROTFN1ZFBoVWRGZW43cGt5VzArYzBPWCtuQUF1?=
 =?utf-8?B?VFBOZ3VQSUJsQVZ0a2dHYWFxWkNxcGJ6NndkRmdXeXl2bS9zR1d1NmZnRmdG?=
 =?utf-8?B?RWdsRWpWVzAvYW1Yby9nWTdHc2VIMzdVM0lHQXZpWTQ1MjZzYkVNWmVqU0I3?=
 =?utf-8?B?SDdXaCsrMHNyOVRnV1drTVVXdGtHNU5SelB2Nmh4ZjJMQ25weEt5U1gwUnVy?=
 =?utf-8?B?UHo2ZENyb1ZOVFRDdGphL2c4SHB3eVEvR0NsdnBBaXdTL0lYWTZWTExqenJs?=
 =?utf-8?B?b3E3cXo4U0xiY3hPelVLcGxrUE11elU2UlRoT2E2YkZza2E3U0lSaVpRekdo?=
 =?utf-8?B?bXRqZlArWGxJTkd4L2hkVU9rd3RxYlk1ekxIYU9Xa0hLeVBXRWRPRTBINmp1?=
 =?utf-8?B?UmxPTGlIbngwMElUWmo1ME9oK3dOcnl2RmdhVlh0QlY4ek05eXpnNy9ZYVE2?=
 =?utf-8?B?M0FXa05lU1pvRWkvbnNYZEovcC9lbkVpcFo3UG9rTURDY29ESzU5U25GamtB?=
 =?utf-8?B?bmZOMk1kdFJjcGdJRXBKZE9TU1J2VjcxSjhaQ0hsNzBOVWJ3dWFyM2ZtTFhZ?=
 =?utf-8?B?OStRYkN4Q0N4K1gxOUkzWDE3L0QzV2tvVU1BWFlzbXVBLzJaQUNIMHlWMEZC?=
 =?utf-8?B?ZGNCeE5wMllnNXRHdzRmTy9ERE5ENGc3QW8zekdScjRQY1VtNmpiRHZCekNG?=
 =?utf-8?B?QytDeWxmOEhQdURSeG1zUE4zOFRjYlZSWThyS2x3QVhOdFV5SzZTa3NXVEpj?=
 =?utf-8?B?K3BjS3FSRytyZzdOU2JNZG1rSkZPVWIwZ0lkeWpLQ3NzZVZqMkY4ZHIzUklz?=
 =?utf-8?B?VEhXamZpbDJMb2VYU0FDaTFlaUNiUmFTb1E0UHdyNmM0QjRaSTJkNGMzVzNp?=
 =?utf-8?B?ZW5GczZHenNXb3JpMXc1eDNaRWdhd0FYK1VjeDIxdXc2UGZuYlAwdjlOZjND?=
 =?utf-8?B?VE5qV00wT1ExMkxJZ0RWMFhYOVhXeWNuME13MCtUd2NLcWM0K3dITVRkR2du?=
 =?utf-8?B?WE1vbFp0MUpnTm00MCtIdnFFU0QrQ2R3cHU0T0dEWS9xMzhZcXJvZVhkcVU3?=
 =?utf-8?B?UERkc1ZmUjhEZkQzY0VRZm0yQStxem1MWXRTWFc2M2QyNWdQQ1gwbFJRSGFs?=
 =?utf-8?B?N1Rwb2l4SHYwa3FMbHljZVBaaEtqckF2RlE3TE0zNHdpc2d0d3hqckRvektj?=
 =?utf-8?B?blpJRFMzdlVLN3RlWTZmL0d6OThnTFBGTlBLUWRJaUhSdHZva003NGtRN0dG?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0755ea2-678e-4512-c788-08db823df25f
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:37:57.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLlsq4NzS5TDYL051bF9XtaA0MPmSVZW8AaI7R6L9AccL9p8TLVGDEaJ/pLohEMgRrrX1jbAjoq5MwmEC1NrTPVAjJFMcrf1ZNZObPdhY8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
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

On 7/11/2023 3:25 PM, Peter Zijlstra wrote:
> On Tue, Jul 11, 2023 at 02:55:57PM +0200, Peter Zijlstra wrote:
>
>> Oohh, this vm-guest mode is new :/ But it doesn't make sense, that
>> commit babbles something about waking CPUs from idle to do TLB
>> invalidate, but that shouldn't be the case, that's what we have
>> kvm_flush_tlb_multi() for, it should avoid the IPI and flush on
>> vcpu-enter.
>>
>> Arjan, what is the actual problem you're trying to solve any why hide
>> this in intel_idle ?
>
> static __always_inline int __intel_idle_hlt(struct cpuidle_device *dev,
> 					struct cpuidle_driver *drv, int index)
> {
> 	raw_safe_halt();
> 	raw_local_irq_disable();
> 	return index;
> }
>
> Which does:
>
> 	STI
> 	HLT
> 	CLI
>
> static __cpuidle int intel_idle_hlt_irq_on(struct cpuidle_device *dev,
>                                     struct cpuidle_driver *drv, int index)
> {
>         int ret;
>
>         raw_local_irq_enable();
>         ret = __intel_idle_hlt(dev, drv, index);
>         raw_local_irq_disable();
>
>         return ret;
> }
>
> That is nonsensical code; because now you have:
>
> 	STI
> 	STI
> 	HLT
> 	CLI
> 	CLI
>
> And that makes sense how?
>
> Rafael, can we please just pull these patches and try again later?

I think you mean "revert"?

That can be done, but maybe it can be fixed instead?


