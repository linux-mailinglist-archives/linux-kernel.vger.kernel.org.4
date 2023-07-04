Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1017746B32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGDHyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjGDHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:54:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99251731
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:53:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so6638815a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688457208; x=1691049208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrXqUlrBpP30rY5ycLmE0WvwHXAB0h27Bdu5zKC2Elg=;
        b=bCW7pqOJ64xhF0HIEPsHvQ+0+7BWUlVlL1e7z1GGz58BneMnJccND5zP0pNu+jZoNq
         RChj7ohW528rLmyIYzBbvoihB8D3WM04s3IO9ruW/unYLeD6+xi1tBmjQxsQpoGUnb2K
         L54mD+Cy3JttcFFuV1GJ2wtHFTZPAjTwkEafXNme5vNllaltQpGZdGOdMOXhoGoBkrPr
         g2zoolXgnZU1tHiSaglE2nYJX20xuGjrzljbC3iWP7broCuJSxurXCqDczYhhzs0LRbw
         sF2ZHd6i32PioLWh804whUOTJM5EWRoLmz3aCG+BF8kWe/o+pxE7vNI1PAkTEhMigMZi
         gpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457208; x=1691049208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrXqUlrBpP30rY5ycLmE0WvwHXAB0h27Bdu5zKC2Elg=;
        b=ZCGWkmPQZ/loxlNWCEbjLtshRIJhaaM/hP+gzgILYU9qUAsK3cviPtxVayyGh790Ci
         DSqEnxdlopgR0zRfOuRjD9NataiC0f56US/2QQhsiPmWvCrsAjY+Vad1BjEytcIvqRn9
         Hd2NnSq2kYKLAk2vS5Xej9a7EGw0AM/SjJf/kLiE29zM9MrrwTrk2Q1vTl2NYDdb8ZIy
         ereKwRg6jxf6qnI2AuAIyKH1+wSaiYcendioq82k5kR3YrVd1oIG/jXXLHK3N5QF0bBt
         7TmTeSVF1QuKEtY1i+dmg2JvN/vsyoJEjInOOO6XAw4zpovH6uHX3A5XU2+6HXaOWiIN
         zS+A==
X-Gm-Message-State: ABy/qLY7epJdG0iBl/J6XybNWbGl2/j69VFyhtuoZJysjiPMlVvA3AJ7
        xfvIN9530SGaj1XV12TJWFypHhcLUL4FEckxdJ0Tww==
X-Google-Smtp-Source: APBJJlFWLYHbDmuyT7EitO1lmZ66TFGNuZz7Pz9jO+RKjMKBFNB9oSWYbE0oFCtgp7d5u+4mwtlvUA==
X-Received: by 2002:a17:906:8315:b0:98e:1484:5954 with SMTP id j21-20020a170906831500b0098e14845954mr10230260ejx.71.1688457208285;
        Tue, 04 Jul 2023 00:53:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906130a00b00992b50fbbe9sm6651031ejb.90.2023.07.04.00.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:53:27 -0700 (PDT)
Message-ID: <b6d3a872-f32e-bfcd-b603-c08339737045@linaro.org>
Date:   Tue, 4 Jul 2023 09:53:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] watchdog: s3c2410: Fix potential deadlock on &wdt->lock
Content-Language: en-US
To:     Chengfeng Ye <dg573847474@gmail.com>, alim.akhtar@samsung.com,
        wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628164759.67594-1-dg573847474@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230628164759.67594-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 18:47, Chengfeng Ye wrote:
> As &wdt->lock is acquired by hard irq s3c2410wdt_irq(),
> other acquisition of the same lock under process context should
> disable irq, otherwise deadlock could happen if the
> irq preempt the execution while the lock is held in process context
> on the same CPU.
> 
>   [Interrupt]: s3c2410wdt_irq
>     -->/root/linux/drivers/watchdog/s3c2410_wdt.c:547
>     -->/root/linux/drivers/watchdog/s3c2410_wdt.c:383
>     -->spin_lock(&wdt->lock);

This interrupt is a threaded interrupt. Therefore the
s3c2410wdt_keepalive() will be called again from process thread. Are you
sure there is deadlock?

Anyway, please also strip unrelated paths and rather use function names,
not references to lines, because these might be not accurate.


Best regards,
Krzysztof

