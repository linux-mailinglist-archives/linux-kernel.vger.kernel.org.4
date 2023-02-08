Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099AA68E96D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjBHH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjBHH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:57:33 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9900E051
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:57:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13so12699077wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHdEEbuiyGXuJqK27P1PHI1QnjGoBHWfXyeeEoL3wJI=;
        b=x4VrFGbpQ7JNGyMEjjdjc7T/aI00idY8uUvx7sfMbsZ4nY/jrODkSzgV9f49HUJj5Z
         IPw2SbvHardpk1eDcHP5zKYFFnvckblxQZQEMtDUsGAxGGOAjKEFk5IISv2vsFxN3T5a
         gAjtWfZCVaeEaATUXT2XyJZoswJHu3R4x10odU/IwY6wVVp73Aee/YZ7gk41TnK/jA94
         V3J3WzJhaBqMxDk0HV5u9j1T/5h6yJjD1UOLKm1lbhd7kuO5xe6foUmC2xaDtYF9V3p3
         j8dOsN8j2afm0GjfcIR2SxugvpHi2CvDfolkB3mJ6V3CKEw5osmRybRXpWhnbeu3iHcY
         3Cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHdEEbuiyGXuJqK27P1PHI1QnjGoBHWfXyeeEoL3wJI=;
        b=R6Eq4MPDNGUnUYC1KKLQmCgyHy5cZHn5owgKJlPlLRPEhhDdG39ReLDlLji86bjafx
         lsafu9t4799GnTBwKusss8shUjBVMeHga18+FNX5ZlGUkXsYTQzUOdVYGRMGi4fb/j++
         ymFvAfQBD47cBTNaWDi/JHT5VjhilnDXgCvsTEKMqm2YnyZr/P+9zqcA1uFIKHdAhzHP
         prnE6ee31MPIhHMUSHv/i1SdHjpThbxw/vOkqAIu6/VYeS/r8r4Y3bX0zUM8GrReGXzg
         b1EvFr3MAxUKvTFdbZYHi/tiCjKbrESi5KpDMDcN2b5nWti+Jhc7ut4Ye5WoPNBe7/LH
         RChA==
X-Gm-Message-State: AO0yUKUmy6Li228OHaGausOppXjpK6qGN+qfCVeJfDDbpT/UBENZOOTf
        Vh4gPlwSdDuAJcJsWawuz5n2xg==
X-Google-Smtp-Source: AK7set9iIl4e8crahaQ2Zidc4dX7xZdna97uQblzvc3bl/bCN832Jk/IdpxvpEl+xXlVRXsYXGJc1w==
X-Received: by 2002:a05:600c:a287:b0:3df:fff4:5f6f with SMTP id hu7-20020a05600ca28700b003dffff45f6fmr5697696wmb.36.1675843045484;
        Tue, 07 Feb 2023 23:57:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003d9aa76dc6asm1228421wmb.0.2023.02.07.23.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:57:24 -0800 (PST)
Message-ID: <de5505aa-ce6c-1164-ff67-ac883268ad72@linaro.org>
Date:   Wed, 8 Feb 2023 08:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5332 and
 its variant
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230208055709.13162-1-quic_kathirav@quicinc.com>
 <20230208055709.13162-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208055709.13162-2-quic_kathirav@quicinc.com>
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

On 08/02/2023 06:57, Kathiravan T wrote:
> Add SOC ID for Qualcomm IPQ5332 and IPQ5322 variants.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

