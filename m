Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF16D4B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjDCOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjDCOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:52:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680FC29BC3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:51:48 -0700 (PDT)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7A163F209
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680533506;
        bh=XBz1zna37ysInm5qeEZxPeU0HrWb4OHRI+Pz2i9OGHc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EVMKtHfeo9w2BCyQ5NKlN4QMuQSsmvkucegdGs4VAB+Lu8g903ab6XduoqoICUR9P
         KgUR6izjsY74hSczmjI5Y7OdGHNOxNr1yFWWr7DtSzzCTfUjseKaLhcHlzVgc0tW9z
         U9Ue65+30/sCFF66ng1xQSjtCl4Q9Xwf8J/P9rz89QMMKDFrg6kNmZDrXzXrxhZxkT
         PqeZGM5Ns9QbPICMEoAFE2fKnyiFFU4MhA//fHHx0zFDpo8MKBjDPEyzJOa9IJ9cur
         eZTTiplpREu2lah9Ln2amewkzunnUSEXqmlg5bg6cSpiam6Twt2XF4A9AOZvmp63YO
         HwwwPlIEGkjEg==
Received: by mail-yb1-f198.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso28549219ybu.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBz1zna37ysInm5qeEZxPeU0HrWb4OHRI+Pz2i9OGHc=;
        b=CoRBogFhw5kBTRMRiPg7pQDhC+ECIKJqRWTnQiYgIyPUszEA3sENEKON1Cnpqz4cow
         P4RXeKvJ13OtPq4SUuEWSv1mZjqa3Qagryq4JDNW8GBQoweNqcUtL28GdUgrMz8rNkmV
         4zHEYE19iJfIOEyfNRT8I1nlbclqpJ6oEX8du3HUhBjGwBDUkDqjnI63BQPEAfAhWMWQ
         aeljISMnfF6oYoX2DcIKUHk8lHs1r66A6b6qRifiouM4UPDTXyLKub4pJFqHPWZtYYYP
         ubO7hNCRW3cZE4N/+P+eRhHUHC6dd+pMjcmtfSaSJix6iSj/mTPDT8cnk5h/759+Uq3f
         GtSw==
X-Gm-Message-State: AAQBX9coyHFIOQj3PSGIiG4jE7yMZ/lx0aO1WIe97B7yF1xn0a13wTtw
        cpXqNCJkpiHzdR0OQML1lli6mM1VliKKsfXJDfvAv3aNlJ7VVRRtTbOjbAYUQBTfSv7PS6Tnb9p
        8TcxukDWzFcynRG1rQS6CK7i5ytPMWPJXDljIH1/8mrcnPmQngzc7F4AAFw==
X-Received: by 2002:a25:d784:0:b0:b76:3b21:b1dc with SMTP id o126-20020a25d784000000b00b763b21b1dcmr11288519ybg.0.1680533505808;
        Mon, 03 Apr 2023 07:51:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350aqgVvrDZpj3W0dpqiva+R1snhDKUQ7qQHwf84isS5iLyZponbAZ23XQDzrn0oLSQL21JAYXzfwIO48DtPuJpY=
X-Received: by 2002:a25:d784:0:b0:b76:3b21:b1dc with SMTP id
 o126-20020a25d784000000b00b763b21b1dcmr11288511ybg.0.1680533505602; Mon, 03
 Apr 2023 07:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com>
 <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm> <CAEivzxf8HKs2FJwTohzGVcb0TRNy9QJbEALC3dni3zx+tOb9Gg@mail.gmail.com>
In-Reply-To: <CAEivzxf8HKs2FJwTohzGVcb0TRNy9QJbEALC3dni3zx+tOb9Gg@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 3 Apr 2023 16:51:34 +0200
Message-ID: <CAEivzxdjjJmwPaxe5miWPxun_ZCRt-wjuCCA2nzOWWyzZZUuOg@mail.gmail.com>
Subject: Re: [RFC PATCH 7/9] fuse: add fuse device ioctl(FUSE_DEV_IOC_REINIT)
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 3:09=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Fri, Mar 3, 2023 at 8:26=E2=80=AFPM Bernd Schubert
> <bernd.schubert@fastmail.fm> wrote:
> >
> >
> >
> > On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> > > This ioctl aborts fuse connection and then reinitializes it,
> > > sends FUSE_INIT request to allow a new userspace daemon
> > > to pick up the fuse connection.
> > >
> > > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: St=C3=83=C2=A9phane Graber <stgraber@ubuntu.com>
> > > Cc: Seth Forshee <sforshee@kernel.org>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Andrei Vagin <avagin@gmail.com>
> > > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: criu@openvz.org
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > > ---
> > >   fs/fuse/dev.c             | 132 +++++++++++++++++++++++++++++++++++=
+++
> > >   include/uapi/linux/fuse.h |   1 +
> > >   2 files changed, 133 insertions(+)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 737764c2295e..0f53ffd63957 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
> > >   }
> > >   EXPORT_SYMBOL_GPL(fuse_abort_conn);
> > >
> > > +static int fuse_reinit_conn(struct fuse_conn *fc)
> > > +{
> > > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > > +     struct fuse_dev *fud;
> > > +     unsigned int i;
> > > +
> > > +     if (fc->conn_gen + 1 < fc->conn_gen)
> > > +             return -EOVERFLOW;
> > > +
> > > +     fuse_abort_conn(fc);
> > > +     fuse_wait_aborted(fc);
> >
> > Shouldn't this also try to flush all data first?

Dear Bernd,

I've reviewed this place 2nd time and I'm not sure that we have to
perform any flushing there, because userspace daemon can be dead or
stuck.
Technically, if userspace knows that daemon is alive then it can call
fsync/sync before doing reinit.

What do you think about it?

Kind regards,
Alex

>
> I think we should. Thanks for pointing to that!
>
> I've read all your comments and I'll prepare -v2 series soon.
>
> Thanks a lot, Bernd!
>
> >
