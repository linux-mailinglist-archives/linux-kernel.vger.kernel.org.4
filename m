Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3135FC3BD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJLK3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJLK3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:29:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F57CB2741
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:29:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n12so25542331wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cMt1aL/E1BmzA/95rCNVdItc5Kfhg0GFqfGel3e+zbE=;
        b=bHfVRBUuRXOtzm5qHBRADP8cD7GTOZXxO80RTmHUCSkO5IAW3rFX1sWl2055ma4y+h
         Njw1FT0LA9lH8iTi3jBdIyj6iNlKqkQyKlP+tBIEWw/NlwJ9Mxsky/FTvDm9ZPzP22HV
         7dN7zO3lCWKRCaa/7xE178mNydWYGmFTY3Itxith055fTzksOBVyhVYocjWDm9n0zUw+
         ylwylW7QzAkyPOg38jl8vo60Nq2k3rye/izFSh1zF/iggo6xtDAWk6SfjtjHYeqDojhr
         BD8TznS3Ylqe3FoOMuDc6pQ7o37w/PMNxne5mzhtu5XjEtQagSErN7U+IFMq+jKJmSn9
         lDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMt1aL/E1BmzA/95rCNVdItc5Kfhg0GFqfGel3e+zbE=;
        b=Ruy3tBYpcdp9PoedGpC4+AxJgb76sXVmevO+yPaRWXHYAyUvTLCmMkTMvgD0Fy4U+p
         rUyEKbIvP5nXrWwwzjTYuqfi/AEE1NkhgmY8jnyk5YYL8WPIbVVEqoAmP6BV6MWmH9v3
         qCJQvItVOjoYeysGStP+6QDzkAefhe1hqb5znH3EHUsjjmJl+TT1jzJHMiXjW8VF9/1j
         30ZTowB6XHdDvrQSygoYIqQdd7bRatb2rFtIZoyeRWnVpBoUxasgy/WSpTeu31nk/e4v
         0LBDFWoYNvhbbTqVCh3VGvav/cDVQNtP20N77ciA5FWOHtV7leCjvfyX076katRq1Wjv
         7FlA==
X-Gm-Message-State: ACrzQf2o5VoFzzZfOCHyUfUxL1lLv0bRuJ823wYoJSzPusSayoKi1PBN
        lvpa1dDiUIe9Pw9Qrl27X3wdPFg8wiEdtu+d
X-Google-Smtp-Source: AMsMyM6aleo8xLLLDII4VdjsqTh4bJE28lsCUuyzn3j+VQwOmEWm/XTqLD9AyPCLE57sGU8ie7I5rg==
X-Received: by 2002:a5d:5d89:0:b0:226:e5ca:4bc2 with SMTP id ci9-20020a5d5d89000000b00226e5ca4bc2mr17755457wrb.310.1665570544589;
        Wed, 12 Oct 2022 03:29:04 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c188-20020a1c35c5000000b003b4a68645e9sm1430138wma.34.2022.10.12.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:29:04 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:29:02 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 4/7] gpiolib: of: add a quirk for reset line for Marvell
 NFC controller
Message-ID: <Y0aW7vDxfNa/8bAk@maple.lan>
References: <20221011-gpiolib-quirks-v1-0-e01d9d3e7b29@gmail.com>
 <20221011-gpiolib-quirks-v1-4-e01d9d3e7b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v1-4-e01d9d3e7b29@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:19:32PM -0700, Dmitry Torokhov wrote:
> The controller is using non-standard "reset-n-io" name for its reset
> gpio property, whereas gpiod API expects "<name>-gpios". Add a quirk
> so that gpiod API will still work on unmodified DTSes.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

How/when has/will the DT bindings documentation for this hardware be
updated to describe the new bindings?

Delivering the quirks ahead of driver updates is great for avoiding
merge conflicts but it also conceals the rename from reviewers so
risks neglecting to update the bindings.

Other than that:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

> ---
>  drivers/gpio/gpiolib-of.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 576f2f0c3432..7d4193fe36e5 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -383,6 +383,16 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
>  #if IS_ENABLED(CONFIG_MFD_ARIZONA)
>  		{ "wlf,reset",	NULL,		NULL },
>  #endif
> +
> +#if IS_ENABLED(CONFIG_NFC_MRVL_I2C)
> +		{ "reset",	"reset-n-io",	"marvell,nfc-i2c" },
> +#endif
> +#if IS_ENABLED(CONFIG_NFC_MRVL_SPI)
> +		{ "reset",	"reset-n-io",	"marvell,nfc-spi" },
> +#endif
> +#if IS_ENABLED(CONFIG_NFC_MRVL_UART)
> +		{ "reset",	"reset-n-io",	"marvell,nfc-uart" },
> +#endif
>  #if !IS_ENABLED(CONFIG_PCI_LANTIQ)
>  		/* MIPS Lantiq PCI */
>  		{ "reset",	"gpios-reset",	"lantiq,pci-xway" },
>
> --
> b4 0.11.0-dev-5166b
