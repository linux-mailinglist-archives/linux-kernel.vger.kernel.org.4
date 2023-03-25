Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DCD6C8D81
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCYLfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjCYLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:35:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40190BDEF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:35:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id er18so6295785edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679744108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8sbl3G2CZLODjlbB1uxWf2aT5vhXcTjxqACgV87rNU=;
        b=cZXk7l2qJgIojf+tCHcNf4qQzd+VavmXIWepTpdQUQkUEZNWmjigthhKeQm7g4Eee6
         QpFl6Jgp/K3DirZGIOipApaS3piHwjON6hkHMWKRxVU+roiH0hikMLSYw4AZoW7yjKmb
         eaED5OqaeWR7OGu0+olpp7o9/E1xmiQtkIXBiYxXy5NqPNeQDsNMWHTSuctXntPATxTM
         D8z+Is4U1BhKvPE6vVxZmoboJQAlD1/7R/TaLeK1kId96NehUzOcwLwwkG4kXhBljGYQ
         bz+vuBOmvaK0IptpeS1YEHv0qaxDzlIyntxrRM1lxiCnMoUJE23C41iIxPcVwpqCcInc
         xIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679744108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8sbl3G2CZLODjlbB1uxWf2aT5vhXcTjxqACgV87rNU=;
        b=mYBun1KMNP1qi5kbhK/p9TJnefHLuffF5DrHUPl0PW9RfiOpkHMwnn2IElzmOPHJTz
         pszlC6PHIDeFzvVbIzAutxF3G+rjM6++jgGKXnk7nT5WUZ0P7Eq0KyfgnmIixUHlV2Xa
         0tFrGPWmsP7SbeKsFmboqmBz0mlu/D9v2OlkAYYsc2V3UZ3H0NxvI0VvqzlNoTah+mWt
         B+7EZJxAO0msgzq9KG6cDXbGMvZV8MvEj7YKiCw9m45lUEVpfA20FK6MMI5g6LlEIqtC
         LP4kNNd/vi+gNhqVWE+c+jvEM0VTpVzMDQwW0qVigwifcaFxDWOFb4WtFSLLZdwstTwk
         D/xw==
X-Gm-Message-State: AAQBX9fvxtB/V6RdgC2/y5t5w874ddXVeffM8d6ePHVfD9jFwHe7oeep
        uUQ98WqGdcYihtYuSwmeMfr8Iw==
X-Google-Smtp-Source: AKy350ZZB2IMfnQvR9XYmhMsZzU0Qst2DCYcRIhiZknm1/aJdstBvEatRrXugUfBv8jhwoMv39amCA==
X-Received: by 2002:aa7:da57:0:b0:4fb:80cf:89e6 with SMTP id w23-20020aa7da57000000b004fb80cf89e6mr6473413eds.8.1679744107720;
        Sat, 25 Mar 2023 04:35:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d230:b2c7:d55:c9c8? ([2a02:810d:15c0:828:d230:b2c7:d55:c9c8])
        by smtp.gmail.com with ESMTPSA id 17-20020a508751000000b004bf7905559asm12075408edv.44.2023.03.25.04.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 04:35:07 -0700 (PDT)
Message-ID: <6da91d8c-6694-9041-2f2f-72a8e95c7df2@linaro.org>
Date:   Sat, 25 Mar 2023 12:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/11] dt-bindings: arm: Add support for DSB element
 size
Content-Language: en-US
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-2-git-send-email-quic_taozha@quicinc.com>
 <e6ad7301-09ea-93e0-929e-86e0eb0a02e7@arm.com>
 <d4c133c1-38c7-93e3-deaf-b55161057409@quicinc.com>
 <fb5d55ba-8f7b-292e-e676-9423c36f4085@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fb5d55ba-8f7b-292e-e676-9423c36f4085@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 10:15, Tao Zhang wrote:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    minimum: 32
>>>> +    maximum: 64
>>>
>>> Shouldn't this be something like oneOf ? It is not a range, but one of
>>> those two specific values ?
>>
>> Yes, "qcom,dsb-element-size" should be an optional option required in 
>> TPDM
>>
>> devicetree. Other properties like "qcom,cmb-element-size", 
>> "qcom,tc-element-size"
>>
>> and etc. will be added in a later patch series.
>>
>> I will update this doc according to your advice in the next version of 
>> the patch.
>>
>> Tao
>>
> Correct my misunderstanding in the mail above.
> 
> You are right, DSB element size should be 32-bit or 64-bit. I will 
> update this in the next

Then 'enum', not 'oneOf'.

Best regards,
Krzysztof

