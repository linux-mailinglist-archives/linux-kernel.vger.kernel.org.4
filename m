Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC46A1E92
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBXPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBXPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:31:21 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A251DB8C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:31:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id i34so30890851eda.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXDQNIM/Va5EbMCqI6+twpMlGTvVzrjYt3Y8rxjXvhc=;
        b=k7gFTmYC+ABoHltWR2NEkYtc1geTbiJvcsxrpqNO9+4AnRtUAwY9FJ7otdEH2Lgmbt
         B9TLcWr7ykyWx6c2P2qaYG1WleTmDrHCFXJWeXsfMYChkIYKI0CIMq578nM2X/RHluov
         cuJx6+7U+ihZhQwy/cHucxEn7BlqiFS4v64JR5txHUgYnzPxycO2QCE4YP5JLQhcrYpE
         tOpIXWuS+cY1Vl3hSGrSVHbFcbIQ2a2tUR2sOVLSnlElhmxFT5VbNJiYM9B9jLItuXOc
         XhWBzOBbo7hdCnesbPtPkKSeVlLP+bqehV8/AURLAriQUjFIM8r0g415Y6Q5xV1euseg
         4FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXDQNIM/Va5EbMCqI6+twpMlGTvVzrjYt3Y8rxjXvhc=;
        b=0Iyd/kiSwumfRUzbWXl4tARpr0Ng9v/nTEmF1ij0ZM0+lQHusabPsKRmGuuuQmta71
         aMGjzLZiCA48eInUbhcWZ9Kb9vKuU81XgB2VZ758S4bScbTixN6VgRR5xU2jFXmIJ/Gd
         19BXePohmCKKj3TySAKNXJygjkpBZ2D7ci1cBoj/o1RfMw+sJlC4a7c5F2svRCytuprB
         e2sg+aTcy6OP5MZZPuIAtyRelUQRN4vnVM3sX+KN3DoXSaaZFqPp7ssC9EN9fW2ZoZ2f
         e3od05Jcc6/v9TMv+hW9U78+gGuw9b0q+viO4GpURo+9V80WANK7zM55MYs9PWvsdUIt
         xCqA==
X-Gm-Message-State: AO0yUKVALac0dsoF4DR55d/RsbOv0sYfaH196WF04AiIpRAfNukOOUf/
        ul6BdFx/n+1qzfC7tO1vskHxUfnlvpeB6Q==
X-Google-Smtp-Source: AK7set/MKaJGPdjkKPadkhDa0B/8nzJlv8JjG6pemMfD0ziDkBPvv1z5vm4FT/dauGmY0+hC4WJS0A==
X-Received: by 2002:a17:907:97c3:b0:8af:ef00:b853 with SMTP id js3-20020a17090797c300b008afef00b853mr30655341ejc.73.1677252677946;
        Fri, 24 Feb 2023 07:31:17 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:35e:38c6:dafc:5dd2? ([2a02:908:1256:79a0:35e:38c6:dafc:5dd2])
        by smtp.gmail.com with ESMTPSA id m8-20020a170906234800b008ee95ccfe06sm1915030eja.119.2023.02.24.07.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 07:31:17 -0800 (PST)
Message-ID: <90b1c9f8-1674-e9ec-e6d8-2fa1967439b3@gmail.com>
Date:   Fri, 24 Feb 2023 16:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: amdgpu didn't start with pci=nocrs parameter, get error "Fatal
 error during GPU init"
Content-Language: en-US
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CABXGCsMbqw2qzWSCDfp3cNrYVJ1oxLv8Aixfm_Dt91x1cvFX4w@mail.gmail.com>
 <a99e6def-68be-3f2b-4e01-ac26cdb80f49@gmail.com>
 <CABXGCsM7JPxtQm6B7vk+ZcXfphgQm=ArJZKiDUdbk9hujyRtmg@mail.gmail.com>
 <43016018-4d0a-94dc-ce93-b4bff2dce71c@gmail.com>
In-Reply-To: <43016018-4d0a-94dc-ce93-b4bff2dce71c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.02.23 um 13:29 schrieb Christian König:
> Am 24.02.23 um 09:38 schrieb Mikhail Gavrilov:
>> On Fri, Feb 24, 2023 at 12:13 PM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> Hi Mikhail,
>>>
>>> this is pretty clearly a problem with the system and/or it's BIOS and
>>> not the GPU hw or the driver.
>>>
>>> The option pci=nocrs makes the kernel ignore additional resource 
>>> windows
>>> the BIOS reports through ACPI. This then most likely leads to problems
>>> with amdgpu because it can't bring up its PCIe resources any more.
>>>
>>> The output of "sudo lspci -vvvv -s $BUSID_OF_AMDGPU" might help
>>> understand the problem
>> I attach both lspci for pci=nocrs and without pci=nocrs.
>>
>> The differences for Cezanne Radeon Vega Series:
>> with pci=nocrs:
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Interrupt: pin A routed to IRQ 255
>> Region 4: I/O ports at e000 [disabled] [size=256]
>> Capabilities: [c0] MSI-X: Enable- Count=4 Masked-
>>
>> Without pci=nocrs:
>> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Interrupt: pin A routed to IRQ 44
>> Region 4: I/O ports at e000 [size=256]
>> Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
>>
>>
>> The differences for Navi 22 Radeon 6800M:
>> with pci=nocrs:
>> Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> Interrupt: pin A routed to IRQ 255
>> Region 0: Memory at f800000000 (64-bit, prefetchable) [disabled] 
>> [size=16G]
>> Region 2: Memory at fc00000000 (64-bit, prefetchable) [disabled] 
>> [size=256M]
>> Region 5: Memory at fca00000 (32-bit, non-prefetchable) [disabled] 
>> [size=1M]
>
> Well that explains it. When the PCI subsystem has to disable the BARs 
> of the GPU we can't access it any more.
>
> The only thing we could do is to make sure that the driver at least 
> fails gracefully.
>
> Do you still have network access to the box when amdgpu fails to load 
> and could grab whatevery is in dmesg?

Sorry I totally missed that you attached the full dmesg to your original 
mail.

Yeah, the driver did fail gracefully. But then X doesn't come up and 
then gdm just dies.

Sorry there is really nothing we can do here, maybe ping somebody with 
more ACPI background for help.

Regards,
Christian.

>
> Thanks,
> Christian.
>
>> AtomicOpsCtl: ReqEn-
>> Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
>> Address: 0000000000000000  Data: 0000
>>
>> Without pci=nocrs:
>> Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>> Stepping- SERR- FastB2B- DisINTx+
>> Latency: 0, Cache Line Size: 64 bytes
>> Interrupt: pin A routed to IRQ 103
>> Region 0: Memory at f800000000 (64-bit, prefetchable) [size=16G]
>> Region 2: Memory at fc00000000 (64-bit, prefetchable) [size=256M]
>> Region 5: Memory at fca00000 (32-bit, non-prefetchable) [size=1M]
>> AtomicOpsCtl: ReqEn+
>> Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>> Address: 00000000fee00000  Data: 0000
>>
>>> but I strongly suggest to try a BIOS update first.
>> This is the first thing that was done. And I am afraid no more BIOS 
>> updates.
>> https://rog.asus.com/laptops/rog-strix/2021-rog-strix-g15-advantage-edition-series/helpdesk_bios/ 
>>
>>
>> I also have experience in dealing with manufacturers' tech support.
>> Usually it ends with "we do not provide drivers for Linux".
>>
>

