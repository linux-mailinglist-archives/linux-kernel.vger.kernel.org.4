Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65560FC62
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbiJ0Pwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiJ0Pwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:52:47 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9B4192DA8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:52:41 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id m6so1248200qkm.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gIoXxiDmfLBwHjIKOLcfrxpt8ArE5iNwkoMZ1If8W0=;
        b=nKQA1LYfKxriWZ9VvH4IRAzSzXZpDjetbvw6Mb0yTTAuBBjXbGKaOOpY3TF6R+B+sO
         qPsi7jAPz1Xy0qZMrpZay0ch2wE/iqkXzGlh9JmKNfeWAnEPZJFPiCgTRRriZbRqT3iF
         c0Uvc0GXPvacdv5Ut3KtsVnod9NbvzPloug1graWwscVQZSsKiUo5NEhFGTH3lbEpvK4
         GExnUdbaI4fMxapMW9ndrnSJBt276TGOGmBFoFeppyPUkgHYaoLPcDTMuIF3XFrQq7i3
         iXq43/5wIDdL0Cs8Ss7v0P0Lqk9XQkOtXKGy3Jz/IQ6UbmgJGt1NMe3DhAvUNF1KESIK
         sNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gIoXxiDmfLBwHjIKOLcfrxpt8ArE5iNwkoMZ1If8W0=;
        b=y91xZe7sUAOL+FNYDZ5tEAxLXWbMUpIwowrIAeas1s/kVkVBA0rHILghrAdVFz0Yl7
         Za+x5BbxplqzZG7HKb5YszZiTGIFxN71KD1nNP86hRla+kTjBqiUPRV7cEnKuqRBGXXZ
         1L32LIxTiMpZGDeBxhU1MU2E3+M82WtGdfhJlGAx1o6i6OjU0r+qDa8yRZpvWHYeqwL/
         Es69vcPATNLho4cp73etw2lL9QsFjijcSWzpnjunK29tWtNdrDlbRDG0yg8VFf3o6DxW
         obHJ7r/yVKOOHLkRcJZZ5DHEytyaheriJ2Ecn0dAj9KdYc0eTIoN124tlAnACf+h/og7
         rKOA==
X-Gm-Message-State: ACrzQf1fU8ZEuxBrwyK0OQ042SLhnNgPf4dq5QuqEivrgszuEWWiGLxF
        YK5EG5gVFBY0yQ9xBBsZb2P5GLms9J72eQ==
X-Google-Smtp-Source: AMsMyM69+ighMCJFVZ5PyILef6TBCOJVDKpNzjTR4VbSGgNOa7WUffx36huom6eVW9hFG1DTA1W7vw==
X-Received: by 2002:a05:620a:17a9:b0:6ee:e098:b2c7 with SMTP id ay41-20020a05620a17a900b006eee098b2c7mr6601418qkb.113.1666885960753;
        Thu, 27 Oct 2022 08:52:40 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y27-20020a37f61b000000b006cf19068261sm1139776qkj.116.2022.10.27.08.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 08:52:40 -0700 (PDT)
Message-ID: <37c53d8c-2810-509a-7404-7ca24d79fed8@linaro.org>
Date:   Thu, 27 Oct 2022 11:52:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221026190457.4003037-1-quic_molvera@quicinc.com>
 <20221026190457.4003037-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026190457.4003037-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 15:04, Melody Olvera wrote:
> Add documentation details for device tree bindings for QDU1000 and QRU1000
> TLMM devices.

Just "Add Devicetree bindings for QDU1000 and QRU1000 TLMM devices."

Subject - drop redundant second bindings.

> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> new file mode 100644
> index 000000000000..a2ca4d59e2e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block (TLMM) found

Drop "This binding describes"

IOW, just take a peak at current bindings in next.


> +  in the QDU1000 and QRU1000 platforms.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:

No items.

> +      - const: qcom,qdu1000-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  "#interrupt-cells": true
> +  gpio-controller: true
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 75
> +
> +  gpio-line-names:
> +    maxItems: 151
> +
> +  "#gpio-cells": true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-qdu1000-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-qdu1000-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-qdu1000-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"

This is not fixed.

> +            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
Best regards,
Krzysztof

