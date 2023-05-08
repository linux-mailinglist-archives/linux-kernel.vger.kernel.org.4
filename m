Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5326FA323
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjEHJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjEHJUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:20:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23931BC1
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:20:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so46763589a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683537628; x=1686129628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeBATTzfWyLrpcItusTVCNqa+kfOywO5ocE6C3AQQ2E=;
        b=GN+DEIdV7HuTj0bxVx7KUkbK0IaihVZfL08tquk8YbKaIdKAsz29zBA1VAwauSiN2r
         vn8/r+I2K5U9xkE9zLDSy1WKAmRQGmn296BBDcempXE8iDDMI8X561i8X9NsqyOb5uUR
         NyS0LA0EBhQFetr35Vk8dM/DVHMPH+w6i3mQP5GqTv8UP0rMOTCEiL6NzJNMxCfYrdaj
         aAm3EXMZLaHeKYRRmnRJ1Ponfwa8Cg7CYSBcOqxnm58bLzSSlJT/U8cqg9BZhtjBfSKF
         J/dMfmSdHiHtBDi41DroTLFRBD+2qUaSchw0obBBNqFS1YXpbymNQ61nvhpt5nqRNups
         tzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683537628; x=1686129628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeBATTzfWyLrpcItusTVCNqa+kfOywO5ocE6C3AQQ2E=;
        b=PpWCjPpO298bLHEJVOtPhCdCq4YdHe11aE0ZdtUqwEeSrd1EXy6vm1Hado2R9aKovR
         W45qPpsSrvXChdo9nQobm+OQXMWb8ScbB0dhtRdIos4rtZ8az3ikI69WHO370zcQ3Hlk
         VBKecVWL6kn99Ib1w1oeWBq0ZPi36FdzbYQSrrauU6Ukuua6uizjxWd8RQc9l2tO2Ypm
         A7raPmvy5nKt/BnbMdJ7hLJvGBIDhgj2p9tDOThxFkfJAArwiFO7Zb8lM+89CtPvNciC
         N4qhQMbGdUtcfOv0n14zlO4RY/00s8Qb3LDJmbQKkXdwB7gIk0Xg7Sq/YKEwuIFHn1ww
         pE9Q==
X-Gm-Message-State: AC+VfDwoepe5tIBTlz0AuVhOAmCKqKWVypoYAQnJW0epHCfHhvMNPrrW
        XNBTSb0bfxKHupXkqiVBViO8+g==
X-Google-Smtp-Source: ACHHUZ6wbdJtCQPbrDPnwiy9G4STmjghvquLlxAjBypDDS0ZeNRPmXyhnYCc3Q1beffyrQAlptusXg==
X-Received: by 2002:a17:907:6d22:b0:965:d7c7:24db with SMTP id sa34-20020a1709076d2200b00965d7c724dbmr8532589ejc.32.1683537628292;
        Mon, 08 May 2023 02:20:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id nc21-20020a1709071c1500b009693ea7db1esm249529ejc.11.2023.05.08.02.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:20:27 -0700 (PDT)
Message-ID: <d67ae7ff-d877-bd71-1483-f9dfa94c11fe@linaro.org>
Date:   Mon, 8 May 2023 11:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-4-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230507182304.2934-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2023 20:23, Jisheng Zhang wrote:
> Add initial device tree for the light(a.k.a TH1520) RISC-V SoC by
> T-HEAD.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/thead/light.dtsi | 454 +++++++++++++++++++++++++++
>  1 file changed, 454 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/thead/light.dtsi
> 
> diff --git a/arch/riscv/boot/dts/thead/light.dtsi b/arch/riscv/boot/dts/thead/light.dtsi
> new file mode 100644
> index 000000000000..cdf6d8b04d22
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/light.dtsi
> @@ -0,0 +1,454 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Alibaba Group Holding Limited.
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/ {
> +	compatible = "thead,light";

Undocumented compatible.

Please run scripts/checkpatch.pl and fix reported warnings.

> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus: cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <3000000>;
> +
> +		c910_0: cpu@0 {
> +			compatible = "thead,c910", "riscv";

Probably the same.

(...)

> +	soc {
> +		compatible = "simple-bus";
> +		interrupt-parent = <&plic>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		reset: reset-sample {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "thead,reset-sample";

Undocumented compatible.

Please run scripts/checkpatch.pl and fix reported warnings.

> +			entry-reg = <0xff 0xff019050>;
> +			entry-cnt = <4>;
> +			control-reg = <0xff 0xff015004>;
> +			control-val = <0x1c>;
> +			csr-copy = <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
> +		};
> +
> +		plic: interrupt-controller@ffd8000000 {
> +			compatible = "thead,c910-plic";
> +			reg = <0xff 0xd8000000 0x0 0x01000000>;
> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			riscv,ndev = <240>;
> +		};
> +
> +		clint: timer@ffdc000000 {
> +			compatible = "thead,c900-clint";


Undocumented compatible.

Please run scripts/checkpatch.pl and fix reported warnings.

> +			reg = <0xff 0xdc000000 0x0 0x00010000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>;
> +		};
> +
> +		uart0: serial@ffe7014000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0xff 0xe7014000 0x0 0x4000>;
> +			interrupts = <36>;
> +			clocks = <&uart_sclk>;
> +			clock-names = "baudclk";
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@ffe7f00000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0xff 0xe7f00000 0x0 0x4000>;
> +			interrupts = <37>;
> +			clocks = <&uart_sclk>;
> +			clock-names = "baudclk";
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@ffe7f04000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0xff 0xe7f04000 0x0 0x4000>;
> +			interrupts = <39>;
> +			clocks = <&uart_sclk>;
> +			clock-names = "baudclk";
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		gpio2: gpio@ffe7f34000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0xff 0xe7f34000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			portc: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <58>;
> +			};
> +		};
> +
> +		gpio3: gpio@ffe7f38000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0xff 0xe7f38000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			portd: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <59>;
> +			};
> +		};
> +
> +		gpio0: gpio@ffec005000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0xff 0xec005000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			porta: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <56>;
> +			};
> +		};
> +
> +		gpio1: gpio@ffec006000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0xff 0xec006000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			portb: gpio-controller@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <32>;
> +				reg = <0>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				interrupts = <57>;
> +			};
> +		};
> +
> +		uart2: serial@ffec010000 {
> +			compatible = "snps,dw-apb-uart";
> +			reg = <0xff 0xec010000 0x0 0x4000>;
> +			interrupts = <38>;
> +			clocks = <&uart_sclk>;
> +			clock-names = "baudclk";
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		dmac0: dmac@ffefc00000 {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).



Best regards,
Krzysztof

