Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511826D565E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 04:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjDDCDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 22:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjDDCDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 22:03:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D71980
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 19:03:35 -0700 (PDT)
Received: from dggpemm500013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pr9wK67JKzKrSc;
        Tue,  4 Apr 2023 10:01:05 +0800 (CST)
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Apr
 2023 10:03:33 +0800
Message-ID: <c2b8abb2-3a1e-6c49-6d3d-d8b29232e41b@huawei.com>
Date:   Tue, 4 Apr 2023 10:03:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] x86: profiling: Using generic unwinding in profile_pc
Content-Language: en-US
To:     Andi Kleen <ak@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
References: <20230224021858.120078-1-chenzhongjin@huawei.com>
 <dc0625d2-edaf-22fe-5eea-3088e95a2998@huawei.com>
 <96d44033-3bfd-840b-15d7-80dd3a1a5313@linux.intel.com>
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <96d44033-3bfd-840b-15d7-80dd3a1a5313@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/4 2:29, Andi Kleen wrote:
>
> On 4/2/2023 6:24 PM, Chen Zhongjin wrote:
>> Just ping... Or has profile code already been obsoleted?
>
>
> I think it would be reasonable to remove the locked functions hack 
> since lock profiling can be handled with much better other tools these 
> days.
>
> I wouldn't make it depend on the generic unwinder since such a low 
> level facility is likely better off without complex dependencies that 
> could break.
>
> -Andi
>
>
Although now the generic unwinder on x86 is quite stable... I think it's 
acceptable to remove the locked functions unwinding
for !FP case and leave the FP part as is.

I'll send a new patch for this with another bugfix.

Thanks for review and best,
Chen
