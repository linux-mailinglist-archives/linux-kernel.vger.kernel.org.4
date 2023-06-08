Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE18728477
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjFHQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbjFHQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:01:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7952D7E;
        Thu,  8 Jun 2023 09:00:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 482C864EC5;
        Thu,  8 Jun 2023 16:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0849FC433D2;
        Thu,  8 Jun 2023 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686240035;
        bh=eeM7vwKXULgYEhWlDPgEsrjY3NVrsR93E78HoKF22HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bknFDsMTKhWwsiXyW4tNTgsp7yel2cEhBXALKuoRoZXlBzRq0YDCo3wXDyQWF0996
         YVvgJLaZpugnXcfVzrrmM3h8L8uvSgQR+SyPcd+oAVo7pMLxYaCwfilhau0UethtlK
         04tIo06ItB2SeUR+6gs3jF/z7KNL0Mhvg/CeceZhUeH5RUF+dvDEiYvP0M8gtjkSqd
         rACBvv3R1lMB4fUngOXLo54bWFnSELsDC8j9gVdnTOakXRl2012u25Zm4/06/q0MTA
         2CyslMHxkjWT01JDNIgrIO7FWxCRNby5QA4NFZKVwe65jngAQNUFFy9AqFrbAyNmi9
         xqi2vBHSlmiLQ==
Date:   Thu, 8 Jun 2023 21:30:24 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] arm: dts: qcom: sdx55: Add interconnect path
Message-ID: <20230608160024.GB8632@thinkpad>
References: <1686154687-29356-1-git-send-email-quic_krichai@quicinc.com>
 <1686154687-29356-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1686154687-29356-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:48:06PM +0530, Krishna chaitanya chundru wrote:
> Add pcie-mem interconnect path to sdx55 target.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  arch/arm/boot/dts/qcom-sdx55.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index 342c3d1..e9f8bfe 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -421,6 +421,10 @@
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "global",
>  					  "doorbell";
> +
> +			interconnects = <&system_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>;
> +			interconnect-names = "pci-mem";
> +
>  			resets = <&gcc GCC_PCIE_BCR>;
>  			reset-names = "core";
>  			power-domains = <&gcc PCIE_GDSC>;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
