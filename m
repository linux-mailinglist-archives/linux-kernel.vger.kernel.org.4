Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FCA70894F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjERUSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjERUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:18:22 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D827010CF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:18:20 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-561e5014336so18121697b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684441100; x=1687033100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT9t62V6Ng7zAzJOoOv8Omp/rmWX41+dyHJ3EkYyjTs=;
        b=UvYfhpIVnvt2TG2FBhPNupz8v8wmMjb+Y8gwjNSxEwf9KsJDSKtsVecFMrvgZO9g19
         VR+kBs2SfEQriq5GBs+0kWDwKH9vyzNhGpjUXdYReuT5CZGlC5VUM0owPTmWoW2Nl1qF
         ioggPgigCgmPDSEvzhoXfCYLd0/ODUNGMbznkbCyuu96JD+3Lb7iBgXbF8jHPFJgtgoT
         iK/XvR9VCexp534pXTTUtTZSKmZzQWEOY+kfs3J4YdrrZGYRYYa+lCnTIeWGuSiY/HKi
         gFd0GX27TAApjMknMfrCppRx106BhErdG/4EDlDNru1XKOhcSpuRXpXXXv2GwpEi88yg
         T/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684441100; x=1687033100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT9t62V6Ng7zAzJOoOv8Omp/rmWX41+dyHJ3EkYyjTs=;
        b=aDoTKdc8FHcz2kxhP5Dmzy2CTVZ9c31TRBbWlMmqNiMV8o7Bc9Gu0AWauCCx50r0VL
         FXihRsJ456b5UpK6ip/jOHC5Pr4zglVrg7b++MLNOSoG6P2eToY5dyWS0qtFHv+qC1Y8
         aD3eOoV9rF0Mfa5hXUXqcidJFyoz4evaH0gmR6r0vOKHajIEnXjY5MHxut4PDzTa6bJY
         pZVGjgBtezAa/0LB0SlDSZs2vcGL2AZ4zzfIF1Y5sOc4SnKhCcqjPK1WYtUj5tOVzUpz
         9D7TVVh4GL401nHSyGbqiMaQpDAzrFKhd7rF9ikEHeC/YXfLR/GiR049AHkjsnxVNtiP
         bfPA==
X-Gm-Message-State: AC+VfDyIUQ6NYWEzmQSten+mYcCb8in8fPazaoAj50pjMkhfU75W8eH6
        RQ7LZN0qGPq2QU9aDA66eAOFFBQ/0ZQAsyI/2fh/
X-Google-Smtp-Source: ACHHUZ5kqEcrFMzgs1IizDsrp297c/mz4qZ+Tcc3WrLuNQoy0GHcwcv9vxWknXnTtkZJar+k9ytS2C9NEkslq9O5lg4=
X-Received: by 2002:a0d:d40f:0:b0:561:cb5c:17ac with SMTP id
 w15-20020a0dd40f000000b00561cb5c17acmr2511962ywd.27.1684441099971; Thu, 18
 May 2023 13:18:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230511123213.722912-1-cgzones@googlemail.com> <6301fdfd0927df2b2fd7a4f2b384e477.paul@paul-moore.com>
In-Reply-To: <6301fdfd0927df2b2fd7a4f2b384e477.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 May 2023 16:18:09 -0400
Message-ID: <CAHC9VhSSA04wzPFgx_Z4jf1gOdEO40hU-augjMqX1uGd-eHLQA@mail.gmail.com>
Subject: Re: [PATCH] selinux: deprecated fs ocon
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 1:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On May 11, 2023 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgzones@=
googlemail.com> wrote:
> >
> > The object context type `fs`, not to be confused with the well used
> > object context type `fscon`, was introduced in the initial git commit
> > 1da177e4c3f4 ("Linux-2.6.12-rc2") but never actually used since.
> >
> > The paper "A Security Policy Configuration for the Security-Enhanced
> > Linux" [1] mentions it under `7.2 File System Contexts` but also states=
:
> >
> >     Currently, this configuration is unused.
> >
> > The policy statement defining such object contexts is `fscon`, e.g.:
> >
> >     fscon 2 3 gen_context(system_u:object_r:conA_t,s0) gen_context(syst=
em_u:object_r:conB_t,s0)
> >
> > It is not documented at selinuxproject.org or in the SELinux notebook
> > and not supported by the Reference Policy buildsystem - the statement i=
s
> > not properly sorted - and thus not used in the Reference or Fedora
> > Policy.
> >
> > Print a warning message at policy load for each such object context:
> >
> >     SELinux:  void and deprecated fs ocon 02:03
> >
> > This topic was initially highlighted by Nicolas Iooss [2].
> >
> > [1]: https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELINUX-S=
ECURITY-POLICY-CONFIGURATION-REPORT.PDF
> > [2]: https://lore.kernel.org/selinux/CAJfZ7=3DmP2eJaq2BfO3y0VnwUJaY2cS2=
p=3DHZMN71z1pKjzaT0Eg@mail.gmail.com/
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/ss/policydb.c | 4 ++++
> >  security/selinux/ss/policydb.h | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
>
> Thanks, this is a nice catch, although some minor suggestions below ...
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 97c0074f9312..31b08b34c722 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -2257,6 +2257,10 @@ static int ocontext_read(struct policydb *p, con=
st struct policydb_compat_info *
> >                               if (rc)
> >                                       goto out;
> >
> > +                             if (i =3D=3D OCON_FS)
> > +                                     pr_warn("SELinux:  void and depre=
cated fs ocon %s\n",
> > +                                             c->u.name);
>
> Instead of having to check if 'i =3D=3D OCON_FS', why not simply put the
> pr_warn() call up in the OCON_FS case block on line ~2249 and let it
> continue to fallthrough to the OCON_NETIF block?

Bah, nevermind, you need to leave it here because of the 'c->u.name'
in the pr_warn().  If you're okay with me adjusting the deprecation
comment (below) during the merge I'll can merge this now ... ?

> >                               rc =3D context_read_and_validate(&c->cont=
ext[0], p, fp);
> >                               if (rc)
> >                                       goto out;
> > diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/polic=
ydb.h
> > index ffc4e7bad205..39cd6222e1a8 100644
> > --- a/security/selinux/ss/policydb.h
> > +++ b/security/selinux/ss/policydb.h
> > @@ -225,7 +225,7 @@ struct genfs {
> >
> >  /* object context array indices */
> >  #define OCON_ISID    0 /* initial SIDs */
> > -#define OCON_FS              1 /* unlabeled file systems */
> > +#define OCON_FS              1 /* unlabeled file systems (deprecated i=
n 6.5) */
>
> Since you are likely re-spinning this (see above), I would just leave
> it as "(deprecated)"; those that want to know where it was deprecated
> can always check the git log/tags.
>
> >  #define OCON_PORT    2 /* TCP and UDP port numbers */
> >  #define OCON_NETIF   3 /* network interfaces */
> >  #define OCON_NODE    4 /* nodes */
> > --
> > 2.40.1

--=20
paul-moore.com
