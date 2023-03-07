Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0497A6AE041
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCGNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjCGNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:19:44 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417DC1B556
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:19:03 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id v27so12251654vsa.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1678195142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5m6abGkwWanCk5tXnPK6IBB9qAUGfHHMPcuCUbVfTg=;
        b=gjxhQLjQyHjyXYHITiaCxJgBBBmqGHoGtpr7wyBx1Cy0wfs9oziMmE515Uub30S448
         kiBn91qGIrMCaNIs/yxuLLERhmXOUiykPqp1T2NfSdiz+lQS9E17XhLTfCfA0tf0reyb
         OXh1Z2CsBRnxD/kWLZIIaEFdwm1BItg8KiRnH26FQ+wWnMwu23u3KcR/1BAhNDXo9Ql3
         fgRSjZYQD+C34g4cg4YJlH1XJXm39TXOIJ6vHM8LTLTxOtqZiC4DH6TBJmpHFqIa/IJY
         O3tIuPuB0zQGPLIXg7rpi/63lwHngjsRIk4LtYo73bc/2BfzXMy65EJ3Lc3kdTBLmBLR
         /AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5m6abGkwWanCk5tXnPK6IBB9qAUGfHHMPcuCUbVfTg=;
        b=sncf7iaG8Ow1mEIwwEfehOKiGYYPJ4XY46UIlX8uFKmJl6zJAM4YN8PlQzA3BKdPVv
         r6RMEmB6gxuTYeVNfcUk/UE9RY+djrWBCFxB1M9+jiekdOIqZDxGk21sgtagwlBjAAiQ
         LH5/aDCEGWIir8OGcbO648m+ParpqMvHVbiKWmHx/tB6uO3qzG7Sz6i86AssN4c6UFJs
         1tPTFlEkV/L7onSzeItIzbCRMThTEd4ZvWX5Dz+L1xzr74N6yQc1pmg06yll6VkH51MO
         P27W/xdVdoWnM976VoFk6X+ZE++iLa1D01fheWsn35OP5pInZNuUyX4x0x/0mJPs2dQe
         YlfQ==
X-Gm-Message-State: AO0yUKXOdDtG5o8spDTQoQ1/jNbbuEBm5QfDeWX58Jw5rvLSUmHWRX92
        xHUnft6Ly7G+Tkrc5yfMcQVz+KIGUNEGV7Kk4I5U6g==
X-Google-Smtp-Source: AK7set/GX/xiuSrXgm/VSXdm3XOKRQlcqt5GoDWrcqRz8bpvNT1xmGeGz7BxwViubLWMgjrcrgo06F+QVhbprsjXRwY=
X-Received: by 2002:a67:ead9:0:b0:411:ffe1:9c6 with SMTP id
 s25-20020a67ead9000000b00411ffe109c6mr9687569vso.0.1678195142179; Tue, 07 Mar
 2023 05:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20230301082552.274331-1-alexghiti@rivosinc.com>
 <CAK9=C2XAOKbyrbOnDP1GzW1VyO-f-V-oEVcp+PhGHeHKFh4C6A@mail.gmail.com> <CAHVXubj9sCEuANsVe0N7YRMg8OPx_eALZfy0vERKU9P6QUDM0Q@mail.gmail.com>
In-Reply-To: <CAHVXubj9sCEuANsVe0N7YRMg8OPx_eALZfy0vERKU9P6QUDM0Q@mail.gmail.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 7 Mar 2023 18:48:48 +0530
Message-ID: <CAK9=C2XDkgZuaxO1fOWCxyCsGgiD=B_O4DmuAPwEhC65Mck9eA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, Mar 7, 2023 at 12:22=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Anup,
>
> On Mon, Mar 6, 2023 at 5:33=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> >
> > On Wed, Mar 1, 2023 at 1:56=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> > >
> > > This patchset intends to improve tlb utilization by using hugepages f=
or
> > > the linear mapping.
> > >
> > > base-commit-tag: v6.2-rc7
> > >
> > > v6:
> > > - quiet LLVM warning by casting phys_ram_base into an unsigned long
> > >
> > > v5:
> > > - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, thank=
s
> > >   Conor
> > > - Add RB from Andrew
> > >
> > > v4:
> > > - Rebase on top of v6.2-rc3, as noted by Conor
> > > - Add Acked-by Rob
> > >
> > > v3:
> > > - Change the comment about initrd_start VA conversion so that it fits
> > >   ARM64 and RISCV64 (and others in the future if needed), as suggeste=
d
> > >   by Rob
> > >
> > > v2:
> > > - Add a comment on why RISCV64 does not need to set initrd_start/end =
that
> > >   early in the boot process, as asked by Rob
> > >
> > > Alexandre Ghiti (2):
> > >   riscv: Get rid of riscv_pfn_base variable
> > >   riscv: Use PUD/P4D/PGD pages for the linear mapping
> >
> > I tried this series but it is getting stuck after reaching user space.
> >
> > Does this series require some other dependent patches ?
>
> No it should not. Let me take a look: what's your config and the base com=
mit?

Please try the alexghiti_test branch at:
https://github.com/avpatel/linux.git

Compile the kernel with defconfig and launch QEMU as follows:
qemu-system-riscv64 -M virt -m 1G -nographic -bios
opensbi/build/platform/generic/firmware/fw_jump.bin -kernel
./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/ram rw
console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img

In the above command, rootfs_riscv64.img is a busybox based rootfs.

Regards,
Anup

>
> >
> > Regards,
> > Anup
> >
> > >
> > >  arch/riscv/include/asm/page.h | 19 +++++++++++++++++--
> > >  arch/riscv/mm/init.c          | 28 ++++++++++++++++++----------
> > >  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
> > >  drivers/of/fdt.c              | 11 ++++++-----
> > >  4 files changed, 57 insertions(+), 17 deletions(-)
> > >
> > > --
> > > 2.37.2
> > >
