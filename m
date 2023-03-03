Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75E56A91CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCCHjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCCHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:39:47 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C259213DC5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:39:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f13so6796608edz.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677829184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGfQhG/t4N08bdM7OR/sIi9YbqrZcvYiGl1Zpsb/00E=;
        b=qm+sRjzjWfPhDM5vw99jBp+rka6Tb/wWGoi99N0seSzXGNpg10ZNfvz0FmLVzmPgox
         7j0aC6SEr3F0/SJ3QF6oNxmIObprZuh3Zv5jjjS9KrEmm0AdfDP/ANFgxz+Ad0INKhVF
         njd4zOqN5WeEvllppaIjf+FX2rvFRL/AxJ/X/7dskF0ctfuFveoyz0HoaFEdGzHtDNsG
         eXjFRb+qpaj9MsChZF2FuGLNwBQd5ilhFMjIYrsAlk3Nt1izDwSo8fmc6IuysABvmv8h
         4+/6lF1qVlrZuQfrBXJgfIqpLGesRe1+rTAkxNd5bh+TeOyTDpjipaMpT97mnjVzVdjD
         5nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677829184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGfQhG/t4N08bdM7OR/sIi9YbqrZcvYiGl1Zpsb/00E=;
        b=Zq97sCzNqGkOzVzJcclSz/JQcIHtmYzZudk1dAyIRNgpEaaa+UP67Z4QFTRja51zZI
         0NGHpW8Qpe7kgJkVmuhWavgNMKnTD2/lR6VHHEPZRbAI8q3ulxx2tvD4egvEsGIqAuzW
         blvtwn/kqOFJBCLTMNpdaQw/29xONgC3FaNLne9EkV/J2x0ZWRlah65CMHtMtIIx0p86
         /cpNBmhNwMTd/hBR/BfSX/hthauaxlJh7hykD8nW3IGk7GGwBEMkQcV0+2GAkaDqgdoQ
         MMNgf9P0h9wCtJZhZrJDEmFvSDKDbul2VVjR9iG77BsJrSARO1N2FjGSpsOWory6o/kR
         t1sA==
X-Gm-Message-State: AO0yUKXlOJZJV2cVGaqC96EE9MkJRpo4yKoE/qxRV72iNTxZTNAU9/iE
        wunHFJh4f9O+hOcRW8Pw4t9IfQ==
X-Google-Smtp-Source: AK7set/LjHBtEwT+6v5RMbFWSyOlRzU4/Gmj8s46nsQwGhXtC/Up0AYfqUZfe2DNqka4LUW7LkdWRg==
X-Received: by 2002:a17:907:72c2:b0:8ad:51e9:cd57 with SMTP id du2-20020a17090772c200b008ad51e9cd57mr1001868ejc.49.1677829184258;
        Thu, 02 Mar 2023 23:39:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n21-20020a17090625d500b00905a1abecbfsm650572ejb.47.2023.03.02.23.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:39:43 -0800 (PST)
Message-ID: <1c692257-44b5-c443-33d8-1516da3be722@linaro.org>
Date:   Fri, 3 Mar 2023 08:39:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 7/8] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6b8d17006d8ee9a1b0c4df803c1cc7caf53ea3ef.1677749625.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 10:55, Varadarajan Narayanan wrote:
> Add USB phy and controller related nodes
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 92 +++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 2bb4053..319b5bd 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -215,6 +215,98 @@
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> +		ssphy_0: ssphy@7D000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			compatible = "qcom,ipq9574-qmp-usb3-phy";
> +			reg = <0x7D000 0x1C4>;
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_USB0_AUX_CLK>,
> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>;
> +			clock-names = "aux", "cfg_ahb";
> +
> +			resets =  <&gcc GCC_USB0_PHY_BCR>,
> +				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
> +			reset-names = "phy","common";
> +			status = "disabled";
> +
> +			usb0_ssphy: lane@7D200 {
> +				reg = <0x0007D200 0x130>,	/* Tx */
> +				      <0x0007D400 0x200>,	/* Rx */
> +				      <0x0007D800 0x1F8>,	/* PCS  */
> +				      <0x0007D600 0x044>;	/* PCS misc */
> +				#phy-cells = <0>;
> +				clocks = <&gcc GCC_USB0_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "gcc_usb0_pipe_clk_src";
> +			};
> +		};
> +
> +		qusb_phy_0: qusb@7B000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			compatible = "qcom,ipq9574-qusb2-phy";
> +			reg = <0x07B000 0x180>;

Lowercase hex everywhere.

> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				<&xo_board_clk>;
> +			clock-names = "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +			status = "disabled";
> +		};
> +
> +		usb3: usb3@8A00000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +			compatible = "qcom,dwc3";
> +			reg = <0x8AF8800 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_SNOC_USB_CLK>,
> +				<&gcc GCC_ANOC_USB_AXI_CLK>,
> +				<&gcc GCC_USB0_MASTER_CLK>,
> +				<&gcc GCC_USB0_SLEEP_CLK>,
> +				<&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +
> +			clock-names = "sys_noc_axi",
> +				"anoc_axi",
> +				"master",
> +				"sleep",
> +				"mock_utmi";
> +
> +			assigned-clocks = <&gcc GCC_SNOC_USB_CLK>,
> +					  <&gcc GCC_ANOC_USB_AXI_CLK>,
> +					  <&gcc GCC_USB0_MASTER_CLK>,
> +					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +			assigned-clock-rates = <200000000>,
> +					       <200000000>,
> +					       <200000000>,
> +					       <24000000>;
> +
> +			resets = <&gcc GCC_USB_BCR>;
> +			status = "disabled";
> +
> +			dwc_0: dwc3@8A00000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).


Best regards,
Krzysztof

