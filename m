Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9116B6862E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjBAJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjBAJbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:31:01 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9147E61853
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:30:52 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so869899wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k94zumruKImHmohA2MCxzYyvVQ+5OXP3k3ovuZNVCL8=;
        b=bPTgjVJy06j+Sg6PHe44wqBpmp4Mw7Gg+FNxXzXeQZzZYvBAoLttmqF4XsSMitZFM0
         JY2sNM4ApmSOCaQeEItBiL144BCrtPc02HKHp+qkAs8fibXK95Bouijds8FHy5bVzZME
         4Ez4tD2Iq8ADlqpZjwm5AbY/gIF+8eleLC8fXR1yCz1hLRcuc8KuWiv6kMpjxrriu4yD
         ewddxNYpQwA1RnsCRXOj/DlxYWWzGhixlTOvcORGNzIeVfe/RhjjfARM5srSPaZOeUUQ
         cEweqB06hkhY54Fv+6+IhE7Z+jKQAHAz+SuHT7KaRd7aBXpzEKVT/gp2NH3p4yOrU1/Z
         x1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k94zumruKImHmohA2MCxzYyvVQ+5OXP3k3ovuZNVCL8=;
        b=ptXYffiYwEgk7fiz5g1GGUtqsZHJNqBiQd6/bruqCYUP7+9xbmvGM+sI4tlCbebYlK
         uclB7P8GKk6fU/MTzobXQ/gL1gNBf9ye0g0mOsP5p6KDRtinrYpVVSsB3nSE7ocK/zUt
         7WTHDjAEwmEZwSS5iPKJ5vrzOfAQlr/rEwGcIlHmitxPm8cJcy7cnbt4uGYXK1SLj/L1
         W45ci+y9o5G5EFi/7x+WwqjGP1vIa6Ukkr37bh5Di/GT6M7wfK6QfNbUEIodaUCnx9lT
         Wrtegu6XXqYIc7EiRsd5FKCgjxJzaomlcnY5dBp+5nYc5ePd/vz0LzXsvRjvuSMcjIlX
         4jUg==
X-Gm-Message-State: AO0yUKW8jaa5dB+jwZjvShAB9CNgzrwNki46/SMjVESw53lf8wEq6XnA
        uD+d6OKrLojQNMlVZMdrgnMqFQ==
X-Google-Smtp-Source: AK7set8BjfVMDcf+vtGiTCysZFFZ1WdyXQN4Nn32KHcxiP6BxS+StcNRGlY7VqGFshRFSIwiBzMffg==
X-Received: by 2002:a05:600c:4f8f:b0:3cf:8b22:76b3 with SMTP id n15-20020a05600c4f8f00b003cf8b2276b3mr1446937wmq.0.1675243851071;
        Wed, 01 Feb 2023 01:30:51 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003daf6e3bc2fsm2438316wms.1.2023.02.01.01.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 01:30:50 -0800 (PST)
Message-ID: <5b51421d-a46e-c88b-9fa0-1fa3650f4a6d@linaro.org>
Date:   Wed, 1 Feb 2023 10:30:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 5/5] dt-bindings: tcsr: Add compatible for IPQ9574
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230201090529.30446-1-quic_poovendh@quicinc.com>
 <20230201090529.30446-6-quic_poovendh@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201090529.30446-6-quic_poovendh@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 10:05, Poovendhan Selvaraj wrote:
> Add the tcsr compatible string for IPQ9574 SoC
> 
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

