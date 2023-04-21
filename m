Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2219D6EACB2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjDUOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjDUOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:20:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A813F87
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:20:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4eca0563b31so1753546e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682086800; x=1684678800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yK3yIe9a1wbBKj0KZBkdEoQSsxDKw5meLrRh6nS/NAs=;
        b=HNYSW9WtRin1UpYDmy5oqGTtPdRzatgSNcyZxKuAWL2njrWAmsO23bnSw/FaV5FsTk
         3NaGs3ayknlAPebHS811STIn/tK01k7aVJddOrK/tE7mFCHeRhw3DWgQizrqy6YbHKFn
         awnt9C3M3RAYwuQs6+fVDrW8uG1bcPKDEpRuCsqSt0Ei+RdxYa8T2YvxEH+bZxeWe8J7
         SsZ7Dck9wf5ax5MSLqxBXeuSKSSPTxhp4UchJ/B4CLrX8WJiLWSG8mrj2aa4rU1t5TNS
         ubMafmsHzR1v7NzXeHnXhbFNyBhH9vrTPdaGMnzaVXPPZ1NJFjuMnPKYB0UMca/j1cis
         TnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086800; x=1684678800;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yK3yIe9a1wbBKj0KZBkdEoQSsxDKw5meLrRh6nS/NAs=;
        b=NAJrwAISWTUVXOfOF8v22LtlsMyIicYwQ0YAVgWLdUtJ+s3We626ti2UhSqnPdQYLv
         uHK2NRmvyxr/G+vOwzW9EZQdMtIbc3AAq/FkNjKMb4KE9qwYjNBeWjow09WF3tM5gAQy
         DBYMJPdT08253nQ34gl623EXR8AMvGI477hnL5Bl0oEm0iPS/zdQWXBs9AMR8RSnZhdh
         UPHKz6d3bCC2Ooicrhj8FsL1AgDJyP42fy4PtPDbF/7NHXyoY1q7JU4JMfJU8FYDIev5
         cI45jo1LNTwTPg8HtWfWuDQPcFrvtqylMp93iHZSYjmHWCeFauN+K6vu+kLQPhYBph/d
         xniQ==
X-Gm-Message-State: AAQBX9eC7p7SRCIvy7jiXVox2M6/XUppeZKZCOD20MGBoOILrPWCnMXV
        pFyI1V6LXxECaz3CkgfcT0CllA==
X-Google-Smtp-Source: AKy350Z3MlSM4frPMB2jDj6hRgEKBnQ0rSplMEGlIjVYqo2u0QTPdtI8l9nJrdrQA3sqCVG865KqkQ==
X-Received: by 2002:ac2:47eb:0:b0:4eb:43f5:73a1 with SMTP id b11-20020ac247eb000000b004eb43f573a1mr1423815lfp.44.1682086799707;
        Fri, 21 Apr 2023 07:19:59 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id m15-20020a056512014f00b004e7fa99f2b5sm574358lfo.186.2023.04.21.07.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 07:19:59 -0700 (PDT)
Message-ID: <6750910d-22a0-7bed-f163-db57424133c6@linaro.org>
Date:   Fri, 21 Apr 2023 17:19:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 2/8] dt-bindings: phy: qcom,qmp-usb: Add IPQ9574 USB3
 PHY
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1680693149.git.quic_varada@quicinc.com>
 <1efa9a64499767d939efadd0aef897ac4a6e54eb.1680693149.git.quic_varada@quicinc.com>
 <b9763bee-c0c8-86be-14de-2ed077b1f1d5@linaro.org>
 <20230421101345.GB5813@varda-linux.qualcomm.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230421101345.GB5813@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 13:13, Varadarajan Narayanan wrote:
> On Thu, Apr 06, 2023 at 09:42:31AM +0200, Krzysztof Kozlowski wrote:
>> On 05/04/2023 13:41, Varadarajan Narayanan wrote:
>>> Add dt-bindings for USB3 PHY found on Qualcomm IPQ9574
>>>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>>   Changes in v8:
>>> 	- Update clock names for ipq9574
>>>
>>>   Changes in v6:
>>> 	- Made power-domains optional
>>>
>>> Note: In the earlier patch sets, had used the (legacy)
>>> specification available in qcom,msm8996-qmp-usb3-phy.yaml. Moved
>>> to newer specification in qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> ---
>>>   .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml        | 43 +++++++++++++++++++---
>>>   1 file changed, 37 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> index 16fce10..e902a0d 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
>>> @@ -16,6 +16,7 @@ description:
>>>   properties:
>>>     compatible:
>>>       enum:
>>> +      - qcom,ipq9574-qmp-usb3-phy
>>>         - qcom,sc8280xp-qmp-usb3-uni-phy
>>>
>>>     reg:
>>> @@ -25,11 +26,7 @@ properties:
>>>       maxItems: 4
>>>
>>>     clock-names:
>>> -    items:
>>> -      - const: aux
>>> -      - const: ref
>>> -      - const: com_aux
>>> -      - const: pipe
>>> +    maxItems: 4
>>>
>>>     power-domains:
>>>       maxItems: 1
>>> @@ -60,7 +57,6 @@ required:
>>>     - reg
>>>     - clocks
>>>     - clock-names
>>> -  - power-domains
>>
>> Power domains are required. Commit msg does not explain why this should
>> be now optional.
> 
> Since IPQ9574 doesn't have power switches couldn't provide power-domains details.
> So, had to make it optional to pass 'make dtbs_check'.

This should be a part of the commit message, so that the next developer 
understands your intentions without going to mail archives.

> 
> Thanks
> Varada
> 
>> Best regards,
>> Krzysztof
>>

-- 
With best wishes
Dmitry

