Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8D6AABA4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCDRpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCDRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:45:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF3512069
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 09:45:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so5741442wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677951911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rsDOa+CNgxF+LrbSAZ/zI3/iIB1uuy0CX68cc9ZNyA0=;
        b=NW7OlzaI4JzVr0yaqHB5GmJkZtcr0ESKphODI8Lm4R+gfUZlVH438JMYWhaB7LL1Ap
         b84LlSJ56E8GM0WXUTekuV38nczf7lNeg6W/m/VP69nP2kFA3u/mec4lOjDtp07hLvf2
         GjPJpJ9f4L+5xtIcjHn4orq53+6QujHEaFNurRPPBIVd30yIq8iJgTs4uPk/5VsRqqU2
         v2CrJ8uDnkqBnMIp+N2F06ZY2LELmlz+jSlnFQKi2Ef1umyVOu8uckIFuEKyPb1gU990
         3mRai8jzyA2vGAhjjgnox70CIe2dk1j76Wh/U9U2FbspyFjJqtLBixoYrYr6lDekjLE6
         +8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677951911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsDOa+CNgxF+LrbSAZ/zI3/iIB1uuy0CX68cc9ZNyA0=;
        b=maV8FGJjewYaQbsj3WRTISLfH/ApAWiTEjdDb2qfSSmQkOEkKG13aAe+SA3uXZhWZG
         JT0wlLYHKJuvSq7QdYVX7GZaU4mNjcdHG0Ww8victIUbzfdEvkwNR9z3SWo0fQZeOKCV
         2/PFdTxhO/0NxyaSYrk3QEnaOLbbrdsF8UL5hJGgSCZfVzaZ76IJiaIYgn9z3zz6IywT
         x9TazgR4AyQiU0aCG3SVxGPrbCbWt9HcGD3Cb9QMARwQZFp95EiVsy3PEeNf2P014NuB
         B9/ZrLPcWOMapAaES04u4hqwd7KYdcA4xrW56gFVNSybN75G3f6S51PL2jWOJM7brS7u
         v2vg==
X-Gm-Message-State: AO0yUKVPjFD+G+34BVnpNEOOHL/NnV+CESotj2bsesw9gvGOm5mseudP
        Gliy9CIBCnEUjamL1BCa8MqsKg==
X-Google-Smtp-Source: AK7set/inqpSJRQRK+Fs1MdmEEpc2iqOvzWeyLhCqa0+AKUxKHSpRzR2JRlZJxO6iRpwlagKjhU5dA==
X-Received: by 2002:a05:600c:1e0e:b0:3dc:55d9:ec8 with SMTP id ay14-20020a05600c1e0e00b003dc55d90ec8mr4784841wmb.41.1677951911204;
        Sat, 04 Mar 2023 09:45:11 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b002c7b229b1basm5522533wrr.15.2023.03.04.09.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 09:45:10 -0800 (PST)
Message-ID: <28561c8b-e9a3-b58e-429a-6dc331ad94e4@linaro.org>
Date:   Sat, 4 Mar 2023 17:45:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
 <20230304-topic-dsi_fixup-v3-1-b8565944d0e6@linaro.org>
 <c1a2ba5b-4cd9-362b-5a4e-e95a6bf27b3e@linaro.org>
 <30798bd2-5805-45e6-92d2-a9df6fb52600@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <30798bd2-5805-45e6-92d2-a9df6fb52600@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2023 17:35, Konrad Dybcio wrote:
>> you'll see no error. However if you just do this
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> index 0733c2f4f3798..829fbe05b5713 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
>> @@ -1094,8 +1094,7 @@ mdp5_intf1_out: endpoint {
>>                          };
>>
>>                          dsi0: dsi@1a98000 {
>> -                               compatible = "qcom,msm8916-dsi-ctrl",
>> -                                            "qcom,mdss-dsi-ctrl";
>> +                               compatible = "qcom,mdss-dsi-ctrl";
>>                                  reg = <0x01a98000 0x25c>;
>>                                  reg-names = "dsi_ctrl";
>>
>>
>> and run the same test you get
> Yes, correct. It's valid but it's deprecated, so the bindings are
> sane. Keep in mind there's an ABI-like aspect to this.
> 
> Konrad

The _driver_ will still accept "qcom,mdss-dsi-ctrl" which is ABI 
compliant but, I don't see why the yaml should.

If you declare a new .dts with only "qcom,mdss-dsi-ctrl", that should 
throw a yaml check error.

---
bod
