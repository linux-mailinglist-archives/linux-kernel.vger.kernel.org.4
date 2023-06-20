Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD47374CC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjFTTAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjFTS7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:59:53 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17324C2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:59:52 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b45c289615so67147441fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687287590; x=1689879590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pUkoASnKDVlNRbghMhxgnOUer5/QTr4MEdQPSjInRM=;
        b=A1SgxJsLuu4gRO/+ZsKe4oQwLXr96Dqgko66fMBvjLK32Vp0aOgQl150Om5Py4zLEK
         4VEekx2N0yLkUI0KGoU1jbDU43Gr/a3oony//zKTExijueVasseFR611zm9x6Nll8UBA
         tG9pQPHiMkbE58Lq8bAeMA5d8NzD21mvDvkhxV/yZqomkqf456g8c7KcUu4oLKnnB9UR
         p7UrJ9KcIv4aXuVmzuUJhMIbvD/xNxvNJsmsfPdwiIlvhiYeQAsLD71/xEWlfTrruXtq
         pYwfzHtraUPOsDVdlwBEqSjiBkAtWI4e0arZDB7xcCSCv9oPSIORZMtRvcAEIQ1E43lG
         tGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287590; x=1689879590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pUkoASnKDVlNRbghMhxgnOUer5/QTr4MEdQPSjInRM=;
        b=U542wGoeWqorArXbt/Z1XDt9A029/S4URSBUVomvkASF0DUGcsX/7tqKgmtVReOwUq
         SW8P8gyiIEFc+NNGRF5cdZJe9pB2cJDm7ZTMmQOO8GdnqdSfEPJsn1jxlL7YLT7wWaJA
         0jJq6zjHGV/KFzCss4jdw6+qCPx/iMdVaXWx7CyaaOqmVyyYvJrrELPO6i2gm3cCPZ+w
         5Bgk8ffU0zu1Xv0n2Ry1K+Tkp0B6iM3jZiyEt2Wd7iRMOi6ItoDShXz5qHjEuA1nD5Z8
         T0cydmbUuf/2MO1ofssqvGggMtON7rN3rAnA0kgoXwGqnVrhkG18UXBEn4MGFOe4bV5k
         QyAQ==
X-Gm-Message-State: AC+VfDy402zRgq5/2Ug5CDhtxwYbNOrlqbVrbYSw+niNsBlGPD9sL3cJ
        rBh/J5EBm8XBFOCKB/IMKAIWow==
X-Google-Smtp-Source: ACHHUZ4E+w2dp1HuPb0wqbUE0OT8L4urfStbwm6IK+13DNhi9a9IxNo2qwHdj5AO3Sp78CfbPyMchg==
X-Received: by 2002:a2e:a0d8:0:b0:2b5:7f93:b3b3 with SMTP id f24-20020a2ea0d8000000b002b57f93b3b3mr1649596ljm.32.1687287590246;
        Tue, 20 Jun 2023 11:59:50 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id j6-20020a2e8506000000b002b473358e7asm516739lji.108.2023.06.20.11.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 11:59:49 -0700 (PDT)
Message-ID: <1cf4af9b-b40e-9e1a-47e4-40c6334fd410@linaro.org>
Date:   Tue, 20 Jun 2023 20:59:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Don't ignore return values of
 regmap functions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230615-topic-bwmonretval-v1-1-223bd048ebf7@linaro.org>
 <3364339a-908d-7ab6-7d62-a05ab8e67739@linaro.org>
 <20230620181451.idesqpkdyb2wa65l@ripper>
 <3b1b7849-c116-a9da-5c5c-a520c10a521b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3b1b7849-c116-a9da-5c5c-a520c10a521b@linaro.org>
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

On 20.06.2023 20:15, Krzysztof Kozlowski wrote:
> On 20/06/2023 20:14, Bjorn Andersson wrote:
>> On Thu, Jun 15, 2023 at 11:26:13PM +0200, Krzysztof Kozlowski wrote:
>>> On 15/06/2023 23:12, Konrad Dybcio wrote:
>>>> As it turns out, not all regmap accesses succeed. Not knowing this is
>>>> particularly suboptimal when there's a breaking change to the regmap
>>>> APIs. Monitor the return values of regmap_ calls and propagate errors,
>>>> should any occur.
>>>>
>>>> To keep any level of readability in bwmon_enable(), add some comments
>>>> to separate the logical blocks.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
>>> Nice coincidence, I just had some talks with a friend about uselessness
>>> (IMHO) of regmap MMIO return status checks.
>>>
>>> Sorry, for me most of this makes the code difficult to read for no gain.
>>> Errors are not real. This is some artificial problem. Solving it makes
>>> code less maintainable.
>>>
>>> If we used here readl/writel, you would not add any checks, right? Then
>>> don't add for regmap mmio.
>>>
>>
>> I agree, the mmio regmap interface should only fail because of bugs or
>> things are misconfigured. Would be nice to capture that in a WARN_ON()
>> or something...
>>
> 
> One choice could be to have for entire functions doing reads/writes:
> 
> 	ret = 0;
> 	ret != regmap_write();
> 	ret != regmap_write();
> 	ret != regmap_write();
> 	return ret;
> 
> and handle this in the caller somehow. I don't think that aborting such
> chain early, just because regmap mmio failures, makes sense.
Meh, perhaps let's just forget about this patch.

Konrad
> 
> Best regards,
> Krzysztof
> 
