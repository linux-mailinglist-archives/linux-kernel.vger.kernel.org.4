Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB16E6809
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjDRP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjDRP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:26:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AFF118EA;
        Tue, 18 Apr 2023 08:26:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (133-32-181-51.west.xps.vectant.ne.jp [133.32.181.51])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 467D2DE5;
        Tue, 18 Apr 2023 17:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1681831555;
        bh=Rn9zMjlac/6epNW7W26E/R1d5UVOmKmvZINuWM+EkTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6T6jLkn7Y2230g3yPvEvXyj78mRG6iZHUGkhEezcvGQgSpgOwNnRwtOFU2YkguXg
         aX1X4jccRbnXOO4QB5YbZETyRIHCoDcf5Txn9shQfWWpVnBc4YARCC29vZMFxerg1z
         Gc+VPNx+vU9iNuKsR6bvb0gKakWBcIY3PSfdg+jo=
Date:   Tue, 18 Apr 2023 18:26:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Heiko Stuebner <heiko.stuebner@bq.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: Fix lvds.yaml references
Message-ID: <20230418152612.GF30837@pendragon.ideasonboard.com>
References: <20230418150658.1535120-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418150658.1535120-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Tue, Apr 18, 2023 at 10:06:57AM -0500, Rob Herring wrote:
> The trailing "/" in "lvds.yaml/#" is not a valid JSON pointer. The existing
> jsonschema package allows it, but coming changes make allowed "$ref" URIs
> stricter.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../devicetree/bindings/display/panel/advantech,idk-1110wr.yaml | 2 +-
>  .../devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml  | 2 +-
>  .../devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml | 2 +-
>  .../devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml | 2 +-
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 +-
>  .../devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
> index 3a8c2c11f9bd..f6fea9085aab 100644
> --- a/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-1110wr.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> -  - $ref: /schemas/display/lvds.yaml/#
> +  - $ref: /schemas/display/lvds.yaml#
>  
>  select:
>    properties:
> diff --git a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
> index 566e11f6bfc0..ab6b7be88341 100644
> --- a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> -  - $ref: /schemas/display/lvds.yaml/#
> +  - $ref: /schemas/display/lvds.yaml#
>  
>  select:
>    properties:
> diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
> index 5cf3c588f46d..3623ffa6518d 100644
> --- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> -  - $ref: /schemas/display/lvds.yaml/#
> +  - $ref: /schemas/display/lvds.yaml#
>  
>  select:
>    properties:
> diff --git a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
> index 54750cc5440d..37f01d847aac 100644
> --- a/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> -  - $ref: /schemas/display/lvds.yaml/#
> +  - $ref: /schemas/display/lvds.yaml#
>  
>  select:
>    properties:
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index c77ee034310a..929fe046d1e7 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> -  - $ref: /schemas/display/lvds.yaml/#
> +  - $ref: /schemas/display/lvds.yaml#
>  
>  select:
>    properties:
> diff --git a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
> index 2e75e3738ff0..e32d9188a3e0 100644
> --- a/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml
> @@ -12,7 +12,7 @@ maintainers:
>  
>  allOf:
>    - $ref: panel-common.yaml#
> -  - $ref: /schemas/display/lvds.yaml/#
> +  - $ref: /schemas/display/lvds.yaml#
>  
>  select:
>    properties:

-- 
Regards,

Laurent Pinchart
