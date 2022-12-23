Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840E654D49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLWIMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLWIMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:12:35 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2228E2C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:12:34 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f34so6145225lfv.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYVZ8+9h5TaYp25FjSDR2jXhSPbQaP7Gr8Ll3NIuGQk=;
        b=B/iKqnlEGIhLwnv1quGV8MJLHUTf008Jaed7bDyyOczv94ZE2cnIQ0TdGGmDWxDXM4
         0zODOlGgjRXw/BlTJ0LGS5eoZIJ7W9NQAR2FSZy93sSaIUMM5Q+syr92X9EIl3D/lRWq
         Hfb5B7Fy+AAUaasHPTSk/0ZjWeKtC96cwpNVsbABTlJIij1sWBREQQiGVkZuwdbtuKT+
         cQ3ICC8r8JqeVSvCUkfoP3/yAJDeGI5th8soBrSLm6Z8A4UwKO9jqUvfHMm93DigIvG/
         wDrWHsbfRjE4KE21ZldvhQZCwyDRpPvhrRqMF9zuZhkKwa9FYRpXlJwx5hHG1bCsl9jt
         FzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYVZ8+9h5TaYp25FjSDR2jXhSPbQaP7Gr8Ll3NIuGQk=;
        b=rZrQ85M8d0NZN51O/4e4uij/I1Sd2iu0XpY/BjLUoZOHByKOkeTIJNjD7PLnaUACxK
         SYwP+n/8fCdG6QgSbpO2oeDOARiH/8IgGJiBGLyu7e/12mp0N9OsvMGnjmiRQrz+nGEq
         YwaZCis/k21NOxJiOJZnCwPMEONSmzyrD10y9RgAccXkOPp6vStY/a7Le/bRAU+BgpJA
         n72IhRwzlMI8t6mBJ43sHaJC0sxWYin02zYzXp8ay16jI2XEuPjLzct8xzuR7w/aMDdP
         Kpzj+40192Mo3NDQs91Oz+Nw4PkMmEXI1AyAzzHE2sy0bhDIeZQfSuVhWsfrNIFsUM7Q
         Ewzg==
X-Gm-Message-State: AFqh2kodPXh8s0GtHgWAm3KTDCpgh5czLKAngptGdutWB7IA24NKD/Kj
        xILFJSgMtlgJDiH9i5xjYL8fsg==
X-Google-Smtp-Source: AMrXdXvl72h7PzLSw0eEcPahBVERYar0f+JBK3mVwVFNkP/pRqDGUB4lQPHVjvZNDIQivwsK2v65JQ==
X-Received: by 2002:a05:6512:32cf:b0:4b4:6490:cbf1 with SMTP id f15-20020a05651232cf00b004b46490cbf1mr2677026lfg.15.1671783152848;
        Fri, 23 Dec 2022 00:12:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a22-20020ac25e76000000b004b58d457f2dsm420515lfr.61.2022.12.23.00.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:12:32 -0800 (PST)
Message-ID: <9636776f-d7f5-02cf-7290-69dbba6de6ab@linaro.org>
Date:   Fri, 23 Dec 2022 09:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/4] dt-bindings: display: Add Himax HX8394 panel
 controller bindings
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Robert Mader <robert.mader@posteo.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221222223830.2494900-1-javierm@redhat.com>
 <20221222223830.2494900-3-javierm@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222223830.2494900-3-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 23:38, Javier Martinez Canillas wrote:
> Add device tree bindings for panels based on the Himax HX8394 controller,
> such as the HannStar HSD060BHW4 720x1440 TFT LCD panel that is connected
> through a MIPI-DSI video interface.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  .../bindings/display/panel/himax,hx8394.yaml  | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> new file mode 100644
> index 000000000000..a8084e95f2fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/himax,hx8394.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Himax HX8394 MIPI-DSI LCD panel controller device tree bindings

Drop "device tree bindings"

> +
> +maintainers:
> +  - Javier Martinez Canillas <javierm@redhat.com>
> +
> +description:
> +  Device tree bindings for panels based on the Himax HX8394 controller,
> +  such as the HannStar HSD060BHW4 720x1440 TFT LCD panel connected with
> +  a MIPI-DSI video interface.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      # HannStar HSD060BHW4 5.99" 720x1440 TFT LCD panel
> +      - hannstar,hsd060bhw4
> +
> +  port: true

Put the port next to other "true" properties.

> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +

With three above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

