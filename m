Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC964322F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiLETZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiLETYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:24:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F82C116;
        Mon,  5 Dec 2022 11:19:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFADB6131A;
        Mon,  5 Dec 2022 19:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A03C433D6;
        Mon,  5 Dec 2022 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670267984;
        bh=FZHTOaos5sxsoVzWostw+hca7YvkdqEguBNcKHP2FoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ukY3FQ2NI2bH5nXNzjfkqd2AOzA4oM3OGJCZ9aV69IR6lbbf0OsaSruYTbc/Fo+dM
         267faZVMAmn+Tqtxzc6EgI2NgTCAJk95gs3dBR5g4+mpDW5W6ddACzzi3jTU601Kfg
         XWi+eGZNlI0qSkmiHjYjRkQNC2IJ2moJU5UkTnEhDuuYuW0M6L/4d0h8FnkFz7C5Nw
         IqoeHQocE2MRBKHS7XVZaVgqvioh9/IbzS3sfJpSdFTtOK12Cyq/bfm9ScDm7ReLSt
         vs1rwdWtWQJUfaqnKr7wAVdR6oO9SofCjhYTsoscnWoafMBY2Q2l6o6t7dDTNn/lPB
         xu7wsJRgARF6A==
Message-ID: <60884c0e-7533-788b-2f93-c128cf7d27fd@kernel.org>
Date:   Mon, 5 Dec 2022 21:19:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 08/11] arm64: dts: qcom: sm8350: Use 2 interconnect
 cells
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, robdclark@gmail.com,
        quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, quic_kalyant@quicinc.com,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        swboyd@chromium.org, quic_vpolimer@quicinc.com, vkoul@kernel.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>, vinod.koul@linaro.org,
        quic_jesszhan@quicinc.com, andersson@kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221205163754.221139-1-robert.foss@linaro.org>
 <20221205163754.221139-9-robert.foss@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221205163754.221139-9-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On 5.12.22 18:37, Robert Foss wrote:
> Use two interconnect cells in order to optionally
> support a path tag.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 805d53d91952..434f8e8b12c1 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1543,56 +1543,56 @@ apps_smmu: iommu@15000000 {
>   		config_noc: interconnect@1500000 {
>   			compatible = "qcom,sm8350-config-noc";
>   			reg = <0 0x01500000 0 0xa580>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
>   		mc_virt: interconnect@1580000 {
>   			compatible = "qcom,sm8350-mc-virt";
>   			reg = <0 0x01580000 0 0x1000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
[..]
> @@ -1620,8 +1620,8 @@ ipa: ipa@1e40000 {
>   			clocks = <&rpmhcc RPMH_IPA_CLK>;
>   			clock-names = "core";
>   
> -			interconnects = <&aggre2_noc MASTER_IPA &mc_virt SLAVE_EBI1>,
> -					<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_IPA_CFG>;
> +			interconnects = <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
>   			interconnect-names = "memory",
>   					     "config";
>   
> @@ -1661,7 +1661,7 @@ mpss: remoteproc@4080000 {
>   					<&rpmhpd SM8350_MSS>;
>   			power-domain-names = "cx", "mss";
>   
> -			interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
> +			interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1 0>;

The second cell for the first endpoint is missing, so this should be:
	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;

Thanks,
Georgi

>   
>   			memory-region = <&pil_modem_mem>;
>   
> @@ -2239,7 +2239,7 @@ cdsp: remoteproc@98900000 {
>   					<&rpmhpd SM8350_MXC>;
>   			power-domain-names = "cx", "mxc";
>   
> -			interconnects = <&compute_noc MASTER_CDSP_PROC &mc_virt SLAVE_EBI1>;
> +			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
>   
>   			memory-region = <&pil_cdsp_mem>;
>   
> @@ -2421,14 +2421,14 @@ usb_2_ssphy: phy@88ebe00 {
>   		dc_noc: interconnect@90c0000 {
>   			compatible = "qcom,sm8350-dc-noc";
>   			reg = <0 0x090c0000 0 0x4200>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   
>   		gem_noc: interconnect@9100000 {
>   			compatible = "qcom,sm8350-gem-noc";
>   			reg = <0 0x09100000 0 0xb4000>;
> -			#interconnect-cells = <1>;
> +			#interconnect-cells = <2>;
>   			qcom,bcm-voters = <&apps_bcm_voter>;
>   		};
>   

