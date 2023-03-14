Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEF6B97C3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCNOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCNOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:21:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F166CA7AA1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:21:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x13so15409701edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678803666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8VuZS7RbY6ZldH2ilAQjBRJiWJizf7XEL9oNzVJSsgE=;
        b=Iacc1DOdC2EC4ZW5rKyNuUfgecaivc6IvkKFqWfUJBGO0s+2jkLRe+e0+lvWvOvW/y
         +CJic7Qsg+b37dk/K9Comk8N/poHt82EbFmNtUSXP6B0Xd7wypmUZ3NdURoK06IDZT69
         uNRJnSmLvePtnnt1RXKJMcanfYZ+dWEP4qG7tscjAGiAxLuMQctxR+Wd112cSQcOIgJr
         ZhtZVMufWKFIn+Y/UZeT5zU7qv/WbJItFGkohS6coXd5xmkDVz372rfpWTqKTSOJqaQv
         ti/pOTm12cSLeknzk+87Ev5L03vSuSfd9DfXSFQ9sJ9oYBBqKoFtD1E6vYeFKDiNrzsX
         71SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678803666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VuZS7RbY6ZldH2ilAQjBRJiWJizf7XEL9oNzVJSsgE=;
        b=U6Vvzz+g2Jk+bN6dmzdJpDBcIYK6B3wvIwnZ9dH4+8Vjql2tp6eC1P4IDOAL0mEP2b
         wRpxcPRiIycrHzxV7o7AY7QTIYwLqpsW0gOX7Hf3j339LkdzQmgqywbd6TikbmNoutuZ
         oD6rdm5fHy2B6dKFRsl4aXNEXRoJbVgKuqwmgtqM6tOnVBXLujTmzYc0RGGUBoJ90jwN
         3LMdYPpjkJhVQlS8UElmjWp6mZYs3FyASAQ6uo+jrQtxc95HLv7I9wskgKrpBbFdoSM7
         SPUgDApxlBoTqBOfa1xJ3qXAUWB4CmfHzl7wNdREtEW6Lu0dzbClEi2DP+nzCCyrp3SF
         fyQg==
X-Gm-Message-State: AO0yUKX0x9+mD4j3TRYjunVdn8MlKU5BnUwtLro/nV68lTCSVEZVHq3I
        OvKhQo5AkHQi65jNd0ggvdueuw==
X-Google-Smtp-Source: AK7set/CqBlzUTje/yhpDFgTQi5VBjU6f292LHsX+VzhELe1yngizcfuBFkh2YlmDd7UvmwOPAQEKQ==
X-Received: by 2002:a17:906:e0d2:b0:92b:f3c3:7c5f with SMTP id gl18-20020a170906e0d200b0092bf3c37c5fmr2608711ejb.53.1678803666478;
        Tue, 14 Mar 2023 07:21:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id oy17-20020a170907105100b008e385438c76sm1220838ejb.55.2023.03.14.07.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 07:21:06 -0700 (PDT)
Message-ID: <49f0b7d9-475d-898d-29d2-7e7cdf07cb0b@linaro.org>
Date:   Tue, 14 Mar 2023 15:21:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/3] dt-bindings: i2c: mpc: Mark "fsl,timeout" as
 deprecated
Content-Language: en-US
To:     Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ryan Chen <ryan_chen@aspeedtech.com>
References: <20230312233613.303408-1-andi.shyti@kernel.org>
 <20230312233613.303408-2-andi.shyti@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312233613.303408-2-andi.shyti@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 00:36, Andi Shyti wrote:
> Now we have the i2c-scl-clk-low-timeout-ms property defined in
> the i2c schema.
> 
> Mark "fsl,timeout" as deprecated and update the example.
> 
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mpc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

