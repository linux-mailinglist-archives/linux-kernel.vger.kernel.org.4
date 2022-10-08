Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6270E5F8465
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJHIrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJHIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:47:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607A4B992
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 01:47:37 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MkzJh2GhtzkXw3;
        Sat,  8 Oct 2022 16:45:08 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 16:47:35 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 8 Oct 2022 16:47:35 +0800
Message-ID: <2a887f96-93d4-90ed-cfc4-61e895b102cf@huawei.com>
Date:   Sat, 8 Oct 2022 16:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] x86/tsc: Make art_related_clocksource static
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <feng.tang@intel.com>, <gregkh@linuxfoundation.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220823021821.3052159-1-chenlifu@huawei.com>
From:   chenlifu <chenlifu@huawei.com>
In-Reply-To: <20220823021821.3052159-1-chenlifu@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/23 10:18, Chen Lifu 写道:
> The symbol is not used outside of the file, so mark it static.
> 
> Fixes the following warning:
> 
> arch/x86/kernel/tsc.c:53:20: warning:
> 	symbol 'art_related_clocksource' was not declared. Should it be static?
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>   arch/x86/kernel/tsc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..a78e73da4a74 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -49,11 +49,11 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
>   int tsc_clocksource_reliable;
>   
>   static u32 art_to_tsc_numerator;
>   static u32 art_to_tsc_denominator;
>   static u64 art_to_tsc_offset;
> -struct clocksource *art_related_clocksource;
> +static struct clocksource *art_related_clocksource;
>   
>   struct cyc2ns {
>   	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
>   	seqcount_latch_t   seq;		/* 32 + 4    = 36 */
>   

friendly ping ...
