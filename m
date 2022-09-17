Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976D85BBAF0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 01:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIQXGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 19:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIQXGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 19:06:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE8E2B263;
        Sat, 17 Sep 2022 16:06:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A83CE415;
        Sun, 18 Sep 2022 01:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663455980;
        bh=yJVQU/LoDpmK0GDSeMa3ENJKTWi4ya1rgtGnDtCSzls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLBiN0EOXkppSgJUTYn/pyviiXeXF7As9xjhtHKhoFqPmen5zN7Cj9Vhlm4bRJg7Y
         MGmSm1p0+TDlWcsiLUgToqIVV2t5a2yaDfjAu9sy3tlyY13GHKZixiCUg7jp61HC6I
         7itqgYghjcXGpa1xkPUdBSzdgAnCE3OaD4rCEHM8=
Date:   Sun, 18 Sep 2022 02:06:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to
 video-interface-devices.yaml
Message-ID: <YyZS38Wo7rDsNRm2@pendragon.ideasonboard.com>
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thank you for the patch.

On Fri, Sep 16, 2022 at 02:35:21PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> video-interface-devices.yaml isn't used so just drop it from the
> DT binding doc.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> index 540fd69ac39f..ce99aada75ad 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5640.yaml
> @@ -9,9 +9,6 @@ title: OmniVision OV5640 Image Sensor Device Tree Bindings
>  maintainers:
>    - Steve Longerbeam <slongerbeam@gmail.com>
>  
> -allOf:
> -  - $ref: /schemas/media/video-interface-devices.yaml#
> -

The rotation property listed in this binding uses the definition from
video-interface-devices.yaml. I don't think just dropping this is the
right solution. Changing additionaProperties to unevaluatedProperties
seems a better option.

>  properties:
>    compatible:
>      const: ovti,ov5640

-- 
Regards,

Laurent Pinchart
