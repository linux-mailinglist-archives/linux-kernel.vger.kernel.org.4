Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC27480F0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjGEJen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjGEJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:34:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61C61721
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:34:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so373504a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688549678; x=1691141678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXURleKlaTFNIbTJ9xd745LCWhyovyOc9RZu94UdHB4=;
        b=CkO7C71oRzFMdTiC7jMnovz3eVbsHlOo7s2oEzA8izZprXZqGtqMf9XLy8R4N2Gxkf
         55gNLjKQjSPI6Tcj+x69U6GC9ejBrOVmAy0igh/p5oCp+ULSywHl8hYtA9lN3do/LdzZ
         q6ihosgyqrpiui+dUAPSdh9kgyn6Yac1sD1r5xbvHfM1mZnlVBOtsYPR1WEC2gjlCntu
         bxSgG7aykjmvPo7WvRDYvbUWFW7jtoSe1uw2r8yLSiZSBrtL3isv4932Mtuf0LsRlu+K
         W69vVRbAPfR443FSD9Yvw83pJCmWZI4KsO6kr2s0C71U1rIKaiJ6P6G3J0zGypTbsPRV
         Z5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688549678; x=1691141678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXURleKlaTFNIbTJ9xd745LCWhyovyOc9RZu94UdHB4=;
        b=PLzH8pS4lRsMD23SfcT5/4CGQ7/usXFs2eNgegNfytdvyqyz+dTwOt9/vyD535lMnn
         cgqrz84FsEMaHd3Yi6BrT8Cubz8eLClWsa2EO7Fd9vp30Y/XHZyQfxIgUGcH4WWdt0hY
         95OAJWqUKXZ4RMQBvav+Bozg0mFF0qaLHsbMYIcsykWyZ3gvrqcRtotew4ZUhNOs3WWG
         UNPTuU4Mh8UnKdsJ0IXv2qA7/HcJeL+AbZuCBAPCDLsE0P8MwQUNIrQXZ8ojyYCFcJQ8
         0rn0/FzrXCqPOGNDd/uWPqcADLk+udl+DVkAWeptnfGpavFFynMo0pZuD0huwSzOZV48
         J8IQ==
X-Gm-Message-State: ABy/qLa9YXAazgRQqIO6hXmT3iVMj69qR+d0u8VbogpabGuColeqWryy
        Mh7Ayr8gVRiAv6NUMmckb742XHFZWjhOeBzfdAU=
X-Google-Smtp-Source: APBJJlE7J4ROo3gkQLmcRe/QT38WIvVMq1KDJBWjeV0T+MvtcUyDCQfMzHs5dYSdZyD8tkxfaNJ3aw==
X-Received: by 2002:a05:6402:7c4:b0:51e:da3:1585 with SMTP id u4-20020a05640207c400b0051e0da31585mr1597166edy.9.1688549678158;
        Wed, 05 Jul 2023 02:34:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p18-20020aa7d312000000b0051a2d2f82fdsm13044557edq.6.2023.07.05.02.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 02:34:37 -0700 (PDT)
Message-ID: <a0631800-f3d5-ff13-b316-9bc027275a82@linaro.org>
Date:   Wed, 5 Jul 2023 11:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V7 1/2] dt-bindings: firmware: bootstats: Add the dtschema
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
 <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
 <d339d413-5242-0d5a-96f6-c2f670e5e5dc@linaro.org>
 <968fb5d3-6cd8-7850-47e7-682e26f9ee5f@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <968fb5d3-6cd8-7850-47e7-682e26f9ee5f@quicinc.com>
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

On 05/07/2023 10:33, Souradeep Chowdhury wrote:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +
>>> +  abl-time:
>>> +    description: The property to store the duration of abl in ms.
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>
>> I have no clue what this entire binding is about. Nothing can bind to
>> it, no usage explained. Properties are not used to "store the duration".
>> This does not look like suitable for DT, drop entire binding.
> 
> This binding was created as per the suggestion on version 6 of the patch 
> by Arnd. The idea was that these 2 devicetree properties will be used to 
> populate the bootstat values from the bootloader and exposed to the user 
> via /sys/firmware/devicetree/ directly.
> 
> Details in the link below:-
> 
> https://lore.kernel.org/lkml/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/T/#mbdc9ad95fcbb5ad7b56c6996a3933899b42d982c
> 
> Can you suggest any alternative way to represent this as a binding?

Then you should clearly state in the binding how this is going to be
used and who is going to populate it. Not only in the binding but also
in commit msg which currently has 0 rationale and answers to "why". Your
commit msg explained only "what", which is usually obvious and much less
important. Your commit should stand on its own and should clearly
explain why we need this feature at all, what problem it solves.

And before you claim that there is some discussion under link or some
cover letter - these do not matter. Commit and bindings matter.

What's more, I don't think that Arnd's advice is correct here - DT is
suppose to describe hardware or firmware. These properties are coming
from firmware but they are not describing any firmware or hardware
characteristics. Instead they are debugging of current boot status.

I will leave the decision on that for Rob, however anyway binding is
very vague and incorrect, so I would expect he will come with the same
concerns regardless whether it is suitable to DT or is not.



Best regards,
Krzysztof

