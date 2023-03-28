Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6972B6CC0D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjC1N3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjC1N3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DF9BDEB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:29:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j11so15798918lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680010179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1WbYAhbTJCq9CpwMXXHWoOEY+JTfgn6zXdroTgNd+uI=;
        b=riY9k7ACEoIZdlsXIAzsYHPCzH86Z6OwmYLjuVX3Hg5rObvWIduAguy+SzEEUwiwK+
         bIzhFOtD/cv9k03LyLZBNFc/okm8XvA8Ay1MWaL65ubpIqqSznWnQWr8KhCThgRi/lHU
         m7vyfIBmwbbnVNVLbwyZEi8UOSGC3U/HGPwVKqxTINS04zNvpsuH2S/dprENXyxWPnzg
         u8V1+wZrq1AfMQl74mstjxE0EFFtkXTLMEiNLYLYOXOM9VzGmM/GJUjgOahev7L77Kn5
         oTb8HA7ddm07TqbySYMkmlVlsLhZWDzvtT1BbGCm9uXm3roPF0t9V6fgaRfWp2WnDh3F
         dRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WbYAhbTJCq9CpwMXXHWoOEY+JTfgn6zXdroTgNd+uI=;
        b=gDrPtsJl89Qw9kRs8dI+/x0wroxn+njBiJtBWmodUOxYeHjL/zK5OIcY74fBlxn/Xn
         m53567bFCHKCfUYLj/+De65vtQz+qlkJo4R9+sx37jilEl5myOaJT/+uBraKabUonf8U
         OCGuJuGXdBIRBLXfh6s7f7mYCZxF1NZULRPkuoF7GysStcAk0hfGvfFEEpwBR4ecZWie
         MPHoPXbOqX4k+4zqLl9WEyKAKhYUyQ0QN7SW3mB5SHxG4Ej0SPFHjI9Xm0D90qTSG9WY
         HkosCnz5JU5ug1wX2S82516b5bgNw5tsolSamUX/Q4Gj6lQUqaIRqZCuvT3YidbM7nPJ
         cljA==
X-Gm-Message-State: AAQBX9ebvFFtinRXOasyw7CcFaLE50BdhoLIT5iXSg9kNniBZx4IKjRy
        go7FjyCBPxhSye5yVSvfb6WaeQ==
X-Google-Smtp-Source: AKy350aI9Nosdzm7Da1+tRI3ckrPMOkF/SZUZmTk6ZU0G1m/sSinzGQCdwI8yBEQKu2hL/2VJBY2lQ==
X-Received: by 2002:ac2:549a:0:b0:4de:ca63:b2d9 with SMTP id t26-20020ac2549a000000b004deca63b2d9mr4125954lfk.49.1680010179704;
        Tue, 28 Mar 2023 06:29:39 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f24-20020ac25338000000b004e8448de1c0sm5116024lfh.10.2023.03.28.06.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:29:39 -0700 (PDT)
Message-ID: <5beab308-a114-745b-fa28-84ca0495f539@linaro.org>
Date:   Tue, 28 Mar 2023 15:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 3/5] ARM: dts: qcom: sdx65: Add support for PCIe EP
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mani@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <1679036039-27157-1-git-send-email-quic_rohiagar@quicinc.com>
 <1679036039-27157-4-git-send-email-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1679036039-27157-4-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.03.2023 07:53, Rohit Agarwal wrote:
> Add support for PCIe Endpoint controller on the
> Qualcomm SDX65 platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  arch/arm/boot/dts/qcom-sdx65.dtsi | 56 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 084daf8..a7d8ad9 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/gpio/gpio.h>
This should be sorted alphabetically

Other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  
>  / {
>  	#address-cells = <1>;
> @@ -293,6 +294,56 @@
>  			status = "disabled";
>  		};
>  
> +		pcie_ep: pcie-ep@1c00000 {
> +			compatible = "qcom,sdx65-pcie-ep", "qcom,sdx55-pcie-ep";
> +			reg = <0x01c00000 0x3000>,
> +			      <0x40000000 0xf1d>,
> +			      <0x40000f20 0xa8>,
> +			      <0x40001000 0x1000>,
> +			      <0x40200000 0x100000>,
> +			      <0x01c03000 0x3000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "addr_space",
> +				    "mmio";
> +
> +			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> +
> +			clocks = <&gcc GCC_PCIE_AUX_CLK>,
> +				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
> +				 <&gcc GCC_PCIE_SLEEP_CLK>,
> +				 <&gcc GCC_PCIE_0_CLKREF_EN>;
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "sleep",
> +				      "ref";
> +
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "global", "doorbell";
> +
> +			resets = <&gcc GCC_PCIE_BCR>;
> +			reset-names = "core";
> +
> +			power-domains = <&gcc PCIE_GDSC>;
> +
> +			phys = <&pcie_phy>;
> +			phy-names = "pcie-phy";
> +
> +			max-link-speed = <3>;
> +			num-lanes = <2>;
> +
> +			status = "disabled";
> +		};
> +
>  		pcie_phy: phy@1c06000 {
>  			compatible = "qcom,sdx65-qmp-gen4x2-pcie-phy";
>  			reg = <0x01c06000 0x2000>;
> @@ -330,6 +381,11 @@
>  			#hwlock-cells = <1>;
>  		};
>  
> +		tcsr: syscon@1fcb000 {
> +			compatible = "qcom,sdx65-tcsr", "syscon";
> +			reg = <0x01fc0000 0x1000>;
> +		};
> +
>  		remoteproc_mpss: remoteproc@4080000 {
>  			compatible = "qcom,sdx55-mpss-pas";
>  			reg = <0x04080000 0x4040>;
