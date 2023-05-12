Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5D700BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbjELPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbjELPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:31:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E860420F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:30:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965e93f915aso1725373966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683905440; x=1686497440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xefq3pdZcO0e8EKQ19pFTto53xIKapXB7LmHWfDyQu4=;
        b=B3wUVVsls0aEbOr/VInqZjyshEeKanQt80a2sIm/FNUZlIQ9xR8OUTxnSZ5AgNhS5b
         I1FQ37AJtyHDuRoXWZ0SB023RcQmLubkjYBsu65owCYFhe96Wq9PrjYghN8cNEXUuEiE
         xkIWdGT0nleZobLTdcoI7WmSrwhlUo/Fgx5W0KCyYXVfmGQW/+IVUTY0i7KMdeu+DhFU
         rzZKJSa+so2eE5r2DUjWbcURlNbIA3/4VzDd5lzGfeY1Gj71F/Q4WYpaiYKPBnjm9npI
         QW9TVbJvsF7aO6viJuxShULipefO1sPsY7zumjiUcNwoufCtOSjgdnDOKM8VywTQLcNo
         ti7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905440; x=1686497440;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xefq3pdZcO0e8EKQ19pFTto53xIKapXB7LmHWfDyQu4=;
        b=YlNLEkitwnxf7huqQlzCytBbODrGEjOJV8mCTx7gTuGCFd4WCcdPph3k9ldR9vfCDM
         r8uAMNi2S5eRdL4SdMyZeFbBfCLRS6B5/TMBh+JPuNIuGYMvgo8ppoPToJ6nJSm0d4K6
         secTgpZAwXfOK1ShHPPgw7Ieqd4Dt2bPd2D3xeCGgMBfHdrocD0BehXpYso19QWRBBht
         vUn3NfEHAnhg/qPm/Tqt1/rBBS8/eu1DSwEVhJhKeaqJyHfKmMOekJ7OX5l7as15xQwP
         NbJzDJlkIjDs7dPG+2njreSC4XQx5AdJIxjP0vEaXpDWqBeq+YTmdqnA8SvQ1eFcksKf
         EZZw==
X-Gm-Message-State: AC+VfDwbn7XnA34DFltTifMakbyzvmA+YcjN3Ogn0WW9I8Pu8gURXFg4
        7+9iJdd3jbWvDufkGDUNBSF1xw==
X-Google-Smtp-Source: ACHHUZ7ox4zpEalJuln5LCdWNNjDzEjIcylFmSEdARdvEn9rrWst0L377ZSaS0MUvfliMWUYEJBOGg==
X-Received: by 2002:a17:907:d16:b0:966:391b:5b3e with SMTP id gn22-20020a1709070d1600b00966391b5b3emr20842436ejc.55.1683905439693;
        Fri, 12 May 2023 08:30:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id bn13-20020a170906c0cd00b0096599bf7029sm5588639ejb.145.2023.05.12.08.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:30:39 -0700 (PDT)
Message-ID: <9591999e-9d7f-2a4a-29df-d9c42dfa736b@linaro.org>
Date:   Fri, 12 May 2023 17:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10] pinctrl: cs42l43: Add support for the cs42l43
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122838.243002-9-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:28, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> Add a basic pinctrl driver which supports driver strength for the
> various pins, gpios, and pinmux for the 2 multi-function pins.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

...

> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(pdev->dev.parent);
> +	struct cs42l43_pin *priv;
> +	struct pinctrl_dev *pctldev;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	priv->regmap = cs42l43->regmap;
> +
> +	priv->shutters_locked = cs42l43->hw_lock;
> +
> +	priv->gpio_chip.request = gpiochip_generic_request;
> +	priv->gpio_chip.free = gpiochip_generic_free;
> +	priv->gpio_chip.direction_input = cs42l43_gpio_direction_in;
> +	priv->gpio_chip.direction_output = cs42l43_gpio_direction_out;
> +	priv->gpio_chip.get = cs42l43_gpio_get;
> +	priv->gpio_chip.set = cs42l43_gpio_set;
> +	priv->gpio_chip.label = dev_name(priv->dev);
> +	priv->gpio_chip.parent = priv->dev;
> +	priv->gpio_chip.can_sleep = true;
> +	priv->gpio_chip.base = -1;
> +	priv->gpio_chip.ngpio = CS42L43_NUM_GPIOS;
> +	priv->gpio_chip.fwnode = dev_fwnode(cs42l43->dev);
> +
> +	if (is_of_node(dev_fwnode(cs42l43->dev))) {
> +		device_set_node(priv->dev,
> +				fwnode_get_named_child_node(dev_fwnode(cs42l43->dev),
> +							    "pinctrl"));

That's something unusual. It seems you want to bind to a DT node because
you miss compatible in DT node?

> +	} else {
> +		device_set_node(priv->dev, dev_fwnode(cs42l43->dev));
> +	}
> +
> +	pm_runtime_enable(priv->dev);
> +	pm_runtime_idle(priv->dev);
> +

....

> +
> +static struct platform_driver cs42l43_pin_driver = {
> +	.driver = {
> +		.name	= "cs42l43-pinctrl",
> +	},
> +
> +	.probe		= cs42l43_pin_probe,
> +	.remove		= cs42l43_pin_remove,
> +};
> +module_platform_driver(cs42l43_pin_driver);
> +
> +MODULE_DESCRIPTION("CS42L43 Pinctrl Driver");
> +MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.cirrus.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:cs42l43-pinctrl");

Same comment, so I guess you have this pattern everywhere.

Best regards,
Krzysztof

