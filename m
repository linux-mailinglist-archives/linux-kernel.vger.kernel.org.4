Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54776971C5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjBNXYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjBNXX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:23:58 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A09612F19;
        Tue, 14 Feb 2023 15:23:57 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h24so20177774qtr.0;
        Tue, 14 Feb 2023 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTN7fp0m6UHSMc4d2i7TBlrITdexu82oLTWNBs1YaKc=;
        b=knksOGW3+SuE4uYuOWNH0orSC0Cc7YpzDKwtwCK3V/wQdPCrrCVtQAG/EtFpiwwF+M
         Vo+4sc9xEOcilUUGVxhslPtCLBxrmEy07ZRanSDoXxAt7X2xarvxTbEd8LxQjqJTU0Fa
         3lInhEMLOAc1cGrl2HCOiLu9zhXmwQRmMiIs0imKVahT18H1k6fFQgNjzctEhWiireWo
         5aYsZ7GiQzh8RZe++JZRUBMLMnOY/OjlbBrpSY/j8TK+jtex/RZ5RmIphms+3nCrkyiz
         CnweQnC+P/Nt+uxXcIrfkeSrIVn9yqBT4R2GWaLMYKYwiqc8tFGOBpyyoGPoKyFX/QOY
         rIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTN7fp0m6UHSMc4d2i7TBlrITdexu82oLTWNBs1YaKc=;
        b=HXHvLqpyVFRdqymzYUxE9LgFH1b7wHtxMmG3ahQw/12+/L9IZYWquzvjgAAR6NzKpd
         IsepgV+ZxTpSBQ8vSpnov8fAYN3kpYODrzOH+sDSQ34MxWaDLlIR8tUir4uZR9ZpfREd
         V6BvUzWzFRKtMYX1ZwAwXEnOHZ0VVYVTw0p784NAg56/FG50QLwbf474GLqY4B1WLA0k
         O+tPH7WqfqLuaDipmy2jzq7PzotzJEXpXlFHrBVBOKYAmioaKt9zw8QVNFkkgcQKGrVY
         wsFJ/rzVhHtFCoESzFrTG2wHSOkERB1tfoig/lN7NhkffxkdvJVCNsRLuMKy9SFHNjtl
         YiMw==
X-Gm-Message-State: AO0yUKV3jV1BVoQyiM3Et1VaFWAmYlmuihXDPCgAWttFYytBBJVyKj9I
        e2ATGqYGz4TObKdh5L2ByUDyRGhfgBjgcg==
X-Google-Smtp-Source: AK7set/TMZdEZoNohzkJ7UjdoZzFQDtUdM6DlJoXM9FSPQJCVIxFeu4n0chTXrFaakrAtzDcN9shOA==
X-Received: by 2002:a05:622a:343:b0:3b6:5fc7:f554 with SMTP id r3-20020a05622a034300b003b65fc7f554mr1112530qtw.7.1676417035969;
        Tue, 14 Feb 2023 15:23:55 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r21-20020ac85e95000000b003b835e7e283sm12093762qtx.44.2023.02.14.15.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 15:23:55 -0800 (PST)
Message-ID: <5dbea804-62f9-d618-89c3-f4ee9e76c087@gmail.com>
Date:   Tue, 14 Feb 2023 15:23:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Couple of Broadcom L2 driver fixes
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
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
 <dfe3b3db-88e5-4d18-e8d1-7d1dfe752a9d@gmail.com>
In-Reply-To: <dfe3b3db-88e5-4d18-e8d1-7d1dfe752a9d@gmail.com>
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

On 1/25/23 16:10, Florian Fainelli wrote:
> 
> 
> On 12/16/2022 3:09 PM, Florian Fainelli wrote:
>> This small patch series ensures that IRQ_LEVEL is set for level
>> triggered interupts in both the irq-bcm7120-l2 and the irq-brcmstb-l2
>> driver.
>>
>> Thanks
> 
> Ping?

Marc, any chance to apply these two patches? Thanks
-- 
Florian

