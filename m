Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025EE64C8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiLNMP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiLNMP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:15:28 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842A23382
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:12:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z26so10086491lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fe9E9gxIDnj9KsiPaWiLwL0tHHYMsA0RVz+NqHip6FY=;
        b=y+AyqWUfZBXAw5Cz6YL8adsELTVVu3WwPCmSvTUw39KBPRpZyjacNyawxGiq/22aHQ
         KEikd9tyjS0kak71lLtsaPMCi5w+csB2UnLSlx3EuK1upHHzD+zZ8XQLt+Lqap9fAssb
         PKOVm/yG8mT/x1+HSCRIu3bBMhIVZmw4wVUSuU5/x5tM6eOZ/QgANmMXr12uHpBlH9Aj
         iraPPMvv2jKdaVYpmjj5h6Aqj8NczRXEo12+EviGVwdDFlQyyXJfKNFrJBKKskUY/vmH
         Zbd6+H+75ovJQ8iwltTbMwlpqZDDZWqF5yxRkaHagQf02EnEiKCHWbGVWayl1F44m46Z
         7URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fe9E9gxIDnj9KsiPaWiLwL0tHHYMsA0RVz+NqHip6FY=;
        b=H+5tKgZ4HmFMmDn42xSAftW//idSnYRl3y90w0JzQnXqpyZgpQC8mSo53paPWtLBQ4
         tSQm8xFLYbTYno11kmmpw4Ymb/0eh7v1OTOn7mnwgUfgO4BSHPs028p0Ps2URnL51Ow1
         kC4ui0UO1lCRZboje6/X4ahwoFmap1zb++TdaMAqMY6Wsht+6OCpen6bRIBUgblD4BWT
         pA4terqd/kz3BApQw4xqCNs1BAw2Q9Uu/o71THz7Z0hMcRwb7aGEeaCdGnNpX9YAiReg
         i0Ex5vY2UmdHWbytFS/bBmIfCCsDLgRO2rgI2zBrHp6qSnlmom7usR1VXkhGl5gKlPpW
         z1Yw==
X-Gm-Message-State: ANoB5plNJ/cospSn9rHEhpk+2RA51Tja+HXPocxqAfXpcisJ/IceaV/r
        28/T6rnT9iu66uzhQ2Cbe4o+fg==
X-Google-Smtp-Source: AA0mqf5SUoalM/0984ObokvctIM+T71pG80NMVumHjUtJunFYvDmnncgF7kJwegfOiS3puFDyH739g==
X-Received: by 2002:a05:6512:12c3:b0:4b0:3210:88b7 with SMTP id p3-20020a05651212c300b004b0321088b7mr8965533lfg.58.1671019946578;
        Wed, 14 Dec 2022 04:12:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512071100b004b58500383bsm775616lfs.272.2022.12.14.04.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 04:12:26 -0800 (PST)
Message-ID: <1eae1313-eaf5-5906-6e36-ea8ca2c563f6@linaro.org>
Date:   Wed, 14 Dec 2022 13:12:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 11/17] dt-bindings: soc: socionext: Add UniPhier
 SoC-glue logic debug part
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221213082449.2721-1-hayashi.kunihiko@socionext.com>
 <20221213082449.2721-12-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213082449.2721-12-hayashi.kunihiko@socionext.com>
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

On 13/12/2022 09:24, Kunihiko Hayashi wrote:
> Add devicetree binding schema for the SoC-glue logic debug part
> implemented on Socionext Uniphier SoCs.
> 
> This SoC-glue logic debug part is a set of miscellaneous function
> registers handling signals for specific devices outside system
> components, and also has multiple functions such as efuse, debug unit,
> several monitors for specific SoC, and so on.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

