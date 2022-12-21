Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A45A652DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiLUIRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiLUIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:16:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DE121E22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:16:06 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id cf42so22379781lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRBaCHV+UNDOXNoLk4RfhR9W0+ki+Ik/87sPPJy8yrI=;
        b=CVZQdBzEjr6RL1Ae0Eo+U9kj3bBVkp3n+L9Xmdm68zecrs+0PcSmQ6xCzdWoTgVNko
         OLkvzYmtIY5JmEWTyZiHP11QfUZ2V43ZWAf8717nGRFZ3h9IV3mnviXd3F1MK5aVPd5a
         ChiI0Kgd9eW8buDR/xEiuRePbnduQ8D49GclP1GorMzdPoGZ2prXAvUuR8/nhPGF9KlC
         5X2LtCk/6Z1Yq62MXp1aRSUDfRNUr5aIzaL5AUn1AZVDJlWHf+03BuPuPmLLO26AmnfD
         gBe6SxsY+KCSawtftjWBcQUXkXAHUFxpbd8S0KhL6AtbAbXWJROx8vn9hLTLwTCO6Z8P
         8v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRBaCHV+UNDOXNoLk4RfhR9W0+ki+Ik/87sPPJy8yrI=;
        b=KZ/Fg907DZqd6HdB0s/SMXqO/UGyuqb0WZtfCZXEPxCS2M3tG/ofTYvQRO1vkkYsUf
         X4ktWVONZ0azC4e81mUJwiu4DzkBvKI3GwCObflgBZZ+90OYI8zQfEx8twKcESDtRLAC
         s1lUFUV1kk0c0PE+b5ghF/noZu2caaGiTNvejz2xIthdCRNcFxOCTF+6Wv1QVY8Re5p5
         mr9ddBXpP5hV5NwsOeBCOPT8J8X1QlplUZUKR/A2VncZ0Rp7KPdKyOKMX2RqQCT1wDKS
         mOarUpYFy3I8ZHLU49oUJYtkaosdv/CfXCP3Td7im0wLYW6olN4Tm6zd6fK9pRQCDhbF
         EWFA==
X-Gm-Message-State: AFqh2koJuLld22Lm7HDayvPtajQlnTNx6x0cxReq+nrNWGeXHOzDn/TY
        +ZizRp7Wu3BC45MlJIjaKQPh3g==
X-Google-Smtp-Source: AMrXdXvu0JzewlvcpSAFLMx6y5F94at0p3f/YQ/rIg3GUPVVM1J4xERq2AC2ortFxt652/XA6s6dLQ==
X-Received: by 2002:a05:6512:3048:b0:4b5:5f2b:ddf8 with SMTP id b8-20020a056512304800b004b55f2bddf8mr419900lfb.7.1671610564375;
        Wed, 21 Dec 2022 00:16:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h10-20020ac2596a000000b004b4b69af17dsm1764774lfp.214.2022.12.21.00.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 00:16:03 -0800 (PST)
Message-ID: <5a7907e3-f79e-5de9-ed1b-ec24ea52c437@linaro.org>
Date:   Wed, 21 Dec 2022 09:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat
 1
Content-Language: en-US
To:     Yuteng Zhong <zonyitoo@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
References: <Y6KfFEChA67E7oX/@VM-66-53-centos>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6KfFEChA67E7oX/@VM-66-53-centos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 06:52, Yuteng Zhong wrote:
> from: DHDAXCW <lasstp5011@gmail.com>
> 
> LubanCat 1 is a Rockchip RK3566 SBC based
> is developed by EmbedFire Electronics Co., Ltd.
> Mini Linux Card Type Cheap Computer Development Board

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> 
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 88ff4422a8c1..84d39a3a8843 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -781,6 +781,11 @@ properties:
>            - const: rockchip,rk3568-bpi-r2pro
>            - const: rockchip,rk3568
>  
> +      - description: EmbedFire LubanCat 1
> +        items:
> +          - const: embedfire,lubancat-1
> +          - const: rockchip,rk3566

Here as well.

Best regards,
Krzysztof

