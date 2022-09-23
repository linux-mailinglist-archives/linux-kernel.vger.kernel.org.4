Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B015E7B79
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIWNLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiIWNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:11:12 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A013252BB;
        Fri, 23 Sep 2022 06:10:54 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MGi6m-1oXoi01EKg-00DqL7; Fri, 23 Sep 2022 15:10:50 +0200
Message-ID: <eb798159-c003-3b43-c891-039080e06e03@vivier.eu>
Date:   Fri, 23 Sep 2022 15:10:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: fr, en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20220921185208.3549140-1-Jason@zx2c4.com>
 <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
 <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
 <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
In-Reply-To: <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YnSbGiUJH5ge9lIS6i1eCEUz04HHxFXXLyymzkJrNfOppz+8s0f
 SOy8aYV0MJM2Jj/ZFFyAaie8/LfDUtHDBp9HrXt2Eouer+JLvLjChdwQ4YKQHfRp4PK8W4u
 EfVGJ3xTIDmXx1BiDC5yoxs94FYlMROc9Fdzm15Aqbpo/O2HT1ctliNfZVf5UYQ8z4qPSYa
 mP+ebyLKpXEFn5wVzB/yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wilGWlDs+9E=:K0kkDbu/yxmSakCVLVzlSF
 ScUPnYdOQhLTpR2h4c3to9w9mA24QO6SDKMH9VqpO/WG4QLqUPnGjw9P3cgh9rFI9GUgRPrZb
 B6YExOq/B2Ek5fTiJGwdiHEO3gv1YvzBLGzLHHG269nX13GD7QYYdKQnd7U56DgOoEZ7W9+mK
 3i3M61nqy2YT4nAfkxfLKNPW9mT+ujvWT+9NAmY+d3W/IBgP/k/oLfOX5Nr8hhFGb5Gd2AH4A
 9AZ191MsoRUERTRYr4fDxDN3cPCMM9xk8sSlloxilzNuIH2Qw6T1F9TiSWV6AjmHU3qZztTJC
 bI/LpSpgbXYGOyMu099KT8njj363LET0pk+uLwahj1/VZBVZJFH9tzXlX6mGIHP1UsVXUY6pG
 5DWgKzY6lCsyU0dCOWgmfzT25hhXJPXdLVbdrFlfMODQ37CSKG61XoMerCGI8VH9KIQm73Lyd
 8Ci+5ky4WQrr0KDBuumcFvwms476jjpRTJNFB2IwrQPRx59BGgSBpj6rMmG9ykPmIQSMN1SsA
 5pKO3OhjshI3idT3gu1UGNGleFro/60YLoPVlxF2H3kOR7cNQf4HsZbaWLz2xybaLnG+5yAdq
 eM1vVKBzSlcbR+p3LEIM2em7gflaa24RCYIvFxaV53ykocUYw1LP8A1HDzXBg4nZONvWcssE8
 elz6PNC0x/W8c5p29yMayGzvWH3nq4EFeTskPZUhPfDmbdc9cTAaBGp/Sj2Tgb6Z5qq83HTKH
 SNahkkjAubpnA6dmaLLsZkfrYRObJKMlEoHxGmh9QBn8RvokhcdHCyVKcR++MAAmG90cBWuKj
 ydhlOOd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/09/2022 à 14:50, Geert Uytterhoeven a écrit :
> Hi Jason,
> 
> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
>>>>>> +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
>>>>>> +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
>>>>>> +               *(u16 *)rng_seed_record->data = len;
>>>
>>> Storing the length should use the proper cpu_to_be16 accessor.
>>
>> Okay, I'll do that for v2.
>>
>> (Simply out of curiosity, why? Isn't m68k always big endian and this
>> is arch/ code?)
> 
> Yes it is.  But virt_parse_bootinfo() below already uses the right
> accessor.
> 
> BTW, I guess people thought the same about PowerPC?
> Although I agree the probability of someone creating a little-endian
> m68k clone in an FPGA or SkyWater project and trying to run Linux on
> it quite low ;-)
> 
>>>> The way I tested this is by having my initramfs just call
>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
>>>> its contents to the console. I checked that it was both present and
>>>> different every time.
>>>
>>> Are you sure the new kernel did receive the same randomness as prepared
>>> by get_random_bytes()? I would expect it to just reboot into qemu,
>>> reload the kernel from disk, and recreate a new bootinfo from scratch,
>>> including generating a new random seed.
>>
>> Yes I'm sure. Without this patch, the new kernel sees the zeroed state.
> 
> That's interesting.  So QEMU preserves the old bootinfo, which is
> AFAIK not guaranteed to be still available (that's why I added
> save_bootinfo()).  Perhaps that works because only memory starting
> from a rounded-up value of _end will be used, and you're just lucky?
> I'm wondering what else it preserves. It sure has to reload the
> kernel image, as at least the data section will no longer contain the
> initialization values after a reboot...
> 
> Laurent?
>

In QEMU the loader makes a copy of the kernel and the initrd and this copy is restored on a reset.

I don't think there is a mechanism in QEMU to save the BOOTINFO section, so I think it works by 
luck. I will check.

Thanks,
Laurent

