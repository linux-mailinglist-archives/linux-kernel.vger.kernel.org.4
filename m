Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EE64D7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLOITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLOITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:19:42 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8EE1F624
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:19:41 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b9so9163399ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSN2/dLk93fIRVrCh8N+0AmorCRCNEabm5sVB7MbO9A=;
        b=XdVfWnxMN7fe1l0Uox7bvSuAbgsX4/G1RES/z7paJzDhpv428QfCL/0kIogX908QlD
         aGv/khZLcysVMdTLJCBcB6/ZYVo4oC554CLmDd5jO+2AvHpepXsYktFm4twIxnb3ytOB
         OKeH1f2/6KKVjFbIorzW3y29nVCxQW8/uQ1zHrzLEZXcIJJrhLR38FaqCcqiO4Zglg8y
         1Adiu65jQjbdHisY8kdg8TB7nZJR6sgZOZm9tgq4UpNVwW4XJa1nzV3Y5KwmwZbNeISt
         ztHQ8DZy4Sj4mZFL6Mw1+irWMEnH/QauYMHEErHbM7+JnGuxbpUhAQ2c/Q8M/vLy7f0v
         wZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSN2/dLk93fIRVrCh8N+0AmorCRCNEabm5sVB7MbO9A=;
        b=hT9xaCQKNM0B04LuaMx+Ne2KL7hlvk4gJvE1KC1mn+NRktcOca/Q8L3vMs2fEpdNGW
         OZm2ju+1+Koj3PPWN5Ahs5myIvnWj7aFq5kxKCs6gE2Qi+kg9RpXDp2X8RsQIN087HPp
         GULEHpY+ayFJOf/MkreCojMrnauq++sFNQ3YT/QkfKP1j0SVfXuZW0qUchO1yrP3+6sB
         okwgwU1a0jOGf3GNyEiew+JF+wzccxwx4OTju+o10BHqDPEZkhLzmPEowOMOLWoRBDCn
         XwVgoSecxOXIAV93XeuspcgCW8EsfqXHjoELk6B5a2WJT0VtvXuLUg+Yop1ab++lfjHT
         o5VA==
X-Gm-Message-State: ANoB5pmgN6xmpGq+1goiWHTgiQT0DUslPfgkf0tRMkfh0aHs68bWknCJ
        lYc/3Bwx9gMeKCWKyyiEMTrSnw==
X-Google-Smtp-Source: AA0mqf7eZY/U6gUBEczTfy7RT19UpsBoMLFLoSgY1p+EcMD9LW0qs3VPqpFnkdT6sSo2Jsp8NA7oog==
X-Received: by 2002:a05:651c:908:b0:26f:db35:ec37 with SMTP id e8-20020a05651c090800b0026fdb35ec37mr6562339ljq.17.1671092379312;
        Thu, 15 Dec 2022 00:19:39 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u16-20020a2eb810000000b00277041268absm781179ljo.78.2022.12.15.00.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 00:19:38 -0800 (PST)
Message-ID: <f77cc097-56ac-845f-9882-e67aab82b02c@linaro.org>
Date:   Thu, 15 Dec 2022 09:19:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
References: <20221214203124.564537-1-bhupesh.sharma@linaro.org>
 <20221214203124.564537-4-bhupesh.sharma@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214203124.564537-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 21:31, Bhupesh Sharma wrote:
> Add USB superspeed qmp phy node to dtsi.
> Make sure that the oneplus board dts (which includes the
> sm4250.dtsi) continues to work as intended.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
>  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 38 ++++++++++++++++++-
>  2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index 3f39f25e0721e..4f0d65574448b 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -232,6 +232,9 @@ &usb {
>  &usb_dwc3 {
>  	maximum-speed = "high-speed";
>  	dr_mode = "peripheral";
> +
> +	phys = <&usb_hsphy>;
> +	phy-names = "usb2-phy";
>  };
>  
>  &usb_hsphy {
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index e4ce135264f3d..15f311dcd289f 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -579,6 +579,40 @@ usb_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		usb_qmpphy: phy@1615000 {
> +			compatible = "qcom,sm6115-qmp-usb3-phy";
> +			reg = <0x01615000 0x200>;
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_AHB2PHY_USB_CLK>;
> +			clock-names = "com_aux",
> +				      "ref",
> +				      "cfg_ahb";
> +			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> +				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> +			reset-names = "phy", "phy_phy";
> +			status = "disabled";
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			usb_ssphy: phy@1615200 {
> +				reg = <0x01615200 0x200>,
> +				      <0x01615400 0x200>,
> +				      <0x01615c00 0x400>,
> +				      <0x01615600 0x200>,
> +				      <0x01615800 0x200>,
> +				      <0x01615a00 0x100>;
> +				#phy-cells = <0>;
> +				#clock-cells = <1>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
> +

Still two blank lines.

Best regards,
Krzysztof

