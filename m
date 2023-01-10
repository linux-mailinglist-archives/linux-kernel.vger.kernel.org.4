Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741466421E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjAJNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjAJNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:42:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A181A3A6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:42:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay12-20020a05600c1e0c00b003d9ea12bafcso6496020wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGbKZAPhkZ2R7/9QlZ2i8Jsx/I0EQ9QpVPkx3ehuGKU=;
        b=m5K2jGbW11x7SiC4SRJdU1Xnu+QTxJ90yOvfQfXbIllKWLnxPluf5cXagaUCcSB8az
         KaufKo5VuxhoKpth9JuokSmW9zYHpPocM9eJm64RiQWwObporx1qaVR97F9dO7OGh8qu
         ELkkfLVc5l/JUHnNtPaDm7N0m5ny81EJZgyTSKiY4F0hgyIQaWi0Fw1dW/Wjj38qjZxJ
         qnIyNNiCnX2BYKMRcqQlgRwsghqzaZ7UGUpiVEqIKSui5K3o1Cjyy7EHankS3Y/4iIcw
         JZv+qu30CMRIDZwKDKav6dqqYucgSR96R0tkkRczwGANkTk3DV4iM8MazTX8m1Oi9jAN
         aezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGbKZAPhkZ2R7/9QlZ2i8Jsx/I0EQ9QpVPkx3ehuGKU=;
        b=a7oDmKu9WlbCjWMs4yRK3I5FQLKXzK55Cs00Gq6YjccdbSxzXyEs8Kcyhxy1zawfcr
         2UegLpKcWdqH6INgfq7/PPMmAjvUOp/3ooFLwY5WKXCXoFnIX5BfgHVgOutYbDwBWxRf
         e8repRQpzHeMX7ubZvV0YRfbjiWLHRH1bUWv+NsrwjqrM888p09KMEQvsZxZaQKh1wBG
         xSJApT3rv2ZoUT9aAhk5PLyOymGBLDwOSfCNLTu/Qa+RBELQsiW9olhdt2Fx7ZzFeGF7
         g66nEW5Q2nPCsEl2FHFtiJk5ig4NMTgFJtPGCRQWRWW3AI9ZGChVaO0UfcZEJjaZY6ql
         X0DQ==
X-Gm-Message-State: AFqh2koP5KPVscOz9L92WSQ/F8RYCFmFUCSe0FCcdhhh9ayku+N9xhTu
        PKh/fHv6vSl+D329nf888PxJjA==
X-Google-Smtp-Source: AMrXdXvfbnzV+4koE/3oFipxv/xZcE7zMLQw61KlbwJc16F86WyQagi21JYo6QSrnCpQfOuajTcLew==
X-Received: by 2002:a05:600c:348b:b0:3d1:fcb4:4074 with SMTP id a11-20020a05600c348b00b003d1fcb44074mr59542962wmq.22.1673358143611;
        Tue, 10 Jan 2023 05:42:23 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p21-20020a7bcc95000000b003c65c9a36dfsm14576725wma.48.2023.01.10.05.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:42:23 -0800 (PST)
Message-ID: <bde66389-619b-771d-1956-43059f8e4d5a@linaro.org>
Date:   Tue, 10 Jan 2023 13:42:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: Add msm8939 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-5-bryan.odonoghue@linaro.org>
 <6e594438-843a-d03e-5276-d6316a9dc2c0@linaro.org>
 <88d66834-ca80-888b-e56e-7694e84b6eae@linaro.org>
 <411a1a02-568e-3695-0a24-0681fbe9f265@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <411a1a02-568e-3695-0a24-0681fbe9f265@linaro.org>
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

On 10/01/2023 13:24, Krzysztof Kozlowski wrote:
> On 10/01/2023 14:14, Bryan O'Donoghue wrote:
>> On 03/01/2023 09:14, Krzysztof Kozlowski wrote:
>>> ../arch/arm64/boot/dts/qcom/msm8939.dtsi:1825.23-1842.5: Warning
>>> (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format
>>> error, expected "7824900
>>
>> For the record the driver consuming this dt entry requires the host regs
>> to come first followed by the core
>>
>> sdhc_1: mmc@7824000 {
>>           compatible = "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4";
>>           reg = <0x07824900 0x11c>, <0x07824000 0x800>;
>>           reg-names = "hc", "core";
>> }
>>
>> If I change this and the msm8916 to
> 
> That's not the solution. The warning is saying that unit address does
> not match your reg. You need to correct unit address.
> 
> Best regards,
> Krzysztof
> 

Is it not the case that the unit-address should match the first reg and 
that the first reg should also be the lowest address ?

---
bod
