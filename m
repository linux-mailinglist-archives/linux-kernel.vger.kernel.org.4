Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AFF6FEED0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237411AbjEKJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbjEKJ24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:28:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC2D7EC9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:28:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50db7ec8188so4964746a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683797332; x=1686389332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cHA3LraFcmGDTaIqGBRmZ93pU3RzjaRHQjlm2jCEjo=;
        b=JXsAiFr6M63ygBIRwO4p+SZCq+xy3AGLgKBO7UA59TEBVF4aWxdjr0p4qxNeUEGjpS
         H81i4v/xaK46iIye8Xmpu01rg7lYSiheY3PIB+CCDzt5YzJjFhlVGK6cDzMN5OFfbk6Y
         qKV2WIFlFJp7jQ7lDDIFe2H3uDkrFFpqGnljGuXHPaEJmYvNepbTQgYnJgxvDYmfyfYd
         3+uXm+JJ+GXraAs9LbTUIlft65Y5QMEqEbbojSftk96J3vMHi21VsTEyqW+RljPYrk8v
         r2Bo7QkGIWN2r2S7i2awUnVRAZU4z/EwTYQqEqAL59gKoQXskq6/gkjUNaET3qd8WgDV
         JkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797332; x=1686389332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cHA3LraFcmGDTaIqGBRmZ93pU3RzjaRHQjlm2jCEjo=;
        b=Hj2M6MeF0ksUqq/wwYKtOHVvN1lF7N0HLfa/Wgmqv/MimCNru8FybqDqkY3+OPU3hL
         pxmiFXw+kdlCUVuia8Cwl22Cig2+2g8cDpaskBvN4e7KDIJ821p9X/M+FoDf70s4y7nA
         sxF/XitF2awU9EFwcF4mOIbDz51579r66yPAxn4FuThiIUpLn0kL9h60PWOusiwHj27e
         dMRdgu3fg8mTVM28aZHoQazoWctCZY6Zn1Hp0RA4ybbxHpldxVsn1jkeSOoHRUw2NIkR
         h0K9ZZfX/inY4Xtvqi8U355iE8lWzxS49MzwzV9UaA1WBt7i3C+t8f4vLqT8C+Bov9vq
         YAlw==
X-Gm-Message-State: AC+VfDyfHx6bXWGI5RLMshjR4l6767a4zeWKPes+/byyqHroFJCuw+4g
        kCqgYNZGZh3p9JkV8hFf+uVpuQ==
X-Google-Smtp-Source: ACHHUZ75ta179hLwDGK7JWKKo/Z4TJGh6O9B4U9ZlcNk2gja0S38wokx5miC8QiJ02RLTkBXBTk2LA==
X-Received: by 2002:aa7:d659:0:b0:508:14f2:399c with SMTP id v25-20020aa7d659000000b0050814f2399cmr19284560edr.10.1683797332595;
        Thu, 11 May 2023 02:28:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id l14-20020a056402028e00b00506addaaab0sm2709963edv.32.2023.05.11.02.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:28:52 -0700 (PDT)
Message-ID: <fc104fdd-3894-aa94-12dc-4c73b26d4159@linaro.org>
Date:   Thu, 11 May 2023 11:28:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: iio: temperature: Add DT bindings for TMP006
Content-Language: en-US
To:     Anup Sharma <anupnewsmail@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>, broonie@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ZFvo2TIiPiMFlbXC@yoga>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZFvo2TIiPiMFlbXC@yoga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 20:56, Anup Sharma wrote:
> Add devicetree binding document for TMP006, IR thermopile sensor.

Why? Where is any user of this? DTS? Driver?

Subject: drop second/last, redundant "DT bindings for". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../bindings/iio/temperature/ti,tmp006.yaml   | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> new file mode 100644
> index 000000000000..c6c5a4d10898
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp006.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/ti,tmp006.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TMP006 IR thermopile sensor
> +
> +maintainers:
> +  - Peter Meerwald <pmeerw@pmeerw.net>
> +
> +description: |
> +  TI TMP006 - Infrared Thermopile Sensor in Chip-Scale Package.
> +  https://cdn.sparkfun.com/datasheets/Sensors/Temp/tmp006.pdf
> +
> +properties:
> +  compatible:
> +    const: ti,tmp006
> +
> +  reg:
> +    maxItems: 1

Missing supply.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        tmp006@40 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

temperature-sensor?

> +            compatible = "ti,tmp006";
> +            reg = <0x40>;
> +        };
> +    };

Best regards,
Krzysztof

