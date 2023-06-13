Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A583E72E245
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 13:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbjFMLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242341AbjFMLvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 07:51:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC7C1BE6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:51:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so7690287a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 04:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686657089; x=1689249089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvgRqV++n772I/d7wLPA5rsuuZeDf6O7UA25bKaKXNk=;
        b=MQ9381wrJR+klO2Uqe2UjAdSKpKAfdwBmxOJPfriSeB/8NzH64V2iyO2V5arQs4Bwv
         4Ug3nM1vYZ6pjfEp2vyw9zYI3OW1c04YXEagaUD11CwXiEq+etoqYKxsXeXuVp1CgwR2
         VToJzvHhCB74bgz7LqTGJ51mhxyuAHOJh6HBXVhg75gZ79oQHXtbwrhI+AfJPkCrQCNy
         T/+7H2B2xWDZYiOuaUYsh1ysGW4Z7hWAYjzscZKmhXOMivd/WO5USSIS7PYjrGdiPWuR
         45w/9JWzokYGMj8dnRNGoHod31e2wM6u3vfXyM3gikSE0qoBPg2u6di+ztN12XqHPp82
         v7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686657089; x=1689249089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RvgRqV++n772I/d7wLPA5rsuuZeDf6O7UA25bKaKXNk=;
        b=f3h2sUwiQaf/Fl/3NX0VyrzUa9dKCnV2+fVgEKTXrX0JAo7pSY400aJ/mz3M1GKON6
         26AOtAEIsyUMVH7YXlteqU3iDK+45rkUdH1miyoqAV2kj461axSG162V5ySpa9gyt5Dp
         6rwJipdvh7PiRh7+UmGRceCCoDu1lrHP9vVlulHa4gjQNVFNo6SrtKJjgLHd2szS/Vk6
         67nYJxzamRWB5kAjeeuzRIeC2PQanj7wKLkdeGwnwVytnKF6PAXo3x6cNaHOwICNx43d
         nYJ1Bkis27q09qLzmriLOwBSfdhLtQ8Qdr8yIW0/5It0JLyM98OWh/T9udwQ4p+34SRu
         OZRQ==
X-Gm-Message-State: AC+VfDyvrFNtm38gCWbm8P2jKUDMnhZuSSIBMAecSolaBj69SPLO09h8
        pWaQRxB+txHEb52Z3GYONKyyKg==
X-Google-Smtp-Source: ACHHUZ4iOHIXzVqnZ/JnP6iQdCy7t4gbxOUo5FN94mdl1eyboMAP5cirp8q3BcpMjH9VepEaPnGLfg==
X-Received: by 2002:a17:907:a40f:b0:978:ae78:a77f with SMTP id sg15-20020a170907a40f00b00978ae78a77fmr11136368ejc.21.1686657088911;
        Tue, 13 Jun 2023 04:51:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009659fa6eeddsm6528453ejk.196.2023.06.13.04.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 04:51:28 -0700 (PDT)
Message-ID: <768c66e4-748a-b63d-7aef-fbbeb61044de@linaro.org>
Date:   Tue, 13 Jun 2023 13:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/8] dt-bindings: connector: usb-connector: add a gpio
 used to determine the Type-C port plug orientation
Content-Language: en-US
To:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v3-0-22c9973012b6@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v3-1-22c9973012b6@linaro.org>
 <e26878e5-fedc-b2fb-2213-5afd8479de4f@linaro.org>
 <cfa788c3-be57-5109-73df-b82099dd17a0@linaro.org>
 <9abec6ec-1995-8e20-8926-f57969341932@linaro.org>
 <f708a6d3-321e-c425-8048-1c0d2ac7a6f0@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f708a6d3-321e-c425-8048-1c0d2ac7a6f0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2023 11:24, neil.armstrong@linaro.org wrote:
> On 13/06/2023 11:02, Krzysztof Kozlowski wrote:
>> On 13/06/2023 10:54, Neil Armstrong wrote:
>>> On 13/06/2023 10:13, Krzysztof Kozlowski wrote:
>>>> On 13/06/2023 09:55, Neil Armstrong wrote:
>>>>> On some platforms, the Type-C plug orientation is given on a GPIO line.
>>>>>
>>>>> Document this optional Type-C connector property, and take the
>>>>> assumption an active level represents an inverted/flipped orientation.
>>>>>
>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Rob had here objections as these are bindings for the connector, not
>>>> PMIC glink/altmode. I still doubt that Qualcomm USB Type-C connectors
>>>> have such pin exposed. If you open the schematics, the GPIO is actually
>>>> coming out from PMIC and is nowhere around the connector. Please drop my
>>>> Ack.
>>>>
>>>> This however could be a pin of the PMIC because it clearly is on the
>>>> schematics.
>>>
>>> Yes it comes from the PMIC, but this part of the PMIC is handled by
>>> the PMIC_GLINK firmware service, so the logical place would be into
>>> the pmic_glink node with a gpio array in order to handle multi-ports.
>>
>> I think all PMICs have only one CC_OUT pin, so this would be now
>> maxItems: 1, but there will be no problem in growing this later.
> 
> Yep, I'll only allow for sm8550-pmic-glink and set maxItems: 1 for now
> since it's the first occurence.

You can add to pm8350 as well - it's already used in HDK8450.

Best regards,
Krzysztof

