Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48806DFABA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDLQBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDLQBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:01:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184730CA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:01:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i3so2107093wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681315308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bFr+6SNH273Zl3F8QVF5uj+29BMN+VjrZnzuQ15L4Ks=;
        b=uW5T098cFgLazTILvUupr66h0Wqi9mRwXj5J7u7By2C3AI6WxNq5DNB0oy/tOn3f/K
         cxlAxICdOCdQjqpjrsF2grZQ1LKC42QwUVzNgtdt+WCt28lNIpxAILIIcrCbBkPXbL/a
         iTszzseg6xwOivX+6ZWo+T7vnhO+ZY5H6AY5pHM7RXgj87jh3K36Vi84U/BoP+eebvsO
         /f+k1GcTvVENXso5AnbiX2qrmHb2Abk3fZ/XRoQYRj7JiaOJjhU3lYuY3m7hfT8CqO5+
         WXeLYBRNaZqT83RlJ9bh3Mm3XFNS8zFKYt5mqT8xEP/HYBQiNi8KadXK2O7EDPou27r+
         v+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681315308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFr+6SNH273Zl3F8QVF5uj+29BMN+VjrZnzuQ15L4Ks=;
        b=F/QK/ziKyZHe7pLO3NTv40oHB25HiMMzy3YlSPPgB8WfHVjlKeNMb1+zLzhmaciifM
         BJeYvTZRuyckUTxg21A/OmNgdPnBhI2pXr2KQNyd0twig2vctWMYZrd05xFmfvXzV+ci
         pTYcEf1ISkYZH/rDXu4/isJkPTAuBeuJ8iga0L4emY39rP1lVz8W/DVfzDOxBUlOh782
         ZyNaNPWy179II/V/pHU8MSiL/UCVAGh2TWboQm68dI0spdtSp4xZ6xexLkPM+/FZsv1m
         rmJOmNJ2elOlbafzx3+ae2LKO4HJuvddlIljaFih4ZK9S+UebHbjdR5J0bWmzhbRkia/
         nL7A==
X-Gm-Message-State: AAQBX9ePN+YeHlpuxU5cqgQKMaA+tHzcxylJGgc++O6/P2e4plROR+VZ
        QXZ2CxPbdfLScSbLO4XxaNi/oA==
X-Google-Smtp-Source: AKy350bkplwSrahDJLIpNKaGEYxKRoC0h3LYaUpg0uwuXG86MFRI70iHgwQvCarlq6tRfPyZQOOEIw==
X-Received: by 2002:adf:dc82:0:b0:2ef:3140:8701 with SMTP id r2-20020adfdc82000000b002ef31408701mr5003891wrj.10.1681315308432;
        Wed, 12 Apr 2023 09:01:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:938a:b3db:7c59:795e? ([2a02:810d:15c0:828:938a:b3db:7c59:795e])
        by smtp.gmail.com with ESMTPSA id u5-20020adff885000000b002c70851fdd8sm17515397wrp.75.2023.04.12.09.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:01:47 -0700 (PDT)
Message-ID: <28488550-7d5a-232c-c9d9-9ca82acfb0f9@linaro.org>
Date:   Wed, 12 Apr 2023 18:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [V2 1/3] spi: dt-bindings: qcom,spi-qcom-qspi: Add iommus binding
 for qspi
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org, quic_vtanuku@quicinc.com
References: <1681313387-8376-1-git-send-email-quic_vnivarth@quicinc.com>
 <1681313387-8376-2-git-send-email-quic_vnivarth@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681313387-8376-2-git-send-email-quic_vnivarth@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 17:29, Vijaya Krishna Nivarthi wrote:
> Add iommus binding to documentation to be in sync with below
> change to dtsi...
> Add stream-id of qspi to iommus

This commit msg needs improvements. Try to avoid referring to other
patches in the series, unless necessary. In this case - it is not
necessary. You should provide here rationale for the binding change.

Subject: Drop redundant part "binding for qspi"

You also miss PATCH part. Use standard tools to generate patches, so
they will fit properly to Linux patch workflow.


Best regards,
Krzysztof

