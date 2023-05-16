Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5698A7053E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjEPQbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjEPQaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:30:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3421FD8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:30:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso2653146666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254605; x=1686846605;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zs8DePhd2PINsPq4Z6VaoJ9+dlwdHGIeIrzanWWmBmg=;
        b=N8hSrPCfLd9veb1O+nZUU9R9ATcG7HQNY8svEJVFomeUMKPOffm8JDDqAAPG+THpeE
         jDiX3ETAFc+TtalG/pExEWsddNw2HbKeZHObg8jBkyScMMjVEOKWAHPinkjRc6M8UeL6
         eNB2l71QG3XEHaeibY9hjyvh8lQ99C24sY+5g+0EViDFie6nk2UEHBY5B1oAGF7dia5k
         5X/xEOt9fbUfz1/sHoczwEBljBxGz9I3IUhDGzyW2U5uvGyzAL/4dcTtlQ9m1OZcODty
         hrYWEETesE6m8XgjemCjgadmLtBXSg3nUYXeKk/nd2NX4M5uRn+jsvNfwB2bwcooUI3N
         DveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254605; x=1686846605;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zs8DePhd2PINsPq4Z6VaoJ9+dlwdHGIeIrzanWWmBmg=;
        b=WiRXDx0HpNg8OSLO7xpByjfk8VP4yLbbNso32Z7kkYC/VD6OT50uZYPqzH2LxM93pA
         jT3/xjuhp4TzuU77UDhFUiI7Bk1SvYSqZwQ5g3LOzGJC6GAUxnTBBHXoWvqR1tBXyvpL
         6pppjNPH6glCrfYqa5hLa+J4KZTaEnWF0+lEPRGKpUXrljDOLNX7WwyMjDea5TaE1Opq
         CFZeOYnB3HhPOQbvJVphdwZXlvO6H7Ih9HuINdT7qioejmJNpJ38gtlGl8fceXkXdkvY
         U96i2ymhmqJOS74XWnwM01DuSw6r+jTjO3L3c8FIspSAl2THhSAVEg1q/lONwUYxJ9cG
         VYIA==
X-Gm-Message-State: AC+VfDxNUzPCqpNtT1hp+VVY7qOeEktsjcTaWcA8vrZe7L7NUaXp20Wx
        nWi10dhW1MpYla9cjVIScSw7Tg==
X-Google-Smtp-Source: ACHHUZ7Mgj8BULw7N8UQv15kmE4LFmuOAsssu32COH+zykLy2IO9HUu054zb3wtDCpQAHz4rhUgAXQ==
X-Received: by 2002:a17:907:7f14:b0:94f:9acc:65c9 with SMTP id qf20-20020a1709077f1400b0094f9acc65c9mr34072842ejc.66.1684254604864;
        Tue, 16 May 2023 09:30:04 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id ev21-20020a17090729d500b00965b416585bsm11236402ejc.118.2023.05.16.09.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:30:04 -0700 (PDT)
Message-ID: <05d08314-2f6f-c91a-0e8e-74fbb4dfef46@linaro.org>
Date:   Tue, 16 May 2023 18:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: tegra210: add missing cache properties
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230421223152.115285-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421223152.115285-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2023 00:31, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified property to fix warnings like:
> 
>   tegra210-p2371-0000.dtb: l2-cache: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Please take the patch via sub-arch SoC tree.

Hi, Thierry,

Can you grab this one?

Best regards,
Krzysztof

