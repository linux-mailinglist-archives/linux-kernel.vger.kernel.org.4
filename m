Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E674872560B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbjFGHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbjFGHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:40:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0863A84
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:38:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977d55ac17bso583092566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686123485; x=1688715485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNSVpTGK/l9iZwOWNmHI2F19yNhHKxnKGcZzUtPUdPM=;
        b=ULkXjzQUh10+WTvid47PSYTfNolUEhpdm0pUGX4COa+AKaF56Lo1LEWLnJJLkMTtDk
         1bu8DW26K2ZWIKauxfZBMLPFVq+1NaKdyWF36l+Djo6nB8KezB+LlKmThOeAOcQokC77
         rd6mUJw2vIcay0nQc4onaXwFdHtel0CItpPmLaaB6SPBbHvwT+gDZWCSX3SULDuXVwQR
         rEcJWNiETnCPR2sBojc8GzYqz9YevQgC0fruyK4yGMYGqmaLkb/3kg69m5d2Ctsk71zV
         eITRSn697jIqgkelnOEW++XCjaltRsY+vxgXcGOWy4b0lvZ6y6qkeR9Qewzg2dl41Rq+
         ml/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123485; x=1688715485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNSVpTGK/l9iZwOWNmHI2F19yNhHKxnKGcZzUtPUdPM=;
        b=dnl23+fiOt6dQs7jeADJxAkhIvuliQd+oJfYgKStEcqL/2vItlB8T+u5SGTuf+NCri
         +uKoa+O7q8ufim+FQwANQNqDO7YRGZONH6eGQjAchOcCInryhEuvJnf0thhGUVsRAzmf
         NXvbzbKvpBpu7Nj5E1WdIihCSOrCZpmqm0tC3o3h39dtjqi3aoIhjr84td9HjjUTzOfK
         vZZhDihSeyDCP6h9oGu00fRYVEhfCy/9LSLOB3QfEiu/x6kyKL5XEqHX91i1Ee2JkD8M
         z1NKIGg6lJhOhcjzn0Jd3AREMc0PCvgyQXZ+4eSthWrhGqfu/eo1IixeOOfReKBqXuEF
         2L4w==
X-Gm-Message-State: AC+VfDw0VvLdw1QQtm7/6eeJ8RH7EKCz2GZ6ZhErsiLGNmSZgN+tSbMl
        BQfamoTUtU8UXNQRSxZtq6XKzw==
X-Google-Smtp-Source: ACHHUZ4eKaPNF9Y7Ctvy7bb6DgDgKJYoGYQGb84V/eSeixnqSw+c+G9oT2Nf3z6Gs7xy3BpZkwvUJg==
X-Received: by 2002:a17:907:9710:b0:974:c1c:8217 with SMTP id jg16-20020a170907971000b009740c1c8217mr5128815ejc.55.1686123485324;
        Wed, 07 Jun 2023 00:38:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bv13-20020a170906b1cd00b00978743b54bdsm1369725ejb.78.2023.06.07.00.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 00:38:04 -0700 (PDT)
Message-ID: <d97987f2-58e1-f46f-4b33-ccc72285d089@linaro.org>
Date:   Wed, 7 Jun 2023 09:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 2/9] riscv: dts: starfive: jh7110: add dc&hdmi controller
 node
Content-Language: en-US
To:     Keith Zhao <keith.zhao@starfivetech.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com, Bjorn Andersson <andersson@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
References: <20230602074043.33872-1-keith.zhao@starfivetech.com>
 <20230602074043.33872-3-keith.zhao@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230602074043.33872-3-keith.zhao@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 09:40, Keith Zhao wrote:
> Add the dc controller and hdmi node for the Starfive JH7110 SoC.
> 
> Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         | 87 +++++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 46 ++++++++++
>  2 files changed, 133 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 1155b97b593d..8dc6c8a15c59 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -31,6 +31,21 @@ memory@40000000 {
>  		reg = <0x0 0x40000000 0x1 0x0>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x0 0x20000000>;
> +			alignment = <0x0 0x1000>;
> +			alloc-ranges = <0x0 0x80000000 0x0 0x20000000>;
> +			linux,cma-default;
> +		};
> +	};
> +
>  	gpio-restart {
>  		compatible = "gpio-restart";
>  		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> @@ -214,6 +229,41 @@ GPOEN_DISABLE,
>  			slew-rate = <0>;
>  		};
>  	};
> +
> +	hdmi_pins: hdmi-0 {
> +		hdmi-scl-pins {
> +			pinmux = <GPIOMUX(0, GPOUT_SYS_HDMI_DDC_SCL,
> +					     GPOEN_SYS_HDMI_DDC_SCL,
> +					     GPI_SYS_HDMI_DDC_SCL)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-sda-pins {
> +			pinmux = <GPIOMUX(1, GPOUT_SYS_HDMI_DDC_SDA,
> +					     GPOEN_SYS_HDMI_DDC_SDA,
> +					     GPI_SYS_HDMI_DDC_SDA)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-cec-pins {
> +			pinmux = <GPIOMUX(14, GPOUT_SYS_HDMI_CEC_SDA,
> +					     GPOEN_SYS_HDMI_CEC_SDA,
> +					     GPI_SYS_HDMI_CEC_SDA)>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		hdmi-hpd-pins {
> +			pinmux = <GPIOMUX(15, GPOUT_HIGH,
> +					     GPOEN_ENABLE,
> +					     GPI_SYS_HDMI_HPD)>;
> +			input-enable;
> +			bias-disable; /* external pull-up */
> +		};
> +	};
> +
>  };
>  
>  &uart0 {
> @@ -221,3 +271,40 @@ &uart0 {
>  	pinctrl-0 = <&uart0_pins>;
>  	status = "okay";
>  };
> +
> +&voutcrg {
> +	status = "okay";
> +};
> +
> +&display {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_pins>;
> +
> +	hdmi_in: port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		hdmi_input: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&dc_out_dpi0>;

This does not make any sense. You wrote in bindings that this is display
output, but you call it HDMI input. If this is input, where is your output?

> +		};
> +	};
> +};
> +
> +&dc8200 {
> +	status = "okay";
> +
> +	dc_out: port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		dc_out_dpi0: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&hdmi_input>;
> +		};
> +

Stray blank line.

> +	};
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 9acb5fb1716d..66be6e65a066 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -249,6 +249,11 @@ tdm_ext: tdm-ext-clock {
>  		#clock-cells = <0>;
>  	};
>  
> +	display: display-subsystem {
> +		compatible = "verisilicon,display-subsystem";

Drop fake nodes which do not represent hardware. Instead, DTS and
bindings should describe real hardware.


> +		ports = <&dc_out>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -570,5 +575,46 @@ voutcrg: clock-controller@295c0000 {
>  			#reset-cells = <1>;
>  			power-domains = <&pwrc JH7110_PD_VOUT>;
>  		};
> +
> +		dc8200: dc8200@29400000 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "verisilicon,dc8200";
> +			reg = <0x0 0x29400000 0x0 0x100>,
> +			      <0x0 0x29400800 0x0 0x2000>,
> +			      <0x0 0x295B0000 0x0 0x90>;
> +			interrupts = <95>;
> +			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_PIX1>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_AXI>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_AHB>,
> +				<&hdmitx0_pixelclk>,
> +				<&voutcrg JH7110_VOUTCLK_DC8200_PIX>;
> +			clock-names = "clk_vout_noc_disp",
> +				"clk_vout_pix0","clk_vout_pix1",

Fix alignment

> +				"clk_vout_axi","clk_vout_core",
> +				"clk_vout_vout_ahb","hdmitx0_pixel",
> +				"clk_vout_dc8200";
> +			resets = <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
> +				 <&voutcrg JH7110_VOUTRST_DC8200_AHB>,
> +				 <&voutcrg JH7110_VOUTRST_DC8200_CORE>;
> +			reset-names = "rst_vout_axi","rst_vout_ahb",
> +						"rst_vout_core";

Fix alignment.



Best regards,
Krzysztof

