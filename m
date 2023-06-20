Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0307365DC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFTIO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjFTIOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:14:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE1B1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:14:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f918922954so20251335e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687248860; x=1689840860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQbdggw74AN0qE4N6rw9FwT496orbg2m9a2V0ULV/Uw=;
        b=qeI0jNx4MMXFY5pvb2+qLIUHE7ZFkv9z5nksQ+dxl7WQDJDA6+otDYPwrUmXxmcMc7
         OwY/zr/aawnu6IYyKH0dL4oTgDWILHJ8GE4g7oM4ZXA44gQCTVks6rRprW25HTKvFTCe
         Y/kcZOLY0w/EttyjMfaGUb2cOvcA8GAA1i+SIrr9fKqmIpVL8OC0Wy4v6543snbr7Osi
         hMsqWpBVWBjzsVHJrPwqBJDJjYH+PEKgscMI+vADvpubrPH+k69kTmWDJ1SgwO90Xa2/
         eLre4gs9T3eHRkhofGMc6nIUp+6nh3QXJPGHQpvxVMOu2DHff/Y32hNGd0RVHbuGMvWU
         Wk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687248860; x=1689840860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQbdggw74AN0qE4N6rw9FwT496orbg2m9a2V0ULV/Uw=;
        b=b3QExnvKmQXXdwmCTD/qoMS+2nHP9Izeplw0YnKeSVJbb0/AQsdGOn9KRNCORENLTh
         ZLAiDgBqZpQ9ya/Ya1EaYlD3TSpEK2HnK9Mbx2/EMtkrsQkGCRJkkqNwT/+dABXsCNBQ
         iz+qbO1n49CxVvP+uTb3/qMmy/yFFDgwWOTEhY8wylCGo3vm+yfLCsfEqrT4avw9F4Gn
         B4hzM8UD2aOVsrUmVCvCGJu3rLmEmCYLrhycq711YmTxYY0xm/+1fvhmk7BC4HMAm1OJ
         2ueCX7AWM/r+d/5d98NQoe/KR88hD6mH3f9EvacW2ur2nYM9xbCSqOrNvcOV9Ty42VGJ
         6B7g==
X-Gm-Message-State: AC+VfDxPiepddSrMTog3Xg0P3NFovmSV1v9eGiu3/9LDCrUt+9aWjxdd
        LeSmmGAIfHZrsGFtb0Rqyt6nQ0JvroaDlWpqqC5kjw==
X-Google-Smtp-Source: ACHHUZ5rqXNURmljNNaXdt2sxgcF4jdXG62ZAho+mTu2bFDoCR6HsKSjbY5W5NzBKLCkQujzUGfPXnfTUJlhfbfEcQ8=
X-Received: by 2002:a05:600c:2252:b0:3f9:14c:11d3 with SMTP id
 a18-20020a05600c225200b003f9014c11d3mr5850732wmm.12.1687248860464; Tue, 20
 Jun 2023 01:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <CAHVXubjOUeEtnFnERjT2YOG+h5=2YX7kxeEBFSStO3WZvcv36A@mail.gmail.com> <ZJFS1K/LltE57MJ4@sunil-laptop>
In-Reply-To: <ZJFS1K/LltE57MJ4@sunil-laptop>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 20 Jun 2023 10:14:09 +0200
Message-ID: <CAHVXubhcStveNOzwA8i0R79P3spR7m1oEbWtBXaVSr2-bL3mvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 9:18=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hey Alex,
>
> Many thanks for writing this up!
>
> On Mon, Jun 19, 2023 at 11:49:13AM +0200, Alexandre Ghiti wrote:
> > @Sunil V L Something about ACPI is more than welcome :)
> >
> > And thanks to @Bj=C3=B6rn T=C3=B6pel and @Atish Kumar Patra for helping=
 in
> > writing this document!
> >
> > On Mon, Jun 19, 2023 at 11:47=E2=80=AFAM Alexandre Ghiti <alexghiti@riv=
osinc.com> wrote:
> > >
> > > This document describes the constraints and requirements of the early
> > > boot process in a RISC-V kernel.
> > >
> > > Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > ---
> > >  Documentation/riscv/boot-image-header.rst |   3 -
> > >  Documentation/riscv/boot.rst              | 181 ++++++++++++++++++++=
++
> > >  Documentation/riscv/index.rst             |   1 +
> > >  3 files changed, 182 insertions(+), 3 deletions(-)
> > >  create mode 100644 Documentation/riscv/boot.rst
> > >
> > > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentatio=
n/riscv/boot-image-header.rst
> > > index d7752533865f..a4a45310c4c4 100644
> > > --- a/Documentation/riscv/boot-image-header.rst
> > > +++ b/Documentation/riscv/boot-image-header.rst
> > > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> > >
> > >  This document only describes the boot image header details for RISC-=
V Linux.
> > >
> > > -TODO:
> > > -  Write a complete booting guide.
> > > -
> > >  The following 64-byte header is present in decompressed Linux kernel=
 image::
> > >
> > >         u32 code0;                /* Executable code */
> > > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boot.=
rst
> > > new file mode 100644
> > > index 000000000000..b02230818b79
> > > --- /dev/null
> > > +++ b/Documentation/riscv/boot.rst
> > > @@ -0,0 +1,181 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +Early boot requirements/constraints on RISC-V
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > +:Date: 23 May 2023
> > > +
> > > +This document describes what the RISC-V kernel expects from the prev=
ious stages
> > > +and the firmware, but also the constraints that any developer must h=
ave in mind
> > > +when touching the early boot process, e.g. before the final virtual =
mapping is
> > > +setup.
> > > +
> > > +Pre-kernel boot (Expectations from firmware)
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Registers state
> > > +---------------
> > > +
> > > +The RISC-V kernel expects:
> > > +
> > > +  * `$a0` to contain the hartid of the current core.
> > > +  * `$a1` to contain the address of the device tree in memory.
> > > +
> > > +CSR state
> > > +---------
> > > +
> > > +The RISC-V kernel expects:
> > > +
> > > +  * `$satp =3D 0`: the MMU must be disabled.
> > > +
> > > +Reserved memory for resident firmware
> > > +-------------------------------------
> > > +
> > > +The RISC-V kernel expects the firmware to mark any resident memory w=
ith the
> > > +`no-map` flag, thus the kernel won't map those regions in the direct=
 mapping
> > > +(avoiding issues with hibernation, speculative accesses and probably=
 other
> > > +subsystems).
> > > +
> > > +Kernel location
> > > +---------------
> > > +
> > > +The RISC-V kernel expects to be placed at a PMD boundary (2MB for rv=
64 and 4MB
> > > +for rv32). Note though that the EFI stub will physically relocate th=
e kernel if
> > > +that's not the case.
> > > +
> > > +Device-tree
> > > +-----------
> > > +
> > > +The RISC-V kernel always expects a device tree, it is:
> > > +
> In general, the firmware can pass either DT or ACPI (not both at the
> same time) to the OS. So, I think the statement that kernel always
> expects DT probably causes confusion. Can we mention some thing like
> below?
>
> The firmware can pass either DeviceTree or ACPI tables to the RISC-V
> kernel.
>
> The DeviceTree is either passed directly to the kernel from the
> previous stage using the `$a1` register, or when booting with UEFI, it
> can be passed using the EFI configuration table.
>
> The ACPI tables are passed to the kernel using the EFI configuration
> table. In this case, a tiny DeviceTree is still created by the EFI
> stub. Please refer to "EFI stub and device" tree section below for
> details of the tiny DeviceTree.
>

Great, this is way better so I'll go with that:

Hardware description
--------------------

The firmware can pass either a devicetree or ACPI tables to the RISC-V kern=
el.

The devicetree is either passed directly to the kernel from the previous st=
age
using the `$a1` register, or when booting with UEFI, it can be passed
using the
EFI configuration table.

The ACPI tables are passed to the kernel using the EFI configuration table.=
 In
this case, a tiny devicetree is still created by the EFI stub. Please refer=
 to
"EFI stub and devicetree" tree section below for details about this devicet=
ree.

Thanks!

> Thanks,
> Sunil
