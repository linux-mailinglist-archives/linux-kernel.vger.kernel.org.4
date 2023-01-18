Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0782F67215F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjARPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjARPfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:35:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3A7173B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:35:12 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id z5so33287764wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoHH2nj7NXm/nL0+Tx9tLOdfs2jN6SHgUks6Yuk9t9Q=;
        b=gQ1Qcz5Xj2Q5vrDeF87Lwa/WHWtCPfHaFRIZ4IvKdaND+T7rTVeimD9FZoFTBRFZCo
         l3AS0Te1y404bmoKZqWKu3m2bqQyehETXIBXez0WwVhWCtdrFHNYSAhaBid7ZF+FLGsz
         LAhhU9y8Gymvdxu6JcW1lo0Qc34H41ASSKQEymQDN+c3n3nDxius4uoeqLRv6p1Re9nE
         5Jr73WnpXPXYoWRMClcKXu+JrrE1+G6Mz74ffawad/WaR77pOPy12TBCVdugGKfK4pU2
         RdAI1eyU6TFjaQ+MrRa6r4SwGEzlqeD04i1IE7SvtgEPU6DYaGL8pJKwKKNZJV7umSQH
         pDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoHH2nj7NXm/nL0+Tx9tLOdfs2jN6SHgUks6Yuk9t9Q=;
        b=jG7nF59sGADPTbdq2+4navPD6rhFcRA/9+qW8eD2J1CxAhkiHQrvjBKC62vgmUA14z
         4jBC8m7ikfCPoGBQs3rAJBvggX7UKpSqxZwBiVc3ODMAdZeuAxLLt+ZMHMri1JwFM+et
         vuQLBy409XbPNIfnrkIJC2q7C3rYqQOii/dX3sNuc/Jl1TubWiJr7z3+6rA3eQPAhtQn
         /dexkSiCbFJzNfyQ126IrZmalXg0IJW95xWh1P2N0Wic6Z2ZXd4S7a8Fcgax1ko5793q
         szlNL3vs1hb/d0gPYSDcpIM6oEvn6XG5iCOuDwCzzAU5En0NyoV6Zo065/zNqmwYmHXf
         CS6w==
X-Gm-Message-State: AFqh2krsW22zWrLI4XcPGvtcd4mjvUIBYJsdp3q2tH8wrrkzhCXhDLen
        dQWKGw9sOT9G6qlU1YiliDeccg==
X-Google-Smtp-Source: AMrXdXs66UXpqSe4xSmFeXLloUSAe1sRQSuZ068jrjBRmIzvXouEACawSgZsSQgK8yYKPRgL8jbGwg==
X-Received: by 2002:adf:e703:0:b0:2bd:d948:3c3e with SMTP id c3-20020adfe703000000b002bdd9483c3emr6597146wrm.19.1674056110682;
        Wed, 18 Jan 2023 07:35:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b00241bd7a7165sm31586447wrp.82.2023.01.18.07.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 07:35:10 -0800 (PST)
Message-ID: <ced7741a-3bd4-3be5-ab9f-ae388373d38a@linaro.org>
Date:   Wed, 18 Jan 2023 16:35:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 2/4] gpio: gpio-rockchip: add compatible string per SoC
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
References: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
 <1510c02c-f640-9924-e42e-fa34e28a580f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1510c02c-f640-9924-e42e-fa34e28a580f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 13:14, Johan Jonker wrote:
> Currently all Rockchip gpio nodes have the same compatible.
> Replace all the compatibles in gpio nodes to be able to
> give them a consistent ID independent from probe order or alias.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> For now only add new compatibles.
> No changes to rockchip_gpio_probe() function yet.
> ---
>  drivers/gpio/gpio-rockchip.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index e5de15a2a..493207de1 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -790,7 +790,22 @@ static int rockchip_gpio_remove(struct platform_device *pdev)
> 
>  static const struct of_device_id rockchip_gpio_match[] = {
>  	{ .compatible = "rockchip,gpio-bank", },
> +	{ .compatible = "rockchip,px30-gpio-bank", },
> +	{ .compatible = "rockchip,rk3036-gpio-bank", },
> +	{ .compatible = "rockchip,rk3066a-gpio-bank", },
> +	{ .compatible = "rockchip,rk3128-gpio-bank", },
> +	{ .compatible = "rockchip,rk3188-gpio-bank", },
>  	{ .compatible = "rockchip,rk3188-gpio-bank0" },
> +	{ .compatible = "rockchip,rk3228-gpio-bank", },
> +	{ .compatible = "rockchip,rk3288-gpio-bank", },
> +	{ .compatible = "rockchip,rk3328-gpio-bank", },
> +	{ .compatible = "rockchip,rk3308-gpio-bank", },
> +	{ .compatible = "rockchip,rk3368-gpio-bank", },
> +	{ .compatible = "rockchip,rk3399-gpio-bank", },
> +	{ .compatible = "rockchip,rk3568-gpio-bank", },
> +	{ .compatible = "rockchip,rk3588-gpio-bank", },
> +	{ .compatible = "rockchip,rv1108-gpio-bank", },
> +	{ .compatible = "rockchip,rv1126-gpio-bank", },

No, this list is useless. Entire patch should be dropped. Just use fallback.


Best regards,
Krzysztof

