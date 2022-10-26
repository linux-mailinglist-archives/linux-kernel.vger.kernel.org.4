Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B5060E336
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbiJZOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiJZOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:20:59 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E5DFB71C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:20:59 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id s17so10574079qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sy6g+vLLQvXjf5HeMT0nB82DeyV0IzT0a5m7Og326KA=;
        b=kqWHgM0TtbYnT+VGk2G0985LVrw6573v0G8yLnv4MUbg6OJoAxvEI+1IYOutsyx7pR
         Udq5eVMqzhxgVIM9RQsxVTJFy5Kxl+7HvEI3R50KgkV7ztvWJM5WH+t1pDJdqO12noVx
         3OYPHEGHMosO/etTmHhC2BDSHgLvoUFqcOHWRj3747uqTzeYcdnQHeiUaYA9Ce1Mf4+X
         Xbg4n/x1/D8jOo/Pu5vsIDDYuX32PZcHAGBrPIS3xnV5UTUgL8DZxqwr76MJS3XynSMt
         og5jO19h5ngEGgG3ufHVn0b/LNl5GM5XcDplOEX546aTgEOi8w6/rQCEcMHt9dCBvc1d
         mRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy6g+vLLQvXjf5HeMT0nB82DeyV0IzT0a5m7Og326KA=;
        b=LEo0sQAydWAbefmdyVVA/kiBdZkzqBCIoH6h3kDR48XD6we2zXL8hHOMSjOWahYZaS
         5+rI185d6WS716KLF23aFW64rlfs/F/RsYDSa7p0PQdB+yxrpnbKNKWcQaak9DoTkro9
         +SNAd5PLrS+vsYNxWOmgq51kgiabhkz8nSaGCzQxFYw1pWCvDwdA3F//GUpHMxvHmung
         brq2yvDjsskWuWQxWYfeZtsl8JuolCtogunDk4aI7AFZyj5o695hbL2I2KLvgPJpa3WG
         bWECTK0WGlni5nr8Ql0qPxVzUEmqZTYkw0zMD6prsUokkeJOhYTYKiv4qnffjk+70qwX
         8eSA==
X-Gm-Message-State: ACrzQf2ZITGW+urZ7UpdHpys0Nm/So6y4Uqg7mWLLwjZ13kvTGIMAy3O
        XFjyxtYPTn3TOzSh99aHvEvJ3g==
X-Google-Smtp-Source: AMsMyM67z/vs5deHpQrLUuxUi9zO4BPnIquP5aPQgFh05WhAqMhT2FBusEI/KZzRvVoj0Y2kLD7l3A==
X-Received: by 2002:a05:620a:796:b0:6ee:80b6:2eae with SMTP id 22-20020a05620a079600b006ee80b62eaemr30617333qka.17.1666794058191;
        Wed, 26 Oct 2022 07:20:58 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006eea4b5abcesm3988882qkp.89.2022.10.26.07.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:20:57 -0700 (PDT)
Message-ID: <438f5df4-b076-4920-7bb3-095041c27eef@linaro.org>
Date:   Wed, 26 Oct 2022 10:20:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/2] clocksource: loongson2_hpet: add hpet driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20221026035752.32681-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026035752.32681-1-zhuyinbo@loongson.cn>
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

On 25/10/2022 23:57, Yinbo Zhu wrote:
> HPET (High Precision Event Timer) defines a new set of timers, which
> are used by the operating system to schedule threads, interrupt the
> kernel and interrupt the multimedia timer server. The operating
> system can assign different timers to different applications. By
> configuration, each timer can generate interrupt independently.
> 
> The loongson2 HPET module includes a main count and three comparators
> , all of which are 32 bits wide. Among the three comparators, only

No blank line before coma.

> one comparator supports periodic interrupt, all three comparators
> support non periodic interrupts.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v4: 
>                 1. Use common clock framework ops to gain apb clock.
>                 2. This patch need rely on clock patch, which patchwork  
>                    link was "https://patchwork.kernel.org/project/linux-clk/list/?series=688892".

Link to lore.

The point 2 should go to cover letter. It's easy to miss it.

Best regards,
Krzysztof

