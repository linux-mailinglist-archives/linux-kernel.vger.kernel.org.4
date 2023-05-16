Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F7705254
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjEPPgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjEPPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:36:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711A65FF1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:36:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f38bea8be8so4136759e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684251369; x=1686843369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jeGWYG6Dtdk/56UIAauzf1NFw5Z+yaN/21LdqzRPh3A=;
        b=S3y9fmwlqyUleXOpUfsedUsZw7ZUc0lW9RO/XwFoLzyH1yeVexSLZGkGYeK9q1WbXO
         ddA15FcXQh7lvVaUCcYxMsSzPy/Br9ro//n2tHNMHP/2Ip7UsWXWmunol4zxZ7nHO7vQ
         NWMj7wQ88/X98LBTGNEiYdkU+YPwCSf/dZGq7GDfGWQl2BjBig/Xz+OuwJO1MzDjDrwF
         P6eCwx7JO70sN+FPPZAbKXSH47lKZrZd1Mu+KfcH6/crtKPjqjDnRJqJOkfzK/TZAst+
         cOUS6cFRWbUPEedXnqxXTH+ueI0vWKjUreL1ZRus3IejwYg25Nsyb9ZW5LLQQjbb8QxB
         tSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251369; x=1686843369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeGWYG6Dtdk/56UIAauzf1NFw5Z+yaN/21LdqzRPh3A=;
        b=aSQKDX4aosOCwnap+MY+iCk1dz4IeS2BC3HXallhpBkKbXUG8oMFvaLW9FEKkqICOQ
         7NxMAaE4SWABrtD+xraq1YBpbvMPq7QdVVA7NKNhLUvYbDs2piDvNEep0gwUw9p0+94/
         0PD5xGTQwafiF/BIYIQobYFDB+S709EV4t5dS+xjogFuNeU4vobqdGNu5r7v1u/xSj52
         xb0qc3vgTU/4VlPY6TLILzvOcvZgCfcwtfhTAAf7uBcruD23gjfTBuTY0eh8lOTu82Vl
         hcDCn8iTaEvSC0Z5uc0vHKZzEKTKoh+EjzCkqFGYflXR7P94KV5BHQl/tgQJldMacwyK
         TjTg==
X-Gm-Message-State: AC+VfDxK2tvkcH+R3m77p/D0Y7rEVBnRjqkuh6MfCvWTcm+WoF/fYRZ8
        0QaSP1aoti17S5fTOTB73ysGPA==
X-Google-Smtp-Source: ACHHUZ4iShN/KfWEFEAIQqX0yyX3N6jm6f7Dkj6ASCHv1lLRsy9K3VckSGQQchvMN17y6d0dB43J7Q==
X-Received: by 2002:a05:6512:3c98:b0:4eb:46c2:e771 with SMTP id h24-20020a0565123c9800b004eb46c2e771mr7698357lfv.14.1684251368696;
        Tue, 16 May 2023 08:36:08 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id k14-20020ac2456e000000b004f2ce4b0f2esm1440631lfm.168.2023.05.16.08.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:36:08 -0700 (PDT)
Message-ID: <894282af-fdfa-d476-fe9a-677db6483501@linaro.org>
Date:   Tue, 16 May 2023 17:36:06 +0200
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
 <2bc16f9a-e150-b3d0-6d72-a2ff0a4d05ae@linaro.org>
 <f790b655-4192-bcad-07af-814a359a351a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <f790b655-4192-bcad-07af-814a359a351a@linaro.org>
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



On 16.05.2023 17:35, Krzysztof Kozlowski wrote:
> On 16/05/2023 17:26, Konrad Dybcio wrote:
>>>>> +&mdss_mdp {
>>>>> +	status = "okay";
>>>>> +};
>>>> This should also be enabled by default, MDSS is useless when MDP is
>>>> disabled.
>>>
>>> But don't we want to disable both when display is not used (not connected)?
>> The MDSS bus device only has a 0x1000 slice of the 0x90000-long "full MDSS",
>> the rest is probed with MDP/DPU. It also calls of_something_populate that
>> make DSI, DSIPHY and DP/HDMI probe. But all of them ultimately need a graph
>> handle to MDP.
>>
>> If we have a display (of any kind), MDP has to be enabled (or the display
>> engine will not have a way to be programmed).
>>
>> If we don't, enabling MDSS makes no sense as all of the hardware will be
>> shut down right after probing.
>>
>> So I'd say either both or none.
> 
> Yes, so the current state - both disabled - is matching it.
Right, but what i was trying to say is that if we leave MDP without
any status properties, it will follow MDSS.

Konrad
> 
> Best regards,
> Krzysztof
> 
