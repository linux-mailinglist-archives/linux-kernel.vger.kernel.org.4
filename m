Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8606E19DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDNBvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDNBvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737B30DE;
        Thu, 13 Apr 2023 18:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C340260B3B;
        Fri, 14 Apr 2023 01:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F389AC433EF;
        Fri, 14 Apr 2023 01:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681437097;
        bh=gLDWYLDDhntT7dquLuIpW7PMEAgkvCXTIyzwrqznejE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZQ7IAWg77gcZjC3M9ConoEp2KwEyANJbR8QqqdS6b+WKyWDHcc9FE491QH/O8dkwk
         KnxXU8L6P2EO/t/xL7SkRsqgmqQDhgEDVdCtlV5IZ/iQlxguTCbmg0uKm/sAXU5ywj
         JG7Pzl3ksFU5tyOsYIDYBwKsAL2rGaXunE3CMjwWag6QejhF6cFQ6CuVa2+nOokk8g
         BxA9uWlK8Ef8w4f9mNZvoo4wDRJxfCSyueUcbWduddxINCG0e+QZoiBzbE5dp5Wx+c
         75xn5lKXrwt5vMgZIZaA3Ph0z2RLoycooKVXfWxDBSbnEw3TLypxYqSAQYS+DGLjxH
         qQHK9EetDh03w==
Message-ID: <59c363bc-9e98-e7a2-1da4-92e41daef34f@kernel.org>
Date:   Fri, 14 Apr 2023 10:51:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCHv1 2/5] dt-bindings: ata: ahci: add RK3588 AHCI controller
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230413182345.92557-1-sebastian.reichel@collabora.com>
 <20230413182345.92557-3-sebastian.reichel@collabora.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230413182345.92557-3-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 03:23, Sebastian Reichel wrote:
> Just like RK3568, the RK3588 has a DWC based AHCI controller.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> FWIW IDK what exactly the ASIC clock is. The TRM does not provide any
> details unfortunately. It is required for functional SATA, though.
> ---
>  .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml       | 6 ++++--
>  Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml    | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> index c1457910520b..0df8f49431eb 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
> @@ -31,11 +31,11 @@ properties:
>        PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
>        clock, etc.
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 5
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 4
> +    maxItems: 5
>      items:
>        oneOf:
>          - description: Application APB/AHB/AXI BIU clock
> @@ -50,6 +50,8 @@ properties:
>            const: rxoob
>          - description: SATA Ports reference clock
>            const: ref
> +        - description: Rockchip ASIC clock

Shouldn't this mention that this clock is for the 3588 only ? Or is it also
necessary for the 3568 ? That is not super clear.

> +          const: asic
>  
>    resets:
>      description:
> diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> index 5afa4b57ce20..c6a0d6c8b62c 100644
> --- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> +++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
> @@ -23,9 +23,11 @@ properties:
>          const: snps,dwc-ahci
>        - description: SPEAr1340 AHCI SATA device
>          const: snps,spear-ahci
> -      - description: Rockhip RK3568 AHCI controller
> +      - description: Rockhip AHCI controller
>          items:
> -          - const: rockchip,rk3568-dwc-ahci
> +          - enum:
> +              - rockchip,rk3568-dwc-ahci
> +              - rockchip,rk3588-dwc-ahci
>            - const: snps,dwc-ahci
>  
>  patternProperties:

