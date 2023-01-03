Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79AF65C905
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238404AbjACViu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjACVir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:38:47 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91756478;
        Tue,  3 Jan 2023 13:38:46 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so19823588otk.8;
        Tue, 03 Jan 2023 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGuFbt9MnQvsizsuFNkW6vGAc/rCyLL+1IoksQSaqUw=;
        b=SdNy7thRNBmLh90LwMtLMK2SGTiiQhZQx02rjhweC0zuS6FgW6C6EQ1xSlLseSne9t
         fI0E2+yoLypQ+jUMnfet69n5LeLqeGnWK0g1xPNzqdNO3F9KWQAL7vTwBQIXu2thcjOZ
         6dUt7ow31sk4m9rOcKAbFQlP+5lZm/GDbdNYluWnPTnPYHqOVsX7bf/7TCAh1ImPEgt1
         TgksGr0utl6VAC3ShxTDTVW5IcP8VnEV0RhplCSIhKVRFHQxi4x29/Ji22R8Vx7lUhTC
         BsgIB1T2kQBrRyY/Aao36BFBlfbbQxLhZqy6qJI5INaAvYBNEoEJyz4vzcjF7cafLAsa
         drpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGuFbt9MnQvsizsuFNkW6vGAc/rCyLL+1IoksQSaqUw=;
        b=T+VMyf9L6PlYXeYVDeBxRAie/hTPc5wUWfd0+T8xy1vCaNRbl4UFZMyCs0vT5+FdN9
         LaqV2YMAemuLJPCNQ7QMYgZaoZZNDj++Ly5Mdgye4adt6yI6wRtN12szNpB/KZsgGAN5
         +X8KR9LnT52aKY1qWSNSs7rqOU4FeLx8ryzMstjHkx6BSwIfcDJI27xHicifrk4zE8Wl
         CXD4XTXjvet2WkdPsVdfZOw9xsQhvXq9268bnjmQd9DW5jCxaEvyG2OSNVeSpZm82ZFn
         ugn/D7cXteYr86z0mSFUhoEh0B+iblHsKfQv0/WEjlHU04iO8cFgUylBvW6iYF91GUgJ
         GzOQ==
X-Gm-Message-State: AFqh2kpKfM0khaWHv8zDtWNp825FUXZsPhLVcAzDXhtffDDYjNHfeN/Z
        OrHLGG+HpbbV8dhum8xNP14=
X-Google-Smtp-Source: AMrXdXt7c/6AQ2q7aRwMgm8FWnnVybLnqUG6ZVNVtpi8w1ICAH8+DKxHTVbdzaSlv/gIr8ZNLWR4cg==
X-Received: by 2002:a9d:7a8d:0:b0:66e:6673:2c48 with SMTP id l13-20020a9d7a8d000000b0066e66732c48mr30099369otn.20.1672781926075;
        Tue, 03 Jan 2023 13:38:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9-20020a9d6f89000000b006619295af60sm15205317otq.70.2023.01.03.13.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 13:38:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 13:38:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     verdun@hpe.com, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/5] ARM: multi_v7_defconfig: Add GXP Fan and SPI
 support
Message-ID: <20230103213844.GA216540@roeck-us.net>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-5-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103203654.59322-5-nick.hawkins@hpe.com>
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

On Tue, Jan 03, 2023 at 02:36:53PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> In order for HPE platforms to be supported by linux on GXP it is
> necessary for there to be fan and spi driver support. There fan driver
> can support up to 16 fans that are driven by pwm through the CPLD. The
> SPI driver supports access to the core flash and bios part. The SPI
> driver spi-gxp was added previously to linux.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

This patch will have to be applied through the arm tree.

Thanks,
Guenter

> ---
> v4:
>  *No change
> v3:
>  *No change
> v2:
>  *No change
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index b61b2e3d116b..192c89bfd02a 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -441,6 +441,7 @@ CONFIG_SPI_CADENCE=y
>  CONFIG_SPI_DAVINCI=y
>  CONFIG_SPI_FSL_QUADSPI=m
>  CONFIG_SPI_GPIO=m
> +CONFIG_SPI_GXP=m
>  CONFIG_SPI_FSL_DSPI=m
>  CONFIG_SPI_OMAP24XX=y
>  CONFIG_SPI_ORION=y
> @@ -530,6 +531,7 @@ CONFIG_SENSORS_NTC_THERMISTOR=m
>  CONFIG_SENSORS_PWM_FAN=m
>  CONFIG_SENSORS_RASPBERRYPI_HWMON=m
>  CONFIG_SENSORS_INA2XX=m
> +CONFIG_SENSORS_GXP_FAN_CTRL=m
>  CONFIG_CPU_THERMAL=y
>  CONFIG_DEVFREQ_THERMAL=y
>  CONFIG_IMX_THERMAL=y
