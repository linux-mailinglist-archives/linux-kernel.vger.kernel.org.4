Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1983A660DE7
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbjAGK0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjAGKZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:25:37 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA98CBED
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:24:14 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bt23so5487174lfb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2EMcV+onqhOTA0NwBZpgQeCm+8rt/XlSXm0iVjEXzA=;
        b=sMsbA5ceEzxqI4auYIpk66bzzaDA5L9CHd/ekkCqtHpypoezA6zth5wU8n6w5YwYxW
         O2be8Lr/qejknQP2Iq63sXEjPDNRJ6ijZHEIwoODsX/LoOe38uldTDdH1KznmzQ6Pu2r
         gcX2ftSzGQNuV43Hm21hsCxHF6yckL8lfG/rqzHv+u2Y6hYNUkf7/mPGquz7/VktMy8L
         WDHOjVhyHWt8NF0Oc8Z5GHzNWxt8uvNjC3UrMtIaMDHYdZakKgNHzRBKLpwCZcgb+4XH
         9toHokcyaGJbhVNmyXisbzWf0s9F9Rgw20bEkYzi7ad75UReZv6hqRwP3U3e52saeTwG
         xK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2EMcV+onqhOTA0NwBZpgQeCm+8rt/XlSXm0iVjEXzA=;
        b=O+FsE20PJTH7QEhLq4zPzLP4IW5M5yni9c0hINr/bzJpUsOWod7hvsN9aTunyz4C+f
         GZLob3jK5ayzTQBRU5Fx+FyGq4B2vUiYbWGK5VUaTtUpEmhBjx5Zqd2ZENUAVLpcQIJR
         zj75btXoTCrhVX+G9Pa8kphXYnrir1bkvjW2QZqJv+b1pQlXMuq5nJtVN15zf8Ry8QSq
         WnwqjRP63xs+Udw68deLiHENqpCThZgQBdPOJ2MkSei9eZ45S/CRcMlVHAHR3rQzp8CO
         z7J1Ckifd1LsPR9z1vYXrL1AfwzDBvxH9pbYqL8PAGtyPWS39gUuAlUwnrk5EALL4xco
         McYw==
X-Gm-Message-State: AFqh2kpPwcjyZlJ51YrRlKVjXKM0lbxR6yCP8MFvPTGhuodczPqBb363
        UH00N5kkjlI0dD5lKEdCuzJduQ==
X-Google-Smtp-Source: AMrXdXt1YkoJc2KNUQwZUtm4Q9Mad6+0kFRCHSU8Y0Oi5MbMUA+IkVBFBLR35D4bWgp2lBG4rLWCxQ==
X-Received: by 2002:ac2:50ca:0:b0:4cc:6f42:a082 with SMTP id h10-20020ac250ca000000b004cc6f42a082mr1302346lfm.4.1673087052911;
        Sat, 07 Jan 2023 02:24:12 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id cf33-20020a056512282100b004a05767bc07sm528921lfb.28.2023.01.07.02.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 02:24:12 -0800 (PST)
Message-ID: <1b5f35ac-05ee-eae5-e17a-d34e2d988e43@linaro.org>
Date:   Sat, 7 Jan 2023 11:24:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
References: <20221215094532.589291-1-bhupesh.sharma@linaro.org>
 <20221215094532.589291-4-bhupesh.sharma@linaro.org>
 <20230106174640.ndis3zm5heoa5wpb@builder.lan>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230106174640.ndis3zm5heoa5wpb@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.01.2023 18:46, Bjorn Andersson wrote:
> On Thu, Dec 15, 2022 at 03:15:32PM +0530, Bhupesh Sharma wrote:
>> Add USB superspeed qmp phy node to dtsi.
>> Make sure that the oneplus board dts (which includes the
>> sm4250.dtsi) continues to work as intended.
>>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
>>  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 37 ++++++++++++++++++-
>>  2 files changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> index 3f39f25e0721e..4f0d65574448b 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> @@ -232,6 +232,9 @@ &usb {
>>  &usb_dwc3 {
>>  	maximum-speed = "high-speed";
>>  	dr_mode = "peripheral";
>> +
>> +	phys = <&usb_hsphy>;
>> +	phy-names = "usb2-phy";
>>  };
>>  
>>  &usb_hsphy {
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> index e4ce135264f3d..030763187cc3f 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> @@ -579,6 +579,39 @@ usb_hsphy: phy@1613000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		usb_qmpphy: phy@1615000 {
>> +			compatible = "qcom,sm6115-qmp-usb3-phy";
>> +			reg = <0x01615000 0x200>;
>> +			clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
>> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
>> +				 <&gcc GCC_AHB2PHY_USB_CLK>;
>> +			clock-names = "com_aux",
>> +				      "ref",
>> +				      "cfg_ahb";
>> +			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
>> +				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
>> +			reset-names = "phy", "phy_phy";
>> +			status = "disabled";
>> +			#clock-cells = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			usb_ssphy: phy@1615200 {
> 
> These patches looks good, but before introducing any
> qcom,sm6115-qmp-usb3-phy in any DT, could we please update the binding
> and driver to the new flattened format - to avoid having to revisit this
> when we try to introduce DP (which I'm guessing this instance has?)
FWIW there's only a single DSI intf (and a single disabled one) on this SoC.

Konrad
> 
> Regards,
> Bjorn
> 
>> +				reg = <0x01615200 0x200>,
>> +				      <0x01615400 0x200>,
>> +				      <0x01615c00 0x400>,
>> +				      <0x01615600 0x200>,
>> +				      <0x01615800 0x200>,
>> +				      <0x01615a00 0x100>;
>> +				#phy-cells = <0>;
>> +				#clock-cells = <1>;
>> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
>> +				clock-names = "pipe0";
>> +				clock-output-names = "usb3_phy_pipe_clk_src";
>> +			};
>> +		};
>> +
>>  		qfprom@1b40000 {
>>  			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>>  			reg = <0x01b40000 0x7000>;
>> @@ -1023,8 +1056,8 @@ usb_dwc3: usb@4e00000 {
>>  				compatible = "snps,dwc3";
>>  				reg = <0x04e00000 0xcd00>;
>>  				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
>> -				phys = <&usb_hsphy>;
>> -				phy-names = "usb2-phy";
>> +				phys = <&usb_hsphy>, <&usb_ssphy>;
>> +				phy-names = "usb2-phy", "usb3-phy";
>>  				iommus = <&apps_smmu 0x120 0x0>;
>>  				snps,dis_u2_susphy_quirk;
>>  				snps,dis_enblslpm_quirk;
>> -- 
>> 2.38.1
>>
