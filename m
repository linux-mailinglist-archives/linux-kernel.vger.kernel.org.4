Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B9063BBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiK2Ilo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiK2IlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:41:21 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A99AF16
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:41:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id r66-20020a1c4445000000b003d05a3775d4so4265087wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b8jAZNW2iOrLRrd89DhxXzx+Yq1CmREwG3nJKgbZlYM=;
        b=HgRHogOxcbeptq7RdOpeE8mcOwl1JyZNgPIEwFYHa49N2cJBwZIixiVeHMT3EPsacS
         00qm3C6yORFC3DBXXt9z2ncLXW0RJR0QPQjYp0WdlQKDr9Aw59PCAXHPKFSh8IPzmXgs
         yI2qU/PgLouCiwpBMTTUz2jvWaueGSPp2rRFb+LSiG9tPW5mKcMQEYHLpkwbBMlnaieZ
         TXc1+eBaRrceP3qTGERv4lbbMHtHVNINkN96Xr+JNgIg9jMXPMlZbyJdgGPOwmNiUyGd
         edtXf1ZHIaWKLWXTs68cklQv3HWJiR6oyO9pxSwuT3H1CYecI1Xee97h3gEwzqhULQSx
         Y48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8jAZNW2iOrLRrd89DhxXzx+Yq1CmREwG3nJKgbZlYM=;
        b=b6mKccPbZuuI2FyvlMRlQyEmkoQtaKhgCC6QCZgpoHkK7j0sqGNCM6RZhHJOEvfZtP
         rvoekwiTt2R7EAwk1eSHIesiqoeQ3OVfcBSEYLlhyI8jblUQot5LSQid1cjjqKihxvU4
         2r2zwEfti8plWeu0bSxExPsbA1cBSx7E8NzGrMI0GfuhR4VJ3R34YFi18h43/Q1g4vt5
         nxx5l9zn8Ov3jlLAk2JlCGS0XTX8ZCgj9HmJtzgpMfR5yqpxIJBeUo94EtQnu7pcNqS4
         n1y8LuCsm7eo739juyrP9viZq/hgn2V8ezIFB6xUOyierbrm0FR61aAC20lCXGlqbFPg
         f8MQ==
X-Gm-Message-State: ANoB5plSoGzaWYGVTdv1va6JUrIeysUB0vrQA4Ma4Da1yO4mHAUBuhX5
        I6N666DEPwSr7ZrTdsykwlLEEA==
X-Google-Smtp-Source: AA0mqf7YTNMTlGF7UPjXTQ7a9Xy432X20Jg5O2T11AKVzsSOE9h3KXWpsSiHCxHF5JkDuBZpndPs4w==
X-Received: by 2002:a05:600c:3d1b:b0:3cf:670e:63cc with SMTP id bh27-20020a05600c3d1b00b003cf670e63ccmr45587752wmb.150.1669711270809;
        Tue, 29 Nov 2022 00:41:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2? ([2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d5645000000b00225307f43fbsm13038696wrw.44.2022.11.29.00.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:41:10 -0800 (PST)
Message-ID: <81e5bd05-b081-8072-b09d-30e32834163e@linaro.org>
Date:   Tue, 29 Nov 2022 09:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] drm/tiny: ili9486: Do not assume 8-bit only SPI
 controllers
Content-Language: en-US
To:     Carlo Caione <ccaione@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
 <20221116-s905x_spi_ili9486-v2-2-084c6e3cd930@baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <20221116-s905x_spi_ili9486-v2-2-084c6e3cd930@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 10:42, Carlo Caione wrote:
> The pixel data for the ILI9486 is always 16-bits wide and it must be
> sent over the SPI bus. When the controller is only able to deal with
> 8-bit transfers, this 16-bits data needs to be swapped before the
> sending to account for the big endian bus, this is on the contrary not
> needed when the SPI controller already supports 16-bits transfers.
> 
> The decision about swapping the pixel data or not is taken in the MIPI
> DBI code by probing the controller capabilities: if the controller only
> suppors 8-bit transfers the data is swapped, otherwise it is not.
> 
> This swapping/non-swapping is relying on the assumption that when the
> controller does support 16-bit transactions then the data is sent
> unswapped in 16-bits-per-word over SPI.
> 
> The problem with the ILI9486 driver is that it is forcing 8-bit
> transactions also for controllers supporting 16-bits, violating the
> assumption and corrupting the pixel data.
> 
> Align the driver to what is done in the MIPI DBI code by adjusting the
> tranfer size to the maximum allowed by the SPI controller.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   drivers/gpu/drm/tiny/ili9486.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
> index bd37dfe8dd05..4d80a413338f 100644
> --- a/drivers/gpu/drm/tiny/ili9486.c
> +++ b/drivers/gpu/drm/tiny/ili9486.c
> @@ -43,6 +43,7 @@ static int waveshare_command(struct mipi_dbi *mipi, u8 *cmd, u8 *par,
>   			     size_t num)
>   {
>   	struct spi_device *spi = mipi->spi;
> +	unsigned int bpw = 8;
>   	void *data = par;
>   	u32 speed_hz;
>   	int i, ret;
> @@ -56,8 +57,6 @@ static int waveshare_command(struct mipi_dbi *mipi, u8 *cmd, u8 *par,
>   	 * The displays are Raspberry Pi HATs and connected to the 8-bit only
>   	 * SPI controller, so 16-bit command and parameters need byte swapping
>   	 * before being transferred as 8-bit on the big endian SPI bus.
> -	 * Pixel data bytes have already been swapped before this function is
> -	 * called.
>   	 */
>   	buf[0] = cpu_to_be16(*cmd);
>   	gpiod_set_value_cansleep(mipi->dc, 0);
> @@ -71,12 +70,18 @@ static int waveshare_command(struct mipi_dbi *mipi, u8 *cmd, u8 *par,
>   		for (i = 0; i < num; i++)
>   			buf[i] = cpu_to_be16(par[i]);
>   		num *= 2;
> -		speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
>   		data = buf;
>   	}
>   
> +	/*
> +	 * Check whether pixel data bytes needs to be swapped or not
> +	 */
> +	if (*cmd == MIPI_DCS_WRITE_MEMORY_START && !mipi->swap_bytes)
> +		bpw = 16;
> +
>   	gpiod_set_value_cansleep(mipi->dc, 1);
> -	ret = mipi_dbi_spi_transfer(spi, speed_hz, 8, data, num);
> +	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
> +	ret = mipi_dbi_spi_transfer(spi, speed_hz, bpw, data, num);
>    free:
>   	kfree(buf);
>   
> Looks fine, but should somehow be tested on an RPi first
to check if the 8bit fallback still works.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
