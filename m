Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ADE74B156
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjGGMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjGGMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:55:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAB61FC4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:55:18 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2632336f75fso1337507a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688734517; x=1691326517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5LjusBoPpp+Na83KC/lSjd+Es2Cm+Z+7hD4iFZ8HSiU=;
        b=lSmiQhySRfwbIifdH2DR6H6Lf8xWCX/RxUPbj7xitoJLLEWw6fmbh2sHO6zmfkNnfC
         UD7FGV4vs1Go9NJunBBMWtZvCZLyX4u6iJIamM6MFYY55f3hGk5bLE6VdZ3uSNPMP2Gj
         3LRM8bC9TSjEumyBIcYEfAVVSlwTB/zB2yHTWwnjh5fZLvdjx6WIbrsq/wrBMWyZHbv7
         8AP4bETSi5szhAMZGuNZWMQR60TLXPoMT+kvrjFNA3TnnHXQhFJS0PH59mpbgJ0+xmNi
         HqnS+oPuALusi80TEmr7mzsPRBEuFD+osxEIXaarO3zwmiRfUmE2oRUdNA/NQFHcSOkR
         LEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688734517; x=1691326517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LjusBoPpp+Na83KC/lSjd+Es2Cm+Z+7hD4iFZ8HSiU=;
        b=aSdtPXmrAaTJeFOHe4Hz2w8FH3iCKc4dGoEteXbZ6wCULNybtlWzpbCa0ieg1Fc6yT
         4PEZjyJxGX58Yb9sCjeADqOmfq9esfarInHKnfxJCvywzOb4P3qY4bFfDVyvkutvP0zB
         srA6iRChZAT/cgImw8GGJpPKTgiU8D13n+0cvXc38Y/BPm9snVkIDWJMpafL8wruRnSW
         aSirpnq6+V1IK2XLJkUpLCGhga9K2KZxgJK5bPAPN/QEKZsc4uloNRRN3rYDubNhuFTl
         DSk6nmYgzm66Irx7mbM/CPR//w/aM2h+o61D+XTru62NmJV5waSim22JXBKaDa37roww
         uXOg==
X-Gm-Message-State: ABy/qLYU1rTUVuzaYYPvQ3u57i8DYhLS6JRnU/u8M4dPjbJKaxY6tKPA
        JMBPwljuYgE+4yiYEFsqR2ObQQ==
X-Google-Smtp-Source: APBJJlFw//6vHCtbCuIybNtytvdtmifzufAvqUZ+qDOG2XtWMVV+f49U/qN9muNtPBqbBcr7kNk1og==
X-Received: by 2002:a17:90a:8a88:b0:25b:d4bc:28d4 with SMTP id x8-20020a17090a8a8800b0025bd4bc28d4mr4374131pjn.40.1688734517525;
        Fri, 07 Jul 2023 05:55:17 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.72])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090a8c8500b00263dccf96a3sm1484701pjo.54.2023.07.07.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:55:17 -0700 (PDT)
Date:   Fri, 7 Jul 2023 18:25:06 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     =?utf-8?B?6JGb5aOr5bu6?= <geshijian@bytedance.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        ron minnich <rminnich@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>, cuiyunhui@bytedance.com,
        jrtc27@jrtc27.com, kernel@esmil.dk,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, weidong.wd@bytedance.com,
        Dong Wei <Dong.Wei@arm.com>
Subject: Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from
 FFI
Message-ID: <ZKgLKvBoWKSxzm6r@sunil-laptop>
References: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
 <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
 <CAP6exYKwZG=_47r0jAUFYNL5-P-SS==k6vWdKiMJ9nB0upH5Zw@mail.gmail.com>
 <20230707-attach-conjuror-306d967347ce@wendy>
 <ZKfsSsdiso0W8mW6@sunil-laptop>
 <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN3iYbMhQU5Ng4r6_rQDnLmit1GCmheC5T49rsUP5NgHFEXsHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 08:05:48PM +0800, 葛士建 wrote:
> Hi Sunil,
> 
> From Sunil:
> IMO, if the question is generic like "Is UEFI mandatory for RISC-V?",
> the answer will be solid "no" because we can use DT without UEFI. But if
> you ask whether UEFI is mandatory for ACPI support on RISC-V, then the
> answer will be "yes".
> ---- Why UEFI is mandatory for ACPI support on RISC-V?  As we know, on X86,
> ACPI works well without UEFI. Is there any limitation on RISC-V
> architecture?
Yes, the limitation is RISC-V can not use IA-PC BIOS. Please see
section 5.2.5 and 15 in ACPI spec.

I don't have much to add to Ard's reasons.
https://lore.kernel.org/linux-riscv/CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com/

> BTW, I don't think ACPI was from UEFI, and ACPI works well with coreboot on
> Chromebook as Ron said.
> 
> + Dong Wei for ARM ISA..
> 
> Thanks,
> -Nill
> 
> 
> On Fri, Jul 7, 2023 at 6:43 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> > On Fri, Jul 07, 2023 at 09:38:30AM +0100, Conor Dooley wrote:
> > > Hey,
> > >
> > > I've tried to reformat this a bit, probably gone wrong in the process
> > > somewhere.
> > >
> > > On Thu, Jul 06, 2023 at 02:39:13PM -0700, ron minnich wrote:
> > > > On Thu, Jul 6, 2023 at 8:32 AM Palmer Dabbelt <palmer@dabbelt.com
> > <mailto:palmer@dabbelt.com>> wrote:
> > > > > On Thu, 06 Jul 2023 01:53:47 PDT (-0700), Ard Biesheuvel wrote:
> > > > > > On Thu, 6 Jul 2023 at 04:04, 运辉崔 <cuiyunhui@bytedance.com<mailto:
> > cuiyunhui@bytedance.com>> wrote:
> > > > > >> On Wed, Jul 5, 2023 at 10:17 PM Palmer Dabbelt <
> > palmer@dabbelt.com<mailto:palmer@dabbelt.com>> wrote:
> > > > > >> > On Wed, 05 Jul 2023 04:42:47 PDT (-0700),
> > cuiyunhui@bytedance.com<mailto:cuiyunhui@bytedance.com> wrote:
> > > > > >> > > Here's version 3 of patch series.
> > > > > >> > >
> > > > > >> > > V1: The FFI (FDT FIRMWARE INTERFACE) scheme has reached a
> > > > > >> > > consensus with the Maintainers.
> > > > > >> > > Please refer to:
> > > > > >> > >
> > https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cuiyunhui@bytedance.com/
> > > > > >> >
> > > > > >> > From looking at that thread it seems that the consensus is this
> > is a bad
> > > > > >> > idea?  Sorry if I'm just missing something...
> > > > > >> >
> > > > > >>
> > > > > >> First of all, Coreboot does not support EFI, Ron has expressed,
> > as follows:
> > > > > >> "I am wondering if we can focus on risc-v here, and not drag in
> > ARM,
> > > > > >> b/c the ARM ACPI+UEFI ship has sailed. I had that discussion in
> > 2013
> > > > > >> ;-) and it's clear we don't want to redo it.
> > > > > >> In general, in my world, because of the many problems that come
> > with
> > > > > >> UEFI (security, code quality, performance), we'd like to avoid
> > > > > >> requiring a dependency on UEFI just to get ACPI on RISC-V. It also
> > > > > >> seems, from other discussions I'm having, that there is some
> > belief
> > > > > >> that ACPI will be wanted on RISC-V. It would be nice to separate
> > those
> > > > > >> pieces on RISC-V; certainly they were separate for a very long
> > time in
> > > > > >> the x86 world (we had ACPI+SMM on coreboot laptops without UEFI
> > for
> > > > > >> example)."
> > > > > >>
> > > > > >
> > > > > > There appears to be a bit of cargo cult going on here.
> > > > > >
> > > > > > I agree that the traditional BIOS vendors did a terrible job
> > pivoting
> > > > > > to (U)EFI when it became a requirement for booting Windows on x86
> > PCs,
> > > > > > and coreboot did an excellent job providing a retrofit alternative
> > > > > > that was more secure and robust.
> > > > > >
> > > > > > However, it makes sense to distinguish between
> > > > > > a) the UEFI specification
> > > > > > b) the UEFI reference implementation (edk2)
> > > > > > c) commercial implementations created by BIOS vendors for x86 PC
> > OEMs
> > > > > > that do not perform any testing beyond booting Windows.
> > > > > >
> > > > > > coreboot decided not to implement EFI at all, which on x86 means
> > > > > > booting in a mode that is similar to BIOS boot. Given how the ACPI
> > and
> > > > > > DMTF (for SMBIOS) specifications were already under development
> > when
> > > > > > UEFI was being rolled out on x86, those specs contain provisions
> > > > > > defining how to obtain the ACPI and SMBIOS tables by scanning
> > regions
> > > > > > of memory and looking for magic strings. But this is only defined
> > for
> > > > >
> > > > > In theory we have that in RISC-V as well: on boot we don't actually
> > have
> > > > > a DT pointer, but instead a "config string" pointer.  That's a bit
> > of a
> > > > > retcon from when we were planning on adding our own firmware probing
> > > > > interface, but in order to appear to have never made a mistake we
> > just
> > > > > said that config strings can be anything and have magic numbers to
> > > > > differentiate between the flavors.
> > > > >
> > > > > IIUC we don't take advantage of that in Linux, though, so maybe let's
> > > > > just pretend it doesn't exist?
> > > > >
> > > > > > x86, and only works on x86 because all x86 machines are essentially
> > > > > > PCs with a highly uniform system topology.
> > > > > >
> > > > > > The ARM case is very different, and while I am no expect on RISC-V,
> > > > > > the following probably applies to it as well:
> > > > > > - there is no need to work around buggy proprietary firmware that
> > can
> > > > > > boot Windows but not Linux
> > > > > > - there is no 'prior art' when it comes to pre-EFI boot interfaces
> > > > > > except for embedded style bare metal boot where all initialization
> > is
> > > > > > done by the kernel (e.g., PCI enumeration and resource assignment
> > > > > > etc), and this is fundamentally arch specific
> > > > > > - ACPI is a rich firmware interface, and the ACPI specification
> > layers
> > > > > > it on top of UEFI so the OS can make certain assumptions about the
> > > > > > extent to which the platform has been initialized by the time it
> > hands
> > > > > > over.
> > > > > >
> > > > > > This is why the maintainers of the arm64 and RISC-V ports appear to
> > > > > > agree that ACPI will only be supported when booting from firmware
> > that
> > > > >
> > > > > Yes, we're basically in the same spot as arm64 is here -- or at least
> > > > > we're aiming to be, we've yet to even release a kernel that boots
> > with
> > > > > ACPI so we have no legacy compatibility yet.
> > > > >
> > > > > > implements the EFI specification. Note that this does not impose
> > any
> > > > > > requirement at all regarding which EFI implementation is going to
> > be
> > > > > > used: suggestions have been made on the thread to use a) a coreboot
> > > > > > specific minimal EFI shim that describes the firmware tables and
> > the
> > > > > > EFI memory map, b) the UPL payload for coreboot, and c) U-Boot's
> > EFI
> > > > > > implementation.
> > > > > >
> > > > > > I will also note that booting according to the EFI spec is not
> > > > > > fundamentally  more secure or faster: I have done some experiments
> > on
> > > > > > arm64 comparing bare metal boot with EFI boot using a minimal
> > > > > > implementation in Rust, for booting virtual machines under KVM.
> > Due to
> > > > > > cache maintenance overhead and execution with the MMU disabled,
> > bare
> > > > > > metal boot is actually slightly slower. And due to the fact that
> > the
> > > > > > minimal EFI firmware enables the MMU and caches straight out of
> > reset,
> > > > > > it is also arguably more secure, given that all memory permission
> > > > > > based protections and other page table based hardening measures
> > (e.g.,
> > > > > > BTI) are always enabled.
> > > > > >
> > > > > > In summary, I think it may be time to stop extrapolating from bad
> > > > > > experiences with buggy proprietary x86 PC firmware created by
> > > > > > traditional BIOS vendors for booting Windows (and nothing else) 15+
> > > > > > years ago. The situation is very different for non-x86 Linux
> > > > > > architectures, where we are trying hard to beat some sense into the
> > > > > > fragmented embedded ecosystem, where every SoC vendor used to have
> > its
> > > > > > own fork of u-boot that booted in a slightly different manner,
> > > > > > requiring a lot of effort on the part of the distros to track all
> > > > > > those moving targets.
> > > > >
> > > > > That's roughly where we're trying to go in RISC-V land, at least for
> > > > > most software people.  Everyone gets their own ISA, which obviously
> > > > > causes a ton of fragmentation, but not really anything we can do
> > about
> > > > > that.  At least we can avoid adding additional sources of
> > fragmentation
> > > > > from the software side of things, though.
> > > > >
> > > > > >> Then, a consensus was reached with Ard, that FFI can be applied
> > to RISC-V.
> > > > > >>
> > > > > >
> > > > > > For the record, I would not characterize this as consensus. What I
> > said was
> > > > > > - SMBIOS has very little significance to the kernel itself or
> > impact
> > > > > > on its internal operation, and so it can be exposed via DT in a
> > > > > > generic manner;
> > > > > > - ACPI without UEFI on non-x86 is a) a bad idea, and b)
> > fundamentally
> > > > > > broken on arm64. So b) is out of the question, but it is not up to
> > me
> > > > > > to decide whether or not the RISC-V maintainers should entertain
> > bad
> > > > > > ideas.
> > > > >
> > > > > IMO we have enough bad ideas in RISC-V already and thus should avoid
> > > > > adding more.
> > >
> > > > ACPI was not originally part of UEFI. ACPI works just fine on
> > > > Chromebooks, and has for 12 years, and on coreboot since 2006,
> > > > without UEFI. I've integrated support for ACPI into several
> > > > code bases, including Plan 9 on non-UEFI systems.
> > > >
> >
> > As per the section  5.2.5 of ACPI spec [1], there are only two ways
> > defined to locate the RSDP. IA-PC is not applicable to RISC-V and only
> > other method defined is via UEFI.
> >
> > [1] -
> > https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#root-system-description-pointer-rsdp
> >
> > > > I am unable to understand the claim that ACPI on non-UEFI
> > > > RISC-V is a bad idea. Clearly, I am not alone.
> > > >
> > > > But, all that said, I get the impression that the gatekeepers
> > > > are absolutely immovable on this question?
> > >
> > > > Perhaps the right way
> > > > to move forward is to find a way to extract what we need from ACPI
> > > > and move forward on systems that can function without UEFI AND ACPI?
> > > > Would that be preferable?
> > >
> > > Isn't this exactly the type of thing that has been proposed by this
> > > series, that everyone seems to be against? Or are you suggesting that we
> > > would, on a DT system, read some ACPI information, and then revert to
> > > being DT based?
> > >
> > > > Just so we're all on the same page, I just now asked Mark Himelstein
> > > > of RISC-V International if there is anything in RISC-V standards that
> > > > requires UEFI, and the answer is a solid "no."
> > >
> > > Huh? Firstly, running off to invoke RVI is not productive - they don't
> > > maintain the various operating system kernels etc.
> > > Secondly, that does not seem to be true. The platform spec mandates UEFI
> > > for the OS-A server platform, alongside ACPI:
> > >
> > https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-spec.adoc#32-boot-process
> > > and the OS-A embedded platform needs to comply with EBBR & use DT:
> > >
> > https://github.com/riscv/riscv-platform-specs/blob/main/riscv-platform-spec.adoc#32-boot-process
> > >
> > > EBBR does say that systems must not provide both ACPI and DT to the OS
> > > loader, but I am far from an expert on these kind of things & am not
> > > sure where something like this where the DT "contains" ACPI would stand.
> > >
> > > The RISC-V ACPI spec also says "UEFI firmware is mandatory to support
> > > ACPI":
> > >
> > https://github.com/riscv-non-isa/riscv-acpi/blob/master/riscv-acpi-guidance.adoc
> > >
> > > Jess, Sunil or Ard on the EBBR front perhaps, please correct me here if I
> > > have got anything wrong.
> > >
> > IMO, if the question is generic like "Is UEFI mandatory for RISC-V?",
> > the answer will be solid "no" because we can use DT without UEFI. But if
> > you ask whether UEFI is mandatory for ACPI support on RISC-V, then the
> > answer will be "yes".
> >
> > Thanks,
> > Sunil
> >
