Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D267DD5C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjA0GQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjA0GQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:16:11 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8059995
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:16:09 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 3so4296768vsq.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rlEPecTLwN3aXhkWIpbJ727AOVtBMW9dFqDKEbVST3Y=;
        b=SxSAU5wU3Q3dN1ZzOJSRsHrPqKoDYVy+1dpYu+PY9tkCYe/4iB8S4FaE7xOIHba1N9
         DNhM+qlp1YaL5WT4DVDIrNKS8Wk3lJfmVTvt0TQ79hJFp6nr2P0IuTFNikA0PEk6OwyU
         7RRIZJDCyVl3zzLrPSupxVBNQYvYOpZHIsaAFMk74+4BOI59tHjCIRpRTQovnNZIjnJZ
         CqMz9twr+3Shrn5C4xDzFxw9ViVksJXQJdlkHnQyFZKwY+aTxbnh9lIrd4Z0SDCIyUuc
         U1TPuYxEt/4KF6x4ksCvvbQp4OqHFf+SN7xQFBt4fN4Ifyfr/ilZcyQ4/DcqCQiwe4h6
         2VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlEPecTLwN3aXhkWIpbJ727AOVtBMW9dFqDKEbVST3Y=;
        b=iypC/JrHtt6Ol5jAnOQ90JrT6t+dC9kFrNsgArmupN+XRXTVwvldFKPtdueHjiX6v0
         UKEvecjYZ0yue6mMfu527iFIxzdyviA0qRIZFw6Fta2hUHzfIWAotfTI6TYZi6CJZPBy
         VxMA+WSUDSJRwpZs3WMfJPOxvMEoZwuiO2Z0ZQCblUzAdOdMtEdd7M0/ujsE8Cwnxtgy
         drQIxc22oXMNfFZ593sEDmldVLUpca5eLYvJ1BdFf+PoiIv3nUHJ9puRvdHZTPPHt1Il
         4cghq3TS6xhk772t+3TlnDKcAjNeWBv2eB5lrqS3sw7LJQ3/JFaaf6FUlW8yFro3Xv55
         7yvw==
X-Gm-Message-State: AFqh2kqVbeoRSvPT1TQZ6ny0+O+oeUIMbm97mofXs5gK2UibxQwyJEbD
        bNksj2qn9EGIoWV3mxU7IqLpPVe6hBi80PGpkrihBg==
X-Google-Smtp-Source: AMrXdXvLEmqxBN/QcD5pknzRXRjn9K7V6E2J+enieZkQ42cCt/OxiBZAHHyvc446AfpfJKy4sI66EbTL1wsz2FMzSaw=
X-Received: by 2002:a67:ea03:0:b0:3d0:d172:3a02 with SMTP id
 g3-20020a67ea03000000b003d0d1723a02mr5288645vso.41.1674800168420; Thu, 26 Jan
 2023 22:16:08 -0800 (PST)
MIME-Version: 1.0
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
 <CAFA6WYOucB3JdVATbydxYuAb0Q5P7ff_JMb=-BgiF+uip8pdpg@mail.gmail.com>
 <Y9AdunpawWzWKIXN@aspen.lan> <d6a92e81-0f67-68ce-744d-149bbcdc06d9@arm.com>
In-Reply-To: <d6a92e81-0f67-68ce-744d-149bbcdc06d9@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 27 Jan 2023 11:45:57 +0530
Message-ID: <CAFA6WYN=no8NEWYmjxZRk2p5eEnCVyu+5Dw1DNxKaPijXcrByQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] arm64: Fix pending single-step debugging issues
To:     Luis Machado <luis.machado@arm.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>, will@kernel.org,
        catalin.marinas@arm.com, liwei391@huawei.com, mhiramat@kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dianders@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On Wed, 25 Jan 2023 at 14:48, Luis Machado <luis.machado@arm.com> wrote:
>
> Hi,
>
> Is this expected to change single-stepping operation in usespace for debuggers (gdb/lldb)?

No it won't affect user-space debuggers as we are only touching the
interrupt path in EL1 mode.

-Sumit

> If so, it would be nice to at least
> test it a little to make sure it works.
>
> On 1/24/23 18:04, Daniel Thompson wrote:
> > On Thu, Jan 12, 2023 at 02:52:49PM +0530, Sumit Garg wrote:
> >> Hi Will, Catalin,
> >>
> >> On Mon, 19 Dec 2022 at 15:55, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>>
> >>> This patch-set reworks pending fixes from Wei's series [1] to make
> >>> single-step debugging via kgdb/kdb on arm64 work as expected. There was
> >>> a prior discussion on ML [2] regarding if we should keep the interrupts
> >>> enabled during single-stepping. So patch #1 follows suggestion from Will
> >>> [3] to not disable interrupts during single stepping but rather skip
> >>> single stepping within interrupt handler.
> >>>
> >>> [1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
> >>> [2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
> >>> [3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/
> >>>
> >>> Changes in v5:
> >>> - Incorporated misc. comments from Mark.
> >>>
> >>
> >> Since patch #1 has already been reviewed/acked by Mark and the
> >> complete patchset has been tested by Doug, would it be fine for you to
> >> pick up this patchset? It fixes a real single stepping problem for
> >> kgdb on arm64.
> >
> > Sorry to be quiet for so long.
> >
> > Testing this patch set has proven to be a little difficult.
> >
> > It certainly fixes the single step tests in the kgdbtest suite.
> > That's a good start.
> >
> > Unfortunately when testing using qemu/KVM (hosted on NXP
> > 2k/Solidrun Honeycomb) the patch set is resulting in instability
> > running the built-in self tests (specifically this one:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/misc/kgdbts.c#n74 ). Running this test using the kgdbtest harness
> > results in the test failing roughly a third of the time.
> >
> > The error reported is that the trap handler tried to unlock a spinlock
> > that isn't currently locked. To be honest I suspect this is a generic
> > problem that the new feature happens to tickle (this test has
> > historically been unreliable on x86 too... and x86 is noteworthy for
> > being the only other platform I test using KVM rather than pure qemu).
> > Of course the only way to prove that would be to find and fix the
> > problem in the trap handler (which probably involves rewriting it) and I
> > haven't managed to do that yet.
> >
> > In short, I think the debugger is more useful with this patchset than
> > without so, although it is caveated by the above, I'd call this:
> >
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> >
> >
> > Daniel.
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
