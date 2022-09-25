Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C176F5E93B9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiIYOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIYOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:44:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EDB2D1E1;
        Sun, 25 Sep 2022 07:44:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t3so4167002ply.2;
        Sun, 25 Sep 2022 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=IZIF93bHpx1XPGat0cPOoaLu/m7t5dn6/nxkSKAG7UY=;
        b=XZofN7Wr07L9QvdRnTG8nyF/mDN3ZqQ4YOqa3WBBkJsVwV5JB5HSttqvmrrDX15EYE
         qdZz6Sx4awtEZrQej9vE89Py/rV4dfUzGPv4OadcMnvtPiZiqDFTDwiUoGuwcUV/+e45
         CSPxFazoQmjqUQIGICBuOpPf56Fy7xc8MKJCbjdqgRI2lG9KIEcqOxxbkv/WKIdVgWok
         WuL743HmgsaL4U+Hjwm7WBU9JgNfmwNzQBplMCLf+/xL06GYRiX7E6gE8rkjH2nnM16o
         5/PrWvpyPn5jJITgbmby+KvotkPpPLTvVJZfQolzwUlGkoGPYOyfmZwc363JxBBbNbYB
         61ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IZIF93bHpx1XPGat0cPOoaLu/m7t5dn6/nxkSKAG7UY=;
        b=5BNtipkP4ttLcz4vKOaBBpal6mjZMNvOvrhJEacM6ro5rGlUiXu3uXjlMHC0OLTsvv
         JPNlXJpkkqaV/WOOAyT4YX05xw2jTGxzjl8E5ls7XwZqsBL6Pn2mj7+oTZQlPhUlkp/w
         /XWcwWTJ4LNxV74gghmMdDtxYvbUa5L5zYH2QvUnuimU1RC66mS+UzFq8L2kWsTUBkcS
         Hf2rFrxb7jnTpKgrc3cAdsKyzQKYuIjUnfE2lko/nEcRDPsn49uCycVDr+A/muKT5Lsu
         mwyKmArjv8X9tIpaI/cjOx35q+DioWqy4m9w8PPl5an+/sNJlQBHQnHAFTxaJjO3zt1a
         QT/g==
X-Gm-Message-State: ACrzQf1yDMULYE187nTLYCGf1WxLwJ7BmV9jQHI4x84KFRIy8Eh8iGH/
        kaWhA4Ohk/6yyi4xt9LFLoU=
X-Google-Smtp-Source: AMsMyM5scIvWqmZ7OkGc08vYxY9hpzHOTVM28RFicqKXovLwDUGFshAiC2cqxnJIejrNoYhKw3FBSA==
X-Received: by 2002:a17:902:d550:b0:178:6155:9b7a with SMTP id z16-20020a170902d55000b0017861559b7amr17277334plf.38.1664117062349;
        Sun, 25 Sep 2022 07:44:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l187-20020a633ec4000000b0043057fe66c0sm8911266pga.48.2022.09.25.07.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:44:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 07:44:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bo Liu <liubo03@inspur.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Check dev_set_name() return value
Message-ID: <20220925144420.GA1753643@roeck-us.net>
References: <20220920020312.2383-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920020312.2383-1-liubo03@inspur.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:03:12PM -0400, Bo Liu wrote:
> It's possible that dev_set_name() returns -ENOMEM, catch and handle this.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/watchdog_dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 54903f3c851e..744b2ab75288 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -1015,7 +1015,11 @@ static int watchdog_cdev_register(struct watchdog_device *wdd)
>  	wd_data->dev.groups = wdd->groups;
>  	wd_data->dev.release = watchdog_core_data_release;
>  	dev_set_drvdata(&wd_data->dev, wdd);
> -	dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
> +	err = dev_set_name(&wd_data->dev, "watchdog%d", wdd->id);
> +	if (err) {
> +		put_device(&wd_data->dev);
> +		return err;
> +	}
>  
>  	kthread_init_work(&wd_data->work, watchdog_ping_work);
>  	hrtimer_init(&wd_data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
