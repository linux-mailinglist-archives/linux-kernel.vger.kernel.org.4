Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32958697944
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjBOJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbjBOJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:46:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4A36459;
        Wed, 15 Feb 2023 01:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C097C61AC1;
        Wed, 15 Feb 2023 09:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2494CC433D2;
        Wed, 15 Feb 2023 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676454405;
        bh=Jor57+yRXIkq/owLmTQVrQYrWDjgXONmDNhnp32CUfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDM+KRB3urZEkN6LH7dCQC6OZumuCXtAHKvYDdGNYWnt33OBrP/cWLvZvpmOZq1tm
         gfeh3P1VaauiogfXkH6yDitMYGLfZnt7/nFJCBDwTuORMso1AZUeN6oF4f+tabrGyt
         MYLpPMK0eHtbDBA4oqU2szxa/NSDEVIgsnuneq0NpOTOYvLHcPXdX/h2Ta9sM/8he7
         qpBhCYOaIS637nFOIbXrT7b5ifhs0j+eu3xXakAhrJTcpebi10m8dL7Mw4aDjY3lzg
         wmetZ55kGcw3N6xNEBpL+QWP978LsBJTetqYwac1yyaogtqlMbqN8wq26qHukXlPY6
         XH3jvgfYwiBuQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSEO4-0006dR-Em; Wed, 15 Feb 2023 10:47:41 +0100
Date:   Wed, 15 Feb 2023 10:47:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sc8280xp-crd: Introduce
 pmic_glink
Message-ID: <Y+yqPMdiuJ+ssisR@hovoldconsulting.com>
References: <20230213215619.1362566-1-quic_bjorande@quicinc.com>
 <20230213215619.1362566-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213215619.1362566-3-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 01:56:17PM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SC8280XP CRD control over battery management and its two USB Type-C
> port using pmic_glink and two GPIO-based SBU muxes.
> 
> Enable the two DisplayPort instances, GPIO SBU mux instance and
> pmic_glink with the two connectors on the CRD.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v3:
> - Moved data-lanes into dp/port/endpoint
> - Moved dp/port/endpoint definition to sc8280xp.dtsi, and reference by
>   label - to avoid repeating structure in the dts
> 
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 196 +++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi    |  17 ++
>  2 files changed, 211 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index 2179c06b4e3b..98a0f1f9f01e 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -36,6 +36,84 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	pmic-glink {
> +		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		connector@0 {
> +			compatible = "usb-c-connector";
> +			reg = <0>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_con0_hs: endpoint {
> +						remote-endpoint = <&usb_0_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_con0_ss: endpoint {
> +						remote-endpoint = <&mdss0_dp0_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_con0_sbu: endpoint {
> +						remote-endpoint = <&usb0_sbu_mux>;
> +					};
> +				};
> +			};
> +		};
> +
> +		connector@1 {
> +			compatible = "usb-c-connector";
> +			reg = <1>;
> +			power-role = "dual";
> +			data-role = "dual";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;

Nit: add a newline for consistency

> +				port@0 {
> +					reg = <0>;
> +
> +					pmic_glink_con1_hs: endpoint {
> +						remote-endpoint = <&usb_1_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					pmic_glink_con1_ss: endpoint {
> +						remote-endpoint = <&mdss0_dp1_out>;
> +					};
> +				};
> +
> +				port@2 {
> +					reg = <2>;
> +
> +					pmic_glink_con1_sbu: endpoint {
> +						remote-endpoint = <&usb1_sbu_mux>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +
>  	vreg_edp_3p3: regulator-edp-3p3 {
>  		compatible = "regulator-fixed";
  
> @@ -262,6 +380,24 @@ &mdss0 {
>  	status = "okay";
>  };
>  
> +&mdss0_dp0 {
> +	status = "okay";
> +};
> +
> +&mdss0_dp0_out {
> +	data-lanes = <0 1>;

This does not work as the drm driver expects 'data-lanes' to be defined
in the controller node where you had it in the previous versions:

	[    6.669325] [drm] Invalid property "data-lanes", default max DP lanes = 4

Moving it to the endpoint nodes would require updating both binding and
driver it seems.

> +	remote-endpoint = <&pmic_glink_con0_ss>;
> +};
> +
> +&mdss0_dp1 {
> +	status = "okay";
> +};
> +
> +&mdss0_dp1_out {
> +	data-lanes = <0 1>;

Same here (and for X13s).

> +	remote-endpoint = <&pmic_glink_con1_ss>;
> +};
> +
>  &mdss0_dp3 {
>  	compatible = "qcom,sc8280xp-edp";
>  	/delete-property/ #sound-dai-cells;

Johan
