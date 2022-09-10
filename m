Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB155B4795
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIJRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIJRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 13:03:47 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A92422EE;
        Sat, 10 Sep 2022 10:03:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f11so7930120lfa.6;
        Sat, 10 Sep 2022 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=9oYntKUPc2tJ6xDf6QhqxRubtQHDLcc9WLX4rHJmEcE=;
        b=a4ihY34sCuJXXsbfoYioaCGOr20RuYPRG0sWanE68KCycUZ87icyY/srGQKw9sfQ3K
         Zv3x/BqyA79rE+22u4EEz3Au6Pf4MthAn4lgOmdSg3H4j2vaZAOgk9edDCDt42CP4Dg7
         6OuA6CuWQUs/+X13huvRv19BLHLweMZN67XtpZ0g6GdaGIruGCf3xmw39xQmfEbW7Y1t
         5uQjv+ZT6tGIWw3Q/beOI+wSXwYThECIAuC4sW9+GGrBrUB5m2vToXGT012Ui5tXj126
         mORn9sYyalAWv4d0yuE2OeGCvbgYBCIin+/h/CZFPRJODtMO/0P952Ug21zfEx6LGI/h
         GtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9oYntKUPc2tJ6xDf6QhqxRubtQHDLcc9WLX4rHJmEcE=;
        b=J+BhS+VXNbhrEFFHCeoyv+WQPlxgC2jg9rNqSEATPyCEtqwPbcZqgjT+xuHEVEf8DY
         W41pVpt2ac3CE39gkwNK/bBKYm2AAe4autNaqx1xewokG6nlWFGUQv/GfKImWxiICI2Z
         ZefsgPlyQOppVFZgVTLuMP8Q/Djk0MKjubQ2v8fnmAaWJeFeV8UN9PVA2a7pU9u7TAku
         AVRZnuehqWFIJUyKldf6G7rQvGphDBu0iVX8hQEHAuVG/9FpO9fr8GKFE03zkO+eNQvt
         G+ujjm569qwli4YVtmBXn2cyft/X0KyyxJBf1U/6E5uLRqJ3uZMf0Z0/+2UaxPSaS6B5
         yu/A==
X-Gm-Message-State: ACgBeo3/vIJPoJyAHyWrMsjSYf4dWnimh6oSgbrhhjpLvtSIjNQh1b9I
        o1qWmWIR/Jk0pA5hgUAIYL0=
X-Google-Smtp-Source: AA6agR47zR5XKaYVAPhR4ZGA2giOKYcMeBAxBL6MMu75ERICREq8q9WytQY8QE3q/a/XVpzzGwP2fw==
X-Received: by 2002:a05:6512:b96:b0:497:9dac:cc22 with SMTP id b22-20020a0565120b9600b004979daccc22mr5751398lfv.687.1662829424256;
        Sat, 10 Sep 2022 10:03:44 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b0026acc9edecdsm401118ljo.47.2022.09.10.10.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 10:03:42 -0700 (PDT)
Message-ID: <03081def-8d49-8823-0f1d-cb710dc3a444@gmail.com>
Date:   Sat, 10 Sep 2022 20:03:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCHv3 13/14] regulator: rk808: add rk806 support
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        shengfei Xu <xsf@rock-chips.com>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
 <20220909175522.179175-14-sebastian.reichel@collabora.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20220909175522.179175-14-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi deee Ho Sebastian,

On 9/9/22 20:55, Sebastian Reichel wrote:
> Add rk806 support to the existing rk808 regulator
> driver.
> 
> This has been implemented using shengfei Xu's rk806
> specific driver from the vendor tree as reference.
> 
> Co-Developed-by: shengfei Xu <xsf@rock-chips.com>
> Signed-off-by: shengfei Xu <xsf@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/regulator/rk808-regulator.c | 384 ++++++++++++++++++++++++++++
>   1 file changed, 384 insertions(+)
> 
> diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
> index fa9fc1aa1ae3..8ef276ef44e3 100644
> --- a/drivers/regulator/rk808-regulator.c
> +++ b/drivers/regulator/rk808-regulator.c
> @@ -3,9 +3,11 @@

// snip

> +static const struct regulator_ops rk806_ops_dcdc = {
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.map_voltage		= regulator_map_voltage_linear_range,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel        = regulator_set_voltage_sel_regmap,
> +	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
> +	.set_mode		= rk806_set_mode_dcdc,
> +	.get_mode		= rk806_get_mode_dcdc,
> +
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.is_enabled		= regulator_is_enabled_regmap,
> +
> +	.set_suspend_mode	= rk806_set_mode_dcdc,
> +	.set_ramp_delay		= rk806_set_ramp_delay_dcdc,
> +	//.set_ramp_delay		= regulator_set_ramp_delay_regmap,

I guess leaving this was the eye-catcher for reviewers who have urge to 
nag about something ;)

Other than that - for what it matters
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Best Regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
