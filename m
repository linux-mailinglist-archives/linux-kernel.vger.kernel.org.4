Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874A6CB172
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC0WJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC0WJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:09:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3300F92
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:09:06 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id p204so12647422ybc.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1679954945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1TlEx9QcMlZ3oxOM4oU1Tjm4fqebLyU8FiZyh0BXvM=;
        b=dzZ5GnLfxajxluUn1Wgqto69XQEs0T5twz6tH0cdJgbBZA18HmrgoGc2ZFBdNysrXl
         CVLhhQyoi+aP7DZLK85nej99NJcgbHf/IVD1NtpajWTfOzScvF8uIn9tgUAQCs1lJTpH
         dAsemve+hswahlWABBR1/Y64GHOugX7L0RzkGmtm7a4+L+vXAA06FZYIhiqRSdcvOMlF
         fb3l/g5zzVqJsntJ5hlUZ3Flp0PBRz/WCR38IlB4MqkhNx0MeCHb0cnAa0pH+tblYQao
         saebexvbkiMxAZOYjWK4pgYXAe4SRaMB6jFzHA0OBVwuzmLFaiOL9Gck/6KqOqNZjCul
         /Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679954945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1TlEx9QcMlZ3oxOM4oU1Tjm4fqebLyU8FiZyh0BXvM=;
        b=5Elc3Tcl+/smaAButh9W096aD1fGPFlQP+biXMiutb8UUAkW0HsHRPrku0ST/Vyrme
         He9ohS132VS9I97XX2NeD2zRzBMHFrMX+1Z4vEZue6osCZa0luAcMtSK4vLYDQh5RIKf
         2zThJ0XNNVk9GnXF5ocwsD0D3uE34dbr5HL0cqalqHgLTLWRtxmHnYI9mvP9MpKzVtz5
         Bl+S1mxb/0JT6Rk/bnKCwLBhueJXn5FU0mRuNsvDI0HWkyP5HSLk94GxM5mzVphbKJgH
         Y0bmxfm0GiEdY10zNSCnwcS2dCEPKdzMnMsVwhQg88U+ISO911Dt7XALT1m4G7lRhNW6
         fdLg==
X-Gm-Message-State: AAQBX9fgPVGK1h3o3NxhUqeBU/UE+Cd4rCbIqdxCCle2ZuerhaJqWFw4
        C+dn+u43Stll2iAtio+Lalp2QXxSFZnsNE7wqqrq
X-Google-Smtp-Source: AKy350bMvVWZnkoZOYCDPEgJHRPmMhgknNlVozqs7cmjsw9ew8biTuseHCkzRf8XygI+S3Uet4jaQ4Q85e3m+A8qbO0=
X-Received: by 2002:a05:6902:1586:b0:b76:ceb2:661b with SMTP id
 k6-20020a056902158600b00b76ceb2661bmr8278162ybu.3.1679954945367; Mon, 27 Mar
 2023 15:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de> <83763b78-453d-de21-9b48-1c226afa13a0@web.de>
 <57a97109-7a67-245b-8072-54aec3b5021d@web.de> <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR=yK72JXW3hJR+gUQtGCNpF0Bzk5RDzPZR0MunC84AUQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Mar 2023 18:08:54 -0400
Message-ID: <CAHC9VhREfdgiCji=uEeCrc4w1kPGfnWGKnJuUYKXwTApdneSjQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Adjust implementation of security_get_bools()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, selinux@vger.kernel.org,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Eric Paris <eparis@parisplace.org>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Ruiqi Gong <gongruiqi1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>,
        Ruiqi Gong <ruiqi.gong@qq.com>
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

On Mon, Mar 27, 2023 at 5:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, Mar 27, 2023 at 3:00=E2=80=AFAM Markus Elfring <Markus.Elfring@we=
b.de> wrote:
> > Date: Mon, 27 Mar 2023 08:50:56 +0200
> >
> > The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer che=
ck despite of
> > the detail in the implementation of the function =E2=80=9Csecurity_get_=
bools=E2=80=9D
> > that it was determined already that a corresponding variable contained
> > a null pointer because of a failed memory allocation.
> >
> > Thus perform the following adjustments:
> >
> > 1. Convert the statement =E2=80=9Cpolicydb =3D &policy->policydb;=E2=80=
=9D into
> >    a variable initialisation.
> >
> > 2. Replace the statement =E2=80=9Cgoto out;=E2=80=9D by =E2=80=9Creturn=
 -ENOMEM;=E2=80=9D.
> >
> > 3. Return zero directly at two places.
> >
> > 4. Omit the variable =E2=80=9Crc=E2=80=9D.
> >
> > 5. Use more appropriate labels instead.
> >
> > 6. Reorder the assignment targets for two kcalloc() calls.
> >
> > 7. Reorder jump targets at the end.
> >
> > 8. Assign a value element only after a name assignment succeeded.
> >
> > 9. Delete an extra pointer check which became unnecessary
> >    with this refactoring.
> >
> >
> > This issue was detected by using the Coccinelle software.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  security/selinux/ss/services.c | 52 ++++++++++++++--------------------
> >  1 file changed, 22 insertions(+), 30 deletions(-)
>
> Hmm, for some odd reason I don't see this patch in the SELinux mailing
> list archive or the patchwork; replying here without comment (that
> will come later) to make sure this hits the SELinux list.

For some reason the generated diff below is pretty messy, so I'm just
going to put some of my comments here:

Given the fairly extensive refactoring here, and the frequency with
which @len, @names, and @values are used in the function, I might
simply create local variables for each and only assign them to the
parameter pointers at the end when everything completes successfully
(you could still reset @len at the start if you wanted).  If nothing
else it will make the function easier to read, and I think it will
simplify the code a bit too.

I would probably also keep the combined @names/@values cleanup under
one jump label; this function isn't complicated enough to warrant that
many jump labels for error conditions.

> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index f14d1ffe54c5..702282954bf9 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2964,53 +2964,45 @@ int security_fs_use(struct super_block *sb)
> >  int security_get_bools(struct selinux_policy *policy,
> >                        u32 *len, char ***names, int **values)
> >  {
> > -       struct policydb *policydb;
> > +       struct policydb *policydb =3D &policy->policydb;
> >         u32 i;
> > -       int rc;
> > -
> > -       policydb =3D &policy->policydb;
> >
> >         *names =3D NULL;
> >         *values =3D NULL;
> > -
> > -       rc =3D 0;
> >         *len =3D policydb->p_bools.nprim;
> >         if (!*len)
> > -               goto out;
> > -
> > -       rc =3D -ENOMEM;
> > -       *names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
> > -       if (!*names)
> > -               goto err;
> > +               return 0;
> >
> > -       rc =3D -ENOMEM;
> >         *values =3D kcalloc(*len, sizeof(int), GFP_ATOMIC);
> >         if (!*values)
> > -               goto err;
> > +               goto reset_len;
> >
> > -       for (i =3D 0; i < *len; i++) {
> > -               (*values)[i] =3D policydb->bool_val_to_struct[i]->state=
;
> > +       *names =3D kcalloc(*len, sizeof(char *), GFP_ATOMIC);
> > +       if (!*names)
> > +               goto free_values;
> >
> > -               rc =3D -ENOMEM;
> > +       for (i =3D 0; i < *len; i++) {
> >                 (*names)[i] =3D kstrdup(sym_name(policydb, SYM_BOOLS, i=
),
> >                                       GFP_ATOMIC);
> >                 if (!(*names)[i])
> > -                       goto err;
> > -       }
> > -       rc =3D 0;
> > -out:
> > -       return rc;
> > -err:
> > -       if (*names) {
> > -               for (i =3D 0; i < *len; i++)
> > -                       kfree((*names)[i]);
> > -               kfree(*names);
> > +                       goto free_names;
> > +
> > +               (*values)[i] =3D policydb->bool_val_to_struct[i]->state=
;
> >         }
> > -       kfree(*values);
> > -       *len =3D 0;
> > +       return 0;
> > +
> > +free_names:
> > +       for (i =3D 0; i < *len; i++)
> > +               kfree((*names)[i]);
> > +
> > +       kfree(*names);
> >         *names =3D NULL;
> > +free_values:
> > +       kfree(*values);
> >         *values =3D NULL;
> > -       goto out;
> > +reset_len:
> > +       *len =3D 0;
> > +       return -ENOMEM;
> >  }
> >
> >
> > --
> > 2.40.0
>
> --
> paul-moore.com



--=20
paul-moore.com
