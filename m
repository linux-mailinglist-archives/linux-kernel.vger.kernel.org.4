Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AA5B895A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiINNnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiINNnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:43:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7432062
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:43:45 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id e18so5431765wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=W8Z5kpkd0SkrtJbwd2sn9XnWAgVawbNE74OWYqDPa98=;
        b=zDxi5YU9rpc/P4/4ACTVR03sZ78dlhXoiEg34DwutUm6Y7Znn6dc16XF+EHNHNq9KX
         SHExzteZmUcTl6QI5k6gjsCgZ40uZsg4XLKS5VwAv37R3e71UcrscZUPrlHw3mHwy3FV
         iawvf2u0uXqAQ/eNNa5mA25uWha04CPctgcf0GjHgdR5GckSbrsmFgM6WU+UArRyRnMZ
         dGEqY1uh35f0s9J9IvqYGKlUxdKYNVImopoNfYbK+bTzANY9djadDB5F764DsnSVBlPM
         iTAvh4Dkh475zFWTNpsxO3rU0YUWMdRrD+rYrGIhW54xzzosDOAc+57RtNZlwTE/icJb
         XkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=W8Z5kpkd0SkrtJbwd2sn9XnWAgVawbNE74OWYqDPa98=;
        b=at+RNpHg8RQsAKbRs7AONmcIeqaBdDw/dPAvB6bZHEzK2BWzp5Vie33oajRmXAM6Zt
         hzNugDIhCZ5yd/W6OtGPjInl/1Ae9wjDJCcGeQotM05zTS4k7hxVqWQc6S/zbedhY5e1
         t5ZeM1h6mEdxU3+myZCytB9pRY9BNPGiwcot5+UIzZx1CXE+Ek57v+IfzGzMHC4rv2yY
         XlJT4YprhKM9A5715rxTfI5ONAts5Z5y524bmVKLJxRU9GfBTy8O5JNoqXJkf+2V7Qtj
         edIAJVQFl1dweJE5UmcnUNtZyH+KHrKHVelwOXfad2bh780+EGdrlurcFeJKGA9opcOZ
         wOLw==
X-Gm-Message-State: ACgBeo1qVTd0TbUzsYx0yudQDG3RyPfC0X/SMoMsCN7xwTG7Jbci9GZ2
        6jrnaaenAsnU62qcU0hwWYjUdsJHwMw3T10H
X-Google-Smtp-Source: AA6agR7a984bJVGvmq0/C97vtjeKUz6al+EhhC8nG4zQvtRSp6gdWlbRjqVgKOQbzZYDdWgdu7P1eQ==
X-Received: by 2002:a05:600c:3483:b0:3b4:99f4:1191 with SMTP id a3-20020a05600c348300b003b499f41191mr3091710wmq.147.1663163023407;
        Wed, 14 Sep 2022 06:43:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:375e:b940:b903:7792? ([2a01:e0a:982:cbb0:375e:b940:b903:7792])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6786000000b00228cbac7a25sm13527031wru.64.2022.09.14.06.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 06:43:42 -0700 (PDT)
Message-ID: <b2b9284d-0e18-0f4b-a41c-bb251f9de591@baylibre.com>
Date:   Wed, 14 Sep 2022 15:43:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spi: meson-spicc: add support for DMA
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220913140303.437994-1-narmstrong@baylibre.com>
 <667da463-1edc-4a99-9ac1-85303d9187c6@www.fastmail.com>
 <499f0940-3d7f-0ed5-e469-5c0979e6f761@baylibre.com>
 <28501fbf-3508-4afe-804d-fa5a3ccd4291@www.fastmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <28501fbf-3508-4afe-804d-fa5a3ccd4291@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 15:17, Arnd Bergmann wrote:
> On Wed, Sep 14, 2022, at 2:35 PM, Neil Armstrong wrote:
>> On 14/09/2022 13:19, Arnd Bergmann wrote:
>>> On Tue, Sep 13, 2022, at 4:03 PM, Neil Armstrong wrote:
>>>
>>>> + /* Sometimes, TC gets triggered while the RX fifo isn't fully flushed *
>>>> + if (spicc->using_dma) {
>>>> +          unsigned int rxfifo_count = FIELD_GET(SPICC_RXCNT_MASK,
>>>> +                       readl_relaxed(spicc->base + SPICC_TESTREG));
>>>
>>> Same here in the interrupt controller, I don't see anything enforcing
>>> the DMA to actually complete before the readl_relaxed().
>>
>> I don't see the relathionship between a register relaxed read and the
>> DMA not finishing
>> writing the data in uncached memory, for me it's 2 unrelated things.
> 
> The race is between the readl_relaxed() and a subsequent access
> to the data that is being transferred. On Arm processors you
> need a "dmb(oshld)" instruction to ensure that the CPU cannot
> prefetch data from the DMA buffer while it is waiting for the
> MMIO to complete.
> 
> The __io_ar() in readl() exists specifically there for this race, and
> this is the reason that readl_relaxed() exists for drivers that
> do not do any DMA.

Acked, thx for for expliciting, will do the fix.

> 
> Note that this prefetching can happen for uncached memory, but
> spe-meson-spicc uses cached memory.
> 
>       Arnd

