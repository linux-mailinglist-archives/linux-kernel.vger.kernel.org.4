Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056AE625DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbiKKPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiKKPDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:03:45 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262E814FA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:01:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bp15so8640029lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XylCHjoZ7BbZOYRF4NNLct0GNll1nDPpxJnFN+swT08=;
        b=pV15QTO2bq+nyEEes3guagA1BSoa0cGtoCex9VwWuIvj7JV/EFcjO7RDHX2r2W0Hl5
         0jYS5ZM0HNWLEfwvrrxfSkJaRO7sT4mNLSUv2/OlRPLabpAr1aMQ8JSXHJPurEvOG6bO
         3U5cRvquXfc4H2wZplV+grc9W2yxnNDWgXDE+obw12p7OuY7c0YsA+JagDk+8Asyoc6h
         6qNZZ8DpurMQxPDzqlAj84U22lwmr4/V3UcwAXy6gfKvI+3QbzU4jmLR1AZ5lHRR8S7J
         64eawYNrHp13dzAHGdKcKZHZm2laGXtAb9E1KBwLZxc4wmeShRAUU8lklj1RXeGRP/9G
         b9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XylCHjoZ7BbZOYRF4NNLct0GNll1nDPpxJnFN+swT08=;
        b=0mDlfpizaL+6Igt86MZdFwRC6t4tEIkzyojqlgZiezMFWMyu9ud7Jba4bcX6dafFdE
         xyZdBmSwkSnSb/W7MwjdavVtLx5HyWt+zOFf9ixmjL1xCpRV4JEGTTvw1U4uubCGi3Ap
         WgIeH8cnUzu5U+YfIPKmKG8eDkdcolihdTMhhE+ZEbJtRnsp6cAJX4fu7WKpTW8ucCs4
         FGoz0he6xyJSwooLrgEP0wSi5rJJ53z+qqwNais6zbLELk6uudUHTM47hkqIBUgA8qFf
         K6/b/YrmcgWo24c/w2AwmHVuyLLtEr9dsdHKxWeBz5gSnjdR9Ac0BTntFRqLZGkorkPa
         HL8A==
X-Gm-Message-State: ANoB5pnO7+IutH+T+dhdiWJXrWAByai4J3f1QFKtBOAHEX91FH5Ns6ZK
        NOLjdniCY2oZmABB3SIiwzoecA==
X-Google-Smtp-Source: AA0mqf6V0Ryay+OOI9OxMnDhdsWaV5XDsXDqL5mWkQZ/WJZlYHJ9xHhR5mpN98c7L/InCaD+uwLybg==
X-Received: by 2002:a05:6512:1398:b0:497:456d:890 with SMTP id p24-20020a056512139800b00497456d0890mr767011lfa.687.1668178882622;
        Fri, 11 Nov 2022 07:01:22 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0049462af8614sm364442lfr.145.2022.11.11.07.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 07:01:22 -0800 (PST)
Message-ID: <21f2dc7b-5fd6-4f28-0a66-5b044a12dd0c@linaro.org>
Date:   Fri, 11 Nov 2022 16:01:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/10] dt-bindings: dmaengine: qcom: gpi: add compatible
 for SM6375
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
 <20221109111236.46003-3-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109111236.46003-3-konrad.dybcio@linaro.org>
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

On 09/11/2022 12:12, Konrad Dybcio wrote:
> Document the compatible for GPI DMA controller on SM6375 SoC.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

