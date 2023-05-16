Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4570520D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjEPP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjEPP0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:26:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309176182
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:26:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2acb6571922so129265651fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684250808; x=1686842808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdgCtQ9x428g2fmdq2eeF1lpjWBXFBmUKUBwGdZd0fw=;
        b=F8IDR3e8D15lWntbesEEnnzt0b7ERjoyuM2hgFPYNc58euIW6njIvDNilJkAz4ZC56
         LhtUGQiK9kT++dq0l4+94724yxzysWsDLGsNho5Cak9npWcJz7ZSr/YdUBGc4gyBxJ/+
         LvPtMo8VmpgUUyBc9cpJJCREfA1kMojcqCgk07vjs0Sqsabqi7xaH7yprJc1xia11Nd5
         xWvRDTD2K9c1iqslb7MZNcd6VcG2mq7vZp77FWhhf0K+MD1bW/QiIamEzrB5JlB00lSA
         jF32Oo4rN4Xre5AL/BQ4koSXzneRQjwgaYZD63X+07z9/FDvQkISHXR49vZszx2zfvwt
         H05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684250808; x=1686842808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OdgCtQ9x428g2fmdq2eeF1lpjWBXFBmUKUBwGdZd0fw=;
        b=X5so5pPGiFHLlhaJ+Jdxb68KHg02VckxaRf/o3Y2XRyPc/U8lPfORNTtiDNrbAvvMe
         qDUoH613DGEXza+S40h0jlzDagYHXmE/2x+PAvho35r1JR+4SphVSGyW+L21Y7yr7I2c
         1Gnqsz2nmetqeCT9z/fLh0xSVlc/wK/SCuJQ18Ic9x62EiyaKtTPSHPOhNLEfm8foNYL
         5SzPQPjAwECGJ7RFLbMbD9+A2jfDk9NFzFvNxBSyrLc/h/+c7awsOwaZpjgmF5O2j7V5
         VXteSu7J/8AAGzxocGtd7ss1jWeut+B9jGE2+St41f59AnnyIYfoqgDe5JMbGLLSk2EO
         XZCw==
X-Gm-Message-State: AC+VfDydwQ9147s8G2KUNY7W9HpJzSSiSW1FEx5rG/g2akJxQ1WGZ5ju
        R3vsO1hoUcXBtU6ZoZTwjd6ziQ==
X-Google-Smtp-Source: ACHHUZ4JnnNBUH5N5yBTJqLceiHUwDt+Vr2wAmyEEWYqYKDQDcGQ51HM6tKSml1kcspqDpAFHoykdw==
X-Received: by 2002:a2e:9c97:0:b0:2a8:c7c2:c380 with SMTP id x23-20020a2e9c97000000b002a8c7c2c380mr9408632lji.48.1684250808416;
        Tue, 16 May 2023 08:26:48 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id y5-20020a2e95c5000000b002addbc16a54sm1456172ljh.41.2023.05.16.08.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:26:47 -0700 (PDT)
Message-ID: <2bc16f9a-e150-b3d0-6d72-a2ff0a4d05ae@linaro.org>
Date:   Tue, 16 May 2023 17:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8550-qrd: add display and panel
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <8b670310-47b3-c301-99ae-84ccb704d733@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <8b670310-47b3-c301-99ae-84ccb704d733@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.05.2023 17:23, Krzysztof Kozlowski wrote:
> On 16/05/2023 17:20, Konrad Dybcio wrote:
>>
>>
>> On 16.05.2023 17:17, Krzysztof Kozlowski wrote:
>>> Enable Display Subsystem with Visionox VTDR6130 Panel (same as on
>>> MTP8550).
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Context in the patch depends on:
>>> 1. https://lore.kernel.org/linux-arm-msm/20230516133011.108093-1-krzysztof.kozlowski@linaro.org/T/#t
>>> 2. https://lore.kernel.org/linux-arm-msm/20230512160452.206585-1-krzysztof.kozlowski@linaro.org/
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 76 +++++++++++++++++++++++++
>>>  1 file changed, 76 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>>> index 30b36a149125..03bf6bc2db4d 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
>>> @@ -420,6 +420,10 @@ vreg_l3g_1p2: ldo3 {
>>>  	};
>>>  };
>>>  
>>> +&dispcc {
>>> +	status = "okay";
>>> +};
>> Missed this in the bigpatchdrop review.. It makes no sense to keep
>> dispcc disabled by default (other than for lazily "solving" UEFI
>> framebuffer being shut down)
> 
> Sure.
> 
>>
>>> +
>>>  &gcc {
>>>  	clocks = <&bi_tcxo_div2>, <&sleep_clk>,
>>>  		 <&pcie0_phy>,
>>> @@ -431,6 +435,50 @@ &gcc {
>>>  		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
>>>  };
>>>  
>>> +&mdss {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&mdss_dsi0 {
>>> +	vdda-supply = <&vreg_l3e_1p2>;
>>> +	status = "okay";
>>> +
>>> +	panel@0 {
>>> +		compatible = "visionox,vtdr6130";
>>> +		reg = <0>;
>>> +
>>> +		pinctrl-names = "default", "sleep";
>>> +		pinctrl-0 = <&sde_dsi_active>, <&sde_te_active>;
>>> +		pinctrl-1 = <&sde_dsi_suspend>, <&sde_te_suspend>;
>> property-n
>> property-names
> 
> Sure, copy-pasta from MTP8550.
> 
>>> +
>>> +&mdss_mdp {
>>> +	status = "okay";
>>> +};
>> This should also be enabled by default, MDSS is useless when MDP is
>> disabled.
> 
> But don't we want to disable both when display is not used (not connected)?
The MDSS bus device only has a 0x1000 slice of the 0x90000-long "full MDSS",
the rest is probed with MDP/DPU. It also calls of_something_populate that
make DSI, DSIPHY and DP/HDMI probe. But all of them ultimately need a graph
handle to MDP.

If we have a display (of any kind), MDP has to be enabled (or the display
engine will not have a way to be programmed).

If we don't, enabling MDSS makes no sense as all of the hardware will be
shut down right after probing.

So I'd say either both or none.

Konrad
> 
> Best regards,
> Krzysztof
> 
