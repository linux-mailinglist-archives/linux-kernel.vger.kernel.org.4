Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADD46DE36A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjDKSEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjDKSEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:04:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A8B7AB1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:03:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m4so11317537lfj.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681236188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocCmwSJrhpHhqyMZr30is+INmJpIsNsGHvDvoi6QJ54=;
        b=OC4wt2PSKCifkvgOhmmEnaoMUGUgXR62hPv8ZjCI7+B78Sbhbbi/ojSdKNJyiVwKdw
         CnPdH1mo8NsIfQXx6NX0dkbguw+BiXtwtuDrR3UvqL+lJdQIXbMPNXNM1ISeWf/ah4b9
         b+a4WeFnZVNcslgBXkAH0z/XvKMA2cngssYJFA5ox8OHnV+AOQ8tbvpDvdmlm9KtmZMj
         ccwSd+c2vRfaIbRKOvzMgAlVG6s77n4WmYEzfvyESoGOCEpHApfcwsHqN3tBOUktfIZL
         FGhQTNL6PgpOsgh5Xwf5+uHG9GDLgaTHCHCMv45X+7Z12ADI3VWmPXpqTwuIt717+1OV
         KcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocCmwSJrhpHhqyMZr30is+INmJpIsNsGHvDvoi6QJ54=;
        b=azgTsoRDSGk91SPRBaxFWT31ahRXslQB7SSWQhmmXN2K3dXVACRszZFUioQtmeryQ3
         mLBuuEtCTYPzs2IhAxmzXBFKX97nN19fQjCUZwizXMpTxASB+extu27DUgn1SYa0w1e+
         KqrseJkudZ9itF0X7vAX9teqGSwtG9lbimB5AVnNnHEuXEhIRm+ZqzWamxYVN58FnxNU
         hqzAGREi9GbISoHQzbwMTDS+kyYFlzGhP60AuMYZylKkXOVccF3AlF2xY7SnwXleAM86
         i6/RQLAFnkp7wJmvbjGWzsK252IOPhCAtZuV/dfXvBUf7oBwiOHlxyJc70SqZn2TGo0s
         I2pQ==
X-Gm-Message-State: AAQBX9ee3zyS5BVDDdzbqU5Mzd7OOQahwKMiP1HsbTqOeNUYa9nfZ7Vk
        DMAJMEwrrD5gX/MPrbLv04M7Mw==
X-Google-Smtp-Source: AKy350b+ZZPTZYJMLqpF9v0rSN6Hsvc2pRdKRoaf8Atw/Lp9m6Ox+TUudD2DkjIuodpkdArg63IoBQ==
X-Received: by 2002:ac2:456f:0:b0:4eb:3149:cbd0 with SMTP id k15-20020ac2456f000000b004eb3149cbd0mr2830807lfm.9.1681236187755;
        Tue, 11 Apr 2023 11:03:07 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id p12-20020a05651238cc00b004ec4f3810ddsm2628102lft.219.2023.04.11.11.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:03:07 -0700 (PDT)
Message-ID: <2ce26f3f-f746-ce15-c490-288628c7645c@linaro.org>
Date:   Tue, 11 Apr 2023 20:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] dt-bindings: power: qcom,rpmpd: Add SA8155P
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
References: <20230411-topic-hanaau-v2-0-fd3d70844b31@linaro.org>
 <20230411-topic-hanaau-v2-1-fd3d70844b31@linaro.org>
 <f12d50a2-a9b0-5659-4224-2b7039ba058e@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <f12d50a2-a9b0-5659-4224-2b7039ba058e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 19:37, Krzysztof Kozlowski wrote:
> On 11/04/2023 15:47, Konrad Dybcio wrote:
>> Add a compatible for SA8155P platforms and relevant defines to the
>> include file.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>>  include/dt-bindings/power/qcom-rpmpd.h                  | 9 +++++++++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> index afad3135ed67..f9c211a9a938 100644
>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>> @@ -29,6 +29,7 @@ properties:
>>        - qcom,qcm2290-rpmpd
>>        - qcom,qcs404-rpmpd
>>        - qcom,qdu1000-rpmhpd
>> +      - qcom,sa8155p-rpmhpd
>>        - qcom,sa8540p-rpmhpd
>>        - qcom,sa8775p-rpmhpd
>>        - qcom,sdm660-rpmpd
>> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
>> index 1bf8e87ecd7e..867b18e041ea 100644
>> --- a/include/dt-bindings/power/qcom-rpmpd.h
>> +++ b/include/dt-bindings/power/qcom-rpmpd.h
>> @@ -90,6 +90,15 @@
>>  #define SM8150_MMCX	9
>>  #define SM8150_MMCX_AO	10
>>  
>> +/* SA8155P is a special case, kept for backwards compatibility */
> 
> This is a new binding, thus I don't understand what is here backwards
> compatible?
Check the DT structure, 8155-adp (so, de facto 8155) included
8150 before, but that was not exactly the correct approach..
It bit us after we accidentally discovered 8155 advertises MMCX,
LCX and LMX PDs in cmd-db but triggers a bite on access attempts..

By mimicking the indices to match the ones of 8150, we only have
to fix up the domains that were axed from 8155 (in comparison to
8150 which has the full fat setup).

Konrad
> 
>> +#define SA8155P_CX	SM8150_CX
>> +#define SA8155P_CX_AO	SM8150_CX_AO
>> +#define SA8155P_EBI	SM8150_EBI
>> +#define SA8155P_GFX	SM8150_GFX
>> +#define SA8155P_MSS	SM8150_MSS
>> +#define SA8155P_MX	SM8150_MX
>> +#define SA8155P_MX_AO	SM8150_MX_AO
>> +
> 
> Best regards,
> Krzysztof
> 
