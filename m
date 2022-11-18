Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74EE62F7F2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiKROmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242646AbiKROmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:42:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481D9532EF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:41:49 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id b3so8545141lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2thmbb28/ZVq6zR0dXPjXeaM3XqjzR2UoNfuu1A+yxY=;
        b=Wh3kz+U3TyES5kVivDFaHBtLFLL/dvPdqDu57smkC6Ph7w7BHKysZMZFhvdXOPuWrW
         Lw8LL84mX38YNKRs3pGwg+Tia/zAFhgcC+1DESyGm5BTi0EnPUnhZ4QHLyyv+0OnhLam
         E3uRYDAR2Os7JpQ0LIhBcgTFaVW5dZNYTp7ZKIyJBX5G4OWwRx1TtogVVoI1kX2CEjrs
         do4Gplx2RwG3okWsGte0NBKp5hVJfTJNt4dRG/5I6q35QXlZIog+hjsX/ykg9GuvhRxD
         47ZlAGzhacUFb32wS7j+NxIQTok5x1gIPOFsudtg8U/R9BKtPU6lhsd4s1bKjF2cUdHM
         ohQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2thmbb28/ZVq6zR0dXPjXeaM3XqjzR2UoNfuu1A+yxY=;
        b=EcGRkNohr2fIKgnNlFWjMNr6Z2BZi7P2IS3jFdAfiU5/8A759QRXXEw7f5I42PjZPy
         MFnDqkO5yXX5nEUkzdKsKbpxt1ji7PaaNwCIHoP+JwBZImqLkYWzDCUi8hNAXth/nvPz
         3NOBHHm63fVbuyHr2MVjfWENzwgptGd1sBENrOIk5+BG78FZQcq+67VBE8fM/fr7rSDD
         uogpOgY/Q8W7Mp9P5+A+/TdsAg88EBBdkJyUSUOmtUclLMXKgt08k2aSz6FkZEFoYF3V
         ZbErrFgvrQ+Of1YmCqRGpvlTd3v9kJOCybirMtMuEQIT3AQo92a7xEVhIlDGIq0RVhw5
         /JpA==
X-Gm-Message-State: ANoB5pkqahgzRZFsRottH5zjLyy0A5dFy9c6FgUyXhCe6A8EFXecC/6u
        roFbde+fg9IYAlGf90vEGwTxAA==
X-Google-Smtp-Source: AA0mqf4LXWW0epb2vwZAvgtK7zqnLsqEffcVxq2B14gkeFCPgUZ7Zh2t6XvOeZxpFU2hG+5fuwFCKg==
X-Received: by 2002:a19:7706:0:b0:4a4:6991:71c4 with SMTP id s6-20020a197706000000b004a4699171c4mr2681393lfc.355.1668782507612;
        Fri, 18 Nov 2022 06:41:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v10-20020ac258ea000000b004b0b2212315sm686134lfo.121.2022.11.18.06.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 06:41:47 -0800 (PST)
Message-ID: <af7f1b14-6b46-54af-19fd-de8d1de535db@linaro.org>
Date:   Fri, 18 Nov 2022 15:41:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: lpass-va: add npl clock for new
 VA macro
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
References: <20221118071849.25506-1-srinivas.kandagatla@linaro.org>
 <20221118071849.25506-2-srinivas.kandagatla@linaro.org>
 <c3a2316f-2956-6417-f1ea-a6a64df037c6@linaro.org>
In-Reply-To: <c3a2316f-2956-6417-f1ea-a6a64df037c6@linaro.org>
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

On 18/11/2022 15:38, Krzysztof Kozlowski wrote:
> On 18/11/2022 08:18, Srinivas Kandagatla wrote:
>> LPASS VA Macro now has soundwire master to deal with access to
>> analog mic in low power island use cases. This also means that VA macro
>> now needs to get hold of the npl clock too. Add clock bindings required
>> for this.
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


... and not.

+        clock-names:
+          items:
+            - const: mclk
+            - const: core
+            - const: dcodec

This neither matches DTS nor driver. Did you test DTS with the bindings
change?

Best regards,
Krzysztof

