Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028264B0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiLMITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbiLMITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:19:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86DF5AC;
        Tue, 13 Dec 2022 00:19:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 191F361355;
        Tue, 13 Dec 2022 08:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB59C433D2;
        Tue, 13 Dec 2022 08:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670919558;
        bh=yY2CBwuvD37TBBn1YVRIQf5C8+KaMDI6W4l+pvlpPa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lh7GH3rF4j1xjuSIE0oMEm3C8qe6u0yXRQ3Go5NTcFizeEhbj9tPTrPEm63VvBiD3
         0zaZPm+5hBE1AOXTBti0S36eREIkoXOw+bX9JtK3ZWT1Lo6aTyTZDCsKcOsiXiKWDn
         P1lYnb4R6PROtm5ZhHD1uDKXNolmV2Phk5zF6mpTldC6K4MgorZQ9bgi1vrpZSOETk
         oSDjWfF06pJ6/nrqRFn/KdCbfRRGexhN5HLtWIkbkKLxpmkzN9/IVOwhI78cd4D4WE
         Qv9Te1donqVPYH8RyHKzrtcGVScjVUllboi4mOT5a3WeC0GxC+Pb66eT1aIlQr7FUv
         2WclzIoyvub0A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p50Vq-0004l2-SD; Tue, 13 Dec 2022 09:19:43 +0100
Date:   Tue, 13 Dec 2022 09:19:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     andersson@kernel.org, bmasney@redhat.com,
        kernel test robot <lkp@intel.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Message-ID: <Y5g1ntW1sOBBgcJ/@hovoldconsulting.com>
References: <20221213051109.8685-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213051109.8685-1-quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 10:41:08AM +0530, Shazad Hussain wrote:
> Add the pcie2a, pcie2a_phy, and respective tlmm
> nodes that are needed to get pcie 2a controller
> enabled on Qdrive3.
> 
> This patch enables 4GB 64bit memory space for
> PCIE_2A to have BAR allocations of 64bit pref mem
> needed on this Qdrive3 platform with dual SoCs
> for root port and switch NT-EP. Hence this ranges
> property is overridden in sa8540p-ride.dts only.

Please break your lines at 72 columns or so (not 50).

> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> Reported-by: kernel test robot <lkp@intel.com>

No need for this Reported-by (even if some people may disagree).

> ---
> Changes since v3:
> - Fix syntax error and add Reported-by (Kernel test robot)
> 
> Changes since v2:
> - Discard below patch as v3 is merged in qcom tree
>   [v4] arm64: dts: qcom: sa8540p-ride: enable PCIe support
>   https://lore.kernel.org/all/20221206161916.315640-1-bmasney@redhat.com/
> - Move tlmm PINCTRL to the end and add R-b (Brian)
> 
> Changes since v1:
> - Fix ranges property indentation (Konrad)
> 
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 96 +++++++++++++++++------
>  1 file changed, 71 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index 6c547f1b13dc..d70859803fbd 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -146,6 +146,27 @@ vreg_l8g: ldo8 {
>  	};
>  };
>  
> +&pcie2a {
> +	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
> +		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
> +		 <0x03000000 0x5 0x00000000 0x5 0x00000000 0x1 0x00000000>;
> +
> +	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
> +	wake-gpios = <&tlmm 145 GPIO_ACTIVE_HIGH>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie2a_default>;
> +
> +	status = "okay";
> +};
> +
> +&pcie2a_phy {
> +	vdda-phy-supply = <&vreg_l11a>;
> +	vdda-pll-supply = <&vreg_l3a>;
> +
> +	status = "okay";
> +};
> +
>  &pcie3a {
>  	ranges = <0x01000000 0x0 0x40200000 0x0 0x40200000 0x0 0x100000>,
>  		 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x20000000>,
> @@ -186,31 +207,6 @@ &remoteproc_nsp1 {
>  	status = "okay";
>  };
>  
> -&tlmm {
> -	pcie3a_default: pcie3a-default-state {
> -		perst-pins {
> -			pins = "gpio151";
> -			function = "gpio";
> -			drive-strength = <2>;
> -			bias-pull-down;
> -		};
> -
> -		clkreq-pins {
> -			pins = "gpio150";
> -			function = "pcie3a_clkreq";
> -			drive-strength = <2>;
> -			bias-pull-up;
> -		};
> -
> -		wake-pins {
> -			pins = "gpio56";
> -			function = "gpio";
> -			drive-strength = <2>;
> -			bias-pull-up;
> -		};
> -	};
> -};
> -

This is a separate change which should go in its own patch. (We sometimes
make exceptions to this general rule, but then you must least mention
that you're also moving the tlmm nodes and why you're doing so in the
commit message.)

>  &ufs_mem_hc {
>  	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
>  
> @@ -268,3 +264,53 @@ &usb_2_qmpphy0 {
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
> +
> +/* PINCTRL */
> +
> +&tlmm {

Johan
