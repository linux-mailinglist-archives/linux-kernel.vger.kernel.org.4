Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9CE5ED7B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiI1I1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiI1I1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:27:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28372FC1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:27:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so2087014wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lIZkVJj/+0M/778lpgTUWdNSZmlLsxXrL8AdvSaQ9uA=;
        b=ctPKPM5Hp+aKGXd5b/qxoarEEZRc2m1B0LQIsoArSVt5/7H41uh661gxi/RDml0rYd
         2r5BOIbXaMA3kX29XCKdaKjq+qXIsUhbWER32FXPcRD17gVj+FghNG53UZyxQEpFlD4Q
         kVP6B2XVQA7RU6vjT2l3GCnPiCYCy5mF/v/NFHU0ThwaU7wdPrtJlSABrndONBoBgMao
         TSb1o8jhHk9pHR1iolqzJMqxNe9kiGwyfGv8N4mTk5mCvrXtxFjs+b5mm9FmDKjtGKOe
         1009NmbFv/t7L9YUIjhcR2kCOcuGZiIHRC6m5n9UvIip7Dk8KGnz21Ha8miWD9A5cJ25
         Z+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lIZkVJj/+0M/778lpgTUWdNSZmlLsxXrL8AdvSaQ9uA=;
        b=q+LisQyep2Dh84mZbnLEigctintz3PHPwXDj6vYd8GZpvc6bUfe0EuT+JYW6qsTpOq
         x5aJvPqR4pYCir2bUUgXdARHH99RzQsiID9SC3DVEW39FeKhJ6A6ZwBW8QMqBpuHxnpg
         ntUc2PaqmkQDtUSMZy+EJ5+Y9fR0JZMlJI/kKqhJCq6CyuQr0u3IienjSZOGPWWZVg5v
         FRCAvmwfV3/ixeIZRmPgR+yxSNRJl9KUwu+NgVCgkePa/2ABEnplYGNYzd0igraU/RdN
         i4jWCKxjUv9vzc+JQdDlfyxL5EhHtRlub5aW9eovaP5SOLenS32qn8lBuKEm5Qaf1M4O
         xHew==
X-Gm-Message-State: ACrzQf3hAkZ2gh6qiY6EyvO0H5QqVn04+X+FgX/LYjjr7X0McS/vudis
        PrCFe+2MHl8jbyLFghGS1vnBAQ==
X-Google-Smtp-Source: AMsMyM5WybFYGhvPIuGUG0NAbItu/BNNr4V3dn5K2Y44thiLh67dAhNGUZdbVuP/yWoFCFZh7xh5MQ==
X-Received: by 2002:a1c:7c12:0:b0:3b4:73e1:bdd7 with SMTP id x18-20020a1c7c12000000b003b473e1bdd7mr5998070wmc.32.1664353631341;
        Wed, 28 Sep 2022 01:27:11 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t18-20020adfe452000000b00228cd9f6349sm3714776wrm.106.2022.09.28.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:27:10 -0700 (PDT)
Date:   Wed, 28 Sep 2022 09:27:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     yexingchen116@gmail.com
Cc:     jingoohan1@gmail.com, lee@kernel.org, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next v2] backlight: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <YzQFXLD/G90+YEdo@maple.lan>
References: <20220928014115.261470-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928014115.261470-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 01:41:15AM +0000, yexingchen116@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
> v1 -> v2
> Add the rest of this fixes for this pattern in the 'drivers/video/backlight' directory.
>  drivers/video/backlight/lm3533_bl.c | 10 +++++-----
>  drivers/video/backlight/lp855x_bl.c |  4 ++--

What happened to the lp8788 fixes?


Daniel.


>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index 1df1b6643c0b..5e2ce9285245 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -66,7 +66,7 @@ static ssize_t show_id(struct device *dev,
>  {
>  	struct lm3533_bl *bl = dev_get_drvdata(dev);
>
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", bl->id);
> +	return sysfs_emit(buf, "%d\n", bl->id);
>  }
>
>  static ssize_t show_als_channel(struct device *dev,
> @@ -75,7 +75,7 @@ static ssize_t show_als_channel(struct device *dev,
>  	struct lm3533_bl *bl = dev_get_drvdata(dev);
>  	unsigned channel = lm3533_bl_get_ctrlbank_id(bl);
>
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
> +	return sysfs_emit(buf, "%u\n", channel);
>  }
>
>  static ssize_t show_als_en(struct device *dev,
> @@ -95,7 +95,7 @@ static ssize_t show_als_en(struct device *dev,
>  	mask = 1 << (2 * ctrlbank);
>  	enable = val & mask;
>
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
> +	return sysfs_emit(buf, "%d\n", enable);
>  }
>
>  static ssize_t store_als_en(struct device *dev,
> @@ -147,7 +147,7 @@ static ssize_t show_linear(struct device *dev,
>  	else
>  		linear = 0;
>
> -	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
> +	return sysfs_emit(buf, "%x\n", linear);
>  }
>
>  static ssize_t store_linear(struct device *dev,
> @@ -190,7 +190,7 @@ static ssize_t show_pwm(struct device *dev,
>  	if (ret)
>  		return ret;
>
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>
>  static ssize_t store_pwm(struct device *dev,
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index bd0bdeae23a4..fafc1a9e76ef 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -293,7 +293,7 @@ static ssize_t lp855x_get_chip_id(struct device *dev,
>  {
>  	struct lp855x *lp = dev_get_drvdata(dev);
>
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", lp->chipname);
> +	return sysfs_emit(buf, "%s\n", lp->chipname);
>  }
>
>  static ssize_t lp855x_get_bl_ctl_mode(struct device *dev,
> @@ -307,7 +307,7 @@ static ssize_t lp855x_get_bl_ctl_mode(struct device *dev,
>  	else if (lp->mode == REGISTER_BASED)
>  		strmode = "register based";
>
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", strmode);
> +	return sysfs_emit(buf, "%s\n", strmode);
>  }
>
>  static DEVICE_ATTR(chip_id, S_IRUGO, lp855x_get_chip_id, NULL);
> --
> 2.25.1
>
>
