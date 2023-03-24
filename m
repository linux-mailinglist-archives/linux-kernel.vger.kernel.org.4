Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A936C82BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjCXRCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjCXRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:02:08 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7FF75B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:02:07 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5416698e889so44359947b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679677326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPlT2n/+WAO9F7YARVyeOXyqn4X2lcfpt5LypD/9BR0=;
        b=VUzkrkumN1l1E8bs4oNdlXWd7fISTZ1PZ5jebg66m//0YRzDxUTLC5YiMB9PUvGPQF
         huu2aL3ofWIuKau+x8NAxOqxAS/KClGHofksBJ+s+dJu7hPoLEi03VXzvJtXpc1eC7Vv
         rKwXFnv3XrEmeR6mx0lsjnsoA0UgWerMYNvMqcrVtzkyrF7M16k9/3PdV9DRzpVL4VBe
         c45Dnh/Cb9hTG8CohPCC2q6rumSXBKQaRrnRUfPubdVumBPL1cU08EGb0WaPhZ/dEg7a
         72Io0Niyj/KTWK/PGrf+PrhGRzooZDhGCzCwWzSSt5NTcZA85BYuzZChbZ3fbxA8RfL5
         VnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679677326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPlT2n/+WAO9F7YARVyeOXyqn4X2lcfpt5LypD/9BR0=;
        b=TI+4U9eoXR6glD7A2PVdGfzNXLmQ1pEEIVn4XOf4E63nJbZvLUiOL7g5WjiNvIquiD
         38Gb5HfXR71WKv8nmksfWcuoSGu9bTMLElneVco+lenyUVRUq9JYtRgGa+hNvmseJywF
         wzTApLDneA0FEuBbhdan6HwBc5N2lpmC8yklUv8/T9lWxEjvayvAX83JC8gEcyqeclKv
         GFoR6TrON8H21mpScOCaYeddPvBW1Qn61mBLts2pAZBzuWkow07EB2w5Fh8BSzsNlr04
         WRVGtLrQT2LrBR1DSEjixXNvu+WnZqPVw0tb3D/y8srW5/jK7knDpL+pA+k188jbaNZr
         BYnA==
X-Gm-Message-State: AAQBX9fvtFzJzMW7UfbjThyDHDvl+uEUcbJRvZYYjPmaV0327gbJewH9
        /1kvMcIaVBfL0EFh0ggLf1ogzDplHTUrTyRZGXo=
X-Google-Smtp-Source: AKy350bAMxgXuFTxjm9PAqhatCJpA+5PzhpFhCTos3DHH5aOu5JYbJtTqOruoiSRWPNAAcu5bsRucw0p2QPj5xI8P24=
X-Received: by 2002:a05:690c:72e:b0:541:6763:3ce1 with SMTP id
 bt14-20020a05690c072e00b0054167633ce1mr1331188ywb.2.1679677326316; Fri, 24
 Mar 2023 10:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
 <ZBRiRu7hlwxSKHBg@alley> <CABDcavYLQ63V81z5JiOxZ6hXMj=M+PQpfDLPk6AQynLGwuYTKQ@mail.gmail.com>
 <ZB281JxlZtKSkJoJ@alley>
In-Reply-To: <ZB281JxlZtKSkJoJ@alley>
From:   Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Date:   Fri, 24 Mar 2023 18:01:55 +0100
Message-ID: <CABDcavZ70vtoZvJPPF=6qGe7SWOp1TbXM_ZhzAnyiTQy7YSqhw@mail.gmail.com>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?B?UGVkcm8gR2FyY8OtYS1QZWdvIENhdGFsw6E=?= <pgpego@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

El vie, 24 mar 2023 a las 16:08, Petr Mladek (<pmladek@suse.com>) escribi=
=C3=B3:
>
> Hi Linus,
>
> I need an advice whether to revert the commit 3cffa06aeef7ece30f
> ("printk/console: Allow to disable console output by using
> console=3D"" or console=3Dnull").
>
> On Wed 2023-03-22 09:33:32, Guillermo Rodriguez Garcia wrote:
> > Hi Petr,
> >
> > El vie, 17 mar 2023 a las 13:51, Petr Mladek (<pmladek@suse.com>) escri=
bi=C3=B3:
> > >
> > > On Thu 2023-03-16 11:29:26, Guillermo Rodriguez Garcia wrote:
> > > > Hi all,
> > > >
> > > > We have several embedded systems where pass console=3D or console=
=3Dnull
> > > > in production to disable the console.
> > > >
> > > > Later we check for this in user space: in our inittab we check if f=
d0
> > > > is "associated with a terminal" (test -t 0); if so, we are in
> > > > development mode and we open a debug shell; otherwise (console
> > > > disabled) we just start the application.
> > > >
> > > > Recently [1] this behaviour has changed and now if we pass console=
=3D or
> > > > console=3Dnull, the new ttynull driver is used. This breaks the che=
ck we
> > > > were doing (test -t 0 always true now).
> > > >
> > > > [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
> > >
> > > This is actually exactly the problem that the change tried to solve.
> > > Some systems failed to boot when there was no console and they tried
> > > to write something at stdout.
> >
> > Well, I did not have any problem before this change.
> >
> > I understand that some systems had a problem (many others didn't, and
> > setting console=3D or console=3Dnull has been standard practice for a l=
ong
> > time). Since this change in behaviour could (and did) break things in
> > user space, perhaps it should have been made opt-in...
>
> Historically, a single and invalid console=3D<name> kernel parameter
> might cause that no console gets registered. As a result, there
> is no stdin/stdout/stderr for the init process.
>
> From the code perspective, the <name> is considered a preferred
> console. No console is registered by default because there is
> the preferred console. But an invalid <name> never matches.
>
> The non-existing stdin/stdout/stderr caused Oopses reported during boot, =
see
> https://lore.kernel.org/all/20200309052915.858-1-shreyas.joshi@biamp.com/
> https://lore.kernel.org/all/20201006065907.GA528@jagdpanzerIV.localdomain=
/
>
> It would have been great to debug the root of the Oopses.
> But it was not trivial. And it looked like the fallback
> to ttynull made sense even if the kernel did not crash:
>
> 1. The init process might expect a working stdin/stderr/stdout.
>    The POSIX standard says:
>
>     At program start-up, three streams are predefined and need not be
>     opened explicitly: standard input (for reading conventional input),
>     standard output (for writing conventional output), and standard error
>     (for writing diagnostic output). When opened, the standard error
>     stream is not fully buffered; the standard input and standard output
>     streams are fully buffered if and only if the stream can be determine=
d
>     not to refer to an interactive device.
>
> 2. Also the comment in init/main.c is rather clear:
>
>     /* Open /dev/console, for stdin/stdout/stderr, this should never fail=
 */
>    void __init console_on_rootfs(void)
>
>
> This is why we implemented the fallback to ttynull. But it causes
> regressions on Chromebooks. They use:
>
>    + console=3D"" to disable consoles on production systems.
>      (better performance, nobody reads the console anyway).
>
>    + "test -f 0" to detect whether the Chromebook is in
>      debugging mode.

FWIW, in my case (not a Chromebook) I was not using test -f, but test
-t in order to check whether fd 0 was "a terminal".

(In hindsight perhaps this worked because when the console is invalid,
there is no fd 0 at all).

[...]
>
> The regression did not reach normal users. Chromebook developers

This is not entirely correct; the regression not only affected
Chromebooks. I suspect it affected many embedded systems where setting
console=3D"" or console=3Dnull is very common. For example, in U-Boot,
when you use the "silent" parameter to suppress log output (which is
common practice in production), the console parameter is automatically
set to "" (empty string). When the meaning of console=3D"" changed, this
also caused side-effects that had to be fixed in U-Boot; see
https://github.com/u-boot/u-boot/commit/ba9aa40bb387385b8ef8b6594661a97ddcb=
8d04c

My point is that perhaps only Chromebook developers complained here,
but many other users were probably affected (specially on embedded
systems).

BR,

Guillermo
--=20
Guillermo Rodriguez Garcia
guille.rodriguez@gmail.com
