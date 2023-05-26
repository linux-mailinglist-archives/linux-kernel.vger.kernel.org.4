Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B68713063
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjEZXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjEZXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:32:00 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F01FB;
        Fri, 26 May 2023 16:31:59 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso1952663a12.1;
        Fri, 26 May 2023 16:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685143919; x=1687735919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHVtfq5jmB1AWrOb8c1sWgrTwMKjesbny2EwybzoRP0=;
        b=n6TwTU8OSVkMET2ybbh1T7Jo79jsD/jOB0ixcFZaKz5lPC9lHYiYffmZLLqX6iB4u6
         jUrYwOfRE6zf5WOFhF9lPJsv1HEhMvShOSTfkRA+pyY10st73gifYiKjx7SXAMRJYLlO
         bYpFQ4U2QZFRJX3Okp6rfnE4dNWorrwY3aRh1rAZIhZZXSiy8bkMt4+69uD3UBIcJZH5
         ihnC2gr4TGRFXXCCjqyjwuIgh+9sBkXHjK09AqZ0NMcQrKJRXpkz7NdqZTzz3a9J8xTp
         49BccE+HeXjMJgEy95CbnoWQoPKiWAXtIWb6zLhbAW9SaUJWw9hPNRpIckxAQJPWbhWp
         v5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685143919; x=1687735919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DHVtfq5jmB1AWrOb8c1sWgrTwMKjesbny2EwybzoRP0=;
        b=ZAQEMOYFAPJnt6FHkRfumaiWuih9HnjWX2wXYEP5WOfxpUsh1LroYQT2FGHVsJlDoU
         jomXaWp6bD+GCYo9QhwOn32WUbtJqOMYDnRES76W9hxSXC22u0Ienj2jds82+UFM81LJ
         zmPKAZvUq3Tr6+NwYRTZbCWb10bJdQqHLwnOU9uzCeRBuoOUcSeLXpGxYkuGga0Y+11C
         7va52VClSrwyoAETrptM27Cbl3qv0SWoWidPDiXlz37nOiiChKCOlwHf5CQkTPXva7Z7
         Lp36ppz9SHIU8tSn6JlbAEim7gs/hSV2VT09fpC0++kJG/TkIshZk+Gzhb5j0S5Wmzv1
         PRHw==
X-Gm-Message-State: AC+VfDzyLlPhgbXq2pMCSAZfo5dWoibmV/3x42x1cVkPHglehNXFpPy1
        xSbN9xoM8Pvh+9yzCWUdz2A=
X-Google-Smtp-Source: ACHHUZ72QHKEXQAzg3LfZgYbHfAyo1uh0FyY4QiSYu9PfHNrKJRhY83haSPdRqiSVrfiFFXcZVleCQ==
X-Received: by 2002:a17:902:dac7:b0:1af:ea40:34f2 with SMTP id q7-20020a170902dac700b001afea4034f2mr931991plx.11.1685143919104;
        Fri, 26 May 2023 16:31:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902a40800b001ac618a6d55sm3744401plq.242.2023.05.26.16.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 16:31:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 26 May 2023 16:31:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Differentiate new BIOS for the Mini
Message-ID: <430e7be0-26a9-43b0-a61f-66cb8dfc805e@roeck-us.net>
References: <20230526215621.16075-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526215621.16075-1-samsagax@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 06:56:22PM -0300, Joaquín Ignacio Aramendía wrote:
> Newer BIOS got some other changes aside from string changes. Add a board
> enum to differentiate it from the old OneXplayer Mini AMD BIOS.
> 

I see no functional difference. What is the point of this change ?

Thanks,
Guenter

> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> ---
>  drivers/hwmon/oxp-sensors.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 0ec7588610ad..423307ed4930 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -47,6 +47,7 @@ enum oxp_board {
>  	aya_neo_air_pro,
>  	aya_neo_geek,
>  	oxp_mini_amd,
> +	oxp_mini_amd_a07,
>  	oxp_mini_amd_pro,
>  };
>  
> @@ -104,7 +105,7 @@ static const struct dmi_system_id dmi_table[] = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER mini A07"),
>  		},
> -		.driver_data = (void *)oxp_mini_amd,
> +		.driver_data = (void *)oxp_mini_amd_a07,
>  	},
>  	{
>  		.matches = {
> @@ -206,6 +207,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  			case aya_neo_air_pro:
>  			case aya_neo_geek:
>  			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>  				*val = (*val * 255) / 100;
>  				break;
>  			case oxp_mini_amd_pro:
> @@ -247,6 +249,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  			case aya_neo_air_pro:
>  			case aya_neo_geek:
>  			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>  				val = (val * 100) / 255;
>  				break;
>  			case aok_zoe_a1:
> -- 
> 2.40.1
> 
