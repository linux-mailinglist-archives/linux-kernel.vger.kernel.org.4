Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE86961F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjBNLIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjBNLHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:07:32 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C728235
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:06:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so11241993wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 03:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UK/C7205cqjtXHN0YFXcPqVqX3FVcOGt0olsnjJ5Yyk=;
        b=CLgo1ipcM0SOZ3IabdPYMw8o2rBkf3OFTn96N/o33hAXz4gmWafi8sAF7sArwncwKg
         8ynnhTpG76ArNnlfoNRT3CXitVksvGo1O198b7k+WbfQNWhYQoLD+wyKsjk7bOxocMvN
         VTxXamd0Piu38SLMWqJfafPsUGmNdnWv443uSQn3dWkG73e70GqfZou6sQ6uTfDh2Zds
         mHZRAYn0y+ADObOQKpHUHZfjNXQBxX2iPjbfAeBzinqKZyToRVQCp9xdlNBRUHTLfs7x
         n5Qv+iiJTZijgOhW1tM9zK28gJKbfjokvfyNrnbMXcljzciBhyl2Gpy3UlsBq62t8HWe
         1I8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK/C7205cqjtXHN0YFXcPqVqX3FVcOGt0olsnjJ5Yyk=;
        b=T07w2ubDTRFAE3/WaDZ3eOsf7A6QAT6Cpz0WZGSMlDVmAnJsTLPqTm76auk+FeTwm5
         CPxu6kWRe38ARPBf+n8NYSE990SoGOu0IRXuZ6m5mX1podKaN8JFEt9UXVtqQT8QOg35
         bncXFFJitt9T0S16LYWnweL2MtG+8Bi7q66AIXjSdSTDpLuqDtS/jWp8Tp0t0RpfDLDo
         WukmqHs6MwWdKdbF27Jk017qqgo0t+0O3eRKfwx2nntdG9cE+/ZVgQfBJyjDweGoA3ph
         7gQPmOq6cHcPU0cn+wZ7zFplHPzCxduJg39wNEL2Fhl8sBJUyUPU5e5AByl7tJQX9d22
         tLlw==
X-Gm-Message-State: AO0yUKWzFvodMu+Kny0D9bUzTeIFnHAgh2qF+anr07HiP1ox6P+vXVXo
        cO3edwte/gA1Si69iz/FLbG6AA==
X-Google-Smtp-Source: AK7set+WCTmbzixkGjfUeksuhVmxtXE7BRFOvctWQ5bUWqHhYKmxbb7uulPFzP3KWazlMzskbho9og==
X-Received: by 2002:a05:600c:3310:b0:3dc:405b:99bf with SMTP id q16-20020a05600c331000b003dc405b99bfmr1732294wmp.15.1676372787011;
        Tue, 14 Feb 2023 03:06:27 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c2cd000b003daffc2ecdesm21019728wmc.13.2023.02.14.03.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 03:06:26 -0800 (PST)
Message-ID: <ae66a024-1901-f7db-e64b-0ceb51131419@linaro.org>
Date:   Tue, 14 Feb 2023 12:06:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 06/16] dt-bindings: iommu: apple,sart: Add
 apple,t8112-sart compatible string
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
 <20230202-asahi-t8112-dt-v2-6-22926a283d92@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v2-6-22926a283d92@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 12:03, Janne Grunau wrote:
> "apple,t8112-sart" as found on the Apple M2 SoC appears to be SART3 as
> well. To allow for later discovered incompatibilities use
> '"apple,t8112-sart", "apple,t6000-sart"' as compatible string.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

