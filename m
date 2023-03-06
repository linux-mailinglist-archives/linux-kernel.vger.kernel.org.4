Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152196AC46F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjCFPJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCFPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:09:41 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D085822A24
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:09:25 -0800 (PST)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 528D03F22C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678111783;
        bh=f2v5CEMXX3gXYzLE99k6iR0CRvXpbrxSSolJwoueXz0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=gy4eaVoWe+pMUO0IEjp4ENz74sKrnlfW1KKUKCkiBP8exMDjBbACax3TtbhWOoGkH
         Elp2SxguW/r2WU6Dy9R8PscK2ZY/EkbwoNuWgITw2hMyt5EezifoY8MAZXQA/c3KyC
         4Gs7Ge1ZUVAjph9T1et97Mhv3HreJL8HpzUJg2cjcrzWMMeoNqJnp1GMC25NINkujJ
         6jOb3eeWOzD8WfHtAIxkHaCaddYjjDQZa/nObndMMGJyYKoiXDzgfOk+83Z23Wvrfo
         dMHmI8lRqMCuvt0dTLDnr3nM5yqmkqXbZqGtZPuIDjub/k3JbIoreNKrXxg+/3dGgE
         WHioAhdPIe5/A==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-536d63d17dbso104146657b3.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:09:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2v5CEMXX3gXYzLE99k6iR0CRvXpbrxSSolJwoueXz0=;
        b=y3qdbzarwOfPsYT8hn3HFhoLEKUxZ5wwiEchVs6qXzwP27/uhmlMGyuyAWxo6Jf31V
         ZaeZlvaMBLQrdOYjkweaLQBymthm+4XvGFHq40cAFDMnZJUBv26HIu6kei0j+ixr59U6
         dckeWxetq38KHO2oSJxLg65HDrCxg8BP6LtcZ6Gl8pfTNCGAjPqUDpohatUT5mfoG5Lz
         tSXIBFrhcbNpcCPEqCW+t/bnSqPrSFzpFta4GC2LJiwfz9Q5rFu4iMF9aoeVkLGZextO
         dNRDTYgm6StCbnOHWP8CO3FFi5ZUa65O5sKAPXvclvMs/32gSyyHQV1RqnYHGkvXrbux
         mXOw==
X-Gm-Message-State: AO0yUKVSC/5xs8FtjRSAmqlnOb9Ko72sppWT6jRpSw+w6FcF8dhVGtDV
        aazPiiDvUbwStcTd/Ym31pvZCmdVuNBzTKoRsv5Z3sQTzXcGBLCwdt7mU5jxTVmOKBY74toHhZr
        60PGeOtwdNnrUGYb+b6vLV2CIvUwpEkSe8FIiz7iG0M7GHz9VtfVzdU8mGw==
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id x18-20020a81af52000000b0052eb48f7349mr6964031ywj.6.1678111782228;
        Mon, 06 Mar 2023 06:09:42 -0800 (PST)
X-Google-Smtp-Source: AK7set/qGKtb7f/W60UbxpJV4lHpxUt88fYIdqGi3qnpEpEAIFHYbXk+SL7tIS3T0MF+znhipcG5v3sWI+bgGQWdtDc=
X-Received: by 2002:a81:af52:0:b0:52e:b48f:7349 with SMTP id
 x18-20020a81af52000000b0052eb48f7349mr6964020ywj.6.1678111782030; Mon, 06 Mar
 2023 06:09:42 -0800 (PST)
MIME-Version: 1.0
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
 <20230220193754.470330-8-aleksandr.mikhalitsyn@canonical.com> <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm>
In-Reply-To: <381a19bb-d17e-b48b-8259-6287dbe170df@fastmail.fm>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 6 Mar 2023 15:09:31 +0100
Message-ID: <CAEivzxf8HKs2FJwTohzGVcb0TRNy9QJbEALC3dni3zx+tOb9Gg@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 3, 2023 at 8:26=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/20/23 20:37, Alexander Mikhalitsyn wrote:
> > This ioctl aborts fuse connection and then reinitializes it,
> > sends FUSE_INIT request to allow a new userspace daemon
> > to pick up the fuse connection.
> >
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: St=C3=83=C2=A9phane Graber <stgraber@ubuntu.com>
> > Cc: Seth Forshee <sforshee@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Andrei Vagin <avagin@gmail.com>
> > Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: criu@openvz.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >   fs/fuse/dev.c             | 132 +++++++++++++++++++++++++++++++++++++=
+
> >   include/uapi/linux/fuse.h |   1 +
> >   2 files changed, 133 insertions(+)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 737764c2295e..0f53ffd63957 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2187,6 +2187,112 @@ void fuse_abort_conn(struct fuse_conn *fc)
> >   }
> >   EXPORT_SYMBOL_GPL(fuse_abort_conn);
> >
> > +static int fuse_reinit_conn(struct fuse_conn *fc)
> > +{
> > +     struct fuse_iqueue *fiq =3D &fc->iq;
> > +     struct fuse_dev *fud;
> > +     unsigned int i;
> > +
> > +     if (fc->conn_gen + 1 < fc->conn_gen)
> > +             return -EOVERFLOW;
> > +
> > +     fuse_abort_conn(fc);
> > +     fuse_wait_aborted(fc);
>
> Shouldn't this also try to flush all data first?

I think we should. Thanks for pointing to that!

I've read all your comments and I'll prepare -v2 series soon.

Thanks a lot, Bernd!

>
