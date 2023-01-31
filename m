Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4AD6830EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjAaPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjAaPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:08:39 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FB56EF7;
        Tue, 31 Jan 2023 07:06:03 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id bx13so7246442oib.13;
        Tue, 31 Jan 2023 07:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61+BShUugDkZ0VhGuRrbn1OiczfmhbrhrlGUrDj5PIM=;
        b=hYdjooPL9vlZ4Cx5DDbY7oY0KyooulwBNmsGpMZIDIoXbZHhGxZ2BbkI7F+yxmUSUl
         CD/YT3uMffGdBhkTchdKQsc8kYcmwm8h1cgKAI9Drh2EAU79QDgnXUkt1DslOZ+DtVPq
         Wg/ww8V20TfPZTOXVXPWbX6LSS5xjRlqGE5oE+PtGF9mSKZ7tH8VjRfBX2oBEgtqQb8p
         6v5LIn9azMQ0Hs7Cw6gpYEBG0BSJe9b+937F9IVvpri32lEE7F67B3m5cWp2iemeGMab
         PdZIJ4e+whNk5jyBW393gVIRQV9b4EhGVx/Pbxh+1RVwFRXckPSkAl7QFsv/Hckl7m83
         nFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61+BShUugDkZ0VhGuRrbn1OiczfmhbrhrlGUrDj5PIM=;
        b=Vhblzq1sHPYEFOEbsYLYa+v6y/rkF467CovseboR8rSwcQb9fQgzer5A3Ct8uC/sxN
         aWI89AslFqlkqeicN1l4jB7KKEw7+rvJCTJtDoEeIY5+CeoYxqZS9i/nCDRRLAD1EkFV
         gqzG/dqxu3bCZhtPx3xunHGKynVzheyCEAwhNw8cfSZVVj+Uy9B83+tzzPCMO3y9rzaF
         dz7oHOeWvIvOPo+qKIIagz1nHEKpQmfF/DDyVt0GoWAjM0uc68rk+6Fplg/3qxCcleu7
         0u+qOfrtkbnb+b0VOVBIijOg9mE5r5JaTU4evvUJNoFrqsagq8RULa0vI1sJJ1XDwdGG
         CiGA==
X-Gm-Message-State: AO0yUKWlvMsps57AJc4iuTIjxs7YSixVmBcY3auMNiJi6+9d8JmhXWno
        9x+b06R7MQQ/KCIwcnIMc5l0xbLRq4U=
X-Google-Smtp-Source: AK7set8ed0PETP/W0dQXCld392TgdFwIW1kDazuR8bsGTteZu2UXpJvdKzvHhM9QrrbZkZVldqixGA==
X-Received: by 2002:aca:2804:0:b0:378:7ec:b7e1 with SMTP id 4-20020aca2804000000b0037807ecb7e1mr5057571oix.55.1675177504006;
        Tue, 31 Jan 2023 07:05:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m7-20020aca6507000000b003631fe1810dsm3141700oim.47.2023.01.31.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:05:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 07:05:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: (iio_hwmon) use dev_err_probe
Message-ID: <20230131150502.GA3591814@roeck-us.net>
References: <20230131103359.625081-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131103359.625081-1-alexander.stein@ew.tq-group.com>
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

On Tue, Jan 31, 2023 at 11:33:59AM +0100, Alexander Stein wrote:
> Instead of just returning an error code, add an error message as well.
> While at it, simplify the code and use a common return path.
> Upon deferral this also nicely lists the following message in
> /sys/kernel/debug/devices_deferred:
> adc     iio_hwmon: Failed to get channels
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/iio_hwmon.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
> index 3aa40893fc09..4c8a80847891 100644
> --- a/drivers/hwmon/iio_hwmon.c
> +++ b/drivers/hwmon/iio_hwmon.c
> @@ -77,9 +77,11 @@ static int iio_hwmon_probe(struct platform_device *pdev)
>  
>  	channels = devm_iio_channel_get_all(dev);
>  	if (IS_ERR(channels)) {
> -		if (PTR_ERR(channels) == -ENODEV)
> -			return -EPROBE_DEFER;
> -		return PTR_ERR(channels);
> +		ret = PTR_ERR(channels);
> +		if (ret == -ENODEV)
> +			ret = -EPROBE_DEFER;
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get channels\n");
>  	}
>  
>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
