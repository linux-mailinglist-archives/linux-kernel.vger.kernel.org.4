Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC364811A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLIKot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:44:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E342FBD9;
        Fri,  9 Dec 2022 02:44:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B56CCE2912;
        Fri,  9 Dec 2022 10:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29980C433F1;
        Fri,  9 Dec 2022 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670582680;
        bh=OQ9wTdZ2DO0JGCC7roVOqbbbr7T4b+hZo3DWXx63pYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQM13xgif5a+PLhbH/IjBoJEZxsoN2owWTZmnM9KMEtM3S2lTVDVfMJ5jQMhvLmlO
         3Od8l3ME20UcEES5cCkBnF0EdqYBOgelrgHpjZiQJDH8p+mvZtx3B3NXUwkhVy4QmS
         HTs54GfS6IrOPPrAmQOEoRFtTy9vh2+czbERrauplpnsQlIitlVa/FrH2elnG0aYtJ
         Mba8xTQHrslJWgJAA0AmyoqYD77uJtEPHMY0hJdsc4IeUsIJU+RV9oN2Uw2o5EI5+c
         lGe4vfNUm+/NKqcHGnQrdoz6I4ifCirH50aes9wUgbYYF4dUjuYPpxtRv0GaqoQQd+
         R+j0rqxCGhnsw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p3asB-0003rW-Js; Fri, 09 Dec 2022 11:44:56 +0100
Date:   Fri, 9 Dec 2022 11:44:55 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/12] arm64: dts: qcom: sa8295-adp: Enable DP
 instances
Message-ID: <Y5MRp5rWmW8ib+9f@hovoldconsulting.com>
References: <20221207220012.16529-1-quic_bjorande@quicinc.com>
 <20221207220012.16529-13-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207220012.16529-13-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:00:12PM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SA8295P ADP has, among other interfaces, six MiniDP connectors which
> are connected to MDSS0 DP2 and DP3, and MDSS1 DP0 through DP3.
> 
> Enable Display Clock controllers, MDSS instanced, MDPs, DP controllers,
> DP PHYs and link them all together.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v4:
> - None
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 243 ++++++++++++++++++++++-
>  1 file changed, 241 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index 6c29d7d757e0..d55c8c5304cc 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts

> +&mdss0_dp2 {
> +	status = "okay";

Please move 'status' last.

> +
> +	data-lanes = <0 1 2 3>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp2_phy_out: endpoint {
> +				remote-endpoint = <&edp0_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp2_phy {
> +	status = "okay";

Same here.

> +
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss0_dp3 {
> +	status = "okay";

And here.

> +
> +	data-lanes = <0 1 2 3>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss0_dp3_phy_out: endpoint {
> +				remote-endpoint = <&edp1_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss0_dp3_phy {
> +	status = "okay";

And here.

> +
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1 {
> +	status = "okay";
> +};
> +
> +&mdss1_dp0 {
> +	status = "okay";

And here.

> +
> +	data-lanes = <0 1 2 3>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp0_phy_out: endpoint {
> +				remote-endpoint = <&dp2_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp0_phy {
> +	status = "okay";

Ditto.

> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1_dp1 {
> +	status = "okay";

Ditto.

> +
> +	data-lanes = <0 1 2 3>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp1_phy_out: endpoint {
> +				remote-endpoint = <&dp3_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp1_phy {
> +	status = "okay";

Ditto.

> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1_dp2 {
> +	status = "okay";

Ditto.

> +
> +	data-lanes = <0 1 2 3>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp2_phy_out: endpoint {
> +				remote-endpoint = <&edp2_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp2_phy {
> +	status = "okay";

Ditto.

> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&mdss1_dp3 {
> +	status = "okay";

Ditto.

> +
> +	data-lanes = <0 1 2 3>;
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;
> +			mdss1_dp3_phy_out: endpoint {
> +				remote-endpoint = <&edp3_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss1_dp3_phy {
> +	status = "okay";

Ditto.

> +
> +	vdda-phy-supply = <&vreg_l11g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
>  &pcie2a {
>  	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
>  	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;

Johan
