Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381176DFB2B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDLQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLQVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF2C76BB;
        Wed, 12 Apr 2023 09:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9715E61182;
        Wed, 12 Apr 2023 16:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FCEC433D2;
        Wed, 12 Apr 2023 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316467;
        bh=21dBoDUPAhRFz5u/I/SNMkgZ5X/vQ2e+XmdjNlj1Du8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTmU8TEKf4jN9ncm84CyFOfQThd9BDS0h6DQ0hlWZ/7s+XTuljeLkMja1C6+MbTaz
         +1Lr2wdMbgfevnk4lP1ZxL/sR1uTyNGm5KoHxK3ZFEL1N5IbzLOCQzgRT91DELBbyq
         68nUz/MDpAjZ8lQpjK3mFZ8cK8RqwFdVOf9Hk2an2qLS0u3LmXsoy8JeQ+9sbT4UeP
         j3vqoBoJYgdv4gA+39eDk96nicOOq+sGO5MOjZuyhVoD7i2Lnn8Cyse5F1AnLJ41V8
         HwjHmSd2De+7l9eWdXASDzPGOlvPeHC52kYT2xWO2G0y1Ie6gc9lsdMZARLdtfBOdC
         S++JQF4p30xSQ==
Date:   Wed, 12 Apr 2023 21:51:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>, Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: phy: cadence-sierra: drop
 assigned-clocks
Message-ID: <ZDbabx/fgDjqh1qm@matsya>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-04-23, 21:01, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  There are also no
> benefits of having it here and a board could actually need more of clock
> assignments than the schema allows.

Applied all, thanks

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.yaml       | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> index 6a09472740ed..1de699fe5306 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
> @@ -61,14 +61,6 @@ properties:
>        - const: pll0_refclk
>        - const: pll1_refclk
>  
> -  assigned-clocks:
> -    minItems: 1
> -    maxItems: 2
> -
> -  assigned-clock-parents:
> -    minItems: 1
> -    maxItems: 2
> -
>    cdns,autoconf:
>      type: boolean
>      description:
> -- 
> 2.34.1

-- 
~Vinod
