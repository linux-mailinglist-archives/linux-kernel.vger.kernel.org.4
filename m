Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DAD62BBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiKPLZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbiKPLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:25:24 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC302E9DC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:16:06 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s8so11824605lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4WBIwS+e0Xm5uyQlYh9tAiUVCv0D4baBJLEBI8dHJk=;
        b=pSwwcDEUtgfR8wFYB8izMtbcfqUeYpQ/sJUxupQJojYeadasdZ+bory8SBYJAUQTib
         kxmME6TmyJZwP2hkJBiuuPeZ9Cafwlj4ePoRskJAtXKbalkhZ6xzgn37bUWG+mFji2Xv
         zE52VgWyWsADyfN+seGr598fjR/JB+iY6XaOROR9iziP/nBEQVHq8tlHJxywQ4CnaLRy
         8gHR0XmIdlMQFzokKFwwXzEbIgrSdqGVdHQl6vy1/MjtQaeWckS8R3QZh9TJ5dtJCjJg
         3i49OB0t7cwAyRiwhz/8gXyQ2G3QK33IsXcZQ15eMqJdq4DR5xXyi6iyfttLkM/V6vWz
         PCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4WBIwS+e0Xm5uyQlYh9tAiUVCv0D4baBJLEBI8dHJk=;
        b=qFwXN0INunMhmqzjaLvuA6RQ/snxOm9oWLG6rQ4h5WLknRGvHctc1rmsvoefGQ3nmT
         62w6KYIYjKJWV0WBCnAqBX4GaLVqZiJ9OwMHrIRihBDI4K7pZbFnI/Oxs75W3w7MGntJ
         OSyqZOu5ABkyZWUUZIFXwTuwao8tgauvSQeFQd19NQoif4B8QmZgMn8kG7Q0soB8OqeE
         XpbcDWxdzF7EQTYMpiDo2lTu9K96/tSSvNUVGmxE8Z2SS2glRSndd/MbxVGdYc9ZA5I5
         gfpkzkLlefnnDT04bfnrgHeAJY2M+6TC3lj7/iw6/QUkG4onroBvmZXbvOgGVtwd4snz
         ehZw==
X-Gm-Message-State: ANoB5plPforgqWLbG6beoa9bQ0BvMj4wv2I1odVQAlYC0tSSoaLROWFn
        +0+QXnn7ERTGEYcwQwwlZHdN0A==
X-Google-Smtp-Source: AA0mqf5GQ6Nx6BtaaI5H1IC5VALIUgM+h+J9tdQBxMDJtFg0ZKH7Ts29H0ZALX7WGRcwSwY+xSvLLw==
X-Received: by 2002:a19:750f:0:b0:499:b108:947e with SMTP id y15-20020a19750f000000b00499b108947emr6809900lfe.143.1668597364398;
        Wed, 16 Nov 2022 03:16:04 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m9-20020a197109000000b00497a61453a9sm2535491lfc.243.2022.11.16.03.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:16:03 -0800 (PST)
Message-ID: <b68c89ba-63dc-0b03-e6e9-51d50a598d3f@linaro.org>
Date:   Wed, 16 Nov 2022 12:16:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/7] dt-bindings: mfd: qcom,spmi-pmic: document pm8010
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-spmi-v1-0-6338a2b4b241@linaro.org>
 <20221114-narmstrong-sm8550-upstream-spmi-v1-2-6338a2b4b241@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-spmi-v1-2-6338a2b4b241@linaro.org>
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

On 16/11/2022 11:11, Neil Armstrong wrote:
> Document compatible for the pm8010 SPMI PMIC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

I don't get why this is not part of previous. The previous patch already
documents 5 different PMICs in this file. This should be squashed.

Best regards,
Krzysztof

