Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5670E49D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbjEWSZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbjEWSZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:25:47 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E4D120;
        Tue, 23 May 2023 11:25:37 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4392f532cdaso2764622137.3;
        Tue, 23 May 2023 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684866336; x=1687458336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDi0EUIF+xc//kmdFaxsPGdDVrHBBOXPVNcw7FtRbqk=;
        b=rv2cB8HbB9ut8R7MKZXeukWX44msdpuRltrNUIk6Q76XBMc78At3Kq3IbuHkRRa6/z
         iWK65yAuwSsOI8OIQTv+rG1Z8bdaju5opZh946ZoE5nahGgDJD2XqiL3WAqmJ6yZtZSZ
         ZdHtcAbARaedT51hBcSrB5rPSwfVPKD83HRYjRZUpPJ84K/1pL5nIRp3BtQ9/qZDlkE+
         tv36teekdfSNbs4Reb+qXVJAeorRHZVb59XSF19NWM0Tme3aC5OEWobCGrGJiCu+8zcR
         RgglftdqqZszYbLQ5tK0JQIISLN391T8b/nWRbNE8z9nHuvtW7BZfZAjGXLJWN8AlzTZ
         y3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684866336; x=1687458336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDi0EUIF+xc//kmdFaxsPGdDVrHBBOXPVNcw7FtRbqk=;
        b=AiG3Ql74CzHXx/w250cYDQnXQQkI/HjT8amUwY0I4I5ELg5KpCXmpX5dG3yluRz+G4
         RFtPZGBPMynQldQ0d/AJcw9+wC4CmkoZ5uiWimm4CflI1e0Jr8x7j4Bq1VYVxc3TCxP8
         5ANjDkeCKv2pALBO/OY5mjXWGGnBYjYud/dK7uLsjL2yQf18OCKD0xNEwZY+bP/42KXv
         bC1S7pnhJ466eOEpsinjlRyUFnJKYiCdAEL5de9YUxk+wbe4XubJVljZFK6Yh+RY0WQ8
         Mh3d1IUZ8Knquh8irb1/mFVWTUGNjP2i96vnrU1Chg1RLqmFOFoJvc/iljgIwuyrc00i
         rMyw==
X-Gm-Message-State: AC+VfDwh+LvEP4mcJsTfaYPIdd7d4qZWJHWQNnA2t4oS5AzEGTEpfLVx
        88L48POWusqoPgy7/4oxaWls268OKocoEWrB7hr/yKxRNOs=
X-Google-Smtp-Source: ACHHUZ73XBtW1dudeuf03KWzhzYn2RnEsBS2kNL9QFDRb8S6ThKHh5ydXVhRdPb8XaESJqOlyO6giiNxhs9tTl3sMuE=
X-Received: by 2002:a67:ed8d:0:b0:434:6d1f:9032 with SMTP id
 d13-20020a67ed8d000000b004346d1f9032mr4370411vsp.14.1684866336124; Tue, 23
 May 2023 11:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230511123213.722912-1-cgzones@googlemail.com>
 <6301fdfd0927df2b2fd7a4f2b384e477.paul@paul-moore.com> <CAHC9VhSSA04wzPFgx_Z4jf1gOdEO40hU-augjMqX1uGd-eHLQA@mail.gmail.com>
In-Reply-To: <CAHC9VhSSA04wzPFgx_Z4jf1gOdEO40hU-augjMqX1uGd-eHLQA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 23 May 2023 20:25:25 +0200
Message-ID: <CAJ2a_DeJhGcXBtVfuOp3xeUNxJyFR4QG-+5=4Q_38go+v6d9-A@mail.gmail.com>
Subject: Re: [PATCH] selinux: deprecated fs ocon
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023 at 22:18, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, May 18, 2023 at 1:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On May 11, 2023 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgzone=
s@googlemail.com> wrote:
> > >
> > > The object context type `fs`, not to be confused with the well used
> > > object context type `fscon`, was introduced in the initial git commit
> > > 1da177e4c3f4 ("Linux-2.6.12-rc2") but never actually used since.
> > >
> > > The paper "A Security Policy Configuration for the Security-Enhanced
> > > Linux" [1] mentions it under `7.2 File System Contexts` but also stat=
es:
> > >
> > >     Currently, this configuration is unused.
> > >
> > > The policy statement defining such object contexts is `fscon`, e.g.:
> > >
> > >     fscon 2 3 gen_context(system_u:object_r:conA_t,s0) gen_context(sy=
stem_u:object_r:conB_t,s0)
> > >
> > > It is not documented at selinuxproject.org or in the SELinux notebook
> > > and not supported by the Reference Policy buildsystem - the statement=
 is
> > > not properly sorted - and thus not used in the Reference or Fedora
> > > Policy.
> > >
> > > Print a warning message at policy load for each such object context:
> > >
> > >     SELinux:  void and deprecated fs ocon 02:03
> > >
> > > This topic was initially highlighted by Nicolas Iooss [2].
> > >
> > > [1]: https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELINUX=
-SECURITY-POLICY-CONFIGURATION-REPORT.PDF
> > > [2]: https://lore.kernel.org/selinux/CAJfZ7=3DmP2eJaq2BfO3y0VnwUJaY2c=
S2p=3DHZMN71z1pKjzaT0Eg@mail.gmail.com/
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  security/selinux/ss/policydb.c | 4 ++++
> > >  security/selinux/ss/policydb.h | 2 +-
> > >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > Thanks, this is a nice catch, although some minor suggestions below ...
> >
> > > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/pol=
icydb.c
> > > index 97c0074f9312..31b08b34c722 100644
> > > --- a/security/selinux/ss/policydb.c
> > > +++ b/security/selinux/ss/policydb.c
> > > @@ -2257,6 +2257,10 @@ static int ocontext_read(struct policydb *p, c=
onst struct policydb_compat_info *
> > >                               if (rc)
> > >                                       goto out;
> > >
> > > +                             if (i =3D=3D OCON_FS)
> > > +                                     pr_warn("SELinux:  void and dep=
recated fs ocon %s\n",
> > > +                                             c->u.name);
> >
> > Instead of having to check if 'i =3D=3D OCON_FS', why not simply put th=
e
> > pr_warn() call up in the OCON_FS case block on line ~2249 and let it
> > continue to fallthrough to the OCON_NETIF block?
>
> Bah, nevermind, you need to leave it here because of the 'c->u.name'
> in the pr_warn().  If you're okay with me adjusting the deprecation
> comment (below) during the merge I'll can merge this now ... ?

Yes, please feel free to adjust the inline comment.

>
> > >                               rc =3D context_read_and_validate(&c->co=
ntext[0], p, fp);
> > >                               if (rc)
> > >                                       goto out;
> > > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/pol=
icydb.h
> > > index ffc4e7bad205..39cd6222e1a8 100644
> > > --- a/security/selinux/ss/policydb.h
> > > +++ b/security/selinux/ss/policydb.h
> > > @@ -225,7 +225,7 @@ struct genfs {
> > >
> > >  /* object context array indices */
> > >  #define OCON_ISID    0 /* initial SIDs */
> > > -#define OCON_FS              1 /* unlabeled file systems */
> > > +#define OCON_FS              1 /* unlabeled file systems (deprecated=
 in 6.5) */
> >
> > Since you are likely re-spinning this (see above), I would just leave
> > it as "(deprecated)"; those that want to know where it was deprecated
> > can always check the git log/tags.
> >
> > >  #define OCON_PORT    2 /* TCP and UDP port numbers */
> > >  #define OCON_NETIF   3 /* network interfaces */
> > >  #define OCON_NODE    4 /* nodes */
> > > --
> > > 2.40.1
>
> --
> paul-moore.com
