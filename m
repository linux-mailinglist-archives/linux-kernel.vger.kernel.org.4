Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF36AC9E6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCFRYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCFRYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:24:30 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2976421285
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:23:56 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A25823F59A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678121077;
        bh=N4pZqm54gYdFBwXOZFEaxtEajFYJlONCrwosIbU2uiM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QE96Uuq1TatICmI/zZqfP0tZPaQgYNQaZaCqZ8JuL/NXJCe8ESyPMUskOae87l80A
         zmLphKrushBO5KyBrM/anLrTHySzInggQenKZ0Yjal7B9R97HVyIZi7z2vPWW+O+xV
         pc+OlwUKZiaHPh01C77u3PYQO+qd6K/gej7IZnumKU/zmYx3XawMKI8S7zIdXzcdNE
         e3Os+PPih4XsYrvecFiL+PrnpiZkQnUPPLD/eb37En/zl3sjPiYfxShRxqs+XKM8Bx
         ovKrUDLCYA32ii5d/L00uyji9zr0Z6cpJvMWWnylneT6NjbCKUyDyNZHJmf16nGAIv
         lrlyT4IGJovZg==
Received: by mail-yb1-f198.google.com with SMTP id l24-20020a25b318000000b007eba3f8e3baso10915180ybj.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 08:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678121076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4pZqm54gYdFBwXOZFEaxtEajFYJlONCrwosIbU2uiM=;
        b=f/ndfGEmJ/i8C8U4ZI1gF8AEyM0UUWkbezZEE8iwY2+lVEtvJH4fCBhlvGT+gonruM
         V6WcCM3lka2aYwjQ1AozE00HMEZz2R46tWXum6l6mtN2cGaqvxnYmdolPpf7CxGJWIxI
         Fq5ocgx81hLT4e6G8QxpvdYpv4onqSfD44Vx6JX9mbBuuza18psPxFyIQ/HIEYP6C70e
         sn88Y4+5RV6cN7TLAv4027kBl3ZF2fHXa0LdlE5mRWV2o7TXR3YqebKTbqhmT++lnIXy
         7IisMMJRW29ynSMgXdCI1eJ96Xb3wEDfg5p1Q+q7togoHe0uDXgeCWzGcUnNKwII4FQa
         NhPA==
X-Gm-Message-State: AO0yUKXIbjx+77oK+aAoBr1SQubaeK5GOztCP2V+J2hMN5SBVgFftjG6
        56oOjoR1fgG21W49Mhv4r+R+2ShyPbYOg3Wy51gQSzAF8t48S5kggWo+fYKo224fSmivDpITjUC
        cJbwUdCqjmvRZsCibh/Ee1+j31LDD0Z9DpowR386IXuDXZfUuEG/f6OZHZg==
X-Received: by 2002:a81:a9c8:0:b0:52e:e8b1:d51e with SMTP id g191-20020a81a9c8000000b0052ee8b1d51emr7465363ywh.1.1678121076341;
        Mon, 06 Mar 2023 08:44:36 -0800 (PST)
X-Google-Smtp-Source: AK7set9t9XdHrJtxVtH0ONr/3NYE6bRrCkF4ZonnKvX7muAawmENQQ11spvKR6dxbZNlzl+jdmOZ61w3k/mqwDTQT0c=
X-Received: by 2002:a81:a9c8:0:b0:52e:e8b1:d51e with SMTP id
 g191-20020a81a9c8000000b0052ee8b1d51emr7465342ywh.1.1678121076070; Mon, 06
 Mar 2023 08:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com> <CAJfpegvQyD-+EL2DdVWmyKF8odYWj4kAONyRf6VH_h4JCTu=vg@mail.gmail.com>
In-Reply-To: <CAJfpegvQyD-+EL2DdVWmyKF8odYWj4kAONyRf6VH_h4JCTu=vg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 6 Mar 2023 17:44:25 +0100
Message-ID: <CAEivzxdX28JhA+DY92nTGn56kmMgdeT9WX__j7NU3QHpg+wcdQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     mszeredi@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org, flyingpeng@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 5:15=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Mon, 20 Feb 2023 at 20:38, Alexander Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > Hello everyone,
> >
> > It would be great to hear your comments regarding this proof-of-concept=
 Checkpoint/Restore API for FUSE.
> >
> > Support of FUSE C/R is a challenging task for CRIU [1]. Last year I've =
given a brief talk on LPC 2022
> > about how we handle files C/R in CRIU and which blockers we have for FU=
SE filesystems. [2]
> >
> > The main problem for CRIU is that we have to restore mount namespaces a=
nd memory mappings before the process tree.
> > It means that when CRIU is performing mount of fuse filesystem it can't=
 use the original FUSE daemon from the
> > restorable process tree, but instead use a "fake daemon".
> >
> > This leads to many other technical problems:
> > * "fake" daemon has to reply to FUSE_INIT request from the kernel and i=
nitialize fuse connection somehow.
> > This setup can be not consistent with the original daemon (protocol ver=
sion, daemon capabilities/settings
> > like no_open, no_flush, readahead, and so on).
> > * each fuse request has a unique ID. It could confuse userspace if this=
 unique ID sequence was reset.
> >
> > We can workaround some issues and implement fragile and limited support=
 of FUSE in CRIU but it doesn't make any sense, IMHO.
> > Btw, I've enumerated only CRIU restore-stage problems there. The dump s=
tage is another story...
> >
> > My proposal is not only about CRIU. The same interface can be useful fo=
r FUSE mounts recovery after daemon crashes.
> > LXC project uses LXCFS [3] as a procfs/cgroupfs/sysfs emulation layer f=
or containers. We are using a scheme when
> > one LXCFS daemon handles all the work for all the containers and we use=
 bindmounts to overmount particular
> > files/directories in procfs/cgroupfs/sysfs. If this single daemon crash=
es for some reason we are in trouble,
> > because we have to restart all the containers (fuse bindmounts become i=
nvalid after the crash).
> > The solution is fairly easy:
> > allow somehow to reinitialize the existing fuse connection and replace =
the daemon on the fly
> > This case is a little bit simpler than CRIU cause we don't need to care=
 about the previously opened files
> > and other stuff, we are only interested in mounts.
> >
> > Current PoC implementation was developed and tested with this "recovery=
 case".
> > Right now I only have LXCFS patched and have nothing for CRIU. But I wa=
nted to discuss this idea before going forward with CRIU.
>

Hi Miklos,

> Apparently all of the added mechanisms (REINIT, BM_REVAL, conn_gen)
> are crash recovery related, and not useful for C/R.  Why is this being
> advertised as a precursor for CRIU support?

It's because I'm doing this with CRIU in mind too, I think it's a good
way to make a universal interface
which can address not only the recovery case but also the C/R, cause
in some sense it's a close problem.
But of course, Checkpoint/Restore is a way more trickier. But before
doing all the work with CRIU PoC,
I wanted to consult with you and folks if there are any serious
objections to this interface/feature or, conversely,
if there is someone else who is interested in it.

Now about interfaces REINIT, BM_REVAL.

I think it will be useful for CRIU case, but probably I need to extend
it a little bit, as I mentioned earlier in the cover letter:
> >* "fake" daemon has to reply to FUSE_INIT request from the kernel and in=
itialize fuse connection somehow.
> > This setup can be not consistent with the original daemon (protocol ver=
sion, daemon capabilities/settings
> > like no_open, no_flush, readahead, and so on).

So, after the "fake" demon has done its job during CRIU restore, we
need to replace it with the actual demon from
the dumpee tree and performing REINIT looks like a sanner way.

The next point is that if we use REINIT during CRIU restore, then we
automatically need to have BM_REINIT too,
otherwise all restored bind mounts become invalid.

Conn generation is not a problem for CRIU if we are not exposing it to
the userspace. It's just a technical thing to distinguish
old and new inodes/struct file's.

>
> BTW here's some earlier attempt at partial recovery, which might be inter=
esting:
>
>   https://lore.kernel.org/all/CAPm50a+j8UL9g3UwpRsye5e+a=3DM0Hy7Tf1FdfwOr=
UUBWMyosNg@mail.gmail.com/

Oh, that's interesting. Thanks for mentioning this! And the most
interesting thing is that Peng Hao mentioned LXCFS as a use case :-)

Added Peng Hao to CC

Kind regards,
Alex

>
> Thanks,
> Miklos
