Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D280749610
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjGFHJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjGFHJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:09:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E3E1732
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:09:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so374015e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688627361; x=1691219361;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e+3UxZtzHVgpN6AySbetYQrNrrAcbanGA/ITUARrZTA=;
        b=joyw8U0qByKFtglxOZnIe4fsCxJKWScziH7T+kOstAb0UKThqasBr5CdPEY5B1i2wr
         m8bJPFWK+EcfKKZXrttWGePda170qVCwdehzgiI/9cO1iau6sLuw+OokUf36N4AAc/ix
         1emyeXwHLEDabZWynbCxNkxcohY1NXf7bY54Omq0JDF0RN0bNtAetf0qaSaBsiQIa5h2
         G+GD6+cGPDTzmC3Lh/QGA7s/eYZ2VvVtoVZrIRx2Tv+rP1mJn1A3GX4qpIWc0M3y0tu1
         pJq+4yNyTAfSYFXOGnL4z1ScNb6DNI7ypt70EIWSkceScCrzjY1pmvUL8bhvIg7GkleD
         8ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688627361; x=1691219361;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+3UxZtzHVgpN6AySbetYQrNrrAcbanGA/ITUARrZTA=;
        b=jVOmDTrcXiRoPu8GpDLfEZAndZSPRvFGOYqEjbAFI+MeDCM9J+FMON9LDNZzI7+Wwu
         bcPenMF5t3V8fgHJfDDBRSo6VKzMNXEQcaYvNXBC9TCvA0YQNURMK29c/7OPxUBWIseS
         cz9LOoRr9eC0Rni4dhQ15j/Y+ACKAQnsvD0W2XkhuUOP40LQqfe5yncCK8WydjEnvhG3
         viPOM4VgexmmKZCcGhPGbXdEl4a6kSQFHON6Sxx0MpWxPtWpIsfuafz0yulisBY1+3us
         nqst1DHN0FSA9EjLUuSefZCSXsPVITpENdyiRyutlMm8oQTFr0jNaZKxTfu/c0TAXzCD
         IcSg==
X-Gm-Message-State: ABy/qLbVJl7+J8pvxT8oSCbl88BFa95/DymDoUclG7hla3J/vANP4iVS
        aXwE8LUnFCwgIQ/Olp+N7vZ+nA==
X-Google-Smtp-Source: APBJJlFON4bLuwxCrqhdPT27/apuffS9FmUkfshZ1Q98OKa5xztSFTpSlUmvsazqmjuaOs8p4DyYvA==
X-Received: by 2002:a05:6512:1ca:b0:4f5:1418:e230 with SMTP id f10-20020a05651201ca00b004f51418e230mr734913lfp.52.1688627361586;
        Thu, 06 Jul 2023 00:09:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:15d1:2748:ead4:bdff? ([2a01:e0a:982:cbb0:15d1:2748:ead4:bdff])
        by smtp.gmail.com with ESMTPSA id v19-20020a1cf713000000b003fbb00599e4sm4227903wmh.2.2023.07.06.00.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 00:09:21 -0700 (PDT)
Message-ID: <80b3c16b-fbf0-4c52-af1f-b9965cdeab5a@linaro.org>
Date:   Thu, 6 Jul 2023 09:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/7] tty: serial: meson: add independent uart_data for
 A1 SoC family
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jbrunet@baylibre.com, jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     kelvin.zhang@amlogic.com, xianwei.zhao@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230705181833.16137-1-ddrokosov@sberdevices.ru>
 <20230705181833.16137-6-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230705181833.16137-6-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 20:18, Dmitry Rokosov wrote:
> Implement separate uart_data to ensure proper devname value for the A1
> SoC family. Use 'ttyS' devname, as required by the A1 architecture,
> instead of the legacy gx architecture.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   drivers/tty/serial/meson_uart.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 6a63184b8091..84cf10b0ca5c 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -818,6 +818,11 @@ static struct meson_uart_data meson_g12a_uart_data = {
>   	.has_xtal_div2 = true,
>   };
>   
> +static struct meson_uart_data meson_a1_uart_data = {
> +	.uart_driver = &MESON_UART_DRIVER(ttyS),
> +	.has_xtal_div2 = false,
> +};
> +
>   static struct meson_uart_data meson_s4_uart_data = {
>   	.uart_driver = &MESON_UART_DRIVER(ttyS),
>   	.has_xtal_div2 = true,
> @@ -836,6 +841,10 @@ static const struct of_device_id meson_uart_dt_match[] = {
>   		.compatible = "amlogic,meson-s4-uart",
>   		.data = (void *)&meson_s4_uart_data,
>   	},
> +	{
> +		.compatible = "amlogic,meson-a1-uart",
> +		.data = (void *)&meson_a1_uart_data,
> +	},
>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);

With the real struct name:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
