Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450926189A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiKCUgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCUge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:36:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F8410AF;
        Thu,  3 Nov 2022 13:36:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k22so2714006pfd.3;
        Thu, 03 Nov 2022 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLrzIidolT+xc06DFOsj1BiO5uh6NNhCUl/p3YFUbo4=;
        b=U5iLI+ckjIK5W52v1WEwrJSTnXXfEETUGsJPv9Z6eg0BvkR0sQN4vTymyeRFlwPFV4
         tIIPVMNm1bG3P+uLNzOUYxs7w2smYMyRasM2NsKQSSuFhdwEg/oV9rFLcEtojNDtEGFx
         ZlWkdXb3EG+jxIPkyB7PTFhbC+VjEZK7e6zBLDdVfHvOyaEkBHgOx+pxb9nG/rrGv3Jq
         L4FmO3SfiwJI6KFxFZZdOANH045OFabcyJV4sLQh6LnutNK/z+qTkx77D6otwDpBnbU/
         x0QpqOdE5gvqpsZAk8CbhzNiBwpQTt2E6Z0Y1XkxI6e1Ekoyx6+XOq0jx8/Hi7RAe7ov
         TdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLrzIidolT+xc06DFOsj1BiO5uh6NNhCUl/p3YFUbo4=;
        b=JnpZHrEMkzbM/stZ2ylxKqCQpGFJFcOoeQbSi241zCchcNBGYZNaFtiTRzZ95kotF3
         4Dd92ybFdVm5AjuLH+epYJFtA3qErR3VlhQyvQR+ACeN3i3XXOkAE/qPqdTMdUw6qAwI
         u3/DecrhUdj/IlX1nVHXpiX5Ksvv8syWoYOIi5LPpp9WUYbhffRPwZ3Yei778//B3RTH
         bjeOErij4rCj/hFfa383HZe+sKeZ8s241oZ9aF/c3TGltBBR2w0lfJUYGObDN+hch0Hl
         1XzOXNzRdbcIBYmK2HcsQrmyX+aa4SjaseZpZkq9ELTMtFONI96OxBnaBG0W4ZVJ1EZ1
         MRxg==
X-Gm-Message-State: ACrzQf1QqPsf9hGq/dC51No3IhfeJbKu1yjljPWmuA4eyAWV8PHDNPch
        ZgEqJNynKsZNxTxwutJiTvw2aB5SQPQ=
X-Google-Smtp-Source: AMsMyM6X79Jrq1zfdFszaXsV+kFll5k4/hf7+sME8OLFpys6osvRodYwwHJIKS1C7UCNkTUOaFFr5A==
X-Received: by 2002:a05:6a00:4ac3:b0:56d:6e51:60eb with SMTP id ds3-20020a056a004ac300b0056d6e5160ebmr23459645pfb.58.1667507793061;
        Thu, 03 Nov 2022 13:36:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id h16-20020aa796d0000000b0056cea9530b9sm1129489pfq.200.2022.11.03.13.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:36:32 -0700 (PDT)
Date:   Thu, 3 Nov 2022 13:36:29 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Make use of device_match_of_node()
Message-ID: <Y2QmTSfA4qRUarxA@google.com>
References: <20221103203005.25743-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103203005.25743-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:30:05PM +0200, Andy Shevchenko wrote:
> Make use of device_match_of_node() instead of open coding its
> functionality.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 52616848a37c..4b91e19366a8 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -85,7 +85,7 @@ static int of_gpiochip_match_node_and_xlate(struct gpio_chip *chip, void *data)
>  {
>  	struct of_phandle_args *gpiospec = data;
>  
> -	return chip->gpiodev->dev.of_node == gpiospec->np &&
> +	return device_match_of_node(&chip->gpiodev->dev, gpiospec->np) &&
>  				chip->of_xlate &&
>  				chip->of_xlate(chip, gpiospec, NULL) >= 0;
>  }
> -- 
> 2.35.1
> 

Thanks.

-- 
Dmitry
