Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18C4671F61
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjAROWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjAROVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:21:49 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D511571F00
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:04:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r2so34037245wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BStJknkxNRkRdaOPMntui8WFVTLp1fXVr+hgk9OK3CA=;
        b=HqO4zk2i3L2FfBM4Uj2xpJNG3ZIVGe7mW87LZa2tw6nMQZNAUd9ml5oWmmS07J4Ofp
         2yK4LwD+K8R+22mNujCfVO8gKpoXKRyCTtDXclChY03p0TVd3WUKUyE8Mt8KUFZxkgMS
         KR1bONAnE39Gkbc/mPMJIJdJ9vQNZWbtSGGhOoekDp88QKNNcxRFCPGlKrPEYAloXxmy
         xzaymLTViFe+3DSidGNVb64JZDUazReeRh9j4pz7TwU+IPLgt/b0xWUh37EQw00RhsXY
         Bz3e7hIgmc/Aic6soff8QNct4Tt90+QVUFM8rKa4eDSua4fQXrEZanhBH8iD1HXJBjkO
         Avkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BStJknkxNRkRdaOPMntui8WFVTLp1fXVr+hgk9OK3CA=;
        b=zOxR8M+UkRvMHh2DCQxtM9m25gkONXxXO+XxSfMvcpysRl6GY0jnbWXLcXG1dNU9M4
         bBWCiwpMfdyIP/GDtScgowF2HUP0GANgGMm5KCweNigGLJdEue47F5Lb2jkfiTUUwJaU
         EevVSKs4xDUVtHyM+XGi7Qr9GZUNSanRSjSTqX1SMh+bOVDDJQ2JjrTJDLcjlnbLw8Wj
         fY5x3yOONI3r1x5znoYuhxuW7JGbe0inj/nAd2ls9mFoIFOPOAcBn706AGY7eBlnXl96
         1SHKMcTw5k0yRQfCoCHvXaT8wwzne62a6jl20NxcmCvlKHLHq++lhhuNFiTWsFLYPTt2
         gQzg==
X-Gm-Message-State: AFqh2kpAkEQIYG0HDbasPn2sxSDUoV/QoPD5oINcUluj+oKptipDSSv7
        G296kkpjNN119QB//RIe+NFc65vwpLyr06Oxycw=
X-Google-Smtp-Source: AMrXdXvisreUlEjmD2E9PJTmXfgydOinhvuH8ytmedUlVBRJ/Vz6PU/+YBdLYpYO3dMPO8X37PikQA==
X-Received: by 2002:a5d:50c9:0:b0:2bd:db42:36cd with SMTP id f9-20020a5d50c9000000b002bddb4236cdmr5869055wrt.0.1674050656317;
        Wed, 18 Jan 2023 06:04:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:37dc:5071:959c:93e4? ([2a01:e0a:982:cbb0:37dc:5071:959c:93e4])
        by smtp.gmail.com with ESMTPSA id n6-20020adfe786000000b002bdbde1d3absm21305586wrm.78.2023.01.18.06.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:04:15 -0800 (PST)
Message-ID: <e7c0fd5a-f77c-a9ef-a648-a711e1eff5ad@linaro.org>
Date:   Wed, 18 Jan 2023 15:04:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm8550-mtp: add DSI panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230104-topic-sm8550-upstream-dts-display-v3-0-46f0d4e57752@linaro.org>
 <20230104-topic-sm8550-upstream-dts-display-v3-3-46f0d4e57752@linaro.org>
 <9fb2618f-43ab-c644-c957-67ffc4c05dc3@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <9fb2618f-43ab-c644-c957-67ffc4c05dc3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 14:36, Konrad Dybcio wrote:
> 
> 
> On 18.01.2023 09:55, Neil Armstrong wrote:
>> Add nodes for the Visionox VTDR6130 found on the SM8550-MTP
>> device.
>>
>> TLMM states are also added for the Panel reset GPIO and
>> Tearing Effect signal for when the panel is running in
>> DSI Command mode.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 56 +++++++++++++++++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> index 0dfd1d3db86c..2de387aa2c2d 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
>> @@ -370,6 +370,34 @@ &mdss {
>>   &mdss_dsi0 {
>>   	vdda-supply = <&vreg_l3e_1p2>;
>>   	status = "okay";
>> +
>> +	panel@0 {
>> +		compatible = "visionox,vtdr6130";
>> +		reg = <0>;
>> +
>> +		pinctrl-names = "default", "sleep";
>> +		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
>> +		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
> Hm.. I've just realized there are two styles of specifying
> phandle arrays: <&a &b> and <&a>, <&b>.. even worse, we
> have both of them in our tree.. Krzysztof, Bjorn, which one
> should we go with, going forward?

I've been cleaning into <&a>, <&b> for the last few years and
it clearer since it separates each phandle (+ parameters) in the DTS.

Neil

> 
> 
>> +
>> +		vddio-supply = <&vreg_l12b_1p8>;
>> +		vci-supply = <&vreg_l13b_3p0>;
>> +		vdd-supply = <&vreg_l11b_1p2>;
>> +
>> +		reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
>> +
>> +		status = "okay";
> Superfluous, it's enabled by default, drop

Ack, will remove

> 
> Konrad
>> +
>> +		port {
>> +			panel0_in: endpoint {
>> +				remote-endpoint = <&mdss_dsi0_out>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&mdss_dsi0_out {
>> +	remote-endpoint = <&panel0_in>;
>> +	data-lanes = <0 1 2 3>;
>>   };
>>   
>>   &mdss_dsi0_phy {
>> @@ -415,6 +443,34 @@ &sleep_clk {
>>   
>>   &tlmm {
>>   	gpio-reserved-ranges = <32 8>;
>> +
>> +	sde_dsi_active: sde-dsi-active-state {
>> +		pins = "gpio133";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +	};
>> +
>> +	sde_dsi_suspend: sde-dsi-suspend-state {
>> +		pins = "gpio133";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	sde_te_active: sde-te-active-state {
>> +		pins = "gpio86";
>> +		function = "mdp_vsync";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>> +
>> +	sde_te_suspend: sde-te-suspend-state {
>> +		pins = "gpio86";
>> +		function = "mdp_vsync";
>> +		drive-strength = <2>;
>> +		bias-pull-down;
>> +	};
>>   };
>>   
>>   &uart7 {
>>

