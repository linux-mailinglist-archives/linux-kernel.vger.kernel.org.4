Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434CD63F509
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiLAQRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbiLAQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:16:59 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB974218A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:16:56 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c1so3229561lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 08:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oTFc2dATfS9osXis9xvRsQEPe/ZtfQF84AfMRcTyJw=;
        b=W3E9HyIOcWSK38+gsC9ayGi8852SOgd2kmcoRgfY97I0IkRjY3jknE9upUK3uw7w6H
         fmzIsnwblDSBCn+BZjHI3VMOawteustNcZGIYZnLGPtixGg3gKVEzju/NUqvHPWCTkMh
         qLcgzn+v2a3iIV12gq0799sUWYk/WqMk1J/xkkS0DNrA/3GBhvoSAtJuewSM6/jeJxjT
         ZApBARwj0ADjZazjwQ/uhyYFFL+31pZ3qdY7TIL6Hk8nEbtHlGppqa8/YUnPVaVLNYZP
         zaZlyHTq56Ouu5a04ULGtD6qyFFQAnRqMHcO588Jc6GAZqMCK9rposhsYh6h1inT4Etp
         YOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oTFc2dATfS9osXis9xvRsQEPe/ZtfQF84AfMRcTyJw=;
        b=BbsIgbZ8jXwPhUNqBd84x5UE4RkHCEvItUBpueBZkHWoqqw3h3ppjZIdwJcVveVAUs
         Q/XtBzRfiMaVyfy0GVc+3IfSfOIBjsq8BN+OZD9hq0Egub/Qo67v1f0sjiIAGQdet0QX
         Ibe1BPBjWMRhL6OE/vy8tdoOM86i9p2N/MQDUn/YgRE51et3gF//gOQnrAQA8cVH2XGE
         pBEdgoGybaW9c+fdzhAb/uoMClag8TWK36oHg0TBublcpouJ28bK7S/U9d/37zLuYw/j
         YWK5ZgCSONI2KMiWm7bM2uZR+yT7Cw9a/Al0J+XndrpltPHt74CNjwGZGaEGK0b7s7gw
         Ehsg==
X-Gm-Message-State: ANoB5pnY1ExKSGhwQnI6idQZqK8g0FfgX/IGw/Cv9wpdD4bkeKMnS5e6
        0ZvRageNBjf24ATFt+ZYVxgjIg==
X-Google-Smtp-Source: AA0mqf5pH+x5zT3NaSsywf8/ZupOJED+U46KUk7f7c1W0olYbCt1BCmCjsra+fdMT0XTniKChdl8uA==
X-Received: by 2002:a05:6512:33ce:b0:4b5:ff:4050 with SMTP id d14-20020a05651233ce00b004b500ff4050mr11242043lfg.476.1669911415121;
        Thu, 01 Dec 2022 08:16:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s24-20020a056512203800b0049480c8e7bcsm691799lfs.176.2022.12.01.08.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 08:16:54 -0800 (PST)
Message-ID: <17ae860f-3fc2-1fec-df30-f23568656b9e@linaro.org>
Date:   Thu, 1 Dec 2022 17:16:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-3-saravanan@linumiz.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201044643.1150870-3-saravanan@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 05:46, Saravanan Sekar wrote:
> Document mpq7932 power-management IC
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
> ---
>  .../bindings/hwmon/pmbus/mps,mpq7932.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml
> new file mode 100644
> index 000000000000..5f20c59eb7ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/pmbus/mps,mpq7932.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/pmbus/mps,mpq7932.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ7932 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <saravanan@linumiz.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mps,mpq7932
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object

The comment was - drop regulators node if you have just one regulator...
but it turns out you have more regulators? Then you need to follow
regulator bindings. Open few and take a look.

> +
> +    description: |
> +      list of regulators provided by this controller, must be named
> +      after their hardware counterparts BUCK[1-6]
> +

This misses patternProperties.

> +      "^buck[1-6]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false


Best regards,
Krzysztof

