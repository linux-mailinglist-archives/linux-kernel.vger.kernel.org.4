Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3656D380C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjDBNLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjDBNLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 09:11:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61759EF3;
        Sun,  2 Apr 2023 06:11:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m8so4643558wmq.5;
        Sun, 02 Apr 2023 06:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680441105; x=1683033105;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnKA/rJs/YqdQyIRLVbwT2UTWdW3DnAQlOaSJno/au0=;
        b=Ymd35wN2lMaWHqCqSopqFnECFfw8b8flj6TTeYkZ2I7gLilnjtJmC4lM0xAfFwuTAI
         AmrPN+fXKqN7l4VnIHmEeu//ekJkI/0J7l85WZk2FwMxMtOfbXLHfeYkMSPXJ499ArqF
         NJD7ZoaPY/1WRrYvKxmpn53lAeOPpMaNtQoxw3xqvoLULqMiJFZ8LzLL12Zx7K45H4yq
         nfRapQyc+LAVNYt57uyA4R4+4j8k+n0MZymZxy0+2B2euTAYktFjdLZ6XpWePyeDG3dO
         hmTPYEoyfzHEPgw0GNXswE1siKsfuYtaCIOsCTwwn+bIb9dnh2OYIiacznUjSQXnODIF
         TRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680441105; x=1683033105;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnKA/rJs/YqdQyIRLVbwT2UTWdW3DnAQlOaSJno/au0=;
        b=XGnUdA/FNRlzPVr37MGit7JKIewfwtXYUupLU/6TJfFqUFkV5QXdFESvqACttab2jd
         G43e03kk747aJkE6zvV//J9E8SdkNAsfDleF6/adsRt7NG9R89pcGbCbxelxx8i6OKQd
         PxZOXkJe5icvkLNI8WMbDKnAMZFZCw/YckMcvyuTUdqDG7uZWSdi69jkQsPN9TedIJ6A
         GOj+eCHfklwo1OCkrTaeq4qVaFZOeGyuqOcws1tjN9/WvLXdFCb6Bi0VC/EQS2fClTcf
         xtBU/XjPC1WvlEehLpuqkoHhrL7ysTWulFtO+pBn4eZojGD0jHBlYe/GBYzN70d9BRg2
         UYmA==
X-Gm-Message-State: AO0yUKUtqjbewYdbQzMybnFJ/mXQYXM6xkaGVTlWu/Fu7iK3ZADvjH+y
        lwAspErCD95EMpGAB6WleJifH6be6fF846nh
X-Google-Smtp-Source: AK7set+BE9+1XY1jQ2bVkiXLFXArtJVu5K69SzBLX7UK84QvLfETulq5BPtiC2yulCArNHPmSc9hOg==
X-Received: by 2002:a1c:790e:0:b0:3ed:a82d:dfe2 with SMTP id l14-20020a1c790e000000b003eda82ddfe2mr23897436wme.29.1680441104976;
        Sun, 02 Apr 2023 06:11:44 -0700 (PDT)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c228500b003e91b9a92c9sm9025808wmf.24.2023.04.02.06.11.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Apr 2023 06:11:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: Kernel Panic - V6.2 - Reseved memory issue
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
Date:   Sun, 2 Apr 2023 17:11:41 +0400
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BAD677A-74AF-4515-B19C-A15A69CE53EF@gmail.com>
References: <CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com>
To:     tanure@linux.com, Stefan Agner <stefan@agner.ch>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2 Apr 2023, at 12:10 pm, Lucas Tanure <tanure@linux.com> wrote:
>=20
> Hi,
>=20
> I am trying to fix a kernel panic I am seeing on my vim3 board =
(Amlogic A311D).
> I don't have enough knowledge about this area, but my current guess is
> the kernel is using a piece of memory belonging to ARM-trusted
> firmware that I shouldn't.
> Log:
>=20
> [ 9.792966] SError Interrupt on CPU3, code 0x00000000bf000000 -- =
SError
> [ 9.792980] CPU: 3 PID: 3471 Comm: kded5 Tainted: G C 6.2.0 #1
> [ 9.792985] Hardware name: Khadas VIM3 (DT)
> [ 9.792987] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS =
BTYPE=3D--)
> [ 9.792991] pc : kmem_cache_free_bulk.part.98+0x1f0/0x528
> [ 9.793004] lr : kmem_cache_free_bulk.part.98+0x2f8/0x528
> [ 9.793008] sp : ffff80000a2eb7f0
> [ 9.793009] x29: ffff80000a2eb7f0 x28: ffff00001f358518 x27: =
ffff000000008800
> [ 9.793016] x26: ffff00000262b300 x25: ffff00000262b300 x24: =
0000000000000001
> [ 9.793019] x23: ffff00000262b000 x22: 0000000000000000 x21: =
ffff00001f358538
> [ 9.793022] x20: fffffc0000098ac0 x19: 0000000000000004 x18: =
0000000000000040
> [ 9.793025] x17: 0000000000000018 x16: 00000000000007f8 x15: =
0000000000000003
> [ 9.793028] x14: 0000000000000006 x13: ffff800008e48550 x12: =
0000ffff9dc91fff
> [ 9.793031] x11: 0000000000000004 x10: 0000000000000001 x9 : =
ffff000007e93680
> [ 9.793035] x8 : 0000000000000020 x7 : ffff000001d2b100 x6 : =
0000000000000007
> [ 9.793037] x5 : 0000000000000020 x4 : ffff000000008800 x3 : =
0000000000000001
> [ 9.793040] x2 : 0000000000000007 x1 : 0000000000000000 x0 : =
ffff00001f358540
> [ 9.793045] Kernel panic - not syncing: Asynchronous SError Interrupt
>=20
> This doesn't happen with downstream Khadas 6.2 kernel, and that's
> because the downstream kernel removed this from
> early_init_dt_reserve_memory (drivers/of/fdt.c):
>=20
> /*
> * If the memory is already reserved (by another region), we
> * should not allow it to be marked nomap, but don't worry
> * if the region isn't memory as it won't be mapped.
> */
> if (memblock_overlaps_region(&memblock.memory, base, size) &&
>    memblock_is_region_reserved(base, size))
>          return -EBUSY;
>=20
>=20
> And this causes 3 MiB of memory belonging to ARM Trusted firmware to
> be reserved.
>=20
> arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi :
> /* 3 MiB reserved for ARM Trusted Firmware (BL31) */
> secmon_reserved: secmon@5000000 {
>        reg =3D <0x0 0x05000000 0x0 0x300000>;
>        no-map;
> };
>=20
> And the mainline kernel fails to reserve that memory:
> [    0.000000] OF: fdt: Reserved memory: failed to reserve memory for
> node 'secmon@5000000': base 0x0000000005000000, size 3 MiB
>=20
> It fails to reserve because memblock_overlaps_region and
> memblock_is_region_reserved return one.
> I think memblock_is_region_reserved is saying the memory is already
> reserved by uboot and shouldn't be nomap, but it should.
>=20
> Is there a bug here?
> Why the kernel is failing to reserve this memory?
> Is this an u-boot issue?
>=20
> I would appreciate any help. The current mainline kernel fails 90% of
> the time to boot into the Vim3 board.

The issue was raised before by Stefan Agner here:

=
https://lore.kernel.org/linux-arm-kernel/40ca11f84b7cdbfb9ad2ddd480cb204a@=
agner.ch/

The thread sort of points at the general issue but the conversation
fizzled out and didn=E2=80=99t lead to any changes. At one point Stefan =
made
a suggestion about reverting part of the code, leading to this patch
in my own patchset:

=
https://github.com/chewitt/linux/commit/9633c9b24f6f16afdb7fa8c2e163b6ea7a=
7ac5f8

The issue is still present and the patch does work around it. The
crashes would probably show up more, only a large percentage of
distros that actively support Amlogic boards (and several vendors)
are picking chunks of my curated LibreELEC patchset for their own
kernels and thus that patch is quite widely used.

Christian

