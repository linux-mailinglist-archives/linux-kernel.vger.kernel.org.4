Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F49627947
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiKNJoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiKNJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:44:37 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1000BE08
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:44:35 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c25so12400215ljr.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Mfk03ObhB5QdyMi+4i15XE/Dl+XNWfhlephvPFyPk=;
        b=cFX1sX3tc79+AqFp5EAVE6mMJlJvIy7uUZLTJ+YOdGgyVeFzP4/xPP4b6u1sb02k0u
         bKGW4C6LXYOqWdGXM7MNMVOyHuWQbYxUKjb253r8bPQACrN81kIp3jxFSI4LAcSPnU8N
         qDXB8PrPtjyqhXF/R42ZG9lMK6LwtePcbOGYiA7r471+R4vFNshB/j79rR1hKh8pNODE
         p50EiRxnNx811a2Ezzab1Z6YupZM8pQIL2j1Unaeuz+lSFGo4rgiC5Kbomrmnns0OHwq
         s9cw0qJQCFQRVlKTmcw64gkdBV9+QQa4sYSxdCWekwYObdBeXSCYXxFawpP3TAmDxK6m
         1+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+Mfk03ObhB5QdyMi+4i15XE/Dl+XNWfhlephvPFyPk=;
        b=6yirNpj8ah9fFlcicA55QvRyi/4wh1fW9mnvkcmq/ObkjcvAy9AbY3EQMu8udX6zcJ
         Mju2gEWepEyvWYNn6FDXioiKQBBGVsQ76nHi2yNGcDRooH623WFxKy2+vDVsp1wYdyPP
         hViBntu5vhsX4SDfWC2QbqdUhjpZJVLEeSD209vT8XDuvZ8DX5baSgWxPmpS9qEiRYXr
         jHv6nahOVq4I34H5WyuQZGV/gv9IW9gTYi8IGJOo9jzmU6gfUeykOYtMXdB/OSTxHvRB
         KJ/2gu4mDeh3q3ZJK5pZqTyuoKVJcmKhr2ZlhsG71BhKegwx6iYDUilOoh8NkxWlpkRU
         MN+w==
X-Gm-Message-State: ANoB5pldFJn5ST8dEm7nZYYaxLAsHqx1IHYWFbd6P0wVpvzlVh74gAKl
        lLBNSxjboAdSojAaDDWBtOcsCS+QwgVuOA==
X-Google-Smtp-Source: AA0mqf4JtU/aYJ6b6h99kDhTOy5GzT3R+kuk+YIYtID6sQ4KNGBGjJtrX3SPgAegJSiYuePUcWfFDQ==
X-Received: by 2002:a2e:1543:0:b0:278:ea37:6b82 with SMTP id 3-20020a2e1543000000b00278ea376b82mr4003143ljv.38.1668419074264;
        Mon, 14 Nov 2022 01:44:34 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o14-20020ac24e8e000000b004a93b8508edsm1757359lfr.181.2022.11.14.01.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 01:44:33 -0800 (PST)
Message-ID: <002289e7-5453-44b1-5e1b-60665b39772e@linaro.org>
Date:   Mon, 14 Nov 2022 12:44:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kumar Gala <galak@codeaurora.org>,
        Rob Herring <robh@kernel.org>
References: <20220830065744.161163-1-krzysztof.kozlowski@linaro.org>
 <20220830065744.161163-2-krzysztof.kozlowski@linaro.org>
 <fe747000-a650-ed2f-8581-92b044f86f2f@linaro.org>
 <CAA8EJpruwhOVacH6_kN2TABmVR5Peu1pjFa1b4sag5p1zouqRA@mail.gmail.com>
 <e3776784-ac9a-8de2-f6e6-393e5dc1041c@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <e3776784-ac9a-8de2-f6e6-393e5dc1041c@linaro.org>
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

On 14/11/2022 10:38, Krzysztof Kozlowski wrote:
> On 13/11/2022 14:50, Dmitry Baryshkov wrote:
>>>> ---
>>>>
>>>> Changes since v6:
>>>> 1. Update header with defines
>>>> 2. Add Rb tag
>>>
>>> Hi Bjorn,
>>>
>>> Any further comments on this? Can it be applied?
>>
>> A gracious ping from my side. I think it would be better to apply this
>> patch rather than having the undocumented and controversial propreties
>> in the device trees.
> 
> The patch was applied.

Ack, then please excuse me for the noise. Somehow I missed it.

-- 
With best wishes
Dmitry

