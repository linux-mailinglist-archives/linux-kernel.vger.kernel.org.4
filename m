Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332E36D57AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjDDEqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDDEp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:45:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD91A4;
        Mon,  3 Apr 2023 21:45:57 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CD9FB8B;
        Tue,  4 Apr 2023 06:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680583555;
        bh=oCBy4RuSxNUF89x5suADnlH3CCX++TyXOLO5XzzXcPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNKZUk6M5SK2E0q7bpevzWyxMBUw4oYsEkLwBkBRlvodVhoieDLapqovGcVSnr023
         vpqgYAQuIk4yIlnWj0dzDfh7rTEztjEfNUGuGy+ZyN4idC2SNUa2NhLyDFfnA+tUCQ
         L8vmW8vfzXcCQzpd/Y3JoEygs+YN/bC9Ho7/MnUQ=
Date:   Tue, 4 Apr 2023 07:46:01 +0300
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
Subject: Re: [PATCH v3 5/9] media: dt-bindings: cadence-csi2rx: Add starfive
 compatible
Message-ID: <20230404044601.GK16648@pendragon.ideasonboard.com>
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-6-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230331121826.96973-6-jack.zhu@starfivetech.com>
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

On Fri, Mar 31, 2023 at 08:18:22PM +0800, Jack Zhu wrote:
> Add starfive compatible for Starfive JH7110 SoC which has a
> Cadence MIPI-CSI2 RX controller.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/media/cdns,csi2rx.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> index f8da4a35e98e..30a335b10762 100644
> --- a/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> +++ b/Documentation/devicetree/bindings/media/cdns,csi2rx.yaml
> @@ -15,7 +15,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: cdns,csi2rx
> +    items:
> +      - enum:
> +          - starfive,jh7110-csi2rx
> +      - const: cdns,csi2rx
>  
>    reg:
>      maxItems: 1
> @@ -130,7 +133,7 @@ additionalProperties: false
>  examples:
>    - |
>      csi@d060000 {
> -        compatible = "cdns,csi2rx";
> +        compatible = "starfive,jh7110-csi2rx", "cdns,csi2rx";
>          reg = <0x0d060000 0x1000>;
>          clocks = <&byteclock 7>, <&byteclock 6>,
>                   <&coreclock 8>, <&coreclock 9>,

-- 
Regards,

Laurent Pinchart
