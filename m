Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556366B687C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjCLQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCLQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:59:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD20367DC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:59:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r15so12533749edq.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678640383;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfkSWA4m4vFAXt2ymWh162tAViiyki63Q+2RK+3+MZw=;
        b=FwZgdZlG2VMoGePCPY47G78odADDfhen4NV/muzUfWciVYQLptd4It+z3v4nzVDf1o
         +RxcI8dyyC9LuEZ7JdIDns2gPQie/I+UGiCrEtjYXLbWweRsMBq/mwUxkW5fRtwDlXQY
         W94AKsztmAXyKuZ8WllAaHaNguGsWPLPO7t71qjowwHLwrN4AYsQyxe+6/fUqOchcr+r
         M+3mS4Npzjziul260HLKyY0LnlipttFpDJzuxUb54wLH690kPLDuBKA+lFC0bQBD8vQs
         UYJfTtGkPplV5lWxNq5N3rJmAJrs9zbU69AmaPSl1cAC1CFp16fro96SG4Z9YqhbQhIi
         RThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640383;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfkSWA4m4vFAXt2ymWh162tAViiyki63Q+2RK+3+MZw=;
        b=60LraVtXvwlY+9uG4Kzx2I/z1fLp69bWNtvOi9cMZYWbsEfuznxbzo1pTLSVBbgRws
         KrI/H4n3OvAZtg1q9WOGFvjzJcDVx85V8vCL+bY42kqoicxIX9lSk+RRNcd6nHfLhMON
         A+P8jiKxgnAvZs3DTHKlkT6eDW1k+r1cNYgCzK6P2r6X1ds5ujU38/aMhHxAgC2Q1/p9
         jfOUzQgJjMGezuCo8N6JzJbrAPmMz4prZv2Ozls4qi8QtLMzf9JU0K3o5gRqY1gdLhj6
         wzLxG3vgtEQmIKjL4MMzinYRvp5N3PMaL5pUHjtAsFqFO1d+kLPrYuudna8BknshY/QX
         gCcg==
X-Gm-Message-State: AO0yUKWyhHCVgQWhaAfigr9ateqGB4hN0LWzJaSKwBDJno1MQtL91eBw
        tF3MLWvaKOEG5i0fIm88fuUKdQ==
X-Google-Smtp-Source: AK7set+nI3aCESbd8oGKsfl3taae2ALqKdzfqzM+VGWa5LNdGfepqdi2ys/KmLdkyVd1293hwFecbg==
X-Received: by 2002:a17:906:dc8c:b0:928:3d04:c7e6 with SMTP id cs12-20020a170906dc8c00b009283d04c7e6mr1452734ejc.26.1678640382986;
        Sun, 12 Mar 2023 09:59:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id sg41-20020a170907a42900b00922f76decefsm1592861ejc.99.2023.03.12.09.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 09:59:42 -0700 (PDT)
Message-ID: <cd9d9983-3dd5-70dd-8155-1b7d856bf35f@linaro.org>
Date:   Sun, 12 Mar 2023 17:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: tegra: drop serial clock-names and
 reset-names
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
References: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123151543.369724-1-krzysztof.kozlowski@linaro.org>
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

On 23/01/2023 16:15, Krzysztof Kozlowski wrote:
> The serial node does not use clock-names and reset-names:
> 
>   tegra234-sim-vdk.dtb: serial@3100000: Unevaluated properties are not allowed ('clock-names', 'reset-names' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thierry, any comments? Can you pick it up?

Best regards,
Krzysztof

