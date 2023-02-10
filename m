Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64596923FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjBJRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjBJRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:07:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A9870CFE;
        Fri, 10 Feb 2023 09:07:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F058161E5A;
        Fri, 10 Feb 2023 17:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739A5C433EF;
        Fri, 10 Feb 2023 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048840;
        bh=8xnEbUe384hDQfmy0gkujDdHwEJmlYJhWIVvttyg4zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ouvjvsjfj6FEcd9NqZXZ8enkDcwx7PSljl8SoNYZ3XdcejU2Ioq59FBZk72pqEde5
         1XTXzIZQu1jXtC0GOrtJrAz/PDEtzcgwiCzXqnNJtu24eMSn2Ka51C94Q9+mgsBSgi
         aW2CsNuMiDqio4/OPNh7kL1Gu/9NgYfenf+xycqfo614duwKZak+U8NJrKkfD3O5tp
         VA1FhFw+z2CKlRgLZNt7E4CvmDA84ZH7aZfcTiWWaciYGDYIgyucYLIetUpkA3ptys
         bFD/bIWp1VQOZozNk7ahP68U197WBLrXTFcd3fachMu5SAb8w+XC4GQpvoT//MouvD
         +hd/0ivyVbzeg==
Date:   Fri, 10 Feb 2023 22:37:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: amlogic,g12a-usb3-pcie-phy: add
 missing optional phy-supply property
Message-ID: <Y+Z5xOlAeqO6JyIj@matsya>
References: <20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-v1-1-3e437b759549@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-v1-1-3e437b759549@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-23, 16:03, Neil Armstrong wrote:
> Add missing optional phy-supply property used to power up PHY regulators.
> 
> Fixes: 87a55485f2fc ("dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml          | 5 +++++

I dont have this file in my tree, what was this based on?

>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
> index 129d26e99776..3314711292d6 100644
> --- a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
> @@ -35,6 +35,11 @@ properties:
>    "#phy-cells":
>      const: 1
>  
> +  phy-supply:
> +    description:
> +      Phandle to a regulator that provides power to the PHY. This
> +      regulator will be managed during the PHY power on/off sequence.
> +
>  required:
>    - compatible
>    - reg
> 
> ---
> base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
> change-id: 20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-b5daf54fb7d6
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>

-- 
~Vinod
