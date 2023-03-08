Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB96B0782
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCHM5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjCHM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:57:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DF662310
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:57:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j11so45809490edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8SIO7I4wOxQtnNTGFCi8Oiq1/e9v1+2cCDPUah83TCA=;
        b=BxUq0tQJ7sedk/dTNnv6D4vDGtFIkxUm9awRdzqEgrROJWWyga9qkmxT+NQ2fXqHJn
         gkJy6ERlRkZ63QWBikamUIVj0y+rXDcb2HCQ6GS9ZeC9Bqg7zaKLlK+lsD/6fpVodUjm
         piNGUB3UzlW4FUGDR6RjYWyOivMpfwlKyf3GLwcjk6XbWmEWTYvFAfcrnw3pYrnr1GG3
         ObUwv3DiRnFRL88ZFInEYyJnEIGARNnWZYsX0Y6Yc1J3zL2jm/k8+3KPvGb/mVzE/NqG
         f26A1yb0Zp72KEr6Si+lo3qtimMxI127k4uGq7kbHFxV8MTAQZQAfW1ngb5PsnBwXijb
         PZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SIO7I4wOxQtnNTGFCi8Oiq1/e9v1+2cCDPUah83TCA=;
        b=D+wq93Mm1gZEH0SSI2qoAAkXjq/ExoODmqElF88VgPZT4bEHxDoUDq4ZiK5j96Ifi+
         d/2HM3kwhdkMgx/cmBe9wysM9NJLvl/7pbwfLKKj5Il9v5ZFcSYgdS/wHtjvaayAIBb/
         XgF8FY1edlxTnRda+tWBLNF9U6vboCqhhzwSpmwNWx07g9h3TNx5JFpjk5w17PifI6UD
         5oYkgs7D/p0sBC3VJ+6ZbfVk9bQPdbv/KfcNXa/SKTyVFm/2YYdUSLfNj+PM/nvtHaGd
         GTYFXNxaXVu0Tk6H9M8dyynhJjifLUY838NQ1GKcqY/tolUff0brhvEPQ3mFa5cQglit
         5BHA==
X-Gm-Message-State: AO0yUKUeZHtyDHH1NK/4NeZKitxV0J+DWk2OG1jcDOL0ePuI74QkWfUu
        akIJebL17xPPIX8fA33zyr/hgw==
X-Google-Smtp-Source: AK7set/+yCw9SGhK3vBlyfqe4O+3Y6x337Nbh4SJd/E1RMQFqpvZiq5thGJyJbt+oG7zSXTF5DVftA==
X-Received: by 2002:aa7:d7ca:0:b0:4af:6c5e:225c with SMTP id e10-20020aa7d7ca000000b004af6c5e225cmr14503119eds.33.1678280259217;
        Wed, 08 Mar 2023 04:57:39 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id k26-20020a508ada000000b004af6b93f00asm8085596edk.23.2023.03.08.04.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:57:38 -0800 (PST)
Message-ID: <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
Date:   Wed, 8 Mar 2023 13:57:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 03/25] arm64: dts: colibri-imx8x: Sort properties
Content-Language: en-US
To:     Philippe Schenker <dev@pschenker.ch>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
References: <20230308125300.58244-1-dev@pschenker.ch>
 <20230308125300.58244-4-dev@pschenker.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230308125300.58244-4-dev@pschenker.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 13:52, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Sort properties according to the following order and inside these
> alphabetically.
> 
> 1. compatible
> 2. reg
> 3. standard properties
> 4. specific properties
> 5. status

Is this approved coding style for IMX DTS?

> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
>  .../boot/dts/freescale/imx8x-colibri.dtsi     | 142 +++++++++---------
>  1 file changed, 71 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> index 12056b77d22e..6f86a83bc957 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> @@ -10,9 +10,9 @@ chosen {
>  
>  	reg_module_3v3: regulator-module-3v3 {
>  		compatible = "regulator-fixed";
> -		regulator-name = "+V3.3";
> -		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> +		regulator-min-microvolt = <3300000>;
> +		



Best regards,
Krzysztof

