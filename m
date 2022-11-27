Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7EC639CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK0U2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0U2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:28:43 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D8DEC7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:28:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w37so3077553pga.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dA6sdJMlXl0krftJxhHNrz/rNjmyzXGJM4YxmWVX7OA=;
        b=X1hFWCkhN0a+wIZAxR8u6GwJ2l8bT3xbYoD0iI+qC2EIUcEVpV1ajKvYCinX0dpceq
         tDPqFtcVxtk+i2DT0qVqoss1LJJKX2057rGWGCK1Segk5lxsnC9WQpujxLjMGi3ZkyHq
         4fttd/cgN2OQsY9/YioKS+rFxWWsd5+188tjbtM0GM8XjPpOdc42C3VWn/T9XPRTWYmb
         2l410xNKuwQLPuPkcx8ZzEdIbrJgSBxDiUPgCnLwJcanCqLRDhog7909AAB72FlTGxVc
         qU3xZkji4ejWI9maMs0gnBRpSamjSu5bOv+CIeS1Qw+IB149+XPkxkAzTJnOdwtni0sP
         Eqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA6sdJMlXl0krftJxhHNrz/rNjmyzXGJM4YxmWVX7OA=;
        b=IRSGMbZmGCO0qr8uUiXUKcEmEtaBqPIlJsOK+Gs+E2YEp/BNE5ACEybHzRdTZpcRCd
         OgqDXZ2bfIzTQ7LZPkCnCdTYN/bSTIeEKTVUpRI1VTayC9DcXNW2DG+XkF5vLuRbTpWj
         BY8lrthMp4oKrA7sultlEswN/egHWp7bkQ+V8kxWa7J63ltymrzPWGbkTVhzdCfW8P4X
         tbxLdcoqfHKvWOmxBhB4VbVHkVu88lBcLBcMBL2XOGMQivr4T1AXagZuHKtOSPATnK1S
         gPHVfHD8jkkD/7cuzWXG8wrkqNAGgX0x0l8gGl+J7epqEbBXLDJ7hxT9hU87ei/67dDk
         zFPw==
X-Gm-Message-State: ANoB5pnH0UQUbiZGvaxQY4AYF2YhCDVBaGz20bnuazF9g25xk58nu+eU
        RTiM9uIkjTHzU/XzCS9CvVqUXfXCCpw=
X-Google-Smtp-Source: AA0mqf6cNWcCrJAf5+S9cpzMGNpgzXgo7eB72FLSid4MWj3vwt9+kKWE28/vE3O0JMDLnV35QNLX4Q==
X-Received: by 2002:a65:4c41:0:b0:477:1126:cc49 with SMTP id l1-20020a654c41000000b004771126cc49mr26083950pgr.367.1669580920966;
        Sun, 27 Nov 2022 12:28:40 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:f1fc:63fc:c03e:8357? ([2600:8802:b00:4a48:f1fc:63fc:c03e:8357])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b0017f57787a4asm7199724plh.229.2022.11.27.12.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 12:28:40 -0800 (PST)
Message-ID: <9c403170-4493-d960-b470-ba337dae893d@gmail.com>
Date:   Sun, 27 Nov 2022 12:28:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] irqchip: Allow test compilation of Broadcom drivers
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221024222749.2341479-1-f.fainelli@gmail.com>
 <87tu2lu9rc.wl-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87tu2lu9rc.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/2022 5:26 AM, Marc Zyngier wrote:
> On Mon, 24 Oct 2022 23:27:39 +0100,
> Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Allow test compilation of the Broadcom irqchip drivers by adding a
>> COMPILE_TEST dependency.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/irqchip/Kconfig | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 7ef9f5e696d3..e4b2ec9b2450 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -116,7 +116,7 @@ config BCM6345_L1_IRQ
>>   
>>   config BCM7038_L1_IRQ
>>   	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
>> -	depends on ARCH_BRCMSTB || BMIPS_GENERIC
>> +	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
> 
> Do we actually need all this churn now that OF is user-selectable (see
> 0166dc11be91)?

Seems to me that we would since that allows people to choose the 
building of these drivers rather than lift the dependencies and replace 
it with:

depends on OF

as this would prompt many users about drivers they do not care about.
-- 
Florian
