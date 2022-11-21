Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77E663237D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKUN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiKUN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:29:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F2C0508
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:29:38 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id z4so5274190wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iV0tg+Y/5LPES0+ZdMW/BhKXPXcFixlOnUzTR1ltz8E=;
        b=ZpOQkhNgfdFBS47OMGa70QRocyMHE2Qgd2U/T7nAx9yRL5srZP4a+yeXSeKONWGRF1
         GxXcaPooaQvsY3k3P+C1q+jlmXNHKCMGzUXemvZNIxqZ3LGLeXyjU0uc//mzzoVEFpe8
         5kq8uN+tE+KdTOK00DnO/PpWQvbiI7zLYVK8qZGeYtGe+Vcz2mE51TpbGUjWLh3g0zab
         8WwIBotd++tc2yUvpCXkDLsyKDFQHi7BzPfAabNhlQP1YlGZATmp7Q18IZBC86K0eNWY
         0NJ6SK2dkXEZ/wfHL+eTexS8TqJFiitk3DflGtUvB/p6xmAboiyTtAX8empoDkOn25L0
         inCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iV0tg+Y/5LPES0+ZdMW/BhKXPXcFixlOnUzTR1ltz8E=;
        b=17/QDMPDHH6FY3D6SqaXL1KddJjHllfnGbYy3r3b9uJYGmJ1sQClJYm32MTbyBoQ8l
         s3iwhyIwArxxBz+Vi9rdCXUHykglyrc1FqxgoZdNLljFdXLM5bLfLkYLnVGrVeeOCi3b
         ORPx4psufAsndtA5hLwoFNLIRvG6lPuD920AFnMxxPYzSnazf48M78KAdOOJJMTnfang
         rzxqr7R6pv+5EnYeu3nPpoMfUBj5jqUmaeTjbrp9FxoKdK3gmYVobp3KSTvC793FJqze
         zE//1mIZaDUkx+HqMGu8WwBKQhEczyTN5GqzznW7iNTQRGWZPS+RH+CWR8nRkZh44JZ3
         3qRQ==
X-Gm-Message-State: ANoB5pnDLkrSmtzXhsM+DI+fTOSQsIXf7ytNMEFFwNEtXQF90WcyyQmK
        gVFXUDg2V0iLqH9S1jKVbRy84w==
X-Google-Smtp-Source: AA0mqf4j3e4CHp4nFnsOImA3/Ksj5nfXDqYpEDrHXLDolSKPZ3OXZpSXpBjs4Joq37jYm4Io1QXq8A==
X-Received: by 2002:a5d:5603:0:b0:241:c2ce:86a4 with SMTP id l3-20020a5d5603000000b00241c2ce86a4mr8684712wrv.360.1669037377327;
        Mon, 21 Nov 2022 05:29:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7eb6:aea3:e748:4607? ([2a01:e0a:982:cbb0:7eb6:aea3:e748:4607])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c1c1500b003cfb7c02542sm15430769wms.11.2022.11.21.05.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 05:29:36 -0800 (PST)
Message-ID: <081732c9-5e8e-b68e-c2bd-20724ca1a5d5@linaro.org>
Date:   Mon, 21 Nov 2022 14:29:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-4-abel.vesa@linaro.org>
 <76560659-7c90-3846-c250-24bfb072ec0e@linaro.org>
 <15ac1d06-5da7-ebd2-92ff-764c8df803a1@linaro.org>
 <3a84d45c-6550-7ae2-2511-9f61d15894d1@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <3a84d45c-6550-7ae2-2511-9f61d15894d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 15:59, Krzysztof Kozlowski wrote:
> On 18/11/2022 15:58, Neil Armstrong wrote:
>> On 17/11/2022 13:51, Krzysztof Kozlowski wrote:
>>> On 16/11/2022 11:31, Abel Vesa wrote:
>>>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>>>
>>>> Add nodes for pm8010 in separate dtsi file.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/pm8010.dtsi | 84 ++++++++++++++++++++++++++++
>>>>    1 file changed, 84 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/pm8010.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/pm8010.dtsi b/arch/arm64/boot/dts/qcom/pm8010.dtsi
>>>> new file mode 100644
>>>> index 000000000000..0ea641e12209
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/pm8010.dtsi
>>>> @@ -0,0 +1,84 @@
>>>> +// SPDX-License-Identifier: BSD-3-Clause
>>>
>>> Any reason why this is licensed BSD-3 clause? It's not a recommended
>>> license (2 clause is). Same for other patches.
>>
>> Probably a bad copy-paste from other existing files.
>>
>> While checking, the majority of arch/arm64/boot/dts/qcom/pm*.dtsi uses BSD-3-Clause
>> so it seems this was done for quite a while now.
> 
> If it is derivative work (of upstrea, downstream), then you might have
> to keep BSD-3. But if not, how about changing it to BSD-2?

It's definitely a derivative work from upstream pm*.dtsi files with BSD-3-Clause
licence.

Neil

> 
> Best regards,
> Krzysztof
> 

