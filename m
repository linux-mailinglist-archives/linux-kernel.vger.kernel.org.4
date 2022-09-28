Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3101C5EE3F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiI1SLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbiI1SK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:10:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BB186731;
        Wed, 28 Sep 2022 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664388472;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=VTSVj2/MnOzJogQVqPNRuV3EWW6q3oME4cKoVN1IPfA=;
    b=HIE0nrnl86PcacEc+gjvo/s+CmKFJ2DK60CZI9HqR74aX5VXWA/6gfj5IE/HRcLGOt
    GbSjkT359x0MuY8AcAe5QETxWkV35dpn7/34UfK/t8kZq2I2PKwgkTU9LDYMVEsceSBa
    f652Bmv8FjrEP/EmPkQwmGfJfcSU6iLLVtUnmFqiGf5LxEb1QpZZJ1rbuAaEN8NDgwvy
    BvkiLJh+tCIDeW7SEF3+Wa1c+8txl1eoUyFHlglQIWPXB+wvxB5YPGF17kmUmRJPugLa
    f/lK8E5g2SxLTDcRw0pdBJrGvZ9olxQkZGjaURFqN/H7rxkdyxR7ZRCSJCIqqdvSMCCh
    sPiA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK88/6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id 06b848y8SI7p0jv
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Sep 2022 20:07:51 +0200 (CEST)
Date:   Wed, 28 Sep 2022 20:07:50 +0200
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
Subject: Re: [PATCH v3 18/34] dt-bindings: pinctrl: qcom,msm8909-tlmm: fix
 matching pin config
Message-ID: <YzSNdpvVkWEDSdu1@gerhold.net>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-19-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-19-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:36:46PM +0200, Krzysztof Kozlowski wrote:
> The TLMM pin controller follows generic pin-controller bindings, so
> should have subnodes with '-state' and '-pins'.  Otherwise the subnodes
> (level one and two) are not properly matched.  This method also unifies
> the bindings with other Qualcomm TLMM and LPASS pinctrl bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml     | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> index e03530091478..b1735918fa90 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> @@ -43,8 +43,9 @@ patternProperties:
>      oneOf:
>        - $ref: "#/$defs/qcom-msm8909-tlmm-state"
>        - patternProperties:
> -          ".*":
> +          "-pins$":
>              $ref: "#/$defs/qcom-msm8909-tlmm-state"
> +        additionalProperties: false
>  
>  $defs:
>    qcom-msm8909-tlmm-state:
> @@ -136,13 +137,13 @@ examples:
>                  };
>  
>                  uart-w-subnodes-state {
> -                        rx {
> +                        rx-pins {
>                                  pins = "gpio4";
>                                  function = "blsp_uart1";
>                                  bias-pull-up;
>                          };
>  
> -                        tx {
> +                        tx-pins {
>                                  pins = "gpio5";
>                                  function = "blsp_uart1";
>                                  bias-disable;
> -- 
> 2.34.1
> 
