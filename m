Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B037A657666
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 13:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiL1M04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 07:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiL1M00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 07:26:26 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD5EA3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:26:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v23so6266027ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ub4ATzUfOQ3XmwVarg+cJkngzbh6iXKnfcPqJ9I4RlY=;
        b=JQTsGEnoyxqTgLMb3BsXtAxnqxGelXXtAenB1eBJeZbzHYymRlyju3DIpRW+PcTFZp
         kljrBbN9AXs3aTwyTPG0ALjls2UfO9yPRMM6sGkW3jX7UaRpvUntGTRTHUpN1GpOoaAV
         cjgbg7+oFkAnQVA1vJD/YeBq+fhk55c4bknUjgSBMSoJQt7OqZplK6gdoOpgTnwi2q0w
         P0egTcxMqtR+45w3aUzERJfPz86cfwATnvcBqXav3x5ee4OD3gortep1QKoZUL3uFVit
         WxM3yLB8DThZszAM/fY1p/xMbS19hyTdRMBbYx7q5cU8JcRZhjBcSzfkZKrkC0V/vjDf
         8YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub4ATzUfOQ3XmwVarg+cJkngzbh6iXKnfcPqJ9I4RlY=;
        b=qBku2K1kIRyvCzIIlM3tHqsmaJt5e984MWDi4xxv+AKrl4IwHDdJfxPUJMpksUbPml
         WD8fkAOa3LEiSGCL+63ai6AG7Nt74a1TaPsNKsrD2UeddpcuVGLTQ18MQ6pgDwNP8pGj
         2fq28ppyN9w9LwxdHo/8d/y426FIVwwdaStt4KHi+XO5NeFvDsVzvOkGR1RzUFIKXEEt
         vKJqaQy+oKb+aMlUYp185/uLGdeOmS9KTDdqmCRg5l57JFyRo6/u6osB+BwBSby2dykl
         g/yr+F0h89AH9XOSqcJzXMwlr5JyN5GhZ9vkDVaIrF3GmFCKzxsWMI2DtIo0uA31zRXd
         HChw==
X-Gm-Message-State: AFqh2kp/W3etcv+j9MpMAFPrNmqQrzgteoMaIFrBfR8iWehC35Iy3LhX
        kPzWZEAkDYseZand8RwqtlyqAA==
X-Google-Smtp-Source: AMrXdXuFOgavTsz6/VjUbcdE+BABkvmBsLjBmuASv+YLKGodRKLJ5a+n9HlkS7L6YG3pZVFop41hhQ==
X-Received: by 2002:a2e:998e:0:b0:278:e50e:9b38 with SMTP id w14-20020a2e998e000000b00278e50e9b38mr6272779lji.5.1672230384061;
        Wed, 28 Dec 2022 04:26:24 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id o10-20020a2e730a000000b00279ebd80387sm1916232ljc.133.2022.12.28.04.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 04:26:23 -0800 (PST)
Message-ID: <508441b7-5af1-ee58-4787-9e3996fb16da@linaro.org>
Date:   Wed, 28 Dec 2022 13:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8350: add missing
 core_bi_pll_test_se GCC clock
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221228112456.31348-1-krzysztof.kozlowski@linaro.org>
 <d2e303d9-3ac4-f574-680f-4f5ccbf5ed13@linaro.org>
 <5001001a-203f-e832-f916-ce483b2d8ea1@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5001001a-203f-e832-f916-ce483b2d8ea1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.12.2022 12:55, Krzysztof Kozlowski wrote:
> On 28/12/2022 12:37, Konrad Dybcio wrote:
>>
>>
>> On 28.12.2022 12:24, Krzysztof Kozlowski wrote:
>>> The GCC bindings expect core_bi_pll_test_se clock input, even if it is
>>> optional:
>>>
>>>   sm8350-mtp.dtb: clock-controller@100000: clock-names:2: 'core_bi_pll_test_se' was expected
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>> Is it even going to be used by anybody, or should we just drop
>> it on the driver side as per usual?
> 
> It's mentioned as possible parent, so there might be users somewhere...
> Or you want to say that other binding and DTS users cannot use that clock?
There's no driver (even downstream) for a supplier of this clock and it's
(probably) only used for early validation by qcom folks. What we're
interested in, as far as debugging clocks goes, is handled by debugcc [1].

Konrad

[1] https://github.com/andersson/debugcc/
> 
> Best regards,
> Krzysztof
> 
