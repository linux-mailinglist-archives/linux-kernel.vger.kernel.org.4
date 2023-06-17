Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357D3733FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjFQIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbjFQIgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:36:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA4268C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:36:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51a21185130so1979039a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686990981; x=1689582981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHSYSNvoBVsWeKTwLcfed1isjXKsHWPqmDjZM1uywnc=;
        b=ELCUwlv7eHCsjHT2e/KCHBZHeJXgNNz5OUDq7/rGvV4alwVrtL10H6hqhknOVkR8zP
         1RhI5VQlC47kohbjZrAMH2Wu6hAPxpsIeyNBKrQF+paldtTvMWxBeJFJ2xgQL0nGDn6h
         Bh7bpMM9cTOKw2XlWLxT3RJGddNpdbYoIqdeEEhvCKN/Aa5Bo17/88rqvzwKllGvECIi
         JiptROrS31G4y2TY/f7EYREizkJ4X3BXbNa8B0p2WV++Dt56LfmcVacn31xFrjBa4fdi
         ksA8JFMUh+1mcbFJ8rMww5wD5jOM/ZMsCLWygMEqgTmxO8QlT6ZFeQJKvlJ2K580UqQ3
         iV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686990981; x=1689582981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHSYSNvoBVsWeKTwLcfed1isjXKsHWPqmDjZM1uywnc=;
        b=dOg/iqK+bpxOaDBW01f1wbbJtOrPxTp4GoTzIRh2cUK1hGt1pG+vtrZhxFPFBr+oun
         PPtiQXrCKDgX8yeq9t5T5QpR1enuWJEbw+F581twqP1tPEx5VwBVetkqQ/EDHNBJ8tkO
         1ONLOvQPqskhwTNLgBSb28x91aCtFzFY9HGdLrVFlmkE05HTrTJvAIuSSuIKaPXzuibp
         JFgGCqHZOV9xc9bRn2RNKPKwzXMUGpSSpava+iUk1Ud5lScCcLXgA+f4CWjJk+Dqvor+
         kc5f/FZ9AM0pY3lmbSToa9TilBrrXJnZHzbHtNhBvHbb0QYUtubJRbKwRi9tX+UHTGUh
         Roow==
X-Gm-Message-State: AC+VfDy74tfqW4gNovzC6eXdbZ6/QzvtB0nEet1xyoPzJu73kTMBVvsU
        0UPaEoseet8NQbiS0l752y0qfg==
X-Google-Smtp-Source: ACHHUZ5LBmphkId8rgr4BiqRLQLQW4t4MG9F7heylFznAVSq8CDhg+7sf8XXFBKu+MR1wcEriZnBpA==
X-Received: by 2002:a17:907:36c7:b0:978:ac42:5ef5 with SMTP id bj7-20020a17090736c700b00978ac425ef5mr3807707ejc.65.1686990981162;
        Sat, 17 Jun 2023 01:36:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gt7-20020a170906f20700b00988168ed20asm33146ejb.185.2023.06.17.01.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:36:20 -0700 (PDT)
Message-ID: <90f802db-79cc-010a-9a83-c7bdbf0d0c00@linaro.org>
Date:   Sat, 17 Jun 2023 10:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 3.0 PHY
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230614092850.21460-1-stanley_chang@realtek.com>
 <20230614092850.21460-5-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614092850.21460-5-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 11:28, Stanley Chang wrote:
> Add the documentation explain the property about Realtek USB PHY driver.
> 
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the  USB 3.0 PHY transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v3 to v4 change:
>     1. Remove the parameter and non hardware properties from dts.
>     2. Using the compatible data included the config and parameter
>        in driver.
> v2 to v3 change:
>     1. Broken down into two patches, one for each of USB 2 & 3.
>     2. Add more description about Realtek RTD SoCs architecture.
>     3. Removed parameter v1 support for simplification.
>     4. Revised the compatible name for fallback compatible.
>     5. Remove some properties that can be set in the driver.
> v1 to v2 change:
>     Add phy-cells for generic phy driver
> ---
>  .../bindings/phy/realtek,usb3phy.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> new file mode 100644
> index 000000000000..0f849cf942e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/realtek,usb3phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC SoCs USB 3.0 PHY
> +
> +maintainers:
> +  - Stanley Chang <stanley_chang@realtek.com>
> +
> +description:
> +  Realtek USB 3.0 PHY support the digital home center (DHC) RTD series SoCs.
> +  The USB 3.0 PHY driver is designed to support the XHCI controller. The SoCs
> +  support multiple XHCI controllers. One PHY device node maps to one XHCI
> +  controller.
> +
> +  RTD1295/RTD1619 SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on some
> +  controllers.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +
> +  RTD1319/RTD1619b SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each XHCI maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#2.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +
> +  RTD1319d SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each xhci maps to one USB 2.0 PHY and map one USB 3.0 PHY on controllers#0.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +                    |- usb3phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - realtek,rtd1295-usb3phy
> +          - realtek,rtd1319-usb3phy
> +          - realtek,rtd1319d-usb3phy
> +          - realtek,rtd1619-usb3phy
> +          - realtek,rtd1619b-usb3phy
> +      - const: realtek,usb3phy

Drop last compatible, it is not used now. Does not make sense.

> +
> +  reg:
> +    description: PHY data registers

Drop description, it's obvious.

> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  nvmem-cells:
> +    maxItems: 1
> +    description: A phandle to the tx lfps swing trim data provided by
> +      a nvmem device, if unspecified, default values shall be used.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: usb_u3_tx_lfps_swing_trim
> +
> +  realtek,amplitude-control-coarse-tuning:
> +    description:
> +      This adjusts the signal amplitude for normal operation and beacon LFPS.
> +      This value is a parameter for coarse tuning.
> +      For different boards, if the default value is inappropriate, this
> +      property can be assigned to adjust.

default:

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255
> +
> +  realtek,amplitude-control-fine-tuning:
> +    description:
> +      This adjusts the signal amplitude for normal operation and beacon LFPS.
> +      This value is used for fine-tuning parameters.
> +    $ref: /schemas/types.yaml#/definitions/uint32

default:

> +    minimum: 0
> +    maximum: 65535
> +


Best regards,
Krzysztof

