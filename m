Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAE66AAB1D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCDQYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCDQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:24:11 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB9D11174;
        Sat,  4 Mar 2023 08:24:10 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id 4so3788360ilz.6;
        Sat, 04 Mar 2023 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677947050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UsIe5Z5hRwOSr549xE297j36VOsUJE5/tQaq3CEC9RU=;
        b=ICgnDvsyDrZ5zLAv8lwz6P7ATWpP7LpyBOVZiUH0JFWgBe2ONH3IVfIjCmE+XtrnS5
         zsGNLqO3x4OmZ8n9aUaLGnWrpNBzz7XqD7xQWG1iw0/oJu98GpXrwtWotxifXoqxI+dN
         9tL0xTopczCCkE0lVdoVp8qIbQKu4GLFb6j9GysYwC6pcDhjrg40bIU5dYwl+O0km4W1
         TcrzpkRL7eLCaj5CYA+uF6WAy9L7lKik1P53CX7L5GbUpoH/e95mC2ZUokFE9uxAvsGY
         YdwNJQxtd80rXasgya5+HiWHkxIgLeZVnimC+rlyH5HwbTLlVk793WBazdG0m0b0g2eD
         vBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677947050;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsIe5Z5hRwOSr549xE297j36VOsUJE5/tQaq3CEC9RU=;
        b=Ph9Cu1RuvBWK3wHVGWJ4sHo1YKvTeR3gXr41zcnI4zqT3R0+TqWGbEdulczekIGu0V
         AAZQ42G5+2kGDDLNqtexbPvPiRMcNiSUHORPLbbSjIScudVMl1ggLONW1RJNZxFJc3X7
         dOUj7JUhS6vSTsMyAWHzcBlN0JfuVFe7kL0/y+v6FDP+Fwy+aPp6EEkRraZrTOk3avGK
         e84HGT4lKrB7ViHevQda5cOkh+LpoSn3AYYZlEVtNGU1FkGYzve8+0jj8hpwSuMooPCv
         TA/QqCgcA8UjWMAx01VQz8guPA8+mEz3CueqGhgIvKAsEbJ4E9S9hab+XS1XhKxpQkEA
         ZCIw==
X-Gm-Message-State: AO0yUKU5ewaQlBPJ7TD1SVvhNJn9zZzEciLkyQebJHAJjD6iBc+7hsTF
        XV7eUdJmG63dtaWZ/XDvCPM=
X-Google-Smtp-Source: AK7set9lKjx9VdzxEhocK/D2i2awazq3VEo2G0g6puAJ73I89QlJDOpLYfl3ztBKX6Lp22pbSUuWjw==
X-Received: by 2002:a05:6e02:2164:b0:318:aac9:3e55 with SMTP id s4-20020a056e02216400b00318aac93e55mr4577469ilv.17.1677947050051;
        Sat, 04 Mar 2023 08:24:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o22-20020a02c6b6000000b003b4dc9ca57asm1735338jan.13.2023.03.04.08.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 08:24:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <636f01fb-a795-a43a-d57d-88e8228c4bc1@roeck-us.net>
Date:   Sat, 4 Mar 2023 08:24:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] watchdog: sbsa: Test WDOG_HW_RUNNING bit in suspend
 and resume
Content-Language: en-US
To:     Wang Wensheng <wangwensheng4@huawei.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xuqiang36@huawei.com
References: <20230301113702.76437-1-wangwensheng4@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230301113702.76437-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 03:37, Wang Wensheng wrote:
> If the sbsa_gwdt is enabled by BIOS, the kernel set WDOG_HW_RUNNING bit
> and keep it alive before anyone else would open it. When system suspend,
> the sbsa_gwdt would not be disabled because WDOG_ACTIVE is not set. Then
> the sbsa_gwdt would reach timeout since no one touch it during system
> suspend.
> 
> To solve this, just test WDOG_HW_RUNNING bit in suspend and disable the
> sbsa_gwdt if the bit is set, then reopen it accordingly in resume
> process.
> 
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Prerequisite: "watchdog: core: Always set WDOG_HW_RUNNING when starting watchdog"

Guenter

> ---
>   drivers/watchdog/sbsa_gwdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 9791c74aebd4..60875a710e43 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -360,7 +360,7 @@ static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
>   {
>   	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>   
> -	if (watchdog_active(&gwdt->wdd))
> +	if (watchdog_hw_running(&gwdt->wdd))
>   		sbsa_gwdt_stop(&gwdt->wdd);
>   
>   	return 0;
> @@ -371,7 +371,7 @@ static int __maybe_unused sbsa_gwdt_resume(struct device *dev)
>   {
>   	struct sbsa_gwdt *gwdt = dev_get_drvdata(dev);
>   
> -	if (watchdog_active(&gwdt->wdd))
> +	if (watchdog_hw_running(&gwdt->wdd))
>   		sbsa_gwdt_start(&gwdt->wdd);
>   
>   	return 0;

