Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A425E9393
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiIYOGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiIYOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:06:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD9286F7;
        Sun, 25 Sep 2022 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1664114411;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y4Fvb9tFgDidWGuwba+gD4vi++BPYzS+rjY1SrTWt8M=;
    b=AEoxGvubdnYyLAIj4WH2a4LrXLrN95SyJ55FQXn2hx6lxdtg+qW/veoO6MyS6XVBKK
    WFjt1YBpDE1JaFhdZbdjlvhG00HCGs51TvVxibl5B5yNLWZtRnt/AfROT5x0JjcIMlR4
    tMMyJckPlJCoxKF3Nx7jPaWLM8kM8koslnUDOtY4n+YonlMG6LIRZIGIjreMmzs819Ym
    vj90qO5/i4PMOY9b5FQCKkHunPQaSx71D0c+5RnFsHWC89NGhPEgde8mZ9pexKbBYJUs
    +f4X1QCSOnq2910pycKvJcw3zovlYjMXEtp/y99muEt1Zd/tHTOdzE7D0RAw3FA7qZXK
    co2A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 48.1.1 AUTH)
    with ESMTPSA id dde14cy8PE0B5Wh
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 25 Sep 2022 16:00:11 +0200 (CEST)
Date:   Sun, 25 Sep 2022 16:00:04 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/32] dt-bindings: pinctrl: qcom,msm8909-tlmm: do not
 require function on non-GPIOs
Message-ID: <YzBe5NdhGqR+2bxN@gerhold.net>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
 <20220924080459.13084-18-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924080459.13084-18-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat, Sep 24, 2022 at 10:04:44AM +0200, Krzysztof Kozlowski wrote:
> Certain pins, like SDcard related, do not have functions and such should
> not be required.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks a lot for all your effort to clean this up!

> ---
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml          | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> index b1735918fa90..e4332e628698 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> @@ -53,7 +53,6 @@ $defs:
>      description:
>        Pinctrl node's client devices use subnodes for desired pin configuration.
>        Client device subnodes use below standard properties.
> -    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
>  
>      properties:
>        pins:
> @@ -113,7 +112,16 @@ $defs:
>  
>      required:
>        - pins
> -      - function
> +
> +    allOf:
> +      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> +      - if:
> +          properties:
> +            pins:
> +              pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-7])$"
> +        then:
> +          required:
> +            - function
>  

Is it possible to place this into qcom,tlmm-common.yaml? If the pattern
is only used to make "function" required for GPIOs, then it should not
matter if it matches just the prefix ("^gpio") or the exact set of
allowed GPIO numbers. The definition of the "pins" property will already
take care of validating those.

Or are there some Qcom SoCs where a GPIO without "function" is valid?

Thanks,
Stephan
