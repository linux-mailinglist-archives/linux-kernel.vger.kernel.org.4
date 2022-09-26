Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEBA5EA8C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiIZOmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiIZOlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451642AF5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:04:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1A3160CF4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB93CC43470
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 13:04:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MwWiARNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664197464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eR2+vCt5rbu8oFVMMRzFPsYJE450ddjyrWAqQ3X2XMU=;
        b=MwWiARNJk+ubCmBPxambBqKQrEfaD7haj27+m07FBb1ztWPVbW31oxH3PT02U15qKHuzEX
        SWwE68cQvH8TPin4gdfCK7Zq8kEBY3hOkL8qB4MpB/LvCnYznXt/wQJZZ09xvN+uXlqd0Z
        yQdU/b2Rn6prBrz+SNWmDdmGyYCG5ic=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 148b2e38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 26 Sep 2022 13:04:24 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id j7so6408190vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:04:24 -0700 (PDT)
X-Gm-Message-State: ACrzQf26v/1u7lzxHxY6uKKQZH7JtiAkcoo0EFn36d24JgI+q1ydDs5K
        QU+d7wXpULuudWu7CWtHAkXo8UqJBzyXqW6UPlI=
X-Google-Smtp-Source: AMsMyM4s10Y10qaJqkejWHspHMCYhe/GxWKVNVa9NOryvG+hkbZu9aHAXQiK0lq15ZjM0GhzrvTgm5f9+Qd+4CJQQIM=
X-Received: by 2002:a05:6102:2908:b0:398:ac40:d352 with SMTP id
 cz8-20020a056102290800b00398ac40d352mr6808337vsb.55.1664197463461; Mon, 26
 Sep 2022 06:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
 <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
 <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
 <eb798159-c003-3b43-c891-039080e06e03@vivier.eu> <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
 <ae3232b2-4277-eee3-726c-30a3a21c41b7@vivier.eu> <CAHmME9omvDj6NcbrSth8P03ciRVf0VcQRDfTJix7yiCoBsg02g@mail.gmail.com>
 <e0ee39d5-33e9-c7ae-a1e9-3b21e83c70fd@vivier.eu>
In-Reply-To: <e0ee39d5-33e9-c7ae-a1e9-3b21e83c70fd@vivier.eu>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 15:04:12 +0200
X-Gmail-Original-Message-ID: <CAHmME9qeRVySk2M0MOBvJ5aRHWfNUx_9HQOgAY7JMdrV0OuKag@mail.gmail.com>
Message-ID: <CAHmME9qeRVySk2M0MOBvJ5aRHWfNUx_9HQOgAY7JMdrV0OuKag@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 3:02 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 26/09/2022 =C3=A0 14:56, Jason A. Donenfeld a =C3=A9crit :
> > Hi Laurent,
> >
> > On Mon, Sep 26, 2022 at 2:52 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Hi Jason,
> >>
> >> Le 26/09/2022 =C3=A0 14:02, Jason A. Donenfeld a =C3=A9crit :
> >>> Hi Laurent,
> >>>
> >>> On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wr=
ote:
> >>>>
> >>>> Le 23/09/2022 =C3=A0 14:50, Geert Uytterhoeven a =C3=A9crit :
> >>>>> Hi Jason,
> >>>>>
> >>>>> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
> >>>>>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> >>>>>>>>>> +       if (rng_seed_record && rng_seed_record->size > sizeof(=
*rng_seed_record) + 2) {
> >>>>>>>>>> +               u16 len =3D rng_seed_record->size - sizeof(*rn=
g_seed_record) - 2;
> >>>>>>>>>> +               get_random_bytes((u8 *)rng_seed_record->data +=
 2, len);
> >>>>>>>>>> +               *(u16 *)rng_seed_record->data =3D len;
> >>>>>>>
> >>>>>>> Storing the length should use the proper cpu_to_be16 accessor.
> >>>>>>
> >>>>>> Okay, I'll do that for v2.
> >>>>>>
> >>>>>> (Simply out of curiosity, why? Isn't m68k always big endian and th=
is
> >>>>>> is arch/ code?)
> >>>>>
> >>>>> Yes it is.  But virt_parse_bootinfo() below already uses the right
> >>>>> accessor.
> >>>>>
> >>>>> BTW, I guess people thought the same about PowerPC?
> >>>>> Although I agree the probability of someone creating a little-endia=
n
> >>>>> m68k clone in an FPGA or SkyWater project and trying to run Linux o=
n
> >>>>> it quite low ;-)
> >>>>>
> >>>>>>>> The way I tested this is by having my initramfs just call
> >>>>>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() p=
rint
> >>>>>>>> its contents to the console. I checked that it was both present =
and
> >>>>>>>> different every time.
> >>>>>>>
> >>>>>>> Are you sure the new kernel did receive the same randomness as pr=
epared
> >>>>>>> by get_random_bytes()? I would expect it to just reboot into qemu=
,
> >>>>>>> reload the kernel from disk, and recreate a new bootinfo from scr=
atch,
> >>>>>>> including generating a new random seed.
> >>>>>>
> >>>>>> Yes I'm sure. Without this patch, the new kernel sees the zeroed s=
tate.
> >>>>>
> >>>>> That's interesting.  So QEMU preserves the old bootinfo, which is
> >>>>> AFAIK not guaranteed to be still available (that's why I added
> >>>>> save_bootinfo()).  Perhaps that works because only memory starting
> >>>>> from a rounded-up value of _end will be used, and you're just lucky=
?
> >>>>> I'm wondering what else it preserves. It sure has to reload the
> >>>>> kernel image, as at least the data section will no longer contain t=
he
> >>>>> initialization values after a reboot...
> >>>>>
> >>>>> Laurent?
> >>>>>
> >>>>
> >>>> In QEMU the loader makes a copy of the kernel and the initrd and thi=
s copy is restored on a reset.
> >>>>
> >>>> I don't think there is a mechanism in QEMU to save the BOOTINFO sect=
ion, so I think it works by
> >>>> luck. I will check.
> >>>>
> >>>> Thanks,
> >>>> Laurent
> >>>
> >>> Are you sure about that? Or at least, could you point me to where you
> >>> think this happens? I'm not as familiar as you with this code base,
> >>> but I really am not seeing it. So far as I can tell, on reset, the pc
> >>> and stack are reset to their initial places, after TCG resets the cpu
> >>> registers to a known state. But the kernel is not reloaded. The same
> >>> thing that was in memory before is used again.
> >>
> >> Yes, this is not clear in QEMU but I think this happens in rom_reset()=
:
> >>
> >> hw/core/loader.c
> >>
> >> 1180         if (rom->mr) {
> >> 1181             void *host =3D memory_region_get_ram_ptr(rom->mr);
> >> 1182             memcpy(host, rom->data, rom->datasize);
> >> 1183             memset(host + rom->datasize, 0, rom->romsize - rom->d=
atasize);
> >> 1184         } else {
> >> 1185             address_space_write_rom(rom->as, rom->addr, MEMTXATTR=
S_UNSPECIFIED,
> >> 1186                                     rom->data, rom->datasize);
> >> 1187             address_space_set(rom->as, rom->addr + rom->datasize,=
 0,
> >> 1188                               rom->romsize - rom->datasize,
> >> 1189                               MEMTXATTRS_UNSPECIFIED);
> >> 1190         }
> >>
> >> kernel and initrd are loaded with load_elf() and load_image_targphys()=
 only once at startup by the
> >> machine init function (virt_init()).
> >>
> >> rom_add_elf_program() adds the kernel to the ROM list
> >> (in include/hw/elf_ops.h, glue(load_elf, SZ) that generates load_elf32=
() when SZ is 32...)
> >>
> >> rom_add_file() adds the initrd to the ROM list too.
> >>
> >> And ROMs are restored on reset from these copies by rom_reset().
> >>
> >> rom_reset() is registered as a reset handler with qemu_register_reset(=
) by
> >> rom_check_and_register_reset() at the end of the machine creation by q=
dev_machine_creation_done().
> >>
> >> So I think bootinfo are not restored because there is no such function=
 calls. Perhaps they are saved
> >> and restaured if they are stored in address space of one of the previo=
us registered ROM.
> >
> > Ahh interesting, thanks for the explanation.
> >
> > So from my debugging, bootinfo is *not* restored, and the previous one
> > appears to be used. Fortunately it's intact and everything works well
> > on a reboot.
> >
> > With that in mind, we now we have to decide whether to:
> > A) Go with my linux patch to write the rng seed before rebooting (3/3
> > in v4 of that series).
> > B) Not go with the linux patch, but instead make sure bootinfo is
> > restored to its previous value, and then also register a qemu reboot
> > notifier to refresh the seed in it, like what x86 does.
> >
>
> I prefer B :)
> It's cleaner and under QEMU control.

Okay. I'm happy to follow your preference. Just one last question,
though: is this what happens on baremetal bootloaders too? Or does no
such thing really exist so it doesn't matter?

Jason
