Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DF26B4D11
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjCJQdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjCJQcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:32:41 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5312CBFD;
        Fri, 10 Mar 2023 08:30:11 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id be16so4707075oib.0;
        Fri, 10 Mar 2023 08:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAELrHo6ArQk1t5su+5ParCDpr/c39PmM5jneNHCCFI=;
        b=G6OI5ju/nJloSHAWprDG0Nk1vm4Xb4C61Q7iax8xymVAyR6Klu17C/62lLgJxqfoiT
         sVMdP7kTQi50XEKpVis842nV3pua2YAE/MEbiRXKGiINrWWzPlquJvWJmBh3VX+7e3gE
         TaOGK+L8FE7uFzoVNYLuaBoinNUZmb7lKonLxGLjcj3NeLJsmAZnHtrRhJCqjNMZGM1Y
         b0OgvvMWkn3g1DKr0YuCdvFFKOuRfbpkJ7IGTwkLJlKXKlMRwyt5Mgs2pB04so4kpqbQ
         FUodbPzNhqIkGoAnFvlhccDV3uOmpxw0QUhORD0mWx5zoqv0iz7MI/njsMNJlzfYpzpZ
         vtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAELrHo6ArQk1t5su+5ParCDpr/c39PmM5jneNHCCFI=;
        b=ie8LibSEZg9SOxW94IdIPjCvxBAza7YbA0pe+og+yftflVV5xedQLLqlx96SdtT5WM
         avhAJT1SEYOW96ZfzcZZnjp8Kdb/GWoDc1Biw36GPY7QBWG3lQN7AUMjpfUp6PTv8FJH
         +Aq4Tc1gqmpYRfVAn0fgRwhXoGxw0EYUwA8GB9H9Fj+LRP6e65TrKmOtwheKYh++51jK
         kMcgL0YUhI5IfzDbGXiZWJQ4RGPKaYzdVIMxtBrU08qLD1kKfHrG2aPd38zqCwa6FR54
         DKLQeWrvXRQSoxTxdvePuswy8osMSQr/NZNqDCnXuvMyI4z3ZCEHHGX/8pV2mACm/rh/
         AEqw==
X-Gm-Message-State: AO0yUKXcBnnT48hEigYUefVt6sCHmj7hcgsXAhFZgKeD8Cw213ED/j7g
        9qjScrEuL+d4XfRnRKIQhjY3zaeBobE=
X-Google-Smtp-Source: AK7set9tPWQI1zdCnMkhi2Rg+Lvrldxw38K4OsfUZH1xNGgaU8zXp+S8x4uenoIzU3cSWzusMCQX/A==
X-Received: by 2002:aca:f0f:0:b0:378:2270:8876 with SMTP id 15-20020aca0f0f000000b0037822708876mr11948901oip.29.1678465809746;
        Fri, 10 Mar 2023 08:30:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id et3-20020a056808280300b00383e0bec93bsm14559oib.49.2023.03.10.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:30:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Mar 2023 08:30:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: ltc4245: Use of_property_read_bool() for boolean
 properties
Message-ID: <138ba352-97ac-4992-9fea-afcfe84a28b8@roeck-us.net>
References: <20230310144707.1542525-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144707.1542525-1-robh@kernel.org>
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

On Fri, Mar 10, 2023 at 08:47:07AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied after s/to to/to/

Thanks,
Guenter

> ---
>  drivers/hwmon/ltc4245.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
> index 5088d28b3a7c..57cbaf3b39fa 100644
> --- a/drivers/hwmon/ltc4245.c
> +++ b/drivers/hwmon/ltc4245.c
> @@ -434,7 +434,7 @@ static bool ltc4245_use_extra_gpios(struct i2c_client *client)
>  		return pdata->use_extra_gpios;
>  
>  	/* fallback on OF */
> -	if (of_find_property(np, "ltc4245,use-extra-gpios", NULL))
> +	if (of_property_read_bool(np, "ltc4245,use-extra-gpios"))
>  		return true;
>  
>  	return false;
