Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16945658FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiL2Rfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiL2Rff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:35:35 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62815825
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 09:35:34 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id AwoUpb98MIwEfAwoUpvG0O; Thu, 29 Dec 2022 18:35:32 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 29 Dec 2022 18:35:32 +0100
X-ME-IP: 86.243.100.34
Message-ID: <d0e98b2d-1c00-b7cc-d0b3-4477e27cf822@wanadoo.fr>
Date:   Thu, 29 Dec 2022 18:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new sensor
 BMP580
Content-Language: fr, en-US
To:     ang.iglesiasg@gmail.com
Cc:     ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        nikita.yoush@cogentembedded.com, paul@crapouillou.net,
        rafael.j.wysocki@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
 <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/12/2022 à 15:29, Angel Iglesias a écrit :
> Adds compatibility with the new sensor generation, the BMP580.
> 
> The measurement and initialization codepaths are adapted from
> the device datasheet and the repository from manufacturer at
> https://github.com/boschsensortec/BMP5-Sensor-API.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 

[...]

> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index efc31bc84708..27d2abc17d01 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h

[...]

> +#define BMP580_CHIP_ID			0x50
>   #define BMP380_CHIP_ID			0x50

Hi,

this is maybe correct (I've not been able to find the datasheet to check 
myself), but it looks odd to have the same ID for 2 different chips.

CJ

>   #define BMP180_CHIP_ID			0x55
>   #define BMP280_CHIP_ID			0x58

