Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC416D57CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjDDE4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDDE4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:56:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0DD1BF3;
        Mon,  3 Apr 2023 21:56:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D24398B;
        Tue,  4 Apr 2023 06:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680584181;
        bh=tvygH40QS7v4O7ryyN1WeXuGuP9sZPM/73Xs4pA/gm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGjH4jNb7Pdv2bGfIVKKtHcqXhsrdp0btfA3Doe5tUf7/8oGD+erEkMv768B0treh
         Dqoug+OF6S79PJpKusSeUC7MvaxMW33hotSkfUhFbIjzfkeXpC8/gYy7caAgXKp1ls
         4mkKelePFw27juProC2CcgbIlSAeQVS142EfKhy0=
Date:   Tue, 4 Apr 2023 07:56:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v3 4/9] media: dt-bindings: cadence-csi2rx: Add resets
 property
Message-ID: <20230404045627.GM16648@pendragon.ideasonboard.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-5-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331121826.96973-5-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

Thank you for the patch.

On Fri, Mar 31, 2023 at 08:18:21PM +0800, Jack Zhu wrote:
> Add resets property for Cadence MIPI-CSI2 RX controller
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/media/cdns,csi2rx.yaml           | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> index 89f414eeef47..f8da4a35e98e 100644
> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> +++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> @@ -38,6 +38,24 @@ properties:
>        - const: pixel_if2_clk
>        - const: pixel_if3_clk
>  
> +  resets:
> +    items:
> +      - description: CSI2Rx system reset
> +      - description: Gated Register bank reset for APB interface
> +      - description: pixel reset for Stream interface 0
> +      - description: pixel reset for Stream interface 1
> +      - description: pixel reset for Stream interface 2
> +      - description: pixel reset for Stream interface 3
> +
> +  reset-names:
> +    items:
> +      - const: sys
> +      - const: reg_bank
> +      - const: pixel_if0
> +      - const: pixel_if1
> +      - const: pixel_if2
> +      - const: pixel_if3
> +
>    phys:
>      maxItems: 1
>      description: MIPI D-PHY
> @@ -120,6 +138,12 @@ examples:
>          clock-names = "sys_clk", "p_clk",
>                        "pixel_if0_clk", "pixel_if1_clk",
>                        "pixel_if2_clk", "pixel_if3_clk";
> +        resets = <&bytereset 9>, <&bytereset 4>,
> +                 <&corereset 5>, <&corereset 6>,
> +                 <&corereset 7>, <&corereset 8>;
> +        reset-names = "sys", "reg_bank",
> +                      "pixel_if0", "pixel_if1",
> +                      "pixel_if2", "pixel_if3";
>          phys = <&csi_phy>;
>          phy-names = "dphy";
>  

-- 
Regards,

Laurent Pinchart
