Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336C66B9119
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCNLHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjCNLHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:07:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8586690B69
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:07:22 -0700 (PDT)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8DDED3F591
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678792018;
        bh=k14yaOEAzliIFD8KZYv4oaFat34UVWC+PGIHdaYXwZM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Wd88tV56aZW7xxwdTWlvgLPR/BqawN4DQOGzZIEHyphLmJSmIy7iq0W2rtyGK1Aza
         B7nAbidj5IrFQ3cNzr9HmOB3zDE3LZzYvqYO5Hj6Iwnju35YoyfxGY9H8+jnIuNINO
         XMRrrvU0wrCxhIVYslmn5y4QHvAvzQ6bQRqeOOR4fZ9yXzE3qiEueWDjThQGuzYSFh
         WchiRu4mDUUkEjAtUtH/h9J1VIJXGdzOd8myzABHZc7oLBA4sgm8r4KeUO+xW6ZOHb
         +HrydkpfNlITsrBLD2GC+9zyM5RuJvzAnK/XlNhWEmwhE7+3JNilKHpjI5eGSW6Tqz
         bHQUbsV6bS/7g==
Received: by mail-yb1-f200.google.com with SMTP id d7-20020a25adc7000000b00953ffdfbe1aso16858949ybe.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678792017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k14yaOEAzliIFD8KZYv4oaFat34UVWC+PGIHdaYXwZM=;
        b=hNtC7rtaGdC6C1/+pJoxbIkTEcKEUPQSPQSVuCgiGnVuV7x98FvmNuZyIoior3iqS8
         kn+xoxG4ZagNTjTasSqIJtFQzaAOe8fn3oPxiSGL9iaYJLMjMY8ywenQkhFRtZOjql3r
         iwHqeB5tvsuRTHzvkJ7qp+aMYGkVlPAMdkNVmRhfGQr/R7uIAYd9BwjesdJwz7FbFhGS
         11d6jCry/SW7FAyp4pUD5o3d3NirDR0oncrce4jds7enV32yd49o1P7YcIC72BZDfrKC
         hWvAnUJQ/uyrjMNsHFuDcvC3TgrQKWqC/E7u+U7QooZHPBTTokgcrqa+joJTiCkL2nUQ
         4JvQ==
X-Gm-Message-State: AO0yUKWpmnvkoG7g/wGYlbqw0G7XzVGfazg0Yd2GQuu1imdR8aAjaop0
        hJ9ZBhmhqx68C2NokTHYnRgIFdv9+Pze99vkdBBEqZap3qUcG/KkA58K5gyaIvw8MyKxkBKMBKj
        9OjGJ1s7pZvRjiK+zVil7g7LsQGnBG5rwho7UkkYnJ4a4iepHzybd4NEejw==
X-Received: by 2002:a81:ac16:0:b0:541:6d4c:9276 with SMTP id k22-20020a81ac16000000b005416d4c9276mr7227845ywh.5.1678792017403;
        Tue, 14 Mar 2023 04:06:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set/ap6Yf7I4ORuPAe4AejZtf7377TRSsrnRb5EGLH7hoPGHDq0W8wPRWfaB0eoy1gwaffsme4UBkIpTVUoXQts8=
X-Received: by 2002:a81:ac16:0:b0:541:6d4c:9276 with SMTP id
 k22-20020a81ac16000000b005416d4c9276mr7227838ywh.5.1678792017213; Tue, 14 Mar
 2023 04:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230313113211.178010-1-aleksandr.mikhalitsyn@canonical.com>
 <CAEivzxf630y_kjVLNM4m1vfQxnwyOBK+0wiCLW1T+8miPVC5Fg@mail.gmail.com> <CAHC9VhT2-QJ6yRoAvbicg5n_NUZLpJ5YjNer4TcHwiaW2hq6FQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT2-QJ6yRoAvbicg5n_NUZLpJ5YjNer4TcHwiaW2hq6FQ@mail.gmail.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 14 Mar 2023 12:06:46 +0100
Message-ID: <CAEivzxcbp61xdDL6mfoMBu4t5C3auyDO_-ec7wHu0EbN=zh2WQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] scm: fix MSG_CTRUNC setting condition for SO_PASSSEC
To:     Paul Moore <paul@paul-moore.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 9:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Mar 13, 2023 at 7:40=E2=80=AFAM Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> >
> > +CC security subsystem folks
> >
> > On Mon, Mar 13, 2023 at 12:32=E2=80=AFPM Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > >
> > > Currently, kernel would set MSG_CTRUNC flag if msg_control buffer
> > > wasn't provided and SO_PASSCRED was set or if there was pending SCM_R=
IGHTS.
> > >
> > > For some reason we have no corresponding check for SO_PASSSEC.
> > >
> > > In the recvmsg(2) doc we have:
> > >        MSG_CTRUNC
> > >               indicates that some control data was discarded due to l=
ack
> > >               of space in the buffer for ancillary data.
> > >
> > > So, we need to set MSG_CTRUNC flag for all types of SCM.
> > >
> > > This change can break applications those don't check MSG_CTRUNC flag.
>
> Unless I'm missing something I don't think this will actually result
> in a userspace visible change as put_cmsg() already has a number of
> checks which set the MSG_CTRUNC flag if necessary (including if no
> control buffer is passed, e.g. msg_control =3D=3D NULL).

Yes you are right. I found this check suspicious while working on
SCM_PIDFD (which is not yet submitted to LKML),
I think it is worth fixing that check anyway just for consistency reasons.

>
> Regardless, it looks fine to me.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks, Paul!

Regards,
Alex

>
> > > Cc: "David S. Miller" <davem@davemloft.net>
> > > Cc: Eric Dumazet <edumazet@google.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Paolo Abeni <pabeni@redhat.com>
> > > Cc: Leon Romanovsky <leon@kernel.org>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical=
.com>
> > >
> > > v2:
> > > - commit message was rewritten according to Eric's suggestion
> > > ---
> > >  include/net/scm.h | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/scm.h b/include/net/scm.h
> > > index 1ce365f4c256..585adc1346bd 100644
> > > --- a/include/net/scm.h
> > > +++ b/include/net/scm.h
> > > @@ -105,16 +105,27 @@ static inline void scm_passec(struct socket *so=
ck, struct msghdr *msg, struct sc
> > >                 }
> > >         }
> > >  }
> > > +
> > > +static inline bool scm_has_secdata(struct socket *sock)
> > > +{
> > > +       return test_bit(SOCK_PASSSEC, &sock->flags);
> > > +}
> > >  #else
> > >  static inline void scm_passec(struct socket *sock, struct msghdr *ms=
g, struct scm_cookie *scm)
> > >  { }
> > > +
> > > +static inline bool scm_has_secdata(struct socket *sock)
> > > +{
> > > +       return false;
> > > +}
> > >  #endif /* CONFIG_SECURITY_NETWORK */
> > >
> > >  static __inline__ void scm_recv(struct socket *sock, struct msghdr *=
msg,
> > >                                 struct scm_cookie *scm, int flags)
> > >  {
> > >         if (!msg->msg_control) {
> > > -               if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
> > > +               if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp =
||
> > > +                   scm_has_secdata(sock))
> > >                         msg->msg_flags |=3D MSG_CTRUNC;
> > >                 scm_destroy(scm);
> > >                 return;
> > > --
> > > 2.34.1
>
> --
> paul-moore.com
