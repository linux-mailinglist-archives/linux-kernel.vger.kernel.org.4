Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6525F5F587F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiJEQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJEQni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:43:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60DB240BE;
        Wed,  5 Oct 2022 09:43:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c7so15698501pgt.11;
        Wed, 05 Oct 2022 09:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tILem83EJNuvIc5+TmcyEmjOuaEfpedRH8xo74px4IM=;
        b=gwPyQmbr7slMOsWZ7Svbjc60E0jzRoQJnXOyA9UlTczLgMCmWVcsB3tt6cKQpOgzQt
         3esZbJKqcEYIkcgl3Lwqn6KM93N7316Rv/YIdpvDuj1fVhvv2Wmd0i+9OtnZNRXEMEH4
         SxMrIkHmu7iZ5Nixr0OcR7v8uceju3Tb7mQ3MthrMXAqC/jGuu/SOBSthKnQdGXVUGOk
         XkrSK1MBD4zviv+WvsDKTRxmJX/uo67/PbgYPKTCz+bV6QCO/7ZdCWOyOpU/Y30fsymu
         0HRXk8pQw0i8grHuI9HLYb+TXKLGd+L833xaufMDqnw3fXAUa5K8RVnYAfMtb3jBPocF
         2TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tILem83EJNuvIc5+TmcyEmjOuaEfpedRH8xo74px4IM=;
        b=V94aHi0VtUsWQUbwKv+H9ytVPX06bU/OsWl9TvonP+VS6M4bjZjw0++nvfZDuGBjjh
         7aWeGb0n7/2M/9ioAhwsOZdKlTmi272wL7EL1SM+J3jvYOpgP/GGWztfC3n0v44gw/YE
         R7/iuvpeNMSnnmxFQO5XasyNChErBRnoPg+RGalxuumMRCAgl/gQXM4015tdpCovRrkl
         K/ylGBY7x9zoJvaai8IbVG+CTG/pLfX42RSdRxywzae03vkXHVxnoItggAQZ7rVJOtSi
         JPqs4EqmIS5y9l7pPET9rFPe0RGxRBDRgfWvuIdv8SUIRI3/nAgXHIDzg1HMJX/oKS7q
         0u/g==
X-Gm-Message-State: ACrzQf1y5iuDyfD0WLTHihgRcWjX0rqo2S6U6Zz03WQPux01XWJAdz2m
        tjZ0rcZcmh0hOPvZmTLRWnU3T7YXmlAHpGUMpj0=
X-Google-Smtp-Source: AMsMyM7kQtyNZhDR0lmhv7RCt2A3DFuUNz9FnAeQRICtLaz6ostG3FIRuQIo4RmdsfYsaVXVbkSc5w==
X-Received: by 2002:a05:6a00:302a:b0:560:950e:afd1 with SMTP id ay42-20020a056a00302a00b00560950eafd1mr332181pfb.26.1664988216904;
        Wed, 05 Oct 2022 09:43:36 -0700 (PDT)
Received: from [192.168.0.106] (155137199074.ctinets.com. [155.137.199.74])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902868a00b0016cf3f124e1sm10595963plo.234.2022.10.05.09.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:43:36 -0700 (PDT)
Message-ID: <be98b367-f29f-25d1-de01-be189ae8057a@gmail.com>
Date:   Thu, 6 Oct 2022 00:43:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
Content-Language: en-US
To:     Sven Peter <sven@svenpeter.dev>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221004112724.31621-1-konrad.dybcio@somainline.org>
 <20221004112724.31621-2-konrad.dybcio@somainline.org>
 <3398859f-e872-4f1d-8a03-4dcb1e46e010@app.fastmail.com>
From:   Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <3398859f-e872-4f1d-8a03-4dcb1e46e010@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2022 23:56, Sven Peter wrote:
> Hi,
> 
> 
> On Tue, Oct 4, 2022, at 13:27, Konrad Dybcio wrote:
>> Add support for A7-A11 SoCs by if-ing out some features only present
>> on:
>>
>> * A11 & newer (implementation-defined IPI & UNCORE registers)
>> * A11[1] & newer (fast IPI support).
>>
>> UNCORE/UNCORE2 and IPI registers conveniently both first appeared on
>> A11, so introduce just one check for that.
>>
>> Knowing whether the SoC supports the latter is necessary, as they are
>> written to, even if fast IPI is disabled.
> 
> AFAIK that's only an artifact in this driver: It was added to prevent an FIQ
> storm in case there were pending fast ipis (i.e. the bootloader was broken ;))
> when this driver didn't support fast ipis yet.
> 
>> This in turn causes a crash
>> on older platforms, as the implemention-defined registers either do
>> something else or are not supposed to be touched - definitely not a
>> NOP though.
>>
>> [1] A11 is supposed to use this feature, but it currently doesn't work
>> for reasons unknown and hence remains disabled. It can easily be enabled
>> on A11 only, as there is a SoC-specific compatible in the DT with a
>> fallback to apple,aic. That said, it is not yet necessary, especially
>> with only one core up, and it has worked a-ok so far.
> 
> Just to make sure I understand this correctly - we have the following three situations:
> 
> - base: no fastipi, no uncore, will work on A11 and M1 though
> - A11: fastipi and uncore but fastipi is broken (possibly due to HW errata or some bug in this driver that only happens on A11)
> - M1 (or maybe even A12 already, doesn't matter though): fastipi and uncore support
> 
> If we figured out _why_ fastipi is broken on A11 we would only need a single
> feature flag to enable both uncore and fastipi but for now we need two to
> disable fastipi for A11

The previous issues with fast IPI does not seem to be reproducible with thisversion of patches anymore, at least when modifying the device tree to useapple,t8103-aic the device still boots. Tested on iPhone X.
> 
> I'm also curious: What are the symptoms when you enable fastipi on A11?
> 
> 
> Sven


Nick Chan
