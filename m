Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC15639D28
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 22:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiK0VJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 16:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiK0VJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 16:09:56 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CB22DD1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:09:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bp15so14554074lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDwaTCGVoj7wtYrjK6JVB1II3Z9a8V6hZsbZhHi2jv0=;
        b=Dx5KKpZpr00x7pUt9HK6k4DVLt5Nf+piLNLTgXu0/AdMbfefx4WtHazziCRZAPEE/2
         IvI2dkixwQ11tdYDYNBFjlFTBbIvVpdYMOxic1CEOMmkFoNrQ95jv+xLMiTkWDpUzq4E
         O8/4becvQoLjPfPWdMUGh77m3Nf7yILiXvnkCRr4vL5yc5shd+oRB/Yrs13oRGoBt+MI
         SArPitM88t+BXOojyTJ9Qru7Wudjpi8zR/ShgSACiWZezXpqnT1mtQBlYVbOJv1RTKrR
         rd35SNQ3AwZa9wDUH8bDiU7Iy5rO3IaIq5BUWu5Ed/WFdLUqh4tbMcpSBAqAd5CAVfez
         qMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDwaTCGVoj7wtYrjK6JVB1II3Z9a8V6hZsbZhHi2jv0=;
        b=uEv+8IZIQEHXuVvx8yXTNEj98Wvngk1Vy4wWK8aNmzZrxRIlLCbqNg9tDEcvAWDcxA
         dk4LR55fXJIJScfW07f7itVcl8D4JBUsEP95PAg08rmM9Yc8FZvYpUdfLh0zrkPQAPCM
         gBRCl9d7qYQ3RoWWttwBZYg6zRZA1g3JBtg+ZcnIP9+BRLwk9XQjvOwegEWO0UAoj1wB
         BgOymTSyjLtRFAKfS6jkPbtuDAV2KJ05QdxCsKEGPK7NYeC1Rt2fgB9qQq9QePTQSZzb
         dxB5CogKp6iB30OgveuK7cuPjDJld4khu5ltkWAcFyYK5ZWib+1fe2pRRa+S9670BUSN
         BLRw==
X-Gm-Message-State: ANoB5pmXfQPjhyq3B1JqrWpbMTXwihpBTlInQ4r0COlQHUBJSgmo7ISr
        0diKVyHsM7calJi6EqEgRFufsQ==
X-Google-Smtp-Source: AA0mqf4DScqRVlpQ42cghb+X8aoHij/z2RupMCOuSaaluhqdVZ7QT5l3+DnGfZ3BWwzC9T0TYFCSVA==
X-Received: by 2002:ac2:4e6e:0:b0:4a2:2210:f169 with SMTP id y14-20020ac24e6e000000b004a22210f169mr10525766lfs.317.1669583393728;
        Sun, 27 Nov 2022 13:09:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i15-20020a056512340f00b0049f87fb416dsm1425087lfr.12.2022.11.27.13.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:09:53 -0800 (PST)
Message-ID: <ef692f82-61c3-b812-b846-64bde04c8bb3@linaro.org>
Date:   Sun, 27 Nov 2022 22:09:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221125220903.8632-1-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125220903.8632-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 23:09, Samuel Holland wrote:
> Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
> the compatible strings were undocumented. Add a binding for them. The
> hardware has an alert interrupt output, but existing ti,adc081c users
> do not provide the 'interrupts' property, so leave it as optional.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

