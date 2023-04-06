Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891F6DA4AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjDFVa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjDFVay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:30:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D76592
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 14:30:53 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5416698e889so764561057b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1680816653; x=1683408653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LItukwG4Odlmrx9xSdhd9q03PqIJKqsvFSRXWc9+xyk=;
        b=UM94zSWJxUtUQNyhE2S5+ZnZoISkomXa5IEM3sbIOBFEzGWFdq4izGSbTieIwqRi4F
         tqtzdxT8yuV5Twubnt0ECfWuAiNzp7DxEtg+wdUKtFwfLivl9I+9BuMFWyvVwLLRfuMq
         57aQWmp3QRklpwLsbjs5rSyKvE0ulygpLaMxYhkZlxuoMZIdWLsa0XnN5+ybHHFzVyYW
         tgbULRp9y5b0j7LUJBdiHqACYk7UOL7D81TF35pfA3UFbpDUNCKQ6p8Vd3qdLVW2d0l+
         HfjnbzNro25iv0tnqsx1sddYnyoFvRfrCGOR3LuGZ5d1MiB8gP/L5GK9sdE7K+30fZg0
         4tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816653; x=1683408653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LItukwG4Odlmrx9xSdhd9q03PqIJKqsvFSRXWc9+xyk=;
        b=1QG0nUD54RxoSsWfFFL1JlZxcYVAiPsl9Fk7GMfcBBZ2IYzwywQf0mglBfB3LR9xZF
         3Qpngqna3iWRQf8B+UOrAtCWnkbj8Ek0n9Eaw0VyaxXdNXyfhfyuzqvPmpuWIp2Ia/E2
         ctbtnAAZ9LUtd78QsPvHNqtxK2F2BlrdG27yDBBJz93h5omUM8xo/uX3IKJMPiFByh20
         oo6QS/Mxmh5vpF0Ky5M+WRyarVt+D1qebSWx/4RCCSjkE6HSVRou5HjwhHcLPsVLHSOK
         xQfByJMh+F3kPnZIPGuQfG2IBG+pvGO0V6+CMyNl9EMhzOuOTTmOc/WMJHfBGDNMc9ln
         p8nQ==
X-Gm-Message-State: AAQBX9fIFPqfPz5R+TiunPbG1mZl7eX4pRvlHJdFUVPNBewK8kpHilz0
        CVPilR88D/n56PwraRf2EvP/fV/dkusi3uEWRmKt
X-Google-Smtp-Source: AKy350Y+xySP235LlVDpjpxIgXqBw8Vnaj7LP4q+p9PthWHwn/6cvXBN2h6S1TdLiMWmw9cYQPxewQonxbjdrihvX6k=
X-Received: by 2002:a81:a94a:0:b0:545:6132:e75f with SMTP id
 g71-20020a81a94a000000b005456132e75fmr6691505ywh.8.1680816652795; Thu, 06 Apr
 2023 14:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <ZC8Dbux56HbJjpTy@char.us.oracle.com> <CAHC9VhQ2rLpjczvb4993fQiMau7ZXLe8aTLtMZO_iF42w=1frg@mail.gmail.com>
 <0746dd23-5dcf-e858-e15b-159673266f2f@oracle.com>
In-Reply-To: <0746dd23-5dcf-e858-e15b-159673266f2f@oracle.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Apr 2023 17:30:41 -0400
Message-ID: <CAHC9VhTCq=07mp4ne8Gvk7K9YkqrUFRxPSyfyoN2e1Zy2F7+DQ@mail.gmail.com>
Subject: Re: Semantics of blktrace with lockdown (integrity) enabled kernel.
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, nathanl@linux.ibm.com, joe.jin@oracle.com,
        Eric <eric.snowberg@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 3:30=E2=80=AFPM Junxiao Bi <junxiao.bi@oracle.com> w=
rote:
> On 4/6/23 11:39 AM, Paul Moore wrote:
> > On Thu, Apr 6, 2023 at 1:38=E2=80=AFPM Konrad Rzeszutek Wilk
> > <konrad.wilk@oracle.com> wrote:
> >> Hey Jens, Paul, James, Nathan,
> >>
> >> We are trying to use blktrace with a kernel that has lockdown enabled =
and find that it cannot run.
> >>
> >> Specifically the issue is that we are trying to do is pretty simple:
> >>
> >> strace -f blktrace -d /dev/sda -w 60
> >>
> >> [pid 148882] <... mprotect resumed>)    =3D 0
> >> [pid 148881] openat(AT_FDCWD, "/sys/kernel/debug/block/sda/trace0", O_=
RDONLY|O_NONBLOCK <unfinished ...>
> >> [pid 148882] sched_setaffinity(0, 8, [1]) =3D 0
> >> [pid 148881] <... openat resumed>)      =3D -1 EPERM (Operation not pe=
rmitted)
> >>
> >> which fails. The analysis from Eric (CCed) is that
> >>
> >> All debugfs entries do not exist until blktrace is run.  It is opening
> >> /sys/kernel/debug/block/sda/trace0 which isn=E2=80=99t there normally.=
 While running the utility,
> >> to place something in it, it must have the write permission set.  When=
 exiting out of
> >> blktrace, the entry is gone, both on a machine running with secure boo=
t enabled
> >> and one with it disabled.  Which also indicates the write permission w=
as set,
> >> otherwise the entry would still be there.
> >>
> >> The fix is simple enough (see attachment) but we are not sure about th=
e semantics of what
> >> lockdown has in mind.
> >>
> >> Looking at the include/linux/security.h the LOCKDOWN_TRACEFS exists wh=
ich would
> >> imply that it is expected that operations with tracefs *should* work w=
ith lockdown (integrity mode).
> >>
> >> But at the same point, debugfs writable attributes are a nono with loc=
kdown.
> >>
> >> So what is the right way forward?
> > What did you use as a basis for your changes?  I'm looking at the
> > patch you sent and it appears to be making a change to a
> > debugfs_lockdown_whitelisted() function defined in
> > fs/debugfs/internal.h which does not exist in Linus' tree.  If I
> > search through all of the archives on lore.kernel.org the only hit I
> > get is your email, so it seems doubtful it is in a subsystem tree
> > which hasn't made its way to Linus yet.
> >
> > Before we go any further, can you please verify that your issue is
> > reproducible on a supported, upstream tree (preferably Linus')?
>
> The patch attached is applied to oracle kernel which is just used to
> demo the idea of a possible fix.
>
> Upstream will have the same issue because blktrace uses relay files from
> debugfs to transfer trace information from kernel to userspace ...

For future reference, the problem with sending patches that aren't
based on an upstream tree is that it both wastes reviewer time trying
to figure out where the basis of the patch, and it makes one question
if the issue is present in an upstream kernel or if there is some
out-of-tree patch in the unknown kernel which is the root cause.

Maybe you've tested everything and know it is a problem with the
upstream code, but when we see a patch that doesn't match up with
anything, how are we supposed to know?

--=20
paul-moore.com
