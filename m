Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF7682D35
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjAaNDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjAaNC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:02:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A606210E3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:02:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hx15so21832747ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMuYK0WSyZYRrXHGABWTQV5R7Ze95cw6D7T0XWB+CoY=;
        b=CiRg1gKu6BnMmpm2H6TI1rDNSlpJujds/qLtimwnby74g7bu8rIgwKmpRQomf3oUJc
         Vut2hZGdmZgJKQd3Rhf2ZhkSRHIS3+C0vdWr0Sz78o+GnEBnHZZ4I/p3PXaVtGC7S9km
         AzaLYdi4P2Ab2s3wn6h5TVXHE+g0TyXRUZ1en+dAcUAOkG+q+Dh5wp/2fco3oXs9WHa5
         uG5LHKkjNE629cdvzAyqtF6VtdDj+QM+u38FtRXKBsdTSX/Y44urHF+64qd9ptbFQeYv
         KWe+IYmn2rMGfi3SquFH87z6sUBC5ue/aDwA/Mm6RGcHpq6oihN3GU4lmHxQMmsIzBzx
         X30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMuYK0WSyZYRrXHGABWTQV5R7Ze95cw6D7T0XWB+CoY=;
        b=pbXcP2kQPmz6b+MsLwIyBvTCDGJKjROqzPKF/W87vLWVRSWGKfDjn0o2NQKVVbZMEo
         9sKUVPEc5Mb4Q6HSnWfymuhNs4A4jeqaXIPE1/H0ovA5JpCQg9bZ1mHYvj0+vG9xENab
         /n+6exa8uS6igNg9uyEWPyZ/5nMt3428uR1Pwo29kUWgQf/4eA69gsaZQrqQDgaQPRHD
         2E59sJu/a2bytAGNimGYLU29/IuNEKKf4CctqWPuhTKmI/h/JR/guhWq4hX6NwcPCZDH
         /OR7fhk7uS4wM2GGt1GKzgIv/HhGKu2R0OSZiboPdma3JSEETrDNpB6o6XKnG0FuONx6
         J0ig==
X-Gm-Message-State: AO0yUKWN1QFwcnY4WmsjDUdv0WXMMgI74PDs/V4gEkvARex45XDbATuc
        8BHG5PkpVmkLoG8NFVj8NXR0KQ==
X-Google-Smtp-Source: AK7set/2j91rb122tJ7RJPdxc//XziEYdyb98GDL00NviToWHLF2NIEOLzSql3kGeK72+YxoLeD6dA==
X-Received: by 2002:a17:907:3f1f:b0:84d:4325:7f7a with SMTP id hq31-20020a1709073f1f00b0084d43257f7amr3948199ejc.65.1675170167139;
        Tue, 31 Jan 2023 05:02:47 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id ac7-20020a170907344700b00881c40ceffasm5623400ejc.112.2023.01.31.05.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:02:46 -0800 (PST)
Message-ID: <e5a0e98c-b64d-d75c-7a5c-5ddbe964acb8@linaro.org>
Date:   Tue, 31 Jan 2023 14:02:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] arm64: dts: qcom: add initial support for qcom
 sa8775p-ride
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230131124026.167281-1-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230131124026.167281-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
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



On 31.01.2023 13:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This adds basic support for the Qualcomm sa8775p platform and the
> reference board: sa8775p-ride. The dt files describe the basics of the
> SoC and enable booting to shell.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - lots of improvements all around the place to make the dts pass dtbs_check
>   (with some additional patches fixing bugs in existing dt bindings),
>   make dtbs W=1 and checkpatch.pl
> - move board-specific properties to the board .dts file
> - ordered top-level nodes alphabetically and sub-nodes by the reg property
> - fixed licensing
> - set #address-cells and #size-cells to <2> in the soc node and update sub-nodes
> 
>  arch/arm64/boot/dts/qcom/Makefile         |   1 +
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts |  47 ++
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 817 ++++++++++++++++++++++
>  3 files changed, 865 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8775p.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b0423ca3e79f..968e07265959 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -71,6 +71,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8540p-ride.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8775p-ride.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> new file mode 100644
> index 000000000000..ed416dd64d60
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include "sa8775p.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8875P Ride";
8775

> +	compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
> +
> +	aliases {
> +		serial0 = &uart10;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32764>;
> +};
> +
> +&tlmm {
> +	qup_uart10_default: qup-uart10-state {
> +		pins = "gpio46", "gpio47";
> +		function = "qup1_se3";
No bias-/drive-strength?

> +	};
> +};
> +
> +&uart10 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup_uart10_default>;
compatible
pinctrl-0
pinctrl-names
status

please
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> new file mode 100644
> index 000000000000..1a71e5c30bb9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -0,0 +1,817 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
rpmh
sa8775

for alphabetical order
> +#include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		xo_board_clk: xo-board-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +			L2_0: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +				L3_0: l3-cache {
> +					compatible = "cache";
> +				};
> +			};
> +		};
> +
> +		CPU1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_1>;
> +			L2_1: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_2>;
> +			L2_2: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_3>;
> +			L2_3: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_0>;
> +			};
> +		};
> +
> +		CPU4: cpu@10000 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10000>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_4>;
> +			L2_4: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +				L3_1: l3-cache {
> +					compatible = "cache";
> +				};
> +
> +			};
> +		};
> +
> +		CPU5: cpu@10100 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10100>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_5>;
> +			L2_5: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +			};
> +		};
> +
> +		CPU6: cpu@10200 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10200>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_6>;
> +			L2_6: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +			};
> +		};
> +
> +		CPU7: cpu@10300 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x10300>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_7>;
> +			L2_7: l2-cache {
> +				compatible = "cache";
> +				next-level-cache = <&L3_1>;
> +			};
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&CPU0>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU1>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU2>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&CPU4>;
> +				};
> +
> +				core1 {
> +					cpu = <&CPU5>;
> +				};
> +
> +				core2 {
> +					cpu = <&CPU6>;
> +				};
> +
> +				core3 {
> +					cpu = <&CPU7>;
> +				};
> +			};
> +		};
> +	};
> +
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-sa8775p", "qcom,scm";
> +		};
> +	};
> +
> +	aggre1_noc: interconnect-aggre1-noc {
> +		compatible = "qcom,sa8775p-aggre1-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	aggre2_noc: interconnect-aggre2-noc {
> +		compatible = "qcom,sa8775p-aggre2-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	clk_virt: interconnect-clk-virt {
> +		compatible = "qcom,sa8775p-clk-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	config_noc: interconnect-config-noc {
> +		compatible = "qcom,sa8775p-config-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	dc_noc: interconnect-dc-noc {
> +		compatible = "qcom,sa8775p-dc-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	gem_noc: interconnect-gem-noc {
> +		compatible = "qcom,sa8775p-gem-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	gpdsp_anoc: interconnect-gpdsp-anoc {
> +		compatible = "qcom,sa8775p-gpdsp-anoc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	lpass_ag_noc: interconnect-lpass-ag-noc {
> +		compatible = "qcom,sa8775p-lpass-ag-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	mc_virt: interconnect-mc-virt {
> +		compatible = "qcom,sa8775p-mc-virt";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	mmss_noc: interconnect-mmss-noc {
> +		compatible = "qcom,sa8775p-mmss-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	nspa_noc: interconnect-nspa-noc {
> +		compatible = "qcom,sa8775p-nspa-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	nspb_noc: interconnect-nspb-noc {
> +		compatible = "qcom,sa8775p-nspb-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	pcie_anoc: interconnect-pcie-anoc {
> +		compatible = "qcom,sa8775p-pcie-anoc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	system_noc: interconnect-system-noc {
> +		compatible = "qcom,sa8775p-system-noc";
> +		#interconnect-cells = <2>;
> +		qcom,bcm-voters = <&apps_bcm_voter>;
> +	};
> +
> +	/* Will be updated by the bootloader. */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x0>;
> +	};
> +
> +	qup_opp_table_100mhz: opp-table-qup100mhz {
> +		compatible = "operating-points-v2";
> +
> +		opp-100000000 {
> +			opp-hz = /bits/ 64 <100000000>;
> +			required-opps = <&rpmhpd_opp_svs_l1>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		sail_ss_mem: sail-ss-region@80000000 {
drop -region from the names

> +			reg = <0x0 0x80000000 0x0 0x10000000>;
> +			no-map;
> +		};
> +
> +		hyp_mem: hyp-region@90000000 {
> +			reg = <0x0 0x90000000 0x0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_boot_mem: xbl-boot-region@90600000 {
> +			reg = <0x0 0x90600000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		aop_image_mem: aop-image-region@90800000 {
> +			reg = <0x0 0x90800000 0x0 0x60000>;
> +			no-map;
> +		};
> +
> +		aop_cmd_db_mem: aop-cmd-db-region@90860000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x90860000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		uefi_log: uefi-log-region@908b0000 {
> +			reg = <0x0 0x908b0000 0x0 0x10000>;
> +			no-map;
> +		};
> +
> +		reserved_mem: reserved-region@908f0000 {
> +			reg = <0x0 0x908f0000 0x0 0xf000>;
> +			no-map;
> +		};
> +
> +		secdata_apss_mem: secdata-apss-region@908ff000 {
> +			reg = <0x0 0x908ff000 0x0 0x1000>;
> +			no-map;
> +		};
> +
> +		smem_mem: smem-region@90900000 {
> +			compatible = "qcom,smem";
> +			reg = <0x0 0x90900000 0x0 0x200000>;
> +			no-map;
> +			hwlocks = <&tcsr_mutex 3>;
> +		};
> +
> +		cpucp_fw_mem: cpucp-fw-region@90b00000 {
> +			reg = <0x0 0x90b00000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		lpass_machine_learning_mem: lpass-machine-learning-region@93b00000 {
> +			reg = <0x0 0x93b00000 0x0 0xf00000>;
> +			no-map;
> +		};
> +
> +		adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap-region@94a00000 {
> +			reg = <0x0 0x94a00000 0x0 0x800000>;
> +			no-map;
> +		};
> +
> +		pil_camera_mem: pil-camera-region@95200000 {
> +			reg = <0x0 0x95200000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		pil_adsp_mem: pil-adsp-region@95c00000 {
> +			reg = <0x0 0x95c00000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_gdsp0_mem: pil-gdsp0-region@97b00000 {
> +			reg = <0x0 0x97b00000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_gdsp1_mem: pil-gdsp1-region@99900000 {
> +			reg = <0x0 0x99900000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_cdsp0_mem: pil-cdsp0-region@9b800000 {
> +			reg = <0x0 0x9b800000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_gpu_mem: pil-gpu-region@9d600000 {
> +			reg = <0x0 0x9d600000 0x0 0x2000>;
> +			no-map;
> +		};
> +
> +		pil_cdsp1_mem: pil-cdsp1-region@9d700000 {
> +			reg = <0x0 0x9d700000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		pil_cvp_mem: pil-cvp-region@9f500000 {
> +			reg = <0x0 0x9f500000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		pil_video_mem: pil-video-region@9fc00000 {
> +			reg = <0x0 0x9fc00000 0x0 0x700000>;
> +			no-map;
> +		};
> +
> +		hyptz_reserved_mem: hyptz-reserved-region@beb00000 {
> +			reg = <0x0 0xbeb00000 0x0 0x11500000>;
> +			no-map;
> +		};
> +
> +		tz_stat_mem: tz-stat-region@d0000000 {
> +			reg = <0x0 0xd0000000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		tags_mem: tags-region@d0100000 {
> +			reg = <0x0 0xd0100000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		qtee_mem: qtee-region@d1300000 {
> +			reg = <0x0 0xd1300000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		trusted_apps_mem: trusted-apps-region@d1800000 {
> +			reg = <0x0 0xd1800000 0x0 0x3900000>;
> +			no-map;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0 0 0 0 0x10 0>;
> +
> +		gcc: clock-controller@100000 {
> +			compatible = "qcom,sa8775p-gcc";
> +			reg = <0x0 0x100000 0x0 0xc7018>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&sleep_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			power-domains = <&rpmhpd SA8775P_CX>;
> +		};
> +
> +		ipcc: mailbox@408000 {
> +			compatible = "qcom,sa8775p-ipcc", "qcom,ipcc";
> +			reg = <0x0 0x408000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#mbox-cells = <2>;
> +		};
> +
> +		qupv3_id_1: geniqup@ac0000 {
> +			compatible = "qcom,geni-se-qup";
> +			reg = <0x0 0xac0000 0x0 0x6000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			clock-names = "m-ahb", "s-ahb";
> +			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> +				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> +			iommus = <&apps_smmu 0x443 0x0>;
> +			status = "disabled";
> +
> +			uart10: serial@a8c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0xa8c000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "se";
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
> +				interconnect-names = "qup-core", "qup-config";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
> +						 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0
> +						 &config_noc SLAVE_QUP_1 0>;
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				operating-points-v2 = <&qup_opp_table_100mhz>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		intc: interrupt-controller@17a00000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
> +			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#redistributor-regions = <1>;
> +			redistributor-stride = <0x0 0x20000>;
> +			ranges;
You don't need address/size-cells and ranges if you don't add
msi-controller subnodes.
> +		};
> +
> +		watchdog@17c10000 {
> +			compatible = "qcom,apss-wdt-sa8775p", "qcom,kpss-wdt";
> +			reg = <0x0 0x17c10000 0x0 0x1000>;
> +			clocks = <&sleep_clk>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		memtimer: timer@17c20000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0 0x17c20000 0x0 0x1000>;
> +			clock-frequency = <19200000>;
Please drop this, your firmware programs this for you.


> +			ranges = <0x0 0x0 0x0 0x20000000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			frame@17c21000 {
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17c21000 0x1000>,
> +				      <0x17c22000 0x1000>;
reg
interrupts
frame-number

please
> +			};
> +
> +			frame@17c23000 {
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17c23000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c25000 {
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17c25000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c27000 {
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17c27000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c29000 {
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17c29000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2b000 {
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17c2b000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@17c2d000 {
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x17c2d000 0x1000>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		apps_rsc: rsc@18200000 {
> +			compatible = "qcom,rpmh-rsc";
> +			reg = <0x0 0x18200000 0x0 0x10000>,
> +			      <0x0 0x18210000 0x0 0x10000>,
> +			      <0x0 0x18220000 0x0 0x10000>;
> +			reg-names = "drv-0", "drv-1", "drv-2";
> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +			      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +			      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,tcs-offset = <0xd00>;
> +			qcom,drv-id = <2>;
> +			qcom,tcs-config = <ACTIVE_TCS 2>,
> +					  <SLEEP_TCS 3>,
> +					  <WAKE_TCS 3>,
> +					  <CONTROL_TCS 0>;
> +			label = "apps_rsc";
> +
> +			apps_bcm_voter: bcm-voter {
> +				compatible = "qcom,bcm-voter";
> +			};
> +
> +			rpmhcc: clock-controller {
> +				compatible = "qcom,sa8775p-rpmh-clk";
> +				#clock-cells = <1>;
> +				clock-names = "xo";
> +				clocks = <&xo_board_clk>;
> +			};
> +
> +			rpmhpd: power-controller {
> +				compatible = "qcom,sa8775p-rpmhpd";
> +				#power-domain-cells = <1>;
> +				operating-points-v2 = <&rpmhpd_opp_table>;
> +
> +				rpmhpd_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					rpmhpd_opp_ret: opp-0 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> +					};
> +
> +					rpmhpd_opp_min_svs: opp-1 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
> +					};
> +
> +					rpmhpd_opp_low_svs: opp2 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs: opp3 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					};
> +
> +					rpmhpd_opp_svs_l1: opp-4 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					};
> +
> +					rpmhpd_opp_nom: opp-5 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					};
> +
> +					rpmhpd_opp_nom_l1: opp-6 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					};
> +
> +					rpmhpd_opp_nom_l2: opp-7 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
> +					};
> +
> +					rpmhpd_opp_turbo: opp-8 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
> +					};
> +
> +					rpmhpd_opp_turbo_l1: opp-9 {
> +						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		tcsr_mutex: hwlock@1f40000 {
> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x0 0x1f40000 0x0 0x20000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		tlmm: pinctrl@f000000 {
> +			compatible = "qcom,sa8775p-tlmm";
> +			reg = <0x0 0xf000000 0x0 0x1000000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 149>;
> +		};
> +
> +		apps_smmu: iommu@15000000 {
> +			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x15000000 0x0 0x100000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +
> +			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 709 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 710 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 713 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 715 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 912 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 911 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 910 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 909 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 908 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 907 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 906 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 905 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 904 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 903 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 902 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 901 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 900 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 899 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 898 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 897 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 896 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 895 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 894 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 893 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 892 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +	};
> +
> +	arch_timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <19200000>;
Please drop this line, your firmware programs this for you.

With this
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +	};
> +};
