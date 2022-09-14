Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E935B8859
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiINMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiINMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:35:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C75AE76
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:35:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso11417828wmr.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=DlDjCrRvT7ZrMqLsqbSeiQMfFP2pPcqVagrQi2zGg/0=;
        b=KusiwEWJadoy6YIDbf+gx4EHkzAewE+aqXzucSNysAhphF1v0JofMwtfZyViiOcLoX
         YS0oUVxNRN0XmqQ1PRCjYE7030kUVLOkje1IT+FZxsl88eMZ32iariaofRB7GxD/RI2T
         r9Xb2Q5r3ZbrwruiqXAY2a53lgfkcSgTdrf8hfKGFv7RrqoK4BCyPgVX/UQH0UMSgb+F
         vq8jo7VcyBdiDjmk/XFdRUoae0vq1axWm9dLH8VSGDSiqhZuoI6jOTKCm/PfA079r6QY
         oqn+zc5UIpysr5e6UwItxDS2ZjWncKhNY6/lcPDPRFwHLbnFuNb59MQGeUvGU2W5qXZ5
         BftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=DlDjCrRvT7ZrMqLsqbSeiQMfFP2pPcqVagrQi2zGg/0=;
        b=hcAZpJeq3bd18FFtTNAdpSI1EyjDs9D99C+zeW5nb8aDNMf++1e+ZGiJRiQOHQBtWJ
         p9d9YNuN4vgOjCs0Z/2k0FFs6pXdXmY5lryFWBlkBT8FvUb4eSMDbwq+G0Yf6w4CBcS6
         8HAZkJnxtKLD54Y53MqOWD/RBA25Po9G4ePKR1Fz8bnKb+6Gqp/YMHDx0HmZHbwt1LLn
         Y4ZmdIfRNzj/VxUIFI6qkeBKmGCpOYthpetVx+b81KAL04ao2EdOPjfzVHeB1O/Yni+m
         El1PnYhDlptjRC9Sk3kcjODSuAIOtbxD/D8RcOz50DL8qJU3ej64P1oJTVIFKVjEDrN5
         7ebg==
X-Gm-Message-State: ACgBeo1W/I1+NjvNW2ylhRNMhRxgACck88Ai5TOVJc5qccDtB06SLz3n
        C38IpxF5vtbLFeqEzzrQjP+gzRKoPWLLGOJu
X-Google-Smtp-Source: AA6agR6QJXG5hGSiJ1yl3xM9u1YtuXerHiYJTL/eyFMFKOjCQYcg4yYiXsh8ODbHUyIAfPVGYILQIw==
X-Received: by 2002:a1c:4b0d:0:b0:3b4:76ae:f7a5 with SMTP id y13-20020a1c4b0d000000b003b476aef7a5mr3137417wma.23.1663158938582;
        Wed, 14 Sep 2022 05:35:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:375e:b940:b903:7792? ([2a01:e0a:982:cbb0:375e:b940:b903:7792])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c4a1300b003a1980d55c4sm15471489wmp.47.2022.09.14.05.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 05:35:38 -0700 (PDT)
Message-ID: <499f0940-3d7f-0ed5-e469-5c0979e6f761@baylibre.com>
Date:   Wed, 14 Sep 2022 14:35:36 +0200
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
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <667da463-1edc-4a99-9ac1-85303d9187c6@www.fastmail.com>
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

On 14/09/2022 13:19, Arnd Bergmann wrote:
> On Tue, Sep 13, 2022, at 4:03 PM, Neil Armstrong wrote:
> 
>> +static void meson_spicc_setup_dma_burst(struct meson_spicc_device *spicc)
>> +{
> ...
>> +	/* Setup burst length */
>> +	writel_relaxed(ld_ctr1, spicc->base + SPICC_LD_CNTL1);
>> +
>> +	writel_relaxed(SPICC_DMA_ENABLE | SPICC_DMA_URGENT |
>> +		       FIELD_PREP(SPICC_TXFIFO_THRESHOLD_MASK, txfifo_thres) |
>> +		       FIELD_PREP(SPICC_READ_BURST_MASK, read_req) |
>> +		       FIELD_PREP(SPICC_RXFIFO_THRESHOLD_MASK, rxfifo_thres) |
>> +		       FIELD_PREP(SPICC_WRITE_BURST_MASK, write_req),
>> +		       spicc->base + SPICC_DMAREG);
>> +}
> 
> It looks like this last writel_relaxed() starts the DMA, but I don't
> see any barrier that serializes it against the memory access, which
> could still be in a store buffer.

You're right this one restarts a DMA, so yeah it should not have the relaxed accessor.

But the one starting the first DMA is in another place and aswell should not use relaxed.

> 
>> + /* Sometimes, TC gets triggered while the RX fifo isn't fully flushed *
>> + if (spicc->using_dma) {
>> +          unsigned int rxfifo_count = FIELD_GET(SPICC_RXCNT_MASK,
>> +                       readl_relaxed(spicc->base + SPICC_TESTREG));
> 
> Same here in the interrupt controller, I don't see anything enforcing
> the DMA to actually complete before the readl_relaxed().

I don't see the relathionship between a register relaxed read and the DMA not finishing
writing the data in uncached memory, for me it's 2 unrelated things.

> 
> At the very minimum, I think these two have to use non-relaxed
> accessors when adding DMA support, but an easier approach would
> be to use those consistently throughout the driver.

I'll do a check of those accessors for v2.

> 
>       Arnd
Thanks,
Neil
