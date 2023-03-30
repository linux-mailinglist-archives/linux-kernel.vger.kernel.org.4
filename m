Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3596CFFB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjC3JT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjC3JTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:19:49 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF861725
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:19:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so11267850wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 02:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680167983;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CbeX3b3mkNU5KCreV7qGDGfkWXIVSy5iikXXRCofrt4=;
        b=Em1thZ80LnmvFydE9lDwXBYXKGD1PpQp8O4whHafhmwL1rSD+XG2INd+ggxm69Wn9e
         Ez3mwMf6WpDIjytF1hucvi1yCzgFfE2O0W2NJqfm2G0XcmqGgvm1VPydx6jtLqrCdYqn
         90bH5eFlz12AAvp2XbDSYeV3mHiLzqKXiN3TcxDwuuQ+NTAe8KTCirNZ2aRREpmEaM5q
         JapCiyEACTmL9aGOlMB6ak75/t3fmtUMqgGO81wOomxCKIVe4shZspy0OP7OGGICG2Mg
         gp28vNO0nxZHXerkyoNWLfvQVR8DStz23RQV2xo2Yfj1X4UqjssAlQjYK7hNxHnskdMq
         3yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680167983;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbeX3b3mkNU5KCreV7qGDGfkWXIVSy5iikXXRCofrt4=;
        b=eoaOLBvnGX+D5d/wkuEBRknBKDEVi7HsmY0gpExDhCts8NR0j58g0Xi5Jxpc1WBEdS
         NdPaqt8p96G+jOf2adZKHTkY0QN3HHSL4Wj+k5L88g2NPKCQYt0muY329ozT4Joh40dp
         lcalzn/lLoUWml1t6FBdZ1zzVWOd8n+FVDPS46vLRysdSY7tdZXuZlmvjZoTjkRNr/xa
         V3ehRWoV7PE6TCsxtHUpoE2l9goiNWfVmqk1KFTz3/FjjghoiteDfFxL3vyKQ2njq7uo
         QGoOgVj5TD9Zti2cVfJP+CfS+Mrc80VgxS+ker3pHr7/oJA+aefmIpR+1T1cuQyhjMsy
         Sluw==
X-Gm-Message-State: AAQBX9dV4Q4u4cjtgQaS4rcykEFp1D5GgQHEU7tdSSrBb6EdPfwKOt31
        W7VAbZHWRX+6cJUQcFGgFSf3bQ==
X-Google-Smtp-Source: AKy350bWernDSucGomHC3DsmFroBEfGa1UdA19ER598biAVvnw/YlqWmIh9FqC7BItHOIFjpzaGtmg==
X-Received: by 2002:a05:600c:b49:b0:3ef:5fe3:c57c with SMTP id k9-20020a05600c0b4900b003ef5fe3c57cmr15666956wmr.23.1680167983346;
        Thu, 30 Mar 2023 02:19:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f? ([2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c220f00b003ef5f77901dsm5055067wml.45.2023.03.30.02.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:19:43 -0700 (PDT)
Message-ID: <9c8e9516-8297-3eb9-2682-5de9b089ac85@linaro.org>
Date:   Thu, 30 Mar 2023 11:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: add Amlogic Meson A1 SPI
 controller
Content-Language: en-US
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230327211351.686831-1-mmkurbanov@sberdevices.ru>
 <20230327211351.686831-2-mmkurbanov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230327211351.686831-2-mmkurbanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/03/2023 23:13, Martin Kurbanov wrote:
> Add YAML devicetree Amlogic Meson A113L (A1 family) SPIFC Driver.
> 
> This patch has dependencies on the A1 clock series which is still under
> review - https://lore.kernel.org/all/20230321193014.26349-1-ddrokosov@sberdevices.ru/
> 
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> ---
>   .../bindings/spi/amlogic,meson-a1-spifc.yaml  | 42 +++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml

I think it's time to drop "Meson" from bindings, please drop Meson here and in all the file
down to the compatible which should be "amlogic,a1-spifc"

> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
> new file mode 100644
> index 000000000000..d2b1c754a6e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-a1-spifc.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/amlogic,meson-a1-spifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson A1 SPI Flash Controller
> +
> +maintainers:
> +  - Martin Kurbanov <mmkurbanov@sberdevices.ru>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amlogic,meson-a1-spifc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/amlogic,a1-clkc.h>
> +    spi@fd000400 {
> +        compatible = "amlogic,meson-a1-spifc";
> +        reg = <0xfd000400 0x290>;
> +        clocks = <&clkc_periphs CLKID_SPIFC>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };

Drop the include and use fake label phandles instead.

Thanks,
Neil

