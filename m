Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700BE63BBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiK2Iji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiK2IjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:39:07 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579766441
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:38:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id o30so10299417wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XgU2Me36pWpv5WapeJ4LPJ3zFhHMt8NlKreZ17SiFYI=;
        b=eSdL13nPAAE9KfbRzj2fCIepGM6/yyMJRSpSbtV+qTcW929EIa4OABn8vS5yE4KwVN
         dhRF4IKu30cR5LMLlmnwFaoBLqN6SL02TGXbzQ2W5eSrWzlbUg6YlFcsxI9lNfHS/059
         DZ0ZaUVAH7k73aSGu7vA0WjbHCO04rV1d4G6qVx6TAu1tcGB1lDkzpb8Ie3s2i5OUilh
         H+NL5OQ7fZAfnVi55MvfEYE8R+DjKIxT//YNB2CU6jdZ8SAnvQ2mY4+OlXalRpVC3gKm
         xyOx2am5t9bgULDwET1sl91wGzsVBZ4U2AUWsm8RyNtTa+xfK1h0uQa6JROUKj9i6fjJ
         jhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XgU2Me36pWpv5WapeJ4LPJ3zFhHMt8NlKreZ17SiFYI=;
        b=KjxIExd5yuUz7k0NJF09JqhzyZd+hqociE9YhfoT8PUcSEDSnZKFPwKi6qEGaEdwS6
         lPI8JIuyvtRctyhiEkfBMOWBiRqcQ2mbwTNv0FchNmTZ4B9yT5ezVd6gTuq9LxrnZt+v
         m4hw9wZPS0FkSVGHLb0vHjVmIJnC1GRY1PMjzzeBxETQzXst1pWkpGWxFDLI1ciOipov
         A4ZbP9hgvPKiHz9lGMR4NqjnJ869HAUeI2GlVoL9h7EVCkDjPN5glU+OzTxf8c+jzQow
         J6VQVVbb1dGQXc9nI/UjPyfOmpqJ3DJ3AD8DQZS36TU5nI7ErDtLnXQOfFataLYzY+ZC
         qjhg==
X-Gm-Message-State: ANoB5pk/SF2bPbCVipr1IsRRQSWX2e0+0ihFYwICv9QGfTPnXcdh3Ajy
        p4WH8Sg+3PvmqOSgKBDmXDg7/w==
X-Google-Smtp-Source: AA0mqf6OAhXAHg9j5+BXVKjL+Xc8gtMngAEKoiv4eF9a4BzThu69gyqxyX8YzEQPD1iPsmDy+DbTAg==
X-Received: by 2002:a7b:c00a:0:b0:3cf:e8f0:ad11 with SMTP id c10-20020a7bc00a000000b003cfe8f0ad11mr44668145wmb.65.1669711120927;
        Tue, 29 Nov 2022 00:38:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2? ([2a01:e0a:982:cbb0:2f85:a28c:5df7:9cd2])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d4587000000b0022ae0965a8asm12835842wrq.24.2022.11.29.00.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:38:40 -0800 (PST)
Message-ID: <fbe945cb-036f-b405-901f-0d625e8bfcbd@linaro.org>
Date:   Tue, 29 Nov 2022 09:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] drm/tiny: rpi-lcd-35: Enable driver module
 autoloading
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
 <20221116-s905x_spi_ili9486-v2-1-084c6e3cd930@baylibre.com>
Organization: Linaro Developer Services
In-Reply-To: <20221116-s905x_spi_ili9486-v2-1-084c6e3cd930@baylibre.com>
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
> SPI devices use the spi_device_id for module autoloading even on
> systems using device tree.
> 
> Add the spi_device_id entry to enable autoloading for the 3.5inch RPi
> Display (rpi-lcd-35).
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   drivers/gpu/drm/tiny/ili9486.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
> index 1bb847466b10..bd37dfe8dd05 100644
> --- a/drivers/gpu/drm/tiny/ili9486.c
> +++ b/drivers/gpu/drm/tiny/ili9486.c
> @@ -183,6 +183,7 @@ MODULE_DEVICE_TABLE(of, ili9486_of_match);
>   
>   static const struct spi_device_id ili9486_id[] = {
>   	{ "ili9486", 0 },
> +	{ "rpi-lcd-35", 0 },

It should also contain "piscreen" then.

Anyway:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, ili9486_id);
> 

