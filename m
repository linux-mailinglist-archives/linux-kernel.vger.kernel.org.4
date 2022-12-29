Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E85658DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiL2O35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2O3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:29:55 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC5BE0A8;
        Thu, 29 Dec 2022 06:29:54 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso11548770otn.2;
        Thu, 29 Dec 2022 06:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PL55QmUDSJz2PWahGHhR8h5Ae0gnbaDbaf5jPT4pcyU=;
        b=azEE1JRCCHq8IORGhrfEEC/1Xq1x83HOkuRGSo9SBlIATiEYLiwcDEs3z+pp7WzqSQ
         H5vP7YXI60i8KK3L7R7B/z+kUPMwyC6D/ED8CP/bJHEkxBebT9na9gNvd7UeUZ2M4E6T
         eeVgWA3FeQVV1+7o4at8+KeoQPvgewkLL+GHz21InKxcBPZobNHDR8mUAsgrTZM3PKrW
         C5xXy73fTuxUt05FDRljLszZvk64XdeihvQyC2q8EFos1UK6lv2Tqo7FuK2OqfxX3LpQ
         ThgFnrleHhdHc7lJ3wjwXascytaxRzt35hf/lCpEk7Oz46n2AbD+L2U/3K6MufBZZ9ee
         DBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PL55QmUDSJz2PWahGHhR8h5Ae0gnbaDbaf5jPT4pcyU=;
        b=qdc6q7Cmr4FU6TRy95E2TONvXGX9indRyU6Z+VlOjokQxNdJ+I3YY8L/O79BRBNSOh
         3ZdvTVkBwqB9XSvl2ZA0cyI7gubWsX6/H4b3WVTtMj5AHlSVn3mKs6fcy5IIZZc5sXVK
         5FSDsWnsvhksWP+O3OaesGJJXuScLlAqmgkEhyVt/QQgBETvmvFWYB8j/lJ64pezK37Q
         xQ/kjyqQuAjKTNPwTQZlfoPQKA6frsDZSi4jwcwVJl2f8YDFQRWRr1ba2AGeM0ggxT3C
         kv7XX37O3o/VhEgbCQtI7XCwjW9dkwGdM1bK4nm371jVaxIhuQLGfntUxUCPIrVlVP0z
         tWUw==
X-Gm-Message-State: AFqh2koaq9SW6dPp2IUfojGLPWaEO3SCOV8vziX0hs+BAMjFJY7uGLbJ
        oEnqUMxzqVE6JRWMu2n3HQpWt9Grdiw=
X-Google-Smtp-Source: AMrXdXsk9DBDdnhj/78enjT18rDcLlNndy7I405c01Hs5lTzgcwPATuew7PY4J+aQtpxgVBuH6bKoA==
X-Received: by 2002:a9d:7cca:0:b0:677:3d79:e60a with SMTP id r10-20020a9d7cca000000b006773d79e60amr13315713otn.31.1672324193920;
        Thu, 29 Dec 2022 06:29:53 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c1-20020a056830000100b006708d2cd8bcsm9077840otp.65.2022.12.29.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:29:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:29:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: (ftsteutates) Use
 devm_watchdog_register_device()
Message-ID: <20221229142952.GA21098@roeck-us.net>
References: <20221224041855.83981-1-W_Armin@gmx.de>
 <20221224041855.83981-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224041855.83981-4-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 05:18:55AM +0100, Armin Wolf wrote:
> Use devm_watchdog_register_device() to let devres take care
> of unregistering the watchdog at device removal. Remove the
> now pointless fts_remove() function.
> 
> Tested on a Fujitsu DS3401-B1.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ftsteutates.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
> index 66ff8d69a0de..d8878b8d16bc 100644
> --- a/drivers/hwmon/ftsteutates.c
> +++ b/drivers/hwmon/ftsteutates.c
> @@ -333,7 +333,7 @@ static int fts_watchdog_init(struct fts_data *data)
>  	/* max timeout 255 minutes. */
>  	data->wdd.max_hw_heartbeat_ms = 0xFF * 60 * MSEC_PER_SEC;
> 
> -	return watchdog_register_device(&data->wdd);
> +	return devm_watchdog_register_device(&data->client->dev, &data->wdd);
>  }
> 
>  static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_types type, u32 attr,
> @@ -611,13 +611,6 @@ static int fts_detect(struct i2c_client *client,
>  	return 0;
>  }
> 
> -static void fts_remove(struct i2c_client *client)
> -{
> -	struct fts_data *data = dev_get_drvdata(&client->dev);
> -
> -	watchdog_unregister_device(&data->wdd);
> -}
> -
>  static int fts_probe(struct i2c_client *client)
>  {
>  	u8 revision;
> @@ -684,7 +677,6 @@ static struct i2c_driver fts_driver = {
>  	},
>  	.id_table = fts_id,
>  	.probe_new = fts_probe,
> -	.remove = fts_remove,
>  	.detect = fts_detect,
>  	.address_list = normal_i2c,
>  };
