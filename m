Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B255B3B39
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiIIOzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiIIOzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:55:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F3A33A26
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:55:05 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id z18so1442794qts.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bCvNKZoLydGpNHfnmbhPHdRB0xcZW5gv/VnZsrr3nIY=;
        b=aROr7p194S8QWVGn8J27yn15HcdwP8Pmes6eH9lKtOyxkH/EKF0u6qGFTZF5C+q2b2
         xtqBzLQfuRBO5m7giVDzdyenhsv4d27DhLrGJK6p4dOKGCOE9pEZjHNh6lQAVz40hG7Z
         ratrOQIt7Mtn6hUQ2qmb06eGZVA2Id8QTA8Ngmcax8fO7a1YJ51UErXeS0WHj7s4neFn
         4Z4JSG5U/LIrpMEtk3rKDnRFBmZ508smDREdKFxBiTto6ztzkrlgBElrYPdJ1olVodHj
         VFwTrQN2AZ8IjHKvAdxQbSPsPgkItJyN5sBJj6UsKi6VwMIHwBpEgP2lMPQryhDvaUlo
         NbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bCvNKZoLydGpNHfnmbhPHdRB0xcZW5gv/VnZsrr3nIY=;
        b=nZV/XgKo+P2mbzR5Kzeytpro9Z8nuwrOlGkFIaXhBggM2MNNqomSIUwp4lUL76Goft
         ytx9zymnwnzK2q5siNjqpbDOCoNmWPuSaQeIuVEUsaFw8+/UDmcG/3sCnIExbA4p/S5c
         Ly515Zih8PD4arHnRGARqxIE9FzEpdUcFWPSAloogAoHrV1alcdDwsW52wzhka+aV+az
         SxgvrvpDW6MYHLqPoFr9U/Pb2zmeR3k4DS0+zMxGieMo2CILHbb3cXRL//kXXhrf48gS
         frj1DK7B+6QY9bl1DmkkfQqCA/Q3aOFV/+rPpYu8DUYKyCXoASgqAKNOcNeh+6+RPVmd
         BqxA==
X-Gm-Message-State: ACgBeo0OvK9D56JiNDCgL3aPz5ouAHMvkrc2m4cm9kjSVK6boPM6P6Jb
        dRtAHYS3RqIkZV+zEUPmxh15V0JpcJ1zh+kg+7RoUuQzUSgp2w==
X-Google-Smtp-Source: AA6agR7kap/mZYJkOyyNkUwnHdsb4MvcIgInmUHiEb3ySElzqIee88HmlSAwUWVFmGmJIkW5AaJTwUpeLWYJFMwWF2k=
X-Received: by 2002:ac8:5fc8:0:b0:344:5ac5:c8e4 with SMTP id
 k8-20020ac85fc8000000b003445ac5c8e4mr12651106qta.113.1662735303638; Fri, 09
 Sep 2022 07:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220901141307.2361752-1-georgepee@gmail.com> <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
 <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com> <28b35935-4e7f-2bd5-dda5-ed81402a527e@arm.com>
In-Reply-To: <28b35935-4e7f-2bd5-dda5-ed81402a527e@arm.com>
From:   George Pee <georgepee@gmail.com>
Date:   Fri, 9 Sep 2022 09:54:52 -0500
Message-ID: <CAKj0CMsEVOjz2TU+hA1kO181=i1KJsNX5SnEJvUajamgooivUg@mail.gmail.com>
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That makes a lot of sense.  How's this?  Flipping the HWCAP2_FPHP bit
is already in a CONFIG_VFPv3 check.

diff --git a/arch/arm/include/uapi/asm/hwcap.h
b/arch/arm/include/uapi/asm/hwcap.h
index 990199d8b7c6..5d635dce8853 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -37,5 +37,6 @@
 #define HWCAP2_SHA1    (1 << 2)
 #define HWCAP2_SHA2    (1 << 3)
 #define HWCAP2_CRC32    (1 << 4)
+#define HWCAP2_FPHP    (1 << 5)

 #endif /* _UAPI__ASMARM_HWCAP_H */
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c39303e5c234..161f8df852e1 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -625,11 +625,12 @@ call_fpe:
     ret.w    lr                @ CP#6
     ret.w    lr                @ CP#7
     ret.w    lr                @ CP#8
-    ret.w    lr                @ CP#9
 #ifdef CONFIG_VFP
+    W(b)    do_vfp                @ CP#9  (VFP/FP16)
     W(b)    do_vfp                @ CP#10 (VFP)
     W(b)    do_vfp                @ CP#11 (VFP)
 #else
+    ret.w    lr                @ CP#9
     ret.w    lr                @ CP#10 (VFP)
     ret.w    lr                @ CP#11 (VFP)
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..8887d0f447d6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1258,6 +1258,7 @@ static const char *hwcap2_str[] = {
     "sha1",
     "sha2",
     "crc32",
+    "fphp",
     NULL
 };

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..fb774fd5c614 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -831,6 +831,8 @@ static int __init vfp_init(void)

             if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
                 elf_hwcap |= HWCAP_VFPv4;
+            if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
+                elf_hwcap2 |= HWCAP2_FPHP;
         }
     /* Extract the architecture version on pre-cpuid scheme */
     } else {

On Fri, Sep 9, 2022 at 9:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-09-09 14:34, George Pee wrote:
> > Adding the hwcap was part of the diagnosis process-- I added it just
> > to make sure that the cpu in question supported the optional
> > extension.
> > It seems like it could be useful to be able to check for support in
> > /proc/cpuinfo.
>
> Sure, but "support" is about more than just what happens to be present
> in hardware. Observe that you can build the 32-bit kernel with
> CONFIG_VFP=n, and it then does not report and VFP or NEON hwcaps,
> because those features will not be usable in that configuration, even if
> you know the hardware implements them.
>
> Note that this looks different on arm64, since there we always expect to
> have FPSIMD hardware available, so support in the kernel is
> unconditional, plus that kernel support is also a lot simpler since we
> don't have a soft-float ABI with all the corresponding trapping stuff
> either.
>
> It might just be the case here that the call_fpe logic needs a bit of
> tweaking to provide proper support, but I'm not sufficiently familiar
> with the ARM VFP code in general to be sure.
>
> Thanks,
> Robin.
>
> > On Fri, Sep 9, 2022 at 7:46 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2022-09-01 15:13, george pee wrote:
> >>> Report as fphp to be consistent with arm64
> >>
> >> Wasn't the original problem that the VFP support code doesn't understand
> >> the new FP16 instruction encodings, so in practice they don't actually
> >> work reliably? Exposing a hwcap to say they're functional doesn't
> >> inherently make them functional - if there is already another patch
> >> somewhere for that, it should be made clear that this depends on it.
> >>
> >> Robin.
> >>
> >>> Signed-off-by: george pee <georgepee@gmail.com>
> >>> ---
> >>>    arch/arm/include/uapi/asm/hwcap.h | 1 +
> >>>    arch/arm/kernel/setup.c           | 1 +
> >>>    arch/arm/vfp/vfpmodule.c          | 2 ++
> >>>    3 files changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
> >>> index 990199d8b7c6..f975845ce5d3 100644
> >>> --- a/arch/arm/include/uapi/asm/hwcap.h
> >>> +++ b/arch/arm/include/uapi/asm/hwcap.h
> >>> @@ -28,6 +28,7 @@
> >>>    #define HWCAP_IDIV  (HWCAP_IDIVA | HWCAP_IDIVT)
> >>>    #define HWCAP_LPAE  (1 << 20)
> >>>    #define HWCAP_EVTSTRM       (1 << 21)
> >>> +#define HWCAP_FPHP   (1 << 22)
> >>>
> >>>    /*
> >>>     * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
> >>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> >>> index 1e8a50a97edf..6694ced0552a 100644
> >>> --- a/arch/arm/kernel/setup.c
> >>> +++ b/arch/arm/kernel/setup.c
> >>> @@ -1249,6 +1249,7 @@ static const char *hwcap_str[] = {
> >>>        "vfpd32",
> >>>        "lpae",
> >>>        "evtstrm",
> >>> +     "fphp",
> >>>        NULL
> >>>    };
> >>>
> >>> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
> >>> index 2cb355c1b5b7..cef8c64ce8bd 100644
> >>> --- a/arch/arm/vfp/vfpmodule.c
> >>> +++ b/arch/arm/vfp/vfpmodule.c
> >>> @@ -831,6 +831,8 @@ static int __init vfp_init(void)
> >>>
> >>>                        if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
> >>>                                elf_hwcap |= HWCAP_VFPv4;
> >>> +                     if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
> >>> +                             elf_hwcap |= HWCAP_FPHP;
> >>>                }
> >>>        /* Extract the architecture version on pre-cpuid scheme */
> >>>        } else {
