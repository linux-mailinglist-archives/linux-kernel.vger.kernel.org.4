Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56199705400
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjEPQfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEPQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:35:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D81868B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:35:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso25785822a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684254914; x=1686846914;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GsGWeD4bI6dpV1BC9oCizIGh+Gcd6Inx+UCID/pRmsk=;
        b=dfiVEmtSSIKaB7rJeBv884PukYvSUTfyMMwWoIIKdMOM0iAPfLRtOtJa/4kQ5+YFFA
         6YPkUed/OWY60aJ0TG6pd4aRB9FInSovR0caYysrSi5Q1vo6CIExqKgRsIe1fVMbXY2r
         baUi/6pWfmh4tkNtaUHdOiuGf8FQcATt+o94oQASoE2UWCTEbw8ieIKs0HrmoqqVK3bc
         rkckI0YgAh0euncxLqxucB8nyrb1AiyxCRJXSRA/C3R5z4Nu+zl23NUFbBm4jp7dhw5R
         h1ZHbtFJWV7Z/YBhTzla4bsuuQzko4ww4rUzsjxZsL1J1gg8SvJ6RhHKYp+9LF8tbzKA
         dp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684254914; x=1686846914;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsGWeD4bI6dpV1BC9oCizIGh+Gcd6Inx+UCID/pRmsk=;
        b=Jyk3Y1VkeMmncm0iTTUE/nKn34+LkBg56UZndDfrrUlwBbAMG2qLbeEhPfX4fFCtPE
         38M4HdgCHcCyLvsClUFAdQEGOsXJlW4enfE/Xo89oeS9p5nftnH+koQ0JLKS9WteK28V
         KVSlqHe8poemT6BKEaCU1KHY9D3H+hllT2MEwOGzf9l636ZAV1dXLkaOyc/OJ4GjixKe
         zeqYdwgVmCfwPUFljczFF7FLxZSjw24HvxIgdEOtxRGzZYO5QQxg4MyHlpBwtID/59qp
         uXcAR9y4RBxzVEtS2ht+VPxGZNMk1vYlz19q/kxG6F3eEAzYYsyPHxoXVbjxF5CoFRsO
         yAXw==
X-Gm-Message-State: AC+VfDwsJFxipxY4RlfXv2RaE6eVu4WZZlm143eHI6kgfP+CA4uW3eYD
        1fcO/orIl0LwDebT1WfO5rWlgg==
X-Google-Smtp-Source: ACHHUZ7Efc971yqkR23m0IOPewDkI6jDvdPI/r84BYakaawfR2EO4wENe/0gUyH8nOi54NY6Q63aog==
X-Received: by 2002:a50:eb03:0:b0:510:8f8d:967e with SMTP id y3-20020a50eb03000000b005108f8d967emr1241142edp.5.1684254914398;
        Tue, 16 May 2023 09:35:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7ca4a000000b005066cadcc54sm8203680edt.43.2023.05.16.09.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:35:14 -0700 (PDT)
Message-ID: <d1cd8378-132a-189f-5654-efa4de56a576@linaro.org>
Date:   Tue, 16 May 2023 18:35:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: allwinner: a64: add missing cache properties
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230421223137.115015-1-krzysztof.kozlowski@linaro.org>
 <2676764.mvXUDI8C0e@jernej-laptop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2676764.mvXUDI8C0e@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 21:59, Jernej Škrabec wrote:
> Dne sobota, 22. april 2023 ob 00:31:37 CEST je Krzysztof Kozlowski napisal(a):
>> As all level 2 and level 3 caches are unified, add required
>> cache-unified property to fix warnings like:
>>
>>   sun50i-a64-pine64-lts.dtb: l2-cache: 'cache-unified' is a required
>> property
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

So this ack means I should grab it? Ok

Best regards,
Krzysztof

