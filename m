Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8570B63509C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiKWGmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiKWGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:42:01 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403E1F393C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:42:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy37so699473ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=liUn5kCS+BaH76kq3rkKYwerpbNTbhF/Gnj/cNLlbFE=;
        b=HygyPMSGiHV+ec7FeK08Tiyc5HNvgKltqYxVxBdBXw+/9NYR4YFv1y0WziGsYPXjY9
         5Du/UKrNapjsuCF1fbiZ00+nBOXShm6rz6GWTALF7sm3X+TcR+FMH1CcBA1PCtrkUnKN
         wgT4zbmj69ftd7LAi9jKt/9pvStH0SRtTapJQ0SOkFYR/FGi4IiHTIGix0+FU6vOVlfS
         S8rLxe3oWhuuPUG4GEtr7VAhncC53wUrYNRACTRv2Ei3b0mYztktR16duSLG25Cf1sPd
         KYpcPg+JBoD/VzOpcoWawPJg2oshe8PC0ba9Xg4+iqvdLDaBJqgBnpUJdWJocL11aLha
         SaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liUn5kCS+BaH76kq3rkKYwerpbNTbhF/Gnj/cNLlbFE=;
        b=GiQcTOjIgvw884/R8QhmOXI3q4h5R8AZbAC6fR7VpqGXuoD0eZYfmGnXnsqAqMbxwQ
         HLSGkjgf0aHQk6MkDZrqxkfi/MzxrXrMkl0YdWy+VqFb6OAYUR2oCv2KUzAkP/9yKno5
         pyIwKX+AjvnHYQJEkaM+FK0yd0Ktbx++WZU2wHE5ADYv/bZljef94tiKsBrGg2FWz41a
         PV/kwNXd1CjTzxQSBSIFDlaVdTiAU6C80tXoDdQ09kIgpWT+RcMlUA5q/WDAY93FuLaF
         SL1pZZDZM8f4vXXXosjM4bEQROP5uZiQ65ft+c1SWoZBxCLncxd62xeFm8ezvmBuiL9h
         5TJQ==
X-Gm-Message-State: ANoB5pm8EHGjcAmq3O/JPJE/hZo0B9PxMIpy78AKu+McVwYw8YwV7bEo
        uczM1oQ8jQsqLMv307vZXIJsrKWG1sqUCtt0p24e7Q==
X-Google-Smtp-Source: AA0mqf58ZmYnZKvRAKgj7maFI2o/QWAepTicr42JnhFBnn2D+s4o4DxIgVSmu2ucUIWpU0EOVHObvSItkN1N3QeHs0A=
X-Received: by 2002:a17:906:b250:b0:7b2:86d5:8b14 with SMTP id
 ce16-20020a170906b25000b007b286d58b14mr22977681ejb.230.1669185718709; Tue, 22
 Nov 2022 22:41:58 -0800 (PST)
MIME-Version: 1.0
References: <mhng-6299f108-11af-4e70-9981-d7e7b3be0b9a@palmer-ri-x1c9>
 <57114829-c205-dece-abdb-1100947286d4@sholland.org> <CAK9=C2WLOa_zgboFE5UCgnwMB-kbWMAVtmXsBxoswqY63-5QHw@mail.gmail.com>
 <a591599e-d133-e19a-4898-5645c3862daa@sholland.org> <CAAhSdy2VdX9VivbuRhjN0cPXTi=nFWdiPwFs+hUv6iMqZu-q5g@mail.gmail.com>
 <4e9a46e2-eaa2-04cb-8b95-2fe9a091a96d@sholland.org>
In-Reply-To: <4e9a46e2-eaa2-04cb-8b95-2fe9a091a96d@sholland.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 23 Nov 2022 12:11:47 +0530
Message-ID: <CAAhSdy22jRmeMqAfJKtubo4wuOs29uax6uucz54RmoiySff7Nw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
To:     Samuel Holland <samuel@sholland.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        conor.dooley@microchip.com, Conor Dooley <conor@kernel.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:57 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 11/23/22 00:10, Anup Patel wrote:
> > On Wed, Nov 23, 2022 at 11:08 AM Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> Hi Anup,
> >>
> >> On 11/22/22 23:35, Anup Patel wrote:
> >>> On Wed, Nov 23, 2022 at 10:41 AM Samuel Holland <samuel@sholland.org> wrote:
> >>>> On 11/22/22 09:28, Palmer Dabbelt wrote:
> >>>>> I also think we should stop entering non-retentive suspend until we can
> >>>>> sort out how reliably wake up from it, as the SBI makes that a
> >>>>> platform-specific detail.  If the answer there is "non-retentive suspend
> >>>>> is fine on the D1 as long as we don't use the SBI timers" then that
> >>>>> seems fine, we just need some way to describe that in Linux -- that
> >>>>> doesn't fix other platforms and other interrupts, but at least it's a
> >>>>> start.
> >>>>
> >>>> We need some way to describe the situation from the SBI implementation
> >>>> to Linux.
> >>>>
> >>>> Non-retentive suspend is fine on the D1 as long as either one of these
> >>>> conditions is met:
> >>>>  1) we don't use the SBI timers, or
> >>>>  2) the SBI timer implementation does not use the CLINT
> >>>>
> >>>> And it is up to the SBI implementation which timer hardware it uses, so
> >>>> the SBI implementation needs to patch this information in to the DT at
> >>>> runtime.
> >>>
> >>> Rather than SBI implementation patching information in DT, it is much
> >>> simpler to add a quirk in RISC-V timer driver for D1 platform (i.e. based
> >>> on D1 compatible string in root node).
> >>
> >> It would be simpler, but it would be wrong, as I just explained.
> >>
> >> Only the SBI implementation knows if the SBI timer extension can wake
> >> any given CPU from any given non-retentive suspend state.
> >
> > The SBI implementation would derive this information from platform
> > compatible string which is already available to the Linux kernel so
> > why does SBI implementation have to patch the DTB and put the
> > same information in a different way ?
>
> It is not the same information. The SBI implementation also chooses, at
> runtime, which timer hardware (CLINT, platform-specific MMIO timer,
> etc.) is used to implement the SBI timer extension. The value of the
> sbi-timer-can-wake-cpu property depends on this choice.
>
> Using D1 as an example, there are two MMIO timer peripherals ("sun4i"
> TIMER and "sun5i" HSTIMER) where the sbi-timer-can-wake-cpu property
> should be set. But the property should not be set if the CLINT is used
> by SBI.
>
> It would be perfectly reasonable for the SBI implementation to claim one
> of the wakeup-capable MMIO timers for itself, mark it as "reserved" in
> the DT passed to Linux, and thus force Linux to use the SBI timer or a
> native CLINT driver (C906 CLINT has S-mode extensions). Then the SBI
> timer _would_ be capable of waking the CPU from non-retentive suspend.

Fair enough but the DT property should not be SBI specific because same
situation can happen with Sstc as well where a particular non-retentive state
does not preserve the state of stimecmp CSRs in the HARTs.

Better to keep the DT property name as "riscv,timer-can-wake-cpu".

Regards,
Anup
