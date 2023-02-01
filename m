Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09938686B26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjBAQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjBAQHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:07:46 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE09774C3C;
        Wed,  1 Feb 2023 08:07:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675267660; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lfYmpWgL0UaaxXjNCpQCXxzyOZubao8dXEmV8np09uCsLGtIwp9RZ7ybyg4gRNvFCn
    SyzaWLcHmxt3RqehjpeXbIxAtZ9rhmGrLd4NAGGAFIAF/fKcXStaBS84fc/lgw8yJmR+
    XKLXzKXldNIli++qqP+L0drOcor6N8Y4nVfVdtDA+RyxIi55E1vbXZ5Of9ZsjzlRnO6Q
    g65wbt1XjLUCDQcJ4upSwGdFsrb+7mdTCWKHhBa8x/WWF3MY1Ew/cGCbVpI/TcyJtQH7
    xGjIx+zlBFj03aU498UyznLj+vT84A6Y6OWti6qeNmLo95zGCbUURqvaUCZ2geXMvno5
    YXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675267660;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5EWlNg+XhFGtz1hJ7SAiKe/vHMaM/9hIzu2dnaeJK2k=;
    b=ZSRkH013oKcZjawQAgn5JOQFjvR4w8LyMmCXxVkEv3BrKD3nq6Wr3AC8I0lROWlPxh
    WKlCVQ4kgbBgncjjIWocFGbXa5Ys2Z+PW7/80kjqv6RQJsBiwUuemM24YQutGtzFIvQ4
    59oN/Sj7xQrWvgWu3nwcibujHm9GI2rfpUvQVwwcH6WpDZubsK1gf86fouo6cWxR0Pwd
    UjrVF2tBZ8+YPPIC5AqgmxC01wXvr9KLOvTV242pwOQXrkcqO58EPpkM1TVnWE1e/GSj
    gGMZppRIAIdsPbaj0yvZZHHv8q7vdOcBecaPCCJlCEOBEMOb3eKRMArOg3f4cwMQ8pT1
    IQeQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675267660;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=5EWlNg+XhFGtz1hJ7SAiKe/vHMaM/9hIzu2dnaeJK2k=;
    b=SxfynlKLzBt0nR54NB7KB87PCmv42ibHGWHJTbLpIo5nINxPKAVbOoT33i7/MW/M11
    74pID6Yn4KKsn+c7yXuc95IuGjKI332mgJhW9rnX8l0wuPBxK/DsM8V0EcjZ/lAqPCKk
    qyZIdoz6gIbwjYfpH3SsWKoIwfQQ3A1fjMQaWxS/P+4N6hRTml6iC/GaBOThqY0Hhszb
    r1zEdgxeYhgGcl60A/nFGMC8DR4U72WvewP82I54CT56shKopgcpwje06fGb1rSp9o8l
    JCr4y9FRyubE+2NApkpRVEXnfnxgBjLNW4Em3FDO6vTesT8H6PGGjbyNu9nf4kaCF9gy
    wXpg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267EpF+OQRc4obTF5+XwHE="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.2.2 DYNA|AUTH)
    with ESMTPSA id eee9e2z11G7eUqH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Feb 2023 17:07:40 +0100 (CET)
Date:   Wed, 1 Feb 2023 17:07:33 +0100
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
Subject: Re: [PATCH 7/7] dt-bindings: pinctrl: qcom: correct gpio-ranges in
 examples
Message-ID: <Y9qORcPIuq4IZcL1@gerhold.net>
References: <20230201153019.269718-1-krzysztof.kozlowski@linaro.org>
 <20230201153019.269718-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201153019.269718-7-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:30:19PM +0100, Krzysztof Kozlowski wrote:
> Correct the number of GPIOs in gpio-ranges to match reality.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

AFAICT the current gpio-ranges do match the number of GPIOs (ngpios) in
the pinctrl drivers for all/most of the platforms you update below. It
looks like the special UFS_RESET pins are also exported as GPIOs in
addition to the real GPIOs. I'm not sure if this is intended or a
mistake.

In any case, the gpio-ranges should match the "ngpios" in the driver,
otherwise the driver exposes more GPIOs than advertised by the DT.

So I think the same change should be made in the driver as well if the
UFS pins are not supposed to be exposed as GPIOs.

Thanks,
Stephan

> ---
>  .../devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml        | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml         | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml        | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml  | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml | 2 +-
>  .../devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml        | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml | 2 +-
>  Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> index f33792a1af6c..77a5aaefddbe 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> @@ -138,7 +138,7 @@ examples:
>          #gpio-cells = <2>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 120>;
> +        gpio-ranges = <&tlmm 0 0 119>;
>          wakeup-parent = <&pdc>;
>  
>          dp_hot_plug_det: dp-hot-plug-det-state {
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
> index 97b27d6835e9..854bbb5b6f5d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
> @@ -128,7 +128,7 @@ examples:
>          #gpio-cells = <2>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 230>;
> +        gpio-ranges = <&tlmm 0 0 228>;
>  
>          gpio-wo-subnode-state {
>              pins = "gpio1";
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> index f586b3aa138e..03c7b5c97599 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> @@ -119,7 +119,7 @@ examples:
>          #gpio-cells = <2>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 151>;
> +        gpio-ranges = <&tlmm 0 0 150>;
>  
>          qup-i2c9-state {
>              pins = "gpio6", "gpio7";
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> index 23d7c030fec0..a08e4557d8b7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> @@ -134,7 +134,7 @@ examples:
>          #gpio-cells = <2>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 151>;
> +        gpio-ranges = <&tlmm 0 0 150>;
>          wakeup-parent = <&pdc_intc>;
>  
>          ap-suspend-l-hog {
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
> index 89c5562583d1..96375f58fa22 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx65-tlmm.yaml
> @@ -140,7 +140,7 @@ examples:
>          reg = <0x03000000 0xdc2000>;
>          gpio-controller;
>          #gpio-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 109>;
> +        gpio-ranges = <&tlmm 0 0 108>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
>          interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> index 29325483cd2b..d35db4f4581b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> @@ -121,7 +121,7 @@ examples:
>          #gpio-cells = <2>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 114>;
> +        gpio-ranges = <&tlmm 0 0 113>;
>  
>          sdc2_on_state: sdc2-on-state {
>              clk-pins {
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
> index c9bc4893e8e8..83848950cc3b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
> @@ -125,7 +125,7 @@ examples:
>          reg-names = "west", "south", "east";
>          interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
>          gpio-controller;
> -        gpio-ranges = <&tlmm 0 0 134>;
> +        gpio-ranges = <&tlmm 0 0 133>;
>          #gpio-cells = <2>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
> index d95935fcc8b5..3fe1f1668fbc 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
> @@ -142,7 +142,7 @@ examples:
>          #gpio-cells = <2>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 157>;
> +        gpio-ranges = <&tlmm 0 0 156>;
>  
>          gpio-wo-subnode-state {
>              pins = "gpio1";
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
> index 4376a9bd4d70..4c9ad9079e69 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
> @@ -136,7 +136,7 @@ examples:
>                <0x03d00000 0x300000>;
>          reg-names = "west", "east", "north", "south";
>          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> -        gpio-ranges = <&tlmm 0 0 176>;
> +        gpio-ranges = <&tlmm 0 0 175>;
>          gpio-controller;
>          #gpio-cells = <2>;
>          interrupt-controller;
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
> index 56c8046f1be0..c4cec40cbb92 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
> @@ -124,7 +124,7 @@ examples:
>          reg = <0x0f100000 0x300000>;
>          gpio-controller;
>          #gpio-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 211>;
> +        gpio-ranges = <&tlmm 0 0 210>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
>          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
> index a457425ba112..6ecc1ad6ccd4 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
> @@ -136,7 +136,7 @@ examples:
>          reg = <0x0f100000 0x300000>;
>          gpio-controller;
>          #gpio-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 211>;
> +        gpio-ranges = <&tlmm 0 0 210>;
>          interrupt-controller;
>          #interrupt-cells = <2>;
>          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.34.1
> 
