Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8467C15C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjAZAKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjAZAKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:10:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B4561D7F;
        Wed, 25 Jan 2023 16:10:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 88so69116pjo.3;
        Wed, 25 Jan 2023 16:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lpfrda1zRE96kSkNyEsDeHnT71evIjqpKMIG3ezgkc=;
        b=FB3PkNhxUK3HzQDIXlM6iMf3wuWCwmrafyI+cW+b6FF/eLByTXeYgEGpFOfTB3pzyM
         AzyaE3UXiKg2S2aizpTzspGre/8blLxlQ5gbBWQA7GXZydHPufbaoU9oC96Anamikij6
         IGQ5BYM19w6Wt2y1B3FMONruhakDSfHdRkz6EW5zXDFKORVnIcLi0SEstODSeVxZhZOu
         0XJGC6gXYsOCFag2m9p0jGV0ntCPgMJuQyP6U6vymtrMZB18dQo30PKP9PJcHFbA1ne9
         sLpn7TCB97bZkNSAOYvaoA2yErqVjUas6NdU6FNTUgrYERvJwqFuLwzyArVwwMXYDoi/
         dU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lpfrda1zRE96kSkNyEsDeHnT71evIjqpKMIG3ezgkc=;
        b=mLIlP9/JeW8PE+lCxM97IdeB0rSLYJVtbM4O4MW8xGG06pILSBi/kIRyn5JVloqNLn
         GA5RGcbrroL3VO/ZerjD354i2klkqewwq17TBlViytdFReRM8hz+qkmlZDOO6zAQ/YWW
         jJDVNtdDGWVzP8TDt/3PL5NWSZynkxT81gms79HLASETNwMccUgZ3AdpuCg1tp1Mh7de
         9y4xApvDem8ANyoatkdvF/UKkLHW9YIzSdWaHqXTlXEM1KTi18Ks0jlvugKN2gGccGfZ
         JKfaLoC7JwogLLFLTFpADYdKvWGfmjRDUGEXmoKSxxClwXgCI7OiR19f3q6RNYcjkDox
         e85g==
X-Gm-Message-State: AFqh2kqUozTCv7cFn1Fitm9WYikjiSvacJs4jU3ZkqBz1yLiWZxkVXr9
        paUafDB/+DDmtHSupRlhxiEGCCS/pJg1zg==
X-Google-Smtp-Source: AMrXdXuACeXqD7ys+1QLiqH5CAxtIoN8wsd5PqU09xdBOzjVtxDrbIS0VPQl6faiDn13xW0SfoIvkQ==
X-Received: by 2002:a17:902:8d94:b0:192:d9dd:167d with SMTP id v20-20020a1709028d9400b00192d9dd167dmr30322952plo.43.1674691806199;
        Wed, 25 Jan 2023 16:10:06 -0800 (PST)
Received: from [192.168.1.106] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902b10a00b00192fb119eb2sm4246997plr.54.2023.01.25.16.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 16:10:05 -0800 (PST)
Message-ID: <dfe3b3db-88e5-4d18-e8d1-7d1dfe752a9d@gmail.com>
Date:   Wed, 25 Jan 2023 16:10:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 0/2] Couple of Broadcom L2 driver fixes
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Doug Berger <opendmb@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:BROADCOM BMIPS MIPS ARCHITECTURE" 
        <linux-mips@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20221216230934.2478345-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221216230934.2478345-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2022 3:09 PM, Florian Fainelli wrote:
> This small patch series ensures that IRQ_LEVEL is set for level
> triggered interupts in both the irq-bcm7120-l2 and the irq-brcmstb-l2
> driver.
> 
> Thanks

Ping?

> 
> Florian Fainelli (2):
>    irqchip/irq-brcmstb-l2: Set IRQ_LEVEL for level triggered interrupts
>    irqchip/irq-bcm7120-l2: Set IRQ_LEVEL for level triggered interrupts
> 
>   drivers/irqchip/irq-bcm7120-l2.c | 3 ++-
>   drivers/irqchip/irq-brcmstb-l2.c | 6 +++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 

-- 
Florian
