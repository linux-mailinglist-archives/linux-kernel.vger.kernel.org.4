Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381355B5FED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiILSKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiILSJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:09:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5456ED52
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:09:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d12so9335079plr.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=krOgoVxwfTTiN1DsCbbELdSz8T1/ug820utrPBGbV+I=;
        b=bbbi3kXh+LuJ615H9/uybCphjVG9PAN1wwm41NzOSOv+PgbEvdPHXSa/FUVuNSX9rF
         cB35qq0zyXJFhMRWzip77xbxMugOe/lnqgHG02o/U6PABq7jAyVJo8WkRqikgUWx82gh
         dhVsA+MMAdP09T3YjlDMYRAX0+zXzJxFXC8SHN333GxgUBHMYHd8srOQMgcxkNZJ71yK
         +V8aM7TWpFRJyvy10jiXA+/A+60P1VY43ycrGU0XA7FXO3AwTGT3D5d6h2XOCj0Nlmlz
         i6LFPmnRpVRHzrV/hIcNEO22P7kfgXapvN5dcK3PfRFuBYu1kFtrpqBVfUUvYBhcd9xW
         lYMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=krOgoVxwfTTiN1DsCbbELdSz8T1/ug820utrPBGbV+I=;
        b=O6SStfgpAcQ2psoCmU6vyXdltjmvPQfXZ4w0QH/xJ/WxI6dxyvIr/HxdFtbYUktLBu
         MjoDQYi4HShFIaBAaP6J4+P079VsDn7w8UdjMS6HIDb/4KT/lTznU9HEN8FHe7kltdSc
         Kpkvc4lqy1WLgH8HtfGZpiB2V+uJKlKnKJM3OuGKR2GaHRKoxG3+Xpk/WyKEHPbNbWlB
         IhGYaddRv6Oxj5r8Kc0PaY4gPVDB3aUftELT1JQCDV8GPDCCco3dpwOm768iD08DaW5e
         tDULiZjHg3d4ttuP04tR6a3YBg49Sv627y22TXekYaETWS3piS3DNeBTzyN8dujlb8Cu
         uJPQ==
X-Gm-Message-State: ACgBeo3eMwJ3Qo0/y436BDKvkEhFeWttG3dy0GPtf5krxoQ6oFOZT9ny
        VXxUrGUAAix6KMswPMNXsO40ZWMOQFz0Nx5yvuo=
X-Google-Smtp-Source: AA6agR4X+Fq14UwFKI68855EfSw8R3jyZUluAJHbDZ9hWSkXwABmcDTlgOOQ8IOazviEmBzF0o8L3K5Y3Kb2rhBqyxM=
X-Received: by 2002:a17:90b:1c81:b0:1fb:887c:f82e with SMTP id
 oo1-20020a17090b1c8100b001fb887cf82emr25159974pjb.92.1663006169735; Mon, 12
 Sep 2022 11:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220901141307.2361752-1-georgepee@gmail.com> <f765da5c-d484-adf2-e1bb-77011780dc0b@arm.com>
 <CAKj0CMv1EY5YCeQ4G6PnGP=XfELJkkN5BaN8W1TGe0fOTXfJBw@mail.gmail.com>
 <YxtIiBvAGs2vAl1P@arm.com> <CAKj0CMtkY_BSkAY3Lo5QbMDM1g0Wa9F8MsVuW0fyJiuPe3z4aA@mail.gmail.com>
 <YxtWUasndYl8syE1@arm.com> <Yx8upeabh9p6gGtY@shell.armlinux.org.uk>
In-Reply-To: <Yx8upeabh9p6gGtY@shell.armlinux.org.uk>
From:   George Pee <georgepee@gmail.com>
Date:   Mon, 12 Sep 2022 13:09:17 -0500
Message-ID: <CAKj0CMtemaGcTPDjdo_18H=_VSQE-udqazdSRsEGX2x8r+We+Q@mail.gmail.com>
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
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

On Mon, Sep 12, 2022 at 8:05 AM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Fri, Sep 09, 2022 at 04:05:53PM +0100, Catalin Marinas wrote:
> > On Fri, Sep 09, 2022 at 09:57:39AM -0500, George Pee wrote:
> > > The details are here.  I originally thought it was a compiler bug
> > > because it first showed up after a toolchain update.
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106763
> > >
> > > Since FP16 is an optional extension, wouldn't it be beneficial to a
> > > user who compiled some userspace float16 code using gcc
> > > -mcpu=cortex-a55 which ran on a cortex-a55 with FP16 extensions but
> > > SIGILL'd on a cortex-a55 w/o FP16?
> >
> > (please don't top-post)
> >
> > My point is that if the kernel doesn't have full support for FP16, it
> > shouldn't advertise it to user even if the hardware supports it. If you
> > fix the kernel to properly handle FP16 on supporting hardware, then the
> > HWCAP part is fine by me.
>
> Presumably, the only CPUs that are going to support FP16 will have
> non-trapping floating point, so the support code shouldn't be entered
> at any time to emulate a half-precision instruction, but only to
> handle the lazy restore of the thread's floating point registers?
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

I didn't see this until after I submitted v2 of the patch.  Let me
take a look at the fp emulation code path.
I had assumed that CP9 handling would work just like CP10/CP11 does in
entry-armv.S and wouldn't need any special handling.
