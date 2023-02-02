Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB1F6887F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 21:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjBBUB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 15:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBBUBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 15:01:53 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C17921B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 12:01:51 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml19so9416327ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 12:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxM9HSg7LJAXbn7ENAypRMHLklYazMOh09jYix5Uw6E=;
        b=TrgOINh6q9JsQaHyOaEFAUKvJS025pXWFlHU3arvlNbLBnK3qcsGuaaMCbjbJN04ZO
         3IlOf2lr6noFQliEHbf+rC9NgB3jAok4fEfbVtF+MywGorktax/oUFYU1xpF5Zau1qmB
         8hq5h44U+elUuZzAW8XFbnpkXiY8ssOyfB4dr13WJ/qtnykslbWA66MGAzupbFzoz7K0
         CJdyB6VXLW++6J0RmyCOgXWJrSnDfUguUwDCMrVjiMZ/xIElI3SKLwY0Fxxvp7z/1b2g
         1plpTYByibYUq0+1x1yJo9bnQHj9K2HIQ7G+X0SMfqGPKuPxlrjKkNeU7vHb+r+ZpDOm
         wQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxM9HSg7LJAXbn7ENAypRMHLklYazMOh09jYix5Uw6E=;
        b=DuWeBazynGYTC+OtGDiqx11+fxsfPp50+B9ldxJduqxvVAPlKO/7tu6AvGdn/p3t12
         2jtdSibZBDHjGcu5KQYfrifn9Y+nSk4Jq7EGOSvsNloXpACyW+rielkFf32JnWNCjh5v
         nbpht1jISMrAvGW8c8Tns/7w4gz2SX7bUTtznDZeeNVB055y1tqS4b2Y5GOlCTpm+9Ox
         SY9RfDh+2aZ5Id1z1O8l/kj0FQ5BCTnL/i3oBtevdATXVNUp4asbX92eQYwhvckmbWl9
         p+kD5bDTPifmX+a2jpKqZP2uPJscY+Kx/UkdwIL/kg3sA8z8aFnABy3RT0YiUoXWGb8C
         nnwQ==
X-Gm-Message-State: AO0yUKVJa1LaO/SJRip86xoETSInotGXQEB6XR7ArEkzr8ixSLMb3XOO
        5+05RZCrmZwo/swh0RMKnMjUNQ==
X-Google-Smtp-Source: AK7set9JKwd3BkoJ3sv3/meRokBhU/jYIVthMrh8D+corP149rVnlLcP+5twV+Gr3Na6gp+EK9USwA==
X-Received: by 2002:a17:906:3885:b0:877:6a03:9ad4 with SMTP id q5-20020a170906388500b008776a039ad4mr7284363ejd.56.1675368110320;
        Thu, 02 Feb 2023 12:01:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906318100b008787134a939sm257789ejy.18.2023.02.02.12.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 12:01:49 -0800 (PST)
Message-ID: <a3b6560a-764f-203f-4926-871c814a556a@linaro.org>
Date:   Thu, 2 Feb 2023 22:01:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/6] dt-bindings: mailbox: qcom: add compatible for the
 IPQ5332 SoC
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-5-quic_kathirav@quicinc.com>
 <3a346606-576b-ab89-78f5-5bbaca729090@linaro.org>
 <8766f07e-a5d2-b59c-d130-f8cc2da64556@linaro.org>
In-Reply-To: <8766f07e-a5d2-b59c-d130-f8cc2da64556@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 22:00, Dmitry Baryshkov wrote:
> On 02/02/2023 17:35, Krzysztof Kozlowski wrote:
>> On 02/02/2023 15:52, Kathiravan T wrote:
>>> Add the mailbox compatible for the IPQ5332 SoC.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml     | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> index 943f9472ae10..8d8cd1bbe67e 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> +++ 
>>> b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
>>> @@ -18,6 +18,7 @@ properties:
>>>       oneOf:
>>
>> - items:
>>      - enum:
>>          - qcom,ipq5332-apcs-apps-global
>>      - const: qcom,ipq6018-apcs-apps-global
>>
>> and drop the next patch
> 
> Is it still ok even if the two devices are not fully compatible (iow, 
> using different PLL types)?

Ignore my question, I mixed the A53 and APCS clocks.

-- 
With best wishes
Dmitry

