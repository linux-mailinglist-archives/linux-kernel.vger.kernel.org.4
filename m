Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4406E620E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiKHLOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiKHLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:14:02 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699117A8A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:13:58 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id d20so20554158ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uEGHhzKbszqMWjuxMkREdBe3r8rfRgsqdTFsuaG+D8g=;
        b=NJ7n5tDHA4FKrxdgKfMSK0JsHzzrPAaCYu9uFHzMI+iTMHzefvTrNRAMFyVDOa+Oke
         SW0pFZ6VU3hfW9BacyR3YDPhurrPdQ0CX54079uUcGSkc5ci79eI5s0ENkwlVcxMumu/
         JMK0yeEhyIe1tAIHjkny0+Qi/juWsPUek0fiUAirUKHM5bRLwFLmsv2ymf8Bl6bDntf0
         tuL1j5f95LjnqRlvoeZsSRpFgW/3+N+1BFu3GByNkq0kjw6j317MtEYkxcg9K4hmGmsI
         eqTliulwoOQVUFWIzLRzamvebCQH9XKIIvLN+FNGAVwTENV0KufYpY8qdPdCT3s/yVgO
         QkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEGHhzKbszqMWjuxMkREdBe3r8rfRgsqdTFsuaG+D8g=;
        b=pYMmomo0mrdAQdD5CDd71NpjVOND4BkjxrttEUe40+e9vgIMpIqqiwINyjzv8Usln1
         3S8EraTEbwBsnv/BIruwtFcepXwykCoVoHjhs4RMjjx/qPKZOVTCn3HL7+wdx/FQSAE2
         lUhKmZlQWUqXDil0HWlxdL3AM7L7anz4giTYf4Jgt4H9PVRgcn7n2dIiAY0xIzwkhbZL
         DIeOiVQvky4Wgef2BzXCOSESZV+EP0m+z99NoVUPBcsDGDlTb5EAxLPR+ABS6ha80z2j
         pJC2wPNj/8IbCJ48ULWLpv80/XRGTm7XugiObAdVRt8MTByNWRKCbmu4HZCSrmO5bMKi
         Hq9w==
X-Gm-Message-State: ACrzQf3k58fbt4+jbUMFPsf/ZvaMOZkiHgd+PkqCWnb0SDFup1+cqqfO
        s7syzEg+/Aa3XIOO8NdYCvThRw==
X-Google-Smtp-Source: AMsMyM5LerxL9uLhjvhqx4rdYZ00h9GhQiY/qVsIX6zMEtdfJqU1Zg/x1+q1u6X6IVzcNyzLs9GczQ==
X-Received: by 2002:a2e:8ec6:0:b0:26d:f909:6b7f with SMTP id e6-20020a2e8ec6000000b0026df9096b7fmr6984570ljl.482.1667906036420;
        Tue, 08 Nov 2022 03:13:56 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id a11-20020ac25e6b000000b004b3e6010827sm685992lfr.66.2022.11.08.03.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:13:55 -0800 (PST)
Message-ID: <37f8f24a-0f25-2f3d-1bc6-de9d5556d18e@linaro.org>
Date:   Tue, 8 Nov 2022 12:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] dt-bindings: clock: qcom: ipq8074: add missing
 networking resets
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221107132901.489240-1-robimarko@gmail.com>
 <20221107132901.489240-2-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107132901.489240-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 07/11/2022 14:29, Robert Marko wrote:
> Add bindings for the missing networking resets found in IPQ8074 GCC.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  include/dt-bindings/clock/qcom,gcc-ipq8074.h | 14 ++++++++++++++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

