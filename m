Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F356B8BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCNHIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjCNHIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:08:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC0EEC4A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:08:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eh3so2062518edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 00:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678777688;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zc2CAzqoPUyyp7nnHUds3QOGxWAQByBM0H4ZExogEF4=;
        b=OC7ijyrcfR+Vk3JrwDgTpQPh+nLY3gh3bMqyFcu/xUt77amFEfh9yXgjGGqYDPebnS
         g7DOqyvE3R2rq1vuT4RIsNjK4W7GmkVzdve/+4ebT/v7xzKEHzziizg3tikt/tCIaYX/
         LaeKKNzasHoimVhlYBO3tJJaDNqkY0NB27/LRhMV5ka0nIfwLRCZKfYme41qvvfgA0Xs
         UwK57LHhuBsx/ScbulF5xiqP3v0MWiRg4W5+kogK3Fg3rIziWVgHaa62kU2JtQJWXpqL
         UT+uXipezckQSZIPMsm2AeG6GCuXKeu1xY0TTEDSAfckBrzx27vACrBEGoq1TkI0hbL1
         Al9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678777688;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zc2CAzqoPUyyp7nnHUds3QOGxWAQByBM0H4ZExogEF4=;
        b=Vq7eLUdzdrONw0s4l900ZtwpVuWOH83txU5/wLqMNlpOxPmmAf/nAtHzkm3CMx/mq1
         GJqlrg0Qtu18Airk8w2wh2RdDIm1OPsjyiK71qGvhnCY1447P13RMstCb31+aita2vex
         p0tytTvXcxO3r2RAr76TuEUILyn/SmXsGd2cueY4tG2WKnVOImvdQiAi8L4tAtG11y3j
         hq1N7NCdKdDUCkFn7hXCfp+MlaU47XRbH/Sl5//VyLmQHVFL+BSrXKFsWLAteBF7hhTg
         /XKQDe2X29attDjCmFvXQVMcywoMqFnQ3p5v8yMZ3sw0wbTBDDbG+EYciuegyvWWCgTu
         BT+w==
X-Gm-Message-State: AO0yUKUhcA9vrq53L5ZmOY+0GVVp0wSmU/LXIk71JapoOuab2MoQhuaT
        pRspQmH9wYHnzUEjwFXTipvFyA==
X-Google-Smtp-Source: AK7set/wZ/4G9KK2Bfk/+low7BMNDEqiBsEDPx88cLIcs10zzu6byiGS6x8pRQggQv89IJFNMHAoew==
X-Received: by 2002:a17:906:4ac2:b0:92b:7e6a:bca1 with SMTP id u2-20020a1709064ac200b0092b7e6abca1mr1597578ejt.20.1678777688673;
        Tue, 14 Mar 2023 00:08:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id cb15-20020a170906a44f00b009226f644a07sm692851ejb.139.2023.03.14.00.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 00:08:08 -0700 (PDT)
Message-ID: <e2d2bbcb-409e-2b13-114f-ee17a3f6c894@linaro.org>
Date:   Tue, 14 Mar 2023 08:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: ipq8074: add compatible fallback to
 mailbox
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230314041515.15883-1-quic_kathirav@quicinc.com>
 <20230314041515.15883-4-quic_kathirav@quicinc.com>
 <4deec4ba-a905-6460-1d1c-e5a0abd042fc@linaro.org>
In-Reply-To: <4deec4ba-a905-6460-1d1c-e5a0abd042fc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 07:45, Krzysztof Kozlowski wrote:
> On 14/03/2023 05:15, Kathiravan T wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> IPQ8074 mailbox is compatible with IPQ6018.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> What's this? Not even a dependency for something as it is last patch in
> the series. What's the point?

To be clear - that's a NAK.

Best regards,
Krzysztof

