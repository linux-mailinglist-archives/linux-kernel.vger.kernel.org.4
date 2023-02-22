Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1D569F4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjBVMhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjBVMhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:37:01 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517853A87C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:36:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy6so24257856edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWfO3bHN/QEhS+Xs0UzkJUsUmv76YTb0jgQPn6Hkz8U=;
        b=ogVriWu9pImQoFQu6bo/zNCC8eZ0Duy+7bRXnFrKEdX/j/4s2vUWCcAKYZfQkJAiTD
         /02ZY3Psih2fZrLmQFw6SlEdNK31kCqtEEELWpHYe/cacSbLcRgZtYmpkkjU4/mvYe9C
         G1kmVKF49UuLhb/ry/6NSlXBGCj0NXjoGFYwIIip8THXSWK7KeSQo8vs9csFiXSEaXxL
         VOn5sNWrt1Voc4gucYEq8RkJ8E2VUSqSf9t/qHiYajoCztVx6xvAIv7xAOMjTyzUP+g9
         Q2TFH6pBbUI8zxGPdOgiIhcPcmqgwqYXg0TNZVsuU0u5rc0FST+suYhpqDSrVjSWYsjL
         rgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWfO3bHN/QEhS+Xs0UzkJUsUmv76YTb0jgQPn6Hkz8U=;
        b=DtDgeVRJCBAgG36etDT5uRRKbQCqRmtvbHJ3+BS2jPg0Beprf1DqBH8QWjSRCfzcAB
         HJBCv0AOv+NziVYnwSogRH8IfxiSDMkgwS+zJBHtEztpH7TQ/c9pl7lLsQhht4tTn1Ec
         1184q+4I76DMv667pqQ/TV21zG47jcpKGCLop2pjcFpvY3eRCyjpqv6G2CdK8p0bn7tf
         ipqR4wpzeEO3rGLbtnyAp4rrp6voRIDOG4W6b4uzfgkNCZXQz+bpm4dW1pGUCRjKl/JE
         m4N/Pqh7K/rirl77Z03Yc43K1MdJ0x4dbF5Q3AOJBjyTI+Y2poCg5AMac7wLd0nLi1dS
         Z9GA==
X-Gm-Message-State: AO0yUKUYn0f7GPODD/Zbfax1lKiCV5oq99IohJLc+msZA0kuvDtdJavA
        putTiymRUN/dqbyhCJ5gWaGkJtxg7KJT57x4
X-Google-Smtp-Source: AK7set/v1HvDm7IY1V+42v11cvnsliWIfG7RseOCxxbVQCy4vucFFgoP7tyDKRoeQOO3T7cz/WInrw==
X-Received: by 2002:a17:906:fca5:b0:878:42af:aa76 with SMTP id qw5-20020a170906fca500b0087842afaa76mr14505727ejb.54.1677069411749;
        Wed, 22 Feb 2023 04:36:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fp16-20020a1709069e1000b008e22978b98bsm1640150ejc.61.2023.02.22.04.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 04:36:51 -0800 (PST)
Message-ID: <fd395ae4-d182-c637-e4b7-6d166ebc1b21@linaro.org>
Date:   Wed, 22 Feb 2023 13:36:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: wlf,wm8524: Convert to json-schema
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222113945.3390672-1-chancel.liu@nxp.com>
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

On 22/02/2023 12:39, Chancel Liu wrote:
> Convert the Wolfson WM8524 24-bit 192KHz Stereo DAC device tree
> binding documentation to json-schema.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8524.yaml | 37 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8524.txt      | 16 --------
>  2 files changed, 37 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8524.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> new file mode 100644
> index 000000000000..09c54cc7de95
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/wlf,wm8524.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wolfson WM8524 24-bit 192KHz Stereo DAC
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +

$ref to dai-common.yaml

> +properties:
> +  compatible:
> +    const: wlf,wm8524
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  wlf,mute-gpios:
> +    maxItems: 1
> +    description:
> +      a GPIO spec for the MUTE pin.
> +
> +required:
> +  - compatible
> +  - wlf,mute-gpios
> +
> +additionalProperties: false

and then this should be unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    wm8524: codec {
> +            compatible = "wlf,wm8524";

Use 4 spaces for example indentation.



Best regards,
Krzysztof

