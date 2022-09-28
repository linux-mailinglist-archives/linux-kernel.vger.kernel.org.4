Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543325EE3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiI1SFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiI1SFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 14:05:15 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F1D7AC36;
        Wed, 28 Sep 2022 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664388308;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6ww6vEm2Ci8TeM1f1oxHc+4j/zU9WsPV4VXaGwkCDa8=;
    b=sSejvT8OYastO5cXoMEf5gxUVNyboP2C+TX2mTeSIcFyt5Av2JKbOrMsGLHlvsIkj2
    ncF9bEBBd/QPvULA91ZsOi6ydbVULxGp6FQ1vu/rHST9JV5LCLk3G3M8ilsOUyq0E+hs
    RnjdSUjKJXsbYUGa1F0Vs9qY36r7Ye4PJjPaCQa7oOYqMhJkh4IRtMLZc/PNYMAu2Y6U
    Jhva7F7w8L9d2O2tl5eerrA6UC0hzOmIm0xwzdeQ6vEgxcL4coAsC+/FoubqXyFTt51J
    2WIYKH6c5k26fmPRBPdhTRdR5JLlhQM+rDiraDGWvnXp5xX9TKTK7z5ZlEY+VRZ1kMer
    eYaw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK88/6Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.3 AUTH)
    with ESMTPSA id 06b848y8SI580jR
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 28 Sep 2022 20:05:08 +0200 (CEST)
Date:   Wed, 28 Sep 2022 20:04:57 +0200
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
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/34] dt-bindings: pinctrl: qcom,tlmm-common: add
 common check for function
Message-ID: <YzSMlGXIIXvAR5He@gerhold.net>
References: <20220927173702.5200-1-krzysztof.kozlowski@linaro.org>
 <20220927173702.5200-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173702.5200-8-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 07:36:35PM +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.  Add a check for this in common Qualcomm TLMM pin
> controller schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Thanks for moving this to the common schema!

FWIW:
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  .../bindings/pinctrl/qcom,tlmm-common.yaml    | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
> index c88c8dcb69d9..e1354f0c64f8 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
> @@ -65,10 +65,6 @@ additionalProperties: true
>  
>  $defs:
>    qcom-tlmm-state:
> -    allOf:
> -      - $ref: pincfg-node.yaml#
> -      - $ref: pinmux-node.yaml#
> -
>      properties:
>        drive-strength:
>          enum: [2, 4, 6, 8, 10, 12, 14, 16]
> @@ -82,5 +78,21 @@ $defs:
>        output-high: true
>        output-low: true
>  
> +    allOf:
> +      - $ref: pincfg-node.yaml#
> +      - $ref: pinmux-node.yaml#
> +
> +      - if:
> +          properties:
> +            pins:
> +              items:
> +                pattern: "^gpio"
> +        then:
> +          required:
> +            - function
> +        else:
> +          properties:
> +            function: false
> +
>      additionalProperties: true
>  ...
> -- 
> 2.34.1
> 
