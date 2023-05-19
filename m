Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E748708E73
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjESDvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESDvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:51:16 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0BD183;
        Thu, 18 May 2023 20:51:15 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 75B4532008FB;
        Thu, 18 May 2023 23:51:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 18 May 2023 23:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1684468273; x=1684554673; bh=4ecmHSmtpaMehpa+G3raIzuSZ3nRd9Ghq9g
        2WcWGtXY=; b=Bca11Fcs0kSlKYIPuv2YpWZ9GJJRanWjT8QE2bT0Rl366OooonO
        iD29iKWvvpkzT1JSrJbRnFsZ5m+UmL8k9A0fvgIr7j2a4B1rh76qwu1yJ0YphDgC
        syWHq3GrDemYVCOEXYQxUK8PjDGsqJxg+GxAP2RZMlCCfaaHsuj/wAsv7yLhP++N
        0lxn5h1FAwWQexge6VGW03jLmiSIcynpU5+QAmZGdw5WOm3glHLjukxk0FQGGQ88
        0Q1JV0SgpiGtpDyG5XVHKwCdxWVqevewoXEBAPCKGkIBaLIHu6uOeAgIAJLxNizG
        raSYXEphI8TmqvoM99ZNcz+EmFQipaeug2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684468273; x=1684554673; bh=4ecmHSmtpaMehpa+G3raIzuSZ3nRd9Ghq9g
        2WcWGtXY=; b=D0UpIsf0zihnnkP/P9K6Em33imMuvchuQa4sj6g9N+CKDPtSYtD
        IXKWm9lIN0I7sKZs3okM40wy8Nm30Z2Z9GWLw0082toSBnE1ylShpsSb7UfZJ1j2
        JOzqwtID67Kmtg5PRqUAHi1cveJR+GBTnXCPz9zkR8GFdPBf7VjWhN8EXpIKr6tt
        1UwF1zrSin0CMupkbjzj7dcmUB9djZNhIOGrW4lbXTACecmdzi5c929YdSsMAIPh
        ACBUmHhGbMjgXfFD430xRBLOkUhDgI20KyaJdx/dJQ5fZBdVHnwfU6MFsKamVguP
        Qxtj8B7uB/8fYlDanKYsge1PGlezwAHlplg==
X-ME-Sender: <xms:MPJmZDrYnw1bwY4EvVwyivz5Wm0VA6aQESGfI0yEELH6kQMcabiSCw>
    <xme:MPJmZNpIwVL29h5HbgrfnR3alu3lG2l6uannRfy1TmuTyKt5JX5in5Z6Sk71CCjtM
    4TDDJN63LtvbK6dbQ>
X-ME-Received: <xmr:MPJmZAM5GBC69vZAr8MTHmOoXuaHtAgqtvcaRt6f20EYQaTbCyAyZPdz8qI-zAZF-NbKwboQYu7LPbc8DI86DC6KlwLtv4QGKCVYhti_zXWYbpqEiuQvR1IBow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduueeugfelledugeeugedvgefghfevjefgieeljeevgeeihfff
    veeiffeivdekheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:MPJmZG5kMAtHd05KPf6MfRSgQf9YZrTIf6Y9nhF11O4rK48tPprLPw>
    <xmx:MPJmZC5bgXOG0CQsw0Gq035YheAIv65t2eXnSNG4MdbKnzdk-r6hcg>
    <xmx:MPJmZOjCTdk-u1fCHnvD4PljGYnNTq-eUt-v41yATKdXlhD9fIgyUg>
    <xmx:MfJmZBSM6qgbBdmi7kiMe98K5lJX7Pd0T_NIJe7_1HVXHOdaf4sXqw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 May 2023 23:51:11 -0400 (EDT)
Message-ID: <accfadfc-6aea-2376-9cf4-1a989626eaf0@sholland.org>
Date:   Thu, 18 May 2023 22:51:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-8-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 07/10] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
In-Reply-To: <20230518152244.2178-8-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 5/18/23 10:22, Jisheng Zhang wrote:
> Add a baisc dtsi for the bouffalolab bl808 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> 
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> new file mode 100644
> index 000000000000..87906fe51db5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "bouffalolab,bl808";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		timebase-frequency = <1000000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "thead,c906", "riscv";
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <256>;
> +			d-cache-size = <32768>;
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <32768>;
> +			mmu-type = "riscv,sv39";
> +			riscv,isa = "rv64imafdc";
> +
> +			cpu0_intc: interrupt-controller {
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +	};
> +
> +	xtal: xtal-clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		/* This value must be overridden by the board */
> +		clock-frequency = <0>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		ranges;
> +		interrupt-parent = <&plic>;
> +		dma-noncoherent;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		uart3: serial@30002000 {
> +			compatible = "bouffalolab,bl808-uart";
> +			reg = <0x30002000 0x1000>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&xtal>;

This isn't strictly accurate, and gives you the right frequency if you
are using the vendor "low_load" bootloader. Without that (e.g. when
loading U-Boot directly from the boot ROM), the routing is:

 MM_MUXPLL_160M / 1 => MM_BCLK1X
 MM_BCLK1X / 1 => MM_UART

So this UART module clock is 160 MHz, not 40 MHz.

The way to make this work reliably is to add drivers for the clock tree
(from the preliminary work at [1][2], we'll need at least five of them),
but that is a huge effort, so I'm not sure what we want to do for now.

Regards,
Samuel

[1]: https://github.com/openbouffalo/u-boot/commit/3ca800850f30
[2]: https://github.com/openbouffalo/u-boot/commits/bl808/clk-reset

> +			status = "disabled";
> +		};
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible = "bouffalolab,bl808-plic", "thead,c900-plic";
> +			reg = <0xe0000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <82>;
> +		};
> +	};
> +};

