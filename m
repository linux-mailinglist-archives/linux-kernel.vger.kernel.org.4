Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107E95BB86E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIQNTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIQNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:18:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD536DF1;
        Sat, 17 Sep 2022 06:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C39A61447;
        Sat, 17 Sep 2022 13:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC58C433C1;
        Sat, 17 Sep 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663420736;
        bh=L+a+LNVzO1yC2Lew2cGCBaAPIZCNQWZLIkzM9flIY74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V7xl4sE5NhQfph9XWi2672UE8IJQpInIlvFLTh+KPCTqourU8VFEQ+Jd6iaKERTPU
         wBSxpZ8BsjiAPHmJEDIKhErHRYsEpYJxJxyIa3LLJhA3al5BeHbSGBz3OawrzT0Moo
         pL3AYAX1R6k05P+bHTDldEzvAHxcJymlqninEyepL3R7V5efqKPUf3lNM/LboUrTid
         irGcWs8YFtZgvCJP38a+IlmqSYEsqSmFe2L/1lvlk3hHkL5zhkBMNShQUgR2oPLBE7
         IZlJ64RFskjVFe+T/vdJlDjg6CVNGnxB7PeMWgd9ESLl+tmS3yx9zKdzypTU88TpgY
         1BdFxnhjbJXsQ==
Date:   Sat, 17 Sep 2022 14:18:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/9] iio: pressure: bmp280: reorder i2c device tables
 declarations
Message-ID: <20220917141859.1496a968@jic23-huawei>
In-Reply-To: <a3969b60e428b9bd29ea1ebc6dd69aa5bbe59da0.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
        <a3969b60e428b9bd29ea1ebc6dd69aa5bbe59da0.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 01:50:07 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Change device tables declarations to forward order like in SPI codepath.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Applied
> ---
>  drivers/iio/pressure/bmp280-i2c.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index bf4a7a617537..5b51ebfc6f2b 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -37,18 +37,18 @@ static int bmp280_i2c_probe(struct i2c_client *client,
>  }
>  
>  static const struct of_device_id bmp280_of_i2c_match[] = {
> -	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
> -	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
> -	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
>  	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
> +	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
> +	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
> +	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
>  
>  static const struct i2c_device_id bmp280_i2c_id[] = {
> -	{"bmp280", BMP280_CHIP_ID },
> -	{"bmp180", BMP180_CHIP_ID },
>  	{"bmp085", BMP180_CHIP_ID },
> +	{"bmp180", BMP180_CHIP_ID },
> +	{"bmp280", BMP280_CHIP_ID },
>  	{"bme280", BME280_CHIP_ID },
>  	{ },
>  };

