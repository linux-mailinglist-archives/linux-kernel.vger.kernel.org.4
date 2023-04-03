Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180B6D44E0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjDCMvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjDCMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:51:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD6D12BC0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 05:51:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w9so116900739edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680526280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBlBY9aCp2fwzyEA3oA1ESp/NxFfdWBUjHz7ismdq/M=;
        b=ZgDUT7kABXnlv7ZQy4O22yoBe5x0gdxIJSPzzUUMzlIO5weoHEy2JCOq5RW2GY5rbq
         5asiMAUFK8koBo2l1hA312FmopSKyS7g5ZyXWL6olYKt9ZhyzYRvUsMFwKcNWkfQuSHv
         8z2k+U3SIQiKC4viWXe1fDRNbOkwQMpew12eeiUQh944BJlypM6VsggRjGZERoQg2mUo
         AdxZf/G1WNImdAEtsy4nPnkVH4j+eOaLhR5km+LMMoeSABMjdKxt8x85oAAVq08zGJZL
         v4NmXtYZiJIQMrTP3jrj28JF/FfH+xWjZDgMDeLtBVbcO8W0p20iylXL2ru3Ry3/hC1k
         CxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBlBY9aCp2fwzyEA3oA1ESp/NxFfdWBUjHz7ismdq/M=;
        b=3+SL4dvD9WoHAHjSfAP5ma0gPHe1SKu6fRggCWNwDtSzaScQ3kS0yqoMccACwPB2xz
         kVE+e0bUctaxc17A6xH+FMF3Pie6+5EevveoDWwa8XRKMD505ESx+CDzCgWeoOuzvd64
         knG/R5myPIoZYM7nv+tCM9z5mitj2qzCcBLGgaaP44oQS2m+a0KtysfoTFXX8BBUn+x9
         TslJdG8wZY/bkw/ZD9wNGaJc+tT7l6NLvdZIxU6JPpHqD3HDtAqNxnTN+9m6URsd6/TS
         TIT29CekEqagmmoxK6yfekPOJha1cECr3JJZuYSevl9TL4D/IhN5vg6PyFxqInxLXNAF
         oeJg==
X-Gm-Message-State: AAQBX9dT+dMeDlPdqfUiY+UoijFLjhwgR79xTWeLwgQhYQ9wBF6w2OBc
        K2RAimGYqZxp9/0AthT2HIRUfA==
X-Google-Smtp-Source: AKy350bf4uQa4MoKau0zxjWPD5Tb7xiBU+NP/AwFSxCBzCP0E607DlXYpS/wBX3Q3Wt3HJlCE2oxtg==
X-Received: by 2002:aa7:c98b:0:b0:4cd:e84d:1e74 with SMTP id c11-20020aa7c98b000000b004cde84d1e74mr39732285edt.0.1680526279821;
        Mon, 03 Apr 2023 05:51:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id n19-20020a509353000000b004c09527d62dsm4621217eda.30.2023.04.03.05.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:51:19 -0700 (PDT)
Message-ID: <d6b4df41-02cb-b900-5e8b-8ad08d3d36f1@linaro.org>
Date:   Mon, 3 Apr 2023 14:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: wm8510: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230403105237.3854-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403105237.3854-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 12:52, Saalim Quadri wrote:
> Convert the WM8510 audio CODEC bindings to DT schema
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
> Changes:
> V1 - V2: Fixup issues mentioned by Krzysztof

So what changed?

>          Add SPI and I2C examples

Why?

> 
>  .../devicetree/bindings/sound/wlf,wm8510.yaml | 52 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8510.txt      | 18 -------
>  2 files changed, 52 insertions(+), 18 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8510.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
> new file mode 100644
> index 000000000000..418a82f65531
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/wlf,wm8510.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/wlf,wm8510.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: WM8510 audio CODEC
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: wlf,wm8510
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        
> +        codec@0 {
> +            compatible = "wlf,wm8510";
> +            reg = <0>;
> +        };
> +    };
> +
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        codec@1a {

Drop second example. It is the same.


Best regards,
Krzysztof

