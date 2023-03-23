Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A596C5D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCWDlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCWDlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:41:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684F35A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:41:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id le6so21111122plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679542866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yoyT5WlWMHPRnswjhmL4+i1o/+q9y1wOVS+eAYJgyU8=;
        b=iG23NtLktGlCuK8yLrt2HgdI2u9Xjrn1xIHRMMQ3pBMV1xVKNHeNmgZxutv9V593Kh
         BcqktDsp/tktwDAfdnh9Lt32isrrQCH1uKy6X2AtUa6g11DsaHb0nrSrhphqQqfr/EAZ
         BD7TgkX9/OdcfUKsCCV1+bNNIFnRBXts4MDszZdP8Mfj/h4qB1jB97D9f5f6zS6Pato1
         /ptfVhFtBq4viZfKfa7ULtZKK1LSNrmzL+nzXB4MYMm9i3Z++7wQ6f4ubqg8ihpk+sk5
         TaR4/zWVHzJ1KB2MQL+f5UPnE2DFWBX1qoKi1ZvxKuh38OjWbwHS/zx8OwemuEGtO/qy
         LU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679542866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoyT5WlWMHPRnswjhmL4+i1o/+q9y1wOVS+eAYJgyU8=;
        b=rRqwEbuZapQBD9QLoBzUKQVygcVgCqEIIFLydeBUXMtsS6iGaWjJVtOoslkVK35n0v
         ULddSLSmW0oNcC/Kdx2N5TxEvvQF45S3J72z4ctBlsuGYgypURI4yD/KG6XHH8n17KyJ
         rbkVrudaHGvdBKCRRtvAfNicdRyyFXGTzt7B9V57MNHEdR45SHU3qCIyuNEE5dGGXxWv
         LFBibrUp70plZso3Vti+Da2S4nJKuchgdrbyBbLtWAKZC75eTdxkWrCAifASSPRcYJnG
         tdkcNKvjEmGtYG82Gyi8guu706G24a1VULXheI1vtQlWCcRV4jS4OnLi7H+T6X7o9+ek
         +r8g==
X-Gm-Message-State: AO0yUKWiWcimd/M2VFnw2o5BKloDjZsy0/LcCht9EfPRrimGegpzB4wH
        /PwB1EdyWbcJkRF2oXueYA==
X-Google-Smtp-Source: AK7set+QUfnUhnpJEqKH7UfWBlBlehf/TeZPU8cuBJxgygXSi8hJBqupZKgwu+4OSJFCj0Tc/ZBVww==
X-Received: by 2002:a17:90b:3b4f:b0:23f:86c2:54e2 with SMTP id ot15-20020a17090b3b4f00b0023f86c254e2mr6077157pjb.16.1679542866516;
        Wed, 22 Mar 2023 20:41:06 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id fu2-20020a17090ad18200b002376d85844dsm254024pjb.51.2023.03.22.20.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 20:41:05 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:40:58 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kexec@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/6] arm64: make kexec_file able to load zboot image
Message-ID: <ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com>
References: <20230306030305.15595-1-kernelfans@gmail.com>
 <CAMj1kXGmjVvNXk6QJON_Tb+ya6WAm6GrHm6=GD0K23rm+7uDNA@mail.gmail.com>
 <ZAbxF+4ekAfSmoUE@piliu.users.ipa.redhat.com>
 <ZAqvTyv3C+Hvl9cR@piliu.users.ipa.redhat.com>
 <CALu+AoS86mKmeeTxSQyaA70=-5bCC3g3iO4i=A6HTZ-ewdHh=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoS86mKmeeTxSQyaA70=-5bCC3g3iO4i=A6HTZ-ewdHh=w@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Thanks for your suggestion. Please see the comment inlined.

On Wed, Mar 22, 2023 at 11:44:52AM +0800, Dave Young wrote:
> On Fri, 10 Mar 2023 at 12:18, Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > On Tue, Mar 07, 2023 at 04:08:55PM +0800, Pingfan Liu wrote:
> > > Hi Ard,
> > >
> > > Thanks for sharing your idea. Please see the comment.
> > >
> > > On Mon, Mar 06, 2023 at 09:08:03AM +0100, Ard Biesheuvel wrote:
> > > > (cc Mark)
> > > >
> > > > Hello Pingfan,
> > > >
> > > > Thanks for working on this.
> > > >
> > > > On Mon, 6 Mar 2023 at 04:03, Pingfan Liu <kernelfans@gmail.com> wrote:
> > > > >
> > > > > After introducing zboot image, kexec_file can not load and jump to the
> > > > > new style image. Hence it demands a method to load the new kernel.
> > > > >
> > > > > The crux of the problem lies in when and how to decompress the Image.gz.
> > > > > There are three possible courses to take: -1. in user space, but hard to
> > > > > achieve due to the signature verification inside the kernel.
> > > >
> > > > That depends. The EFI zboot image encapsulates another PE/COFF image,
> > > > which could be signed as well.
> > > >
> > > > So there are at least three other options here:
> > > > - sign the encapsulated image with the same key as the zboot image
> > > > - sign the encapsulated image with a key that is only valid for kexec boot
> > > > - sign the encapsulated image with an ephemeral key that is only valid
> > > > for a kexec'ing an image that was produced by the same kernel build
> > > >
> > > > >  -2. at the
> > > > > boot time, let the efi_zboot_entry() handles it, which means a simulated
> > > > > EFI service should be provided to that entry, especially about how to be
> > > > > aware of the memory layout.
> > > >
> > > > This is actually an idea I intend to explore: with the EFI runtime
> > > > services regions mapped 1:1, it wouldn't be too hard to implement a
> > > > minimal environment that can run the zboot image under the previous
> > >
> > > The idea of the minimal environment lools amazing. After digging
> > > more deeply into it, I think it means to implement most of the function
> > > members in efi_boot_services, besides that, some UEFI protocols due to
> > > the reference of efi_call_proto(). So a clear boundary between zboot and
> > > its dependent EFI service is demanded before the work.
> > >
> >
> > Looking deeper into it. This approach may be splitted into the following
> > chunks:
> > -1. Estimation the memory demanded by the decompression of zboot, which
> > roughly includes the size of Image, the size of the emulated service and
> > the stack used by zboot. Finally we need a kexec_add_buffer() for this
> > range.
> >
> > -2. The emulated EFI services and some initial data such as the physical
> > address of dtb, the usable memory start address and size should be set
> > by kexec_purgatory_get_set_symbol()
> >
> > -3. Set up an identity mapping of the usable memory by zboot, prepare
> > stack and turn on MMU at the last point just before 'br efi_zboot_entry'
> > in relocate_kernel.S, which means relocate_kernel.S should support two
> > kinds of payload.
> >
> > -4. For efi_zboot_entry(), if jumping from kexec, limit its requirement
> > to only a few boot services: e.g. allocate_pages, allocate_pool. So the
> > emulated services can be deduced.
> 
> Hi Pingfan,
> 
> I'm not sure how hard it will be although Ard thinks it could be
> doable.  If it is not easy I suspect it is not worth the effort.
> 

Yes, it is a little hard comparing to the original patch. But I am also
trying in that direction.

> For your current series,  my suggestion is you can try to move the
> major code in the generic code path in kernel/kexec_file.c and keep
> the arch code minimum so that in the future other arches can avoid
> redundant code.
> 

OK. I will do it.

> Otherwise a fallback solution could be using the same key to sign both
> the zboot image and the internal kernel image like below:
> 1. sign the kernel with the same key twice (kernel image and zboot
> image) in distro kernel
> 2. introduce a kconfig in mainline to sign the kernel image with an
> ephemeral key same to kernel modules.  Distro can disable the config
> option. (in this way kexec can only load the same kernel, it is not
> useful if people want to load older/newer kernels)
> 3. patch kexec-tools to decompress the zboot image and load the kernel image
> 

Yes, this is also a doable way. I will try it if more votes for it.

Thanks,

	Pingfan
> >
> > > > kernel up to the point where it call ExitBootServices(), after which
> > > > kexec() would take over.
> > > >
> > >
> > > IIUC, after kexec switches to efi_zboot_entry(), it will not return,
> > > right?
> > >
> >
> > I have this assumption because letting the control path switch between
> > kernel and non-kernel code is not a good idea.
> >
> >
> > Thanks,
> >
> > Pingfan
> >
> > > > >  -3. in kernel space, during the file load
> > > > > of the zboot image. At that point, the kernel masters the whole memory
> > > > > information, and easily allocates a suitable memory for the decompressed
> > > > > kernel image. (I think this is similar to what grub does today).
> > > > >
> > > >
> > > > GRUB just calls LoadImage(), and the decompression code runs in the EFI context.
> > > >
> > >
> > > Ah, thanks for the correcting. I had made an wrong assumption of grub
> > > based on [1], from which, I thought that grub is the case "For
> > > compatibility with non-EFI loaders, the payload can be decompressed and
> > > executed by the loader as well, provided that the loader implements the
> > > decompression algorithm and that non-EFI boot is supported by the
> > > encapsulated image"
> > >
> > >
> > > [1]: https://www.phoronix.com/news/Linux-6.1-Generic-EFI-Zboot
> > >
> > >
> > > Eager to find a solution to kexec a zboot image. Hope it will come soon.
> > >
> > >
> > > Thanks,
> > >
> > >       Pingfan
> > > > > The core of this series is [5/6].  [3,6/6] handles the config option.
> > > > > The assumption of [3/6] is kexec_file_load is independent of zboot,
> > > > > especially it can load kernel images compressed with different
> > > > > compression method.  [6/6] is if EFI_ZBOOT, the corresponding
> > > > > decompression method should be included.
> > > > >
> > > > >
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > > > Cc: kexec@lists.infradead.org
> > > > > To: linux-arm-kernel@lists.infradead.org
> > > > > To: linux-kernel@vger.kernel.org
> > > > >
> > > > > Pingfan Liu (6):
> > > > >   arm64: kexec: Rename kexec_image.c to kexec_raw_image.c
> > > > >   lib/decompress: Introduce decompress_method_by_name()
> > > > >   arm64: Kconfig: Pick decompressing method for kexec file load
> > > > >   lib/decompress: Keep decompress routines based on selection
> > > > >   arm64: kexec: Introduce zboot image loader
> > > > >   init/Kconfig: Select decompressing method if compressing kernel
> > > > >
> > > > >  arch/arm64/Kconfig                            |  59 ++++++
> > > > >  arch/arm64/include/asm/kexec.h                |   4 +-
> > > > >  arch/arm64/kernel/Makefile                    |   2 +-
> > > > >  .../{kexec_image.c => kexec_raw_image.c}      |   2 +-
> > > > >  arch/arm64/kernel/kexec_zboot_image.c         | 186 ++++++++++++++++++
> > > > >  arch/arm64/kernel/machine_kexec.c             |   1 +
> > > > >  arch/arm64/kernel/machine_kexec_file.c        |   3 +-
> > > > >  include/linux/decompress/generic.h            |   2 +
> > > > >  include/linux/decompress/mm.h                 |   9 +-
> > > > >  include/linux/zboot.h                         |  26 +++
> > > > >  init/Kconfig                                  |   7 +
> > > > >  lib/Kconfig                                   |   3 +
> > > > >  lib/decompress.c                              |  17 +-
> > > > >  13 files changed, 314 insertions(+), 7 deletions(-)
> > > > >  rename arch/arm64/kernel/{kexec_image.c => kexec_raw_image.c} (98%)
> > > > >  create mode 100644 arch/arm64/kernel/kexec_zboot_image.c
> > > > >  create mode 100644 include/linux/zboot.h
> > > > >
> > > > > --
> > > > > 2.31.1
> > > > >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> >
> 
