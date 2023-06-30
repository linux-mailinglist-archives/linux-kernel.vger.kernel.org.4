Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E2743946
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjF3KXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3KXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:23:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C872D55
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:23:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313f18f5295so2009890f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688120607; x=1690712607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VmdXzmCC+XSRpl2cZcrWSADrZXdjh9tEbqph0HmuCQY=;
        b=QKaSmWjPqYx99qSfHAtLNJoZP4nKQuLK4PLwpaXl0XFt0h/HKgli9EH/4IT3ZG7GaA
         jC0nGmW1PDr3tAiVGd+brLdRpXnPgKiEyeErmJrpCvSLTN/iflGpFxZRwin7dH6N1nKk
         LZmDKCFdPogymoQ3fJso7T5ITuxwtKVpoAQSlF5a5/FILPvSWHKXUKynXXENNbgzrpaR
         nuslvQ8nRQ5uYatoyoCmK0iSAgT02LX0ztz111DTRQ8pMBTOvCtfLblRTPRsH8Dd26Oe
         WfJJKeVjJTmv4x2oVLZWdMXRiw4YXlLrh378LYe1d7f0ioJqyvli1tApt0O54BPMGXNS
         zFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688120607; x=1690712607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmdXzmCC+XSRpl2cZcrWSADrZXdjh9tEbqph0HmuCQY=;
        b=LM0oxTmMh571iJQQPKMPqWeJzjLBDFETqAr/96JtgmaodTI0E9TFKKSQc52Aj6usyc
         AGfPH2Mb8Lnp6JjT793QqNlfSNC05LMPcW7NgQATHKETebdDUSgoAoZosmGeCP3JUnMN
         tCHzaJVUZFldGP4FBMOxFv6tV9mfEjdk+gMgxbGLtLTm8ccaeTOlFFxMJksj+s7J3hAx
         brNFOsmtinhlck44dY9z9aKFmkTf9CqiXBKbu7mNXQAs8Ap4gs4nyfgG0MYhHZtkT45M
         ePgvA7mIyGe0ctTZNSq+d6g0LhP2kv5Q6L9P7aju6cS8InrWHGLlPxwcF8wBKq98EzPA
         HCig==
X-Gm-Message-State: ABy/qLbKu8aH22P0Vc34MEzWSzDv9IneFHUll6Tc2A868XEET1qC+wIJ
        ShHfPSPuuMoLIk1tYGr5mnTg5Q==
X-Google-Smtp-Source: APBJJlHNlHGSGUNDtuzzpwr9a1C38q/cF6uAOct+WK/H0b/GPF5GwP3waQft9qz4XvRy//iHgUgIQg==
X-Received: by 2002:a5d:4804:0:b0:313:f1b7:c229 with SMTP id l4-20020a5d4804000000b00313f1b7c229mr1597471wrq.66.1688120607485;
        Fri, 30 Jun 2023 03:23:27 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4d10000000b00313eeca9f4asm14336264wrt.14.2023.06.30.03.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 03:23:27 -0700 (PDT)
Message-ID: <6ca04dbe-572a-0f22-ad5f-c93d95f51cf6@linaro.org>
Date:   Fri, 30 Jun 2023 12:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] irq-bcm6345-l1: do not assume a fixed block to cpu
 mapping
Content-Language: en-US
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Simon Arlott <simon@octiron.net>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230629072620.62527-1-jonas.gorski@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230629072620.62527-1-jonas.gorski@gmail.com>
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

On 29/6/23 09:26, Jonas Gorski wrote:
> The irq to block mapping is fixed, and interrupts from the first block
> will always be routed to the first parent IRQ. But the parent interrupts
> themselves can be routed to any available CPU.
> 
> This is used by the bootloader to map the first parent interrupt to the
> boot CPU, regardless wether the boot CPU is the first one or the second
> one.
> 
> When booting from the second CPU, the assumption that the first block's
> IRQ is mapped to the first CPU breaks, and the system hangs because
> interrupts do not get routed correctly.
> 
> Fix this by passing the appropriate bcm6434_l1_cpu to the interrupt
> handler instead of the chip itself, so the handler always has the right
> block.
> 
> Fixes: c7c42ec2baa1 ("irqchips/bmips: Add bcm6345-l1 interrupt controller")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>   drivers/irqchip/irq-bcm6345-l1.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

