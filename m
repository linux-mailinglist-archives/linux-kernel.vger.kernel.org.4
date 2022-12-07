Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC07645D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLGPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLGPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:13:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E0C5FBA3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:13:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so29111895lfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwuV0n2FcadO46u8mq+gLHcFjCqs4mgvgde47beSgFk=;
        b=ZvS9jSQhUfL8WcXq/TxjyksIXloX15Ag5b6M8G03A1zo4+dvHKYj8t3a8r40mu0zUD
         M2UVP7NtSB1bzo/jAucazJWb/W/54+/U+mC//YqsA4AmlQQgsTPeaF2bp/Q2fzsI6OGT
         imkn5Y7HbXYKqZf1tA1kLjtpHdJIjCJx0GR9ufvTcuUfWjPhtUsrAOAgjoC70cQ37dZ/
         Wa3Yk2L8Z1SS5cojk6pU9smxwWQ4hJi5nEVC96MZgjOzjP4wegHIg4v1q1KuNEkEu59Y
         66Pb14vJxPITtwp8AGoKMUfUE7+wLmUIaLW+5uIIxpzwIoroodtdFUuONVOwugpDCrol
         xmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwuV0n2FcadO46u8mq+gLHcFjCqs4mgvgde47beSgFk=;
        b=CFGsszy2Ica+PU9b+ypS8bh++e+qquhvkejQ8OigGb+ZZ47PLRYI4OK5YaekJaok+L
         lkvyo1z6Q32TnaJ3UgTNWz8KBnr7VazhchecSqcEYGzNNejF6STndm7EiIBKmPfXjbRv
         hJp6Ap7knzfu7E104jESpgdZboq6faqPxFpnUfqj7jnyPfVX2GmYQ3jqskvBNFVpqa0/
         oduBuDcN4CW3Iqqg+yWWE224ueOoHBuP2QrAeRANlhNwLyMpep9fTa7fAJrV83qT08av
         fWPMwz4IzikM+Rxv4HtmhqoUTs7Ommz+oSbWfTgBbTc9sQ0xlncLhUkP2tsq4U9wGvr6
         +hWA==
X-Gm-Message-State: ANoB5pnujBxtjpDvQ/sQ6RSW46utgMBHJfSSPEILankQYPnuDcpewfvb
        ySa9Eb6223LkqV5Yk0Uq9K7Q+Q==
X-Google-Smtp-Source: AA0mqf7H/u1TTdUDubpP4RFHzJ+Z6dInp9jhB+5+WVPVTc4JVsGKqJfFgAD2IAyI7TXnhs+eSOZW8A==
X-Received: by 2002:a05:6512:3454:b0:4b5:8240:5bcb with SMTP id j20-20020a056512345400b004b582405bcbmr3082136lfr.388.1670425987664;
        Wed, 07 Dec 2022 07:13:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi27-20020a0565120e9b00b004aac23e0dd6sm2893718lfb.29.2022.12.07.07.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:13:07 -0800 (PST)
Message-ID: <d7ecbbbf-5d6b-3254-b645-dbea369447ae@linaro.org>
Date:   Wed, 7 Dec 2022 16:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207131731.1291517-2-william.qiu@starfivetech.com>
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

On 07/12/2022 14:17, William Qiu wrote:
> Add documentation to describe StarFive
> designware mobile storage host controller driver.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../bindings/mmc/starfive,jh7110-sdio.yaml    | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml b/Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
> new file mode 100644
> index 000000000000..4f27ef3cf4f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/starfive,jh7110-sdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive Designware Mobile Storage Host Controller
> +
> +description:
> +  StarFive uses the Synopsys designware mobile storage host controller
> +  to interface a SoC with storage medium such as eMMC or SD/MMC cards.
> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"

Drop quotes

> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-sdio

Why do you call it sdio if the interface is for mmc as well?

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: biu clock
> +      - description: ciu clock

I don't think the card interface clock is optional... are you sure you
have designs working without it? No clock line at all getting to the memory?

> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: biu
> +      - const: ciu
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  starfive,sys-syscon:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      The desired number of times that the host execute tuning when needed.

That's not matching the property name. Missing number of items... this
is anyway confusing. Why number of tuning tries is a property of DT?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7110.h>
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +    mmc@16010000 {
> +            compatible = "starfive,jh7110-sdio";

Use 4 spaces for example indentation.

> +            reg = <0x16010000 0x10000>;
> +            clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> +                 <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;

Align with previous <

Best regards,
Krzysztof

