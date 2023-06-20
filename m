Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65173739C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjFTSPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFTSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:15:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC81995
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:15:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b45bc83f26so69676031fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687284908; x=1689876908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TT7LlbKYnEwehboHvc1lv2cmLW8z3m28zz/vqMQaYEo=;
        b=w8eZgS9zrDcu6dwURuzU/ck3QSFXvN6548w3Lr0nroLB3jqU7Nt6XZpLEjIBCu2yju
         fBkaUt8Bj8kSVrOkARJ/ejn34nqHUv0gBWHkF4UanVVZuYNOutA/nXq0c0vW3IBFfZ+5
         JFcxpbafZLGGb66h6vHMSTLouVxwtZeO2bbBm4HuA3rjZYxyRBhBLQtp2ozfcqynwRJi
         g4fmT1fjBotZ3RQDgiuLLaTqVGTFQcIXMRyUYLX3NaQz6OH+kIdidn3Ex8yolr0C/XKf
         kEuiFZwPpFEnEj7734YTjrI/8uDEkgFqfBe5PKF60gWSLHoxa5HaTTmO25rLHd5bq3TH
         YPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687284908; x=1689876908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TT7LlbKYnEwehboHvc1lv2cmLW8z3m28zz/vqMQaYEo=;
        b=XmJcuA0fBi0Wl7a0ieMfPlrQzKkr1w030UDKiu5M2Hj+jy9zSobQVOHzuDdPZMmFR7
         s/cvhDndgMRBRqjB5US/XFrG98t63mny2CtmKatSCxqf6sVfU5CsBk3SXyd5OXVUEqyh
         ZNPJtZRKVFmRyX+SHnHB1vfHiA4fSiMCKAtBO6LJ7tzqxJA7P9lfyzHA5rvcs71kEpqt
         /l31CQfcIdJA3RvPAITy2HzFZt5x/UosKVoHXo/LrOfBY1TPkC/BLdqdU82bvIHAcnJS
         8lHdJHw8bi8+lBb04t5/22MMoPZy0gJwQ6/qWD6WAyGlEiEcqHzURkkekc1EbgJ7P411
         LYmw==
X-Gm-Message-State: AC+VfDziNA7pbgqfpX+UKKPi3bX6H+VPUm/JLyOR6SzWjGQ0FOHDaiyV
        a8bISuYMJD1W9S07PTWX3AEG9g==
X-Google-Smtp-Source: ACHHUZ6EVAhy22zj3TocAaPSfTH9MuogtDKKfQXnCB36xMXYe9CXfKFnj8HHuLrada7jN/t8OLe2Tw==
X-Received: by 2002:a2e:9b4f:0:b0:2b4:70da:823 with SMTP id o15-20020a2e9b4f000000b002b470da0823mr5007651ljj.45.1687284907717;
        Tue, 20 Jun 2023 11:15:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906711100b009884f015a44sm1774033ejj.49.2023.06.20.11.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 11:15:07 -0700 (PDT)
Message-ID: <3b1b7849-c116-a9da-5c5c-a520c10a521b@linaro.org>
Date:   Tue, 20 Jun 2023 20:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Don't ignore return values of
 regmap functions
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230615-topic-bwmonretval-v1-1-223bd048ebf7@linaro.org>
 <3364339a-908d-7ab6-7d62-a05ab8e67739@linaro.org>
 <20230620181451.idesqpkdyb2wa65l@ripper>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620181451.idesqpkdyb2wa65l@ripper>
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

On 20/06/2023 20:14, Bjorn Andersson wrote:
> On Thu, Jun 15, 2023 at 11:26:13PM +0200, Krzysztof Kozlowski wrote:
>> On 15/06/2023 23:12, Konrad Dybcio wrote:
>>> As it turns out, not all regmap accesses succeed. Not knowing this is
>>> particularly suboptimal when there's a breaking change to the regmap
>>> APIs. Monitor the return values of regmap_ calls and propagate errors,
>>> should any occur.
>>>
>>> To keep any level of readability in bwmon_enable(), add some comments
>>> to separate the logical blocks.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Nice coincidence, I just had some talks with a friend about uselessness
>> (IMHO) of regmap MMIO return status checks.
>>
>> Sorry, for me most of this makes the code difficult to read for no gain.
>> Errors are not real. This is some artificial problem. Solving it makes
>> code less maintainable.
>>
>> If we used here readl/writel, you would not add any checks, right? Then
>> don't add for regmap mmio.
>>
> 
> I agree, the mmio regmap interface should only fail because of bugs or
> things are misconfigured. Would be nice to capture that in a WARN_ON()
> or something...
> 

One choice could be to have for entire functions doing reads/writes:

	ret = 0;
	ret != regmap_write();
	ret != regmap_write();
	ret != regmap_write();
	return ret;

and handle this in the caller somehow. I don't think that aborting such
chain early, just because regmap mmio failures, makes sense.

Best regards,
Krzysztof

