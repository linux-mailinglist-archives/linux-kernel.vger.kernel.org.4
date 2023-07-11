Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06874F000
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjGKNSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGKNSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:18:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5533912F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:18:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so8332313e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689081482; x=1691673482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1M416nxinRPhMN72vt3UGKfG1j5hFyRnFIH3z1K8CY0=;
        b=mLWHy13gnfEODDnVaE+Cd9BMvRPT1potqsYTW7tW6KH3+OCJNqCXPRfpaKFPQ+O6UK
         At5idoRZXXjHXtri/l0U9ytWKOn362jHTwRZIykgJvLMO/RG5uVUhyXEcs1S3qKWpD2R
         7LGVvosyn4tDvneqDBHdUGMIfhuIzIv5iBCDtnwoKoy3Ae2L9x3tlIzXn8vIJUBsZ8wb
         g/7SepshLR7SY7Y3uMMbftC1vE3RAMMgAF/Hs3rSfQbe/pWg3wZWQKwb56YZqhQesCPn
         zZgUHjvpiMy1+qxFHWMdS23fuvMp9YWI1rpkyQs02ronAbtT23DQHtVH45WsEpuFvtx7
         0DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689081482; x=1691673482;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M416nxinRPhMN72vt3UGKfG1j5hFyRnFIH3z1K8CY0=;
        b=U0GGJuAjpghB5wO4xogiNS2xnz+08MIgReb8P6BlhMdcbIweAH/Ums2u7z3E3EFxT7
         cV1iBO31maidSKEU++itG09ewLG1Zgq3Cx0iqWttUnpss3l3LHobJvGOCubmzhrRSXkI
         ftpHhBBrcScrwcDExOD0uOO+IgkvGLIkRQo0bGvxNLXhmyDsckC1l44Y1lT1HDTnAJH3
         8Vr1ruZv82eJrukriMrNdIv0/ByPKbYaN9nGR6CQevuQAzB07H1CViALRL98aoysB0qO
         5ybZ/ssXFodCobj+hxWtp75liJ4KRYdkHtxKd/FDeGGdDicbXJVqZdIB3+D15FbmwdHk
         SX7Q==
X-Gm-Message-State: ABy/qLZBVNPu9RHuNMAVRhKckCFF11IhqCrjEWYD5iAGGsiXNSVTOhua
        iPcRPv+24q5lN+KSVbgnwmoXo1x2ZJqPN3NZ+f0=
X-Google-Smtp-Source: APBJJlG4jJrWm0lu72w6bT3WD8bOW7mvytM/mXWOJRIPSonej9X8klrk5olkHCz3glygAVziSdytAw==
X-Received: by 2002:ac2:4c52:0:b0:4fb:85b2:cf78 with SMTP id o18-20020ac24c52000000b004fb85b2cf78mr15387499lfk.37.1689081482480;
        Tue, 11 Jul 2023 06:18:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
        by smtp.gmail.com with ESMTPSA id q16-20020a056402033000b0051e2a1502a1sm1239244edw.68.2023.07.11.06.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 06:18:02 -0700 (PDT)
Message-ID: <9a20851f-7981-bf31-eed1-7dd77528ca02@linaro.org>
Date:   Tue, 11 Jul 2023 15:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] irqchip/loongson-eiointc: Fix return value
 checking of eiointc_index
Content-Language: en-US
To:     Bibo Mao <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230711120807.1805186-1-maobibo@loongson.cn>
 <20230711120807.1805186-2-maobibo@loongson.cn>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230711120807.1805186-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 14:08, Bibo Mao wrote:
> Return value of function eiointc_index is int, however it is converted
> into uint32_t and then compared smaller than zero. This causes logic
> problem. There is eioint initialization problem on qemu virt-machine
> where there is only one eioint node and more than 4 vcpus. Nodemap of
> eioint is 1, and external device intr can only be routed to vcpu 0-3, the
> other vcpus can not response any external device interrupts and only local
> processor interrupts like ipi/timer can work.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   drivers/irqchip/irq-loongson-eiointc.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

Fixes: dd281e1a1a93 ("irqchip: Add Loongson Extended I/O interrupt 
controller support")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

