Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E565E95A6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiIYTIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiIYTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:08:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13129C8B;
        Sun, 25 Sep 2022 12:08:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fs14so4452885pjb.5;
        Sun, 25 Sep 2022 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mSTdWroZUCeHXs4af7r75si5L3digqfiyERQmQxOYhA=;
        b=VA6qzaqgmpa1GI/WIm2ExEcZ8Q5Ja5PMiDupGrYk5XyvPRnSsT9HzyAkL1A2evY4tZ
         l3IgHSrjhMQ70rfXmZciz3eO3ip2y8QMQolPPoz5tnhAUQkUEFBA0CxsqbWpP/SrYG8d
         +9I6I6kAqe7mDd32NPLVmt1VIA0xTMcZhZDChtcA3YEo9jVThdfUUFPm6SsVQD/TGvw+
         dULcNf4eTg8xle9ZQGSjERaS0MVQoHgbbAluqdCjTVF6lCwLlAZkHWA3rNY8WdYP1U5i
         34cxq92Nr3BWh/3BYuUSSMIJ/J7uCWHOTDHxeIs6kNEiigiijfasQhknezNju7KXHNVJ
         a2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mSTdWroZUCeHXs4af7r75si5L3digqfiyERQmQxOYhA=;
        b=s3zdGEbC3WA76NoZKuvtUVjB63JbYuHnUn6ERSq/BN84SIuA8dWImBs2NqUZUX8/S5
         oQbGTR4BBwYDoELGiN9bFg9xUfsihBnMruIKYO8qVehkHI9VyEe02rYeZ6gFEvNugjEi
         sEIHQ4CwDo+j+xoaV8QavT8EJCQWisN5idiMju92t1jWrW0JLJkBM/acUppWp0KcTrBR
         /PaONzyA//d95BTH/vn4aiSGHdYsgxI1pix0Cb3JRJ0KvltNxBf39f/zEXXpAtatvr2o
         SO9Wx/obJz93DUX7P0ATDRomXGM4DUbYmOt8D5trY8SAcdgnaLb7lEgrlDC1U34uID/L
         SQDw==
X-Gm-Message-State: ACrzQf2fWFSzKKCXt8RSEbsRmt4UItK65GTbPrjv9gSRmkjEeBJFBe/r
        EQkxmqxpWHz5rff3dALAFmA=
X-Google-Smtp-Source: AMsMyM7XaAI27t7wZ1RDXD84pRuHLXU0RaxuU1h+7NaApOG/E76uvgPM0csXQ0xb05qEHCVDVqwspg==
X-Received: by 2002:a17:90a:fd08:b0:203:7b5d:89bf with SMTP id cv8-20020a17090afd0800b002037b5d89bfmr32110049pjb.98.1664132887337;
        Sun, 25 Sep 2022 12:08:07 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0017894a84639sm9632178pls.288.2022.09.25.12.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 12:08:06 -0700 (PDT)
Message-ID: <430b8a98-d76e-521b-81a2-a302679ecce5@gmail.com>
Date:   Mon, 26 Sep 2022 04:08:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] bindings: Update maintainer's email address
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
 <78859fd2-330f-1687-7fa3-f0831402778c@gmail.com>
In-Reply-To: <78859fd2-330f-1687-7fa3-f0831402778c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 9. 26. 04:03, Chanwoo Choi wrote:
> On 22. 9. 24. 09:36, Guru Das Srinagesh wrote:
>> Update Guru Das Srinagesh's email address.
>>
>> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
>>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
>> index 6a9c96f..480e4fb 100644
>> --- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
>> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  title: Qualcomm Technologies, Inc. PM8941 USB ID Extcon device
>>  
>>  maintainers:
>> -  - Guru Das Srinagesh <gurus@codeaurora.org>
>> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>>  
>>  description: |
>>    Some Qualcomm PMICs have a "misc" module that can be used to detect when
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> index ec3138c..1f3ac59 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
>> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  title: Qualcomm Technologies, Inc. PM8008 PMIC bindings
>>  
>>  maintainers:
>> -  - Guru Das Srinagesh <gurus@codeaurora.org>
>> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
>>  
>>  description: |
>>    Qualcomm Technologies, Inc. PM8008 is a dedicated camera PMIC that integrates
> 
> 
> As Krzysztof comment, I changed the patch title and then applied it. Thanks.
> - dt-bindings: Update Guru Das Srinagesh's email address
> 

I'm sorry for that. It should be also confirmed from MFD maintainer.
I withdraw the applying.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com> 

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
