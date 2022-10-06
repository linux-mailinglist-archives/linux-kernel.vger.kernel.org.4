Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B3D5F6AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJFPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 11:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJFPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 11:39:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88039E1A;
        Thu,  6 Oct 2022 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665070592;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=93YZjM5uq6hKPW57tU48yES77lxzaLoqRI5R07/h1E8=;
    b=HLyCBgYUGVGcOZ+VaX76POU1CHqw9g3l9xnTU+9ka2fdaRl1HgXpaBHWKY/cmZxO37
    3mvM1u49oVb0fXQw24WzywhELy1MLKaWI62Nt1lZ9Kskt1DBQ6qbLz5itlLNYIOa8lgG
    7C1ClPQxfiZgAIXFqpz3xRUSttfs/DtZ4h/AJ+VflGyAC6XcLIyXj1q3+3MyX6cdh2al
    buff+UQI76Yptn0IudjAzWfFakY87z4AXHUpwTyBahTuBr04qq/2b6gi4cqgs6lTpUDI
    iQgPXDJDbP/yOA2F/rG16BrVFJ7EbWFpryabSP1xyXnqS131B2PJalQHR28Mrn7+ouOs
    Xa3g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWwvWmtQ=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.3 DYNA|AUTH)
    with ESMTPSA id 06b848y96FaVPyG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 Oct 2022 17:36:31 +0200 (CEST)
Date:   Thu, 6 Oct 2022 17:36:18 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: minor
 style cleanups
Message-ID: <Yz718g8yWxevNI34@gerhold.net>
References: <20221006140637.246665-1-krzysztof.kozlowski@linaro.org>
 <20221006140637.246665-19-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006140637.246665-19-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 04:06:21PM +0200, Krzysztof Kozlowski wrote:
> Drop "binding" from description (and align it with other Qualcomm
> pinctrl bindings), use double quotes consistently and drop redundant
> quotes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for all the cleanup!

FWIW:
Acked-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml           | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> index 9c647e24fa9a..cc6d0c9c5100 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> @@ -10,8 +10,7 @@ maintainers:
>    - Stephan Gerhold <stephan@gerhold.net>
>  
>  description: |
> -  This binding describes the Top Level Mode Multiplexer (TLMM) block found
> -  in the MSM8909 platform.
> +  Top Level Mode Multiplexer pin controller in Qualcomm MSM8909 SoC.
>  
>  allOf:
>    - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> @@ -25,10 +24,10 @@ properties:
>  
>    interrupts: true
>    interrupt-controller: true
> -  '#interrupt-cells': true
> +  "#interrupt-cells": true
>    gpio-controller: true
>    gpio-reserved-ranges: true
> -  '#gpio-cells': true
> +  "#gpio-cells": true
>    gpio-ranges: true
>    wakeup-parent: true
>  
> @@ -39,7 +38,7 @@ required:
>  additionalProperties: false
>  
>  patternProperties:
> -  '-state$':
> +  "-state$":
>      oneOf:
>        - $ref: "#/$defs/qcom-msm8909-tlmm-state"
>        - patternProperties:
> @@ -53,7 +52,7 @@ $defs:
>      description:
>        Pinctrl node's client devices use subnodes for desired pin configuration.
>        Client device subnodes use below standard properties.
> -    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
>  
>      properties:
>        pins:
> -- 
> 2.34.1
> 
