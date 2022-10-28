Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1DE611374
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiJ1NqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiJ1No4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:44:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA132EF4;
        Fri, 28 Oct 2022 06:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3BF0B82A32;
        Fri, 28 Oct 2022 13:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F03C4FF10;
        Fri, 28 Oct 2022 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666964683;
        bh=LcKz3O85jBpORVzoqD8hoLCMY+nPoqxJwOLtUvB36iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r37lpyLRxXnxvD0akaCLv34DqqisYLps+u/LHPs3w1mwog9eES0udif1wSfocOSZO
         pkVjJWtwjzvzG/BqCatD7SGYXYlDl7eLokaLMRIJVOLidhIQAJG1PF2+PsJSdGylgN
         RdRW6X8S647MQ/mQUOCXhH/KJBQajjjQX9rnuuH3HXKUFy9Hle646o8Wei9dIJr6q5
         cIWks98dOZAZ+SQJJi4e635yOhVT1rbiV/HM+urocmQbWlIcckPTZLOXbUb6iJqea5
         2ycHu9aZGRaupG7zF/1CobmpTaPSGOATqfWziSh1PwA3ZLaVtF8u8qxIkUMXO/O5sO
         DREHJfM+tVLLg==
Date:   Fri, 28 Oct 2022 08:44:39 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com
Subject: Re: [PATCH v1 6/9] arm64: dts: qcom: sm8350: Use 2 interconnect cells
Message-ID: <20221028134439.ugja55guopmql4nk@baldur>
References: <20221028120812.339100-1-robert.foss@linaro.org>
 <20221028120812.339100-7-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028120812.339100-7-robert.foss@linaro.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:08:09PM +0200, Robert Foss wrote:
> Use two interconnect cells in order to optionally
> support a path tag.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 606fab087945..b6e44cd3b394 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1543,56 +1543,56 @@ apps_smmu: iommu@15000000 {
>  		config_noc: interconnect@1500000 {
>  			compatible = "qcom,sm8350-config-noc";
>  			reg = <0 0x01500000 0 0xa580>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;

You also need amend all the interconnects references with the additional
tag cell.

Regards,
Bjorn

>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		mc_virt: interconnect@1580000 {
>  			compatible = "qcom,sm8350-mc-virt";
>  			reg = <0 0x01580000 0 0x1000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		system_noc: interconnect@1680000 {
>  			compatible = "qcom,sm8350-system-noc";
>  			reg = <0 0x01680000 0 0x1c200>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		aggre1_noc: interconnect@16e0000 {
>  			compatible = "qcom,sm8350-aggre1-noc";
>  			reg = <0 0x016e0000 0 0x1f180>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		aggre2_noc: interconnect@1700000 {
>  			compatible = "qcom,sm8350-aggre2-noc";
>  			reg = <0 0x01700000 0 0x33000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		mmss_noc: interconnect@1740000 {
>  			compatible = "qcom,sm8350-mmss-noc";
>  			reg = <0 0x01740000 0 0x1f080>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		lpass_ag_noc: interconnect@3c40000 {
>  			compatible = "qcom,sm8350-lpass-ag-noc";
>  			reg = <0 0x03c40000 0 0xf080>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		compute_noc: interconnect@a0c0000{
>  			compatible = "qcom,sm8350-compute-noc";
>  			reg = <0 0x0a0c0000 0 0xa180>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> @@ -2420,14 +2420,14 @@ usb_2_ssphy: phy@88ebe00 {
>  		dc_noc: interconnect@90c0000 {
>  			compatible = "qcom,sm8350-dc-noc";
>  			reg = <0 0x090c0000 0 0x4200>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
>  		gem_noc: interconnect@9100000 {
>  			compatible = "qcom,sm8350-gem-noc";
>  			reg = <0 0x09100000 0 0xb4000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> -- 
> 2.34.1
> 
