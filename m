Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD96632445
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKUNuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKUNud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:50:33 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05260E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:50:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id be13so18931536lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAt4YvIoyvYsFbo41kBZWP010rGTy75faIZV5/NcsYg=;
        b=gzXIwUVXy1V7XBQQSTVPLPMyWs9eNUDdabh6yxCweLVXP0Y6xCGvLuky1A0pLGKMjt
         EctDlYTbYh7atokrbgwkF3m2WoN7dkhcH7eiHwuD6hIwTy1XYNrBtCasY/E1VSWfLZsA
         qROPXRiGVWnFpDVL1oWnB+qU1HMkJyretUNyK0pF9ynXE8ztKFR2X+MKbQSWzG+etLcv
         cd+tK5t5IdGz8GGE5nuKL8KVDePd/hPi3oUWcbnV4YrMIgtkL3zDWxCdDFvXFVWC6aYo
         SD28pL5bCy7dSkI2BrRaxkrt/OjbWOmyvPF7MksBJExMLpXWvMN/Fgoon8cJfwkhmTHZ
         wzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAt4YvIoyvYsFbo41kBZWP010rGTy75faIZV5/NcsYg=;
        b=pZIYjFw2whCBrfOIhZVJNQAizbxrOf52RdSV/XfrdCKmY4pn9RjNb+5uyEqeKNzF4X
         qwwIJvqsHURNT5oHFeaUAhlTMnw2qPWI3UznxakOmCqeT5fb/gErdgMY4X7xkeKjMzav
         YQtZgXiEGwI4uU+cWDA2+mq44PiRDunUIq0UwrbLE56QVYY7eJ/sotu/9uYH6oeXlbkP
         lrlXT2GA4bi0Sa6cTS8i+O7PuY99ZcqPZso6r4jDK9MW0fXXIpemF0PiTSwAcZISzAaY
         B6HQq+VzThhHtIvBPeWyQmcVukVYxt4dXA9MHQ3nJS+1orFslCxWCsufId+YFZPLlqBl
         +anw==
X-Gm-Message-State: ANoB5pnL5f1ai1LUVq+EBlSXSikWIlGW97UercYdQA5BlEg5JoIA4NOP
        rAqu/xtdsfmBZvDJZTwSYdI/pg==
X-Google-Smtp-Source: AA0mqf5TYxFBqqdBHMjFqcmXaZTC/TwSnfK8gpf3JY5xoq27k5W77KUczLzcmKQ1hGAgM6fJhOjrew==
X-Received: by 2002:a05:6512:2109:b0:4a2:5f7b:840a with SMTP id q9-20020a056512210900b004a25f7b840amr3125371lfr.577.1669038630507;
        Mon, 21 Nov 2022 05:50:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 21-20020ac24835000000b004a2588520f5sm2027721lft.166.2022.11.21.05.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 05:50:30 -0800 (PST)
Message-ID: <e0835b03-c409-ef0b-501b-176251bc1725@linaro.org>
Date:   Mon, 21 Nov 2022 14:50:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 03/10] arm64: dts: qcom: Add pm8010 pmic dtsi
Content-Language: en-US
To:     neil.armstrong@linaro.org, Abel Vesa <abel.vesa@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
 <20221116103146.2556846-4-abel.vesa@linaro.org>
 <76560659-7c90-3846-c250-24bfb072ec0e@linaro.org>
 <15ac1d06-5da7-ebd2-92ff-764c8df803a1@linaro.org>
 <3a84d45c-6550-7ae2-2511-9f61d15894d1@linaro.org>
 <081732c9-5e8e-b68e-c2bd-20724ca1a5d5@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <081732c9-5e8e-b68e-c2bd-20724ca1a5d5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 14:29, neil.armstrong@linaro.org wrote:
>>>> Any reason why this is licensed BSD-3 clause? It's not a recommended
>>>> license (2 clause is). Same for other patches.
>>>
>>> Probably a bad copy-paste from other existing files.
>>>
>>> While checking, the majority of arch/arm64/boot/dts/qcom/pm*.dtsi uses BSD-3-Clause
>>> so it seems this was done for quite a while now.
>>
>> If it is derivative work (of upstrea, downstream), then you might have
>> to keep BSD-3. But if not, how about changing it to BSD-2?
> 
> It's definitely a derivative work from upstream pm*.dtsi files with BSD-3-Clause
> licence.

OK.

Best regards,
Krzysztof

