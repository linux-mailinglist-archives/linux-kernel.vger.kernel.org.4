Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2485A6C4436
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCVHiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVHiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:38:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07A20A1D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:38:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so6112130edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679470683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fIlFrePZXbAkRU2ELLJPQAlw9IYOtHNm0vNBQivbWPw=;
        b=Ovk6gx9LBcuOvIdpF+utI2+huZW2TwdhnKy6VxEQRwDCZA9TY4mdwyiqUaV/Q0Ue4i
         t6IQatnKJOtNRArp68GUTKweCl0MlKdRfog2LEAolB4T7hzD70haB7PLcvCCN85tjkG4
         Ffd3aNS8kKC1a3YTllsPUi64p+SQbAKjB89v0mexDiB0guMTeC6Wuyk503iTcsh+Rv/m
         e0bAZnP3FxV4ktpIDfsRFBoPOauLZJM7zoaWTj9ZRQtq6faWDENs04KxRhFVdiqtiwAb
         pI2vcKOq5KKoCWZREkNLl+6B6AOS7uDTBO7viKCZcHMHZ8sbbw7yPndR6ciO6jVrTeSu
         Pnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470683;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIlFrePZXbAkRU2ELLJPQAlw9IYOtHNm0vNBQivbWPw=;
        b=jy05JfL0oDt/Yavqhnyry+4vyS00BsaylNE1rPptpwkOhYHbR9TuVDZX76lpRB1xv0
         xXD5SMfcpFM4xegcXJKSNWiuVxuV2i8VvDT+F28DdOsaF+ISdkVYI36SYoOPspNisaRC
         pZTNZiTK1cCk0swGilGfEM2ZuPLodm9ZgcU6N18j+twz69SQ0ecLcidLiGIqcEZeBZiX
         j/BpWsv96qDSy1Ain87RI4ScVhxQbb2/OYwdHCZuDCRGwSrY0k+MODsIHXWUBBc0/3yd
         U1BSLo31JdKuiaasSUG/BGxSpCCTQ5TdKeU2M9PLqpjDec5uz8EMo3PwiOxofUaT83Q8
         mXHQ==
X-Gm-Message-State: AO0yUKVolOKlVV8znAWC9M5J1Il2KPDNUBdjhlnmqeZ+Q+phLyqmOl5f
        CVqBb7k+Jl7gkAdRB1Rf0HjvrA==
X-Google-Smtp-Source: AK7set9uNqqqp+RTyy+Lsso2YFsulLEsLgbXC/U05maYZvjld3UjEALosJg2dArGoCc9ViY65hz1fA==
X-Received: by 2002:aa7:c84e:0:b0:4fb:e9b8:ca5a with SMTP id g14-20020aa7c84e000000b004fbe9b8ca5amr5669909edt.40.1679470682958;
        Wed, 22 Mar 2023 00:38:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id g4-20020a170906520400b0093a35f65a30sm1619990ejm.41.2023.03.22.00.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:38:02 -0700 (PDT)
Message-ID: <d1559192-8f6d-26e0-ef19-d14ac7987a74@linaro.org>
Date:   Wed, 22 Mar 2023 08:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: ak5558: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230321180809.9215-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321180809.9215-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 19:08, Saalim Quadri wrote:
> Convert the AK5558 ADC audio codec bindings to DT schema.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
>  .../devicetree/bindings/sound/ak5558.txt      | 24 ---------
>  .../devicetree/bindings/sound/ak5558.yaml     | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> deleted file mode 100644
> index e28708db6686..000000000000
> --- a/Documentation/devicetree/bindings/sound/ak5558.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -AK5558 8 channel differential 32-bit delta-sigma ADC
> -
> -This device supports I2C mode only.
> -
> -Required properties:
> -
> -- compatible : "asahi-kasei,ak5558" or "asahi-kasei,ak5552".
> -- reg : The I2C address of the device.
> -
> -Optional properties:
> -
> -- reset-gpios: A GPIO specifier for the power down & reset pin.
> -- AVDD-supply: Analog power supply
> -- DVDD-supply: Digital power supply
> -
> -Example:
> -
> -&i2c {
> -	ak5558: adc@10 {
> -		compatible = "asahi-kasei,ak5558";
> -		reg = <0x10>;
> -		reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.yaml b/Documentation/devicetree/bindings/sound/ak5558.yaml
> new file mode 100644
> index 000000000000..90fd734daeec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.yaml

Missing vendor prefix, so
asahi-kasei,ak5558.yaml

> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ak5558.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AK5558 ADC Device Tree Bindings

drop "Device Tree Bindings"

You dropped few pieces of device description. Why? Also ADC is very
confusing.

> +
> +maintainers:
> +  - Junichi Wakasugi <wakasugi.jb@om.asahi-kasei.co.jp>
> +  - Mihai Serban <mihai.serban@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - asahi-kasei,ak5558
> +      - asahi-kasei,ak5552

Keep them ordered by name.

> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.

Drop description, obvious.

> +
> +  avdd-supply:
> +    description: A 1.8V supply that powers up the AVDD pin.
> +
> +  dvdd-supply:
> +    description: A 1.2V supply that powers up the DVDD pin.
> +
> +  reset-gpios:
> +    maxItems: 1
> +


Best regards,
Krzysztof

