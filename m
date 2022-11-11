Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6E6262DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbiKKU1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiKKU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:27:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A07340F;
        Fri, 11 Nov 2022 12:27:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3737620CA;
        Fri, 11 Nov 2022 20:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8460FC433C1;
        Fri, 11 Nov 2022 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668198420;
        bh=VFFbMfX4/o+UWM2oq92Ps0TnAJRnovYTG4dVRRwNmek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIhYqyP+xZ8S6v1nHiz0+ojoNRzBDYw041MuMpA5sNeXdEipWJ381RiqGr0JdJelE
         A5aW0fJyWXVMCdrX9PaCBhIVNLxoKs3QJ3+pKxHskMbAxJwGkufUo+7DcYcwV33I0n
         GMqfFJfA+Hb2UJ4H6ETvOiLX73z5UizuxnO6cSh0dsPywRHearwcPNbbe/eUUAFL8D
         Rgz60jqhL9AAkhtvJOuOBSXITR1nFvBirmi175OqEYzfrjQVtq+HMmCAoCyZeMpmoH
         xbu41uPww5uLQN8KgpavD+4AZjFYe9Rm1Bds+iquI82tcZju/JV65Ews7LVJ0xsiNK
         ByvyNIJzDjd6Q==
Date:   Fri, 11 Nov 2022 14:26:57 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-usb3-uni: drop
 reference-clock source
Message-ID: <20221111202657.kyzay7oy4yojp4xo@builder.lan>
References: <20221111093857.11360-1-johan+linaro@kernel.org>
 <20221111093857.11360-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111093857.11360-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:38:55AM +0100, Johan Hovold wrote:
> The source clock for the reference clock is not used by the PHY directly
> and should not be included in the devicetree binding.
> 
> Fixes: e8e58e29a0c9 ("dt-bindings: phy: qcom,qmp-usb: fix sc8280xp binding")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml       | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> index ef080509747a..16fce1038285 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> @@ -22,12 +22,11 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    maxItems: 5
> +    maxItems: 4
>  
>    clock-names:
>      items:
>        - const: aux
> -      - const: ref_clk_src
>        - const: ref
>        - const: com_aux
>        - const: pipe
> @@ -82,12 +81,10 @@ examples:
>        reg = <0x088ef000 0x2000>;
>  
>        clocks = <&gcc GCC_USB3_MP_PHY_AUX_CLK>,
> -               <&rpmhcc RPMH_CXO_CLK>,
>                 <&gcc GCC_USB3_MP0_CLKREF_CLK>,
>                 <&gcc GCC_USB3_MP_PHY_COM_AUX_CLK>,
>                 <&gcc GCC_USB3_MP_PHY_PIPE_0_CLK>;
> -      clock-names = "aux", "ref_clk_src", "ref", "com_aux",
> -                    "pipe";
> +      clock-names = "aux", "ref", "com_aux", "pipe";
>  
>        power-domains = <&gcc USB30_MP_GDSC>;
>  
> -- 
> 2.37.4
> 
