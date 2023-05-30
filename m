Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD3B716D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjE3TNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjE3TNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:13:13 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF9DF7;
        Tue, 30 May 2023 12:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685473973; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qU7DNAy+pcGWmhjuiAm9kRZRamd3CjaN4FZNo9xxupruZsjDBjvzGYUulmhex1Zlwp
    DOiZ4qkHMR/aQpg2cu0cRw20HEyDKlNDudjwV+BGS/gjuN9rUd2pllHPAADyp9DAEgSY
    htpHb/Va2PtU8Z5jl4OlABXcLf3Ii9niXp55rSKDaqyelj8Q+1ZlB3gjIt/0RGdKCY6Y
    msD/Hql5puJ3ip7ltNIILq8P5PBiVq/L0zjFu3QoLgXMXbsjAvoPJb0w9/TxmAs0v2Bc
    kfqzMJ1IYgz6CskDpEtINT8vQsL6LcawSHipczl9zx0gY8zdJLJqLRhZiJ280SfBRzfp
    t0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685473973;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SWANTZ5LEi/i+/1OmwNVpeU8Q7B6L98dYRwCag1X3IU=;
    b=I/X0CW8WhEp2A4za5NpiYhBoom9IHdgSls/ubMEOPaT8J1rbLK3S1KeSPh9/cdkImH
    Mc8Gtpp5K7lG02FNrycaMZHZZneNAaamPSrI3sLh3NStwALNiYBo6Ba6gzeVo48veVVv
    N5jF3q9VoQqQkomhORZllXoV/2IWine2tS9h2wO8CB+tepaYN5KpXU+NufA+68ihYoGw
    cujGTpWNvsslgYNFMWeB28bjgScQ4WGRPHD8ST6PW5hl9eYrF+7T46DPoFYNxtfZNSe4
    7iMTZcmRrH7j8YkVp4sBWi4RRA4b9+tJtwumAF2NhFfz8kAZp4PuRDdb9TRFjh3WBYqE
    GTrw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685473973;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SWANTZ5LEi/i+/1OmwNVpeU8Q7B6L98dYRwCag1X3IU=;
    b=FP15hFHt7bpGY5RHvuIydONPTqUWgn24aeD7J7cIsVVjJXLrUejy1YuCBUDpJevVXz
    rPBRIk/7SgXG2EaWgrXi0HBJVyZ7muRUNHrCjJhuyeCCi31FNHu8r9kcSGXq+Uh2H+qE
    CaYRYiiwjsGhO0zC4y5I2XPVjzAeRPWjr2MNaunRs9YQpWYliWqoYHmc5At14PMNm8Kx
    Xphp8uejnz0yblvdUpE7iYSL45VJuH5lT/g2uZXqGKgIgVAgj3qFjZZxaVcMtQWp00CU
    00mW+9EyixBVFTDmsODxP1yOZ5bsRMtTO+bofUgdoFf9drpApWxf5CShK7feZklkUKNl
    YxIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685473973;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SWANTZ5LEi/i+/1OmwNVpeU8Q7B6L98dYRwCag1X3IU=;
    b=0vKC/pbXCFw865TKgWIbeMWtQkGyD0pg9Z0RZOOHqaY3uiXaPDPu+L1OTpT1tORz68
    RTtLOfqc4pWs5wpougBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4UJCqjnU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 30 May 2023 21:12:52 +0200 (CEST)
Date:   Tue, 30 May 2023 21:12:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] ARM: dts: qcom: msm8226: Add mdss nodes
Message-ID: <ZHZKriRXoh9gHpWg@gerhold.net>
References: <20230308-msm8226-mdp-v2-0-e005b769ee28@z3ntu.xyz>
 <20230308-msm8226-mdp-v2-7-e005b769ee28@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308-msm8226-mdp-v2-7-e005b769ee28@z3ntu.xyz>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:24:17PM +0200, Luca Weiss wrote:
> Add the nodes that describe the mdss so that display can work on
> MSM8226.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Can you update this to use labels like in [1]? See inline below.
This will allow proper grouping of the labels in the board DT.

Thanks,
Stephan

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=835f939501769253eb7eb2dc5389b8592a63a3ed

> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 127 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 42acb9ddb8cc..c794f5ece1d1 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -636,6 +636,133 @@ smd-edge {
>  				label = "lpass";
>  			};
>  		};
> +
> +		mdss: display-subsystem@fd900000 {
> +			compatible = "qcom,mdss";
> +			reg = <0xfd900000 0x100>, <0xfd924000 0x1000>;
> +			reg-names = "mdss_phys", "vbif_phys";
> +
> +			power-domains = <&mmcc MDSS_GDSC>;
> +
> +			clocks = <&mmcc MDSS_AHB_CLK>,
> +				 <&mmcc MDSS_AXI_CLK>,
> +				 <&mmcc MDSS_VSYNC_CLK>;
> +			clock-names = "iface",
> +				      "bus",
> +				      "vsync";
> +
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			status = "disabled";
> +
> +			mdp: display-controller@fd900000 {

			mdss_mdp:

> +				compatible = "qcom,msm8226-mdp5", "qcom,mdp5";
> +				reg = <0xfd900100 0x22000>;
> +				reg-names = "mdp_phys";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <0>;
> +
> +				clocks = <&mmcc MDSS_AHB_CLK>,
> +					 <&mmcc MDSS_AXI_CLK>,
> +					 <&mmcc MDSS_MDP_CLK>,
> +					 <&mmcc MDSS_VSYNC_CLK>;
> +				clock-names = "iface",
> +					      "bus",
> +					      "core",
> +					      "vsync";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						mdp5_intf1_out: endpoint {

						mdss_mdp_intf1_out:

> +							remote-endpoint = <&dsi0_in>;
> +						};
> +					};
> +				};
> +			};
> +
> +			dsi0: dsi@fd922800 {

			mdss_dsi0:

> +				compatible = "qcom,msm8226-dsi-ctrl",
> +					     "qcom,mdss-dsi-ctrl";
> +				reg = <0xfd922800 0x1f8>;
> +				reg-names = "dsi_ctrl";
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <4>;
> +
> +				assigned-clocks = <&mmcc BYTE0_CLK_SRC>,
> +						  <&mmcc PCLK0_CLK_SRC>;
> +				assigned-clock-parents = <&dsi_phy0 0>,
> +							 <&dsi_phy0 1>;
> +
> +				clocks = <&mmcc MDSS_MDP_CLK>,
> +					 <&mmcc MDSS_AHB_CLK>,
> +					 <&mmcc MDSS_AXI_CLK>,
> +					 <&mmcc MDSS_BYTE0_CLK>,
> +					 <&mmcc MDSS_PCLK0_CLK>,
> +					 <&mmcc MDSS_ESC0_CLK>,
> +					 <&mmcc MMSS_MISC_AHB_CLK>;
> +				clock-names = "mdp_core",
> +					      "iface",
> +					      "bus",
> +					      "byte",
> +					      "pixel",
> +					      "core",
> +					      "core_mmss";
> +
> +				phys = <&dsi_phy0>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						dsi0_in: endpoint {

						mdss_dsi0_in:

> +							remote-endpoint = <&mdp5_intf1_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dsi0_out: endpoint {

						mdss_dsi0_out:

> +						};
> +					};
> +				};
> +			};
> +
> +			dsi_phy0: phy@fd922a00 {

			mdss_dsi0_phy:

> +				compatible = "qcom,dsi-phy-28nm-8226";
> +				reg = <0xfd922a00 0xd4>,
> +				      <0xfd922b00 0x280>,
> +				      <0xfd922d80 0x30>;
> +				reg-names = "dsi_pll",
> +					    "dsi_phy",
> +					    "dsi_phy_regulator";
> +
> +				#clock-cells = <1>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&mmcc MDSS_AHB_CLK>,
> +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +				clock-names = "iface",
> +					      "ref";
> +			};
> +		};
>  	};
>  
>  	timer {
> 
> -- 
> 2.40.1
> 
