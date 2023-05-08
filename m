Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C886FB4F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjEHQVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjEHQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:21:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF93172D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:21:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so9013630a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683562906; x=1686154906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bByvY91yjFmYYAl8+yO8RJrqMmwasrfCvUEiLf04BkQ=;
        b=fXdGCvyEm5gGOcm5T0zdCgu+KEU2/V73fZwDRWjgWaeeDPOJKy6xwGSkhuuZRByuLX
         aHN8KfSxHfaDNskhkR2iBv7PupeO6v7wc78aSA2WhDP0nhLMUKdMsjt8IlUr/HSDMw+/
         Rmxg9UUmsgcMuR73WMC2f+HSb6YzS54U7oBTRXu/y7Ih7LbYpjAXfvSMtgd1IehY3laa
         3bfEuSGB3joyCEooKnCKRtM9CLmmGjZMxt1zKobiq91NArPc+jE9mMtt5CkorB98ZJpe
         yijqg/IJRw/11iBhrSKi36mGi3zCjOAYjnnNfal3Vb08PnThf84pV5C//+54rjqhmtec
         uBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683562906; x=1686154906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bByvY91yjFmYYAl8+yO8RJrqMmwasrfCvUEiLf04BkQ=;
        b=kRdsorZjoMBKS8kPnqIwTw6RUINg4pWQbbLbIWkC9NdxkBcnByw79Pk1vHBhwFZfO0
         W/dTgDqTp73jyHtpTRJ5dfALtm5HvZPqgmS3WrHOEe9IKd+rRwSE/PqjfpzA5puEplzw
         xKHSG4//MZPLs2EBlXmwRsW9bTRvSFVIxEJ0XeFCJs8PtlLnCZ/XPjP7CKw8gZeXsJYn
         sT/dHeTDF6wICgseWAWoKTAZK0jQZkT+xzKOIxiWSh2ygML89FF8XiTk51bl+zml6iQD
         mr9ApPBtL5yV/ZRDxef5EFqJkQdzYjNEmOqJtHcMA2Cm+84f9RAqyhJELGWbCD+zfJvt
         /blg==
X-Gm-Message-State: AC+VfDx9/qZuvAhTKyeTcS/gVVWOBd6tL/sldT2bH1p1AjYMrzZMvrtK
        eqyQsDGL0AuujBo2Q47hCcLAfOrEpa+59d5IKnk=
X-Google-Smtp-Source: ACHHUZ5VmJPrF0oBBAqUa/85bhiSJ/EF8tbDtYjza9FoecRfsEbm98dbBiVNnhevft1FVqPOSmZ+Sw==
X-Received: by 2002:a05:6402:1390:b0:502:9a5b:206e with SMTP id b16-20020a056402139000b005029a5b206emr7732377edv.9.1683562906034;
        Mon, 08 May 2023 09:21:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7c402000000b00501c96564b5sm6233636edq.93.2023.05.08.09.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 09:21:45 -0700 (PDT)
Message-ID: <003b0a75-75d4-cca0-556f-bc78f90e6964@linaro.org>
Date:   Mon, 8 May 2023 18:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] dt-bindings: firmware: brcm,kona-smc: convert to YAML
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230508103255.GA18424@standask-GA-A55M-S2HP>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508103255.GA18424@standask-GA-A55M-S2HP>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 12:32, Stanislav Jakubek wrote:
> Convert Broadcom Kona family Secure Monitor bounce buffer bindings
> to DT schema.
> 
> Changes during conversion:
>   - move from misc to firmware subdirectory
>   - add used, but previously undocumented SoC-specific compatibles
>   - drop deprecated compatibles (they've been deprecated for ~10 years)
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V3:
>   - remove unnecessary oneOf (Krzysztof)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

