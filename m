Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397D5EA884
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbiIZOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiIZOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:34:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9755696DB;
        Mon, 26 Sep 2022 05:52:53 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTAJl-1opDwc0TfD-00UWf0; Mon, 26 Sep 2022 14:52:49 +0200
Message-ID: <ae3232b2-4277-eee3-726c-30a3a21c41b7@vivier.eu>
Date:   Mon, 26 Sep 2022 14:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
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
From:   Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
In-Reply-To: <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GScUxbJLWjtngZXX+/nVYdlce5jE3bmFs/zTqIqiNxfp+1et5ku
 MTmLsKpQtUsQH6aXGd15IQLCxvqqUOhkMPE/vSPB7PGqigmskJB+RuljfXaQmSTAMOpV1Fl
 Z5qcFw5b1c0aG3eW3P+6rIpCyWT+b9Avg4iCz6w1mH3ZgdN4XAxM8h8nyEprA4vzMGVYn6n
 aClLMowl6e80T81kM8wgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O9Wlcnpf39Y=:X5ox+kE+4jL3kk9cKMkygL
 Behsu5oSOlgehaXOKjsLxbyJzSrwuO9C5paOHrk1mVk8MG/gEIKEniV+R55wVJ1QEXXWTKNlO
 YdKZeTc2oWTU9ScU/0zOPgvl6a15bxXshOdI9uarJTJH4p8bjbo1zzvDwQQNtn9CqlsQef144
 K0q6mLoSY+ab1vfh08ue2yUTLyHG0JvalEUT6WaQQl8ZMnVXA1Ra0SakuwKTUtTVDU9SxPGtH
 iCpjaYTI+SDagY+IAR4H4jtnV0q069kyx+6PDFNAA1pdxn8iQFl0VJB7wqs9QVnGysL458+iX
 RcD8Jn5sJb6DAxQuGnXKK9DkvivSXmmP6uhmkVAH/rFHFNmj4xXOwyx+0Tu6OU93QaXsgjyW2
 KzZphwO9btJMVBZuEkemeZqaZtZ1oBgjRVcVmqktNzxXxgPkTt5TfpXd1cfiS1b7Qnzf3Huwz
 o9KcuGK+rZkD0ELk3/ZiPcKebw8fxtX3uXTTNzjn1zW1oPHffk28q5Q6qDcofqME4zWi/GB0v
 69sjQlrazCf+3x9O2hwsnwSdBzTwOQpJT6kcZe8UUpQWc2ENn+iEOsjLqXobZ8MgdmJWXxQ7i
 mBS3D5aorhx5kudnnDVizF9kggN+SEtYEKPb4ibLTAX17IKmU5xn2CBLEszG+bBZ0spNvcJCW
 5k8s4cMWsBO/qxQJDVaRRQ1uIL8L43vDgBw9sh46jIXfGOLU/s1Em8Gfk4I1MAE9jYxpQ9HUs
 QEnPoAZUAb6TXAIY4ml4eznXhVgb6q90B/6jaVvzlPdjf8CaH5BocWUzYJTm+0Ss3iHH2Ibmz
 onO7h2w
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Le 26/09/2022 à 14:02, Jason A. Donenfeld a écrit :
> Hi Laurent,
> 
> On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 23/09/2022 à 14:50, Geert Uytterhoeven a écrit :
>>> Hi Jason,
>>>
>>> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
>>>>>>>> +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
>>>>>>>> +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
>>>>>>>> +               *(u16 *)rng_seed_record->data = len;
>>>>>
>>>>> Storing the length should use the proper cpu_to_be16 accessor.
>>>>
>>>> Okay, I'll do that for v2.
>>>>
>>>> (Simply out of curiosity, why? Isn't m68k always big endian and this
>>>> is arch/ code?)
>>>
>>> Yes it is.  But virt_parse_bootinfo() below already uses the right
>>> accessor.
>>>
>>> BTW, I guess people thought the same about PowerPC?
>>> Although I agree the probability of someone creating a little-endian
>>> m68k clone in an FPGA or SkyWater project and trying to run Linux on
>>> it quite low ;-)
>>>
>>>>>> The way I tested this is by having my initramfs just call
>>>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
>>>>>> its contents to the console. I checked that it was both present and
>>>>>> different every time.
>>>>>
>>>>> Are you sure the new kernel did receive the same randomness as prepared
>>>>> by get_random_bytes()? I would expect it to just reboot into qemu,
>>>>> reload the kernel from disk, and recreate a new bootinfo from scratch,
>>>>> including generating a new random seed.
>>>>
>>>> Yes I'm sure. Without this patch, the new kernel sees the zeroed state.
>>>
>>> That's interesting.  So QEMU preserves the old bootinfo, which is
>>> AFAIK not guaranteed to be still available (that's why I added
>>> save_bootinfo()).  Perhaps that works because only memory starting
>>> from a rounded-up value of _end will be used, and you're just lucky?
>>> I'm wondering what else it preserves. It sure has to reload the
>>> kernel image, as at least the data section will no longer contain the
>>> initialization values after a reboot...
>>>
>>> Laurent?
>>>
>>
>> In QEMU the loader makes a copy of the kernel and the initrd and this copy is restored on a reset.
>>
>> I don't think there is a mechanism in QEMU to save the BOOTINFO section, so I think it works by
>> luck. I will check.
>>
>> Thanks,
>> Laurent
> 
> Are you sure about that? Or at least, could you point me to where you
> think this happens? I'm not as familiar as you with this code base,
> but I really am not seeing it. So far as I can tell, on reset, the pc
> and stack are reset to their initial places, after TCG resets the cpu
> registers to a known state. But the kernel is not reloaded. The same
> thing that was in memory before is used again.

Yes, this is not clear in QEMU but I think this happens in rom_reset():

hw/core/loader.c

1180         if (rom->mr) {
1181             void *host = memory_region_get_ram_ptr(rom->mr);
1182             memcpy(host, rom->data, rom->datasize);
1183             memset(host + rom->datasize, 0, rom->romsize - rom->datasize);
1184         } else {
1185             address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECIFIED,
1186                                     rom->data, rom->datasize);
1187             address_space_set(rom->as, rom->addr + rom->datasize, 0,
1188                               rom->romsize - rom->datasize,
1189                               MEMTXATTRS_UNSPECIFIED);
1190         }

kernel and initrd are loaded with load_elf() and load_image_targphys() only once at startup by the 
machine init function (virt_init()).

rom_add_elf_program() adds the kernel to the ROM list
(in include/hw/elf_ops.h, glue(load_elf, SZ) that generates load_elf32() when SZ is 32...)

rom_add_file() adds the initrd to the ROM list too.

And ROMs are restored on reset from these copies by rom_reset().

rom_reset() is registered as a reset handler with qemu_register_reset() by 
rom_check_and_register_reset() at the end of the machine creation by qdev_machine_creation_done().

So I think bootinfo are not restored because there is no such function calls. Perhaps they are saved 
and restaured if they are stored in address space of one of the previous registered ROM.

Thanks,
Laurent

