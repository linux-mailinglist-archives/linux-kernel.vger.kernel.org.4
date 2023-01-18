Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534406723EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjARQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjARQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:45:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D5B5587;
        Wed, 18 Jan 2023 08:44:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2EAAB81DA6;
        Wed, 18 Jan 2023 16:44:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D111C433D2;
        Wed, 18 Jan 2023 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674060291;
        bh=pmYmioG0fcrEcbWXBBM408S3FTzU7YmS8Z5jlCpig6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ny6f4nxMYkCU5Y+pJjIKC/bjQoZcIvf0N98mKvejArUr+EOnAx0KErq0ngOMxfsHP
         5VvnHtNGCiXPasyyfkwZ7Gd7sPeS/TVFPGkVeWrlpzdSq+8dLnsyvMOW9fiD7QhSct
         DdKTs/ds6NqASMoAvzolEl9krHbxP1mpO3Q9SieoH6ae6Ww3kyEDyLSuhsy1moSn/h
         UxY7tp/8GL4NYTlPeDLn3e0uhPq38TIvOGdyiy/wVEG0qDFd0xA+UDEumZso6G/Ttl
         e0gC2b7bs4Bqk0zs/g5cglUsgFEUDxYoQgtCpWa4lCQM+/8Z6U1nD1G7F+ayaugohh
         z7sEBtroQRxHw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pIBYq-0005t8-2X; Wed, 18 Jan 2023 17:45:16 +0100
Date:   Wed, 18 Jan 2023 17:45:16 +0100
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: phy: Add QMP PCIe PHY comptible for
 SM8550
Message-ID: <Y8giHJMtPu4wTlmA@hovoldconsulting.com>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
 <20230118005328.2378792-2-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118005328.2378792-2-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:53:21AM +0200, Abel Vesa wrote:
> Document the QMP PCIe PHY compatible for SM8550.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index 8a85318d9c92..65f26cfff3fb 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -20,6 +20,8 @@ properties:
>        - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>        - qcom,sc8280xp-qmp-gen3x4-pcie-phy
>        - qcom,sm8350-qmp-gen3x1-pcie-phy
> +      - qcom,sm8550-qmp-gen3x2-pcie-phy
> +      - qcom,sm8550-qmp-gen4x2-pcie-phy
>  
>    reg:
>      minItems: 1

I don't think I'll have time to look at this week, but I did notice that
you fail do describe the clocks, regulators, and resets (as you also
did for the UFS PHY binding) which are currently different from
sc8280xp.

Please be more careful when adding compatible strings so we get this
right. You should also double check that the differences are really
warranted and not just due the vendor using different names for the same
resource.

At least the reset must be renamed ("pcie_1_nocsr_com_phy_reset", e.g.
drop 'pcie' and 'reset', maybe more).

Johan
