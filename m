Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26857486EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjGEOx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGEOxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:53:53 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F381BFC;
        Wed,  5 Jul 2023 07:53:25 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso7456347276.3;
        Wed, 05 Jul 2023 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688568794; x=1691160794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cCxZnqnbc7kbM8222+sFq1akWhUm72mIgcQ0Ba8ScDw=;
        b=R5V5MPST2/8OlDBWiU72EnSYQ5KCww+ZA4jlpSNe5hg1jjZy+cruj+CWcTVhpnXPbq
         jpDKwXmflIhQSItvSr6lZtF4jS8ZtJaWsfWHeGC7pzslhxDTzf1Z/g1RXo5Yo/z+aDj9
         WL+S0+njjLmsBUpK2aicpo8kbDYD2+utIjItET/JnwkGw3Wi5NKjhuicXVL7oOB9qw11
         nVnYFDCwVHfHE54PPil4ptZIJ6K6D6aThuHk5l29anqQ+WUFGuZi8/v47apx5laLRXJK
         t4eMA/HzA6BKU3sLL5IYsn56JWSAgUI/cS1QjtgH+UN3bblV/7gxH5uWFrU75Di6xF8s
         Wbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688568794; x=1691160794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cCxZnqnbc7kbM8222+sFq1akWhUm72mIgcQ0Ba8ScDw=;
        b=MTyTopyw32XLZqV6YBPxL69CIrHI65nND5hfva1OSqnXNN2y0XpjUO6LmZPHEITqs+
         ZmKKZipfaz6vX6xQAwHC7dsaGA7bfZVxrQqBGLwO0VVZvwdaX50bZajRpJTKXJtiXy8+
         o8yLxuh5JU3FCbtghR7ZIBDiSk4IN6fzFt593Lb6YsGl6Fu93PCg1d+k90zpl5yal/qB
         HTfzvjrYatF7XSeEMoWutncxLQ+AM55a3bCwgodf9O4yz2HPvM0XirQAUnyW0RXAP+Ig
         /U+UHFicXFTp9AD/0UMOKHfiW6nzPmsSBTXdjG8ZRxxTQVH+OnUxnOPMtgTNg3VZlc7i
         PsIg==
X-Gm-Message-State: ABy/qLZYS3gi46nPuiAe0gwBz87Y0FCFK0rqbvXnjzAI5pNPuYHVz8Iw
        dd96eE6k+9sXHDkBm1ujbP8=
X-Google-Smtp-Source: APBJJlE5twqJnkqjFMt4XaFUinxE0MOHJV00raZ865uvX7xc+uzYea3rDuFyLC6t3xpnTZ6RB9Kzkg==
X-Received: by 2002:a25:cb03:0:b0:c5f:85f5:a0e3 with SMTP id b3-20020a25cb03000000b00c5f85f5a0e3mr3249364ybg.13.1688568793998;
        Wed, 05 Jul 2023 07:53:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2-20020a254f02000000b00bdd085da648sm5301898ybb.48.2023.07.05.07.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 07:53:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7266dc04-8db3-a48b-6844-8530ae7b8adf@roeck-us.net>
Date:   Wed, 5 Jul 2023 07:53:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] watchdog: s3c2410: Fix potential deadlock on
 &wdt->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        wim@linux-watchdog.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230705090951.63762-1-dg573847474@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230705090951.63762-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 02:09, Chengfeng Ye wrote:
> As &wdt->lock is acquired by hard irq s3c2410wdt_irq(),
> other acquisition of the same lock under process context should
> disable irq, otherwise deadlock could happen if the
> irq preempt the execution while the lock is held in process context
> on the same CPU.
> 
> [Deadlock Scenario]
> s3c2410wdt_suspend()
>      -> s3c2410wdt_stop()
>      -> spin_lock(&wdt->lock)
>          <irq iterrupt>
>          -> s3c2410wdt_irq()
>          -> s3c2410wdt_keepalive()
>          -> spin_lock(&wdt->lock) (deadlock here)
> 
> [Deadlock Scenario]
> s3c2410wdt_probe()
>      -> s3c2410wdt_start()
>      -> spin_lock(&wdt->lock)
>          <irq iterrupt>
>          -> s3c2410wdt_irq()
>          -> s3c2410wdt_keepalive()
>          -> spin_lock(&wdt->lock) (deadlock here)
> 
> [Deadlock Scenario]
> s3c2410wdt_keepalive()
>      -> spin_lock(&wdt->lock)
>          <irq iterrupt>
>          -> s3c2410wdt_irq()
>          -> s3c2410wdt_keepalive()
>          -> spin_lock(&wdt->lock) (deadlock here)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock, which reported the above
> warning when analyzing the linux kernel 6.4-rc7 release.
> 
> The tentative patch fix the potential deadlock by spin_lock_irqsave()
> under process context.
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/s3c2410_wdt.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 95416a9bdd4b..e1dc71ece01e 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -379,10 +379,11 @@ static int s3c2410wdt_enable(struct s3c2410_wdt *wdt, bool en)
>   static int s3c2410wdt_keepalive(struct watchdog_device *wdd)
>   {
>   	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned long flags;
>   
> -	spin_lock(&wdt->lock);
> +	spin_lock_irqsave(&wdt->lock, flags);
>   	writel(wdt->count, wdt->reg_base + S3C2410_WTCNT);
> -	spin_unlock(&wdt->lock);
> +	spin_unlock_irqrestore(&wdt->lock, flags);
>   
>   	return 0;
>   }
> @@ -399,10 +400,11 @@ static void __s3c2410wdt_stop(struct s3c2410_wdt *wdt)
>   static int s3c2410wdt_stop(struct watchdog_device *wdd)
>   {
>   	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned long flags;
>   
> -	spin_lock(&wdt->lock);
> +	spin_lock_irqsave(&wdt->lock, flags);
>   	__s3c2410wdt_stop(wdt);
> -	spin_unlock(&wdt->lock);
> +	spin_unlock_irqrestore(&wdt->lock, flags);
>   
>   	return 0;
>   }
> @@ -411,8 +413,9 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
>   {
>   	unsigned long wtcon;
>   	struct s3c2410_wdt *wdt = watchdog_get_drvdata(wdd);
> +	unsigned long flags;
>   
> -	spin_lock(&wdt->lock);
> +	spin_lock_irqsave(&wdt->lock, flags);
>   
>   	__s3c2410wdt_stop(wdt);
>   
> @@ -433,7 +436,7 @@ static int s3c2410wdt_start(struct watchdog_device *wdd)
>   	writel(wdt->count, wdt->reg_base + S3C2410_WTDAT);
>   	writel(wdt->count, wdt->reg_base + S3C2410_WTCNT);
>   	writel(wtcon, wdt->reg_base + S3C2410_WTCON);
> -	spin_unlock(&wdt->lock);
> +	spin_unlock_irqrestore(&wdt->lock, flags);
>   
>   	return 0;
>   }

