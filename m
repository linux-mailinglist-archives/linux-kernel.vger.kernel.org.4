Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6726AE6E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCGQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCGQlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:41:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF188C962
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:38:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az36so8207062wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1678207094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZZguwSSEPzBsonH3p0dNEDuIQs3YTv/Y0IWmQeMQCs=;
        b=w0olMT+4m3Hv3vfB4gX7ikHWrlZVvK+YS9ZnUaBoATd+vQDR6vMRTW7k9BrhtgUMGS
         bPXYrHNuK46Qo/YCfUG4jB/Lw5v6izJ0MHyIFjkWDfP2S3VU0Oxz9W31zmSq/72nfFY/
         9YjC26LM5FbeoL8qSoWPEHXLtmeDcQRlWSRhEJNE5f/Q+SSSdNSEOF6NLcjm57/6kmrD
         TbnCvJVTe14mKh1cZNRTD5qJvTIDUQ4CYCr2SCCQbRmhZLvjMX8sFGvhRISaqwfXBa3i
         ITBYw1FoVe5Qs2FTvHcpcNlpIC8UlhtqYe9m4710aWSAXAjQ6dVVWvw0UJvQeF5RCbZ+
         37Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZZguwSSEPzBsonH3p0dNEDuIQs3YTv/Y0IWmQeMQCs=;
        b=j88e9Rx04DqeO+0N4orW0Rab51tT1RIGa9+vvlhLTBWnqOojDg5lcEv7sAs/lmBXwv
         ajkMAV3mHXYHz6kTjQV8OoCUR1QtFBY3u3ROvG4ibSCN5yeUrSPz3xLKjMbu6JX+BnmO
         tQu8yeOwFOTOF5QJoztYzrmpyik3ZGJ/Y+k2ykfoWPy3a5BLHIzzAcyZTIw+tO3rjVRx
         ms0+Mt9kF8X2eKUcZpYCWs1usERszAlNwyndsy4vQE+NOIPhtnO9G4cfKr6cu1iWLQay
         SPc2L3ZRaOPJSNv7acqKoP/HMJoAUC6eTO4mMGHOFjPEvTNLmpSUN4e7ZZsEiwerLAt6
         mDzA==
X-Gm-Message-State: AO0yUKXS9s45qiLmqSNkdfpPOoAPyyErlG+uB2p+VXsDCUERLuUhEFob
        PV2IZHOlr11ZEfMN+G/TJ+k2JLWeVrfOy4o/1BXqZw==
X-Google-Smtp-Source: AK7set+G4B9uony8qATKSxd7z0X+ALRQtArGSoIZNv+Rn+3CjCVlP2RhZxCNT5vQQdYnnkE4L6yRaf8TBKfYpAm+ryk=
X-Received: by 2002:a05:600c:688:b0:3e1:eaca:db25 with SMTP id
 a8-20020a05600c068800b003e1eacadb25mr3251051wmn.6.1678207094028; Tue, 07 Mar
 2023 08:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20230301082552.274331-1-alexghiti@rivosinc.com>
 <CAK9=C2XAOKbyrbOnDP1GzW1VyO-f-V-oEVcp+PhGHeHKFh4C6A@mail.gmail.com>
 <CAHVXubj9sCEuANsVe0N7YRMg8OPx_eALZfy0vERKU9P6QUDM0Q@mail.gmail.com>
 <CAK9=C2XDkgZuaxO1fOWCxyCsGgiD=B_O4DmuAPwEhC65Mck9eA@mail.gmail.com> <CAHVXubg6dgr9dM1-mR+xh6D+5cmistWmo2dJQaZavcWGcCshag@mail.gmail.com>
In-Reply-To: <CAHVXubg6dgr9dM1-mR+xh6D+5cmistWmo2dJQaZavcWGcCshag@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 7 Mar 2023 17:38:02 +0100
Message-ID: <CAHVXubhRtDRwm3AQAio6cUJ5vRxDbLerc0ys7H0dgpzx01iCpQ@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 2:36=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> On Tue, Mar 7, 2023 at 2:19=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> >
> > Hi Alex,
> >
> > On Tue, Mar 7, 2023 at 12:22=E2=80=AFAM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > Hi Anup,
> > >
> > > On Mon, Mar 6, 2023 at 5:33=E2=80=AFPM Anup Patel <apatel@ventanamicr=
o.com> wrote:
> > > >
> > > > On Wed, Mar 1, 2023 at 1:56=E2=80=AFPM Alexandre Ghiti <alexghiti@r=
ivosinc.com> wrote:
> > > > >
> > > > > This patchset intends to improve tlb utilization by using hugepag=
es for
> > > > > the linear mapping.
> > > > >
> > > > > base-commit-tag: v6.2-rc7
> > > > >
> > > > > v6:
> > > > > - quiet LLVM warning by casting phys_ram_base into an unsigned lo=
ng
> > > > >
> > > > > v5:
> > > > > - Fix nommu builds by getting rid of riscv_pfn_base in patch 1, t=
hanks
> > > > >   Conor
> > > > > - Add RB from Andrew
> > > > >
> > > > > v4:
> > > > > - Rebase on top of v6.2-rc3, as noted by Conor
> > > > > - Add Acked-by Rob
> > > > >
> > > > > v3:
> > > > > - Change the comment about initrd_start VA conversion so that it =
fits
> > > > >   ARM64 and RISCV64 (and others in the future if needed), as sugg=
ested
> > > > >   by Rob
> > > > >
> > > > > v2:
> > > > > - Add a comment on why RISCV64 does not need to set initrd_start/=
end that
> > > > >   early in the boot process, as asked by Rob
> > > > >
> > > > > Alexandre Ghiti (2):
> > > > >   riscv: Get rid of riscv_pfn_base variable
> > > > >   riscv: Use PUD/P4D/PGD pages for the linear mapping
> > > >
> > > > I tried this series but it is getting stuck after reaching user spa=
ce.
> > > >
> > > > Does this series require some other dependent patches ?
> > >
> > > No it should not. Let me take a look: what's your config and the base=
 commit?
> >
> > Please try the alexghiti_test branch at:
> > https://github.com/avpatel/linux.git
> >
> > Compile the kernel with defconfig and launch QEMU as follows:
> > qemu-system-riscv64 -M virt -m 1G -nographic -bios
> > opensbi/build/platform/generic/firmware/fw_jump.bin -kernel
> > ./build-riscv64/arch/riscv/boot/Image -append "root=3D/dev/ram rw
> > console=3DttyS0 earlycon" -initrd ./rootfs_riscv64.img
> >
> > In the above command, rootfs_riscv64.img is a busybox based rootfs.
>
> Ok I can reproduce the problem. I'll debug that a bit further but
> increasing memory allows booting to userspace.
>

This is a real bug and that's because I should split the 1G page that
contains the kernel text alias (and anything that we map with stricter
rights) or something similar. I'll get back soon with a fix.

Thanks Anup for the report,

Alex

> >
> > Regards,
> > Anup
> >
> > >
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > >
> > > > >  arch/riscv/include/asm/page.h | 19 +++++++++++++++++--
> > > > >  arch/riscv/mm/init.c          | 28 ++++++++++++++++++----------
> > > > >  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
> > > > >  drivers/of/fdt.c              | 11 ++++++-----
> > > > >  4 files changed, 57 insertions(+), 17 deletions(-)
> > > > >
> > > > > --
> > > > > 2.37.2
> > > > >
