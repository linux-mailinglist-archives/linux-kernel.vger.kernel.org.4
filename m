Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2317D69CEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjBTOJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjBTOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:09:06 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D141BE9;
        Mon, 20 Feb 2023 06:08:31 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id t6so692993ioj.8;
        Mon, 20 Feb 2023 06:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Y9RRT+lR50hAVTTs81gKUUVMeO675YNPBw7XMDS9SE=;
        b=f2IeHq3AX8ZN2qO4Ktxb3S7GNocDhX+2XVpSyXHCV7aUcHmfuZvhLwHtWvomZ2xhAG
         xvmZDfRIaJ9iLZtnqiEbz++uOhritlUNg5wA7ihIwNWYVR4dgkUxlh9xrgd6C4UKYwU7
         gw8ysYmMROmCNhOgjAIK+vE+hzQyPYKeBtRWdg9Px+aXRwcNhJB95ZuQD1SpBqmpc0S8
         zNEYTPhXAgKaHrWQNcjvWY5X4jfQ4cps8ucS1iJCoVBCz/37nO4kYsrkqN3spfhlViWh
         dwWE7mW5bnKbL2kMVDV48AB22k8mYty5t2257ZNguxqz7vP24Z9RT8gOuU0OWI/Sw6pu
         mFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Y9RRT+lR50hAVTTs81gKUUVMeO675YNPBw7XMDS9SE=;
        b=Vncvoe+8cMxikSy7pZW6/jZ8KSfwtnxeHr2WOu4KY0f/5nraci19STxSNHnhfke2o5
         Dk8yOWAntlWsAfU/33r1FjhXgx2OqCA5RXwLnyM70B0tRDukTPHhjGVpiynXJc0eq5Sy
         80xOuS/1e2kfUEC3b2JEJxxXExij/AoLuRiO+1n71lAVcMVQsFBOOz8/qljmNaALGRqv
         Cu38Cma3c5bSW4zQKa8p4uj7edxp1Hzd7/Nyj4BOnw7CYDRRJgmW1S9GRL4nylgxfbC4
         CgEr7lgb6gYFDzxpbFLehl6KnIjNu5w4jblniqkQElbH8pzK1C/OCxhsIcaUqloLfjM8
         8eaA==
X-Gm-Message-State: AO0yUKUvmcwPp3e+dejgEskpCqHZfm65yk2CryO5ieZcbDl0bjslR6ua
        N5DP/qHCAdqRDkvgSpfqNDw=
X-Google-Smtp-Source: AK7set/IdJiSmcCRQ7VUt6mWYO+d7SWfUaE/3afkJ70SPWwLaURgAeaqEYN0VYiQf4OSejLsHDVKhw==
X-Received: by 2002:a5e:a914:0:b0:715:cba2:d505 with SMTP id c20-20020a5ea914000000b00715cba2d505mr173805iod.0.1676902110258;
        Mon, 20 Feb 2023 06:08:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k17-20020a6b6f11000000b0071db3975335sm3688701ioc.12.2023.02.20.06.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:08:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 20 Feb 2023 06:08:26 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        jordan.crouse@amd.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (adt7475) Fix setting of hysteresis registers
Message-ID: <20230220140826.GA4009286@roeck-us.net>
References: <20230219232956.23784-1-tony.obrien@alliedtelesis.co.nz>
 <20230219232956.23784-3-tony.obrien@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219232956.23784-3-tony.obrien@alliedtelesis.co.nz>
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

On Mon, Feb 20, 2023 at 12:29:56PM +1300, Tony O'Brien wrote:
> In temp_store(), for the hysteresis setting calculation there were two
> errors.  The first tries to clamp the hysteresis value by comparing the
> required hysteresis value to THERM - 15C.  This is incorrect since the
> hysteresis value is a relative value whereas THERM - 15C is an absolute

No, it isn't. The hysteresis attribute is an absolute temperature.
The value written into the attribute is expected to be in the range
[THERM - 15, THERM] (in degrees C). The value written into the register
is then in the range [15, 0]. I see nothing wrong with the current code.

> value. This causes it to always select 15C for hysteresis.  Change the
> first parameter to THERM - val to compare two absolute temperatures.
> The second error masks the wrong bits in the hysteresis register; indices
> 0 and 2 should zero bits [7:4] and preserve bits [3:0], and index 1 should
> zero bits [3:0] and preserve bits [7:4].

I'll have to verify that with the datasheet. Either case, one logical change
per patch, please.

Thanks,
Guenter

> 
> Fixes: 1c301fc5394f ("hwmon: Add a driver for the ADT7475 hardware monitoring chip")
> Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> ---
>  drivers/hwmon/adt7475.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 77222c35a38e..68233191798e 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -484,14 +484,14 @@ static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
>  		adt7475_read_hystersis(client);
>  
>  		temp = reg2temp(data, data->temp[THERM][sattr->index]);
> -		val = clamp_val(val, temp - 15000, temp);
> +		val = clamp_val(temp - val, temp - 15000, temp);
>  		val = (temp - val) / 1000;
>  
>  		if (sattr->index != 1) {
> -			data->temp[HYSTERSIS][sattr->index] &= 0xF0;
> +			data->temp[HYSTERSIS][sattr->index] &= 0x0F;
>  			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF) << 4;
>  		} else {
> -			data->temp[HYSTERSIS][sattr->index] &= 0x0F;
> +			data->temp[HYSTERSIS][sattr->index] &= 0xF0;
>  			data->temp[HYSTERSIS][sattr->index] |= (val & 0xF);
>  		}
>  
> -- 
> 2.39.2
> 
