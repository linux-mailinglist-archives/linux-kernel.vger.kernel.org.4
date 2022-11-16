Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6395F62BA23
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiKPKwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbiKPKvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:51:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB75288E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:40:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id r12so28835810lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5arRNEzeZmyjcIxb0J9Ia9IkpqFKY/qEalRnuGlZPo=;
        b=AUBOm9BP50OfpbVXPPBIHmkCgP1NJev70bSUdhsEOQq4AM7FErUK6wWRFf6RuVPBrr
         ARaEcAzSXMcWgmBz9XRNQ/gJ1Omz572yZJ2Aee15mMgei7lO85PWTuw4Uo38XTOga7bv
         qYxdard31IkDKjKcP9WV2DSFHOhoL8R3kl4RFHGa0t1YoBB6Ptpx3Y/HfPPpCtwYe8gd
         MuZA/5kJBOk+q70UO6mo9KKXbX/JLsiUuRkg6PJ3nx0Z4miRTw1X9BDUb2yY/hMqyW1B
         5kck6QMDyfjJsJ6hU1QTC4eyMGzZHdzGhjnvpGxHTCNP6lqVfnZBjFgJANqXOD62E141
         J18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5arRNEzeZmyjcIxb0J9Ia9IkpqFKY/qEalRnuGlZPo=;
        b=PVDUmAvjQGYRCVDPUYTQXfyukZtjIEzG7kxzMOqgEmSghV5/ghN31cwu1X2XVv7N4B
         D5f627lgq3c7Q0/mNj1gQiUOROxvPHfP3wsOaKjSW7GySxEDVFCdTKS9yjWkhHSJAFdt
         tAlKIWqKsXH3Ghrc5LtA6ZoNaZOC+Vs7d/yrwR7HG4TSv5sUzM63nxLUEGxcWNgO2jvm
         KMiHMlnsoL+UfgYrollaZIMG1lq1hF9qhSob2AUfQYSsb2nQCpy4/jFgNEIcu2P9zEt7
         3+haBQLgnrRcNxYqrSVI+z7D9/oLLneb3+pJOUxSlYzVfF6mmURVI5Wa83AMrHDia/VL
         gZPg==
X-Gm-Message-State: ANoB5plZW3E1+ODvcE+RLCgXrYaQ7oXWOfp/who3P4Z3SfQ3xlzKD+A7
        64FJOboZVRrDUO600TN8tJTNSQ==
X-Google-Smtp-Source: AA0mqf6YoduX3Hvycoq2nH3KppUunH72l9zKBO4zSS68VxXoAK22YdieVasPPe2cdhrbxs+vx3MveA==
X-Received: by 2002:a05:6512:3f01:b0:4a6:396d:a06a with SMTP id y1-20020a0565123f0100b004a6396da06amr7577079lfa.514.1668595216946;
        Wed, 16 Nov 2022 02:40:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d25-20020a19e619000000b00494706193adsm2534950lfh.208.2022.11.16.02.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:40:16 -0800 (PST)
Message-ID: <75550e08-cbec-2d4a-429f-c94e0803fcc1@linaro.org>
Date:   Wed, 16 Nov 2022 11:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and
 LPASS
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-3-srinivas.kandagatla@linaro.org>
 <5ff80fe0-eb23-9db0-ab75-189da5977901@linaro.org>
In-Reply-To: <5ff80fe0-eb23-9db0-ab75-189da5977901@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 09:10, Krzysztof Kozlowski wrote:
> On 15/11/2022 18:02, Srinivas Kandagatla wrote:
>> Add LPASS Codecs along with SoundWire controller for TX, RX, WSA and VA macros
>> along with LPASS LPI pinctrl node.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 324 +++++++++++++++++++++++++
>>  1 file changed, 324 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index e3cdd8bccb0c..a87d58bee1e0 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -11,6 +11,7 @@
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>  #include <dt-bindings/thermal/thermal.h>
>>  #include <dt-bindings/soc/qcom,gpr.h>
>>  
>> @@ -1115,6 +1116,9 @@ usb_2_ssphy1: phy@88f1e00 {
>>  			};
>>  		};
>>  
>> +		sound: sound {
>> +		};
> 
> sound node is not part of SoC.
> 

To clarify - I meant to put it outside of soc node.

Best regards,
Krzysztof

