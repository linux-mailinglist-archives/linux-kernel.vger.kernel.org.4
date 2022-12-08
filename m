Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD674646AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLHInQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiLHImt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:42:49 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E00D63BBA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 00:42:32 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x6so798030lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 00:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JXSdHdsZyWboxcc4iAxVadlzgqEqol54wNICne1rTk=;
        b=th/cQ/Xki2PinQ4rvmHgqq6vBUyPMQ2tK9M0iaeAMhphucgEarZiLOb6EdLOmHPseZ
         Sih/rFRacj5qvLmUAzhvvNHqYQ1lT3XK2Yzs9NVb/NKXriEaMLGnD/aVS8L0j5NiP5SH
         RXHxyLk87Pko8lfqPvETij0WYo1COXq1L8iTJG3LixUheqeNZFoLXmpYmDIv36blZ4D9
         sVPhLVGBeb6w9S1io2xRAc8g5/Nh9eI7ZZSKg8dwVXv+2LxbeF/cHHNJkMDT8/nM62Ds
         fCx6RjC4g4BMpcN0Mv0AmAQlG6fyEZOs2dpJBBpQjJhKrcEnhR8PX7IH9b/Puo3fiqMZ
         FUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JXSdHdsZyWboxcc4iAxVadlzgqEqol54wNICne1rTk=;
        b=g1pDhsbFz1ZtYKQ4xb8siJcGX+gMP5obmAssFFoy6xw2top5mcsAXc4OmC4ge3dAsb
         LmToKtotGEpJRtz/y/XvvWswq2gcHPFHjzqC00ZBbdbpZNNQFfLiUje6CiXyyn6qnYx7
         MF3SlF0xQebb0uUQGV3BWd03eJvNoO/nDN5hgRyDSs0KOJKBSjQnVpvAFaA5tnXs1qRb
         qq5Ec/9gFVZgl4EK6SfMHfwB9gXemwUZzHWFEQfI9EKG0eWdPj6noqY1WmUpmlNZnG4B
         20QzwoA/MS/lIsRSJOWQdTTuRPlY2ez18Xi+Vq9DxHneZGaMPjUBBfo6l8JdeXDgqV+s
         cXHg==
X-Gm-Message-State: ANoB5pkwekKxbHym+91zNHQx3VaIrMz22O54pTgMFyaknNFhV67ko10a
        oMIHTZESroiij1NtcYnK8jR3EA==
X-Google-Smtp-Source: AA0mqf5evXYhwU40YYpCfkkHg4wvHU3QopufVcNgs8yDz9+CsGE7KHBp56ZzBRVAUHudXSz8Ro8UHw==
X-Received: by 2002:a2e:9415:0:b0:279:82f1:f858 with SMTP id i21-20020a2e9415000000b0027982f1f858mr18974012ljh.336.1670488950391;
        Thu, 08 Dec 2022 00:42:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z15-20020a056512370f00b004b4b69af17dsm2824769lfr.214.2022.12.08.00.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 00:42:29 -0800 (PST)
Message-ID: <6604d25f-f5f9-332d-bd2d-08706380c935@linaro.org>
Date:   Thu, 8 Dec 2022 09:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] dt-bindings: interrupt-controller: loongarch: Fix
 mismathed compatible
Content-Language: en-US
To:     Liu Peibao <liupeibao@loongson.cn>, Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221208030208.10841-1-liupeibao@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208030208.10841-1-liupeibao@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 04:02, Liu Peibao wrote:
> The "compatible" doesn't match what the kernel is using. Fix it as
> kernel using.
> 
> Fixes: 855d4ca4bdb3 ("irqchip: loongarch-cpu: add DT support")

Really? You just added these patches...

1.  In the same time Loongson people keep pinging for accepting these:
https://lore.kernel.org/all/e3bf1f8a-e37e-46e3-f9b3-20a9031d49e2@loongson.cn/
https://lore.kernel.org/all/f5d0f796-0147-8789-5bed-edf38b28229e@loongson.cn/

All the time - several pings, every week.

2. In the last weeks, two of your engineers sent the same driver
(Loongson I2C) in the same time, with different names! For the same
hardware.

3. Several other patches from Loongson, when posted on mailing lists,
have multiple compile warnings. This suggests they were not really
compiled properly (with different test configs, with W=1, smatch,
sparse, coccinelle). There were so many compiler warnings, that I assume
your patches should wait on mailing list for two weeks before starting
any review. Otherwise it's a bit waste of reviewer's effort.

Patches are welcomed but all this points on poor quality of submissions
and sending anything, hoping it will get merged upstream, regardless of
quality.

I appreciate fixing the patch fast, it's a good sign, but maybe Loongson
could a bit improve internal processes of review before sending and
pinging on mailing list?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

