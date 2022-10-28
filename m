Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1573C610FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ1Le2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ1LeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:34:25 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E441D1E32
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:34:24 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id g16so3263530qtu.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rt9We+bdFCOM6MYPx3GfU2X+tmzaOyqM9y5CbRGQOvs=;
        b=WAzJ33H4XEjVkUng4DugDH4uAkLn856Igs2TsuSMBhLt1ArrdJsd8iOPfzLnCYr9mv
         jp4iHcPMm4vJR1lcoP9SOsGSC9g7xW2Ysvh/C4MDE4lV21jhjpbF12rIAWCLJzDddS9h
         u3gLaAmi/UR+q1gjRD+HJ5fzjkLOjCKVbHpgc2hjbi5xLgxm6IVEdQzBYpgulMO7TCpD
         /qnJdwPaFCW0cFcFGXzaPoDDg1OzSxFj9AOp4gukxTrfqJKLESQCVXRapp62VQwoALMP
         8rZEEBgbqgtENXUPqhpm5OSgeOdynKERhnebvNbc2JdP6NpDHGk+JERJB670/RiS8efC
         25AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rt9We+bdFCOM6MYPx3GfU2X+tmzaOyqM9y5CbRGQOvs=;
        b=MY5dKEQB0Mn2YkC6fexWOErqzRN4bSDumyaokufArYsggLA6rpnM2WYRjCo45yxgD7
         UrERf3HpXlxX1huITDZwE63CGTwxVqBub46U0RZW/KbHnVrThQPHIbqP2q1EzW3GLG2u
         zpB6WJqTBf/WemkZngsR8F19OuYFx/INmjF9iiktUOm2mmCd4eaT0RZLXfk7OGdRoiyh
         JdcTDJIS34q+Bdg5vwtOOZEI8ANnv7VijMLElg+w/Uh8wmzI8FvsH9r95C+Y+j266WFU
         GKnCAVMkDSXopj0WSQpwzDux3KHnhhlLfzQqyhAw/GIa86JiGEt1iuxNCxo/jqn6R2c/
         1VHQ==
X-Gm-Message-State: ACrzQf1JQJguCAQ4TF/q9EwxrHBf+JbkBqkgxQvDa3msyeDLghcJwjPB
        IneXVjbe7CRvy1S7pgUBUsQRYTel5Q6Lww==
X-Google-Smtp-Source: AMsMyM7133VH+iawxms9jEJuJhxO4MT89rIyr0tQ945QwbBBADGYZQoPIILzZ0JmAncHItSZvvI3Fw==
X-Received: by 2002:a05:622a:342:b0:39c:f1a5:7333 with SMTP id r2-20020a05622a034200b0039cf1a57333mr44104050qtw.505.1666956863767;
        Fri, 28 Oct 2022 04:34:23 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id 184-20020a3705c1000000b006cf3592cc20sm2701958qkf.55.2022.10.28.04.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:34:23 -0700 (PDT)
Message-ID: <0fb95197-bde3-01be-874d-1b1a993ce58c@linaro.org>
Date:   Fri, 28 Oct 2022 07:34:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 1/2] clocksource: loongson2_hpet: add hpet driver
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
References: <20221028073222.21609-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028073222.21609-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 03:32, Yinbo Zhu wrote:
> HPET (High Precision Event Timer) defines a new set of timers, which
> are used by the operating system to schedule threads, interrupt the
> kernel and interrupt the multimedia timer server. The operating
> system can assign different timers to different applications. By
> configuration, each timer can generate interrupt independently.
> 
> The Loongson-2 HPET module includes a main count and three comparators
>  , all of which are 32 bits wide. Among the three comparators, only

This is still not fixed.

> one comparator supports periodic interrupt, all three comparators
> support non periodic interrupts.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v5:
Best regards,
Krzysztof

