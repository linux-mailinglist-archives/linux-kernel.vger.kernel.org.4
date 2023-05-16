Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E08704788
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjEPIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjEPIOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:14:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133B40C1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:13:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso2553075166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684224838; x=1686816838;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lj3Qee7I1DqHX3iE2V1/eDMAAPnia5Mrja+K3B6fCN0=;
        b=v0Gfj6SyCh7dP8UQPg7f5xW9zWuhSGt51yv7j7BiQK4ytL0CiBWgT2jDeovohlq9Hw
         jp3po2kaW2mHOkmv0UfSADTTKMJCo1FyB9oZmb8MSZhu1Ee/YwmyIB2d8gpbXULcufu5
         xx4ymrCPQKUGQI8HicF9Cd4V5aK4dICSJfXsffdHRbs6VwVAOs+O/zBrp2T9h+0cNGU3
         73UUq3Hk+5t7l7D3NbC6fIORw+eBn+ugTxeMRzVffdQm+NInJOuf7VtvsBIe8x15sKqM
         g1JAZYpEOygCfOzG69zPO514fOjVuj6a7jJp21x5DaiJAFq9sQvfd2cGzqAvW7ANy/d8
         +HvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684224838; x=1686816838;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lj3Qee7I1DqHX3iE2V1/eDMAAPnia5Mrja+K3B6fCN0=;
        b=iWrzTRSHLMnvvmGfY38wfLQePtI7a9424qI/bxGA67Ci2DHkA+YLoxstUhBMOWx94a
         bHjysbZCfTHbUE6s3D0PIxbPUodsWuTYsSipF0Z37PheNO+Oq5m8vUIB/xW/hYDJRsCc
         nvMsCkBrXsToSN0Qd2We1vq3ahMlvfB6yzAQdwlIR9C1NYG5JiwSP0/KtKp++TZ+0kw5
         SqDGl60yLVJT1cM1UyV9tDHICfRZ23SlVWIcxN15uUZNgev75oRhaMCNRPJbWhtzCNz1
         UhW58khATgzXRK3LwUo8P8eZwCwrz9x+1D3VMRx56M6sKwNcEIZg+qFgKpLaOcWl8fPa
         uGrg==
X-Gm-Message-State: AC+VfDzsM0+q+N7mxjLsV2YtEuMiNtqwlmqw+NGPCz82VKpYfkmsK5B3
        HFpPIFF3yhPlnR8t/EborHrJjA==
X-Google-Smtp-Source: ACHHUZ6ZnmSuHolDYS7+IxqHFlvTopiIXdz7o7ZKRY5vLLeZmDFuZbsDSvyaaR9ddGPlvDUeWVRNUA==
X-Received: by 2002:a17:907:6da3:b0:969:9118:a991 with SMTP id sb35-20020a1709076da300b009699118a991mr27564806ejc.42.1684224838234;
        Tue, 16 May 2023 01:13:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id mm30-20020a170906cc5e00b0096595cc87cesm10689220ejb.132.2023.05.16.01.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:13:57 -0700 (PDT)
Message-ID: <99e39fb6-26e0-eb9a-3c07-e07d1fa4122c@linaro.org>
Date:   Tue, 16 May 2023 10:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] dt-bindings: touchscreen: add virtual-touchscreen
 and virtual-buttons properties
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v2-2-f68a6bfe7a0f@wolfvision.net>
 <58c8b822-8b47-3269-3b78-334b53c20bff@linaro.org>
In-Reply-To: <58c8b822-8b47-3269-3b78-334b53c20bff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 10:10, Krzysztof Kozlowski wrote:
> On 15/05/2023 17:00, Javier Carrasco wrote:
>> The virtual-touchscreen object defines an area within the touchscreen
>> where touch events are reported and their coordinates get converted to
>> the virtual origin. This object avoids getting events from areas that
>> are physically hidden by overlay frames.
>>
>> For touchscreens where overlay buttons on the touchscreen surface are
>> provided, the virtual-buttons object contains a node for every button
>> and the key event that should be reported when pressed.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Apologies, second thoughts - why calling all this binding and properties
"virtual"? That's the word which immediately raises questions, because
bindings are only for real things, not virtual.

Touchscreen is just clipped, not virtual, so maybe "clipped-area"
instead of virtual-touchscreen? Buttons are real, so maybe just "buttons"?

Best regards,
Krzysztof

