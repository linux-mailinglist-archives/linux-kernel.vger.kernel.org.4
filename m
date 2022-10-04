Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB10A5F3CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJDGx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJDGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:53:55 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6942F011
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:53:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bp15so6295734lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rGAbSoZZBNp1Rcgw72Rvq0ko1UR3Gj5wyM3fR9f9QcA=;
        b=kwFzKfO/Y/xaLTNuTEfETEj4Sx9BNm+sDiWRt2m6ij+4hPyAy813ZhUuqvLUihg/w7
         HPzk7xkR2hMGfmCel+qv+9pktl4dzA+64MlhqCGa+F/p7NbEZh0QzqNa0n2U8NJ7JSYl
         RLD1M3i+tTIdVhZXeYovo/mNN9e9hDCpI3SqSrJ6wdLNCsaFbBCaDfKnuq9MCqK/Bjjs
         h3H8w35Hia1srXSv2U5PUeUdXwyFOqqH+VgCKgpifXFPt/Bl+JpeMFGdhpimof7HAkvj
         BkeyjFns0x85c8D1kEv333nbQiwXg2kt/IDzM1ibdZaX0wV50TYNEG8atXflJOHsrI0S
         cbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rGAbSoZZBNp1Rcgw72Rvq0ko1UR3Gj5wyM3fR9f9QcA=;
        b=NGZhaZHnSJ0gzfNnj2M/iyw684aMJtJYhwnYem//o+UnSinEZ3i44L8qTxlO14HdFy
         JlX+WUjGes8EZ92xmau0vOT+EyN3Kjrq9FSNVjWi+BueXOgpwokkpAErEv2aVGguqNBF
         OUVKqP0pa0c+rj2RMT+nfsjDWnX4J1nYXqXwnz8520RhdYMtxA1aEy/P7s/OhLxHbato
         wOqyCQZwJ01NvT+srvDQBO8sBc84B0N55/j6xleUoi7kiZs7Opd+cOf26bsI6QJ7uF3Z
         D+Zrlg9DZqOnF3cyzPMKcgAT9/MHf+pTlyHQodEnGsIvdYysDWSJNRI0t7JSDiDZl61c
         k+jA==
X-Gm-Message-State: ACrzQf03KiQsG4NmCvuPGTDhc3l5I7eA2/MQre07wY5srV69z25s/Zko
        OHmpLewCV9DwvtkVvLBOfXkWZQ==
X-Google-Smtp-Source: AMsMyM5RaCobEe+/0/5LX8MZEHgbJcoU+0O/Jr7Y0adYZZuT5CPllLO9zX3tunOqSvUAvqlyO6sYmg==
X-Received: by 2002:ac2:51ae:0:b0:4a2:4f37:451c with SMTP id f14-20020ac251ae000000b004a24f37451cmr1309615lfk.649.1664866432124;
        Mon, 03 Oct 2022 23:53:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k2-20020a05651239c200b00499aefcf68esm1769029lfu.292.2022.10.03.23.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 23:53:51 -0700 (PDT)
Message-ID: <9664a623-3c58-49e8-1b9a-69335d844448@linaro.org>
Date:   Tue, 4 Oct 2022 08:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] dt-bindings: firmware: scm: Add QDU1000/QRU1000
 compatibles
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030641.29354-1-quic_molvera@quicinc.com>
 <20221001030641.29354-2-quic_molvera@quicinc.com>
 <09f5d364-320e-9ecc-2c2b-68066c61f802@linaro.org>
 <e9c44e3b-b29f-0f47-b822-da0f4f2264cc@quicinc.com>
 <CAA8EJprE-mOOH8VF3m8TRb+0q=3_8NpvzdEAugabDaDbq6FMVQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJprE-mOOH8VF3m8TRb+0q=3_8NpvzdEAugabDaDbq6FMVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 00:14, Dmitry Baryshkov wrote:
> On Tue, 4 Oct 2022 at 01:02, Melody Olvera <quic_molvera@quicinc.com> wrote:
>>
>>
>> On 10/1/2022 4:25 AM, Krzysztof Kozlowski wrote:
>>> On 01/10/2022 05:06, Melody Olvera wrote:
>>>> Add compatibles for scm driver for QDU1000 and QRU1000 platforms.
>>>>
>>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>> index c5b76c9f7ad0..b47a5dda3c3e 100644
>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>>>> @@ -51,6 +51,8 @@ properties:
>>>>            - qcom,scm-sm8250
>>>>            - qcom,scm-sm8350
>>>>            - qcom,scm-sm8450
>>>> +          - qcom,scm-qdu1000
>>>> +          - qcom,scm-qru1000
> 
> I think after seeing all the patchsets it's time to ask the following
> question. Do we really need a duplicate compatibility families:
> qdu1000 vs qru1000? I'd suggest using a single set of compatibile
> strings in most of the cases.
> Settle down onto a single name (qdu,qru, qdru, whatever) and define
> distinct compat strings only when there is an actual difference?
> 
> E.g .we don't have separate compatible strings for all the sda660,
> apq8096, etc. unless this is required by the corresponding hardware
> block not being compatible with corresponding sdm or msm counterpart.
> 

I am not that fluent in Qualcomm naming, so let me ask - what are the
differences between QDU and QRU?

For compatible (and/or similar) devices the general recommendation is to
have specific compatibles followed by fallback. Even if devices are
very, very, very similar, usually the recommendation still stays.

Best regards,
Krzysztof

