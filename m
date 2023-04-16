Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150006E3880
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDPNJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDPNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:09:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331F1FE0;
        Sun, 16 Apr 2023 06:09:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f3cd32799so42980966b.0;
        Sun, 16 Apr 2023 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681650580; x=1684242580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sNQcR72lxA1AVVNfsXZ77YrtExBj+UGMBGyQjKiT4qs=;
        b=q04H6dBFxTDy3zNnMEYBfZKyTEBySfBSi+bwBrHuR0KQw3QUyqz9Jp/AZ/3w1SemPD
         V06Y00LCI2RRKOueZct0TIpYcH/AQjIdyjP8TuvP6wAd4Z2WBZOYHpBqiecYjX3GlHkO
         Q13pqT/ej3fpLW16eAueTCYVJBKfrlVAOg6xCCIwvtWh3O991AlXT79TCYS8HCinfKDf
         CuYx/Wy4r24oDC/w/NIMUVlt6eHy3BMp6+vxteK0+XiDSrggpT63GTmS5ibeVBeerYy2
         s+8wmyw/oYU/0bmBBFJDs026wOs6RcbefKq1Bhtubm1IAilpttvv4QvHwMoyYD7ZQ1uc
         KqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681650580; x=1684242580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNQcR72lxA1AVVNfsXZ77YrtExBj+UGMBGyQjKiT4qs=;
        b=IE8JREGPVDOQuPARZl9FceQEW+k1BLcTwjojtxUNRkdMl+2gCO8EraLFbR9gzs6S51
         qC7xPLJ8lMQAwaFm3hlUDitZba2Pa9rJN1pb0e7k3o3i9dvLlCyJJSdqMxUf8/a7cZmR
         LNFT6Np/FCQDnP3k08lo5PN8v6yXJDNlAZLPB3/JbO8u+U855HmNGAjOKRWRUnjsQH7U
         x2uAq5kNEDL4vUtkQApErLRJlcJoAf7oW9AREMBXdQVP/qeCndj0k/pw1zA6UftXzEP3
         1cUxXg5BNYf3CUKWiPHy9PrRFivvEPU5v2JqbYWZsm8E+cEl0b5flJ4ax8scpuQD9DP7
         E27A==
X-Gm-Message-State: AAQBX9edsyVfYkRh48wFwH7XRb/WoRsxLdMGCbsdwr0sa1U7x9zwWQqX
        qr0jF3vjR0Lq48MeBlWaQCQ=
X-Google-Smtp-Source: AKy350YIaQnWdnA8o0bmnjpipOetmc+37VvK2Sz1+cpIazmoOZme0G2J2ujFouu4WO/7L6+K3Xxt4w==
X-Received: by 2002:aa7:d38e:0:b0:506:70a2:cb9c with SMTP id x14-20020aa7d38e000000b0050670a2cb9cmr9952800edq.12.1681650580319;
        Sun, 16 Apr 2023 06:09:40 -0700 (PDT)
Received: from [192.168.50.244] (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7cb51000000b004aeeb476c5bsm4437961edt.24.2023.04.16.06.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 06:09:39 -0700 (PDT)
Message-ID: <8b9438b9-6628-78f8-6de3-aa1f418044ed@gmail.com>
Date:   Sun, 16 Apr 2023 15:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: display: panel: Add Samsung S6D7AA0
 LCD panel controller
Content-Language: en-US
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230416130735.30965-1-aweber.kernel@gmail.com>
 <20230416130735.30965-2-aweber.kernel@gmail.com>
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20230416130735.30965-2-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 15:07, Artur Weber wrote:
> Add bindings for the S6D7AA0 LCD panel controller, including the
> S6D7AA0-LSL080AL02 panel used in the Samsung Galaxy Tab 3 8.0 family
> of tablets.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changed in v2:
>    - Updated commit message
>    - Applied suggestions from Krzysztof Kozlowski
> ---
>   .../display/panel/samsung,s6d7aa0.yaml        | 51 +++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> new file mode 100644
> index 000000000000..969cef7738b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Artur Weber <aweber.kernel@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6d7aa0-lsl080al02
> +
> +  reg: true
> +  reset-gpios: true
> +  backlight: true
> +
> +  enable-supply:
> +    description: Enable supply
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - enable-supply
> +  - backlight
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
> +
> +        panel@0 {
> +            compatible = "samsung,s6d7aa0-lsl080al02";
> +            reg = <0>;
> +            enable-supply = <&lcd_enable_supply>;
> +            reset-gpios = <&gpf0 4 GPIO_ACTIVE_LOW>;
> +            backlight = <&backlight>;
> +        };
> +    };
> +
> +...

Wrong patch file, please ignore. Will re-send in a second.
