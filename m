Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A6E7141C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjE2Bvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2Bvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:51:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050FEB8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:51:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d44b198baso1907014b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685325095; x=1687917095;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPRHttCC09H4/tUnTXoXcgLVvVhSGfEl39Ynz6A4OtM=;
        b=V519c/gbuue/T92+R4H0pBg1sxGlRJprFhuCh0JHMw49sp4ZQriafpp+D5tGr4f8Bm
         UFcuu9nCVKRk+Xs5HY5AxGTNhbHM0hWC8ejexIMWeRuQbfULB6xjiJW36P39rxz1boJV
         SQAbGk0eu/T/sEk/Rxd9CeB5US7iRzRPX8eEA8AITlH1rGZHia6KQybulgmCVsx70rSq
         L809pQS6ffm6BMEIm5dJY2RFFsjiJOR2GJdeYL+PyOm3WXW1S45PD4ejG9rRkO9OMHft
         5h1dWqtzCzQ0najzmjyTyxdoGljDz/dDAj/p+C2cX7o0K/Ookogd9CcNKOQFv8sV/iJK
         YNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685325095; x=1687917095;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gPRHttCC09H4/tUnTXoXcgLVvVhSGfEl39Ynz6A4OtM=;
        b=eTMQ1qbCMTEsmdj2Uuii7hu8Gjx6z9IYFy6xOhLt5l3KP0lCYben9rSqrBs7ojU628
         DEHIMv72yQ/9tzKmirD4K6JHMGmmiaAjwRiJNnFQKjxb8ZMCB2rWGSrpuBAsMczZx/32
         E8qMtIxHbgwD61QIG3L5jK89K/FS/l6F3MNvNqJQRYUONc5N7880LYf/47NhY2xb5mjY
         LUrC53RRx8WGZid/zWGv+sHpmnOltdpTkOrSbCke9xz2lL3wDsRO6PCd8jAbLbqrgevF
         lBhFBP/pgZrmOfp9vQhDcHU+/3Ona6CqcxRoAjaJoOkrb1i2I24pwbHYrOXm42sqqHjw
         fGuQ==
X-Gm-Message-State: AC+VfDxuGiBJC8j6oiubDasENHClEvh0g3PtVLdzLNZZ1O/dN4I1tpq5
        zVBEqPjFnmScrrchp1/3FT5t3LYgo2o=
X-Google-Smtp-Source: ACHHUZ5eg9u2gFQ/NpsWDKl0x6LFq4+4SZ/VN1BEeZ26O2vXPPAebeK2u1iGkJbCbKUybu4MaidBHA==
X-Received: by 2002:a05:6a00:1742:b0:647:157b:cb61 with SMTP id j2-20020a056a00174200b00647157bcb61mr7382873pfc.7.1685325095172;
        Sun, 28 May 2023 18:51:35 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-34.three.co.id. [116.206.12.34])
        by smtp.gmail.com with ESMTPSA id s22-20020aa78296000000b00627fafe49f9sm5661178pfm.106.2023.05.28.18.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 18:51:34 -0700 (PDT)
Message-ID: <6a10ec48-3940-cd8d-5e34-b9ade9f87b82@gmail.com>
Date:   Mon, 29 May 2023 08:50:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux x86 <x86@kernel.org>
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Bert Karwatzki <spasswolf@web.de>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kernel/cpu.c: linux misses the initialization of one CPU
 (off-by-one regression)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Since commit 18415f33e2ac4ab382cbca8b5ff82a9036b5bd49 linux misses the initialization of 1 CPU when the CONFIG_NR_CPUS is equal to the actual number of CPUs in the system. One can work around the issue by increasing CONFIG_NR_CPUS or apply the following patch:
> 
> From aa5ef661936655f0d806fdbf2d28fc9513dd5c69 Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Sun, 28 May 2023 14:35:45 +0200
> Subject: [PATCH] Fix CPU detection when CONFIG_NR_CPUS is equal to the actual
>  number of CPUs.
> 
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  kernel/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 005f863a3d2b..5e900b531827 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1770,7 +1770,7 @@ static void __init cpuhp_bringup_mask(const struct cpumask *mask, unsigned int n
>  	for_each_cpu(cpu, mask) {
>  		struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>  
> -		if (!--ncpus)
> +		if (!ncpus--)
>  			break;
>  
>  		if (cpu_up(cpu, target) && can_rollback_cpu(st)) {
> -- 
> 2.40.1

Anyway, I'm adding it to regzbot:

#regzbot introduced: 18415f33e2ac4a https://bugzilla.kernel.org/show_bug.cgi?id=217498
#regzbot title: Off-by-one CPU initalization when CONFIG_NR_CPUS equal to actual system CPU count

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217498

-- 
An old man doll... just what I always wanted! - Clara
