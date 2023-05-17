Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0ED7069D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjEQN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjEQN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:29:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D801BC
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:29:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f24d4900bbso962038e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684330138; x=1686922138;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7H9sn2dWZJRuoUfbIC4+AN4juqKG9jvbgSCH57Xe0A=;
        b=QvCeS159FrQrEX1R8hhzpMrNxvNXOud0ZgvDu38e5OPdYk2ljrUDA5l0/rvQw/zoaa
         FVvjA2gL+BE8blUqkoQRnmeJ/UuPvsA+VMjHdVMKUbjLEuwwZtLVVXf7wSsE7kokw84A
         Sp/Gpaj7hrxaj2DHXx8MGN3lOLYIUljHiwAnXfYNKlJu34LzEtOvUdw5GEf0tfLsSYS+
         l24dgLSlgREbA7GJhmSXIHqyYPt20NHboORUsLOldaXTWTD9/2tdOhTGkXJ397PbuzE/
         H1kMgxgfOEjYUDBKRX0CZZymXI1rjbRbzKX5rDvoA9q0TDY4IYkCKRaijqSq2eNmsq5f
         P32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684330138; x=1686922138;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7H9sn2dWZJRuoUfbIC4+AN4juqKG9jvbgSCH57Xe0A=;
        b=Bb6YZzpgnKIwW5jw5zxNHItah1W6T6KQ6ct05UkoMyRfqtOt4wCxPoBC7jBO6Ux4cR
         b4/seEvOHsAFuRVQ96poh3ZKyJjIWG88G4LyRWb2SdZWKj3OZP3yivJ6CA9cvPMyAGc/
         PpssWZVUhL6aRI/SY6Z/zYuejMLXHD0sn1GjDH9XpSLtkUnRl2ecIERWKlbdKcNwPsgk
         fBQasFw17I/XxJgojm+knrlxujJsq5T0Fm64W4Vl/cSHAH/e5QNiVvJ8f5Oeunqzvk9j
         UaESTYeelESOwGKr6ahXNxedM9anFyfnPsQ8xy1kG4FZ816uQ/MsgZhlkZ0yTJuVKQRw
         XjWQ==
X-Gm-Message-State: AC+VfDxRnPPfYBzAmWLzX1AauPDIkguuwalbPcjwzJyWyY4psN4/KqVC
        1qrpgj8ue5rK5WXgavjt1bxQbA==
X-Google-Smtp-Source: ACHHUZ6pkE/lBljECeBc1B+gG2pYeVaj/bRXhcUm7XnHAQvhA1OVwaL5PHMHK0oHAqsccgfRrjWxnQ==
X-Received: by 2002:ac2:4904:0:b0:4e8:c5d:42a5 with SMTP id n4-20020ac24904000000b004e80c5d42a5mr241158lfi.24.1684330138595;
        Wed, 17 May 2023 06:28:58 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c93:874f:be7b:fb6c:26f9:307c? ([2a00:f41:c93:874f:be7b:fb6c:26f9:307c])
        by smtp.gmail.com with ESMTPSA id h4-20020a05651211c400b004edc2a023ffsm3372074lfr.36.2023.05.17.06.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 06:28:58 -0700 (PDT)
Message-ID: <f82e0517-0c96-06e5-81ac-c97ea2b8decb@linaro.org>
Date:   Wed, 17 May 2023 15:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8550: Add missing RPMhPD OPP
 levels
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517-topic-kailua-rpmhpd-v1-0-cd3013d051a6@linaro.org>
 <20230517-topic-kailua-rpmhpd-v1-3-cd3013d051a6@linaro.org>
 <CAA8EJppaZSXeRP661g65WtadZAuJo1T8=Yk8AfX6n4Jg04BvZA@mail.gmail.com>
 <d6bc4b56-3a0c-44f4-2e21-ff07c69100a6@linaro.org>
In-Reply-To: <d6bc4b56-3a0c-44f4-2e21-ff07c69100a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.05.2023 15:25, Konrad Dybcio wrote:
> 
> 
> On 17.05.2023 15:25, Dmitry Baryshkov wrote:
>> On Wed, 17 May 2023 at 16:20, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>> We need more granularity for things like the GPU. Add the missing levels.
>>>
>>> This unfortunately requires some re-indexing, resulting in an ugly diff.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 36 ++++++++++++++++++++++++++++--------
>>>  1 file changed, 28 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>> index 6e9bad8f6f33..0c987dd4e4e5 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>> @@ -3616,35 +3616,55 @@ rpmhpd_opp_min_svs: opp2 {
>>>                                                 opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
>>>                                         };
>>>
>>> -                                       rpmhpd_opp_low_svs: opp3 {
>>> +                                       rpmhpd_opp_lov_svs_d2: opp3 {
>>> +                                               opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
>>> +                                       };
>>>
>>
>> Maybe we should stop using the indices for OPP entries and switch to
>> encoding levels instead?
> I think we should just retire this and register a hardcoded OPP table
> in the .c driver.
But then we don't have any required-opps to reference... yeah the nodes
should probably be renamed to opp-<levelvalue>

Konrad
> 
> Konrad
>>
