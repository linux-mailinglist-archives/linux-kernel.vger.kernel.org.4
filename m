Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5376AAA92
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCDOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:55:04 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38CD15CB8;
        Sat,  4 Mar 2023 06:55:01 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id 4so3680861ilz.6;
        Sat, 04 Mar 2023 06:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677941701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MJLJpd9NzIbgfT1PX8LwJ+KD+O/5AxkPiWkXsZqZ0+w=;
        b=TpOBrX7Ht8Z0FrjSyZMH10AauJS7UYNWUJi9eICV9imYeS/ZgLzUVO/9CGqVfok0aY
         guBMCUhbR806Tu953K9SEzqeWC4dMXt94BgkLrtgX7ILc9EmpCv7g1XL1AcoHmO6vHqa
         dQDFANKeNPfC/eP+WEKNcYyf3aVcmAfeBJNpNe5bbPyeh5CwFzJGG0W6Dr0snuZ2Oo+d
         KneECNRJ7DRE2tiULTmEl0s56Qq3ulOchB/OxZl0SJxcahCnH37GH1zSv1rNIpPNUKSo
         9ZSEoKGCLF27VOdkASOBCcf7T1Y3aja7calmRQyLSe8y3XyhRvGESCm23piWKUsRIP80
         f6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677941701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJLJpd9NzIbgfT1PX8LwJ+KD+O/5AxkPiWkXsZqZ0+w=;
        b=6xNX1prdhG0zZrk6HcIsVxMfxDgeNPugs4N7NboI76cibYoP8VLG/urOEPGJgDo4vZ
         ZPPq4/HaFYvLzw4B2rsuVpf3LPlBK9hjdIO2dwDzY90pwzbp4suyo44VinW+4nmbzv3N
         AOPKGlyD5I7fCEji0R/5T3r6KeO2bj/2oQ8D6j00vCqYh3ekSOl02VUSMNsmzMHtKwkj
         P6hGSznw/VbkCyUbN4gfIlLodkg7nGF83jWet9BZnJhwzLWGOXkfwrUHHturMmyLQw1S
         5yVJJU6v6fbXp0UTRz2a5zkMjMCiW4VUIu+o61oYNdgY+O7S5hqYamG3DfXA1X0kdCqV
         Sbrg==
X-Gm-Message-State: AO0yUKW0NQM6nju6TTReO7ufTCnrkJFZr53fta7kPEUzqlGNNEbvW2Tk
        iVuE0GlNvts5JeV2/lbQBYVFiNqwzeM=
X-Google-Smtp-Source: AK7set+NMfTt7/RTqZc23ne2fOvPG6y0aFL5fNgIr3dNWsMMo2YDi/QXBRc8pswkrNuig7bxSMvDpQ==
X-Received: by 2002:a05:6e02:20e6:b0:315:4738:1b04 with SMTP id q6-20020a056e0220e600b0031547381b04mr4315358ilv.20.1677941701275;
        Sat, 04 Mar 2023 06:55:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g9-20020a0566380bc900b003c4e9b78e0asm1615638jad.2.2023.03.04.06.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 06:55:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8aff260c-7151-fe1c-91cd-1e107225a25f@roeck-us.net>
Date:   Sat, 4 Mar 2023 06:54:58 -0800
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

That will not stop the watchdog if it is currently open (active)
and if it wasn't running when the module was loaded.

Guenter

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

