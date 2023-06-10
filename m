Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203E872AD78
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjFJQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjFJQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 12:39:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710583C39
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:39:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-514859f3ffbso4280128a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686415145; x=1689007145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QiXYDHQLPum02ry8vW/Ny8uS/yxBKBPG03To311Ihhw=;
        b=NxSakPZ4DOZAcyWtlrET9GBA440gLPD9Lg5iidkj5a/7RImEi3zGKkKJnDG2Eugfpv
         lnbLTfVv370m++JC3nnkHPPmDhlCqRXMLco1zgVfuVFz8ciy1nMTkXoC7JYsx71Wwnxx
         l7KqsGWVNOsPBc3RK96XzrM605cxARowyjsXZwzkxPKeUegKmT8NNrnlOKh0zx0QcAr6
         aMyGHKqczHUbi2uZF2nBsnMUxLTT7qqXKGZY+5RLNGc7oZNB9lc/ZdOFlSm1SHeDzb5F
         gArkVf5s9icp+p6Js4q6t1Die/eZQvCG5DEC/a7MKvRa93aqCwBGmDgzI4CaUdgZp34U
         5ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686415145; x=1689007145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiXYDHQLPum02ry8vW/Ny8uS/yxBKBPG03To311Ihhw=;
        b=dxwRKd76GNgGtTeSv42DXXpvkqAjOwbhItwc9ZgjwBtQIYTOb6q91qZFvTedb0ZzIC
         kJtCHwtTikpFxprE7luCRzaqOXhzYxsXNWXNNKM+sfrbGhwQIMbK/ru1akKE2TM3KatJ
         4K3T5yyycNKw4hiXNO7fD26KKaCxWVEMW99jU33JljM0DkU1lSgoJXGQrayc7m1HNCGP
         /iOK/iWbZHrS7oMHqG58mYhTEMwXUA4rMqAPFs2SUWBmSaDRjz2UiG6FJ4W1pXWk6w67
         woD0fODXgd5iHO01pUIK/MeQf7/tvZROVJOLaz+X7R/CBBQUm0FVoIqZLcMhyKGzLxFU
         WTXw==
X-Gm-Message-State: AC+VfDyM+0Aei1HjXQ9g+twUwKd/xc0QTg3OlKFJR1u4NdvQ3YXwJ9uX
        2TsZb/o36/1sd3cWVzD9BMWhcA==
X-Google-Smtp-Source: ACHHUZ5Jb1+VnWqrBMQFrwFTVbVrskJi7tR7TK7otkENFqwYCziIMptTjdy7AotWU9Bq3PUpJWdcfA==
X-Received: by 2002:a05:6402:138f:b0:514:7f39:aa81 with SMTP id b15-20020a056402138f00b005147f39aa81mr1435661edv.20.1686415145043;
        Sat, 10 Jun 2023 09:39:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id n22-20020aa7db56000000b005182edf2a52sm753791edt.30.2023.06.10.09.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 09:39:04 -0700 (PDT)
Message-ID: <59bfe97b-a403-1d61-2969-da0440506067@linaro.org>
Date:   Sat, 10 Jun 2023 18:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 12/18] dt-bindings: clk: amlogic,a1-pll-clkc: expose all
 clock ids
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v1-12-9676afa6b22c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-12-9676afa6b22c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 12:56, Neil Armstrong wrote:
> Due to a policy change in clock ID bindings handling, expose
> all the "private" clock IDs to the public clock dt-bindings
> to move out of the previous maintenance scheme.
> 
> This refers to a discussion at [1] & [2] with Krzysztof about
> the issue with the current maintenance.
> 
> It was decided to move every A1 pll ID to the public clock
> dt-bindings headers to be merged in a single tree so we
> can safely add new clocks without having merge issues.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

