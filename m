Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B486E660EE7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjAGMva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 07:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjAGMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 07:51:28 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331DE76EC7
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 04:51:27 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso5355968wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 04:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kmoQ/u+G9G8zOvmN8BbgXLEcMlL+8PUMUot4O7oTYU=;
        b=dknDOhZiOZx6N8mxrLxmzfEGaVB/HnbxjqdFLw5Hh5lat8whsxNiUpbrXJZ/QpNuZB
         qxj8EEWJevM9ZkMVPw+waMFv57StmKbYPk4Y56hgENFawyjqMFfRepcGBA4wa2kHiZ/h
         nAXHcCudu/yMVDIzK3pSaZsHrswTHjIGjy+CWstzt05koUq9ojtEFJMtspNz0AN0H6xs
         864Z5C/7YNZDXaUED4BNaxlPiHWVbh2MC2qxeCwk67RDvpqSJQPQrthlwkbV6LbQtt6H
         1v4mRqOJS/SiOdb8OAQDaehKloUKa4AKZtgNc+52YOo60MV+ykMlbEoyFkWxF3BPe4T2
         uDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kmoQ/u+G9G8zOvmN8BbgXLEcMlL+8PUMUot4O7oTYU=;
        b=BhXblo7VkJx3HefhyR81hpkh8yHXAJq7a5X+8lYfiqihPFhlxGPyBcUaExZIMS6xHm
         KoIAol6BdX5XmJlbUnCzUa187293UcAzQxI3Aryhs4sG0jAv6cwV6/0DKoDxTkHNyjfN
         9McH0R0BNc1LPG0VpLuxxaH0vAL6dDAErr0uAP/Sw7bJJaqmBi46TDDpeh2D9tYHedFX
         GjbcLmc1k7rLDkfs0WAICm/6EL5HyrozyP/X+YMUrNU+Ugm4E9SCCWX8ol8vngW7J54W
         v2SZTQ/sEhWm+niWrnLhDu+Rf1d3aOlB2Dq5nYUKZXGxiF4bCYLoDB+k7eW1KliM+3cQ
         rEhA==
X-Gm-Message-State: AFqh2koKyF2jQpscny3B82H3F/+S7e5CKvINx4AuvYJLg9cdzFoMh/5d
        O6uMd+SDGwFG72nBsHpJTFSh/Q==
X-Google-Smtp-Source: AMrXdXtsspADlUPwT3zNqefHd0aEud7EVXUZY6ZyOJcd15kj/Gbaw0+SfMbh9vvJtXz+AvbtR6APXQ==
X-Received: by 2002:a7b:cb8a:0:b0:3d2:7e0:3d51 with SMTP id m10-20020a7bcb8a000000b003d207e03d51mr44260530wmi.17.1673095885793;
        Sat, 07 Jan 2023 04:51:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003d990372dd5sm10691037wmq.20.2023.01.07.04.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 04:51:25 -0800 (PST)
Message-ID: <2b2abd3f-469b-91ff-12ed-c8422c50ba6f@linaro.org>
Date:   Sat, 7 Jan 2023 13:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 2
To:     Andy Yan <andyshrk@163.com>, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     lasstp5011@gmail.com
References: <20230107115159.2125308-1-andyshrk@163.com>
 <20230107115221.2125368-1-andyshrk@163.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230107115221.2125368-1-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2023 12:52, Andy Yan wrote:
> Add EmbedFire LubanCat 2>
> Signed-off-by: Andy Yan <andyshrk@163.com>
> 
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 058ed707f3cd..870c32f8574b 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -100,6 +100,12 @@ properties:
>            - const: embedfire,lubancat-1
>            - const: rockchip,rk3566
>  
> +      - description: EmbedFire LubanCat 2
> +        items:
> +          - const: embedfire,lubancat-2
> +          - const: rockchip,rk3568
> +
> +

Only one blank line.
With above:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


>        - description: Engicam PX30.Core C.TOUCH 2.0
>          items:
>            - const: engicam,px30-core-ctouch2

Best regards,
Krzysztof

