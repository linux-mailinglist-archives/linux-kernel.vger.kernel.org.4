Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C372E05C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbjFMLG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbjFMLGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:06:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC58010F9;
        Tue, 13 Jun 2023 04:06:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f5f728c4aaso6275041e87.0;
        Tue, 13 Jun 2023 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686654381; x=1689246381;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPOGwysNuczpOUEUONHWQLo/3obqtMGi8KL8tevE4Iw=;
        b=nQf0NnrBh/5ZtSMnJG20jTUoYcMqHLI6LI1jq4oeCp9HiSNO7NzPsKDUCcWX0IQrkb
         I5J9ne8mK9mgXOkvWbdfuz3/Xw8SY6crlXPO/WAbiY7hByCvchOmK1tM3fQXalaYyqe7
         hEHlxrzOZofuXvxgRAqoMhv9HasYRPvjAK61OZ6zgYcuU3lALvGM1VYqzkLWgFBiJ7N0
         nOLU2UcpCQzWCFlnnpRA0UeqbgZN4OFpM2VUhye6amPAs88sQaNf9N8yDgiK4/aZNmxx
         0v6X1GwTDDp+Q5Hri7n9LmnjJAIab531DwX6gvykt3NRMZsTclO8FXQSO530sW5mAOKr
         UZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686654381; x=1689246381;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPOGwysNuczpOUEUONHWQLo/3obqtMGi8KL8tevE4Iw=;
        b=Shx/Yd3B+itS6O81+Sc/AcVgrFuIbtq6YvR3/H23EEDAhwwKL1gGyQpiL9/EX8dZhC
         sG7cC96Hp7r7qUZ02k916uMe25XBJK4zMfYXWS0jYEleTgvgVzZPu+UIgrXg9hdSDpuE
         QGKYNT7bK7EZpUnH2MmyeEFGhgtFo/SWR8qDKppI7Y6X9LFUUaERBAyX0z5q594hS5pG
         3ebdAY8GHVvMA5/chWGTxcLfiLhZ8yb0nW1Qe3ahY6UbgT/svDcWkcMqvBda0delTpHY
         /AJ9lbyNxwfn4RxUJlxCiXB5V0vorVZ1sNDZIPiEzJd8wSwyDOuPHEI+9nNMhbglUBf4
         0HhQ==
X-Gm-Message-State: AC+VfDzu9v5F+TL6qvyvu+Ct4lEM+b2Po5fTMSM+W4Rt/SybD5+VL6ye
        1zY4YfPVefSsAwCxeZKMFLw=
X-Google-Smtp-Source: ACHHUZ5zTvUSCPFnMgDhC/dZNpqqZqzRSRHn85J4RuNWVabxu2uXhGV7b9PzIEyRlZWIXkzTbMErDw==
X-Received: by 2002:a05:6512:3a8a:b0:4f3:7889:7603 with SMTP id q10-20020a0565123a8a00b004f378897603mr4631131lfu.24.1686654380980;
        Tue, 13 Jun 2023 04:06:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004f42718cbb1sm1732715lfl.292.2023.06.13.04.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:06:20 -0700 (PDT)
Message-ID: <69d7d2ab-4bfb-dac3-c6c9-88ab8e481c60@gmail.com>
Date:   Tue, 13 Jun 2023 14:06:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
 <5e827d018b5d0caf2b5d157e2c24d78c20fe855f.1686651032.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 7/7] iio: accel: Add support for Kionix/ROHM KX132-1211
 accelerometer
In-Reply-To: <5e827d018b5d0caf2b5d157e2c24d78c20fe855f.1686651032.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Mehdi,

Just one thing still crossed to my mind...

On 6/13/23 13:22, Mehdi Djait wrote:
> Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
> ranges from ±2G to ±16G, digital output through I²C/SPI.
> Add support for basic accelerometer features such as reading acceleration
> via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.
> 
> Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> ---


> +static int kx132_get_fifo_bytes(struct kx022a_data *data)
> +{
> +	__le16 buf_status;
> +	int ret, fifo_bytes;
> +
> +	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
> +			       &buf_status, sizeof(buf_status));
> +	if (ret) {
> +		dev_err(data->dev, "Error reading buffer status\n");
> +		return ret;
> +	}
> +
> +	fifo_bytes = le16_to_cpu(buf_status);
> +	fifo_bytes &= data->chip_info->buf_smp_lvl_mask;

Does this mask guarantee the fifo_bytes can't be bigger than the 
allocated buffer no matter what is read from I2C?

I am asking this because it's not uncommon to see some noise in I2C, or 
read 0xff 0xff, ... if IC is for example resetting. Hence, I would sleep 
a tad better if I knew the fifo_bytes read from IC is not 100% trusted - 
but is verified against known maximum number of samples.

This does not matter with the KX022A because the size of max number of 
samples exceeds the value indicated by 0xff (the 8bit SMP_LVL register).

Please correct me if I am wrong but it seems to me we use 10bits of data 
from smp_lvl register on KX132. Hence, the maximum value if all bits are 
set is 1023. This equals to 1023/6bytes samples - which is roughly 170. 
I think the FIFO size was defined to be maximum of 86 samples on KX132 - 
which means that if we have some bogus value from I2C, we may overwrite 
allocated buffer. Hence we might want to ensure the fifo_bytes is never 
bigger than the fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES - no matter 
what we read from I2C.

> +
> +	return fifo_bytes;
> +}
> +

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

