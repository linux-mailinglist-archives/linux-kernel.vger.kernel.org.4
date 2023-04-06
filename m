Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C580F6D90C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjDFHpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjDFHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:45:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AC186A5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:45:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er13so106172618edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680767113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOjoikP2F15w+15T/QJGgscQFyRwfxAkd27/+GjeIJs=;
        b=YrWVOTeR1tJGMVNUyVwkw69hY1/UCcVC4Rl/weBy0Or/GEp8m0Oc/KfCnuHcLVpePt
         RH64vz4sWzuY/HyaDvqSaR/B0iWN8mLcdcMpLuCuhQAAY4W/QMkTqCYy5jEw9aIkeGrO
         U+dDaVZWFsi/Q/73WSVnjac9pGr/KxYrxk3Xjcf5MRvUJWu4qM4ppNa788UQrlX2LIB7
         oSoLPucZ5+rINoKzHsECnYL1Kw1whHWwmk/LDqgAcmV+dy2O3EG1puMwYtuZGNT3awnl
         hGiU0IbG4WFQcV4bwiiuSiAx0OK96TK0MaYwKSfvh1/imrtUboCoxbIlq/O0CcoP2A5a
         dxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOjoikP2F15w+15T/QJGgscQFyRwfxAkd27/+GjeIJs=;
        b=DQeRuR6TAR+iBE9KgUpAV1GQV+G4dYBAiH8k7mtg6ftGGFRJ3Y/Wmpa7/DgyoEhYuN
         JLXs5VWDz6YYRpGXgpvEkbMHdFTSkquQp8hX923Ls3/UYmEUGmeFaX72jIjaXwxXucjk
         slEjgdBmAE1gkAGTexLbClu0fdORoKZx9NAUy6XDLNgE8ODOi6patPE24vATXUkrnwnY
         x/IQ9NvQi6/hCLZqMzi3DIhHjo6FiYC/KP+Af8jESCJM0P6msJrrSpnp+pL5DnLZrRZN
         j4QTVUw9dNUn5J3vkOv71AntaIijcRminEu1WV9T+pRKav17soGbjwjWU/EMqbTqo9wL
         sjYQ==
X-Gm-Message-State: AAQBX9e0RSNBIQMuA23KbDHjv1kJxMsu3nGaBH7uXWBmpOy4+9fYyeD/
        NGGiKX883RD61QNsD2EpayIl5aX5cEbZMWZ9z8o=
X-Google-Smtp-Source: AKy350YOUjGCPd1HXHOZt6Oat6KFx5NcZ7QNjzs+crEoKqdKeA3jJFs4x/l6OsbN4xduiuo+/u0Wcw==
X-Received: by 2002:a17:906:c7d9:b0:946:c1d2:8b53 with SMTP id dc25-20020a170906c7d900b00946c1d28b53mr5070042ejb.72.1680767112800;
        Thu, 06 Apr 2023 00:45:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906bc4e00b0093338259b2bsm423583ejv.207.2023.04.06.00.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 00:45:12 -0700 (PDT)
Message-ID: <15dcd1fa-9adb-6bc2-9f01-454273368002@linaro.org>
Date:   Thu, 6 Apr 2023 09:45:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv1 1/3] dt-bindings: usb: Add RK3588 OHCI
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
 <20230404145350.45388-2-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230404145350.45388-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 16:53, Sebastian Reichel wrote:
> Add compatible for RK3588 OHCI. As far as I know it's fully
> compatible with generic-ohci.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../devicetree/bindings/usb/generic-ohci.yaml  | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> index a9ba7257b884..d84732a100ba 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> @@ -44,6 +44,7 @@ properties:
>                - hpe,gxp-ohci
>                - ibm,476gtr-ohci
>                - ingenic,jz4740-ohci
> +              - rockchip,rk3588-ohci
>                - snps,hsdk-v1.0-ohci
>            - const: generic-ohci
>        - enum:
> @@ -68,8 +69,6 @@ properties:
>      maxItems: 2
>  
>    clocks:
> -    minItems: 1
> -    maxItems: 3

The constraints here should stay.

Best regards,
Krzysztof

