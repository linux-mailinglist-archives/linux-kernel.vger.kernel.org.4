Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99E5EAC95
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiIZQc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIZQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:32:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E68321A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:21:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id i26so11372841lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tWi/dsE8AuXCeQ6nZkBTZY/QK66Lk4dB+IUoBCRY7mk=;
        b=imQCW1Cq4bSSwT+3faEeWCRPaqfIK/sznAR1qnmSFc6/PgtqhnTtFZzMgi9uuDru71
         bd2u4s9093j3nCVqhwlLE/wwT+JEd09mCHvqarsHv9fWXsrdMZUaYCP3bmf6yPzoBsMB
         9BxdxRa17MBvvkEMyPCgKA6qZYnvkaRkXAS5HfrvUmD+3u+9wdviTguR8Jo1vHWKc59T
         +SA514JyXxM6iIjctdW1FfIU8cIpRoMsohvlV+TlU/mMGnbil+fJ5YDfy4U/aF8uhqqt
         bCtRmkvLDX60DzfO5ZJUn+v0glQ1//zY7TMRUSq85efN53wSNKds2gaoi5r49dXb29G1
         FuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tWi/dsE8AuXCeQ6nZkBTZY/QK66Lk4dB+IUoBCRY7mk=;
        b=UuddyTeV3fliBHTETNGGBa3TdNSwK11jDazmHfJSEGYoOZgMHJDbWnGFSlM8P8D9mC
         b6eXYfkEnKh1wDDFlg0lFFliQs6Ve13TzwSSJpiTKSbcdlQIQ1IJi6wFotxLyk6bYn40
         3YImKmBWDXXrMqIFrUHgm0fVec0DuuPOFk9phV+RYS7mXUtxEbsHGe2lJctAWSqdGxK1
         VwO6QqBbtmOozV2X7NltPt3XjxF9g4A2IWfgNi/JufJtjQnXXR2VYBoMuifRlo0GYtdb
         GAGh9+LOAxR6VKCbS9jnTp86BYTkmLgP750LVYbXUnyjrufGExR6gFQiBtGtLhJmAMbL
         yS7A==
X-Gm-Message-State: ACrzQf2tjjofSLe+aPcatAflVPKuwUTnQsP24TAcKzOgQdfsemkWxXQg
        QdOpppU2ehO+hKCPRQUl+IZacw==
X-Google-Smtp-Source: AMsMyM6ZKhHvCfw6VXJTnAEUEBa6RxAvON78hn4d1rZ4Z8sgGMJ8zlmCmYgyKGXCuTn95c6xzWmtAQ==
X-Received: by 2002:a05:6512:1056:b0:498:efaf:5bd1 with SMTP id c22-20020a056512105600b00498efaf5bd1mr8760526lfb.64.1664205664900;
        Mon, 26 Sep 2022 08:21:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i21-20020a0565123e1500b0048fdb3efa20sm2548731lfv.185.2022.09.26.08.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 08:20:43 -0700 (PDT)
Message-ID: <123472be-564e-9fa4-528e-f7d43cd5b9ad@linaro.org>
Date:   Mon, 26 Sep 2022 17:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/7] dt-bindings: msm/dp: Add SDM845 and SC8280XP
 compatibles
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <acd9ff20-a07b-05ab-6f4b-34e3e8b1cae8@linaro.org>
 <20220926151302.GA1880039-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220926151302.GA1880039-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 17:13, Rob Herring wrote:
> On Thu, Sep 22, 2022 at 05:37:39PM +0200, Krzysztof Kozlowski wrote:
>> On 22/09/2022 02:14, Bjorn Andersson wrote:
>>> On Tue, Sep 20, 2022 at 09:09:13AM +0200, Krzysztof Kozlowski wrote:
>>>> On 19/09/2022 23:18, Bjorn Andersson wrote:
>>>>> On Sat, Sep 17, 2022 at 06:03:27PM +0100, Krzysztof Kozlowski wrote:
>>>>>> On 16/09/2022 21:00, Bjorn Andersson wrote:
>>>>>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>>>
>>>>>>> Add compatibles for the DisplayPort and Embedded DisplayPort blocks in
>>>>>>> Qualcomm SDM845 and SC8280XP platforms.
>>>>>>>
>>>>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>>>>>
>>>>>> No need for quicinc SoB (unless you also take ownership).
>>>>>>
>>>>>
>>>>> It's my understanding that both needs to be there. Bjorn @ Linaro
>>>>> authored the patch and the author must certify its origin, but as the
>>>>> submitter I must certify its origin.
>>>>
>>>> It's the same person. There are no two Bjorns (unless there are :) ), so
>>>> you certify with old email. SoB chain is coming from people, not email
>>>> addresses.
>>>>
>>>
>>> IANAL, but I don't think it's the same person. I can't use my old
>>> signature to certify the origin in a contribution today and I can't
>>> claim authorship of something Linaro did.
>>
>> Fine with me.
>>
>>>
>>>> And it is not only my understanding of SoB chain.
>>>> https://lore.kernel.org/all/YuKcBO5JatwRYQJ3@kroah.com/
>>>>
>>>
>>> Again, IANAL, but I think the situation is different given AMD and
>>> Xilinx relationship.
>>
>> Hm, I am not sure how it is different. We might know or we might know
>> the change of ownership. Maybe the change of owner came with copyrights,
>> maybe not (someone else bought them). I don't know, there can be many
>> cases here. I interpret Greg's point there as in SoB statement - the
>> person, not email address, certifies.
> 
> If Bjorn owned the copyright, then yeah, 1 email would be enough. But 
> Linaro owned the copyright so it should be there.

True for taking the authorship of patch, however SoB is not for
copyright holders/ownership but to certify that one has the right to
send it. Since patch was on the list, anyone can take it and send it.
Everyone has such right. If another person is sending, then he needs to
certify the origin with SoB. If Bjornv2 is that other person, he already
certified (although with different email address).

Best regards,
Krzysztof

