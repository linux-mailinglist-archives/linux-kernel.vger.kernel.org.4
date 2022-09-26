Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561045EA8E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiIZOrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiIZOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:46:37 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7441B1C118;
        Mon, 26 Sep 2022 06:10:49 -0700 (PDT)
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MOAr1-1os1To2eBV-00OYJW; Mon, 26 Sep 2022 15:10:45 +0200
Message-ID: <de443669-dff9-a6e1-83cb-601fd1d93ddb@vivier.eu>
Date:   Mon, 26 Sep 2022 15:10:44 +0200
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
 <e0ee39d5-33e9-c7ae-a1e9-3b21e83c70fd@vivier.eu>
 <CAHmME9qeRVySk2M0MOBvJ5aRHWfNUx_9HQOgAY7JMdrV0OuKag@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <CAHmME9qeRVySk2M0MOBvJ5aRHWfNUx_9HQOgAY7JMdrV0OuKag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ra7u4yl+gzo+PQSiICSXG0mp+C9RWJ8pbJxGf5eqAL0peom8H00
 w63ynDA4DPRNI+WurjTX/i4QI1DJMPMv8Sd4mqNEr98fghRUc151bKZPY+CEhyrKJrzphla
 Jh+A25XUsjMr9WxblAT9yiCzch1vQPG87jgo6ySMTbKihd/QR1ZZJMkX0UWgpx524V/7N+1
 9vNkCb0vh3tbp7vV8qYJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xhCHQt7uk5g=:/sDHp5TsPqedYxAFqUCZx5
 vm9n9PcHQH3Ux8tHBrwagS+JDOQYlRHYAelaIwybTPqUiAgEJcT9Akw7yezoDc7S8uXvKFOG2
 2HWayMh9dR3a8ym503f7hQXrScv1sKK3BO8s3S9zghYAh89HaUNYN/bqC4UZCvuqjCu7OWJTq
 Q6T6x/7nqJItrhF9/WP7obtKuM9SQpWSirjILt10onrIj/WiD3a1k5493rOMvItCaIZFUeu7s
 vuOranpgcfJr+iwA/wvtGDN6dNwjlLSi7Mlao5hN/0QwLRS3gmzlp3ko/OXRn93IpGvKORf9P
 7M7BBM/e7tGc6MfiT8ZjECB16TZtqwZCIHWtjr45uLhiarJ8tbfTM9BXhEJZt3Oj3+pfCCL76
 ItJP/v7AcfOCPxfAI4u6m4CFb+WQk76wQPPAnA04Kyj93bO99MSBbgVjyUIjDPKdb9+648DIJ
 3FkbLmKpcJhNI/EM4hrxijIVfr52xIHf5IApI4jyRxIV/DAR2eB0DaFjNtoA7WFWbUKpluw41
 M/AiMQPCL4o4CmezdrHhuzHznve9FucT+Cok8PAPfT5ufvzloRfp++Cw3CThiYVhvzXrE4nls
 PpSYmccvBQuhezv5NOgvrRVwktq8wDQAnM1WB5m3V0Myq863Gjj8NILqTtARhzSj9bP7smJ0f
 82pcEQHXX+Jj9NsxpxLqQwhMzly30jH1XINfAwuiZm/e5at3LIW64UYAJPPDG/Ovzkl7qN+tX
 1/WAWh4tZa/5ayA5CoxWGYBmo8q+F5dwAKRTP/FYc3TpcZ4H0kjc1w/EC0pG64llyHr7lafrj
 SrgdkP+
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/09/2022 à 15:04, Jason A. Donenfeld a écrit :
> On Mon, Sep 26, 2022 at 3:02 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 26/09/2022 à 14:56, Jason A. Donenfeld a écrit :
>>> Hi Laurent,
>>>
>>> On Mon, Sep 26, 2022 at 2:52 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> Hi Jason,
>>>>
>>>> Le 26/09/2022 à 14:02, Jason A. Donenfeld a écrit :
>>>>> Hi Laurent,
>>>>>
>>>>> On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>>>>
>>>>>> Le 23/09/2022 à 14:50, Geert Uytterhoeven a écrit :
>>>>>>> Hi Jason,
>>>>>>>
>>>>>>> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>>>>>>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>>>>>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeof(*rng_seed_record) + 2) {
>>>>>>>>>>>> +               u16 len = rng_seed_record->size - sizeof(*rng_seed_record) - 2;
>>>>>>>>>>>> +               get_random_bytes((u8 *)rng_seed_record->data + 2, len);
>>>>>>>>>>>> +               *(u16 *)rng_seed_record->data = len;
>>>>>>>>>
>>>>>>>>> Storing the length should use the proper cpu_to_be16 accessor.
>>>>>>>>
>>>>>>>> Okay, I'll do that for v2.
>>>>>>>>
>>>>>>>> (Simply out of curiosity, why? Isn't m68k always big endian and this
>>>>>>>> is arch/ code?)
>>>>>>>
>>>>>>> Yes it is.  But virt_parse_bootinfo() below already uses the right
>>>>>>> accessor.
>>>>>>>
>>>>>>> BTW, I guess people thought the same about PowerPC?
>>>>>>> Although I agree the probability of someone creating a little-endian
>>>>>>> m68k clone in an FPGA or SkyWater project and trying to run Linux on
>>>>>>> it quite low ;-)
>>>>>>>
>>>>>>>>>> The way I tested this is by having my initramfs just call
>>>>>>>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
>>>>>>>>>> its contents to the console. I checked that it was both present and
>>>>>>>>>> different every time.
>>>>>>>>>
>>>>>>>>> Are you sure the new kernel did receive the same randomness as prepared
>>>>>>>>> by get_random_bytes()? I would expect it to just reboot into qemu,
>>>>>>>>> reload the kernel from disk, and recreate a new bootinfo from scratch,
>>>>>>>>> including generating a new random seed.
>>>>>>>>
>>>>>>>> Yes I'm sure. Without this patch, the new kernel sees the zeroed state.
>>>>>>>
>>>>>>> That's interesting.  So QEMU preserves the old bootinfo, which is
>>>>>>> AFAIK not guaranteed to be still available (that's why I added
>>>>>>> save_bootinfo()).  Perhaps that works because only memory starting
>>>>>>> from a rounded-up value of _end will be used, and you're just lucky?
>>>>>>> I'm wondering what else it preserves. It sure has to reload the
>>>>>>> kernel image, as at least the data section will no longer contain the
>>>>>>> initialization values after a reboot...
>>>>>>>
>>>>>>> Laurent?
>>>>>>>
>>>>>>
>>>>>> In QEMU the loader makes a copy of the kernel and the initrd and this copy is restored on a reset.
>>>>>>
>>>>>> I don't think there is a mechanism in QEMU to save the BOOTINFO section, so I think it works by
>>>>>> luck. I will check.
>>>>>>
>>>>>> Thanks,
>>>>>> Laurent
>>>>>
>>>>> Are you sure about that? Or at least, could you point me to where you
>>>>> think this happens? I'm not as familiar as you with this code base,
>>>>> but I really am not seeing it. So far as I can tell, on reset, the pc
>>>>> and stack are reset to their initial places, after TCG resets the cpu
>>>>> registers to a known state. But the kernel is not reloaded. The same
>>>>> thing that was in memory before is used again.
>>>>
>>>> Yes, this is not clear in QEMU but I think this happens in rom_reset():
>>>>
>>>> hw/core/loader.c
>>>>
>>>> 1180         if (rom->mr) {
>>>> 1181             void *host = memory_region_get_ram_ptr(rom->mr);
>>>> 1182             memcpy(host, rom->data, rom->datasize);
>>>> 1183             memset(host + rom->datasize, 0, rom->romsize - rom->datasize);
>>>> 1184         } else {
>>>> 1185             address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECIFIED,
>>>> 1186                                     rom->data, rom->datasize);
>>>> 1187             address_space_set(rom->as, rom->addr + rom->datasize, 0,
>>>> 1188                               rom->romsize - rom->datasize,
>>>> 1189                               MEMTXATTRS_UNSPECIFIED);
>>>> 1190         }
>>>>
>>>> kernel and initrd are loaded with load_elf() and load_image_targphys() only once at startup by the
>>>> machine init function (virt_init()).
>>>>
>>>> rom_add_elf_program() adds the kernel to the ROM list
>>>> (in include/hw/elf_ops.h, glue(load_elf, SZ) that generates load_elf32() when SZ is 32...)
>>>>
>>>> rom_add_file() adds the initrd to the ROM list too.
>>>>
>>>> And ROMs are restored on reset from these copies by rom_reset().
>>>>
>>>> rom_reset() is registered as a reset handler with qemu_register_reset() by
>>>> rom_check_and_register_reset() at the end of the machine creation by qdev_machine_creation_done().
>>>>
>>>> So I think bootinfo are not restored because there is no such function calls. Perhaps they are saved
>>>> and restaured if they are stored in address space of one of the previous registered ROM.
>>>
>>> Ahh interesting, thanks for the explanation.
>>>
>>> So from my debugging, bootinfo is *not* restored, and the previous one
>>> appears to be used. Fortunately it's intact and everything works well
>>> on a reboot.
>>>
>>> With that in mind, we now we have to decide whether to:
>>> A) Go with my linux patch to write the rng seed before rebooting (3/3
>>> in v4 of that series).
>>> B) Not go with the linux patch, but instead make sure bootinfo is
>>> restored to its previous value, and then also register a qemu reboot
>>> notifier to refresh the seed in it, like what x86 does.
>>>
>>
>> I prefer B :)
>> It's cleaner and under QEMU control.
> 
> Okay. I'm happy to follow your preference. Just one last question,
> though: is this what happens on baremetal bootloaders too? Or does no
> such thing really exist so it doesn't matter?

With a baremetal bootloader information are provided by the firmware.

In our case, we don't have bootloader nor firmware as the kernel is loaded and started by QEMU.
So QEMU must do the bootloader and the firmware actions. It's why I prefer B.

Thanks,
LAurent

