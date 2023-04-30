Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE16F28E9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjD3Mtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 08:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3Mtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:49:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98119A5;
        Sun, 30 Apr 2023 05:49:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b60365f53so1987454b3a.0;
        Sun, 30 Apr 2023 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682858989; x=1685450989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AskwpvcZACrusV969mOwr01id7ph7N4caZ81qYgEcK8=;
        b=NP1DZtlHxJ1/oSnp43mwZJa55OPL4nIgR3Brls9mZBz3ifCQ0bvz91Rw8+GLMgTAfP
         IwhWdBF9H06A5Zou3DlNDiBn8LrZB0DYsEfbX+Eahp8NdVHSbWNC25a285leWFkEOQxe
         YqKjcXn+lSwsnUjzTnffzy9QhuGD0sa0DKoEJT2Lb7rGbJL3uE7Wz1sCJAaOht+8SVCD
         rGOyYHy4swB7yiJ8qCyrs509VGuh2iPjxGhBZjXCF6XLBtmj2pEoldjMmwtE02FJecUd
         sAGqAsi3SoxhRQ9XzLkw2Z7NhMz/hz24cynKStzU1ITygaraSUsdZtjsGui6j0Bk04Di
         yYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682858989; x=1685450989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AskwpvcZACrusV969mOwr01id7ph7N4caZ81qYgEcK8=;
        b=MmvsTyO/gGHOWa/RQ7EPauSbAhPIa7yVMUntz+deu3+uNIam75b5TGMUtpxbqygLot
         HWdHbnBRjYp3jxx83NlDDM2fpVML59YXXo3kIapSR/EBHBw66hwRI8YHilNMcxfa94g4
         xnnoSkiMcRgDHYi6H3TbUHGZnG3NKHimOjC+vZ3zFxRtldQiift+rd5ldWOJbeaH8Jx6
         pY4mgtsra+k+B/9cbb4N30T4q+6dTtQkr+JZcXXIveXtcowou63zQs5X1w88uMib8eWZ
         sOhzDaXhcimL/nQfQVMKnGHkGx6QP/jmyKM8W/ad4mMCTRn8m2IpjzOWbD/39u155se7
         3AVw==
X-Gm-Message-State: AC+VfDyC+2imMhTlOWEO/5cHBV0jRi4A8AVfipmUY9agFcv2bBMw00s0
        4pxqGAY5qwqbThpHHgJq98jnmfpx4s0=
X-Google-Smtp-Source: ACHHUZ6mvdI6MU96aj9UwrSDXPSI0L+71/pNsWMP6nG3txWRCMzAg425kzNs/bGfSSHNmpboFGk22A==
X-Received: by 2002:a17:902:ab44:b0:1a9:8769:36bb with SMTP id ij4-20020a170902ab4400b001a9876936bbmr9653391plb.54.1682858988546;
        Sun, 30 Apr 2023 05:49:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u7-20020a170903124700b001a260b5319bsm2788245plh.91.2023.04.30.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Apr 2023 05:49:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 30 Apr 2023 05:49:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, manio@skyboo.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property
 APIs
Message-ID: <a52663d8-dc5f-4360-87c7-5089f942dfe3@roeck-us.net>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
 <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
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

On Wed, Apr 19, 2023 at 11:36:56AM +1200, Chris Packham wrote:
> Instead of of_property_read_*() use the equivalent
> device_property_read_*() API. This will allow these properties to be
> used on DT unaware platforms. For DT aware platforms this will be a
> noop.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> 
> Notes:
>     This is an additional update for master from the preceeding bugfix
>     commit. I've not added a fixes tag for this one because I don't think
>     there will be a behaviour change for existing usages.
>     
>     I know we have one upcoming DT unaware platform that we may want to use
>     some of these properties via ACPI tables so I won't object if this ends
>     up on the stable track but I don't think it meets the criteria for
>     stable.
> 
>  drivers/hwmon/adt7475.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 6a6ebcc896b1..3b9289bc5997 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1468,7 +1468,7 @@ static int load_config3(const struct i2c_client *client, const char *propname)
>  	u8 config3;
>  	int ret;
>  
> -	ret = of_property_read_string(client->dev.of_node, propname, &function);
> +	ret = device_property_read_string(&client->dev, propname, &function);
>  	if (!ret) {
>  		ret = adt7475_read(REG_CONFIG3);
>  		if (ret < 0)
> @@ -1494,7 +1494,7 @@ static int load_config4(const struct i2c_client *client, const char *propname)
>  	u8 config4;
>  	int ret;
>  
> -	ret = of_property_read_string(client->dev.of_node, propname, &function);
> +	ret = device_property_read_string(&client->dev, propname, &function);
>  	if (!ret) {
>  		ret = adt7475_read(REG_CONFIG4);
>  		if (ret < 0)
> @@ -1556,8 +1556,8 @@ static int set_property_bit(const struct i2c_client *client, char *property,
>  			    u8 *config, u8 bit_index)
>  {
>  	u32 prop_value = 0;
> -	int ret = of_property_read_u32(client->dev.of_node, property,
> -					&prop_value);
> +	int ret = device_property_read_u32(&client->dev, property,
> +					   &prop_value);
>  
>  	if (!ret) {
>  		if (prop_value)
