Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD668E985
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBHIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHIEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:04:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6C33B65E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:04:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h16so15834320wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPZYKz9kIWG0BV1hKs7mmkywSKpqe4/iI0ZWWNXTejg=;
        b=JDQ7cEO1o5sk/n06eAakbpT66oZ80BwGfLJ6rQUl/kuVS0pPWBerSI62m/+4k3yuLT
         9KS5ffgX7iGFD8fSJu1Fy9tsseGZV9CNhY9knoLl8qpMUnZdl9nGOx4rwn/VUh/plBrM
         VMTsBInoS1ym37pZsfMAOGeRNZURvNN/1FGhk7JlXpD31+DoXQOoUA/FU40Ar2MRA3sM
         HON0JuwbYyuHh1G2QrTWEox46SWx/KYDWOfVwQ28VsGfX+B5B6atDsNb8MzFD+vufq4w
         2HG5d/3SAe74owyHXvj3IjuLC8nLaQ9JAn9yIkDtxBYdKnGeFw4i53Um0fHNoYc1i93M
         qmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPZYKz9kIWG0BV1hKs7mmkywSKpqe4/iI0ZWWNXTejg=;
        b=mAIQJzKevn6vginN8FeboQv2IR8JUmAaTr9zgHp6WfS1ZYaA252fLeFwusbyMFTSj7
         UB58noWqXA2oBU7cS4wLiU4vWH6fuj00yOMcWKa1vHwIrGgWt09HYwZT51YzYyN4DQlj
         FP1PUIec/2ULKl4cPH827RRxpdTGsybFSrmgaXL/wQwh5yE4aUriSaOJ1LwbPcE9cbmb
         ZZL/otGhsYKQgGxCUjxyuwxUeWt2msfvOfurwtdfWaORtzushTJyJpMMB9E7SK0fnVIV
         SzX+zw7oMwNUxAT0mnhfrxbDIjv8OKkqUlDOff8aFyZtQHyM/PGd9xcUDJZD/oH+mnet
         hcjA==
X-Gm-Message-State: AO0yUKXdPQy/YCu/AuI99eT7uoTuv9x4Z8uCKWnDOa8EP2Mc4OoPYOWa
        hcV8KYFZgrg5en4s3vYpHIOA9A==
X-Google-Smtp-Source: AK7set/9BRPwbInVYGqTZVlD3CNJVkBqMQafTUumpq+/ygBf8ftf4J0AcDgJI1cyDRzks+1vVM1MKg==
X-Received: by 2002:a5d:6750:0:b0:2be:64bb:1d84 with SMTP id l16-20020a5d6750000000b002be64bb1d84mr5308759wrw.24.1675843448008;
        Wed, 08 Feb 2023 00:04:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s7-20020adfeb07000000b002bff1de8d4bsm12935330wrn.49.2023.02.08.00.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 00:04:07 -0800 (PST)
Message-ID: <9ca854f9-3148-2f56-287a-f898c8226f67@linaro.org>
Date:   Wed, 8 Feb 2023 09:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch][next] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
Content-Language: en-US
To:     ChiaEn Wu <chiaen_wu@richtek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
References: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
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

On 08/02/2023 04:14, ChiaEn Wu wrote:
> Revise RT9467 compatible name from "richtek,rt9467-charger" to
> "richtek,rt9467"

Missing full stop.

Please explain why.

> 
> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>

Best regards,
Krzysztof

