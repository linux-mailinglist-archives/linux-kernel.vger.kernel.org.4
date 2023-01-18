Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A5672CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjARXkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjARXkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:40:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AF563081;
        Wed, 18 Jan 2023 15:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF20061AC2;
        Wed, 18 Jan 2023 23:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4D6C433EF;
        Wed, 18 Jan 2023 23:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674085245;
        bh=4z99fwOBj8wyKeWgsNT+dDn9Fq0WFr6o8JW+WgXF9LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEe46n3G0XzhpkHJhdYZG9z/YtETaNTEfBmcxdyhGo5IEvZ6YUPUbf2bqnhYD0eaf
         LGbwt4CpmZiRg1jd0PkpGNJH4YBkocRx/YvUOnxS7IHwLuKgnaehAqdycS2HwD+nC0
         o5rXmWE7X+sSlKJMABnJybTIIveyxd6ExjUjDx3Qa1/YTMrQEKgy9z65GriA06mAce
         fqYmzVDdnSmx8+VffNdUAiaX0tV6SdKjX+fLVwK6wWF8/GhEic/5buq8g8ITfFAvBV
         uP3m6HOC2HUyiyXPYbORum124Y0ttCKkpkzlBRzmwrGh9eo2Ct0GoNctWVAH6pt6tS
         0r+FnZkaMGT0Q==
Date:   Wed, 18 Jan 2023 17:40:42 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@linaro.org,
        a39.skl@gmail.com
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add interconnect nodes
Message-ID: <20230118234042.ds4hqdgqjrt7ukpg@builder.lan>
References: <20221130104519.2266918-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130104519.2266918-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 04:15:19PM +0530, Bhupesh Sharma wrote:
> Add the interconnect nodes inside SM6115 dtsi.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Seems the driver series is waiting for a v2.

I'll drop this from my queue for now, please resubmit once the DT
binding has landed.

Thanks,
Bjorn

> ---
> - Based on linux-next/master
> - Depends on the SM6115 dt-binding and driver patchset, which can be
>   seen here: https://lore.kernel.org/linux-arm-msm/20221130103841.2266464-1-bhupesh.sharma@linaro.org/ 
> 
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 51 ++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index e4a2440ce544..dad5ab3edf0e 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -485,6 +485,57 @@ usb_1_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		snoc: interconnect@1880000 {
> +			compatible = "qcom,sm6115-snoc";
> +			reg = <0x01880000 0x60200>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
> +				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
> +
> +			clk_virt: interconnect-clk {
> +				compatible = "qcom,sm6115-clk-virt";
> +				#interconnect-cells = <1>;
> +				clock-names = "bus", "bus_a";
> +				clocks = <&rpmcc RPM_SMD_QUP_CLK>,
> +					 <&rpmcc RPM_SMD_QUP_A_CLK>;
> +			};
> +
> +			mmnrt_virt: interconnect-mmnrt {
> +				compatible = "qcom,sm6115-mmnrt-virt";
> +				#interconnect-cells = <1>;
> +				clock-names = "bus", "bus_a";
> +				clocks = <&rpmcc RPM_SMD_MMNRT_CLK>,
> +					 <&rpmcc RPM_SMD_MMNRT_A_CLK>;
> +			};
> +
> +			mmrt_virt: interconnect-mmrt {
> +				compatible = "qcom,sm6115-mmrt-virt";
> +				#interconnect-cells = <1>;
> +				clock-names = "bus", "bus_a";
> +				clocks = <&rpmcc RPM_SMD_MMRT_CLK>,
> +					 <&rpmcc RPM_SMD_MMRT_A_CLK>;
> +			};
> +		};
> +
> +		cnoc: interconnect@1900000 {
> +			compatible = "qcom,sm6115-cnoc";
> +			reg = <0x01900000 0x8200>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
> +				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
> +		};
> +
> +		bimc: interconnect@4480000 {
> +			compatible = "qcom,sm6115-bimc";
> +			reg = <0x04480000 0x80000>;
> +			#interconnect-cells = <1>;
> +			clock-names = "bus", "bus_a";
> +			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
> +				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
> +		};
> +
>  		qfprom@1b40000 {
>  			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>  			reg = <0x01b40000 0x7000>;
> -- 
> 2.38.1
> 
