Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6EF6F1B05
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346199AbjD1O5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjD1O52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 10:57:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55710268D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:57:26 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b87d23729so76227b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682693846; x=1685285846;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFDQCFyXA+k+c8Gn9qzR9lLCIqZgemO1CqJ4E7mFh7w=;
        b=W+rOfp6EuIHcbIESxSPM6bkKWaRSLxE5DeLwpWop5woNlgZ7IBEcStVlNWbcKela5L
         4NOXjrwPaYf1Z2H5RrBgPqor7UttkCuHxJ6E1/9+N0mOjVYeGE7ngPm2tR4792BXSXol
         O2ytwpGQyUj1th98Ua7au5/+SFBOdPO8QqFXTQrpLUj6DYHa0+hP4i1+84L2R1W4uCXp
         wvZ588eR2zS/kJ7SVIJxeI2FFPwvj8BKA7Ney7xJkf/uDfKgOHYCw56zPwyiWmE4rLP2
         Y1qaIXXSfvJJmVU3Q246ajEOLNx/qs5Tz3NzLvWmAQ0PS78Wh8604JE4Bh42+59FMPRw
         tmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682693846; x=1685285846;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFDQCFyXA+k+c8Gn9qzR9lLCIqZgemO1CqJ4E7mFh7w=;
        b=B/mMioCfmSbSz8ZMwD5hbByKHw8UBhVHLDTEygvooVKxxdzTVMa34mL6seBPHPLK1E
         3EWojmcaW9R3W7VFKupfaC29rZwG68wzi8wI8WNFgyWLpOsgFzuJCWTaXBFPnqaE7shY
         niK8hnyS2qmor2ZyHySKCt9ScVdBOcMfbw/phqsiAwkL7Huh2Fxxcx8QOt6DK48K2n0a
         vfR6ToCYIcOl/MOpXgkbHuQ8+UgawR07fFtC2+3jC1pJe0iPc77aY5NeQ7Cn0ucu0+2G
         d8M2Swn6ly1lWvJ4eATgL5dJUlSvJMivvgGAkKUeBrYBlzZHPVEjlEIywHfLZdKU0W3x
         eyBg==
X-Gm-Message-State: AC+VfDy2tvPifVbkyo5eSS2NU92nfjtnzchMcYY+BQL1nHI/u/QHeMpb
        xXUld4L4T4owLAhEfJ+JhzqEyQ==
X-Google-Smtp-Source: ACHHUZ6A+HWr1Mi1wqQYt2gI1/Q7U4c4t3SZvF42yxu8YHpnN2TJ31mkxvlWrwV7DptdCoMugOVeTw==
X-Received: by 2002:a05:6a20:9596:b0:f3:1c8b:ce62 with SMTP id iu22-20020a056a20959600b000f31c8bce62mr5679111pzb.47.1682693845535;
        Fri, 28 Apr 2023 07:57:25 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id n47-20020a056a000d6f00b0063f18ae1d84sm13537799pfv.202.2023.04.28.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 07:57:25 -0700 (PDT)
Date:   Fri, 28 Apr 2023 07:57:25 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Apr 2023 07:57:23 PDT (-0700)
Subject:     Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux vector
In-Reply-To: <20230424194911.264850-1-heiko.stuebner@vrull.eu>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, heiko@sntech.de,
        kito.cheng@sifive.com, jrtc27@jrtc27.com,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        christoph.muellner@vrull.eu, philipp.tomsich@vrull.eu,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        heiko.stuebner@vrull.eu
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Message-ID: <mhng-51ee6a97-de3e-4b25-a506-5ffe245cde99@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 12:49:07 PDT (-0700), heiko@sntech.de wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> The hwprobing infrastructure was merged recently [0] and contains a
> mechanism to probe both extensions but also microarchitecural features
> on a per-core level of detail.
>
> While discussing the solution internally we identified some possible issues,
> tried to understand the underlying issue and come up with a solution for it.
> All these deliberations overlapped with hwprobing being merged, but that
> shouldn't really be an issue, as both have their usability - see below.
>
> Also please see the "Things to consider" at the bottom!
>
>
> Possible issues:
> - very much limited to Linux
> - schedulers run processes on all cores by default, so will need
>   the common set of extensions in most cases
> - each new extensions requires an uapi change, requiring at least
>   two pieces of software to be changed
> - adding another extension requires a review process (only known
>   extensions can be exposed to user-space)
> - vendor extensions have special needs and therefore possibly
>   don’t fit well
>
>
> Limited to Linux:
> -----------------
>
> The syscall and its uapi is Linux-specific and other OSes probably
> will not defer to our review process and requirements just to get
> new bits in. Instead most likely they'll build their own systems,
> leading to fragmentation.
>
>
> Feature on all cores:
> ---------------------
>
> Arnd previously ([1]) commented in the discussion, that there
> should not be a need for optimization towards hardware with an
> asymmetric set of features. We believe so as well, especially
> when talking about an interface that helps processes to identify
> the optimized routines they can execute.
>
> Of course seeing it with this finality might not take into account
> the somewhat special nature of RISC-V, but nevertheless it describes
> the common case for programs very well.
>
> For starters the scheduler in its default behaviour, will try to use any
> available core, so the standard program behaviour will always need the
> intersection of available extensions over all cores.
>
>
> Limiting program execution to specific cores will likely always be a
> special use case and already requires Linux-specific syscalls to
> select the set of cores.
>
> So while it can come in handy to get per-core information down the road
> via the hwprobing interface, most programs will just want to know if
> they can use a extension on just any core.
>
>
> Review process:
> ---------------
>
> There are so many (multi-letter-)extensions already with even more in
> the pipeline. To expose all of them, each will require a review process
> and uapi change that will make defining all of them slow as the
> kernel needs patching after which userspace needs to sync in the new
> api header.

The whole reason we're doing hwprobe with bitmaps is beacuse the ISA 
strings are not a stable interface, and thus are not suitable for 
building uABI around.

>
>
> Vendor-extensions:
> ------------------
>
> Vendor extensions are special in their own right.
> Userspace probably will want to know about them, but we as the kernel
> don't want to care about them too much (except as errata), as they're
> not part of the official RISC-V ISA spec.
>
> Getting vendor extensions from the dt to userspace via hwprobe would
> require coordination efforts and as vendors have the tendency to invent
> things during their development process before trying to submit changes
> upstream this likely would result in conflicts with assigned ids down
> the road. Which in turn then may create compatibility-issues with
> userspace builds built on top of the mainline kernel or a pre-
> existing vendor kernel.
>
> The special case also is that vendor A could in theory implement an
> extension from vendor B. So this would require to actually assign
> separate hwprobe keys to vendors (key for xthead extensions, key for
> xventana extensions, etc). This in turn would require vendors to
> come to the mainline kernel to get assigned a key (which in reality
> probably won't happen), which would then make the kernel community
> sort of an id authority.
>
>
>
>
> To address these, the attached patch series adds a second interface
> for the common case and "just" exposes the isa-string via the
> AT_BASE_PLATFORM aux vector.
>
> In the total cost of program start, parsing the string does not create
> too much overhead. The extension list in the kernel already contains
> the extensions list limited to the ones available on all harts and
> the string form allows us to just pipe through additional stuff too, as
> can be seen in the example for T-Head extensions [2] .
>
> This of course does not handle the microarchitecture things that
> the hwprobe syscall provides but allows a more generalized view
> onto the available ISA extensions, so is not intended to replace
> hwprobe, but to supplement it.
>
> AT_BASE_PLATFORM itself is somewhat well established, with PPC already
> using it to also expose a platform-specific string that identifies
> the platform in finer grain so this aux-vector field could in theory
> be used by other OSes as well.
>
>
> A random riscv64-qemu could for example provide:
>     rv64imafdcvh_zicbom_zihintpause_zbb_sscofpmf_sstc_svpbmt
>
> where a d1-nezha provides:
>     rv64imafdc_xtheadba_xtheadbb_xtheadbs_xtheadcmo_xtheadcondmov_xtheadfmemidx_xtheadint_xtheadmac_xtheadmemidx_xtheadmempair_xtheadsync
>
>
> Things to still consider:
> -------------------------
>
> Right now both hwprobe and this approach will only pass through
> extensions the kernel actually knows about itself. This should not
> necessarily be needed (but could be an optional feature for e.g. virtualization).
>
> Most extensions don’t introduce new user-mode state that the kernel needs to manage (e.g. new registers). Extension that do introduce new user-mode state are usually disabled by default and have to be enabled by S mode or M mode (e.g. FS[1:0] for the floating-point extension). So there should not be a reason to filter any extensions that are unknown.
>
> So it might make more sense to just pass through a curated list (common
> set) created from the core's isa strings and remove state-handling
> extensions when they are not enabled in the kernel-side (sort of
> blacklisting extensions that need actual kernel support).
>
> However, this is a very related, but still independent discussion.
>
>
> [0] https://lore.kernel.org/lkml/168191462224.22791.2281450562691381145.git-patchwork-notify@kernel.org/
> [1] https://lore.kernel.org/all/605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com/
> [2] These are the T-Head extensions available in _upstream_ toolchains
>
> Heiko Stuebner (4):
>   RISC-V: create ISA string separately - not as part of cpuinfo
>   RISC-V: don't parse dt isa string to get rv32/rv64
>   RISC-V: export the ISA string of the running machine in the aux vector
>   RISC-V: add support for vendor-extensions via AT_BASE_PLATFORM and
>     xthead
>
>  arch/riscv/errata/thead/errata.c     | 43 ++++++++++++
>  arch/riscv/include/asm/alternative.h |  4 ++
>  arch/riscv/include/asm/elf.h         | 10 +++
>  arch/riscv/kernel/alternative.c      | 21 ++++++
>  arch/riscv/kernel/cpu.c              | 98 +++++++++++++++++++++++++---
>  5 files changed, 168 insertions(+), 8 deletions(-)
