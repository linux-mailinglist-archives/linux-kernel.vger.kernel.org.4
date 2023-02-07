Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C468DD8A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjBGQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBGQDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:03:52 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1AC93D8;
        Tue,  7 Feb 2023 08:03:50 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-16a8d511ce0so1036439fac.1;
        Tue, 07 Feb 2023 08:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w1FeMxMrXft7z/3fTjcABkiIwj31U55sfnDiFJ4Qoog=;
        b=calax4UQTytx5iAQEsC2lmqiIYBZQMAC5bUinNdJrYxICDkTNp2FBzmjzbPCLAvnVc
         4KjukMEFdQC3jzrOQPyC1owLE8uhdCedwEB4D8zqHqT1Pgu3w8IIfnf364vDYmWrgIEt
         dKyh6Zd4hQMPaEB9bCqzAUDiIYHm/TxzLcEYQykkzCQNJPL58g1F5QmswHA95UsTYczT
         czh5dopIdOxYSgBMDAUqm02Se+klOBqcqFxdYC3tRYKzuPTKmtbny+5Rb/xJjUZXa2Pa
         PkZvLyCCjbjslznbUXnAAS/ZzWplb1H7y9+1DTi+R0qPElAmVcc1goSdSxdiyN8QVMn7
         06+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1FeMxMrXft7z/3fTjcABkiIwj31U55sfnDiFJ4Qoog=;
        b=nhtnraeICvinvhj4BJara0T2sdyIkaxFNYLM2FxXKL1e0vCl8afgon5/Xe6ZCKR26/
         w2xuzUOwpn+T9hXVwiKHYcJ0Qx2FpN5ulM1rSyc/neN0SAOjkr4JiVSLwRebGArKegdR
         Gew5fXyvO7T3h1/1I6fvg1u+9SLm5bIQFEVopIPVUqApQRAMT8ft7q0JFIKa8kOQ2/By
         Qu21RFcZV37JmwnI+zle8MJqC+iSXRtKee6YaenLgxHRNQWB/zWMJNjxKXBodCTUxAqC
         nm6TpL5dE8bJrz2i97EwJrei45zSGsrj4bdsOQdHq/5rGFqgKy9JXDHvqgji2ehPjw1j
         JAcg==
X-Gm-Message-State: AO0yUKXcj93JojshMLw2qh7cLfRZKmY5pQQS8mHBTR2pr5iq1ts3nlhF
        Md6fjijVMd6ZkXY/q5cAV2pW7MIk7bo=
X-Google-Smtp-Source: AK7set+N0vkBjZyEwfj5EvOQwixlYChoyR+ECAaTDm10miWpuJC6b9m/1OOKXMAg0VyIdpt2biy7tg==
X-Received: by 2002:a05:6870:a408:b0:15f:be68:501 with SMTP id m8-20020a056870a40800b0015fbe680501mr2005657oal.21.1675785829821;
        Tue, 07 Feb 2023 08:03:49 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id zh37-20020a0568716ba500b00140d421445bsm4211003oab.11.2023.02.07.08.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 08:03:49 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <db0eda3d-65a7-8d8a-e9a3-7f7617d242ef@roeck-us.net>
Date:   Tue, 7 Feb 2023 08:03:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     George Cherian <george.cherian@marvell.com>,
        wim@linux-watchdog.org, zhangshaokun@hisilicon.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207044603.1011555-1-george.cherian@marvell.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] watchdog: sbsa_wdog: Fix the timeout calculation
 while programming
In-Reply-To: <20230207044603.1011555-1-george.cherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 20:46, George Cherian wrote:
> The time out calculation done in sbsa_gwdt_set_timeout() would always
> return a 32-bit value. Use proper typecasting to make sure the overflow
> values are captured.
> 
> Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>
> ---
>   drivers/watchdog/sbsa_gwdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 9791c74aebd4..aaa3f5631f29 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -152,14 +152,14 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
>   	wdd->timeout = timeout;
>   
>   	if (action)
> -		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);
> +		sbsa_gwdt_reg_write((u64)gwdt->clk * (u64)timeout, gwdt);
>   	else
>   		/*
>   		 * In the single stage mode, The first signal (WS0) is ignored,
>   		 * the timeout is (WOR * 2), so the WOR should be configured
>   		 * to half value of timeout.
>   		 */
> -		sbsa_gwdt_reg_write(gwdt->clk / 2 * timeout, gwdt);
> +		sbsa_gwdt_reg_write((u64)gwdt->clk / 2 * (u64)timeout, gwdt);
>   
>   	return 0;
>   }

The driver sets max_hw_heartbeat_ms. It is its responsibility to clamp
the timeout value written into the controller to the configured limit
to avoid confusing the watchdog core. Something like

	timeout = clamp(timeout, 0, wdd->max_hw_heartbeat_ms / 1000);

This also solves the problem in patch 2 since it guarantees that the
resulting register value is <= U32_MAX for version 0.

Guenter

