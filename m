Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845B160E33D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiJZOXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiJZOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:23:31 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BEA1119DF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:23:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id s17so10580761qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqMNLvHQ2hWVKlzHSd00UW0qgFnV5U+Ku1OTYpudEo4=;
        b=JRWZV4zzj1C+QUy3o4Hg6Hl7KAVINoB/ig04Wx9mFze3OHESDYG41Aydp3LBDYor4d
         Cu35M805+/LwGTGokYH+Scm79ho14Wog0i1F8urzeGXB6Abzd4feOpyXO71Q/gT1dWgF
         zQtzscBAeNFCZ5wVaV0c+x7Jb+2Fl1Fehaz6UG2hlxNXh6mS55d6DoK/W+Ro9ha5t2nM
         Xcfss3pXHHJqDZo5CrTY3UIjIQL5ESexHBYfLHfObpzEJWGYnmySDvjncisGEVLqDCFV
         4zztOnLiroyJ3oKNKaRYYNxTN8XlhdSjLIPwJ8l7M8WH8kVjghLlSAFFXJQwdUnXGJ6Q
         kXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqMNLvHQ2hWVKlzHSd00UW0qgFnV5U+Ku1OTYpudEo4=;
        b=SpHyB79mnuv/xazrRsXT0RcDwOS1d7MB3YvUAcLJmt1odHp6dsmZNgY95C6FbGuoNw
         MEWbw58hh2rGLDRtETgDrMvSQpaHzT1ndrg+vV/7RBMj3RzwEUIkcsCZ3LLMOzxIdbIK
         SZboxKvONlm27J38FmVpVBd1zKXJK0mUI4HEkOEE7L5hHxrlTA66OlIVkntNxfGErEsi
         Wi+eQdcbRcw7+S1gdca/p56NoLyckDS1x4goDT6JmXXn030pVnDs8ckxhn+4gWGAatq6
         P9jYmplx6gOoW09EvasNApQP/AFAlDAlzaXdxXYvTPOn7ZIl48+cIlYMic9Cd3pNYENA
         Re8w==
X-Gm-Message-State: ACrzQf0rnPPnD/poKKPnrb8vQAMFKx8LAdpAN0ISZgS0/22D1HnNKRP1
        bVpxmu8ifovehmewovtaQV0m87+NC2lqoQ==
X-Google-Smtp-Source: AMsMyM4wVzLveUDs8MwkkI2QdIMLJxr4YRBhsXq+G3qow0kiGcjCJ274Q7QbwW3pfuvcl/dTGbs56w==
X-Received: by 2002:a05:620a:e87:b0:6f4:9c2c:c04b with SMTP id w7-20020a05620a0e8700b006f49c2cc04bmr12407111qkm.60.1666794198489;
        Wed, 26 Oct 2022 07:23:18 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id 3-20020ac85903000000b00399d5d564b7sm3335859qty.56.2022.10.26.07.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:23:17 -0700 (PDT)
Message-ID: <fd4132ce-fad8-bd33-689c-e8358b587d28@linaro.org>
Date:   Wed, 26 Oct 2022 10:23:15 -0400
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
> one comparator supports periodic interrupt, all three comparators
> support non periodic interrupts.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v4: 
>                 1. Use common clock framework ops to gain apb clock.
>                 2. This patch need rely on clock patch, which patchwork  
>                    link was "https://patchwork.kernel.org/project/linux-clk/list/?series=688892".

Your dependency does not apply. You based it on some other tree, so we
cannot even test this.

Fix your clock patchset.

Best regards,
Krzysztof

