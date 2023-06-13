Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AC772DCE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbjFMIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbjFMIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:43:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF6B1BC7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:43:27 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9745baf7c13so774036866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686645805; x=1689237805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5Dbs9odIHVvkEWBqHHqfLFf7lgHuWeM0uugMrIB5UY=;
        b=LloKSIEhAMpnEpsYPW39b6O6NUjbZ2ljy2hcRAYG21medhu4KyE2ePRR0r+zVHeL64
         pDEzzdxroHyDIdqlykc6iTGhhQ/UrKnN6XR0uqNzz0t4o6x1sBiEovQY2eFH6QAkK/By
         KYHuM6dKnJTpkoJBbs4k5cM/iEgCYHccdow6ZBBOOFHFHLgGvim7eG8pld4Obs74ufJH
         7Xd5U1H0U5Fzu4S7Oe/sTghVUA52cIJ2Ada8qz7OtkpqHpt/IBTmUUkuKmqXrKbrPipf
         Eo/ydGkWScNOYzLsari49zXzfz9lAyhQbbPUEW58HQf2Bq9+eLHVVBei067BxG2OqapH
         miGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645805; x=1689237805;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Dbs9odIHVvkEWBqHHqfLFf7lgHuWeM0uugMrIB5UY=;
        b=hNmebwayp5b1ltXxCKmfYfJnxiFJHoczbgJzdP1KUDoCVhqC9lGm8loNVkLUgwvS6V
         TrM6sfucwwyENkCg/wWvfNZwdj3VMuVHvMdqQhPqHtTyeNhb6zA8B145AJa/ysz7PetD
         j2tz5X+KIlXzP0Ixo0L9JYZotTcDSNfKHXzsJASh9aQJD5DSuFnAwvGCKBhrpTo1ItdD
         puakspItAJIbQ1bgnOtdIS02BC/TAMo6/JXt7oZd75/4duxUshYaRxSLlwtM7zSRr2yj
         T81A2AiLLANhjczfH5wCP76VGeb9eL5LbN6C1aplWos2Neww7jyy9vmXj0z18goJcO3s
         zpDw==
X-Gm-Message-State: AC+VfDzfVootYBvP5SNBiJOcpUwYKYcL39qMEwJR4qfEcarNRXGNQWeP
        knTnVInwJ546Pambsq0YuYPhng==
X-Google-Smtp-Source: ACHHUZ4/ztJz5BfPpk5ZLSM0RLuAYAVgxSU3DPpJe1GRo73HUHvkUMgS3aOL4f8QyySrPKsiYIeIjA==
X-Received: by 2002:a17:907:320a:b0:974:52e6:93cb with SMTP id xg10-20020a170907320a00b0097452e693cbmr12720907ejb.50.1686645805697;
        Tue, 13 Jun 2023 01:43:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090668c900b0098242730348sm218185ejr.72.2023.06.13.01.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:43:25 -0700 (PDT)
Message-ID: <9e0ac1da-9064-5a0a-0365-d5e00cefd1c0@linaro.org>
Date:   Tue, 13 Jun 2023 10:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson audio
 card
Content-Language: en-US
To:     YingKun Meng <mengyingkun@loongson.cn>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
References: <20230612090058.3039546-1-mengyingkun@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612090058.3039546-1-mengyingkun@loongson.cn>
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

On 12/06/2023 11:00, YingKun Meng wrote:
> From: Yingkun Meng <mengyingkun@loongson.cn>
> 
> The audio card uses loongson I2S controller present in
> 7axxx/2kxxx chips to transfer audio data.
> 
> On loongson platform, the chip has only one I2S controller.
> 
> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>

Where is the changelog? It's second v2 I got.

Best regards,
Krzysztof

