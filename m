Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6565D6DA102
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbjDFTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjDFTU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:20:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC2D3A8E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:20:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso2340791a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680808855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uys/L8O7xZiA+IlXK1BRZhgWN+PypYAepeVXE0xpUtQ=;
        b=szCtW94vPkczBdTnbR80adOAclPwalJ7BkvQYs3FUajLczbNu1z67JLTUQGR6/2aQn
         J1nITuCLHCt1OQrHRUUjM6nBcb1htMQ8E0zsdGY61jwWkj7Q2P1E2itcwH+95iZyadDV
         Gqdy+BdycFICJTw24tVxXSkUPwH0gpVW7qC4vWp/wA1R26EofpsIB5uF0Pd+WU8Jppe/
         g1BkcWD2bqHxk1HMjgly0N+1xZgn6xPLgMLNZNLTIY0s0q5AizMhkwRTyDA4fimMvSD7
         pVKgqjz83wkM1Owum969UhhUg4FYbDCzQej6Azc17wvOMnbPZJpmjpa3L0YSYPfbZBup
         jDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680808855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uys/L8O7xZiA+IlXK1BRZhgWN+PypYAepeVXE0xpUtQ=;
        b=DTvtQV+8VJcGsDHgiyN53lGrjt+86cxJCOnKx6g3JmEU/xsJBB/6D15CCKh7Nt9HZ/
         PyQ4PKhhnDQ9Ttk5M+hEAoY7ByycXx9/zcWwCUcxk0v0jnyH8AvCVZ5V36J0xysoCHo9
         4TMj86r0+tdPzpzhfU3eQw7PWpoAS6xSbVK0VbukTx7F3IRFA4zyVGkpcnF3HOC1oJhY
         fPf02nXbnaC/kyEWCY0TJ0uJO8JVTlreAS2bVDwQ+QnRd0/E9QU3bKDQ3svGIF/NT7jx
         TZbj+D7ZStbTLMKxC5NOGlS/Wa0cq3KV8JWcbMjfA/he7bhxDyn8xJ1eLeG5tvLuoVDA
         HNUg==
X-Gm-Message-State: AAQBX9f0UDJdSnZH0qsi8QTH+A9LN6rgQh77w5N+YYBljWamNisYuAYn
        yOKiy80KBLAL10Fpoh8fYS+UPw==
X-Google-Smtp-Source: AKy350aTrwKXuR27E5tLtNwoNoUbzzOwtElN/iIeID0/1vaD7VdGluqPSroZH3isFfJqALCgWgMs8Q==
X-Received: by 2002:aa7:cd5b:0:b0:4fc:d331:515 with SMTP id v27-20020aa7cd5b000000b004fcd3310515mr5835266edw.5.1680808855209;
        Thu, 06 Apr 2023 12:20:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id t6-20020a05640203c600b004fb30fc1dabsm1041933edw.96.2023.04.06.12.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:20:54 -0700 (PDT)
Message-ID: <d1feb2c0-98b1-af38-e9c6-432a72b352f1@linaro.org>
Date:   Thu, 6 Apr 2023 21:20:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] hwmon: max31827: add MAX31827 driver
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        Vincent Tremblay <vincent@vtremblay.dev>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Greg.Schwendimann@infineon.com" <Greg.Schwendimann@infineon.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406164331.6557-1-daniel.matyas@analog.com>
 <20230406164331.6557-2-daniel.matyas@analog.com>
 <20230406164331.6557-3-daniel.matyas@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406164331.6557-3-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 18:43, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 

(...)

> +
> +static const struct hwmon_ops max31827_hwmon_ops = {
> +	.is_visible = max31827_is_visible,
> +	.read = max31827_read,
> +	.write = max31827_write,
> +};
> +
> +static const struct hwmon_chip_info max31827_chip_info = {
> +	.ops = &max31827_hwmon_ops,
> +	.info = max31827_info,
> +};
> +
> +static int max31827_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct max31827_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
> +		return -EOPNOTSUPP;
> +
> +	st = devm_kzalloc(dev, sizeof(struct max31827_state), GFP_KERNEL);

sizeof(*...)

> +	if (!st)
> +		return -ENOMEM;
> +


Best regards,
Krzysztof

