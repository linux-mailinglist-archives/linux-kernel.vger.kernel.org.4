Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A705FF291
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJNQvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJNQvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:51:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7472C105;
        Fri, 14 Oct 2022 09:51:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d10so5424775pfh.6;
        Fri, 14 Oct 2022 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFvfv0UWGbNZojkW4m37OPvbrZXUyDcmNX8dFdGXeQ4=;
        b=AneMt3bR6CjNYR/zB9Mj07/kpGHrjCtjy4Z0Mzo+0SykdqHY6TZ+/KyBQdvrYyancl
         lIxYA5lbWLJ7uWT5SUF7VTqfYWr850pw3WStP3yrvMWDHLLzb/Fbgf74Zqb13EaTnjj7
         OnzvE4Dru0sSp8p0lKeqm4l1SkDzd0NcMGakAO6ccghmS+1MxJwou/w+pMxeaBrNV3MJ
         Gqtca4QVVqnkH7ae/qIArdoGNWKhALO1cVnAkfx7EnyQ+PH49wRmNM7/s+DO3rRFQMkD
         y+/7Xvo5F4r+XB9A0WpT0mL9NEDTFZf3VRzlRnp8jM+bor9SyEngR1oly0tYVnkdhSJY
         V4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFvfv0UWGbNZojkW4m37OPvbrZXUyDcmNX8dFdGXeQ4=;
        b=wIIhgyVvJmyBLWENl3LeTfEnEHgZSR45NvLlRDViuPr2zXM7v+HLX5Ymoq3I5dJxwb
         Cdq5gtF1gbSqK/3LRa/mRmfLza81ycKLoUTtfJDNXA53JSiFfV9eWjhRWjxbJemE++PV
         z5lIXOvkiKOWCBwzIOclR7pT3iyLXiVdTlTNQjJVvXL1znUjraDchzV3T+jKfsyzndrb
         6dnnG/na6UgbPpu/TImeBDNGFoCzJ/7IVw78bcno8aL2xoqDa1gwxd/TmxDxE+61e4vH
         KOwefN6Emw5EgZbWzWR6QBG1qzTUQHY9r5K7ZxBAMxd7mtlZBN95Bsch7AR/hdqFKHkj
         s3NQ==
X-Gm-Message-State: ACrzQf04z8tbxabCjXG/HZkpeub7syA8mT60lc9fESTIc2X6EFkJNPBR
        jpM/K75oQ+Wo0ZCbrH4y50M=
X-Google-Smtp-Source: AMsMyM7yHa4syirxMh3BWZQ21Yb3JW9li8TD621PykanyzIBE+c2aQJhVkzKck+YRGLE4VW9G0f0Ug==
X-Received: by 2002:a05:6a00:3406:b0:55c:e661:6d31 with SMTP id cn6-20020a056a00340600b0055ce6616d31mr6402510pfb.42.1665766290074;
        Fri, 14 Oct 2022 09:51:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b0017305e99f00sm1947154plx.107.2022.10.14.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:51:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Oct 2022 09:51:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (pwm-fan) Explicitly switch off fan power when
 setting pwm1_enable to 0
Message-ID: <20221014165129.GA234611@roeck-us.net>
References: <20221013135951.4902-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013135951.4902-1-matthias.schiffer@ew.tq-group.com>
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

On Thu, Oct 13, 2022 at 03:59:51PM +0200, Matthias Schiffer wrote:
> When pwm1_enable is changed from 1 to 0 while pwm1 == 0, the regulator
> is not switched off as expected. The reason is that when the fan is
> already off, ctx->enabled is false, so pwm_fan_power_off() will be a
> no-op.
> 
> Handle this case explicitly in pwm_fan_update_enable() by calling
> pwm_fan_switch_power() directly.
> 
> Fixes: b99152d4f04b ("hwmon: (pwm-fan) Switch regulator dynamically")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index dc3d9a22d917..83a347ca35da 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -257,7 +257,10 @@ static int pwm_fan_update_enable(struct pwm_fan_ctx *ctx, long val)
>  
>  	if (val == 0) {
>  		/* Disable pwm-fan unconditionally */
> -		ret = __set_pwm(ctx, 0);
> +		if (ctx->enabled)
> +			ret = __set_pwm(ctx, 0);
> +		else
> +			ret = pwm_fan_switch_power(ctx, false);
>  		if (ret)
>  			ctx->enable_mode = old_val;
>  		pwm_fan_update_state(ctx, 0);
