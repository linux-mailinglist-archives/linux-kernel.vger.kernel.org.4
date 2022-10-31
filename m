Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34643612E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 01:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJaAsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 20:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJaAsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 20:48:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495C95BF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 17:48:16 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N0vX91LspzVjJK;
        Mon, 31 Oct 2022 08:43:21 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 08:48:15 +0800
Received: from [10.67.111.195] (10.67.111.195) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 08:48:15 +0800
Message-ID: <86d72429-d15a-50d1-f841-ca196011fbc1@huawei.com>
Date:   Mon, 31 Oct 2022 08:48:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] x86: i8259: Make default_legacy_pic static
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <20220823021958.3052493-1-chenlifu@huawei.com>
From:   chenlifu <chenlifu@huawei.com>
In-Reply-To: <20220823021958.3052493-1-chenlifu@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.195]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/23 10:19, Chen Lifu 写道:
> The symbol is not used outside of the file, so mark it static.
> 
> Fixes the following warning:
> 
> arch/x86/kernel/i8259.c:410:19: warning:
> 	symbol 'default_legacy_pic' was not declared. Should it be static?
> 
> Signed-off-by: Chen Lifu <chenlifu@huawei.com>
> ---
>   arch/x86/kernel/i8259.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
> index 15aefa3f3e18..3aa5304200c5 100644
> --- a/arch/x86/kernel/i8259.c
> +++ b/arch/x86/kernel/i8259.c
> @@ -405,11 +405,11 @@ struct legacy_pic null_legacy_pic = {
>   	.probe = legacy_pic_probe,
>   	.irq_pending = legacy_pic_irq_pending_noop,
>   	.make_irq = legacy_pic_uint_noop,
>   };
>   
> -struct legacy_pic default_legacy_pic = {
> +static struct legacy_pic default_legacy_pic = {
>   	.nr_legacy_irqs = NR_IRQS_LEGACY,
>   	.chip  = &i8259A_chip,
>   	.mask = mask_8259A_irq,
>   	.unmask = unmask_8259A_irq,
>   	.mask_all = mask_8259A,

Friendly ping ...
