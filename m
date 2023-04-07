Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761986DB40F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjDGTSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjDGTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:18:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176189ECB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:18:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sg7so10383905ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680895119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVZrkBqgVgcVzeGGGFBhsy4jLsRZIddjwzjEhu3g9lM=;
        b=ntTn7ynloJD1t1Gl4ChofmVHRUhHROukNNWnB9ljx+J7RETmKFEFQ+KJ5gtfYozxXW
         Axho8MKxdGYzZHD94OLoGbONIekG1GdcUeeXbml8S10Gs2C9bjsVTb4Mo/3NMiJDPlJz
         3mLk3P405NWO/vlSub75PYDuBfcnLSugHnpurF1ZWjwnWlrFM9AyHfMJgjHm6gfhufU+
         smYPokPhd+PSyx7wLigoXXWfgpxFgajrgvko4le4iaj6idEpEdy55L3gtnuYNScoYIpv
         HDn+maIzr7RmUxuQSrUZuJkUR7tVLOUmgFKIENhh7NzIQCINkwxhv3Jd52UR63vUpadz
         VNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680895119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cVZrkBqgVgcVzeGGGFBhsy4jLsRZIddjwzjEhu3g9lM=;
        b=TM4WTYkONbQBssrnfYHcw5CUuqsEzfo9cEYZBdSTDfeJZfGfYku6iohrsis45rfEqx
         0Il75nxdJw4xEv/8yw7/yRKpW8NvA/nEb9nFElH1Z8Fm+70KaOcxKBkQw/33BJyJg5sT
         IkfKN0AaG1UF0fL30lOutF48AotZj9cLDCBl4L6Zc5BWf3d4+vaqhSj/93EdIVuZ6Mv1
         2/0yR42rxo3gsTbtPi/ml8y3nTuLeA/Bk87TahVn54w4XQyor2bauvhAQG8vkLogSTKS
         MO0JmdPqiMX0nlnwdwZ5HvdOqbUwHLaqtBGWy1z/6CMk3ePsGHg9noTwVh90vBBKX/Ko
         pdCA==
X-Gm-Message-State: AAQBX9c83RPspOc6xpFGwLsqm8OCTy6f3P4y1r81cfJqxQtgo6elbJMD
        6tFrSIYOtMpyZcq4e3bjwj5K0w==
X-Google-Smtp-Source: AKy350ayqtLaBs8rKb/x8oA6mTQe4UuwpmtgcUiP9/ueZGZEGgmoxYXtwqgNZ8xQ0h9e6tayUIDijA==
X-Received: by 2002:a17:906:fe44:b0:879:ab3:93d1 with SMTP id wz4-20020a170906fe4400b008790ab393d1mr711542ejb.4.1680895119358;
        Fri, 07 Apr 2023 12:18:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b20f:8824:c926:8299? ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id lf27-20020a170906ae5b00b008e68d2c11d8sm2312732ejb.218.2023.04.07.12.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:18:38 -0700 (PDT)
Message-ID: <070b55eb-504c-f505-8b13-a903d5ec7564@linaro.org>
Date:   Fri, 7 Apr 2023 21:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630: move DSI opp-table out of
 soc node
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
 <20230327193938.42rvpttgo5p4kia6@ripper>
 <edb9fc8d-5d64-146f-fb82-6112c1d9455e@linaro.org>
 <20230407163442.ckbd4vxa5b2xu3eu@ripper>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407163442.ckbd4vxa5b2xu3eu@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 18:34, Bjorn Andersson wrote:
> On Mon, Mar 27, 2023 at 09:39:00PM +0200, Krzysztof Kozlowski wrote:
>> On 27/03/2023 21:39, Bjorn Andersson wrote:
>>> On Sun, Mar 26, 2023 at 11:16:05AM +0200, Krzysztof Kozlowski wrote:
>>>> The soc node is supposed to have only device nodes with MMIO addresses,
>>>> so move the DSI OPP out of it (it is used also by second DSI1 on
>>>> SDM660):
>>>>
>>>
>>> This node has been moved into the dsi node, so if we still want this,
>>> could you please update the commit message.
>>
>> The OPP table has been moved *out of* DSI node. The v1 was moving
>> inside, but this was not good approach, thus v2 moves it out.
>>
>> I don't understand what shall be updated here.
>>
> 
> The commit message doesn't reflect what's in linux-next today and the
> patch doesn't apply.
> 

It seems you applied v1. It's okay, yet would be nice to clean up so I
will send a follow-up patch.

Best regards,
Krzysztof

