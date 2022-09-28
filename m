Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3700A5EE3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbiI1SJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiI1SJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:09:53 -0400
X-Greylist: delayed 115 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 11:09:50 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1F3640C;
        Wed, 28 Sep 2022 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664388585;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CUA1rKZXJjH54FeXOtkdOiT6Q4YsuptFxBFMyFhbLR0=;
    b=a7Wt+nCBJ5q2lfYoM/Rq6xPcAC/iYv+pjlRZ2vQnzMexLoEe1W2YEQLHjeNiuWTFpG
    1jM6hSGi6+MyWbp7Wsy0hjzaXyzn0FxBgVXPZV1TaVsXDLBDs29pU9upz4rDIpiynH0e
    xbXOEYUYSz3f4ZaUdXPzlxkpfBCjGcPBDmZmP5I0cb/PcWlAiFyM0v2NZJmJCvY0NTXG
    40pqzWyQKJiWIYVvL0Y1CeeQv0tEBV9z8o26HoJ8hlfOooEec/qKAPxABXFRw0Uh4lDD
    IYYNhhoZH+oApLR3TVkXgFx9Qzz4vsCZRURJuuyFgzuyArW9ovE66NDnSzLMYw5WmSd1
    kdIA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK88/6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id 06b848y8SI9j0kC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Sep 2022 20:09:45 +0200 (CEST)
Date:   Wed, 28 Sep 2022 20:09:44 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix
 indentation in example
Message-ID: <YzSN6KsMZiq5gEza@gerhold.net>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-21-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-21-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:36:48PM +0200, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 60 +++++++++----------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> index 08e2dd5cbebe..9c647e24fa9a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> @@ -118,35 +118,35 @@ $defs:
>  
>  examples:
>    - |
> -        #include <dt-bindings/interrupt-controller/arm-gic.h>
> -
> -        pinctrl@1000000 {
> -                compatible = "qcom,msm8909-tlmm";
> -                reg = <0x1000000 0x300000>;
> -                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> -                gpio-controller;
> -                #gpio-cells = <2>;
> -                gpio-ranges = <&tlmm 0 0 117>;
> -                interrupt-controller;
> -                #interrupt-cells = <2>;
> -
> -                gpio-wo-subnode-state {
> -                        pins = "gpio1";
> -                        function = "gpio";
> -                };
> -
> -                uart-w-subnodes-state {
> -                        rx-pins {
> -                                pins = "gpio4";
> -                                function = "blsp_uart1";
> -                                bias-pull-up;
> -                        };
> -
> -                        tx-pins {
> -                                pins = "gpio5";
> -                                function = "blsp_uart1";
> -                                bias-disable;
> -                        };
> -                };
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pinctrl@1000000 {
> +        compatible = "qcom,msm8909-tlmm";
> +        reg = <0x1000000 0x300000>;
> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&tlmm 0 0 117>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        gpio-wo-subnode-state {
> +            pins = "gpio1";
> +            function = "gpio";
>          };
> +
> +        uart-w-subnodes-state {
> +            rx-pins {
> +                pins = "gpio4";
> +                function = "blsp_uart1";
> +                bias-pull-up;
> +            };
> +
> +            tx-pins {
> +                pins = "gpio5";
> +                function = "blsp_uart1";
> +                bias-disable;
> +            };
> +        };
> +    };
>  ...
> -- 
> 2.34.1
> 
