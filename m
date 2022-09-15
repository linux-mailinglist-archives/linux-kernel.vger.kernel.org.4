Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4665B9E90
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiIOPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiIOPPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:15:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6CBA0621;
        Thu, 15 Sep 2022 08:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B764A624E0;
        Thu, 15 Sep 2022 15:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80324C433C1;
        Thu, 15 Sep 2022 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663254550;
        bh=s4g27oLFR4JjdrDKoXeayNWkQcw7rCcusIREdv1SkiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpBmjGjl438pPHnH0k8AcGThRXV53hXAa7+7AOuGdZvExVltjjVPV2nR2kocSozB1
         bVq+lg7gAcBjbEFkTdN5xCL7AAQsNXPp9S+dLJPQ8Jr6uSarZKEMu6bG9cQ1P+Epts
         D0U4f5jQedH+DPXLYoCYlMefosQ3FUgYr/366jRr6iQE1LkipsRg2TEmzkHYOyN5Gf
         qdiR56ETbjQGGK51j5ta19IrpCKA4BBrNUdOWleRPePl71fUp819cagv0b8dMNJ1QO
         D1RNFARlzOv8pETs58L9T/59/bB/QVUJU46/GFq8EfCfhTipFYmk3Y4beK922sreK1
         sSKPyAteLElsw==
Date:   Thu, 15 Sep 2022 10:09:07 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
Message-ID: <20220915150907.yxmulr3xq4uwvi7f@builder.lan>
References: <20220915141601.18435-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915141601.18435-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 04:16:01PM +0200, Johan Hovold wrote:
> The size of the UFS PHY serdes register region is 0x1c8 and the
> corresponding 'reg' property should specifically not include the
> adjacent regions that are defined in the child node (e.g. tx and rx).
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 4b85c9276435..638317f78ab2 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1432,7 +1432,7 @@ ufs_mem_hc: ufs@1d84000 {
>  
>  		ufs_mem_phy: phy@1d87000 {
>  			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> -			reg = <0 0x01d87000 0 0xe10>;
> +			reg = <0 0x01d87000 0 0x1c8>;
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> @@ -1500,7 +1500,7 @@ ufs_card_hc: ufs@1da4000 {
>  
>  		ufs_card_phy: phy@1da7000 {
>  			compatible = "qcom,sc8280xp-qmp-ufs-phy";
> -			reg = <0 0x01da7000 0 0xe10>;
> +			reg = <0 0x01da7000 0 0x1c8>;
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges;
> -- 
> 2.35.1
> 
