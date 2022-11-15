Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82662958C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiKOKQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKOKQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:16:27 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08629B61
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:16:26 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s24so16868018ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGHlZVL39eCUsJrhUm15x+JuQR4luXm9cgq/qr21IVY=;
        b=etoIZgnqAeeAztGAY0oY4aMkSANYzJwcegk3tPICBKH07bc7OBcEuXy4aHDAh3Lklp
         PSM14j14q26wQkZGe4AxoLUpeXbyGJ8FcXuKaaefsSyvZcMQpjh8jWA7KpjJJqyA4dxG
         pB3ZZ+jtw1X0qrDR8Tn4s1HfC1r0xjrXv66TyET+EqCOd9UFS63JX1jgKC0NLfwe2Lds
         IvWNxGUou28td2JgbQ9K64Q/vMaVO4xlKRPAdL+Zg8nQOan/qnib7ublcnAPNhg/g27U
         AhrQ1akMtoQFwt2Mv8iDa6ge+6L2HfVPR744POiyDn4qHbZDbliolGuzI6UIqrXpShKo
         +xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGHlZVL39eCUsJrhUm15x+JuQR4luXm9cgq/qr21IVY=;
        b=QjpqDswfg7pk92X/p0txMtTEPhI5RLZnCZkIZmA2zYF+4Dt/AVeWxee0pg/5vzO1Ko
         hYoEpJD0cT+jMW0ov1HlqwpMIxUXJMQb1dPZ3hgCHUiv6QTH3PHVb9kxb5Hin8bGyZKI
         p1zjuBHJo2XKkLfQy0hDm28vd7eQ7gK0sm7huX/u3W2QmWtpOGR9SG8fjHk3Y1KCW4dJ
         VmhToC6duxBiVw0eSCV6J8uBKGIN9q+P8FXNsyI1hc64iC7HElj6siDYfzz4KKx28yXq
         Eby9CF70NNFitNCcz/9tLZXwkp2uKQLnr91SI3zJMbjV76o449qZB+5eWvvsqH7Gcgbd
         xNdA==
X-Gm-Message-State: ANoB5pnlgugoupJkje6Gu/Ofj0TM0ywElp8k+XHU+c5ztEjbvyBrTKFa
        YKfMuFnQ54VY041lVGqt+rHbqw==
X-Google-Smtp-Source: AA0mqf4j0NwkOajZo6/FfndECMtqa/uh+Ezn1EL74qlkjKNZN5lyyAl+CoL93o3aU1vj951oIH0KKA==
X-Received: by 2002:a2e:300c:0:b0:277:524c:f83d with SMTP id w12-20020a2e300c000000b00277524cf83dmr5880907ljw.217.1668507384396;
        Tue, 15 Nov 2022 02:16:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c2-20020a056512074200b004979e1ff641sm2142914lfs.115.2022.11.15.02.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 02:16:24 -0800 (PST)
Message-ID: <4f97dc96-5f95-4d36-6d40-c247043162bc@linaro.org>
Date:   Tue, 15 Nov 2022 11:16:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8450-hdk: add sound support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221114152130.385871-1-krzysztof.kozlowski@linaro.org>
 <20221114152130.385871-4-krzysztof.kozlowski@linaro.org>
 <f52157c7-d198-9c26-089a-c5227a1c1f4f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f52157c7-d198-9c26-089a-c5227a1c1f4f@linaro.org>
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

On 14/11/2022 16:39, Konrad Dybcio wrote:
> 
> On 14/11/2022 16:21, Krzysztof Kozlowski wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> Add sound support to SM8450 HDK board.  Tested setup so far is only two
>> speakers (working) and head-phones (only one channel working).
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 161 ++++++++++++++++++++++++
>>   1 file changed, 161 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> index 4d75f9db08c2..c177283b6764 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
>> @@ -6,6 +6,8 @@
>>   /dts-v1/;
>>   
>>   #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>> +#include <dt-bindings/sound/qcom,q6asm.h>
>>   #include "sm8450.dtsi"
>>   
>>   / {
>> @@ -421,6 +423,147 @@ &uart7 {
>>   	status = "okay";
>>   };
>>   
>> +&soc {
> 
> soc should go before uart alphabetically.
> 
> 
> Other than that:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 

Ack

Best regards,
Krzysztof

