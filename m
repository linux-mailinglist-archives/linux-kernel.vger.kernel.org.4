Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C925E6747
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiIVPhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiIVPho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:37:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D6EB104
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:37:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so15331602lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zdGItr5ICc4vlhS3KGwufw/Y8w2UR5ZVlts6EctynGI=;
        b=cYwW6ohqGr+JtPJ/CQ4fzXi+ot92VVnYo0FHuXQI76jbm8+6lgnVm/+IBi5NLIuAJp
         kxZ2IXhyaFXUtcVSx6vOBG5nCGulreB7JY3l7+kgMlntGfGGUYdxNf4zhJGDvLfzBNZj
         yffbR7QxgOGesk1up0TsxpFaSg3SIHIQsGmWH+obHSl6VIRewS62cXjxHRfTYSWhTT4I
         c14V4UraiU52gm+7TgaCeOQU0hsbgoWEfgHezZ/Ug6+jjqd4WNg/HZoY1Cuc1HX1s6tB
         95/xM/6e58bs5qpZu/Eg8t3clreVhFcU9ISgFZVBQNhwZ7Ejl6uMNpLQPjEyZ7ENEv0p
         bljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zdGItr5ICc4vlhS3KGwufw/Y8w2UR5ZVlts6EctynGI=;
        b=AFyKdJxu10rgvuq6e/WPJc/VuVh4yNG7P/c63PHdlm1ohD+e4YFAptFHEMxPDUL3fc
         8YKpL6dRb6AqCUbOfOLZ/1EOF+SpUazunsQ6w6t06hnHY8eLmYVMdAZEPx7mynhurXOL
         Tnr0YCm1/Uh+Ow/dV+QSg8HI60B2PbXWj1Iy/kmnvHOkhzvlDmYAto5EjkbPIQDZEXIj
         kQAljqen7a8gqsJBmYMb1RRiLTF3pSxnPEgpQZeEC0cmiC9HP+pQxEoXRyJ60N35R8ZN
         ZT6oOgDRPQjpfA1zw0b5wjsuYyJ+OT4mj+fPviAXRA7lIb4MmkN7tcbZCnRDY8YHELxS
         63tw==
X-Gm-Message-State: ACrzQf2j53VjtxO1Ph9q2rnxBpICCMH3oryEcTGpZsqahMgikGpeHE1B
        jZyYDe74Yv14S/YZtekU6/N3vA==
X-Google-Smtp-Source: AMsMyM7h9wDWsyUiqMcRTiNhG8QJKDH4ATtOFz8lkYELII3NUCIdQoLWizMQQQXkal5Hd6Zg8Y51zg==
X-Received: by 2002:a05:6512:2251:b0:496:c3b9:c18d with SMTP id i17-20020a056512225100b00496c3b9c18dmr1389520lfu.403.1663861061448;
        Thu, 22 Sep 2022 08:37:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b0049f907b9ba9sm982317lfr.226.2022.09.22.08.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:37:40 -0700 (PDT)
Message-ID: <acd9ff20-a07b-05ab-6f4b-34e3e8b1cae8@linaro.org>
Date:   Thu, 22 Sep 2022 17:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220916200028.25009-1-quic_bjorande@quicinc.com>
 <20220916200028.25009-2-quic_bjorande@quicinc.com>
 <1641e41c-08c7-859b-644a-28d966fb00f3@linaro.org>
 <20220919211832.6b3buqxrnfp6yjjg@builder.lan>
 <6b242b44-b657-c7a6-63ca-465c7031376f@linaro.org>
 <20220922001429.zqfap3clprvlo6jo@builder.lan>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922001429.zqfap3clprvlo6jo@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 02:14, Bjorn Andersson wrote:
> On Tue, Sep 20, 2022 at 09:09:13AM +0200, Krzysztof Kozlowski wrote:
>> On 19/09/2022 23:18, Bjorn Andersson wrote:
>>> On Sat, Sep 17, 2022 at 06:03:27PM +0100, Krzysztof Kozlowski wrote:
>>>> On 16/09/2022 21:00, Bjorn Andersson wrote:
>>>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>
>>>>> Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
>>>>> Qualcomm SDM845 and SC8280XP platforms.
>>>>>
>>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>>>
>>>> No need for quicinc SoB (unless you also take ownership).
>>>>
>>>
>>> It's my understanding that both needs to be there. Bjorn @ Linaro
>>> authored the patch and the author must certify its origin, but as the
>>> submitter I must certify its origin.
>>
>> It's the same person. There are no two Bjorns (unless there are :) ), so
>> you certify with old email. SoB chain is coming from people, not email
>> addresses.
>>
> 
> IANAL, but I don't think it's the same person. I can't use my old
> signature to certify the origin in a contribution today and I can't
> claim authorship of something Linaro did.

Fine with me.

> 
>> And it is not only my understanding of SoB chain.
>> https://lore.kernel.org/all/YuKcBO5JatwRYQJ3@kroah.com/
>>
> 
> Again, IANAL, but I think the situation is different given AMD and
> Xilinx relationship.

Hm, I am not sure how it is different. We might know or we might know
the change of ownership. Maybe the change of owner came with copyrights,
maybe not (someone else bought them). I don't know, there can be many
cases here. I interpret Greg's point there as in SoB statement - the
person, not email address, certifies.

Anyway, this is not a blocker for the patch.


Best regards,
Krzysztof

