Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE86AE0AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCGNgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCGNgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:36:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B68A62B5E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:36:44 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j2so12124076wrh.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678196202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psTRywtzl68njLyoyMeFGZqYTnFyd3ofmQ3diHYsd3k=;
        b=dZNhqcjc+Tyw7rHD240aQ69pbdZ7dN1ncj4vPHqRrgjYBOen6TwvDeBWaSH5Igte7X
         7C/RYeDGxzzhpm8yfFsLR6gfLaVN+W6Q586eFpjRNWVHXHPcbOyeRmr6/9CJtjfyA7gb
         blGDXSBcWZmaSfemM7JL8lVRkOncrTP4mMca73KdFqvxQ/+NgtuoyBbb3ekzZhEUb0sB
         yxXDHoKwn4H2IQqNNWd72/mAghCto8ubanep2HgZFn3Qh9t3LO85lzAWyE9ANBxhzH+t
         SRz907v0NM1lmUZ9y6ZGhVF05ij0iSlwSE+eYYjObIQyJOb+OkigEjOM974VBBMKRq4O
         ADOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psTRywtzl68njLyoyMeFGZqYTnFyd3ofmQ3diHYsd3k=;
        b=zDmALkSXRE5L/gIN8LkCy9v8p56NMdltTQpdS5bwf70aKY4Nht1zHs4wj5ARp82Ilf
         ZUGOrDGo16gME+zvlBHsVG9e8kc1TQqtl2OOZ6ahN6wWJ6KN/YZxRAoPm3HN0Kp7ZB8z
         D5kuawknSTpMsJRQRfT7uWs2E2SWlvUQv4ke7jnC9YovcqG7ZUYsIxTSKs7uWjDUl6Gj
         OT8zP2y5cJ0ZgP1MWM9v/6Zo9/HM2ZeZfyw/fD9TTshbr1rRel0WExbtiTSGooNS26nz
         mqDzJhUhWCu5yFZh4tzcHrgMTnY4ipxLlHtkiBXCLm9mR89/P0Fz4//ZpIiE86LuQPT3
         +DFw==
X-Gm-Message-State: AO0yUKV3RQhKiK8vWmKs5Y6Au6EGmIev5M0OmvgmQXSKKWBzCPFE5RG3
        evn0GATNV7SQ/wSJa2XALCF4Aq9DESvQJ/2xjsAjAg==
X-Google-Smtp-Source: AK7set/BsN6tbDw8kZ/LkJFYQlT9RdjOo7dvo8ti9Techq1p7qOOko8EcxaT1uAy5MUHI2bAqFOUDwH2UlDF1pkJZpw=
X-Received: by 2002:a5d:534e:0:b0:2c9:e34e:7d2 with SMTP id
 t14-20020a5d534e000000b002c9e34e07d2mr2655948wrv.11.1678196202706; Tue, 07
 Mar 2023 05:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20230301082552.274331-1-alexghiti@rivosinc.com>
 <CAK9=C2XAOKbyrbOnDP1GzW1VyO-f-V-oEVcp+PhGHeHKFh4C6A@mail.gmail.com>
 <CAHVXubj9sCEuANsVe0N7YRMg8OPx_eALZfy0vERKU9P6QUDM0Q@mail.gmail.com> <CAK9=C2XDkgZuaxO1fOWCxyCsGgiD=B_O4DmuAPwEhC65Mck9eA@mail.gmail.com>
In-Reply-To: <CAK9=C2XDkgZuaxO1fOWCxyCsGgiD=B_O4DmuAPwEhC65Mck9eA@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 7 Mar 2023 14:36:31 +0100
Message-ID: <CAHVXubg6dgr9dM1-mR+xh6D+5cmistWmo2dJQaZavcWGcCshag@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 2:19=E2=80=AFPM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> Hi Alex,
>
> On Tue, Mar 7, 2023 at 12:22=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosi=
nc.com> wrote:
> >
> > Hi Anup,
> >
> > On Mon, Mar 6, 2023 at 5:33=E2=80=AFPM Anup Patel <apatel@ventanamicro.=
com> wrote:
> > >
> > > On Wed, Mar 1, 2023 at 1:56=E2=80=AFPM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > > >
> > > > This patchset intends to improve tlb utilization by using hugepages=
 for
> > > > the linear mapping.
> > > >
> > > > base-commit-tag: v6.2-rc7
> > > >
> > > > v6:
> > > > - quiet LLVM warning by casting phys_ram_base into an unsigned long
> > > >
> > > > v5:
> > > > - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, tha=
nks
> > > >   Conor
> > > > - Add RB from Andrew
> > > >
> > > > v4:
> > > > - Rebase on top of v6.2-rc3, as noted by Conor
> > > > - Add Acked-by Rob
> > > >
> > > > v3:
> > > > - Change the comment about initrd_start VA conversion so that it fi=
ts
> > > >   ARM64 and RISCV64 (and others in the future if needed), as sugges=
ted
> > > >   by Rob
> > > >
> > > > v2:
> > > > - Add a comment on why RISCV64 does not need to set initrd_start/en=
d that
> > > >   early in the boot process, as asked by Rob
> > > >
> > > > Alexandre Ghiti (2):
> > > >   riscv: Get rid of riscv_pfn_base variable
> > > >   riscv: Use PUD/P4D/PGD pages for the linear mapping
> > >
> > > I tried this series but it is getting stuck after reaching user space=
.
> > >
> > > Does this series require some other dependent patches ?
> >
> > No it should not. Let me take a look: what's your config and the base c=
ommit?
>
> Please try the alexghiti_test branch at:
> https://github.com/avpatel/linux.git
>
> Compile the kernel with defconfig and launch QEMU as follows:
> qemu-system-riscv64 -M virt -m 1G -nographic -bios
> opensbi/build/platform/generic/firmware/fw_jump.bin -kernel
> ./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/ram rw
> console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img
>
> In the above command, rootfs_riscv64.img is a busybox based rootfs.

Ok I can reproduce the problem. I'll debug that a bit further but
increasing memory allows booting to userspace.

>
> Regards,
> Anup
>
> >
> > >
> > > Regards,
> > > Anup
> > >
> > > >
> > > >  arch/riscv/include/asm/page.h | 19 +++++++++++++++++--
> > > >  arch/riscv/mm/init.c          | 28 ++++++++++++++++++----------
> > > >  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
> > > >  drivers/of/fdt.c              | 11 ++++++-----
> > > >  4 files changed, 57 insertions(+), 17 deletions(-)
> > > >
> > > > --
> > > > 2.37.2
> > > >
