Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C356658809
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiL2AKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2AKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:10:37 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121610FCF;
        Wed, 28 Dec 2022 16:10:33 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r11so16007852oie.13;
        Wed, 28 Dec 2022 16:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVFzkE367g76hEdHAnpQgdk5KYpJ4SEVgNfUXDyiXMs=;
        b=FNBOc4Qm0gZ+PbTagUKYgmu2y4/LPF4gF9LQyrTZxRCtLFdWTHO146/hKaOGtcMK73
         UjN3EJ84Nam7hBw/RC1Pqf5fftjEK5yqs5cE3gYh81nde2YSIF0Fz12t7gL4GHfoU7cy
         MeBaGSJFgJDjlaEi4ghEs9nt+qubTUQ3dx0UprRUmqN0FIRqbZ7u+WDTapspStco61CH
         JMQuEQLbdOuQDvwYEbxtAH3PDT9BhWmIPk9myA0J4gpYPAE9FRsxkO9VbtO+Wnva00P2
         eEtbW+DinuVMS2UB3oNnpnZAz/+rDZQefiPC6x8ilF2z30Wqt6t38bSuJg1q0Hv1MMQs
         3sjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVFzkE367g76hEdHAnpQgdk5KYpJ4SEVgNfUXDyiXMs=;
        b=J0/aMLqUPYp3sst2bK8r+FjMWUnxi5e980Vi6/7puqVUxSds038ObaU/MEu7ItW5Ko
         LdlGVVrBpilrQ2B7lLUjkCkkh5idn7h8xt6/zVwy4PR+1+DkuK17xG026b4kF3PXMFNG
         RajEkeBGuyL6lc9KFkSmkx5A86TRSIjK9ykCReyF6CVaU1AX7/QMo6k7V4P91YbubjX+
         a54bgEIrOr58+MRpJ5sSgWS0rTLmV8F+y9/e1l8laqltjEWy3mSF+PlAU8t9e8YlBWNI
         hpLFgRlv/X7HK2k3YUxuFqg3I4+b8hvZznQzXHJrGqeRFOFSxpxB3zZ5TQXyg/mdCjJS
         4NDg==
X-Gm-Message-State: AFqh2koDPPyz6BwNI+JKH9F4O8JhAPF0TWVGeTnaKgHsDrnrlZXX3Y24
        nCzQacEmwp5H49zWWLyWCNrsC8cXKdk=
X-Google-Smtp-Source: AMrXdXvZdCseZOjA6SZJfQgjT8jd7esMfZlVtUydpLuUdXBuaK7V2NrybtqZ5M/2ei+t9CqLvRAHuQ==
X-Received: by 2002:aca:bbc6:0:b0:360:d8c5:1eef with SMTP id l189-20020acabbc6000000b00360d8c51eefmr11109461oif.53.1672272632582;
        Wed, 28 Dec 2022 16:10:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j6-20020aca1706000000b0035a64076e0bsm7482738oii.37.2022.12.28.16.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 16:10:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 16:10:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add support for the AYANEO AIR and AYANEO AIR Pro
 models of handheld devices. These devices use the same EC registers and
 logic as the One X Player mini AMD. Previous AYANEO models are not supported
 as they use a different EC and do not have the necessary fan speed write
 enable and setting registers. The driver is tested on AYANEO AIR while AIR
 Pro model EC functionality and DMI data were verified using command line
 tools by another user.
Message-ID: <20221229001030.GA540645@roeck-us.net>
References: <20221228230632.141917-1-derekjohn.clark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221228230632.141917-1-derekjohn.clark@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:06:32PM -0800, Derek J. Clark wrote:
> The added devices are:
> - AYANEO AIR (AMD 5560U)
> - AYANEO AIR Pro (AMD 5560U)
> - AYANEO AIR Pro (AMD 5825U)

Add:

While at it, fix spelling error (appart -> apart).

> ---
> Bundled all cases that lead to break.
> Spelling and grammar fixes.
> More verbose description of supported devices.
> ---
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  Documentation/hwmon/oxp-sensors.rst | 19 +++++++----
>  MAINTAINERS                         |  1 +
>  drivers/hwmon/oxp-sensors.c         | 52 ++++++++++++++++++++++++-----
>  3 files changed, 56 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 39c588ec5c50..7f6e8def5aef 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -3,18 +3,21 @@
>  Kernel driver oxp-sensors
>  =========================
>  
> -Author:
> +Authors:
> +    - Derek John Clark <derekjohn.clark@gmail.com>
>      - Joaquín Ignacio Aramendía <samsagax@gmail.com>
>  
> -Description:
> +Description
>  ------------

I am not going to accept this. The change is POV, and it is unrelated to
this patch. Either submit a separate patch or let the person requesting
the change submit it. It is very unlikely that I am going to accept it,
though, since the change is POV, unnecessary, and the original author may
rightfully come back tomorrow and submit a revert.

Really, seriously, please refrain from making such changes.

Guenter

>  
> -One X Player devices from One Netbook provide fan readings and fan control
> -through its Embedded Controller.
> +Handheld devices from One Netbook and Aya Neo provide fan readings and fan
> +control through their embedded controllers.
>  
> -Currently only supports AMD boards from the One X Player and AOK ZOE lineup.
> -Intel boards could be supported if we could figure out the EC registers and
> -values to write to since the EC layout and model is different.
> +Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
> +Neo devices. One X Player Intel boards could be supported if we could figure
> +out the EC registers and values to write to since the EC layout and model is
> +different. Aya Neo devices preceding the AIR may not be supportable as the EC
> +model is different and do not appear to have manual control capabilities.
>  
>  Supported devices
>  -----------------
> @@ -22,6 +25,8 @@ Supported devices
>  Currently the driver supports the following handhelds:
>  
>   - AOK ZOE A1
> + - Aya Neo AIR
> + - Aya Neo AIR Pro
>   - OneXPlayer AMD
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90220659206c..8bce95170f12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15346,6 +15346,7 @@ F:	drivers/mtd/nand/onenand/
>  F:	include/linux/mtd/onenand*.h
>  
>  ONEXPLAYER FAN DRIVER
> +M:	Derek John Clark <derekjohn.clark@gmail.com>
>  M:	Joaquín Ignacio Aramendía <samsagax@gmail.com>
>  L:	linux-hwmon@vger.kernel.org
>  S:	Maintained
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index f84ec8f8eda9..36872b57912a 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Platform driver for OXP Handhelds that expose fan reading and control
> - * via hwmon sysfs.
> + * Platform driver for OneXPlayer, AOK ZOE, and Aya Neo Handhelds that expose
> + * fan reading and control via hwmon sysfs.
>   *
> - * Old boards have the same DMI strings and they are told appart by the
> - * boot cpu vendor (Intel/AMD). Currently only AMD boards are supported
> - * but the code is made to be simple to add other handheld boards in the
> - * future.
> + * Old OXP boards have the same DMI strings and they are told apart by
> + * the boot cpu vendor (Intel/AMD). Currently only AMD boards are
> + * supported but the code is made to be simple to add other handheld
> + * boards in the future.
>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
>   * scaled to accommodate for that. Newer boards like the mini PRO and
> @@ -42,6 +42,8 @@ static bool unlock_global_acpi_lock(void)
>  
>  enum oxp_board {
>  	aok_zoe_a1 = 1,
> +	aya_neo_air,
> +	aya_neo_air_pro,
>  	oxp_mini_amd,
>  	oxp_mini_amd_pro,
>  };
> @@ -60,6 +62,20 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *) &(enum oxp_board) {aok_zoe_a1},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_air},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_air_pro},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -161,8 +177,17 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
>  			if (ret)
>  				return ret;
> -			if (board == oxp_mini_amd)
> +			switch (board) {
> +			case aya_neo_air:
> +			case aya_neo_air_pro:
> +			case oxp_mini_amd:
>  				*val = (*val * 255) / 100;
> +				break;
> +			case aok_zoe_a1:
> +			case oxp_mini_amd_pro:
> +			default:
> +				break;
> +			}
>  			return 0;
>  		case hwmon_pwm_enable:
>  			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> @@ -191,8 +216,17 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  		case hwmon_pwm_input:
>  			if (val < 0 || val > 255)
>  				return -EINVAL;
> -			if (board == oxp_mini_amd)
> +			switch (board) {
> +			case aya_neo_air:
> +			case aya_neo_air_pro:
> +			case oxp_mini_amd:
>  				val = (val * 100) / 255;
> +				break;
> +			case aok_zoe_a1:
> +			case oxp_mini_amd_pro:
> +			default:
> +				break;
> +			}
>  			return write_to_ec(dev, OXP_SENSOR_PWM_REG, val);
>  		default:
>  			break;
> @@ -233,7 +267,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * Have to check for AMD processor here because DMI strings are the
> -	 * same between Intel and AMD boards, the only way to tell them appart
> +	 * same between Intel and AMD boards, the only way to tell them apart
>  	 * is the CPU.
>  	 * Intel boards seem to have different EC registers and values to
>  	 * read/write.
> -- 
> 2.39.0
> 
