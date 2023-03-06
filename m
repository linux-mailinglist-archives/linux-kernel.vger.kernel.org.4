Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1116AC4BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCFPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCFPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:23:28 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FDC93CE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:23:21 -0800 (PST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAE1D412B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678111611;
        bh=/D42eMJZgZ7OPGoMocOPrjvW3/oUv+rveESzzqsiFAQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=O75vcd5vyCBldTNijDhLXyDmav5xujWaUGv++FTcI9X7+brodCNtJxub8ST+EnjT/
         /rF25degysems4Mx7dSXvWsVtJ6eFpThWtt7kwhwimSeRsv5MXTql5Z0TNS9enAdjB
         WazALxmnj8fxPyAHfpdir6NlwVpfLr3upNcHtkOChtKQgTykjq5MYa9fjx7TUjlnEa
         a8njKmXIltWZwkuDR6OXp94VX8r1OG8lyXXBwRtBR5sxf9AOBwuN0lMOyFujaAqYK4
         g8DH5PNj9vlTfPR4inU+z3FmzKWRILCgsaY/XhHc+IIauQnCvfN09k516zXgXHVrtQ
         25Qkku4ZxvlqA==
Received: by mail-yb1-f198.google.com with SMTP id n203-20020a25dad4000000b0091231592671so10535242ybf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/D42eMJZgZ7OPGoMocOPrjvW3/oUv+rveESzzqsiFAQ=;
        b=UxArGQ1Dbqj5mlkO5+hDm678Sa5fc/qOL2Ynou+m7D2PHBlQasB5vJun40qn3CVdbn
         oG6kIGzKEq/PnnB3wSENq1oSGzCwM2Deod3FAV+zb6H0nmQnwEfAJ8x+1RucdcCpIWyU
         34pnLz3hxUnI2XpbGHQObarT7PMhmCUQi5hE3iUi+vjZh32rbZKmsdXSUy+F/hTeiD4h
         Ool/SRVW9LfRlsk3k4V+3Ai6299lGf9IZ+x06cme7Dpv1DU3LpYt3di7F6kPR/AAWe3u
         AJcl1Jir01MyPi9qMkoMZpgSmvq/2W3X4LLAU2Zz3OkNBKBEejxux3JKVBVbPyRYg/oe
         gdPg==
X-Gm-Message-State: AO0yUKVC6gBn8X5gm5+J5ZeJ4fTAaCFjYloQHhm3kfGZYryW5jIQp4Ia
        ErZMHaIVUsEbXYwNZlB6VYrf0BJMlLYrHVomOiwg8FJwMDpkmTw7Y+iChcuKhVNm2mZbPiN3pmN
        dTW/xxsP/MowNi0QOKdU5q7N2ohd8Vf22aFxvfGZlNcWeTiFdZ/fiTL9gDg==
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id x18-20020a81af52000000b0052eb48f7349mr6956597ywj.6.1678111610473;
        Mon, 06 Mar 2023 06:06:50 -0800 (PST)
X-Google-Smtp-Source: AK7set9XJaE1ycvsX1GHyO29Ms+GXboiZHBdlTeNCSP7soxAAoIyIS6f8pksSgKASOAiWWiJ4Yip7LSQoVql6h000eA=
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id
 x18-20020a81af52000000b0052eb48f7349mr6956573ywj.6.1678111610184; Mon, 06 Mar
 2023 06:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com> <fc8d6066-a550-455c-c864-f418db3239a3@ddn.com>
In-Reply-To: <fc8d6066-a550-455c-c864-f418db3239a3@ddn.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 6 Mar 2023 15:06:39 +0100
Message-ID: <CAEivzxfk0pEUePi7r=sdy5jVjUpZD6okLmPH-twxvv4P2cm34A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     mszeredi@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
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

On Fri, Mar 3, 2023 at 8:43=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> w=
rote:
>
>
>
> On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
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
>

Hello, Bernd!

Thanks a lot for your attention/review to this patch series!

>
> I like your patches, small and easy to read :)

Glad to hear, thanks! ;-)

> So this basically fails all existing open files - our (future) needs go
> beyond that. I wonder if we can extend it later and re-init the new
> daemon with something like "fuse_queue_recall" - basically the opposite
> of fuse_queue_forget. Not sure if fuse can access the vfs dentry cache
> to know for which files that would need to be done - if not, it would
> need to do its own book-keeping.
>

I thought about this (problem with existing opened FDs) too, it's just
a first approach to the problem and as far as I mentioned I have no
CRIU-side implementation (so it's not tested with full
Checkpoint/Restore),
but it works well for "fuse reinitialization" (which is needed for
LXCFS and can be useful for other fuse filesystems).

I think we can easily extend this later if we come up with some
agreement about generic UAPI.

I hope that more people will react to this and post their opinions.

Kind regards,
Alex

>
> Thanks,
> Bernd
