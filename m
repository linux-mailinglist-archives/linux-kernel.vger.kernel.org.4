Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07166EDC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbjDYHIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjDYHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:08:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D817EC0;
        Tue, 25 Apr 2023 00:08:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a7ac8a2c8bso50961201fa.3;
        Tue, 25 Apr 2023 00:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682406481; x=1684998481;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk59Vw8Pct6R1MB4/G1PaaIn6BGP5vILmLOMwIknPHE=;
        b=MW7qTQDTxxE8lGumnDlA5OBwrHDlf/ACcge7rLR5J/a6SJELObTitmYqcl/OlZ5W+h
         roK2KqYi3MXnbAifAkbdbDckTzBkUydnh15ejFI/tiVuvoM5M+WouSkbCLbV4OtiAndq
         lkZ2YI/0dbSQ6mhOJOdr2uYF3axYbyzZSnqjWem4++BR8J1MzWQIyhR5i7WzDOlQ6y63
         ml6STYU0ZvXXhMPEHMHxIcjo4wDPmk28Hgv0NlI8moyj30dZcicJqx+tIiju7FWit21y
         TbFcCtsSpIIq0cMjIdZXJ0dtElQ45za8n7HgQaEQ7UT7UIUB1PGy2zMc9WAcUJee21ql
         NTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682406481; x=1684998481;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wk59Vw8Pct6R1MB4/G1PaaIn6BGP5vILmLOMwIknPHE=;
        b=GQKh5frt7sO43s0xv9pO9nXYyNlvMk8L4QujDi+57pn4WjSmYWRPnXnPJPdnDs/3CO
         25TqW037xcMry0olSjgOW+urnQOUNvcmNUwrLrwUBgfT1jIDMbLgnglKH0ej8PbukZEo
         X8/Nr2Flu5+LJLtPNzXmgSHX0FcXAg5NLyEAbHLq9BM7gDnTkc3s8sO0htMvoPPQEQZU
         7GpSnqFkFoGzqrNeBrDX/O/T095gFBZz1YAXmMJCqupjZUX8Y+1oNEWCVQAaAEorZ11L
         Z4huj//XYOEQF4nAiC3Xtf+XcR5g9n/EHh9CLjl3Wm/N8kpb/nBYuSJusS9KBffAnDCg
         DAcQ==
X-Gm-Message-State: AAQBX9fKRj+Ldl+5HbvegMsf8w58BpGYcBVzlZqkzD6l8bznOl/f+AXA
        k+GU4onKabQNDmqvgt05h80=
X-Google-Smtp-Source: AKy350ZacIKDb8y2Kx8daqWqWNV7bLe1ePHOE5caMsVfLg6HeN/PHiMByxUoeGQ65JLQ3Q5yOqXH1Q==
X-Received: by 2002:a2e:b17c:0:b0:2a8:bca1:bfa6 with SMTP id a28-20020a2eb17c000000b002a8bca1bfa6mr3163748ljm.24.1682406481052;
        Tue, 25 Apr 2023 00:08:01 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e7412000000b002a8bb20e534sm1915957ljc.108.2023.04.25.00.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 00:07:55 -0700 (PDT)
Message-ID: <b0f894fa-a216-aead-a5a4-1844292acad9@gmail.com>
Date:   Tue, 25 Apr 2023 10:07:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <fc12d40f7c2132c1a9a1b5f83b79231dc8ce539f.1682373451.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
In-Reply-To: <fc12d40f7c2132c1a9a1b5f83b79231dc8ce539f.1682373451.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 01:22, Mehdi Djait wrote:
> Since Kionix accelerometers use various numbers of bits to report data, a
> device-specific function is required.
> Implement the function as a callback in the device-specific chip_info structure
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---
> v3:
> - fixed the warning of the kernel test robot in kx132_get_fifo_bytes

Do you mean kx022a_get_fifo_bytes? (I guess this won't go to commit logs 
so no need to respin for this).

> 	(invalid assignment: &=, left side has type restricted __le16
> 	right side has type unsigned short)
> 
> v2:
> - mentioned the kx132-1211 in the Kconfig
> - added a kx132-specific get_fifo_bytes function
> - changed the device name from "kx132" to "kx132-1211
> 
>   drivers/iio/accel/kionix-kx022a.c | 30 ++++++++++++++++++++----------
>   drivers/iio/accel/kionix-kx022a.h |  4 ++++
>   2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 66da3c8c3fd0..4a31d17c1f22 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -595,11 +595,28 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
>   	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
>   }
>   
> +static int kx022a_get_fifo_bytes(struct kx022a_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, fifo_bytes;
> +
> +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> +	if (ret) {
> +		dev_err(dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	/* Let's not overflow if we for some reason get bogus value from i2c */

This comment would need fixing. I guess this is my bad - this comment 
goes back to first internal draft datasheets where the fifo lenght was 
said to be shorter than 255 bytes...

> +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> +		fifo_bytes = KX022A_FIFO_MAX_BYTES;

...Currently the fifo size (KX022A_FIFO_MAX_BYTES) is 258 bytes and 
KX022A_FIFO_FULL_VALUE is 255 (8-bit register) - meaning that no matter 
what noise there is in the I2C line, we won't overflow the buffer. This 
check is here to handle the 'quirk' where full 258 bytes of FIFO data is 
advertised by register max value (255).

It wouldn't be fair to require fixing this in context of this change - 
but I guess I can ask you to please update the comment if you happen to 
re-work this file ;)

> +
> +	return fifo_bytes;
> +}
> +

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

