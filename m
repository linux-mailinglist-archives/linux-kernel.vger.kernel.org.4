Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29A96A2A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBYPCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 10:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYPCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 10:02:30 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB8314231;
        Sat, 25 Feb 2023 07:02:29 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso1250849ota.1;
        Sat, 25 Feb 2023 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usCXqN2cCSnj4dT7GAyVtGjFUIiKD/qbjhaNX2F8edA=;
        b=PkjIvRaioq5OxN7nl3+uGp4r8lh5lXIAnAk0fLMFSJkH5eddwAwcUytLn31PxIwkdS
         ceMcl7Nvyw3LC07mqziDLPe+YU6W/PwgAIuYmKIjgHs6LPWKzSdg7pG4iGoO1muRgkvu
         rimST2WaqJ67l5aJxZZhkLYNhUk8b+MQljA2n31jEDs/x+PJgcQlBth09HXqUr8dyWa9
         l8U4TskQrMsKSdkUtnYMmK3wkWLPPcTzL7a7eH21GSuCoxQTHqwuP/c61QBJpNdIMHJS
         SuPhWAWBK6gViJMnE1QXwozHJUn09JKaO/7tTUGVZWvTySVDQH5cuKYQsfqhz25pcYJ5
         +3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usCXqN2cCSnj4dT7GAyVtGjFUIiKD/qbjhaNX2F8edA=;
        b=2TNHcozV+XmXw8XtRRP0eQd/WVOfuXw21fSphRMomBz/AV79IiSMY5j2DIXmEytwbT
         qLUrPiCz/vQhMitg1FMIyx03+FHFJPzkVomty4UPL0pa1I0aghrTZpnUDR6GMsuhjyoA
         KFpT+28f0Kzsz2gNvMiaM/qgsoKUsM9lnZZaEcBos3QyCtOjtL6RKwEkrwRXSLOF/TLL
         RjhUVJW/9G9xfmw1F7XIt0pptRe0Ed07dNJRw8reNtvDLFySGEiWrZMeUtPlfPJV+KnA
         C3v9E85Cw89uBLKduu5zaarWuS3DREIWmMKU1vB+ufRnjSxUIG8VdWvLrCx1GLwtsbM5
         lIWg==
X-Gm-Message-State: AO0yUKUqctcEqSX449IN1a6WMhYGHexq68J1fpHjFqq0QHVYGn5DyDcc
        fs6cm5Ot2butc4Ttq5VQZmQ=
X-Google-Smtp-Source: AK7set8hLPaL7FFVicqv2X6TyxFo2jyY+Qr0CAaC80Vl8FHE6Ug+1WtSJqPmEQRLS4/jrrOJe+lvlw==
X-Received: by 2002:a05:6830:578:b0:68d:6b28:d92d with SMTP id f24-20020a056830057800b0068d6b28d92dmr6111792otc.18.1677337348207;
        Sat, 25 Feb 2023 07:02:28 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t2-20020a9d7742000000b0068d59d15a93sm684181otl.40.2023.02.25.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 07:02:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 25 Feb 2023 07:02:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (adt7475) Display smoothing attributes in
 correct order
Message-ID: <20230225150225.GA3625646@roeck-us.net>
References: <20230222005228.158661-1-tony.obrien@alliedtelesis.co.nz>
 <20230222005228.158661-2-tony.obrien@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222005228.158661-2-tony.obrien@alliedtelesis.co.nz>
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

On Wed, Feb 22, 2023 at 01:52:27PM +1300, Tony O'Brien wrote:
> Throughout the ADT7475 driver, attributes relating to the temperature
> sensors are displayed in the order Remote 1, Local, Remote 2.  Make
> temp_st_show() conform to this expectation so that values set by
> temp_st_store() can be displayed using the correct attribute.
> 
> Fixes: 8f05bcc33e74 ("hwmon: (adt7475) temperature smoothing")
> Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>

Applied.

Thanks,
Guenter

> ---
> Changes in v2:
> - None
>  drivers/hwmon/adt7475.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 51b3d16c3223..77222c35a38e 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -556,11 +556,11 @@ static ssize_t temp_st_show(struct device *dev, struct device_attribute *attr,
>  		val = data->enh_acoustics[0] & 0xf;
>  		break;
>  	case 1:
> -		val = (data->enh_acoustics[1] >> 4) & 0xf;
> +		val = data->enh_acoustics[1] & 0xf;
>  		break;
>  	case 2:
>  	default:
> -		val = data->enh_acoustics[1] & 0xf;
> +		val = (data->enh_acoustics[1] >> 4) & 0xf;
>  		break;
>  	}
>  
