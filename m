Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114DA736608
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjFTIZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFTIZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:25:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B30DB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:25:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-312826ffedbso156238f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687249500; x=1689841500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3evY5tN6qzgdFsrfqIXUpcoFzb3IStfjYrKcL0qrqdw=;
        b=ivDz+WrTZTztk9Hn4W1CcvPZJxZcZTemxrC0UQ4ymMFfLVisimBS1DynRpr6KUAf16
         jXCuYD5cPRMP6uUm+RTj13Y4/o0xrIvbbhdD7Slt+29ye7bhoAQddcyuCP8qSzbQZQUH
         kUN+xh63LiHxrPky7aPHYHS7QsRdqwTNiSy83IvPf8rM7kIKcJoYoSRM3A7YeWclugKw
         bMRy8aHUjM/vl7b9enIR/T+jMNdH6Oc+UzYaRjl8+b2YS1Yd6WUMMHB5HQl0FloC1Y20
         5MJ3ldMawWHeBXZkwL5d3ZzEqNPebSpDLkXO3Whm2hbZjmwieYGXGuDCcm6U0DKW6C1D
         MFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687249500; x=1689841500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3evY5tN6qzgdFsrfqIXUpcoFzb3IStfjYrKcL0qrqdw=;
        b=SX4F2g6p1INE38T86t2k+mwSAgVpkEZw2rB/RJf8qUdgmu7O/Uc21uRbv5BtXtIoc9
         QMIG15DdiupTTVbWCa5o/rWTWnRjzNPTm94yfg/BE9F5zuOC0SUxqMp4fCKF2jqdB7Ma
         NNq3gkOzc73CmI/33zFJXUJi5gchfbyR0AZsZOT3iEhPrAWsUU97lGXjkd/qXczXpajA
         GyQYVB0Cc0C3oUi2VnPHmeVJYOmbahp2uG68m8xz+5gJ9GkSfgxf1G/0YfAboIAFABew
         +GzYwFDUOgS07N8Vu0RHVZGqZHNxwdSGU0wQ3a+SR5dGd4fXLCSr2vBXPaE+sb+McxDR
         mz5A==
X-Gm-Message-State: AC+VfDyoxBqQjLtlZLMb+35Mjaed5PVEiw0xTbKxcaT8vN4fKH1g9uss
        q7zgmgrn5QnBF3QwaOFKR4TyewBEk9MO8so1DvdgZQ==
X-Google-Smtp-Source: ACHHUZ6fEAAE+PddtHZkYCJKGXLQzqQWugmbMrdnZ+rUOZ3Xiut5GzkNY1WIVBRLi221yjqaYsWvNhTixpIWiEMgsDE=
X-Received: by 2002:adf:df0b:0:b0:311:1009:10c9 with SMTP id
 y11-20020adfdf0b000000b00311100910c9mr9231916wrl.5.1687249500404; Tue, 20 Jun
 2023 01:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <20230619-kerchief-unmixed-cfdbeb1cf242@wendy> <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
 <ZJFYE+Ss/OgMIjda@sunil-laptop>
In-Reply-To: <ZJFYE+Ss/OgMIjda@sunil-laptop>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 20 Jun 2023 10:24:49 +0200
Message-ID: <CAHVXubjNHS1goZx=hiAC0Y5n2Ox_-6=+9wb+qphgn_AV0+hAHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 20, 2023 at 9:41=E2=80=AFAM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Mon, Jun 19, 2023 at 04:04:52PM +0200, Alexandre Ghiti wrote:
> > On Mon, Jun 19, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > Hey Alex,
> > >
> > > Thanks for working on this :) I've got a mix of suggestions and
> > > questions below. Hopefully it is not too disjoint, since I didn't wri=
te
> > > them in order.
> > >
> > > On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:
> > > > This document describes the constraints and requirements of the ear=
ly
> > > > boot process in a RISC-V kernel.
> > > >
> > > > Szigned-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > ---
> > > >  Documentation/riscv/boot-image-header.rst |   3 -
> > > >  Documentation/riscv/boot.rst              | 181 ++++++++++++++++++=
++++
> > > >  Documentation/riscv/index.rst             |   1 +
> > > >  3 files changed, 182 insertions(+), 3 deletions(-)
> > > >  create mode 100644 Documentation/riscv/boot.rst
> > > >
> > > > diff --git a/Documentation/riscv/boot-image-header.rst b/Documentat=
ion/riscv/boot-image-header.rst
> > > > index d7752533865f..a4a45310c4c4 100644
> > > > --- a/Documentation/riscv/boot-image-header.rst
> > > > +++ b/Documentation/riscv/boot-image-header.rst
> > > > @@ -7,9 +7,6 @@ Boot image header in RISC-V Linux
> > > >
> > > >  This document only describes the boot image header details for RIS=
C-V Linux.
> > > >
> > > > -TODO:
> > > > -  Write a complete booting guide.
> > > > -
> > > >  The following 64-byte header is present in decompressed Linux kern=
el image::
> > > >
> > > >       u32 code0;                /* Executable code */
> > > > diff --git a/Documentation/riscv/boot.rst b/Documentation/riscv/boo=
t.rst
> > > > new file mode 100644
> > > > index 000000000000..b02230818b79
> > > > --- /dev/null
> > > > +++ b/Documentation/riscv/boot.rst
> > > > @@ -0,0 +1,181 @@
> > > > +.. SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > +Early boot requirements/constraints on RISC-V
> > > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Please use "title case", here and elsewhere in the doc.
> >
> > You mean using "title: " instead of "=3D=3D=3D=3D"? Or using uppercase =
for the
> > first letter of each word? FYI I followed
> > https://docs.kernel.org/doc-guide/sphinx.html?highlight=3Dtitle#specifi=
c-guidelines-for-the-kernel-documentation
> >
> > > I'd also be inclined to drop the "Early" from here, as it permits mor=
e
> > > natural section headings. Perhaps "RISC-V Kernel Boot Requirements an=
d
> > > Constraints"?
> >
> > Good suggestion, I'll go with that, thanks
> >
> > >
> > > > +
> > > > +:Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > +:Date: 23 May 2023
> > > > +
> > > > +This document describes what the RISC-V kernel expects from the pr=
evious stages
> > >
> > > "the previous stages" is a bit vague IMO. You mean bootloader stages =
I
> > > assume, but I think it should be explicit. Perhaps:
> > > "...what a RISC-V kernel expects from bootloaders and firmware, and t=
he
> > > constraints..."
> > >
> > > > +and the firmware, but also the constraints that any developer must=
 have in mind
> > > > +when touching the early boot process, e.g. before the final virtua=
l mapping is
> > > > +setup.
> > >
> > > s/setup./set up./
> > >
> > > Do you mean to have "For example" here? Or is "before the final virtu=
al
> > > mapping is set up" the definition or "early boot"? If the latter, I
> > > would reword this as something like:
> > > "...when modifying the early boot process. For the purposes of this
> > > document, the 'early boot process' refers to any code that runs befor=
e
> > > the final virtual mapping is set up."
> >
> > Thanks, that's what I meant.
> >
> > >
> > > > +Pre-kernel boot (Expectations from firmware)
> > >
> > > Firmware or bootloaders? TBH, I would just drop the section in () and
> > > do something like:
> > >         Pre-kernel Requirements and Constraints
> > >         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >         The RISC-V kernel expects the following of bootloaders and pl=
atform
> > >         firmware:
> > >
> >
> > Ok
> >
> > > > +
> > > > +Registers state
> > >
> > > s/Registers state/Register State/
> >
> > Ok
> >
> > >
> > > > +---------------
> > > > +
> > > > +The RISC-V kernel expects:
> > > > +
> > > > +  * `$a0` to contain the hartid of the current core.
> > > > +  * `$a1` to contain the address of the device tree in memory.
> > > > +
> > > > +CSR state
> > > > +---------
> > > > +
> > > > +The RISC-V kernel expects:
> > > > +
> > > > +  * `$satp =3D 0`: the MMU must be disabled.
> > >
> > > "the MMU, if present, must be disabled." ;)
> >
> > Ahah forgot the !mmu case, thanks :)
> >
> > >
> > > > +
> > > > +Reserved memory for resident firmware
> > > > +-------------------------------------
> > > > +
> > > > +The RISC-V kernel expects the firmware to mark any resident memory=
 with the
> > >
> > > Should this be
> > > "...resident memory, or memory it has protected with PMPs, with..."
> > > ?
> >
> > I used "resident" memory instead of "PMP" memory because it was more
> > general. I mean you can have a region that is resident but not
> > protected by PMP, and I don't think the kernel should ask for this
> > resident memory to be protected with PMP right?
> >
> > >
> > > > +`no-map` flag, thus the kernel won't map those regions in the dire=
ct mapping
> > >
> > > "no-map" is a DT specific term, should this section be moved down und=
er
> > > DT, as a sub-section of that?
> >
> > Maybe I can rephrase with something like that:
> >
> > "The RISC-V kernel must not map any resident memory in the direct
> > mapping, so the firmware must correctly mark those regions as follows:
> > - when using a devicetree, using the `no-map` flag,
> > - when booting with UEFI without devicetree, either as
> > `EfiRuntimeServicesData/Code` or `EfiReserved`."
> >
> Hi Alex,
>
> I am not sure about the idea behind mentioning only UEFI boot without
> DT since UEFI boot is supported with DT also. Should we just mention
> that "when booting with UEFI, resident firmware ranges must be marked as
> per UEFI specification" ? Converting reserved-memory node in DT to UEFI
> memory map is anyway mentioned separately under UEFI memory map section
> right?

Right, let's make it simple:

"The RISC-V kernel must not map any resident memory in the direct
mapping, so the
firmware must correctly mark those regions as per the devicetree
specification and/or the UEFI specification."

Feel free to comment if that's still not right to you,

Thanks,

>
> Thanks,
> Sunil
