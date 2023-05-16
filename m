Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A23E7051FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjEPPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjEPPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:23:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F9676BC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:23:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so21791370a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684250596; x=1686842596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veRzPqieD2xIyPWtInPZpay2oq9TezkA6RY5NApQtqk=;
        b=LCLogQMJsTZ6Ovarvk7cE7knhWlL4Yx31pjrraLSRlFTj+nXAiFr/rc4lWLVJxQRx+
         IkZ+BG7UGc10H4JVE37lH3WrCIei63NAoGFL1TUb2QQhIVIiLZsM/K6LWDzmXYd922lk
         eZLVJ8yMiueTaVT/fFnFLompS/D/Fv8J1xCmDI7Y2Dg4rL/tP97QbxRVLCA4prXM1dba
         T2dKyHDKzV9TSOq1cOgxg2RxNcpitnb8jn+NxarGB3/zU7BkNgFmechon7bDB1LjNTeM
         xiVY1JWvKQQ6tj6Pr9GiSITVAvbRRCvi69XV/cI9dUEZEZehVhahgLS/ZCK1BM2zkz8V
         7W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684250596; x=1686842596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veRzPqieD2xIyPWtInPZpay2oq9TezkA6RY5NApQtqk=;
        b=icAelFU2srfy62OCGFjDkIX7QtRrHI7+gZF1n2FuM7J/7V5xXCvANqcqDPjK1mc33F
         gqiDBI55TM5E9GkpHznA9rRiDMq5y4C3IAfxk2Qs+YHNazfdklrouhWya7WuFBj2jdcj
         qkL3Qfk8s035oD2AlYO9u74dKAotz3xj4Bcl/c6hh9gkd462QejQDnqvqrrqgkHSyRYK
         dapdq9Opwn0wjffpTkMRElDUyZiYIAig2yXP61evcE7brON5/6Hts6bTAtnnlCUEOL9C
         ZAaRsv0Bn5ILvBh5fLwFrsPmL16HN2cAe6XRfBVPv/jaNLEpZZo8tkVIHAX0Ofpfa4Xv
         hEeg==
X-Gm-Message-State: AC+VfDyLjds69XnCixZZugM5M+dP3CHLTJihDzWTxHBTe5PtBdVpl0fd
        FrZCw/ZhVdQnO2NpTEnNQZrnSQ==
X-Google-Smtp-Source: ACHHUZ71bCaUguxQbo8uXIgrwfdQ91XlJ93Pf3PozcM9swMT7wOvO1lwIeC8RhFNlZOE0pIJXhG+Mw==
X-Received: by 2002:a50:ef0c:0:b0:50b:c42b:b737 with SMTP id m12-20020a50ef0c000000b0050bc42bb737mr28694427eds.37.1684250595768;
        Tue, 16 May 2023 08:23:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id a17-20020aa7d751000000b0050d988bf956sm8425605eds.45.2023.05.16.08.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:23:15 -0700 (PDT)
Message-ID: <8b670310-47b3-c301-99ae-84ccb704d733@linaro.org>
Date:   Tue, 16 May 2023 17:23:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-qrd: add display and panel
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>
References: <20230516151708.213744-1-krzysztof.kozlowski@linaro.org>
 <ecfe4f62-9c54-df5e-cd5d-e7a956510696@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ecfe4f62-9c54-df5e-cd5d-e7a956510696@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 17:20, Konrad Dybcio wrote:
> 
> 
> On 16.05.2023 17:17, Krzysztof Kozlowski wrote:
>> Enable Display Subsystem with Visionox VTDR6130 Panel (same as on
>> MTP8550).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Context in the patch depends on:
>> 1. https://lore.kernel.org/linux-arm-msm/20230516133011.108093-1-krzysztof.kozlowski@linaro.org/T/#t
>> 2. https://lore.kernel.org/linux-arm-msm/20230512160452.206585-1-krzysztof.kozlowski@linaro.org/
>> ---
>>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 76 +++++++++++++++++++++++++
>>  1 file changed, 76 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>> index 30b36a149125..03bf6bc2db4d 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>> @@ -420,6 +420,10 @@ vreg_l3g_1p2: ldo3 {
>>  	};
>>  };
>>  
>> +&dispcc {
>> +	status = "okay";
>> +};
> Missed this in the bigpatchdrop review.. It makes no sense to keep
> dispcc disabled by default (other than for lazily "solving" UEFI
> framebuffer being shut down)

Sure.

> 
>> +
>>  &gcc {
>>  	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>>  		 <&pcie0_phy>,
>> @@ -431,6 +435,50 @@ &gcc {
>>  		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>  };
>>  
>> +&mdss {
>> +	status = "okay";
>> +};
>> +
>> +&mdss_dsi0 {
>> +	vdda-supply = <&vreg_l3e_1p2>;
>> +	status = "okay";
>> +
>> +	panel@0 {
>> +		compatible = "visionox,vtdr6130";
>> +		reg = <0>;
>> +
>> +		pinctrl-names = "default", "sleep";
>> +		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
>> +		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
> property-n
> property-names

Sure, copy-pasta from MTP8550.

>> +
>> +&mdss_mdp {
>> +	status = "okay";
>> +};
> This should also be enabled by default, MDSS is useless when MDP is
> disabled.

But don't we want to disable both when display is not used (not connected)?

Best regards,
Krzysztof

