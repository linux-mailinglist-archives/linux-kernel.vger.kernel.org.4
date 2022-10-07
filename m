Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F85F74A4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJGHVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:21:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64224C0686
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:21:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2BF861B9A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590CDC43140
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665127260;
        bh=UpkSzocUaYLEKCuNB+Me/32VTxEiKSJV4MLW+ktFRJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u2u7E9SYipADwtJrlSgPtCJ8mi9IXguBoEi+cAu5FS2lEN1kIc2L9IpbnWP3pjy9E
         G38XLhZqUPFz/uhkzB0dffEFXO+rBgdMwbkwKJhuicn7GOttG9f+ZbDaTw6lH8YJow
         IgSKU0UkZ/vjeD78GoN7QybBemywMCdGlAA3lU5b7m3KEij+7iH+cHyqPyNxVE8aoA
         sBSXa1dqanB7pkRjWLNyouJQW84l3z8ja873H2hSE8T+MUulD5mX59iXZ149n9Ywgg
         U2agIaQ4qVY7uMhuIjFfbGRhLxv+IXqEpmzptKBW3jL/oA+i/+mC5GsxTKSRATN9dO
         vHXktb0EZtrpw==
Received: by mail-lf1-f54.google.com with SMTP id b2so6036629lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:21:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf3dM+Gl6GqJo08TspRmj16bJ+aEV8+K7cJOrcnnCS1/nvoKF574
        I9aWY1KqRCjknJyNZBPWUDtDADVKfXl6ZjQuBfU=
X-Google-Smtp-Source: AMsMyM6ZRywrundXVSZackOgIx9rqipImdCL0OGGGJiZBo16eeV/Gi48y8KakkvL/qGknMrQCZvdoCue2wCUMt+/a+A=
X-Received: by 2002:a05:6512:104a:b0:4a2:9c7b:c9c with SMTP id
 c10-20020a056512104a00b004a29c7b0c9cmr620582lfb.122.1665127258284; Fri, 07
 Oct 2022 00:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221006230051.185850-1-atishp@rivosinc.com> <20221006230051.185850-3-atishp@rivosinc.com>
 <b1306db2-74c5-c207-7c6d-beba0f1593f4@canonical.com>
In-Reply-To: <b1306db2-74c5-c207-7c6d-beba0f1593f4@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 7 Oct 2022 09:20:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXENi6rGK5tuU5ny5gAXMGLErx3o8ci3stazq0HJO5QArg@mail.gmail.com>
Message-ID: <CAMj1kXENi6rGK5tuU5ny5gAXMGLErx3o8ci3stazq0HJO5QArg@mail.gmail.com>
Subject: Re: [v4 PATCH 2/3] RISC-V: Update image header
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Leif Lindholm <quic_llindhol@quicinc.com>,
        Nikita Ermakov <arei@altlinux.org>,
        Atish Patra <atishp@atishpatra.org>,
        Julian Andres Klode <julian.klode@canonical.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022 at 01:51, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> On 10/7/22 01:00, Atish Patra wrote:
> > Update the RISC-V Linux kernel image headers as per the current header.
> >
> > Reference:
> > <Linux kernel source>/Documentation/riscv/boot-image-header.rst
> >
> > 474efecb65dc: ("riscv: modify the Image header to improve compatibility with the ARM64 header")
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   include/grub/riscv32/linux.h | 15 ++++++++-------
> >   include/grub/riscv64/linux.h | 21 +++++++++++++--------
> >   2 files changed, 21 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/grub/riscv32/linux.h b/include/grub/riscv32/linux.h
> > index 512b777c8a41..de0dbdcd1be5 100644
> > --- a/include/grub/riscv32/linux.h
> > +++ b/include/grub/riscv32/linux.h
> > @@ -19,20 +19,21 @@
> >   #ifndef GRUB_RISCV32_LINUX_HEADER
> >   #define GRUB_RISCV32_LINUX_HEADER 1
> >
> > -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
> > +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
>
> Thanks for following up on this series.
>
> Considering 69edb312056 ("loader/arm64/linux: Remove magic number header
> field check") why should this constant exist in GRUB at all?
>
> In a follow up patch we could remove it together with
> GRUB_LINUX_ARM_MAGIC_SIGNATURE, GRUB_LINUX_ARMXX_MAGIC_SIGNATURE, and
> GRUB_LINUX_ARMXX_MAGIC_SIGNATURE.
>

Indeed.

But by the same reasoning, why do we need per-arch kernel header
typedefs at all?  The only fields we access are generic PE/COFF header
fields.

> >
> > -/* From linux/Documentation/riscv/booting.txt */
> > +/* From linux/Documentation/riscv/boot-image-header.rst */
> >   struct linux_riscv_kernel_header
> >   {
> >     grub_uint32_t code0;              /* Executable code */
> >     grub_uint32_t code1;              /* Executable code */
> > -  grub_uint64_t text_offset; /* Image load offset */
> > -  grub_uint64_t res0;                /* reserved */
> > -  grub_uint64_t res1;                /* reserved */
> > +  grub_uint64_t text_offset; /* Image load offset, little endian */
> > +  grub_uint64_t image_size;  /* Effective Image size, little endian */
> > +  grub_uint64_t flags;               /* kernel flags, little endian */
> > +  grub_uint32_t version;     /* Version of this header */
> > +  grub_uint32_t res1;                /* reserved */
> >     grub_uint64_t res2;               /* reserved */
> >     grub_uint64_t res3;               /* reserved */
>
> According to tag next-20221006 of
> Documentation/riscv/boot-image-header.rst and of
> arch/riscv/include/asm/image.h this field is called 'magic' and filled
> it with the string 'RISCV\0\0\0'.
>
> > -  grub_uint64_t res4;                /* reserved */
> > -  grub_uint32_t magic;               /* Magic number, little endian, "RSCV" */
> > +  grub_uint32_t magic;               /* Magic number, little endian, "RSC\x05" */
>
> The Linux kernel documentation calls this field magic2.
>
> Of course this is functionally irrelevant as we don't care about the
> content of both fields.
>
> >     grub_uint32_t hdr_offset; /* Offset of PE/COFF header */
> >   };
> >
> > diff --git a/include/grub/riscv64/linux.h b/include/grub/riscv64/linux.h
> > index 3630c30fbf1a..ea77f8718222 100644
> > --- a/include/grub/riscv64/linux.h
> > +++ b/include/grub/riscv64/linux.h
> > @@ -19,23 +19,28 @@
> >   #ifndef GRUB_RISCV64_LINUX_HEADER
> >   #define GRUB_RISCV64_LINUX_HEADER 1
> >
> > -#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x52534356 /* 'RSCV' */
> > +#include <grub/efi/pe32.h>
> > +
> > +#define GRUB_LINUX_RISCV_MAGIC_SIGNATURE 0x05435352 /* 'RSC\0x5' */
>
> to be removed in future
>
> Best regards
>
> Heinrich
>
> >
> >   #define GRUB_EFI_PE_MAGIC   0x5A4D
> >
> > -/* From linux/Documentation/riscv/booting.txt */
> > +/* From linux/Documentation/riscv/boot-image-header.rst */
> >   struct linux_riscv_kernel_header
> >   {
> >     grub_uint32_t code0;              /* Executable code */
> >     grub_uint32_t code1;              /* Executable code */
> > -  grub_uint64_t text_offset; /* Image load offset */
> > -  grub_uint64_t res0;                /* reserved */
> > -  grub_uint64_t res1;                /* reserved */
> > +  grub_uint64_t text_offset; /* Image load offset, little endian */
> > +  grub_uint64_t image_size;  /* Effective Image size, little endian */
> > +  grub_uint64_t flags;               /* kernel flags, little endian */
> > +  grub_uint32_t version;     /* Version of this header */
> > +  grub_uint32_t res1;                /* reserved */
> >     grub_uint64_t res2;               /* reserved */
> > -  grub_uint64_t res3;                /* reserved */
> > -  grub_uint64_t res4;                /* reserved */
> > -  grub_uint32_t magic;               /* Magic number, little endian, "RSCV" */
> > +  grub_uint64_t magic;               /* magic (RISC-V specifc, deprecated)*/
> > +  grub_uint32_t magic2;              /* Magic number 2 (to match the ARM64 'magic' field pos) */
> >     grub_uint32_t hdr_offset; /* Offset of PE/COFF header */
> > +
> > +  struct grub_coff_image_header coff_image_header;
> >   };
> >
> >   #define linux_arch_kernel_header linux_riscv_kernel_header
