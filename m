Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE670B25A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjEVAKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 20:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVAKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 20:10:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50DACE
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 17:10:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4b256a0c9so230216e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684714214; x=1687306214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPS5fFkqpvMee14hrF/ikA2TPC8pX3LGfU7DUbhIJaE=;
        b=RRq0kg+dVq0QFsR0lMDQ6lhbr7Je1zV4BxIzbCLuQmhkrOyqwCc0CZMVHvClD4l7f4
         RVVnEUWAEnOW/v/4IWYs1VYqVzzCrqAi0wPvNSVUu4IAVsZC41zro2qIey1BQm4iMJUO
         7AdGizqL1+HNGAqgzEWerh6onZ8M2XjiQ4GadTD6dG9ktqD6JU/Ek7Xz20TAG2ZaqcBr
         4EG9LrXx5/l/jbFic45fKr8VBhbQzTxiW+tuhoFiDIwg9x3ja20pcUDfI1l2o5kv2jaI
         EMfus+3IWkCmnDWjEYCuXg415TIJnpZAZJHkmYM97XmmGiDiHrVISQxCRjIQt1nUeFzJ
         kYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684714214; x=1687306214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPS5fFkqpvMee14hrF/ikA2TPC8pX3LGfU7DUbhIJaE=;
        b=X2pVgvcxNDXOv0lXu+VI3m0MUIduAze6wNbD54Oj3yuihKwO/Rvh3DPoqnWUs+NdnV
         4Gmh1jlim0evfUP65yDTewk9hqObKvyVR3Se2bc3uK1FOwL5zKxIAsD5Q9g5a1MpBTrx
         J6GUat9DifhRH1gJjX/Zoa37uX4UYIzgmPbFVp0Va7fU/JtyA3hLUhpkoB2obDhM4JCR
         U6WbNJAS87l1dEnMIHep3MOEx4mwCJUKOUehdcIqfVJg83+OeMKmvCTXgghPWihQGbVy
         cKOeZMrgWLBquT3xvF27NpdvHWs4Z4tzJsKraTQBGq0KBCIsFX5ds3P7LbDxns02PrPR
         rz2g==
X-Gm-Message-State: AC+VfDzT6MEeE+/IVLgccPyf9mHfEoyb8tQtr+PVefQkN9X8JQ3DFKY3
        RILE+hq4+OL367LX78Vfuc5Wyw==
X-Google-Smtp-Source: ACHHUZ6mN4N4LRHuUJJtMSitJvgcoIgwFaOiovO3hUvVPxYCIHTdas6PwiLuCVdlTx6+16LFUpYesA==
X-Received: by 2002:a05:6512:11e7:b0:4dd:af29:92c1 with SMTP id p7-20020a05651211e700b004ddaf2992c1mr2656182lfs.44.1684714213909;
        Sun, 21 May 2023 17:10:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d30-20020ac25ede000000b004f26f437ad8sm769258lfq.53.2023.05.21.17.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 May 2023 17:10:13 -0700 (PDT)
Message-ID: <43d9d6f4-0780-5605-211d-87cc2b2e2688@linaro.org>
Date:   Mon, 22 May 2023 03:10:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 02/10] dt-bindings: display: panel: Describe Sony
 Xperia XZ3's LGD panel
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org>
 <20230521-drm-panels-sony-v1-2-541c341d6bee@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230521-drm-panels-sony-v1-2-541c341d6bee@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 00:23, Marijn Suijten wrote:
> Document the LG-Display OLED panel found in the Sony Xperia XZ3.

According to find chineese market this is LG LH599QH3-EDB1

> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   .../bindings/display/panel/sony,akatsuki-lgd.yaml  | 71 ++++++++++++++++++++++
>   1 file changed, 71 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sony,akatsuki-lgd.yaml b/Documentation/devicetree/bindings/display/panel/sony,akatsuki-lgd.yaml
> new file mode 100644
> index 0000000000000..523e580b70c7d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/sony,akatsuki-lgd.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sony,akatsuki-lgd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony Xperia XZ3 LG Display 1440x2880 6.0" OLED DSI panel
> +
> +maintainers:
> +  - Marijn Suijten <marijn.suijten@somainline.org>
> +
> +description: |
> +  This is an unnamed 6.0" 1440x2880 (9:18 aspect ratio) 60 hz panel
> +  produced by LG Display, found in the Sony Xperia XZ3 smartphone.
> +  It is always programmed with DSI 1.1. enabled.
> +
> +  The assembly features an Atmel maXTouch digitizer, described separately
> +  as atmel,maxtouch.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: sony,akatsuki-lgd
> +
> +  port: true
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  reset-gpios: true
> +
> +  vddio-supply:
> +    description: I/O voltage supply (1.8V)
> +
> +required:
> +  - compatible
> +  - port
> +  - reg
> +  - reset-gpios
> +  - vddio-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        panel@0 {
> +            compatible = "sony,akatsuki-lgd";
> +            reg = <0>;
> +
> +            vddio-supply = <&vreg_l14a_1p8>;
> +
> +            reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint = <&dsi0_out>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> +
> 

-- 
With best wishes
Dmitry

