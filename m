Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14C674D74
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjATGl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjATGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:41:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C3442D8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:41:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so3914225wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slGPI6crOMYVC8sg2UdbToHUlfJe2Yt2u0BePxW+DE8=;
        b=syu8BvlihPitmOdzTlCvAKZdU0CYUPdiFZAMMB324wLdZi6aBGYiVdeFs0mVcpo5rL
         L3mtJQa3rFwuMK3Iu1x58Mgpb0AuR8ATuRu+AwSMRNFqMmlElKbaBaohxDf7Y+Ypk3SA
         7birmWEI2+Atf+CuDiCl+P9U8xLS4glBIg1yfgmytNVN2bCzA5u7zGI31eI1rU2fqj84
         E7qOIkcVnkqvgrVCAkQ1sdSKW5RW1MHETFpxOC0U2C3tGpSX3ih5uLiWT29s9WBXn+Jf
         /MQ5cGEbvgFXOswsuFR3v0oFZw9K8VtgV7f6DKyWltLjOHZfrglD8EP8RHSFlz/cDp8Z
         6AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slGPI6crOMYVC8sg2UdbToHUlfJe2Yt2u0BePxW+DE8=;
        b=clrj5HoJvi1JRt9OnfIskXv7dRikj1ahMl7TA2W5HrXT2uAond+SHYynxEbvNprARH
         ZE2Z6JznAbTJHRfQXHClj+Szq72uV+1SLk9qCHbi+lSjLKkB4ecZYGoqPsgYRZq1uaCk
         CBiP5NY9/TI1/1cLK1HeSVIebCXFe0JVIAtrLBh3Fjlec8Zpb2V9PHycB9AO7bWCGdnh
         mJE5jqn21Cn9vSyuZx2oAKfH2/HCgaOzocYBYxkQL2orIZPQqqYS0eiAXaM2Wpt8LOLi
         naZklAChtTcPiI/5eZG+BOmH3d0KLk2F/CF48QadAw3J8Pu59EblWExGpL5sD/w8syYd
         F5+w==
X-Gm-Message-State: AFqh2kqMXKQcH9wumfw1F7HoYvN558evBbi3kN3MOiteeJIus+0OAi3D
        Nwp+KX7bGQErAfxrikUe315cdQ==
X-Google-Smtp-Source: AMrXdXsEQJpb4J+80as5QAfc8VdtlHuSYRcxkbLulhlLE4kmrEIl6O1WXICsnLmy9n/UBpwLCIu6Jg==
X-Received: by 2002:a5d:6b0e:0:b0:2be:d03:287 with SMTP id v14-20020a5d6b0e000000b002be0d030287mr11554212wrw.44.1674196880688;
        Thu, 19 Jan 2023 22:41:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v14-20020adff68e000000b002365730eae8sm35429959wrp.55.2023.01.19.22.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 22:41:20 -0800 (PST)
Message-ID: <e8b6034e-f163-6f6b-2f02-f2eda808950f@linaro.org>
Date:   Fri, 20 Jan 2023 07:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/2] dt-bindings: opp: constrain required-opps
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Ilia Lin <ilia.lin@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230119130028.106817-1-krzysztof.kozlowski@linaro.org>
 <20230119130028.106817-2-krzysztof.kozlowski@linaro.org>
 <20230120043834.txkg4tockxcjqs2g@vireshk-i7>
 <9adec806-5529-f98a-949a-630edf3e1d0a@linaro.org>
In-Reply-To: <9adec806-5529-f98a-949a-630edf3e1d0a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 07:27, Krzysztof Kozlowski wrote:
> On 20/01/2023 05:38, Viresh Kumar wrote:
>> On 19-01-23, 14:00, Krzysztof Kozlowski wrote:
>>> Be specific how many required-opps are allowed.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> This change is independent, although logically is connected with my
>>> dtschema pull:
>>> https://github.com/devicetree-org/dt-schema/pull/95
>>> ---
>>>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml     | 1 +
>>>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 3 ++-
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>> index 47e6f36b7637..9b141a409191 100644
>>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>>> @@ -202,6 +202,7 @@ patternProperties:
>>>            for the functioning of the current device at the current OPP (where
>>>            this property is present).
>>>          $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +        maxItems: 1
>>
>> I may not under this property very well. What exactly does this line
>> say ? Asking as required-properties can have an array of phandles as
>> well.
>>
> 
> It says we can have maximum one item in "required-opps" in "opp" node
> and you are right that we could have here more. I'll fix it.

OK, this patch can be actually dropped. The dtschema will bring
constraints of 1-8 number of items here, which should cover all cases
for both opps - v2 and v2-kryo-cpu.

Best regards,
Krzysztof

