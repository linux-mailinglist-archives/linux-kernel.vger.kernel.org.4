Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790086BC3C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCPC0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCPC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:26:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329DC8899;
        Wed, 15 Mar 2023 19:26:28 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id l9so260738iln.1;
        Wed, 15 Mar 2023 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678933587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn6GTzWZhVeWN9PHLIBwYzMfzh5f2SxCuW63G3ON8vA=;
        b=EYke7L/0V16TNrSbT6Wd/Z2S7MJA3OsZBwtYESg7GgG097KlpCDeglcU5CEslriEaK
         dRbQ2BR8iZjhdySIZM/KnbKWRchRf+RLGhKkC4ZUMbw7qOHP/00owgNxCOXeySIBxB8N
         ljACycgo4gC+qpBsEdUS42OyGkFX/SNxsVMU/2jM7SdQbZQBNurwGl82Ze6CEcuKWsvU
         3NHSa/2/Rb1pVEsEl8OcsfLu+4fZ9AolNfpJcvnk4b+Hfv6Mwkfpz3ljmgU7Z9IZGemo
         Wkq9LTBynK91Y2+x5wPhrDSeKe02iqXya9JLB0PTDf1n3CcKA4IpG/wv5tP2SPjWPVjo
         ZkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678933587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn6GTzWZhVeWN9PHLIBwYzMfzh5f2SxCuW63G3ON8vA=;
        b=uxbB8rneAdrWo49hBj4WLNEvA5F8cWeUZubWzqsVwPSDdeT7xfFxkYkeltezLfHCFr
         EaPG181Vl5WyS9rOaUtY7z2kZ8NA1fMfv1+iuhdGkNYuWIshGgDwnu6cuuO90r6DP2sa
         MQdx2ssz6/vwRu+cZqEbSjNE1FOLXrDyXCYVS0Sajq6hf1U/xouFDdUje+A+KJzRzp7D
         CvJcV2vD4pqKs5CxuuNF3xIV4Hr1zX145jLu5lhlcwTQ1fcMuhE7k6oyLvqxHW6xlWIP
         Mfq2h3s3gDIT+3e/z2ev1lg1sGMuDW73ZcrW8gVtMO81JvlnwvC0kww7Vls7E0Fi+88I
         l2KQ==
X-Gm-Message-State: AO0yUKVDFFzf6qNzK4bu+kRjx8SVR3xx5ehB8Q1H15hHXAbaHzl+E409
        JR+ZtJ89SUqgQpbIr3Q7Rnw=
X-Google-Smtp-Source: AK7set8p2OItMZv7IfV7pyIVxYF9z9ZHhZogOGMpMQFDu6g2dTdXi3txgIEK1s1udk3ydfCVe4nUpQ==
X-Received: by 2002:a05:6e02:68a:b0:311:e48:d64a with SMTP id o10-20020a056e02068a00b003110e48d64amr6041036ils.17.1678933587699;
        Wed, 15 Mar 2023 19:26:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020a92cd09000000b00316e39f1285sm2030493iln.82.2023.03.15.19.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 19:26:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Mar 2023 19:26:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lorenz Brun <lorenz@brun.one>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: pwm-fan: set usage_power on PWM state
Message-ID: <ec52f540-0f78-4cf0-ae61-314cab33ac80@roeck-us.net>
References: <20230309011009.2109696-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309011009.2109696-1-lorenz@brun.one>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:10:08AM +0100, Lorenz Brun wrote:
> PWM fans are controlled solely by the duty cycle of the PWM signal, they
> do not care about the exact timing. Thus set usage_power to true to
> allow less flexible hardware to work as a PWM source for fan control.
> 

This doesn't seem to be used anywhere else. I do not understand the
rationale, and I do not understand the practical impact of this change.
This needs to be confirmed by someone who understands what the flag is
supposed to be used for, its impact, and if it is indeed appropriate
in this context.

Also, since in practice there is no such "less flexible hardware"
in the upstream kernel, please describe the use case in more detail.
The only pwm driver that supports usage_power is pwm-pca9685,
and that driver uses the flag for EMI reasons, not because it is
"less flexible hardware". I am not inclined to accept such a change
without specific use case or need.

Thanks,
Guenter

> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
>  drivers/hwmon/pwm-fan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 83a347ca35da..aa746c2bde39 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -507,6 +507,14 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	pwm_init_state(ctx->pwm, &ctx->pwm_state);
>  
> +	/*
> +	 * PWM fans are controlled solely by the duty cycle of the PWM signal,
> +	 * they do not care about the exact timing. Thus set usage_power to true
> +	 * to allow less flexible hardware to work as a PWM source for fan
> +	 * control.
> +	 */
> +	ctx->pwm_state.usage_power = true;
> +
>  	/*
>  	 * set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
>  	 * long. Check this here to prevent the fan running at a too low
