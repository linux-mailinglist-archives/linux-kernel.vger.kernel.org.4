Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A26E6C00
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjDRSVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjDRSVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:21:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0CB464;
        Tue, 18 Apr 2023 11:21:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63d4595d60fso1579238b3a.0;
        Tue, 18 Apr 2023 11:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681842091; x=1684434091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NHSuSSQ9P6xK9QCJtcWEYNs0SaujXBKf1zxRzDXpo68=;
        b=sjGwNFaKwbxXWg/bAQka076APjfFv+D8cnEraqagA5JVqiS1EnpDvmRwoUhlVEAoLD
         Gip9jA2JGni820IxH2MdlR5GJRerEC6M1DHtS6w7xEkRRSglq262KYtDNjl9PREfuH1X
         D2Rr5CuGSy4Q+H//XqaLnmsDE/pde2sL6+kZq4H1210+Br1c5aQkySKVMCQLiClEgyUa
         tnT9s3OICyjrrJ1pLJnY/sLPteLxndAPQbtl9Fwv8mfZXS0nHFlCbbHdzPeR0BZIC5om
         js81DAyIHGcU1p1n/3m8UV8G9JBDIwcLubwKilyr1S7Vx/nRLlnfbxIxzoMR85J2Z5mY
         jHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681842091; x=1684434091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHSuSSQ9P6xK9QCJtcWEYNs0SaujXBKf1zxRzDXpo68=;
        b=K8fIHUofyh0rN4QEIc/A56bobKD0vm19MR2jIO9XWZ154/kwwBYlQCFgBibQVKiUtn
         tXErpN15trMYp2OWwVL109Bb56o0/6dNoiuBWKJUmIoggVp0dhpYJqVPVL+JILkjBPhr
         JG+osHQowPTDpVVvaavO23jpsWbZ0d/nWs9Dx0dAo5Mo2j5Kl1bwV+ChpleUqN6GvAMX
         Yer8vGS2db1HUFO2qhL6WZDUX5Lk0cvVOailz1dHFXljCW0pEWfPozkW0ziN4samkxzO
         1ByvSzviwO2trAmK5idYSiPapvgZ14MYT7OBZ5g6Rlem0DsDVljExPXLjHDfBBDhiFhq
         QLXg==
X-Gm-Message-State: AAQBX9dQfVHyMQQuDRv4/H7seJrpZjPKqhV0re++8cbbO5NRz7vi1mQy
        kmFBzASy0+syvrhBN5Xpuok=
X-Google-Smtp-Source: AKy350YpjgzYcwvlme3Qa9TxvnWfB4G9uh+LEHBqUWuzrzlb7XQbfCBICt3UjvFdlYLb3C9Doykauw==
X-Received: by 2002:a17:90b:503:b0:23f:2486:5b53 with SMTP id r3-20020a17090b050300b0023f24865b53mr495244pjz.17.1681842091507;
        Tue, 18 Apr 2023 11:21:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mg12-20020a17090b370c00b0023670dbb82fsm6414940pjb.25.2023.04.18.11.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 11:21:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a2d036ae-de4e-770d-03d1-e4147ddaee10@roeck-us.net>
Date:   Tue, 18 Apr 2023 11:21:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] watchdog: menz069_wdt: fix timeout setting
Content-Language: en-US
To:     Johannes Thumshirn <jth@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230418172531.177349-1-jth@kernel.org>
 <20230418172531.177349-3-jth@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230418172531.177349-3-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 10:25, Johannes Thumshirn wrote:
> When setting the timeout for the menz069_wdt watchdog driver, we
> erroneously read from the 'watchdog value register' (WVR) instead of the
> 'watchdog timer register' (WTR) and then write the value back into WTR.
> 
> This can potentially lead to wrong timeouts and wrong enable bit settings.
> 
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/menz69_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/menz69_wdt.c b/drivers/watchdog/menz69_wdt.c
> index bca0938f3429..3c98030b9fcd 100644
> --- a/drivers/watchdog/menz69_wdt.c
> +++ b/drivers/watchdog/menz69_wdt.c
> @@ -77,7 +77,7 @@ static int men_z069_wdt_set_timeout(struct watchdog_device *wdt,
>   	wdt->timeout = timeout;
>   	val = timeout * MEN_Z069_TIMER_FREQ;
>   
> -	reg = readw(drv->base + MEN_Z069_WVR);
> +	reg = readw(drv->base + MEN_Z069_WTR);
>   	ena = reg & MEN_Z069_WTR_WDEN;
>   	reg = ena | val;
>   	writew(reg, drv->base + MEN_Z069_WTR);

