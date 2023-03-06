Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA74F6ACC5F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCFSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCFSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:22:24 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5122234C9;
        Mon,  6 Mar 2023 10:22:07 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-176d93cd0daso2969051fac.4;
        Mon, 06 Mar 2023 10:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678126920;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uq610a7Shc6tuljdDKHAPf3qm5p/qwDI9hFktJ65y3U=;
        b=qY3qiuFLFnNjVVfJm0itJmjlyZmBsTUlebTdIoJje3iMdFw2LnAsg6PL3Oq3N70l6F
         7r/wSxOp7+BKfk/Cyh274M8wYKMQG1Z1qBVrm8YFppazWCADdh+9+Wx0RDYv9cxk6OBl
         n3M9XLrHFFPTyw0bBCO8TrfSVKiIwQja3pbGrkl1A16P3tBOCf5jnAmQ9PaL6jVVLPGX
         flJ/QIUPqAKwsEA7DzYW/867xX7lPrZ3fcQOxw4mLbWuzczso+K+dum/nHsYx94Au6za
         QfPqGHBP94hfWhjkyiMDyPlQX9U2yBs3MqpEREcsGfkBWZxfNrWbWi+kWSy7KTuR1VpQ
         qg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678126920;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uq610a7Shc6tuljdDKHAPf3qm5p/qwDI9hFktJ65y3U=;
        b=Mdhcmy6DMQh3H1iJCH3teNcvoPzmVvPDSEZ5qLt/UTPsh2PM1a++B6hXCalMplNrcS
         heNuFlVpFFn/BhPEiW+8gVLvOrwwx1nK56gpKVGrqhgWRvl+usaMd5l9LW3bbzl8pInE
         SxaHOIQaYMA6Y+R/tBIc2ua7Km0XEozM84M3r3NcX1pevyld4tpECU7GmTQgJjwnvCWN
         WtdIEYlHHxEO5oA0rm7wt/Shyu99pO87ezp8OrYQS3AuegTTGXzU7yXvPQH/L9N1hZBQ
         gdpgKrHh5B8Z0xifCDZuX0UGNTk+qfqCjTWrP9j3PFe0fuClyWwUm6WFqGxAsStv1RgB
         lujQ==
X-Gm-Message-State: AO0yUKUXVm4cW7G13gtkebijvX9D76/hWfp6gCLeT0ozBW3oukv4Nfho
        00IYRSH5b4ZE40Sx640d1AU=
X-Google-Smtp-Source: AK7set+s1lViStQJYSOSuZQ61DTJsgyBuZ2TcP/0eUh46dq9yyP88/Qm51k8HoOq8OxxtE7AWKZeLQ==
X-Received: by 2002:a05:6870:42cd:b0:172:1fb5:68ed with SMTP id z13-20020a05687042cd00b001721fb568edmr5856900oah.20.1678126920749;
        Mon, 06 Mar 2023 10:22:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dv23-20020a056870d89700b001728669a604sm4266045oab.5.2023.03.06.10.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 10:22:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1c1f9813-7f65-6a45-45fc-3d6edf8f2496@roeck-us.net>
Date:   Mon, 6 Mar 2023 10:21:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, kernel@pengutronix.de
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/3] watchdog: Simplify using
 devm_watchdog_register_device()
In-Reply-To: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 09:08, Uwe Kleine-König wrote:
> Hello,
> 
> this series converts three drivers to use
> devm_watchdog_register_device(). This allows to drop their remove
> callback.
> 

Side note: We could do more of the same by also replacing pm_runtime_enable()
with devm_pm_runtime_enable(), only I don't know if the additional
call to pm_runtime_dont_use_autosuspend() in its disable callback would
be a functional change. I also don't know if pm_runtime_put() in the remove
function is necessary or if it even makes sense. Any idea ?

Thanks,
Guenter

> Best regards
> Uwe
> 
> Uwe Kleine-König (3):
>    watchdog: bcm47xx: Simplify using devm_watchdog_register_device()
>    watchdog: rn5t618: Simplify using devm_watchdog_register_device()
>    watchdog: wm8350: Simplify using devm_watchdog_register_device()
> 
>   drivers/watchdog/bcm47xx_wdt.c | 12 +-----------
>   drivers/watchdog/rn5t618_wdt.c | 12 +-----------
>   drivers/watchdog/wm8350_wdt.c  |  9 +--------
>   3 files changed, 3 insertions(+), 30 deletions(-)
> 
> 
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6

