Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA80C7300F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbjFNN7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjFNN7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:59:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F8E57
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:59:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977e7d6945aso124325066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686751155; x=1689343155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/2gm70U0WT4+2tRD9sjQ6lyrCALPN33S/x9R10AK7o=;
        b=eLIEiiSikPLuSW9fNZ+yQPWqSx5bj5HC7qllChDvXO3zYszNeEt834u4UM3NPxoGdO
         4rK2ati3iQjAQNuMBdCHqiqbQsEWWYehL0ZfOFdkxux0EUpyBIiEcbI1EoPTSrx4JgN6
         sqOeRqp/J7jB9vrxUStWjFAkuCv9ropC0PybMcg4BOhVMMrTSxRbTJF0O+kLPkJqY3VE
         EBVraPqkAJr+FLAhB6iikRmthBIO8yViqUH9Ng5MBM1AYhmUa1u6KCKNXf+VNUJI0/HH
         JJdOPTqv3q848CSlrX01dU4arWpMVjOtMdW/XLzfvpE9upaY3l3Vp5B7rNo589XQveic
         W2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686751155; x=1689343155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/2gm70U0WT4+2tRD9sjQ6lyrCALPN33S/x9R10AK7o=;
        b=mGBnprwWwUI/rVHaIuJLlkb535g2SATJ4m23E74SB3oN6L5YzW5oRMcaq1Y+lccH6j
         8OIL17hgSmG4D+lMRHM+8VrhK6v6/B7YkekM2c3Li96BjOfL1acDE803TPsQSqcJabrp
         ToyAm9E1yo8m3Yz0ZEpB3m8IYkqe1n3nYzZ3Jk6EVObX3HmgG85ZU5blcjsEGVZG+bQr
         /OGZYN5vcGaLxzW9KGDygv+r/aPJF3HHUvyvkrGT1Ewn9EAcvs3nKT1R5Bp8ebvXwRi7
         15UxDDxlAoxCosZk+zQXUP7sZAYGDBupeOj/0Q6/WKOATTZBaqckbfRu1WtOzhmBM3+s
         S+Kg==
X-Gm-Message-State: AC+VfDylWW6h3Gcso/i0WO8RWDeXX2IqR3g12Cx9DMuK017hKjcc4msY
        /Cgs8lq4/l09HAAh+W23Hckdrw==
X-Google-Smtp-Source: ACHHUZ6lKBzq4QLv5O2ItE40XH3MOlBcMGIQyV4Sr/fo0M1UAWefd5Z+DBwaxKh7/u3IacHKvMNItg==
X-Received: by 2002:a17:907:948e:b0:982:8a28:ba24 with SMTP id dm14-20020a170907948e00b009828a28ba24mr692558ejc.63.1686751155484;
        Wed, 14 Jun 2023 06:59:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o21-20020a17090637d500b009571293d6acsm8100877ejc.59.2023.06.14.06.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 06:59:15 -0700 (PDT)
Message-ID: <36900050-2ffd-b5dd-f768-986624a83c70@linaro.org>
Date:   Wed, 14 Jun 2023 15:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        loic.poulain@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
 <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
 <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
 <87edmoitu3.fsf@kernel.org>
 <0555c089-9d0d-7d19-9646-f0f9b8630d12@quicinc.com>
 <5f9cc367-eaa5-4c19-4e5e-7052b0259ccf@linaro.org>
 <04f5e3cb-d2f5-747c-1fd0-4b61d845e2c5@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <04f5e3cb-d2f5-747c-1fd0-4b61d845e2c5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 13:43, Manikanta Mylavarapu wrote:
>>>>>>>>> +    properties:
>>>>>>>>> +      compatible:
>>>>>>>>> +        enum:
>>>>>>>>> +          - qcom,ipq5018-wcss-ahb-mpd
>>>>>>>>> +          - qcom,ipq9574-wcss-ahb-mpd
>>>>>>>>> +          - qcom,ipq5018-wcss-pcie-mpd
>>>>>>>>
>>>>>>>> Keep rather alphabetical order (so both 5018 together).
>>>>>>>>
>>>>>>>> I also do not understand these at all. Why adding bus type to
>>>>>>>> compatible? This rarely is allowed (unless it is PCIe controller within
>>>>>>>> soc).
>>>>>>>>
>>>>>>> IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
>>>>>>> external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE
>>>>>>> radio's properties, i have added bus type to compatible.
>>>>>>
>>>>>> It's the same device - WCSS - right? We do not create multiple nodes and
>>>>>> compatibles for the same devices. Bus suffixes are almost never parts of
>>>>>> compatibles.
>>>>>
>>>>>
>>>>> No it's not the same device. WCSS on inside IPQ5018 and WCSS attached
>>>>> via pcie to IPQ5018. Here QDSP6 managing both WCSS's.
>>>>>
>>>>> So for better clarity i will use attached SOC ID in compatible.
>>>>> Below are the new compatible's.
>>>>>
>>>>> - qcom,ipq5018-wcss-mpd //IPQ5018 internal radio
>>>>> - qcom,ipq9574-wcss-mpd	//IPQ9574 internal radio
>>>>> - qcom,qcn6122-wcss-mpd //IPQ5018 attached radio
>>>>
>>>> What mandates that there's just one QCN6122 device attached to PCI?
>>>> Assuming fixed PCI configurations like that makes me worried.
>>>>
>>>
>>> IPQ5018 always has one internal radio, attached pcie radio's depends on
>>> no of pcie ports. IPQ5018 has 2 pcie ports, so it supports max two
>>> qcn6122 devices. One compatible (qcom,qcn6122-wcss-mpd) itself support's
>>> number of pcie devices controlled by QDSP6.
>>
>> So this is hot-pluggable (or at least board-pluggable), then should not
>> be a part of static DTS.
>>
>> Some concepts of virtual-processes is anyway far away from hardware
>> description, thus does not fit into DTS. Adding now to the equation PCIe
>> with variable number of such processes, brings us even further.
>>
>> This is not a DT property. Remember - DT describes hardware.
>>
>> Best regards,
>> Krzysztof
>>
> 
> In the multipd architecture based Socs, There is one Q6 DSP which runs 
> the OS/kernel and there are one or more instances of WCSS radios
> (It can be either internal or pcie attached).
> These WCSS cores are controlled by the Q6 (Q6 DSP brings wcss radios out 
> of reset/ shuts it down etc). Q6 forms the 'root Protection domain' and 
> the wcss radios are termed as the 'user protection domain'.
> The compatible's that is being added here are to manage the 'root 
> domain' and 'user domain'.
> Not sure if using the words 'pcie'/'ahb' made it confusing.
> So, 'qcom,ipq5018-q6-mpd' and 'qcom,ipq5018-wcss-mpd'.
> 
> There will be multiple instances of 'qcom,ipq5018-wcss-mpd' in DT based 
> on number of wcss radios connected on that board and only one instance 
> of 'qcom,ipq5018-q6-mpd'.
> 

I don't understand why the user protection domains need a specific
compatible. Why do they need compatible at all?

Not mentioning that amount of your domains on Q6 is actually fixed per
SoC and probably should not be in DT at all.

Qualcomm puts so many so weird stuff into DT which is not a hardware
description. I understand that everything is there a firmware, but then
make it discoverable for example...

Best regards,
Krzysztof

