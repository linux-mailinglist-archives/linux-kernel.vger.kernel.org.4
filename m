Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048B26BD7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCPSN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCPSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:13:54 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6AB8A52;
        Thu, 16 Mar 2023 11:13:53 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id i24so2760852qtm.6;
        Thu, 16 Mar 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990433;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Y+m9u6K4ht070eqey27O7Njm/6Af+oMlELqKeLBTAs=;
        b=BxbvFYClu2tJEkrQ1aCoXzMiQo7deUDhlXfMRuBTKLEOMFnfCfaa5Z71efIwxDqLXa
         cIcjgql0bzEN3OcnxPX5M2KEMiri2vuWNsRYHlFGW0hEunZiYklKdGZkqZ0jk79RVbKD
         7nkjaGXsOw7lZQ+744etw22ijPKgZv+rjIbFNKQQGKhN5jiSrTmiFbo2+pdneQ9ryAga
         4+TMSL+WlwyPQnpXVH3VFr4xQ4FO2TZ2XqDVEjrJpw8LvA/m5326D99epLYiYbvASNNF
         pzOtgsFB47FJi7KILxxKrAoJzDJn1lx3w1WvXpUtV5pGvpSNwBInuXrnzI5FHHuMi5Fh
         7geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990433;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y+m9u6K4ht070eqey27O7Njm/6Af+oMlELqKeLBTAs=;
        b=O+J1M48rb7Az8gDz1bknHe74oc02Z2QUCs6JdanHrOjyUZpJFKNAQ9wDRykmEtugwc
         nm8lkVsCJSEILEbl34K1hWadixZHgEIv8ZknpIox1a2Ot3mZdgaWuHDu8F2L4bssLrzR
         p51Z2JiLvbf4Jt2LChGgxIhXFiPpA1y6JOlIv8fWwmlQHytz0cJKwOpGnRS1+AlLsWIe
         5GC0FL+BIcx7P6YUxyrvY0RD3k/Sxsi+t3g4mGDIw/pyFyAWMIpCEF+GIFI8Vp6MJZTJ
         7s4wCIeRLrjgqauUBuNPf+kuUFwRTWLAiaDTc/rPimKvK/DcVt6Xud/TFhKTnMTnJ9cj
         tFew==
X-Gm-Message-State: AO0yUKVUtsmgrtxiqyNEoDx2Mi8EE3OX5uS45znh6z0ATYroWgO9WBBX
        t+SKSMErHJK4ICq2US9lAR1ooAJzO5s=
X-Google-Smtp-Source: AK7set/YRJZqqUiXIuY2tRb2sExTNprdGead/jMTHFL53RzrmWpDfqy1sAN1NKt4X2/4C2hNHabbRg==
X-Received: by 2002:a05:622a:54d:b0:3bf:c7f4:24b with SMTP id m13-20020a05622a054d00b003bfc7f4024bmr7617754qtx.42.1678990432205;
        Thu, 16 Mar 2023 11:13:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b17-20020ac86bd1000000b003bfd27755d7sm97570qtt.19.2023.03.16.11.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:13:51 -0700 (PDT)
Message-ID: <aa72bcfb-b366-f373-60c5-99404109c482@gmail.com>
Date:   Thu, 16 Mar 2023 11:13:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] irqchip/bcm-6345-l1: show MMIO address
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de,
        maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316180701.783785-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230316180701.783785-1-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 11:07, Álvaro Fernández Rojas wrote:
> It's safe to show MMIO address.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

This is going to be the kernel virtual address, and while on MIPS it is 
easy to resolve to the physical address because these platforms map 
registers through KSEG0/1, on other platforms like ARM/ARM64 the kernel 
virtual addresses are pretty meaningless unless what you want to debug 
is how ioremap() mapped the address.

I would rather do the following change:

diff --git a/drivers/irqchip/irq-bcm6345-l1.c 
b/drivers/irqchip/irq-bcm6345-l1.c
index 1bd0621c4ce2..832957d363a4 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -261,6 +261,8 @@ static int __init bcm6345_l1_init_one(struct 
device_node *dn,
         if (!cpu->map_base)
                 return -ENOMEM;

+       request_mem_region(res.start, sz, res.name);
+
         for (i = 0; i < n_words; i++) {
                 cpu->enable_cache[i] = 0;
                 __raw_writel(0, cpu->map_base + reg_enable(intc, i));

such that this shows up in /proc/iomem. WDYT?

> ---
>   drivers/irqchip/irq-bcm6345-l1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
> index 6899e37810a8..55a2d9b31597 100644
> --- a/drivers/irqchip/irq-bcm6345-l1.c
> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> @@ -335,7 +335,7 @@ static int __init bcm6345_l1_of_init(struct device_node *dn,
>   	for_each_cpu(idx, &intc->cpumask) {
>   		struct bcm6345_l1_cpu *cpu = intc->cpus[idx];
>   
> -		pr_info("  CPU%u at MMIO 0x%p (irq = %d)\n", idx,
> +		pr_info("  CPU%u at MMIO 0x%px (irq = %d)\n", idx,
>   				cpu->map_base, cpu->parent_irq);
>   	}
>   

-- 
Florian

