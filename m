Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB4F670D05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjAQXPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjAQXNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8252A14A;
        Tue, 17 Jan 2023 12:58:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA5BBB819B0;
        Tue, 17 Jan 2023 20:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39F7C433F2;
        Tue, 17 Jan 2023 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673989084;
        bh=kSbtYgfEYRDJQLRjZGOgB7sOGnCZFG8dk3OebFDhVGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCCFukQCO4d/fpfQgIQyqsjTZvkI4EmNpjLBQYM+kFAXHJGBUV3BpgZC5CoxoJGUg
         ChcFsK86KBMwhSPz41en3YKgyDAjILDUc/hSBoBOZBFnrprj3skp6NXzFczFANbh0Q
         gXpUBXwYUiME1E7eoDCPjpidVO2ncHFxU7AIelpHRL3y2GSJC1/OXYr7juWQHy3t+R
         EaMYMmiaoVEGDN9ggRRzbfxPpL7QSMggn2xE5blTC7286ED3IRv+NrZWLK9FPNqFYe
         3EgIaE6oP46ET8CQCjHembyqBSRpscbDxZR/6adBUfTjBLMGWXstct/uuJKGePnYtQ
         12roTGJDJDclA==
Date:   Tue, 17 Jan 2023 14:58:00 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <20230117205800.cqexxwxmtupapy7e@builder.lan>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:48:43AM +0000, Bryan O'Donoghue wrote:
> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
> differences to msm8916.
> 
> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
> - DRAM 1x800 LPDDR3
> - Camera 4+4 lane CSI
> - Venus @ 1080p60 HEVC
> - DSI x 2
> - Adreno A405
> - WiFi wcn3660/wcn3680b 802.11ac
> 
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Co-developed-by: Jun Nie <jun.nie@linaro.org>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> Co-developed-by: Benjamin Li <benl@squareup.com>
> Signed-off-by: Benjamin Li <benl@squareup.com>
> Co-developed-by: James Willcox <jwillcox@squareup.com>
> Signed-off-by: James Willcox <jwillcox@squareup.com>
> Co-developed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Co-developed-by: Joseph Gates <jgates@squareup.com>
> Signed-off-by: Joseph Gates <jgates@squareup.com>
> Co-developed-by: Max Chen <mchen@squareup.com>
> Signed-off-by: Max Chen <mchen@squareup.com>
> Co-developed-by: Zac Crosby <zac@squareup.com>
> Signed-off-by: Zac Crosby <zac@squareup.com>
> Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Just to make sure when I get the question, you all co-developed this
patch, right?

> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi | 2393 +++++++++++++++++++++++++
>  1 file changed, 2393 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> new file mode 100644
> index 0000000000000..8cd358a9fe623
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
> @@ -0,0 +1,2393 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2020-2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-msm8939.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/interconnect/qcom,msm8939.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/reset/qcom,gcc-msm8939.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;

Why do you use a default of 2? In particular since you reduce it to 1 in
/soc...

> +
> +	clocks {
> +		xo_board: xo-board {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <19200000>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +		};
> +	};
[..]
> +	smp2p-hexagon {

To avoid having people start sending patches that changes the sort order
as soon as I merge this, could you please sort your nodes by address
(not applicable for this one), then by node name alphabetically, then by
label alphabetically.

> +		compatible = "qcom,smp2p";
> +		qcom,smem = <435>, <428>;
> +
> +		interrupts = <GIC_SPI 27 IRQ_TYPE_EDGE_RISING>;
> +
> +		mboxes = <&apcs1_mbox 14>;
> +
> +		qcom,local-pid = <0>;
> +		qcom,remote-pid = <1>;
> +
> +		hexagon_smp2p_out: master-kernel {
> +			qcom,entry-name = "master-kernel";
> +
> +			#qcom,smem-state-cells = <1>;
> +		};
> +
> +		hexagon_smp2p_in: slave-kernel {
> +			qcom,entry-name = "slave-kernel";
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the reg */
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};
> +
[..]
> +	soc: soc@0 {
[..]
> +		pronto: remoteproc@a204000 {
> +			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
> +			reg = <0x0a204000 0x2000>,
> +			      <0x0a202000 0x1000>,
> +			      <0x0a21b000 0x3000>;
> +			reg-names = "ccu", "dxe", "pmu";
> +
> +			interrupts-extended = <&intc 0 149 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
> +			interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
> +
> +			memory-region = <&wcnss_mem>;
> +
> +			power-domains = <&rpmpd MSM8939_VDDCX>,
> +					<&rpmpd MSM8939_VDDMX_AO>;

The purpose of the remoteproc driver's vote is to keep the rails powered
while we're booting the remote, in the event that Linux decides to
suspend and turn of the power rails while we're waiting...

Once the remote pulls the "handover" interrupt, it signals that it has
cast the necessary votes and need no more hand-holding.

So it's unlikely that _AO is the right choice here.

> +			power-domain-names = "cx", "mx";
> +
> +			qcom,smem-states = <&wcnss_smp2p_out 0>;
> +			qcom,smem-state-names = "stop";
> +
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&wcnss_pin_a>;
> +
> +			status = "disabled";
> +
> +			iris {
> +				compatible = "qcom,wcn3620";
> +				clocks = <&rpmcc RPM_SMD_RF_CLK2>;
> +				clock-names = "xo";
> +			};
> +
> +			smd-edge {
> +				interrupts = <GIC_SPI 142 1>;
> +				qcom,ipc = <&apcs1_mbox 8 17>;
> +				qcom,smd-edge = <6>;
> +				qcom,remote-pid = <4>;
> +
> +				label = "pronto";
> +
> +				wcnss {
> +					compatible = "qcom,wcnss";
> +					qcom,smd-channels = "WCNSS_CTRL";
> +
> +					qcom,mmio = <&pronto>;
> +
> +					bluetooth {
> +						compatible = "qcom,wcnss-bt";
> +					};
> +
> +					wifi {
> +						compatible = "qcom,wcnss-wlan";
> +
> +						interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
> +							     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
> +						interrupt-names = "tx", "rx";
> +
> +						qcom,smem-states = <&apps_smsm 10>,
> +								   <&apps_smsm 9>;
> +						qcom,smem-state-names = "tx-enable",
> +									"tx-rings-empty";
> +					};
> +				};
> +			};
> +		};
> +	};
> +
> +	smd {

"so" < "sm"

> +		compatible = "qcom,smd";
> +
> +		rpm {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs1_mbox 8 0>;
> +			qcom,smd-edge = <15>;
> +
> +			rpm_requests: rpm-requests {
> +				compatible = "qcom,rpm-msm8936";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8936", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +					clock-names = "xo";
> +					clocks = <&xo_board>;
> +				};
> +
> +				rpmpd: power-controller {
> +					compatible = "qcom,msm8939-rpmpd";
> +					#power-domain-cells = <1>;
> +					operating-points-v2 = <&rpmpd_opp_table>;
> +
> +					rpmpd_opp_table: opp-table {
> +						compatible = "operating-points-v2";
> +
> +						rpmpd_opp_ret: opp1 {
> +							opp-level = <1>;
> +						};
> +
> +						rpmpd_opp_svs_krait: opp2 {
> +							opp-level = <2>;
> +						};
> +
> +						rpmpd_opp_svs_soc: opp3 {
> +							opp-level = <3>;
> +						};
> +
> +						rpmpd_opp_nom: opp4 {
> +							opp-level = <4>;
> +						};
> +
> +						rpmpd_opp_turbo: opp5 {
> +							opp-level = <5>;
> +						};
> +
> +						rpmpd_opp_super_turbo: opp6 {
> +							opp-level = <6>;
> +						};
> +					};
> +				};
> +			};
> +		};
> +	};
[..]
> +
> +	/* Dummy regulator for our non-psci cpu@X defintions */

It's a power-supply...

> +	vreg_dummy: regulator-dummy {
> +		#power-domain-cells = <0>;
> +	};
> +
> +	smp2p-wcnss {

This belongs up by the other smp2p node.

Regards,
Bjorn
