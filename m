Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC7631D87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKUJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiKUJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:56:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8AA93
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:56:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id t4so8053885wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KV4ztLMcqo35iUBenDly0e7oE30KFyPrfUjUB/4nml8=;
        b=qGAIRSJg/brYeUvsyEhgzjSgthv9J4NlAZTdDGZE3ltPHyHTUBKuufvD9IOgqR7gED
         XZDbxN9gEVYJ5ESX05/5hpWG3VP1EWjablmqViOnF5Figgexbs5ZmhupJgMaRN593K+K
         FTsMWZVUirtfeHBKEwMOV3ruMEPxahUfSWu9eQyunwiv6Y2AyU9Tbrxrg5RmQS+zpFJ2
         ALMz8auoeKfkKAM9nxWsrc4Iaq16l+SaVqJubpahEhNmfg39rRiSbo64PR7jKecJrUhW
         P53+xfQ7CA7bSbFPkxvMGBUU/ZRM2SczqIhhN+L/dtyISAc3lI+WaWXBYiKLRAucFnbh
         Gcjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV4ztLMcqo35iUBenDly0e7oE30KFyPrfUjUB/4nml8=;
        b=2XYhsNU57c01b8A9zQoOrrVKw+Ukng8S7ObmsPR9SUcYwV6+ipJ8X2gxBfE5/o+LZe
         klT9Oivq/xHaW+EgJCtBobNOHar5ef1GSyW7iqoS/u4hPc5k+ap5X8trwRgWn0qQ4prl
         LsRvlxjb6J1xH92tYybYFOhhady769bFStY43QeZCL0ZnFCqDZyVxTwvXENgD5X7CuBv
         S+lAobFnZ2EBf9Q3U7nCObPtQl938B/EGBnhx4J0nb8fJZv9cnnBsDNTetjTuOmz3t0H
         BP2cMpz6L2/WxKBvN7faXm6Ad6POI+uoDdg9HKm5S/rAzyTiYDNr8vDiL7mSJVqZA5CD
         K9xw==
X-Gm-Message-State: ANoB5pnJQ/AyGZ3c8Gf+d7Q1UY3tdeA17oYZI50/jIlXMoYPcviZl8aU
        zjQov9e9suoD30E/HtGYGnXqlA==
X-Google-Smtp-Source: AA0mqf78HuAM8JefAVkxBLHkJ/3gFtd683lcl+iP0S0BL7YXdl+m7GNJV+8qdD2ftDKZbVbK7HdSPA==
X-Received: by 2002:a05:600c:1e11:b0:3cf:8d52:a216 with SMTP id ay17-20020a05600c1e1100b003cf8d52a216mr3223702wmb.77.1669024611860;
        Mon, 21 Nov 2022 01:56:51 -0800 (PST)
Received: from [192.168.7.93] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4bc8000000b002238ea5750csm10734448wrt.72.2022.11.21.01.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:56:51 -0800 (PST)
Message-ID: <929e06bf-84b5-047f-91e9-29876b721cee@linaro.org>
Date:   Mon, 21 Nov 2022 10:56:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 431/606] mfd: khadas-mcu: Convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-432-uwe@kleine-koenig.org>
Organization: Linaro Developer Services
In-Reply-To: <20221118224540.619276-432-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 23:42, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/mfd/khadas-mcu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index f3d418810693..7338cc16f327 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -84,8 +84,7 @@ static struct mfd_cell khadas_mcu_cells[] = {
>   	{ .name = "khadas-mcu-user-mem", },
>   };
>   
> -static int khadas_mcu_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id)
> +static int khadas_mcu_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
>   	struct khadas_mcu *ddata;
> @@ -135,7 +134,7 @@ static struct i2c_driver khadas_mcu_driver = {
>   		.name = "khadas-mcu-core",
>   		.of_match_table = of_match_ptr(khadas_mcu_of_match),
>   	},
> -	.probe = khadas_mcu_probe,
> +	.probe_new = khadas_mcu_probe,
>   };
>   module_i2c_driver(khadas_mcu_driver);
>   


Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
