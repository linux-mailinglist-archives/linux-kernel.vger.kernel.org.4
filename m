Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175C169221E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBJP02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBJP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:26:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA9172C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:26:22 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id z13so4088508wmp.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MI0pJoJjJW53j1vziPtBPFrePFjIW6d9gPmtB55UHYs=;
        b=mr1Svns2pPLmbqQpFN/FvnuWqrf8t59pfCISLf/Q7cljSkSmII0VEdXcV4Cyv0o5qV
         yKFwki5+bnF2u+PWuXwNu6kI1nvP6tBFsvR8aWbfjah4FQg4l8onk4T/NQfEzcW+uKGe
         21iXfHYG1oLPATtYDhBR0+rdPfJrQJM7wz7ldI4Weo6vUjCS7osDwg9ZlpFga1QZXYk4
         KJluEf/PgmS7WTVVfVniu/whRh6Xde3s5QLHUOOl2VteVpxJHyrweaVJfYbcq+jWA3go
         Affi2MoY+PPJDGipNWGuqdnKruoC0TbAkJuSZwXXwyCd+zuC6cNXpSjj31mKKdsnMGfX
         +IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI0pJoJjJW53j1vziPtBPFrePFjIW6d9gPmtB55UHYs=;
        b=iWWvMpPWOpSkqIGhgfngeuPtpp7ZQgnnlN/hMC5M5eGPOM0PRKjCCVG+/UZUU6/c8s
         AQkKaV+FFTj70uEwTrNIs3ilpwenxDhhkKaOhnXMALyi22FEqqfSa12D0lrPSmDoCJbe
         dmIfqtjW38afWawNsBfArgOWnM+9Hhu3E6nC5CvdEE450gxPKtpKKJigelDg79RcoQFJ
         LhquHL0pkJRNgEMMFNuWqSXwv/KZKB6YsWQxnt3IFAsbHbsB3cTzon3QXxD8oa6JUVvY
         isOGe+zvDgKNMQ9NEvz4A0xNhnQhcuNV1MZfxZtkTH9wbdwUiK8SkNldF8j3TNfIZbEE
         fmVw==
X-Gm-Message-State: AO0yUKUDXcyrtGabGP60kKlX5reDh15h1Vay2xlwHRJNzdelcqJFzKmW
        Hz67Qs/8JlWpN6kDOgClk249sA==
X-Google-Smtp-Source: AK7set+qFG2qGlt0qvwTq3RWA0dKdzYCfRmpXn/7Ezi6vuPn8Qa8oRQpHBpfgobF1qwXJTht6MTUGw==
X-Received: by 2002:a05:600c:13ca:b0:3dc:5937:35a2 with SMTP id e10-20020a05600c13ca00b003dc593735a2mr14517027wmg.9.1676042781326;
        Fri, 10 Feb 2023 07:26:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a65:5553:55cf:3027? ([2a01:e0a:982:cbb0:5a65:5553:55cf:3027])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b003e0015c8618sm8588935wmb.6.2023.02.10.07.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:26:20 -0800 (PST)
Message-ID: <411990c0-d8fc-c9b4-d05a-3779435626f8@linaro.org>
Date:   Fri, 10 Feb 2023 16:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 08/11] arm64: dts: qcom: sm8350-hdk: add pmic glink
 node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-8-71fea256474f@linaro.org>
 <a0a47304-3d57-40ff-421d-f040420ec0b0@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <a0a47304-3d57-40ff-421d-f040420ec0b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 16:21, Konrad Dybcio wrote:
> 
> 
> On 10.02.2023 16:02, Neil Armstrong wrote:
>> Add the pmic glink node linked with the DWC3 USB controller
>> switched to OTG mode and tagged with usb-role-switch.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 77 ++++++++++++++++++++++++++++-----
>>   1 file changed, 65 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> index 54654eb75c28..28fc9a835c5d 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
>> @@ -31,6 +31,40 @@ hdmi_con: endpoint {
>>   		};
>>   	};
>>   
>> +	pmic-glink {
>> +		compatible = "qcom,sm8350-pmic-glink", "qcom,pmic-glink";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		connector@0 {
>> +			compatible = "usb-c-connector";
>> +			reg = <0>;
>> +			power-role = "dual";
>> +			data-role = "dual";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +
>> +					pmic_glink_hs_in: endpoint {
>> +						remote-endpoint = <&usb_1_dwc3_hs>;
>> +					};
>> +				};
>> +
>> +				port@1 {
>> +					reg = <1>;
>> +
>> +					pmic_glink_ss_in: endpoint {
>> +						remote-endpoint = <&usb_1_dwc3_ss>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +
>>   	vph_pwr: vph-pwr-regulator {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vph_pwr";
>> @@ -666,23 +700,42 @@ &usb_1 {
>>   };
>>   
>>   &usb_1_dwc3 {
>> -	/* TODO: Define USB-C connector properly */
>> -	dr_mode = "peripheral";
>> -};
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>>   
>> -&usb_1_hsphy {
> Are you removing the hsphy completely?

Oops seems I did remove too much stuff... thx for noticing

> 
> Konrad
>> -	status = "okay";
>> +	ports {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>>   
>> -	vdda-pll-supply = <&vreg_l5b_0p88>;
>> -	vdda18-supply = <&vreg_l1c_1p8>;
>> -	vdda33-supply = <&vreg_l2b_3p07>;
>> +		port@0 {
>> +			reg = <0>;
>> +
>> +			usb_1_dwc3_hs: endpoint {
>> +				remote-endpoint = <&pmic_glink_hs_in>;
>> +			};
>> +		};
>> +
>> +		port@1 {
>> +			reg = <1>;
>> +
>> +			usb_1_dwc3_ss: endpoint {
>> +				remote-endpoint = <&pmic_glink_ss_in>;
>> +			};
>> +		};
>> +	};
>>   };
>>   
>> -&usb_1_qmpphy {
>> -	status = "okay";
>> +&usb_1_dwc3 {
>> +	dr_mode = "otg";
>> +	usb-role-switch;
>> +};
>>   
>> -	vdda-phy-supply = <&vreg_l6b_1p2>;
>> -	vdda-pll-supply = <&vreg_l1b_0p88>;
>> +&usb_1_dwc3_hs {
>> +	remote-endpoint = <&pmic_glink_hs_in>;
>> +};
>> +
>> +&usb_1_dwc3_ss {
>> +	remote-endpoint = <&pmic_glink_ss_in>;
>>   };
>>   
>>   &usb_2 {
>>

