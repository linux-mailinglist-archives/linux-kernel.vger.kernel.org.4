Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D316F520D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjECHmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjECHme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:42:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7B1981
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:42:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc34b98edso5825354a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683099750; x=1685691750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndE9+pB7brffk/7YIwrb3ZQg3LFDw+vNaQtTCPye8HE=;
        b=MEuqWv5vtqiSKvg52mayWX30IwRPxUz+cfDtHkhPig2Vn4wK2G77Xqtxf0PtTqhlxA
         16nQiG9aPckN2qpF/woUA6glbvY56otJpWOAo/zdSQFhueLPBMgTNqxG6ZkljU4pfEIC
         h6havLlECzkgz7gUpPLZrpJSCVhTKME9HfrpRw0Ow1F29TJCux4r7Yx9BbDzXsm1RokG
         MUUg8LuC3YWdFX9IoLMEJOWRbZiEWetJTQkUL6OzCz5FZdr4IZVSuA0PihD5lqKIDA+k
         bYSpbiSzzvkFY2JwYdgQ/0EhEMESuAGMe1MG8FcTmx+K61vMXUUcYlrAv15cbDDo8pTf
         QnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683099750; x=1685691750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndE9+pB7brffk/7YIwrb3ZQg3LFDw+vNaQtTCPye8HE=;
        b=M0nyg3Nxu0uBSCZVQRcpgwJE757R0k/nyCcwDLFhREaCL/vRp5etswu0Scho5WmH1D
         Db5Q3TH+AfuWpy31hh+82iSfaMA1xDV9vxjk+DdJ0e0gIvrWOxCBM/oWkroBIPGnGH5t
         0fLXXOe9SYqwGqbuf6glXHl45ytACIgcA6gUkZfXo/uXVkJ9obnTSTWp/QStc+59wShs
         M2jOxoUO+v2bJgmVqtIOU5alRd01Vm50OTMJXDjbu+y4kfQe0BHkg8jXKpcGi22VmMa5
         xzevx4YX+qJ0XPqxcreZ7tHCG8KulI8rEhzKZzFYbl5wifEU3mmktsSKW8Y3ebXCZSd1
         89JQ==
X-Gm-Message-State: AC+VfDwhWsGV10aTFs/Q95E5rpDM8ajy3DixcsrhL20G7W6/c8yEzsmd
        qdF0kXvIu5jqaywKotlzhZzbng==
X-Google-Smtp-Source: ACHHUZ7SvjrzpPDWGQ6Bi44YUCZS7ALk2lsdvmVXcMSgaM0otDrRMa4BK7HRaTwIoW8KQcyO77dj2Q==
X-Received: by 2002:a05:6402:1608:b0:50b:de1f:8792 with SMTP id f8-20020a056402160800b0050bde1f8792mr1998633edv.37.1683099750257;
        Wed, 03 May 2023 00:42:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5? ([2a02:810d:15c0:828:a40b:9d8:1fa0:ecc5])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7d5d0000000b0050bd427a539sm397161eds.60.2023.05.03.00.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:42:29 -0700 (PDT)
Message-ID: <915eea5b-6cef-d346-7cbd-b679726113ad@linaro.org>
Date:   Wed, 3 May 2023 09:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/4] dt-bindings: thermal: tsens: Add ipq9574 compatible
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
References: <cover.1682682753.git.quic_varada@quicinc.com>
 <3c6f7510d175ba5a3c81730b010f6c421b2fbf2d.1682682753.git.quic_varada@quicinc.com>
 <16443d11-7948-d224-cfef-b6c1b5c3d60d@linaro.org>
 <20230503071055.GB1087@varda-linux.qualcomm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230503071055.GB1087@varda-linux.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 09:10, Varadarajan Narayanan wrote:
> On Mon, May 01, 2023 at 09:08:49AM +0200, Krzysztof Kozlowski wrote:
>> On 28/04/2023 16:52, Varadarajan Narayanan wrote:
>>> From: Praveenkumar I <quic_ipkumar@quicinc.com>
>>>
>>> Qualcomm IPQ9574 has tsens v2.3.1 block, which is similar to IPQ8074 tsens.
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> ---
>>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> index d1ec963..8e2208c 100644
>>> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
>>> @@ -66,6 +66,7 @@ properties:
>>>        - description: v2 of TSENS with combined interrupt
>>>          enum:
>>>            - qcom,ipq8074-tsens
>>> +          - qcom,ipq9574-tsens
>>
>> Your drive change indicates they are compatible, so make them
>> compatible. 9574 followed by 8074.
> 
> Not able to understand. You want IPQ9574 to use "qcom,ipq8074-tsens"
> instead of adding a "qcom,ipq9574-tsens" and no need to add an extra
> entry to the driver like

Assuming the devices are really compatible, which your driver change
suggests, I want to use two compatibles. 9574 followed by 8074 fallback,
just like we do for all Qualcomm IP blocks. Then as you said - no need
for driver change.

Best regards,
Krzysztof

