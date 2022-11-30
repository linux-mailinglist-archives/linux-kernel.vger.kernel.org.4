Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D70463CFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiK3HVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3HVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:21:35 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038211F9D9;
        Tue, 29 Nov 2022 23:21:34 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 3E9AF32008C3;
        Wed, 30 Nov 2022 02:21:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Nov 2022 02:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669792890; x=
        1669879290; bh=q72EpL3uhOPRJqv9dDJjBbzAkGOsjTb1XnOeKej+X6Y=; b=T
        1oA3hm0bUR7Xv8EVN7JD1+jqOy3CWDrA2nAw/zq8z9ewbU3FQ8BBdMxfxP9FTE8y
        tuYufw1idtHR12TPdU7wDWUgwHVtiBc1Jvh0c3hG5sAzi5QWafOHf8snUNIHxkQp
        pQ4nEFhDJVqX0ybKKMvv1o6wxfnvHMjnBzDR/tzfpPQLh6F1qOy+Alme3W13OYnG
        6rIYtNTmTCKr7k8+jfO5fF8TvKST6t6PxkcRN02IqKPTRZsbcp5p57iZ9PyRTWwt
        yU/yICNdQPw68xFDEIZXTxEe6ze9lR/RSsAnGxUCoj7kplifqz9R4yJpWd3f4X/D
        9Irdun8sZQShg21/RCCWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669792890; x=
        1669879290; bh=q72EpL3uhOPRJqv9dDJjBbzAkGOsjTb1XnOeKej+X6Y=; b=R
        pYOmhN+h3E3LxnGoY1ByqBMUkdZ/f5rHya6YV4HXgIah0Xz+uVR7bGS/m0AR/hao
        6wRFPXOwo1V5Hf7puqFqe29XGyX0QtVwGrKVAZs+2jIg8zAdBPGGIZ84wmQojVCC
        lVVvLw6DkItgG4OEVCE2cl28nLNZUATNjbqKHuKy8fb5HmYRrerLfG5N63DywkVP
        Siu8xcTVvs0aqhvmg9ASVSkAgfjHvaq6tdA+BYdNZLnvJ4UHjq7P3a5Rv8yOP9E1
        ++L6vEv4rJj15oFj1ZJZZ9fcxK2Rz32m3sO79fXN6lRulgx+JBMng08MU1Nnqt3x
        Tk6bOHpiu15BfyrwDsAng==
X-ME-Sender: <xms:egSHY8bHzscxwxJ_XI7SjdETzhUGVpkCgZHGGx7OlAtJmDfvPDTR7w>
    <xme:egSHY3YPBQFQAmJ2SNwJxWG1Cgg0rDgxX4PDTlh_7o8t8rqPTISOS9LaWasHjabZ5
    YTisw3i6R2ee581ag>
X-ME-Received: <xmr:egSHY2_xM4dj0QjoPWlGrg-4-ds6i5qcckSDdqkGcr3isVhQfAXlmVKLidKUR2FDwbVuD76bL9c_QwYzL1i14ciobGZNUy2aDrW9XRdbj0CnR7QRBy7zHvyUmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeejgfffhfdujeeftdeuudeguedttefgieetffffheejuefguedv
    heejteeftdfftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:egSHY2ryPlW0Uk6wVPPsUrzYPAZ3nphYU1HFdhLK9ugHv7xtEq6o5w>
    <xmx:egSHY3o3lHtQ6VBxToj7VZ2tl1tYHonFUJGQ98ZssEKbbHp7Erc_GQ>
    <xmx:egSHY0TXUTmItSHZUxv2Dg7cUD3c4oKZQbYc5LJS0EuxifZxTFxhUA>
    <xmx:egSHY1ikeFwuY9xfeCiUw50Ag9_w21YQNXUIEhMyqtIioCf9C0-Hzw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 02:21:28 -0500 (EST)
Message-ID: <d4d8998f-288c-3ff6-141d-02814f8e35d0@sholland.org>
Date:   Wed, 30 Nov 2022 01:21:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-7-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 6/9] riscv: dts: bouffalolab: add the bl808 SoC base
 device tree
In-Reply-To: <20221127132448.4034-7-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 07:24, Jisheng Zhang wrote:
> Add a baisc dtsi for the bouffalolab bl808 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/bouffalolab/bl808.dtsi | 74 ++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> 
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> new file mode 100644
> index 000000000000..f4b170ccc32e
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808.dtsi
> @@ -0,0 +1,74 @@
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
> +		uart0: serial@30002000 {

It's unfortunate that the SDK/documentation calls this peripheral both
UART0 and UART3. I don't know if we can/should put the "M0" and "D0" bus
peripherals in the same DT; it seems like most of the "M0" peripherals
are not accessible from the C906. But if we did, this would conflict
with the other UART0.

> +			compatible = "bouffalolab,bl808-uart";
> +			reg = <0x30002000 0x1000>;
> +			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&xtal>;

There's a clock controller with a mux and a gate between the crystal and
the UART. I'm not sure what the policy is about adding "fake" suppliers
before the real supplier has a binding defined.

Unfortunately, Bouffalolab threw everything and the kitchen sink into
the GLB register space, so that complicates defining the binding for the
clock/reset controller part.

> +			status = "disabled";
> +		};
> +
> +		plic: interrupt-controller@e0000000 {
> +			compatible = "thead,c900-plic";
> +			reg = <0xe0000000 0x4000000>;
> +			interrupts-extended = <&cpu0_intc 0xffffffff>,

The C906 PLIC has an M-mode context, so 0xffffffff is not correct. This
should reference the M-mode external interrupt.

> +					      <&cpu0_intc 9>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			riscv,ndev = <64>;

The SDK/documentation lists IRQ numbers up to BL808_IRQ_PDS == 82, so
this value should be at least that.

Regards,
Samuel

> +		};
> +	};
> +};

