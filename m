Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4472403E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbjFFK5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjFFK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:57:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824810FC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:55:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-514924b4f8cso9108039a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686048948; x=1688640948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pq4/1o8g+mHwxEzqKNg20efBPbAjrR6apZBJChO3sIo=;
        b=fNLnGrMKKPYmlkdlb1s0aa4qOdDS/E1AlGKBf/9H/8/BDC1jc8RVHNZ2oaY+CwKtBr
         Mnq8pM9pKveS+LblpZJNtwLfnkiC96AHJJSuXxBNMzE7lh/sikDrt8XkRtpQU7+pYmqv
         lbSK5/2/K03Z4GucrOFZcFIN0wrfLZp6+nNbDlkfUmVlHDj5alBigSC3y+K9JrYP5Ijk
         bRRFFVL1r2vlj8BIYt0pOjhKvGO2wuNawm1t5CdDE0M2y5TX/myn3vv4A4YeSjojnKvu
         XsgUEfbbYMSa++caqDvq7fg7tMDNxS4a9jKB76UfTASnlxpGEQktqxeqakR5pkdPRwEu
         jZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686048948; x=1688640948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pq4/1o8g+mHwxEzqKNg20efBPbAjrR6apZBJChO3sIo=;
        b=MUZSvz+wD894eO+hUHmpsA4zfNevvXkE1UI+D6bgyWxyQPjLo2nK3s9i0EdHBWJY+G
         4xBC/b+yFSn/jzgsqQ/Lb+/K4wJmly0uoYuWdG/K8v/jT4dIKy1wFXtLKe9Q80WUNN30
         Qe7Xh12Q6UPHzgHjI5ceiY9qc6DICYgHcnrWy7CpEzEyesPqr96xfKeg/lj3+58/OZxn
         Lk/FVxklqId2mCmHzL1Kdpe95ifgVJwBKFlmhPsfmOpnc3klY5cBRcT0kKwkhldNRFLx
         pCioukhPYcOeblnEy9sbXCMkQ3Q7ZH7u7zTKz1casIh9DuFn7SHpAEdNeQ+1q/5Uvhsq
         NLJA==
X-Gm-Message-State: AC+VfDzfC0H4gNZDjsLOctc0BszlCIoVysYf37wld5Swz8KFrST4/7i4
        H6w23gZCJfxL721R49tYc2BdNQ==
X-Google-Smtp-Source: ACHHUZ6KgrMqGQMO7tZmwZnsNMzYsMhI4ucZxYbGLbrsL0Bzdh2tfgvpy05IWX5Q7ONoeyOU1C64ww==
X-Received: by 2002:a17:907:9721:b0:94e:2db:533e with SMTP id jg33-20020a170907972100b0094e02db533emr2144315ejc.49.1686048948580;
        Tue, 06 Jun 2023 03:55:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id sd17-20020a170906ce3100b0095fbb1b72c2sm5418402ejb.63.2023.06.06.03.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:55:48 -0700 (PDT)
Message-ID: <676e5c04-e13c-417b-5a2a-73ee339fbbd3@linaro.org>
Date:   Tue, 6 Jun 2023 12:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [v5 4/5] pwm: Add Aspeed ast2600 PWM support
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        patrick@stwcx.xyz
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-5-billy_tsai@aspeedtech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606094535.5388-5-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 11:45, Billy Tsai wrote:
> Add the support of PWM controller which can be found at aspeed ast2600
> soc. The pwm supoorts up to 16 channels and it's part function of
> multi-function device "pwm-tach controller".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---


> +static int aspeed_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	struct aspeed_pwm_data *priv;
> +	struct device_node *np;
> +	struct platform_device *parent_dev;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	np = pdev->dev.parent->of_node;
> +	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Unsupported pwm device binding\n");

No, don't embed compatibles in your code. This is useless, so drop it.

> +
> +	priv->regmap = syscon_node_to_regmap(np);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Couldn't get regmap\n");
> +
> +	parent_dev = of_find_device_by_node(np);

Why? You already have parent!

> +	priv->clk = devm_clk_get_enabled(&parent_dev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Couldn't get clock\n");

NAK. This is purely broken. You cannot play with parent's clock and I
told you this last time. Parent is simple-mfd so this code is a hacky
workaround over using simple-mfd even though I told you that yuo cannot
use simple-mfd.

> +
> +	priv->reset = devm_reset_control_get_shared(&parent_dev->dev, NULL);

NAK.


Best regards,
Krzysztof

