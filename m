Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0786E2901
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjDNRLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDNRLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:11:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F09112F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:11:16 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so3054460a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681492275; x=1684084275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWFKzv+6OmPpo0mp+ZpJhFgaz9KaqvwS0otuVBFZkt4=;
        b=zD/gD0jBGi43o9/Ge5kQCvMRScKUzFjkx5DaAbv/qtx0EJwZcJv2CoslRQDqd02H+y
         md1jyufYPCllkhwCyDmoo0CVeh58e28zdDxN3wSnCy4MWOoyIhraFoYPXDTqREkpyI7N
         m/Ha9wvdSPGfS4O24o9Xt0FXKp4Pa4k81XftT642qAajltTUdZRatCK5garx8jXT3WfM
         1yS2jLg5m8kgM3QRF5uydUGagY5uIvqyob9d+bk1Ynq5DdSWZ3B8e7Y3SRMWysP+C6Ek
         WdhGn+Umaoye7LWFQdNtIniRqS3MKgp8m/bJOIcI7J6L4+H4Lhp5B6bhonQfdbRP/5tQ
         8M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681492275; x=1684084275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWFKzv+6OmPpo0mp+ZpJhFgaz9KaqvwS0otuVBFZkt4=;
        b=kf1bp7uG5075aJRnRXEx0i5Xp1J3lg+N18M9G4wyNsE8Ma+4AI7NhCDWXb+fFGvuSu
         YpVCwx8Nv9AjpWeUysjkttj5nQ3InDOb3ykLROoJksfdWZYksvrRyLWMF7VTg9sLD/R3
         fqYZXNF6rfO25BuNw6k5x/CtQFNn5EwhXDRi7r4J75m1DseeRbd3Z2AUhuwTrCjzgXZm
         HrQrlZguwQivfewTZZL9Cnd+VbQ3IeUno9BglXLEHjQ9rGk7PMAbSwanCYOW4NkSKFBx
         GqdI8cwkseDZQY2swYGgwy+3rDQbdgFG6nDzmDwOUAj0n1tbDLwLJ96Oi2KUaNarcrXA
         9BNA==
X-Gm-Message-State: AAQBX9fVMcX2k6xeREvvmYtY95V8tq4lWjkQGaTuesCQ8u4QQ5LjLTNq
        9ZBPtTDKUROGtsPwCYTVrci17g==
X-Google-Smtp-Source: AKy350ZM7koFyxIDpucMqufOPkm2B6d69BgIu8wCBP3JNPLMuVz9Btf/itc+rnQmz5h3CQEwKNXoLA==
X-Received: by 2002:aa7:c394:0:b0:501:c3de:dc5c with SMTP id k20-20020aa7c394000000b00501c3dedc5cmr6166290edq.18.1681492275024;
        Fri, 14 Apr 2023 10:11:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:39b7:81a0:bd41:17b1? ([2a02:810d:15c0:828:39b7:81a0:bd41:17b1])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7dbcf000000b00501d51c23fbsm2344642edt.6.2023.04.14.10.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 10:11:14 -0700 (PDT)
Message-ID: <76237034-7871-c77f-1e32-c0a585d8df86@linaro.org>
Date:   Fri, 14 Apr 2023 19:11:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V1 1/4] dt-bindings: clock: qcom,ipq9574-gcc: Drop the
 Bias PLL ubi clock source
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
References: <20230414134812.16812-1-quic_devipriy@quicinc.com>
 <20230414134812.16812-2-quic_devipriy@quicinc.com>
 <dc48d390-9c8b-d3b7-9c5e-6cbddb0e1306@linaro.org>
 <aca7b808-51ce-1921-2ee2-0e82cf19d960@quicinc.com>
 <7b4fe58c-9cf8-57ab-8cbc-c5ccf0b2a46d@linaro.org>
 <2c5bbe48-3007-a1d5-73b9-9d2132bff9d4@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2c5bbe48-3007-a1d5-73b9-9d2132bff9d4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 18:04, Devi Priya wrote:
> 
> 
> On 4/14/2023 8:39 PM, Krzysztof Kozlowski wrote:
>> On 14/04/2023 16:22, Devi Priya wrote:
>>>
>>>
>>> On 4/14/2023 7:47 PM, Krzysztof Kozlowski wrote:
>>>> On 14/04/2023 15:48, Devi Priya wrote:
>>>>> Remove bias_pll_ubi_nc_clk from the binding as it has been removed from
>>>>> the Device Tree. Also added Bjorn Andersson to the maintainers list.
>>>>
>>>> Was it really removed? Where?
>>>>
>>> It has been removed from the Device tree and binding in V11
>>> https://lore.kernel.org/linux-arm-msm/20230404101622.5394-1-quic_devipriy@quicinc.com/
>>
>> I still see it in current next. Are you sure you refer to something
>> already merged?
> 
> This change was made in V11 and Currently V9 is merged in linux-next.
> So, the delta changes between V9 & V12 is posted in this series.
> The device tree change where the clock is removed is added part of this 
> incremental patch series and the binding is updated to reflect the same.
> Apologies, if the confusion is because of "has been removed from device 
> tree" in the commit message.

Your commit indicated that removal from DTS happened. If it did not
happen, you need to come with proper reason (and fix the tense not to
confuse).

Best regards,
Krzysztof

