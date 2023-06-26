Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B5873D7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjFZGbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFZGa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:30:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514DA8;
        Sun, 25 Jun 2023 23:30:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b698937f85so19164941fa.2;
        Sun, 25 Jun 2023 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687761056; x=1690353056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsS/Y7QmyuRKwcPesSfAtRaAvlPDwYzf4S/RVFkZS2k=;
        b=AUv0dawnnPS9PAdHVmpyXNX0hhxeRtDWrOUucdx87Ta02dyx/4aZ8tcs9yT5laXwXb
         5a03FI19bl04cv3thL5/WIUKobKR1DiwzkX/YSFxBNSU2toebc6XJi1fPABCugrvaTGO
         ElERi0IXOANQy1RQlBqJJWYMGoD2IoiaLN3p0fj4HG7TS/Uyh1MtnfvTjuhWWepSJ37v
         JUEPhvMkVUgXxUFJfjNR2LaG9NhAS8zIiiIcxJglt9txWXK5QsKVLDgsQMf4SQF86m16
         XUTJdo7AQksN2SfkwzDd4jNetolN4AMIlkeMnEeqkHlOLUP3kFnrP2Aaal8vQXDOCwzU
         WWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687761056; x=1690353056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsS/Y7QmyuRKwcPesSfAtRaAvlPDwYzf4S/RVFkZS2k=;
        b=CkzE4iiL2NvJhFctDHLDuObm5U+yC1QRaTsTlcavW6SeIMByQclXzDVaTzgnDBmw0+
         rXkK0freoK5hKGw/nkaxG7VCGUa+94VSyyL7itsTJLL4wdFdhbR2zHUsuanHcAcqGB78
         BhgKjcFcN76fcPpJXKcTjgY6pbf7J26vQlUzA0HoMnXumax4hfK26GRT7E/Jus118dXb
         ZWYYnPSIxJmFgnjRLdS3XIiAFrjG8Q5+LX5OOxMFMOsEkq84H6IOYPNI7CWisulzM/db
         PyJFk0s1CbElTDI2lwIMa2pMLJlavTaG2A21gI/KFmNIajN2MrsF5w1FNWsOxMa0aICc
         zfyA==
X-Gm-Message-State: AC+VfDwpgyatwT81X4qldCYUBjfPZpu5EUliegM3BAgmGZncibw6x2PN
        Ebe/aZ0EWrqceI7bRKSTIdziAJAwBiMcEOCfHmkRZb5BewLbyg==
X-Google-Smtp-Source: ACHHUZ4vHkyZEQ5KKhG/gx0bkJclkNpFmK54+JXMhdFKKqLJT9AznoiI8OHpW/fOHTzMNwE4MXZdZRMuIRAS2DisOh0=
X-Received: by 2002:a19:ca11:0:b0:4f8:bfb4:e4c4 with SMTP id
 a17-20020a19ca11000000b004f8bfb4e4c4mr10271331lfg.19.1687761055637; Sun, 25
 Jun 2023 23:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230623213406.5596-1-risbhat@amazon.com> <20230623213406.5596-4-risbhat@amazon.com>
 <CANT5p=o3KqnxfLEuJ+veVaK1EdYJapevP60oCSS76-UhuQ101w@mail.gmail.com> <2023062626-bless-cytoplast-a147@gregkh>
In-Reply-To: <2023062626-bless-cytoplast-a147@gregkh>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Mon, 26 Jun 2023 12:00:44 +0530
Message-ID: <CANT5p=pB9chz2CrWK0Znz-wp6-znFWJnCz6jHeCuUTt6GqUv-Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 3/5] cifs: Introduce helpers for finding TCP connection
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rishabh Bhatnagar <risbhat@amazon.com>, pc@cjr.nz,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 11:43=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jun 26, 2023 at 11:34:44AM +0530, Shyam Prasad N wrote:
> > On Sat, Jun 24, 2023 at 3:14=E2=80=AFAM Rishabh Bhatnagar <risbhat@amaz=
on.com> wrote:
> > >
> > > From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>
> > >
> > > commit 345c1a4a9e09dc5842b7bbb6728a77910db69c52 upstream.
> > >
> > > Add helpers for finding TCP connections that are good candidates for
> > > being used by DFS refresh worker.
> > >
> > > Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> > > Reviewed-by: Aurelien Aptel <aaptel@suse.com>
> > > Signed-off-by: Steve French <stfrench@microsoft.com>
> > > Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
> > > ---
> > >  fs/cifs/dfs_cache.c | 44 +++++++++++++++++++++++++++++++------------=
-
> > >  1 file changed, 31 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
> > > index 3ca65051b55c..31b3dc09e109 100644
> > > --- a/fs/cifs/dfs_cache.c
> > > +++ b/fs/cifs/dfs_cache.c
> > > @@ -1305,6 +1305,30 @@ static char *get_dfs_root(const char *path)
> > >         return npath;
> > >  }
> > >
> > > +static inline void put_tcp_server(struct TCP_Server_Info *server)
> > > +{
> > > +       cifs_put_tcp_session(server, 0);
> > > +}
> > > +
> > > +static struct TCP_Server_Info *get_tcp_server(struct smb_vol *vol)
> > > +{
> > > +       struct TCP_Server_Info *server;
> > > +
> > > +       server =3D cifs_find_tcp_session(vol);
> > > +       if (IS_ERR_OR_NULL(server))
> > > +               return NULL;
> > > +
> > > +       spin_lock(&GlobalMid_Lock);
> > > +       if (server->tcpStatus !=3D CifsGood) {
> > > +               spin_unlock(&GlobalMid_Lock);
> > > +               put_tcp_server(server);
> > > +               return NULL;
> > > +       }
> > > +       spin_unlock(&GlobalMid_Lock);
> >
> > We've moved away from using GlobalMid_Lock for anything other than MIDs=
.
> > Please use server->srv_lock instead.
>
> This is just a backport of a commit that showed up in the 5.6 release.
> It's not new development.
>
> thanks,
>
> greg k-h

Ah. I get it now.
Sorry for the confusion.

--=20
Regards,
Shyam
