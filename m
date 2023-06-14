Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9572F4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241791AbjFNGbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243160AbjFNGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:31:08 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A951BF7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:30:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5147e8972a1so10819703a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686724239; x=1689316239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cc+dxPpu8lXsZsADd1XaSw2JFjXzN4blFEsEKZHFTD8=;
        b=qfeOtFUYHy+0ttTJcytVR9sVTi76yBJKYGUruFsPsclOXYncFnmR2a+KZ5QFJ7u0MG
         O+uPjlQFFZud5PzW7DMkZD8zUwzmgzz1afhTunc8ERcoyzy82KvTJnaPoKv/t39Cn2Rs
         glUcWe5jY/Obo8sSaRX0dFxf09OWOpAnfK/9IJUDHA2huuaScEpevMSQ5WMoNpPMu9kw
         fHd1LXYv434YjhEjoVwvB+j1PKds323PDP+4w1Wj/uFSEFGBpPgXie/pYfKEhPNr3DtK
         AUgbArtKo7c9bt9bHk7ac+OsRv2KV1qPKY/UuJ2UCg1MiqEVxRAPeLkypVQvJzTc8eZF
         tdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686724239; x=1689316239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cc+dxPpu8lXsZsADd1XaSw2JFjXzN4blFEsEKZHFTD8=;
        b=dVYccexag6N9KaRgZ6t4QbQj8KmVRHuZ70v7dWiXF7yEgrlLi5TlU1a0IYy5hyx0x8
         v/ZSNEY0sH0kitItL189cQy3OvLHXzncmDOGF1pEgT5A2XNP47pGJTJwcVlHFr8mVYaH
         uE68K+7L2s5jAZHaQW6dqYY+jqOaG4BAuKI4jilxUfwUyXNl1+K9bPu77MlqkZo3VEDY
         dx9n8FqKIe77+QVtX+o5oGbXx+iOPni7+a/Ba85jvWiQZKvBOjSFLM+wS37tbk1PR67T
         sebXjM8cC61qEHR/lBuigIt3+QBf+C3koM5Eb1oGuwMfw35UzmpdNnJsoifw7X2tucD6
         lUlQ==
X-Gm-Message-State: AC+VfDzbm1jRrYhwPSXIVZ6VirOaEpcAm1BH7g52noY4BpvjlX18mnFw
        jnQN0PFt0w4/LUAdu7Gj81jnYw==
X-Google-Smtp-Source: ACHHUZ5abd/2cZWoy7USVlJWZb32cnqcjXZa76XE9hHfo1LyM0+k06asglp308N0ZQs34+NNItEODA==
X-Received: by 2002:a50:fb94:0:b0:509:c6e6:c002 with SMTP id e20-20020a50fb94000000b00509c6e6c002mr7851333edq.39.1686724239059;
        Tue, 13 Jun 2023 23:30:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n12-20020a05640204cc00b0051631518aabsm7211825edw.93.2023.06.13.23.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 23:30:38 -0700 (PDT)
Message-ID: <46458a14-28f3-5279-f5ad-302e6edebaa5@linaro.org>
Date:   Wed, 14 Jun 2023 08:30:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: adc: add max14001
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com,
        andy.shevchenko@gmail.com, robh@kernel.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230614004857.134980-1-kimseer.paller@analog.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614004857.134980-1-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 02:48, Kim Seer Paller wrote:
> The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> binary inputs.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V5 -> V6: Removed tags.

Not the review one tag! Drop the fake reports because there was not
report and nothing to close.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

