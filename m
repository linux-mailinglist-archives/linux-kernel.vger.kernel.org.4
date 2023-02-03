Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A973B689753
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjBCKyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCKys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:54:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6123E721C3;
        Fri,  3 Feb 2023 02:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECE3AB82A59;
        Fri,  3 Feb 2023 10:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F129C433EF;
        Fri,  3 Feb 2023 10:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675421684;
        bh=bdrm4RmZt8Zhe1KAE3Pxv/XYpMXhajbxCxkPQpTRAIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxjzdNtifff+EPlQ/Q03g/ZSxR+Yi7CGiqlUsCt8DFjRjW49/sBKsX1cSTvOfCfMN
         LUGHAi5FOiwIeSyR0M65ui8nX3EwIgVfTzVCRwuKF0Iypl+Yp2QxxA7GYZvkcF/ChJ
         AHQV+z5TQ3hLsFJSNAvR0vH0Wv6nCyjWGrBRXkTHpaAK7v9MPoDd2AARx9tTqgamSv
         rHmmCOYpu/VKhhVowrOU0+i0AzEnNS4lAAODzWo1voc6ePtN6CRJMWwgOLf+/QlumX
         u1iq8UxqTuWjbJTcfeDiaeaAzmnS8ODa1kSVXWA+2Xp5mB4puPxiIY5AvdQBspriaK
         ECedToCDlDZKw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNtip-0001Oq-Ch; Fri, 03 Feb 2023 11:55:11 +0100
Date:   Fri, 3 Feb 2023 11:55:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/8] arm64: dts: qcom: sm8550: Add USB PHYs and
 controller nodes
Message-ID: <Y9zoD/eVG8zjMYNx@hovoldconsulting.com>
References: <20230202132511.3983095-1-abel.vesa@linaro.org>
 <20230202132511.3983095-8-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202132511.3983095-8-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 03:25:10PM +0200, Abel Vesa wrote:
> Add USB host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v3:
>  * none
> 
> Changes since v2:
>  * none
> 
> NOTE: This patch has been already merged. It is here only to provide
> context for the rest of the patchset. There is a change with respect to
> the clocks, but that will be sent as a separate/individual fix patch.

I believe it was because of the 'phy' and 'common' resets, which have
been switched below.

>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 92 +++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index a85d2ae7d155..0262193e2ffe 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -746,7 +747,7 @@ gcc: clock-controller@100000 {
>  				 <&ufs_mem_phy 0>,
>  				 <&ufs_mem_phy 1>,
>  				 <&ufs_mem_phy 2>,
> -				 <0>;
> +				 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>  		};
>  
>  		ipcc: mailbox@408000 {
> @@ -2060,6 +2061,95 @@ opp-202000000 {
>  			};
>  		};
>  
> +		usb_1_hsphy: phy@88e3000 {
> +			compatible = "qcom,sm8550-snps-eusb2-phy";
> +			reg = <0x0 0x088e3000 0x0 0x154>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&tcsr TCSR_USB2_CLKREF_EN>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_dp_qmpphy: phy@88e8000 {
> +			compatible = "qcom,sm8550-qmp-usb3-dp-phy";
> +			reg = <0x0 0x088e8000 0x0 0x3000>;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> +
> +			power-domains = <&gcc USB3_PHY_GDSC>;
> +
> +			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			reset-names = "phy", "common";
> +
> +			#clock-cells = <1>;
> +			#phy-cells = <1>;
> +
> +			status = "disabled";
> +		};

Johan
