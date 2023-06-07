Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039D4725E09
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbjFGMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbjFGMIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:08:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD61BD9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:08:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-977ed383b8aso451903766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686139707; x=1688731707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbaSkFKmaWWmmIo4d8BONfqm4x6XM3okcFS76p+73tg=;
        b=FEG1BYoo8Gc5j9aQwAjfWG9KitjRYTgwv1Kfs37ouE2LD1ua/BNeojlIoCjZW/xsr7
         f/h1myCX7DcDNAhxluIFyAsI2QYCc14LIqJR2czEQ4+EmbGLk3PtU7Vw2bvkQPmXIqQa
         CM3AKS6NtBrI7l6FaxKKYclKc31pgppf9+rjh891gPb9pVXqSZdS7d1XQxGfPwOkTqjm
         1BFJ52JM87NCorGvZhtEZpXF07YvGjTDmLYfdFICFE/DatCZGQ1Z6wAAOve0aCzvE1oO
         Q92l+GKSjXp3+sLGgFzEOfdGIyXcW/zZRHFAW45kN7bXm+TWiTeNlPwh0nFlLC1E1mCl
         t26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686139707; x=1688731707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbaSkFKmaWWmmIo4d8BONfqm4x6XM3okcFS76p+73tg=;
        b=KLWUrEVKArcgDyRjUpMAkGfpNjolf/gwrLUpjxRhXlqw0HqnrVVWVWzJsre6srV7uI
         ykDOTHIrul69Qjp/dNRrdoILI6hNr5QdWD6obnjuhvORr1oDJ3uEVBOwwCnDAh8otmV9
         V2G4odUHiGgSjvUVmZsiJi6lbsR0LowmFBdUVNZw0IilNLR+UiKPl8irvVbIdNMNlI+t
         SPqzTt1STjVanvMdiUOdIph/KQqYMtzabBUu/CWaWdG4P5Cf5Q67/g4Itfzf85aw3p92
         5bQ9aCOI4sgph4m8ABl0okq480fVSSF4QZHLfR6p7DtxPfEEOVlfFc5q6L7OH1tancAL
         CfLQ==
X-Gm-Message-State: AC+VfDwzDJy5ZPLFx6KH5kzDzFhnGptZBy05HIP2Zk6gOYEPRtDcWXwu
        m78m9GzLPjoSsZA+FYeDmkVf3Q==
X-Google-Smtp-Source: ACHHUZ5vKpxtUxSkt4XRhTjs7/kmyFaEHLXlF0ZmCITH6qGYltllIooFFN4Apbf+De6gz2h6l5NazQ==
X-Received: by 2002:a17:907:7252:b0:976:509a:2b57 with SMTP id ds18-20020a170907725200b00976509a2b57mr5038137ejc.47.1686139706726;
        Wed, 07 Jun 2023 05:08:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7c155000000b0051421010690sm6019611edp.21.2023.06.07.05.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 05:08:26 -0700 (PDT)
Message-ID: <58aea31d-8f47-a558-6e17-17b55059bb23@linaro.org>
Date:   Wed, 7 Jun 2023 14:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 5/5] dt-bindings: phy: realtek: Add the doc about the
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
        Ray Chi <raychi@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-5-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607062500.24669-5-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:24, Stanley Chang wrote:
> Add the documentation explain the property about Realtek USB PHY driver.
> 
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the  USB 3.0 PHY transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v2 to v3 change:
>     1. Broken down into two patches, one for each of USB 2 & 3.
>     2. Add more description about Realtek RTD SoCs architecture.
>     3. Removed parameter v1 support for simplification.
>     4. Revised the compatible name for fallback compatible.
>     5. Remove some properties that can be set in the driver.
> v1 to v2 change:
>     Add phy-cells for generic phy driver
> ---
>  .../bindings/phy/realtek,usb3phy.yaml         | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> new file mode 100644
> index 000000000000..b45c398bba5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/realtek,usb3phy.yaml
> @@ -0,0 +1,156 @@
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
> +  RTD1395 SoCs USB
> +  The USB architecture includes two XHCI controllers.
> +  The controller#0 has one USB 2.0 PHY. The controller#1 includes two USB 2.0
> +  PHY.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +                               |- phy#1

Skip unrelated devices.

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
> +  RTD1312c/RTD1315e SoCs USB
> +  The USB architecture includes three XHCI controllers.
> +  Each XHCI maps to one USB 2.0 PHY.
> +  XHCI controller#0 -- usb2phy -- phy#0
> +  XHCI controller#1 -- usb2phy -- phy#0
> +  XHCI controller#2 -- usb2phy -- phy#0
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - realtek,rtd1295-usb3phy
> +          - realtek,rtd1619-usb3phy
> +          - realtek,rtd1319-usb3phy
> +          - realtek,rtd1619b-usb3phy
> +          - realtek,rtd1319d-usb3phy

Same comments as for previous patch.

> +      - const: realtek,usb3phy
> +
> +  reg:
> +    description: PHY data registers
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  "#phy-cells":
> +    const: 0

1 phy or 4? Decide.

> +
> +patternProperties:
> +  "^phy@[0-3]+$":
> +    description: Each sub-node is a PHY device for one XHCI controller.
> +    type: object
> +    properties:
> +      realtek,param:
> +        description: The data of PHY parameter are the pair of the
> +          offset and value.
> +        $ref: /schemas/types.yaml#/definitions/uint8-array

Your choice of types is surprising. If this is array, than maxItems (and
please don't tell me it is maxItems: 1). Anyway, why 8 bits long?

> +
> +      realtek,do-toggle:
> +        description: Set this flag to enable the PHY parameter toggle
> +          when port status change.
> +        type: boolean
> +
> +      realtek,do-toggle-once:
> +        description: Set this flag to do PHY parameter toggle only on
> +          PHY init.
> +        type: boolean
> +
> +      realtek,check-efuse:
> +        description: Enable to update PHY parameter from reading otp table.
> +        type: boolean
> +
> +      realtek,use-default-parameter:
> +        description: Don't set parameter and use default value in hardware.
> +        type: boolean
> +
> +      realtek,check-rx-front-end-offset:
> +        description: Enable to check rx front end offset.
> +        type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    usb_port2_usb3phy: usb-phy@13e10 {
> +        compatible = "realtek,rtd1319d-usb3phy", "realtek,usb3phy";
> +        reg = <0x13e10 0x4>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        #phy-cells = <0>;
> +
> +        phy@0 {
> +            reg = <0>;
> +            realtek,param =
> +                    <0x01 0xac8c>,
> +                    <0x06 0x0017>,

First, this is matrix, not uint8 array. Second, 0xac8c is past 16 bits
long, not 8. Third, you put some magic register programming to DT.
Please don't. Drop all this from DT.


Best regards,
Krzysztof

