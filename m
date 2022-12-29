Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DFC658AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiL2Inv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiL2Int (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:43:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847A01004D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:43:48 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z26so26666860lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vL8afHzTaqjBY6U5w1WFZj4uiZAR1AAE2D/1vRWSAHg=;
        b=jvAJbYHFZGbz9dPddn2mPrro2N71ItWk2khEugyAqyHCTvQdYJ24CJLSFZS0nfWIPm
         0JPEh6ieruyHJN3HB+np8ETesGVGIPJ2hK1ea6mHP7STdkdDqVH5xn06SEJhAIJ4aslZ
         94M8A2ltNYXPALWwd72mITM8x34hXTc0JYvHHbPZR+sOp9vyHIClFPLZp1+lflCG3EKL
         KYmhm1hWx/fFc7cvlvWwmrrkwiMm5TaQnxqHHOG4juwomWvdfQcTbfOz1WNCXEvLqqgF
         re7cKY0+EFkl2nbawv+pvOkzUX+rY7TdCjxS4yyPhubqsF6dU7qumwnw81HMtTSkGTK3
         tSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vL8afHzTaqjBY6U5w1WFZj4uiZAR1AAE2D/1vRWSAHg=;
        b=aUzv8+xH4agjUrAo2cICxoZHeRTgeBkIqjchNkBCz0JdoFw6nHoD69KO/J6U6x3o+I
         uPrZ/Yf+URnVfahhepvOtHtIDA/SgstBx3OG47PPtn1U6R29Czb9+viankYxKru1rbcb
         WWeTMeTmAKqXlKt8qTFcQ4Ffi5KohCftRLgbw+0x55YfpaYn2jDP88YO3sn3sIZygBMI
         1AaMqgbk0Uv8Eny4Egw3NwG+iCQGErCDyhcu1a0y2fafLmbALuJtEVvhnHfNXWbgSUTv
         DndL7zLZPXY3XbtNp9V1f+GG4lrC82lXU1js771DUSJ/nr7pGNDWV1fAqVpiBgXhwJks
         YT5w==
X-Gm-Message-State: AFqh2krncQ0Wt4jByLb5KJAdDWXS8esWBuzzizdcJyIChBAdqWw3v9ry
        kJTnD3ZgywROYF0YFYcpH9rLwQ==
X-Google-Smtp-Source: AMrXdXsiU8r20s+g29/F1UOGiJVZst6npjcKAkomkf1TTX+1kDwXWnKtkw8AsQ6aF9WcMYF1Gkg4rA==
X-Received: by 2002:ac2:5142:0:b0:4cb:2260:8553 with SMTP id q2-20020ac25142000000b004cb22608553mr62917lfd.30.1672303426916;
        Thu, 29 Dec 2022 00:43:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c9-20020a05651200c900b0049944ab6895sm2951747lfp.260.2022.12.29.00.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:43:46 -0800 (PST)
Message-ID: <1216b455-7637-a510-28ca-f2affa0ec799@linaro.org>
Date:   Thu, 29 Dec 2022 09:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 2/2] dt-bindings: soc: rockchip: graf: add
 rockchip,dp-phy.yaml
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, kishon@kernel.org
References: <5fa3aaca-4e49-8baa-68c4-2b3981400d3b@gmail.com>
 <aa942b16-1135-c202-d44a-d25f1f82787f@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aa942b16-1135-c202-d44a-d25f1f82787f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 23:02, Johan Jonker wrote:
> Add new converted rockchip,dp-phy.yaml to grf.yaml file.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index 7ac9aa5fa..36f6d85a9 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -96,8 +96,11 @@ allOf:
>      then:
>        properties:
>          edp-phy:
> -          description:
> -            Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> +          type: object
> +

Drop the blank line

> +          $ref: /schemas/phy/rockchip,dp-phy.yaml#
> +

Ditto, so with updated path:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

