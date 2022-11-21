Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB4A631D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKUKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiKUKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:01:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC452E9FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:01:27 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s8so18028861lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdHq/rvX7KryG7wAunvfq9iiBy/GQXmZIFnR3Hg2TYE=;
        b=BJ68t8t/GQgR6/g1k5r81iMpJYFzH5wJxzWH6RVyUydlRm8yvizWPjIO1jPV2z1U8A
         a+3PeRRlhinBOTDqyeEPY93nP5QZkE3I6lGiYaBDzZAY8SjFnLHheidQCq24Pj8G2SiD
         CJA78wDNvEpTz5evWXX+k2/F7Uh9eQkJq5XTyaAr/QCTZStIlHUEW74M79M89jk0xwoy
         YjzQUzxG2YTLnhqFrdk0KsJsG9e1Kvz+a1RqRAzfbO7tJKeGLcLuNSMWLH+n+fEiOp4B
         NsgL1lPfj+2tY6lwUsNDEOiw1dHZ0w7QefhEl8rJ4Cr+fPwH+Bm8ZRVcnvwGpF/tIxp6
         WiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdHq/rvX7KryG7wAunvfq9iiBy/GQXmZIFnR3Hg2TYE=;
        b=E/iL9nQF2SHBUYy+BcpQjNbpcSKAz/C7eg68A/FJVj8GstPKEws39Bv2+hFrum3iLj
         sPXFCe3Qavwd2gP1UTj4rDyk+Ps7naaJaFjVoVCxHcnO5e2f2vmqpiEGYgCEQtTOP8YY
         4w+uRMuz4Lv8EMjJMKD19nrPxetvbg1cN471Yej/9RBHpTYN2t3stUdQjU3SnZkyM9cB
         JArubLfFEg5jh7OxO/OzLEhW3bbwjzmIDbwOCJD1L8TGDptCkIOlCCfZ44WSGqsFkqWw
         oKACsHkzitG58RKYAbq6+vlyI4LXHuy3OxqDjEN6cHKXe6KaFfpZxIMvm6WZ4JT1+61D
         8GkQ==
X-Gm-Message-State: ANoB5pmcoZwNw6yHgsnESZx6aWveg4dPq41lrU5EN1o/IkC4s6k57a+r
        jRKP/WDMH76EQ6/G5r3Q2qVX1g==
X-Google-Smtp-Source: AA0mqf57USOJxIKG1DLY+72g4hRVITQUAM2926LJyd102HRZeb0hnXMBqCPAiFIXTwniaOvmDybYfw==
X-Received: by 2002:ac2:455a:0:b0:4ab:90c7:3f9 with SMTP id j26-20020ac2455a000000b004ab90c703f9mr1200451lfm.342.1669024886024;
        Mon, 21 Nov 2022 02:01:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m7-20020a056512358700b004b4b69af17dsm1958123lfr.214.2022.11.21.02.01.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:01:25 -0800 (PST)
Message-ID: <a7cbbdf0-1433-b3f8-bccf-b54ddb20d073@linaro.org>
Date:   Mon, 21 Nov 2022 11:01:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/5] dt-bindings: qcom: Document msm8916-gplus-fl8005a
Content-Language: en-US
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221121004813.3883-1-linmengbo0689@protonmail.com>
 <20221121005128.4245-1-linmengbo0689@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121005128.4245-1-linmengbo0689@protonmail.com>
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

On 21/11/2022 01:52, Lin, Meng-Bo wrote:
> Document the new gplus,fl8005a device tree bindings used in its
> device tree.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

