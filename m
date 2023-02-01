Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A980686AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjBAPuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjBAPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:50:28 -0500
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 07:50:26 PST
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E410F2;
        Wed,  1 Feb 2023 07:50:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675266444; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=MckXOtOwCZhhXborN9/uXufdtB1EhDgRAzhKb31wHgVZaFFB2UTvbH0eLZCcwHzUrD
    AzSB6gH3a6DchrfCw6o+pFXqZb2gvkJbeEgqJuocBRSOhKWU/QtN+3exW5BsZnanV7Hr
    fqZWbk4fDd0txIex+/hUsWAAqroSrPaT5/9AtrR2Lw51S4rroQTBsYN2+vWHH+x0lLYr
    pJImqLwjHtlyxPp2UVNFOCfFS4n6zMxDSpwc43I80QSHDIUXZ+9IZn857euRm5n5Vy/h
    sqBLj2Wn+DlFUtutG5dF0S9kOMle+jvWGrohzrvYeAE0sPP0U8CMf09ALzGI/A5naKV9
    HoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675266444;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZRbPu9ZSdTZy3FgvNd6Y/M17h6PRus5FhIoDkgBz7WA=;
    b=mufi2nkG1hfRiN4Oal/F9qiszfrR4kST/zxRZUgMAk6fEnI5+Kk+P+8q7qq1fRNb8k
    cOYInHGMO8EcfG/hrMypVODNnuuZoF+WjnioUGnBHg1j4QZ61O9/LCX6J+s/jWFVkDb/
    VB7QEp5IeKrJ51AhlYhc0Ow1WDHaf3PJ957zpDj+sE5g+v2yw4mhU2OL2/tO6Sjlmn4+
    g6bYIubGXGyY0kVfTfVNMR7MTROWAc05AlgOScN4Z0Xiu+foPfDiUUEMllPRDBoASzKx
    u6d4ScOqoYi4J1Sv1/5kVAqKAejxXaGGOzSFJcBQHv2iiZ38TWcKdW7tFo8zbJ1AH1iO
    SryQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675266444;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZRbPu9ZSdTZy3FgvNd6Y/M17h6PRus5FhIoDkgBz7WA=;
    b=OHpCb6vqt5rz+CVcmg9RdZK12V+Rh0mnd8iZdQPaG/mHjuRNn8A4bwjUsWMcQm4IhB
    8jIGNqksr110WODWYERrlfQIVNAmccn0IhE7HUxDRpndVvLwNyWy2RKSE5UUwnXsbGLN
    2vJjxWX9xFBpzpbDgRfDZTEJxlH/T/Q/6hT6b+pTN5AjiD8F/JwMQ/x3Oifc+XIlVqLd
    LeqfTomAWFqHvmIQY0riGsU7dmBKdD1F2fk7gYCQNL7dOYg2EVYYm+SIDxgxYOFw4oZn
    54NtHY20r77uAg4zmM4JG44CZV55MqTNjKqGuIVt7Uqhcg0+0yWZaszG1kYC8Ubh1Z/H
    q5/w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267EpF+OQRc4obTF5+XwHE="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.2.2 DYNA|AUTH)
    with ESMTPSA id eee9e2z11FlOUlz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Feb 2023 16:47:24 +0100 (CET)
Date:   Wed, 1 Feb 2023 16:47:17 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: pinctrl: qcom,msm8909: correct GPIO
 name pattern and example
Message-ID: <Y9qJheoYYCOnk1DO@gerhold.net>
References: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
 <20230201153019.269718-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201153019.269718-2-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:30:14PM +0100, Krzysztof Kozlowski wrote:
> The MSM8909 TLMM pin controller has GPIOs 0-112, so narrow the pattern
> and gpio-ranges in the example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Not sure if people care about Fixes tags for DT schema but this patch
definitely

Fixes: c249ec7ba1b1 ("dt-bindings: pinctrl: Add DT schema for qcom,msm8909-tlmm")

I have no idea what I was thinking when I used 117 instead of 113...
Thanks a lot for finding and fixing this!

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> index 449e6e34be61..85082adc1811 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> @@ -63,7 +63,7 @@ $defs:
>            subnode.
>          items:
>            oneOf:
> -            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-7])$"
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-2])$"
>              - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
>                        sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data0, qdsd_data1,
>                        qdsd_data2, qdsd_data3 ]
> @@ -127,7 +127,7 @@ examples:
>          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>          gpio-controller;
>          #gpio-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 117>;
> +        gpio-ranges = <&tlmm 0 0 113>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
>  
> -- 
> 2.34.1
> 
