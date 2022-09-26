Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EE25EA8F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiIZOsl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Sep 2022 10:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiIZOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:47:50 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3311DF1D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:13:16 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id z9so4245846qvn.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XBGFSl/wwXaQtUVRFQdrnUu+CvpuUCanwda+7qtWhK0=;
        b=6wiNhby/dpPWpqvrUiWR5jy6sThxH4KiirCQvvr/cdu4aPAUAo3KNQ7Ix7aaglWp/X
         3AGklFuza/aBvGvyBm9Cw7ixQbESuomyoLf42k9fLtQkKwW5CTdiGLuefTS2FFNtol/6
         1Kd4+mZ1iW0ZGVZfHuB6CCo5rcFgaHs6LE7rMCzJEgo8+h56qM/IpeDCP0CWXsNLF3MM
         jR5mDbNaSjVR0cp5yQMiz6HU7tkcgnwtRZ7/GXsB6PoFCWkI3QZNTyyF00pOWHFZ5BYt
         GjViz8J/ZTpNYvnP0CoV8I66Z/FzlqZTby5EYIFbg3zcAw+c0tHI7X0fn6w2Frewih90
         SKog==
X-Gm-Message-State: ACrzQf3+RJMvPQaUWSaSsXOM/F6R6xIfXIq45r2mS9ujqnCgMfYwnJmG
        /apjotEJs31kzR5AhpFy1pQV43taLtDOJA==
X-Google-Smtp-Source: AMsMyM5UBFQX6rh1c0UoM7EEe+jOf0+dtmfVOV3NP4s62NEnHQrgCojpKkyKP4xGoTzX0xthz2ymGA==
X-Received: by 2002:a05:6214:2aae:b0:4ac:acc9:b84e with SMTP id js14-20020a0562142aae00b004acacc9b84emr17028226qvb.124.1664197995162;
        Mon, 26 Sep 2022 06:13:15 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id bl21-20020a05620a1a9500b006ce30a5f892sm11295977qkb.102.2022.09.26.06.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 06:13:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id f189so8256096yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:13:14 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr19777467ybl.604.1664197994528; Mon, 26
 Sep 2022 06:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185208.3549140-1-Jason@zx2c4.com> <20220921185208.3549140-2-Jason@zx2c4.com>
 <CAMuHMdUuM85s1APoxRmXnw13hHHEGgo8Z9EKvpV6maaZPaVUfA@mail.gmail.com>
 <CAHmME9pAsY4M=V0o4QLrrQiXwCvtiEO9FApBibXRiG41h-AgVA@mail.gmail.com>
 <CAMuHMdUSF=ARvKTP33psHNWEqvSeUUDuWLRsUUA7LHa+12agng@mail.gmail.com>
 <CAHmME9ocjS11ugpKKwmosqb2HUBf4_N74a056=OOoj06yD6wmQ@mail.gmail.com>
 <CAMuHMdWruwCNqM3eLaaM9L+D+ZTw+t6z3O+rjNWTMiCQyj4_zQ@mail.gmail.com>
 <eb798159-c003-3b43-c891-039080e06e03@vivier.eu> <CAHmME9rnxvDDu-hSG8PNJC+xs6khbgdMzXcaB79ByZjJd3RQjw@mail.gmail.com>
 <ae3232b2-4277-eee3-726c-30a3a21c41b7@vivier.eu> <CAHmME9omvDj6NcbrSth8P03ciRVf0VcQRDfTJix7yiCoBsg02g@mail.gmail.com>
 <e0ee39d5-33e9-c7ae-a1e9-3b21e83c70fd@vivier.eu> <CAHmME9qeRVySk2M0MOBvJ5aRHWfNUx_9HQOgAY7JMdrV0OuKag@mail.gmail.com>
In-Reply-To: <CAHmME9qeRVySk2M0MOBvJ5aRHWfNUx_9HQOgAY7JMdrV0OuKag@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 15:13:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUevNjzvRVmQynaBOZ+FzhQvjjEnx67cZcC7nR20bLLgQ@mail.gmail.com>
Message-ID: <CAMuHMdUevNjzvRVmQynaBOZ+FzhQvjjEnx67cZcC7nR20bLLgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] m68k: virt: generate new RNG seed on reboot
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Sep 26, 2022 at 3:04 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Mon, Sep 26, 2022 at 3:02 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > Le 26/09/2022 à 14:56, Jason A. Donenfeld a écrit :
> > > On Mon, Sep 26, 2022 at 2:52 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > >> Le 26/09/2022 à 14:02, Jason A. Donenfeld a écrit :
> > >>> On Fri, Sep 23, 2022 at 3:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
> > >>>> Le 23/09/2022 à 14:50, Geert Uytterhoeven a écrit :
> > >>>>> On Fri, Sep 23, 2022 at 2:26 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >>>>>> On Fri, Sep 23, 2022 at 2:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >>>>>>>> The way I tested this is by having my initramfs just call
> > >>>>>>>> `reboot(RB_AUTOBOOT);`, and having add_bootloader_randomness() print
> > >>>>>>>> its contents to the console. I checked that it was both present and
> > >>>>>>>> different every time.
> > >>>>>>>
> > >>>>>>> Are you sure the new kernel did receive the same randomness as prepared
> > >>>>>>> by get_random_bytes()? I would expect it to just reboot into qemu,
> > >>>>>>> reload the kernel from disk, and recreate a new bootinfo from scratch,
> > >>>>>>> including generating a new random seed.
> > >>>>>>
> > >>>>>> Yes I'm sure. Without this patch, the new kernel sees the zeroed state.
> > >>>>>
> > >>>>> That's interesting.  So QEMU preserves the old bootinfo, which is
> > >>>>> AFAIK not guaranteed to be still available (that's why I added
> > >>>>> save_bootinfo()).  Perhaps that works because only memory starting
> > >>>>> from a rounded-up value of _end will be used, and you're just lucky?
> > >>>>> I'm wondering what else it preserves. It sure has to reload the
> > >>>>> kernel image, as at least the data section will no longer contain the
> > >>>>> initialization values after a reboot...
> > >>>>>
> > >>>>> Laurent?
> > >>>>>
> > >>>>
> > >>>> In QEMU the loader makes a copy of the kernel and the initrd and this copy is restored on a reset.
> > >>>>
> > >>>> I don't think there is a mechanism in QEMU to save the BOOTINFO section, so I think it works by
> > >>>> luck. I will check.
> > >>>>
> > >>>> Thanks,
> > >>>> Laurent
> > >>>
> > >>> Are you sure about that? Or at least, could you point me to where you
> > >>> think this happens? I'm not as familiar as you with this code base,
> > >>> but I really am not seeing it. So far as I can tell, on reset, the pc
> > >>> and stack are reset to their initial places, after TCG resets the cpu
> > >>> registers to a known state. But the kernel is not reloaded. The same
> > >>> thing that was in memory before is used again.
> > >>
> > >> Yes, this is not clear in QEMU but I think this happens in rom_reset():
> > >>
> > >> hw/core/loader.c
> > >>
> > >> 1180         if (rom->mr) {
> > >> 1181             void *host = memory_region_get_ram_ptr(rom->mr);
> > >> 1182             memcpy(host, rom->data, rom->datasize);
> > >> 1183             memset(host + rom->datasize, 0, rom->romsize - rom->datasize);
> > >> 1184         } else {
> > >> 1185             address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECIFIED,
> > >> 1186                                     rom->data, rom->datasize);
> > >> 1187             address_space_set(rom->as, rom->addr + rom->datasize, 0,
> > >> 1188                               rom->romsize - rom->datasize,
> > >> 1189                               MEMTXATTRS_UNSPECIFIED);
> > >> 1190         }
> > >>
> > >> kernel and initrd are loaded with load_elf() and load_image_targphys() only once at startup by the
> > >> machine init function (virt_init()).
> > >>
> > >> rom_add_elf_program() adds the kernel to the ROM list
> > >> (in include/hw/elf_ops.h, glue(load_elf, SZ) that generates load_elf32() when SZ is 32...)
> > >>
> > >> rom_add_file() adds the initrd to the ROM list too.
> > >>
> > >> And ROMs are restored on reset from these copies by rom_reset().
> > >>
> > >> rom_reset() is registered as a reset handler with qemu_register_reset() by
> > >> rom_check_and_register_reset() at the end of the machine creation by qdev_machine_creation_done().
> > >>
> > >> So I think bootinfo are not restored because there is no such function calls. Perhaps they are saved
> > >> and restaured if they are stored in address space of one of the previous registered ROM.
> > >
> > > Ahh interesting, thanks for the explanation.
> > >
> > > So from my debugging, bootinfo is *not* restored, and the previous one
> > > appears to be used. Fortunately it's intact and everything works well
> > > on a reboot.
> > >
> > > With that in mind, we now we have to decide whether to:
> > > A) Go with my linux patch to write the rng seed before rebooting (3/3
> > > in v4 of that series).
> > > B) Not go with the linux patch, but instead make sure bootinfo is
> > > restored to its previous value, and then also register a qemu reboot
> > > notifier to refresh the seed in it, like what x86 does.
> >
> > I prefer B :)
> > It's cleaner and under QEMU control.

Me too.

> Okay. I'm happy to follow your preference. Just one last question,
> though: is this what happens on baremetal bootloaders too? Or does no
> such thing really exist so it doesn't matter?

On e.g. Amiga, the whole system is reset, and starts AmigaOS from ROM.
So for booting Linux, you go through the whole Linux bootstrap chain,
loading kernel and optional ramdisk, preparing bootinfo, and passing
all of that to Linux. It should be the same on other real platforms.

ARAnyM has its own bootstrap, and handles reboot itself, but it seems
to behave the same, as it reloads a new kernel from disk on reboot.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
