Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C608366A1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjAMSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAMSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:16:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C5FD22;
        Fri, 13 Jan 2023 10:08:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C2D622C8;
        Fri, 13 Jan 2023 18:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44ADC433D2;
        Fri, 13 Jan 2023 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673633291;
        bh=/AOabS0gzSJrsANTEfB1Kjc/Gs5HwKZqsKiGn38jFWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJ7ZuRIXkhsUlY1TuCjTHLnWmEQpqClIv/XQ445+CZEKSojWM6V9El6DgHXapUxqG
         nUj65/qqkvZQIJS/kqAQmfbb+74pcNJIhpBdcgGSH3fMWSo5U5cmgn7hynWH2EED4N
         LhrX6fqeiQxkWg8/7ZIdbxqF/KKYc2zv3utmse8f7ishSUfJwQCGKb6SeTmwwQHnPI
         EoeMpVLXur7jebEC75XFjV2NkLrGpEMdGbuy6Oy6zQP64F6pEZB2TdFPukWXbaOfuL
         L/oJ+mMjfo18g0xrQUjWV0NEViYOhgMEClAOMlt24U3wdzx5AHRj/FeEDUXo+zx2Gr
         lgg5corXEsM/A==
Date:   Fri, 13 Jan 2023 23:38:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        kishon@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip: convert
 rockchip-dp-phy.txt to yaml
Message-ID: <Y8GeBzNJvhMeh3sn@matsya>
References: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6fe473-71f2-edba-f009-994a3dbc9802@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-12-22, 10:44, Johan Jonker wrote:
> Convert rockchip-dp-phy.txt to yaml.

This series fails to apply, pls rebase
> 
> Changed:
>   rename file name

This should not be in change log but after the --- line

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed V2:
>   Use the compatible as filename.
> ---
>  .../bindings/phy/rockchip,rk3288-dp-phy.yaml  | 41 +++++++++++++++++++
>  .../bindings/phy/rockchip-dp-phy.txt          | 26 ------------
>  2 files changed, 41 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
> new file mode 100644
> index 000000000..2538235c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3288-dp-phy.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/rockchip,rk3288-dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip specific extensions to the Analogix Display Port PHY
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3288-dp-phy
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: 24m
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3288-cru.h>
> +    edp-phy {
> +      compatible = "rockchip,rk3288-dp-phy";
> +      clocks = <&cru SCLK_EDP_24M>;
> +      clock-names = "24m";
> +      #phy-cells = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> deleted file mode 100644
> index e3b4809fb..000000000
> --- a/Documentation/devicetree/bindings/phy/rockchip-dp-phy.txt
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -Rockchip specific extensions to the Analogix Display Port PHY
> -------------------------------------
> -
> -Required properties:
> -- compatible : should be one of the following supported values:
> -	 - "rockchip.rk3288-dp-phy"
> -- clocks: from common clock binding: handle to dp clock.
> -	of memory mapped region.
> -- clock-names: from common clock binding:
> -	Required elements: "24m"
> -- #phy-cells : from the generic PHY bindings, must be 0;
> -
> -Example:
> -
> -grf: syscon@ff770000 {
> -	compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
> -
> -...
> -
> -	edp_phy: edp-phy {
> -		compatible = "rockchip,rk3288-dp-phy";
> -		clocks = <&cru SCLK_EDP_24M>;
> -		clock-names = "24m";
> -		#phy-cells = <0>;
> -	};
> -};
> --
> 2.20.1

-- 
~Vinod
