Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F06A5B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjB1PLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjB1PLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:11:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF12B211F6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:10:53 -0800 (PST)
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1995A3F176
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677597052;
        bh=iGAHJ0JLuNvbnqKl/1cEPPn6YFJL/3WCv0VTdp2dQuA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FzQ9vSEfNxkHlgOSbnk2lpXw+ApBkaITOX3w9sQyK/Iy9EQ2Q4TcdYkRcVDjS89/F
         rdhItn5W3LhAo989Mvjme9IqThixCIEDO2RRTxldSURUpG9f60iNTNB7Ce8GVon4sW
         JU0cyQOCT+PSkKt6NUDQxKk3XHb81a9Dfuu4KPlRbJLTpejTBs4Dp114Y/k5OSWHHl
         OOkhZmqKk/KYUCe8Uy9qL5xfJB3mdeQ7uMEmVl3UJLhiZDw4kwW/Um3vOrJ0JU1uVq
         wMSFapDNikL/XlIH3N2d4IjU5i4prNcG35m4rtqVge5DADXdlqllzPGQi+sq2HK2sk
         QxA05jbCSeDIg==
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-53700262a47so212497577b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGAHJ0JLuNvbnqKl/1cEPPn6YFJL/3WCv0VTdp2dQuA=;
        b=ooqkj14qxPDuwyQ3KZ9X8L8rPlYhg9mu8xiaqJVpj9O7/WClukfbwXvXqyYGXyCceS
         o9CdBLo6PSeWVFQJaojlNqKvddpfOB6G0IhXm/mF4eYYr4p7udeNWK0PY7dV65cIw0Lv
         vvDfdOJqhcDyRc7BiN+M4fdXVvGY4oS+wJv2Sb8Wi2e0z0QB/2NTA/YVLnS/h8gh/LIi
         xwzGGW+z4K529to7yX7Z/gYI1KgKPDXqWACdZO3zLF0/cQsXx4zYXD75AC0c73LJf3PO
         rPk6UM1aPLkFNmCaFZOXYd8XWQTWMJ8ybnOz7WS56R6GfJGUSId4jjnqPalhQzR5coUR
         Gflw==
X-Gm-Message-State: AO0yUKWf18kiBA8ITTDUJlV6dF4/IKhhA7o9OXB6HlZpzUUDY3mRhixo
        esUmSsLo94/kq7MVug6vVZTjrwwopycGclhw130FvN2IvjjJi7s3CYbvP2Ubo06Qiu0CjD6iSS6
        wq34kbNGeRRMcDq+c2uxbQo/fGTOZSfUJlKiEFO8DfxqOHhy73RcwRHFYTQ==
X-Received: by 2002:a25:860c:0:b0:a02:a3a6:78fa with SMTP id y12-20020a25860c000000b00a02a3a678famr698682ybk.12.1677597050773;
        Tue, 28 Feb 2023 07:10:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+xsTr9z9bxOpYkcq7buCX03KQic5pK+7KKsPc8GtOURrOJlVrceINFQHPFHUiKxL3gG5glmql8mlU41qgBO+g=
X-Received: by 2002:a25:860c:0:b0:a02:a3a6:78fa with SMTP id
 y12-20020a25860c000000b00a02a3a678famr698670ybk.12.1677597050546; Tue, 28 Feb
 2023 07:10:50 -0800 (PST)
MIME-Version: 1.0
References: <20230226201730.515449-1-aleksandr.mikhalitsyn@canonical.com>
 <Y/x8H4qCNsj4mEkA@unreal> <CAEivzxeorZoiE4VmJ45CoF4ZRoW3B+rkT0ufX7y1bxn510yzPQ@mail.gmail.com>
 <Y/z3OtIA+25GjjH2@unreal> <CAEivzxemz8SDr2_NAvgi6XdzA12d5_3ZOmJ=1FF8VMbaGLdVng@mail.gmail.com>
 <Y/4Tlu7q2gNbcExT@unreal>
In-Reply-To: <Y/4Tlu7q2gNbcExT@unreal>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 28 Feb 2023 16:10:38 +0100
Message-ID: <CAEivzxegPOS4NCEzvi_pZJqh=jDvLr61bQfmw4oQiBOuWddfJw@mail.gmail.com>
Subject: Re: [PATCH net-next] scm: fix MSG_CTRUNC setting condition for SO_PASSSEC
To:     Leon Romanovsky <leon@kernel.org>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
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

On Tue, Feb 28, 2023 at 3:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Feb 28, 2023 at 11:06:12AM +0100, Aleksandr Mikhalitsyn wrote:
> > On Mon, Feb 27, 2023 at 7:32=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Mon, Feb 27, 2023 at 10:55:04AM +0100, Aleksandr Mikhalitsyn wrote=
:
> > > > On Mon, Feb 27, 2023 at 10:47=E2=80=AFAM Leon Romanovsky <leon@kern=
el.org> wrote:
> > > > >
> > > > > On Sun, Feb 26, 2023 at 09:17:30PM +0100, Alexander Mikhalitsyn w=
rote:
> > > > > > Currently, we set MSG_CTRUNC flag is we have no
> > > > > > msg_control buffer provided and SO_PASSCRED is set
> > > > > > or if we have pending SCM_RIGHTS.
> > > > > >
> > > > > > For some reason we have no corresponding check for
> > > > > > SO_PASSSEC.
> > > > > >
> > > > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > > > Cc: Eric Dumazet <edumazet@google.com>
> > > > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > > > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@can=
onical.com>
> > > > > > ---
> > > > > >  include/net/scm.h | 13 ++++++++++++-
> > > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > >
> > > > > Is it a bugfix? If yes, it needs Fixes line.
> > > >
> > > > It's from 1da177e4c3 ("Linux-2.6.12-rc2") times :)
> > > > I wasn't sure that it's correct to put the "Fixes" tag on such an o=
ld
> > > > and big commit. Will do. Thanks!
> > > >
> > > > >
> > > > > >
> > > > > > diff --git a/include/net/scm.h b/include/net/scm.h
> > > > > > index 1ce365f4c256..585adc1346bd 100644
> > > > > > --- a/include/net/scm.h
> > > > > > +++ b/include/net/scm.h
> > > > > > @@ -105,16 +105,27 @@ static inline void scm_passec(struct sock=
et *sock, struct msghdr *msg, struct sc
> > > > > >               }
> > > > > >       }
> > > > > >  }
> > > > > > +
> > > > > > +static inline bool scm_has_secdata(struct socket *sock)
> > > > > > +{
> > > > > > +     return test_bit(SOCK_PASSSEC, &sock->flags);
> > > > > > +}
> > > > > >  #else
> > > > > >  static inline void scm_passec(struct socket *sock, struct msgh=
dr *msg, struct scm_cookie *scm)
> > > > > >  { }
> > > > > > +
> > > > > > +static inline bool scm_has_secdata(struct socket *sock)
> > > > > > +{
> > > > > > +     return false;
> > > > > > +}
> > > > > >  #endif /* CONFIG_SECURITY_NETWORK */
> > > > >
> > > > > There is no need in this ifdef, just test bit directly.
> > > >
> > > > The problem is that even if the kernel is compiled without
> > > > CONFIG_SECURITY_NETWORK
> > > > userspace can still set the SO_PASSSEC option. IMHO it's better not=
 to
> > > > set MSG_CTRUNC
> > > > if CONFIG_SECURITY_NETWORK is disabled, msg_control is not set but
> > > > SO_PASSSEC is enabled.
> > > > Because in this case SCM_SECURITY will never be sent. Please correc=
t
> > > > me if I'm wrong.
> > >
> > > I don't know enough in this area to say if it is wrong or not.
> > > My remark was due to the situation where user sets some bit which is
> > > going to be ignored silently. It will be much cleaner do not set it
> > > if CONFIG_SECURITY_NETWORK is disabled instead of masking its usage.
> >
> > Hi Leon,
> >
> > I agree with you, but IMHO then it looks more correct to return -EOPNOT=
SUPP on
> > setsockopt(fd, SO_PASSSEC, ...) if CONFIG_SECURITY_NETWORK is disabled.
> > But such a change may break things.
> >
> > Okay, anyway I'll wait until net-next will be opened and present a
> > patch with a more
> > detailed description and Fixes tag. Speaking about this problem with
> > CONFIG_SECURITY_NETWORK
> > if you insist that it will be more correct then I'm ready to fix it too=
.
>
> I won't insist on anything, most likely Eric will comment if you need to
> fix it.

Got it.

Thanks a lot for your attention to the patch!

Kind regards,
Alex

>
> Thanks
>
> >
> > Thanks,
> > Alex
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Kind regards,
> > > > Alex
> > > >
> > > > >
> > > > > >
> > > > > >  static __inline__ void scm_recv(struct socket *sock, struct ms=
ghdr *msg,
> > > > > >                               struct scm_cookie *scm, int flags=
)
> > > > > >  {
> > > > > >       if (!msg->msg_control) {
> > > > > > -             if (test_bit(SOCK_PASSCRED, &sock->flags) || scm-=
>fp)
> > > > > > +             if (test_bit(SOCK_PASSCRED, &sock->flags) || scm-=
>fp ||
> > > > > > +                 scm_has_secdata(sock))
> > > > > >                       msg->msg_flags |=3D MSG_CTRUNC;
> > > > > >               scm_destroy(scm);
> > > > > >               return;
> > > > > > --
> > > > > > 2.34.1
> > > > > >
