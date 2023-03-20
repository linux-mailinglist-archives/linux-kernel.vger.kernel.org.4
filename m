Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE20E6C147A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCTONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjCTONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:13:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D17FF37
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:13:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so47350034edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679321619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KhLTwAPbhzahu8cLvqWPKYphjoJMZGlrXReeRqVQsY=;
        b=zsXBiB7+F5D7QTP+fOLUoSvKOjZYiP8Ene0Sa6MTBgICONnAM4d6nFV7vghsZKF0yE
         3caHH1/En3W6wlfXQGmVM8scKu2jLFi2LvsO6ymxwZ2Ct6+vRXLRnX8F6hXYve/Ytalc
         YdZvmZfvlG6VbYE905wVnL4Ua3FfYzUo4VZ8d58OliaoPMhLXVJlIOrvkZkywfkqmEkm
         1yqAWmoRwrmnzAch1Qb5h+BECQ3JzxfknD8Tm3jiAaB+MHb0Cy11U26LMFKy3H34jAXL
         anjOL9JOAQc36tAHUSsMa2CFxFmxN+MhHiFqJZtS88/L0NHg8+3+b4M7vNctFcRQelqx
         vTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KhLTwAPbhzahu8cLvqWPKYphjoJMZGlrXReeRqVQsY=;
        b=T8IxuFifshdFwq2J3bL9xskmiw1Yi6xIU9ide8h7fik03e67JtlEzqlU6qaaPanrwr
         k9HLuxWfp7KveUzFAU8WnIlFqoIJNq+/MHqYzzWKxO9L8PkVwuM8NyZgYk/iGm2OaKCq
         pm8x6TdzLCcLBf7xIy0FYDLAXHCcyQitpOQsXXbwuUBpHjTD2OwMJ0LfmpVG4K+boMFj
         38dg/UqrLvtpBAXSytGYvXmwLjj6GbN8ydr0VNeu5UoPdvHlkBkkoNwwtC8DF7h0xWLL
         z+VCjvc35uHNi8U9K+Z9waWgZieKE5QUTQuYa+vHVGCADzLMRj2kd4sB6ZL/5TGl4GgZ
         LGAA==
X-Gm-Message-State: AO0yUKXnpQth2Kn9+ynaqSsb91+tNCumPX4VxG7LMJEAn5lzYeZgjkkL
        d3D/D1Uoy8xH4PGyS73gtbApBA==
X-Google-Smtp-Source: AK7set8X8htMZpH5R7tt01dJroDyS7MQHlNZpNqPtHpJNiqqqr40KShtWPW6JhWp7HCt72I9A8LZ7g==
X-Received: by 2002:a17:907:a04f:b0:931:51c0:7300 with SMTP id gz15-20020a170907a04f00b0093151c07300mr9180387ejc.77.1679321619259;
        Mon, 20 Mar 2023 07:13:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:458e:64e7:8cf1:78b0? ([2a02:810d:15c0:828:458e:64e7:8cf1:78b0])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm4514553ejc.29.2023.03.20.07.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:13:38 -0700 (PDT)
Message-ID: <8e673c47-5cdf-a5ac-5999-ede025dfe63e@linaro.org>
Date:   Mon, 20 Mar 2023 15:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/3] dt-bindings: mfd: qcom,spmi-pmic: add nvram function
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-4-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320135710.1989-4-johan+linaro@kernel.org>
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

On 20/03/2023 14:57, Johan Hovold wrote:
> Add an 'nvram' pattern property and a reference to the corresponding
> SDAM DT schema.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

