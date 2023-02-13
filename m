Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA96943A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBMK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBMK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:59:21 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA1E6A71
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:59:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id by3so10407420wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNRrH6pVFd2ShQx69BQENhHFCRJ2DJdc/TbT0vWDWBA=;
        b=jcwCUaS5PsaDXY9H+0qskpy7DXmR3b1cP4nVEKDi4Hp/+xm7GVrQJgygVp5xrSOixW
         gDtHSPdrQnfqSPGCUs9crDzyA5P77qCi0pYULDwO+4l/UNW6zU6r3yM2amjpPvK2GOiG
         Gzyq27yRZhOvTd9yRYuyI8lEnkN8Tr0I+ayf2gnp+YBLrLJlFnTApP91LDbhFqjUUet7
         tiHerycM7g19mzYregs+tnn16eHbVNDrB/9FqoueFKnSoKWBYQRnqHmTaGZuY+L7+0VK
         Lt9t/ndiAQSeKWfDbNES/FIvG11bgnUPrHKivfZntyOo94HqL8A9Re4ctfsATcKSwDNK
         MNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNRrH6pVFd2ShQx69BQENhHFCRJ2DJdc/TbT0vWDWBA=;
        b=eXNfjrT4msAKy94d8EEphbKUxxwVH3duXhpiuZ9QO/XV7jB/ALcoC5LEn+ELTd3IAr
         dB6yKVMxMHPV8vPevMf76+fbj4JnHh7+yYC/OYgvl0ajwGlBtadKxzRZ9vSaNCqTpoUZ
         bGcVth3iE/DiM6iKkBGDML8JSWZAnyxv+tHljpfMjLwWQTEQyW+f8xU5l4X71UAj4zne
         vvV4vJU21Gw5Gbd60of9AN79vdkAaQJDqAJyRrx3xQaKj3vY74X5SGOdQuera4C5/RX4
         WM8gh1/AFFeJ7Z89iK1J/EsppdsmtPND/RgFuoCuJRrGs6Z4+Wvc2KtBA5pChx+jIs97
         Jfjw==
X-Gm-Message-State: AO0yUKVMbfkH9eLHcdeXOp263zlrpjNfZ35iFxm9QbvT0wqufhf8OIOE
        OCFglVk4QSGQrK10PN4mtAU9zg==
X-Google-Smtp-Source: AK7set9EKm+ljNDXO8rry/RYjZUYrLXSN+ZaRUUJFfk9J3sel0OVnXraCoS/B6pbcDZ/GaRn+sG7Tg==
X-Received: by 2002:adf:fcc1:0:b0:2c3:f78f:518f with SMTP id f1-20020adffcc1000000b002c3f78f518fmr18003290wrs.39.1676285958566;
        Mon, 13 Feb 2023 02:59:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h12-20020adff4cc000000b002be505ab59asm10354062wrp.97.2023.02.13.02.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:59:18 -0800 (PST)
Message-ID: <10ddd574-3ad1-f2e7-e7b4-a6803ee240d6@linaro.org>
Date:   Mon, 13 Feb 2023 11:59:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/6] dt-bindings: soc: amlogic: document System Control
 registers
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
 <20230209-b4-amlogic-bindings-convert-take2-v1-3-c4fe9049def9@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-3-c4fe9049def9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 14:41, Neil Armstrong wrote:
> Document the System Control registers regions found on all Amlogic
> SoC families and it's clock, power, pinctrl and phy subnodes.
> 
> The regions has various independent registers tied to other
> hardware devices, thus the syscon compatible.
> 
> Clock controllers and Pinctrl devices are not yet documented, the
> definition of those will be updated in a second time.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
> new file mode 100644
> index 000000000000..672eabd90c09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic Meson System Control registers
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - amlogic,meson-gx-hhi-sysctrl
> +          - amlogic,meson-gx-ao-sysctrl
> +          - amlogic,meson-axg-hhi-sysctrl
> +          - amlogic,meson-axg-ao-sysctrl
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-controller:
> +    type: object
> +
> +  power-controller:
> +    $ref: /schemas/power/amlogic,meson-ee-pwrc.yaml
> +
> +  pinctrl:
> +    type: object
> +
> +  phy:
> +    type: object
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-gx-hhi-sysctrl
> +            - amlogic,meson-axg-hhi-sysctrl
> +    then:
> +      required:
> +        - power-controller
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-gx-ao-sysctrl
> +            - amlogic,meson-axg-ao-sysctrl
> +    then:
> +      required:
> +        - pinctrl
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - amlogic,meson-axg-hhi-sysctrl
> +    then:
> +      properties:
> +        phy:
> +          oneOf:
> +            - $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
> +            - $ref: /schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml

And all other variants? This allows phy/power/pinctrl/clock in any
combination, thus maybe the binding should be just split? Hard to say
without full picture.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clock-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sysctrl: system-controller@0 {
> +        compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
> +        reg = <0 0x400>;
> +
> +        clock-controller { };

The example should be complete, so empty node does not look correct. If
you wait for other bindings, send them as patchset when all are ready.

Best regards,
Krzysztof

