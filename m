Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0709D65761D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiL1LzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiL1LzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:55:16 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7F10FDA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:55:15 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id p36so23285649lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJcl46MI5RR8btKw7j2dJfA3w1szrqjhaKNcGHRcG5Q=;
        b=zS5iBp6QPRq2LmndJwyrn7LjFwzIsXy4sjKotWIEc6iYEzWksnWigGMnDIorBX5/K9
         W5Aw7q+GmPVIIVGPeOeRIzqgmYXSHr5TKZ7j6DavEBEHEVTFFYM3Y+jepsVlKxgeHD3T
         f/CASpolMuUooCQysl5ddrSJLf6aAt+a03+j2mBI31fZfTe5Mizb5LmDqPROuNfBHxLQ
         7AKJsvwfHd/cQakmpLVhbUGvtV6CGldaWhtd0RxmGGe45aVOO+8e0m685s1k96eoIZto
         GVs1IhgcuOyrJyB3fi8wh9/Ny3DnqOwCtP8iXQNW3KhjQoXRoOluaqSD68itrZbssj5P
         YmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJcl46MI5RR8btKw7j2dJfA3w1szrqjhaKNcGHRcG5Q=;
        b=0XdFBQFnybPhEKW6Qd9pQl10CSL4++bjZCzTyaEJl1svaj3AOjtHmqUMGl9N6zcLAH
         IUZ2yzDDTCl88xv9/Yd5dMKDt6urrh3Wst3r9I0KpyfurclZl2YI+TbdE1igcnh1hSGd
         th6qmw3P+n9kWIt0HGCE/2T9QRjkyFL8L1cC/w5JsPG/0GV4b+x/N72R5IFcSoR0TJLi
         4H664l3tPiwS+AABDY8oTFRfEHuKvMfOrd+ELe+muvjJLEhyDBZlRuHWTB2v7DLZB978
         NgIt1PFyZHoqIABOpZMUSOKr2GgWN6FHeH0huMGIOjHhxHUJSD/YjoLZGwUEOdApDG1i
         uA1g==
X-Gm-Message-State: AFqh2kor68QoTxIwPG8e5HRrM5f4c6bN+ZtlzasAxOxYfKB0Cnt2D/Jh
        /X7bsx9vh/0QNsDHnAv3CZkjiQ==
X-Google-Smtp-Source: AMrXdXvfsXmeDlz4TQc8GxqaNcnOs4agF62kEE7aXeTk2NJaTudG8+xpW+DFjbxZCBzv40gTbOLHVw==
X-Received: by 2002:a05:6512:3135:b0:4b6:fdbe:773d with SMTP id p21-20020a056512313500b004b6fdbe773dmr7334264lfd.43.1672228513757;
        Wed, 28 Dec 2022 03:55:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o20-20020ac25e34000000b004b4b69af17dsm2663436lfg.214.2022.12.28.03.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 03:55:13 -0800 (PST)
Message-ID: <5001001a-203f-e832-f916-ce483b2d8ea1@linaro.org>
Date:   Wed, 28 Dec 2022 12:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8350: add missing
 core_bi_pll_test_se GCC clock
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221228112456.31348-1-krzysztof.kozlowski@linaro.org>
 <d2e303d9-3ac4-f574-680f-4f5ccbf5ed13@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d2e303d9-3ac4-f574-680f-4f5ccbf5ed13@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 12:37, Konrad Dybcio wrote:
> 
> 
> On 28.12.2022 12:24, Krzysztof Kozlowski wrote:
>> The GCC bindings expect core_bi_pll_test_se clock input, even if it is
>> optional:
>>
>>   sm8350-mtp.dtb: clock-controller@100000: clock-names:2: 'core_bi_pll_test_se' was expected
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> Is it even going to be used by anybody, or should we just drop
> it on the driver side as per usual?

It's mentioned as possible parent, so there might be users somewhere...
Or you want to say that other binding and DTS users cannot use that clock?

Best regards,
Krzysztof

