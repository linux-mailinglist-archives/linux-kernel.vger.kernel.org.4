Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6766777B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjAWJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjAWJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:48:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7C126D8;
        Mon, 23 Jan 2023 01:48:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECC1760DF5;
        Mon, 23 Jan 2023 09:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D95AC433D2;
        Mon, 23 Jan 2023 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674467298;
        bh=Gtrawd7V+PvigCRX4HDB9clZlq6pOWl9bC5qYU/+HLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfWR0NTjvuDZ6i0n+Rb8fjNYeA0IjRNI9+763/zPi9X0gJTlndXoEa3kU7DzZz4wf
         zBT6ZZ7Pyy/nXgf71EEV88AoI6MBbMn+Bx+M+BBzWozs6Fqb+5lXyHtjsc7TJjMVnq
         IvJ7B9x3wa5j0tFuiULBreBkzHTvO18Fc2VsKi8yYffzmrvYciBhn84fwn23YFVw3i
         v882rT+ctchnhWcL4gXiI+kDqb+24tahQXhnfNve7dSw3x3U4eLVQWTmii+s+m6mWZ
         01e3Hw/qKpdy8v15QQ781QJsEQF/9CaPLYmqM6PudqdEf7VhJsMZtR8wOKTuoc4lmZ
         YjWJBwpxMkTjw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJtR1-0000JK-I7; Mon, 23 Jan 2023 10:48:15 +0100
Date:   Mon, 23 Jan 2023 10:48:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: Add QMP UFS PHY comptible for
 SM8550
Message-ID: <Y85X3whxGRhFZjtP@hovoldconsulting.com>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
 <20230117142015.509675-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117142015.509675-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 04:20:10PM +0200, Abel Vesa wrote:
> Document the QMP UFS PHY compatible for SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> index 760791de0869..64ed331880f6 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,sc8280xp-qmp-ufs-phy
>        - qcom,sm6125-qmp-ufs-phy
> +      - qcom,sm8550-qmp-ufs-phy
>  
>    reg:
>      maxItems: 1

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
