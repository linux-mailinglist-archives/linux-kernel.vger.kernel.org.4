Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788F65EA8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiIZOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiIZOlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:41:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0840FFF;
        Mon, 26 Sep 2022 06:02:47 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MXGzQ-1ol73l2YKk-00YjbJ; Mon, 26 Sep 2022 15:02:43 +0200
Message-ID: <e0ee39d5-33e9-c7ae-a1e9-3b21e83c70fd@vivier.eu>
Date:   Mon, 26 Sep 2022 15:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
Content-Language: fr
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20220921185208.3549140-1-Jason@zx2c4.com>
 <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
 <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
 <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
 <eb798159-c003-3b43-c891-039080e06e03@vivier.eu>
 <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
 <ae3232b2-4277-eee3-726c-30a3a21c41b7@vivier.eu>
 <CAHmME9omvDj6NcbrSth8P03ciRVf0VcQRDfTJix7yiCoBsg02g@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <CAHmME9omvDj6NcbrSth8P03ciRVf0VcQRDfTJix7yiCoBsg02g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4dR4GE5zXf36b73wkneVBW+qzkdI/0+upbsMDkyi4TmoiuO7jaq
 NPkH72vDiiLYZj0uDxRiCHPsMxrw+RMxWaSl91MAjllTo4/3HlVF8JH+CXLytSbkEhrA/3f
 DsCcBafDJOhd1TzBna5Gps7ums51ajPYDM+v8tW2QF+PvCqG4mLLPGugufi8jv5QgyQ65Rc
 RevvgCaN3g80XnG7fK67g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TW771hBLjm0=:huz3eFD7qe83G9hi7whCWu
 ZmCKzzusjDaTlXmX98N3KvzMnw5A2cxuZsCOhWhPX3ygnaiG7VfTctxOsrrglukuk5wGgnc0R
 m++Pf66mWXzo+EAn8EawZPeQPdgF1ZsJx+s9sRZKiMey2ibii2Q5PiWwSMfDR1P0VZ0oFNndH
 0W1hPNIdJnFwsoLkK4t6M9qrT5I/T3G/4WkjPeJoln9bcxEGSkUZatz6bdeyn3X5NwNlaiGcs
 nHazFmROMiVC0IXELLs5O0XveTKjBdpWwCZRuj62dAU3Pj6hHHdLAucqw2fb8oFq8FK//sy/d
 QUV3tkTQvdV88VsNrHMSbOTvRxBIgC3NF68jhdgF18/vCbNNwNbBPLQySHdqNdRy0gSkFL4oh
 DGUItmsngSeyNltaBpDCnbzAvoJ46hkTY1z+mEktC9kEnilVJY4Rp9iDTZl5CUxspu7KD668e
 sHBm/zTebdGOZQLdGnLZrDVAYO692oerojc/ePapASDC7s8vQIuJ3oVf65MVCZydQ0Oip5E3c
 Bmr5U1YEVL4dFhBIUi/Rb8+aZ/TzzrrEz7UM44Gcydq6t5mSTs9V6GeqWFjPEDj8VVGjUVYBc
 hw7LnkRXmJvGC5GKGDwFCdM08vKeHzViTgxVs315uqkHD92Qrlrcs8jK27RFX6X8Bf3QN8Ktf
 ijzlNZfLVi3Q/U3f8q0dR/AcayP6ZsdtrOpQ1UDcNBCEEGuo0POmpUFuiQuRicyxpZFFw8lMV
 rIRiLENVxqvJq8edZzfPMpcrmcI66NNCA1MDOLeAOXzk09azuK9x1Wh9U0Hq9I1Ss1izouQGM
 rBzCe2T
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/09/2022 à 14:56, Jason A. Donenfeld a écrit :
> Hi Laurent,
> 
> On Mon, Sep 26, 2022 at 2:52 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Hi Jason,
>>
>> Le 26/09/2022 à 14:02, Jason A. Donenfeld a écrit :
>>> Hi Laurent,
>>>
>>> On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> Le 23/09/2022 à 14:50, Geert Uytterhoeven a écrit :
>>>>> Hi Jason,
>>>>>
>>>>> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>>>>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>>>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
>>>>>>>>>> +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
>>>>>>>>>> +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
>>>>>>>>>> +               *(u16 *)rng_seed_record->data = len;
>>>>>>>
>>>>>>> Storing the length should use the proper cpu_to_be16 accessor.
>>>>>>
>>>>>> Okay, I'll do that for v2.
>>>>>>
>>>>>> (Simply out of curiosity, why? Isn't m68k always big endian and this
>>>>>> is arch/ code?)
>>>>>
>>>>> Yes it is.  But virt_parse_bootinfo() below already uses the right
>>>>> accessor.
>>>>>
>>>>> BTW, I guess people thought the same about PowerPC?
>>>>> Although I agree the probability of someone creating a little-endian
>>>>> m68k clone in an FPGA or SkyWater project and trying to run Linux on
>>>>> it quite low ;-)
>>>>>
>>>>>>>> The way I tested this is by having my initramfs just call
>>>>>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
>>>>>>>> its contents to the console. I checked that it was both present and
>>>>>>>> different every time.
>>>>>>>
>>>>>>> Are you sure the new kernel did receive the same randomness as prepared
>>>>>>> by get_random_bytes()? I would expect it to just reboot into qemu,
>>>>>>> reload the kernel from disk, and recreate a new bootinfo from scratch,
>>>>>>> including generating a new random seed.
>>>>>>
>>>>>> Yes I'm sure. Without this patch, the new kernel sees the zeroed state.
>>>>>
>>>>> That's interesting.  So QEMU preserves the old bootinfo, which is
>>>>> AFAIK not guaranteed to be still available (that's why I added
>>>>> save_bootinfo()).  Perhaps that works because only memory starting
>>>>> from a rounded-up value of _end will be used, and you're just lucky?
>>>>> I'm wondering what else it preserves. It sure has to reload the
>>>>> kernel image, as at least the data section will no longer contain the
>>>>> initialization values after a reboot...
>>>>>
>>>>> Laurent?
>>>>>
>>>>
>>>> In QEMU the loader makes a copy of the kernel and the initrd and this copy is restored on a reset.
>>>>
>>>> I don't think there is a mechanism in QEMU to save the BOOTINFO section, so I think it works by
>>>> luck. I will check.
>>>>
>>>> Thanks,
>>>> Laurent
>>>
>>> Are you sure about that? Or at least, could you point me to where you
>>> think this happens? I'm not as familiar as you with this code base,
>>> but I really am not seeing it. So far as I can tell, on reset, the pc
>>> and stack are reset to their initial places, after TCG resets the cpu
>>> registers to a known state. But the kernel is not reloaded. The same
>>> thing that was in memory before is used again.
>>
>> Yes, this is not clear in QEMU but I think this happens in rom_reset():
>>
>> hw/core/loader.c
>>
>> 1180         if (rom->mr) {
>> 1181             void *host = memory_region_get_ram_ptr(rom->mr);
>> 1182             memcpy(host, rom->data, rom->datasize);
>> 1183             memset(host + rom->datasize, 0, rom->romsize - rom->datasize);
>> 1184         } else {
>> 1185             address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECIFIED,
>> 1186                                     rom->data, rom->datasize);
>> 1187             address_space_set(rom->as, rom->addr + rom->datasize, 0,
>> 1188                               rom->romsize - rom->datasize,
>> 1189                               MEMTXATTRS_UNSPECIFIED);
>> 1190         }
>>
>> kernel and initrd are loaded with load_elf() and load_image_targphys() only once at startup by the
>> machine init function (virt_init()).
>>
>> rom_add_elf_program() adds the kernel to the ROM list
>> (in include/hw/elf_ops.h, glue(load_elf, SZ) that generates load_elf32() when SZ is 32...)
>>
>> rom_add_file() adds the initrd to the ROM list too.
>>
>> And ROMs are restored on reset from these copies by rom_reset().
>>
>> rom_reset() is registered as a reset handler with qemu_register_reset() by
>> rom_check_and_register_reset() at the end of the machine creation by qdev_machine_creation_done().
>>
>> So I think bootinfo are not restored because there is no such function calls. Perhaps they are saved
>> and restaured if they are stored in address space of one of the previous registered ROM.
> 
> Ahh interesting, thanks for the explanation.
> 
> So from my debugging, bootinfo is *not* restored, and the previous one
> appears to be used. Fortunately it's intact and everything works well
> on a reboot.
> 
> With that in mind, we now we have to decide whether to:
> A) Go with my linux patch to write the rng seed before rebooting (3/3
> in v4 of that series).
> B) Not go with the linux patch, but instead make sure bootinfo is
> restored to its previous value, and then also register a qemu reboot
> notifier to refresh the seed in it, like what x86 does.
> 

I prefer B :)
It's cleaner and under QEMU control.

Thanks,
Laurent
> (A) sounds a lot easier to me. Opinions?
> 
> Jason

