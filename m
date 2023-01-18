Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B125671C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjARMdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjARMco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:32:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BE5CE4D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:50:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b7so7664576wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YWB/ese8ZwFRllWf7nsL8bsDpP0Q+wo0YCV75hUGQzo=;
        b=JuUKSeBAwcrUCHjkFD+bc8yUghPGtoTEKWu8FkcVgI3zkhapD5uoRva+qjhxGPwcfl
         IkhYnuDciQXbDh8Nj+UB/0Iusz9WE1bzWA2zdZCmsGYl4fpyeQ3ONjNotO+AdQ1NYOVE
         kOHibAYl2i8O0A7u7DuTaFFuoH+sIt6jyDrVRapt8K14H+yP9MELbhlEA9TQi+BxkTdI
         RNzIzEtkngVS2mluLtBqVco2qe8BFF+adg4xvUP4gljV7O1wBm4wMGMEY3id2DjP8f8j
         ROLHMjqf/wF5AOu3WK/SS5Jqt3c2g/rPI2H3ycBceyJNx3sZWmSMzfMnufaBFWahahYg
         nFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YWB/ese8ZwFRllWf7nsL8bsDpP0Q+wo0YCV75hUGQzo=;
        b=4SjO47Tfg1032jPbHWcMVP0aCY9n/PxCG3pxYynUYgT//eAETjbJQzyHbVQH7pRBL3
         d9jX/bcyDXXWo2R7xuqjdIeLPgbR3eVeYDRp4cFCpHY83q3xz4dnNBeJaAlKNWoX39uO
         yQKcUsjY5/E0Uc8VNMGhDVVSLd3/Qko1GIjZnCL8i/oIXcIwiOtEZ2utXjc+cb6W45k5
         VwGEoe0y+QytkXaomLu2QrGnosq/s737Mux7ULBCfc//7ati0DAcktnUIIxlJs9MGiJ0
         EGNmdhUvdwksI+nJUKP6QQRK1BnusPI+bw+Z1z630Viuhfo6tebthoK88ZTH/JD6FfEH
         ztVA==
X-Gm-Message-State: AFqh2kqrJW3wDnEV4UvPlq0I4O70Il4gqcbkOCgyGPSVY7DnpWN5Hi4U
        GHJBuGIYF10cuKGNb+Htme+VOQ==
X-Google-Smtp-Source: AMrXdXu2RaAvdT+CrF34XcTNF2qHGw/JsiNlQDZe8hlX5Nv+jLDpCCcNilRCjvYtITnFSZ2Bb9NApw==
X-Received: by 2002:a05:6000:1f14:b0:2bb:5adc:9f92 with SMTP id bv20-20020a0560001f1400b002bb5adc9f92mr6107322wrb.50.1674042622795;
        Wed, 18 Jan 2023 03:50:22 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h3-20020adfe983000000b002bdf5832843sm10298027wrm.66.2023.01.18.03.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 03:50:22 -0800 (PST)
Message-ID: <cf4920e6-c007-20a5-ba3a-5005b22f891b@linaro.org>
Date:   Wed, 18 Jan 2023 11:50:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <Y8fC/GCHfENQmBNC@gerhold.net>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y8fC/GCHfENQmBNC@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 09:59, Stephan Gerhold wrote:
> On Tue, Jan 17, 2023 at 02:48:43AM +0000, Bryan O'Donoghue wrote:
>> Add msm8939 a derivative SoC of msm8916. This SoC contains a number of key
>> differences to msm8916.
>>
>> - big.LITTLE Octa Core - quad 1.5GHz + quad 1.0GHz
>> - DRAM 1x800 LPDDR3
>> - Camera 4+4 lane CSI
>> - Venus @ 1080p60 HEVC
>> - DSI x 2
>> - Adreno A405
>> - WiFi wcn3660/wcn3680b 802.11ac
>>
>> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Co-developed-by: Jun Nie <jun.nie@linaro.org>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>> Co-developed-by: Benjamin Li <benl@squareup.com>
>> Signed-off-by: Benjamin Li <benl@squareup.com>
>> Co-developed-by: James Willcox <jwillcox@squareup.com>
>> Signed-off-by: James Willcox <jwillcox@squareup.com>
>> Co-developed-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Co-developed-by: Joseph Gates <jgates@squareup.com>
>> Signed-off-by: Joseph Gates <jgates@squareup.com>
>> Co-developed-by: Max Chen <mchen@squareup.com>
>> Signed-off-by: Max Chen <mchen@squareup.com>
>> Co-developed-by: Zac Crosby <zac@squareup.com>
>> Signed-off-by: Zac Crosby <zac@squareup.com>
>> Co-developed-by: Vincent Knecht <vincent.knecht@mailoo.org>
>> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
>> Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/msm8939.dtsi | 2393 +++++++++++++++++++++++++
>>   1 file changed, 2393 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/msm8939.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>> new file mode 100644
>> index 0000000000000..8cd358a9fe623
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>> @@ -0,0 +1,2393 @@
>> [...]
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu0: cpu@100 {
>> +			compatible = "arm,cortex-a53";
>> +			device_type = "cpu";
>> +			enable-method = "spin-table";
>> +			reg = <0x100>;
>> +			next-level-cache = <&L2_1>;
>> +			power-domains = <&vreg_dummy>;
>> +			power-domain-names = "cpr";
> 
> Why are you adding a dummy power domain here? IMO this would be better
> added together with CPR. Especially because I would expect two power
> domains here later ("mx", "cpr"). For cpufreq you also need to make
> votes for the "MSM8939_VDDMX" power domain.

I'm pretty sure there's binding checks that demand this but, I will 
re-verify it.

> 
>> +			qcom,acc = <&acc0>;
>> +			qcom,saw = <&saw0>;
>> +			cpu-idle-states = <&CPU_SLEEP_0>;
>> +			clocks = <&apcs1_mbox>;
>> +			#cooling-cells = <2>;
>> +			L2_1: l2-cache {
>> +				compatible = "cache";
>> +				cache-level = <2>;
>> +			};
>> +		};
>> [...]
>> +	soc: soc@0 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +
>> +		rng@22000 {
>> +			compatible = "qcom,prng";
>> +			reg = <0x00022000 0x200>;
>> +			clocks = <&gcc GCC_PRNG_AHB_CLK>;
>> +			clock-names = "core";
>> +		};
>> +
>> +		qfprom: qfprom@5c000 {
>> +			compatible = "qcom,msm8916-qfprom", "qcom,qfprom";
>> +			reg = <0x0005c000 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +
>> +			tsens_caldata: caldata@a0 {
>> +				reg = <0xa0 0x5c>;
>> +			};
>> +			cpr_efuse_init_voltage1: ivoltage1@dc {
>> +				reg = <0xdc 0x4>;
>> +				bits = <4 6>;
>> +			};
>> +			cpr_efuse_init_voltage2: ivoltage2@da {
>> +				reg = <0xda 0x4>;
>> +				bits = <2 6>;
>> +			};
>> +			cpr_efuse_init_voltage3: ivoltage3@d8 {
>> +				reg = <0xd8 0x4>;
>> +				bits = <0 6>;
>> +			};
>> +			cpr_efuse_quot1: quot1@dd {
>> +				reg = <0xdd 0x8>;
>> +				bits = <2 12>;
>> +			};
>> +			cpr_efuse_quot2: quot2@db {
>> +				reg = <0xdb 0x8>;
>> +				bits = <0x0 12>;
>> +			};
>> +			cpr_efuse_ring1: ring1@de {
>> +				reg = <0xde 0x4>;
>> +				bits = <6 3>;
>> +			};
>> +			cpr_efuse_revision: revision@5 {
>> +				reg = <0x5 0x1>;
>> +				bits = <5 1>;
>> +			};
>> +			cpr_efuse_revision_high: revision-high@7 {
>> +				reg = <0x7 0x1>;
>> +				bits = <0 1>;
>> +			};
>> +			cpr_efuse_pvs_version: pvs@3 {
>> +				reg = <0x3 0x1>;
>> +				bits = <5 1>;
>> +			};
>> +			cpr_efuse_pvs_version_high: pvs-high@6 {
>> +				reg = <0x6 0x1>;
>> +				bits = <2 2>;
>> +			};
>> +			cpr_efuse_speedbin: speedbin@c {
>> +				reg = <0xc 0x1>;
>> +				bits = <2 3>;
>> +			};
> 
> Please add the CPR items later together with CPR. This will make the
> review a bit easier because we don't need to check that these are right
> for the initial submission.

I will excise this if I can, i.e. if the system will still boot once done.

> 
>> +		};
>> [...]
>> +		mdss: display-subsystem@1a00000 {
>> +			compatible = "qcom,mdss";
>> +			reg = <0x01a00000 0x1000>,
>> +			      <0x01ac8000 0x3000>;
>> +			reg-names = "mdss_phys", "vbif_phys";
>> +
>> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +
>> +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +				 <&gcc GCC_MDSS_AXI_CLK>,
>> +				 <&gcc GCC_MDSS_VSYNC_CLK>;
>> +			clock-names = "iface",
>> +				      "bus",
>> +				      "vsync";
>> +
>> +			power-domains = <&gcc MDSS_GDSC>;
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			#interrupt-cells = <1>;
>> +			ranges;
>> +
>> +			mdp: display-controller@1a01000 {
>> +				compatible = "qcom,mdp5";
>> +				reg = <0x01a01000 0x89000>;
>> +				reg-names = "mdp_phys";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <0>;
>> +
>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>> +					 <&gcc GCC_MDSS_MDP_CLK>,
>> +					 <&gcc GCC_MDSS_VSYNC_CLK>,
>> +					 <&gcc GCC_MDP_TBU_CLK>,
>> +					 <&gcc GCC_MDP_RT_TBU_CLK>;
>> +				clock-names = "iface",
>> +					      "bus",
>> +					      "core",
>> +					      "vsync",
>> +					      "tbu",
>> +					      "tbu_rt";
>> +
>> +				iommus = <&apps_iommu 4>;
>> +
>> +				interconnects = <&snoc_mm MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
>> +						<&snoc_mm MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>,
>> +						<&pcnoc MASTER_SPDM &snoc SLAVE_IMEM>;
>> +				interconnect-names = "mdp0-mem", "mdp1-mem", "register-mem";
> 
> As I mentioned a already in a direct email at some point, AFAIU adding
> interconnects should be an [almost-] all or nothing step. If you only
> add interconnects for MDP then everything else that needs bandwidth will
> either break or only continue working as a mere side effect of MDP
> voting for permanent high bandwidth.

We did discuss that. You'll also recall we concluded we would have to 
revert this patch to make that happen.

commit 76a748e2c1aa976d0c7fef872fa6ff93ce334a8a
Author: Leo Yan <leo.yan@linaro.org>
Date:   Sat Apr 16 09:26:34 2022 +0800

     interconnect: qcom: msm8939: Use icc_sync_state

but then why not revert for all of these SoCs too ?

drivers/interconnect/qcom/msm8939.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/msm8974.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/msm8996.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/osm-l3.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sc7180.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sc7280.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sc8180x.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sc8280xp.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sdm845.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sdx55.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sdx65.c:		.sync_state = icc_sync_state,
drivers/interconnect/qcom/sm6350.c:		.sync_state = icc_sync_state,

until such time as we have an all or nothing interconnect setup for each 
of those SoCs ?

Yes I take your point "some peripherals will appear to work only as a 
result of the AHB vote the MDP casts here" but, that is a bug in the 
definition of that hypothetical peripheral.

The MDP/display won't run without the interconnect here and the only way 
to pull it is to remove sync_state which begs the question why not pull 
sync_state for all SoCs without a perfect interconnect description ?

I think that would be a retrograde step.

> (Semi-related side note: "register-mem" is neither documented nor used
>   anywhere in the code?)

Oh do you have me there though, this is a holdover from the Android 
dtsi. I'll see if it makes a difference dropping this.

> 
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdp5_intf1_out: endpoint {
>> +							remote-endpoint = <&dsi0_in>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						mdp5_intf2_out: endpoint {
>> +							remote-endpoint = <&dsi1_in>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +
>> +			dsi0: dsi@1a98000 {
>> +				compatible = "qcom,msm8916-dsi-ctrl",
>> +					     "qcom,mdss-dsi-ctrl";
>> +				reg = <0x01a98000 0x25c>;
>> +				reg-names = "dsi_ctrl";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <4>;
>> +
>> +				power-domains = <&gcc MDSS_GDSC>;
> 
> Why is MDSS_GDSC defined again here? The parent-child relationship of
> MDSS->MDP should ensure that the MDSS_GDSC from the parent mdss node
> is on when dsi is.
> 
>> +
>> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
>> +					 <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>> +					 <&gcc GCC_MDSS_BYTE0_CLK>,
>> +					 <&gcc GCC_MDSS_PCLK0_CLK>,
>> +					 <&gcc GCC_MDSS_ESC0_CLK>;
>> +				clock-names = "mdp_core",
>> +					      "iface",
>> +					      "bus",
>> +					      "byte",
>> +					      "pixel",
>> +					      "core";
>> +				assigned-clocks = <&gcc BYTE0_CLK_SRC>,
>> +						  <&gcc PCLK0_CLK_SRC>;
>> +				assigned-clock-parents = <&dsi_phy0 0>,
>> +							 <&dsi_phy0 1>;
>> +
>> +				phys = <&dsi_phy0>;
>> +				status = "disabled";
>> +
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						dsi0_in: endpoint {
>> +							remote-endpoint = <&mdp5_intf1_out>;
>> +						};
>> +					};
>> +
>> +					port@1 {
>> +						reg = <1>;
>> +						dsi0_out: endpoint {
>> +						};
>> +					};
>> +				};
>> +			};
>> +
>> +			dsi_phy0: phy@1a98300 {
>> +				compatible = "qcom,dsi-phy-28nm-lp";
>> +				reg = <0x01a98300 0xd4>,
>> +				      <0x01a98500 0x280>,
>> +				      <0x01a98780 0x30>;
>> +				reg-names = "dsi_pll",
>> +					    "dsi_phy",
>> +					    "dsi_phy_regulator";
>> +
>> +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>> +				clock-names = "iface", "ref";
>> +
>> +				#clock-cells = <1>;
>> +				#phy-cells = <0>;
>> +				status = "disabled";
>> +			};
>> +
>> +			dsi1: dsi@1aa0000 {
>> +				compatible = "qcom,msm8916-dsi-ctrl",
>> +					     "qcom,mdss-dsi-ctrl";
>> +				reg = <0x01aa0000 0x25c>;
>> +				reg-names = "dsi_ctrl";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <5>;
>> +
>> +				power-domains = <&gcc MDSS_GDSC>;
>> +
>> +				clocks = <&gcc GCC_MDSS_MDP_CLK>,
>> +					 <&gcc GCC_MDSS_AHB_CLK>,
>> +					 <&gcc GCC_MDSS_AXI_CLK>,
>> +					 <&gcc GCC_MDSS_BYTE1_CLK>,
>> +					 <&gcc GCC_MDSS_PCLK1_CLK>,
>> +					 <&gcc GCC_MDSS_ESC1_CLK>;
>> +				clock-names = "mdp_core",
>> +					      "iface",
>> +					      "bus",
>> +					      "byte",
>> +					      "pixel",
>> +					      "core";
>> +				assigned-clocks = <&gcc BYTE1_CLK_SRC>,
>> +						  <&gcc PCLK1_CLK_SRC>;
>> +				assigned-clock-parents = <&dsi_phy1 0>,
>> +							 <&dsi_phy1 1>;
> 
> Does this work? Confusingly, BYTE1/PCLK1_CLK_SRC can only have dsi0pll
> as parent in gcc-msm8939 and not the dsi1pll. <&dsi_phy1 0/1> is not a
> valid parent for those clocks.

No you're right, its all wrong. I will correct it

         mdss_dsi0: qcom,mdss_dsi@1a98000 {
                 compatible = "qcom,mdss-dsi-ctrl";
                 label = "MDSS DSI CTRL->0";
                 cell-index = <0>;
                 reg = <0x1a98000 0x25c>,
                       <0x1a98500 0x2b0>,
                       <0x193e000 0x30>;
                 reg-names = "dsi_ctrl", "dsi_phy", "mmss_misc_phys";
                 qcom,mdss-fb-map = <&mdss_fb0>;
                 qcom,mdss-mdp = <&mdss_mdp>;
                 gdsc-supply = <&gdsc_mdss>;
                 vdda-supply = <&pm8916_l2>;
                 vdd-supply = <&pm8916_l17>;
                 vddio-supply = <&pm8916_l6>;
                 clocks = <&clock_gcc clk_gcc_mdss_mdp_clk>,
                          <&clock_gcc clk_gcc_mdss_ahb_clk>,
                          <&clock_gcc clk_gcc_mdss_axi_clk>,
                          <&clock_gcc_mdss clk_gcc_mdss_byte0_clk>,
                          <&clock_gcc_mdss clk_gcc_mdss_pclk0_clk>,
                          <&clock_gcc clk_gcc_mdss_esc0_clk>;
---
bod
