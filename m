Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9306E7C51
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjDSOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjDSOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:22:27 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF77EC3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fe3cd445aso1095577b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681914145; x=1684506145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln9hR9i08xff/C0u8D2VYHEx4cj96IU5iSKUXpBT6XY=;
        b=TCL58DcQPHiHqVDFcIK1omNGsbWSDkNxdVS2XV5A+akXnMFMROJOMvg/SlN6dqt7qp
         2Z+BVbfc7bBqBHcxkF3Rho7MpJywq1QJKkd6Jf91AvH8MZuRVrEts1XLDbL1vojXPiWY
         7cba0t6/CyXH98UzJ0y++7Yic4YUyoTFm+/S7FfdePYHfBfMo21rH66SxuNXrexIdQWO
         XZxY6fspdQzYIzu4zWGGc7dfmGAKWwXKua3WGJfJplVhmHkdYeBdl979933qvRGN/COo
         aPM/F9p2QEmEfJRLRjHmhqD7juBtOO4O+eYprVdiWG7v/YrjYvLSnexgoLay2f4lPDv6
         Ecwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914145; x=1684506145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln9hR9i08xff/C0u8D2VYHEx4cj96IU5iSKUXpBT6XY=;
        b=Lp9i6UTHFXdOyvnpZ3ElDqV/hv2Kjv7bkWPg9Qja9VfDI1nX99rpDSIq3cYN1T67/F
         BODrp5UF6aLQ9eU8kkBfJp7UIEon42WiNCnSevmmONvQ4NvG2eaE9euYu8d1an9yKWn3
         Qqf/SD8bbZqVthU2DkL4iNYHn5fIZcN4ErjwuXd7d4hB0zbIWanfef8jYn1F2pULtH78
         A9bq7W0U1pByejVvUDrGU49Q46fjgA4BL0KdXkQGhAa92mLfNjXqy5TpG8EkIXxgcSn3
         29ZZSCk+aaTwIT4q4mFo1vSdn16Hjr7f4o7KWafXZKyJGGKU7TusJRsTVUGFZBVe9KwT
         njBw==
X-Gm-Message-State: AAQBX9ff58FSJQLbQvfaaM4wG9FFYcuks8ERH0v/k9mmAJw2F1SD4fov
        yFGaZJssObc0gpc9TPSsgrbbnYy6McWiUaLS+3rb
X-Google-Smtp-Source: AKy350Y4ZWJAKz0XCiTiqS2bQifETNOMRdhLScT7VHvtdEdYOAH554GSiMIx+XymlgkO7YxYIEVbQjLKLmBaiitEI0w=
X-Received: by 2002:a0d:d4c3:0:b0:54f:8636:2152 with SMTP id
 w186-20020a0dd4c3000000b0054f86362152mr2771194ywd.15.1681914144985; Wed, 19
 Apr 2023 07:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230411155921.14716-1-casey@schaufler-ca.com>
 <20230411155921.14716-5-casey@schaufler-ca.com> <CAHC9VhQHxEzv9bQJQzTiSQZvGiMO86+HizRtaR=2LW=KwsDvfg@mail.gmail.com>
 <5f7ee090-1708-c5ac-d194-1cc5c69487a6@schaufler-ca.com>
In-Reply-To: <5f7ee090-1708-c5ac-d194-1cc5c69487a6@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Apr 2023 10:22:14 -0400
Message-ID: <CAHC9VhQcRq0i==tXcNDaLH-6cpO8HH7F8UE=GdhtK-6jwRjuXQ@mail.gmail.com>
Subject: Re: [PATCH v8 04/11] LSM: syscalls for current process attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 6:34=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 4/18/2023 2:49 PM, Paul Moore wrote:
> > On Tue, Apr 11, 2023 at 12:01=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> Create a system call lsm_get_self_attr() to provide the security
> >> module maintained attributes of the current process.
> >> Create a system call lsm_set_self_attr() to set a security
> >> module maintained attribute of the current process.
> >> Historically these attributes have been exposed to user space via
> >> entries in procfs under /proc/self/attr.
> >>
> >> The attribute value is provided in a lsm_ctx structure. The structure
> >> identifies the size of the attribute, and the attribute value. The for=
mat
> >> of the attribute value is defined by the security module. A flags fiel=
d
> >> is included for LSM specific information. It is currently unused and m=
ust
> >> be 0. The total size of the data, including the lsm_ctx structure and =
any
> >> padding, is maintained as well.
> >>
> >> struct lsm_ctx {
> >>         __u64   id;
> >>         __u64   flags;
> >>         __u64   len;
> >>         __u64   ctx_len;
> >>         __u8    ctx[];
> >> };
> >>
> >> Two new LSM hooks are used to interface with the LSMs.
> >> security_getselfattr() collects the lsm_ctx values from the
> >> LSMs that support the hook, accounting for space requirements.
> >> security_setselfattr() identifies which LSM the attribute is
> >> intended for and passes it along.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  Documentation/userspace-api/lsm.rst | 15 +++++
> >>  include/linux/lsm_hook_defs.h       |  4 ++
> >>  include/linux/lsm_hooks.h           |  9 +++
> >>  include/linux/security.h            | 19 ++++++
> >>  include/linux/syscalls.h            |  5 ++
> >>  include/uapi/linux/lsm.h            | 30 +++++++++
> >>  kernel/sys_ni.c                     |  4 ++
> >>  security/Makefile                   |  1 +
> >>  security/lsm_syscalls.c             | 55 ++++++++++++++++
> >>  security/security.c                 | 98 ++++++++++++++++++++++++++++=
+
> >>  10 files changed, 240 insertions(+)
> >>  create mode 100644 security/lsm_syscalls.c

...

> >> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> >> index f27c9a9cc376..b10dfab8a4d9 100644
> >> --- a/include/uapi/linux/lsm.h
> >> +++ b/include/uapi/linux/lsm.h
> >> @@ -9,6 +9,36 @@
> >> #ifndef _UAPI_LINUX_LSM_H
> >> #define _UAPI_LINUX_LSM_H
> >>
> >> +#include <linux/types.h>
> >> +#include <linux/unistd.h>
> >> +
> >> +/**
> >> + * struct lsm_ctx - LSM context information
> >> + * @id: the LSM id number, see LSM_ID_XXX
> >> + * @flags: LSM specific flags
> >> + * @len: length of the lsm_ctx struct, @ctx and any other data or pad=
ding
> >> + * @ctx_len: the size of @ctx
> >> + * @ctx: the LSM context value
> >> + *
> >> + * The @len field MUST be equal to the size of the lsm_ctx struct
> >> + * plus any additional padding and/or data placed after @ctx.
> >> + *
> >> + * In all cases @ctx_len MUST be equal to the length of @ctx.
> >> + * If @ctx is a string value it should be nul terminated with
> >> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
> >> + * supported.
> >> + *
> >> + * The @flags and @ctx fields SHOULD only be interpreted by the
> >> + * LSM specified by @id; they MUST be set to zero/0 when not used.
> >> + */
> >> +struct lsm_ctx {
> >> +       __u64   id;
> >> +       __u64   flags;
> >> +       __u64   len;
> >> +       __u64   ctx_len;
> >> +       __u8    ctx[];
> >> +};
> > Sorry, style nitpick since this needs to be respun anyway for the
> > syscalls.h fix at the very least ... I *really* dislike when variable
> > declarations, and field declarations in the case composite variables,
> > are aligned with the vertically neighboring declarations; just use a
> > single space please:
>
> I'll do it, but the tab after type has been accepted for forever.
> As an aside, I pulled out my 1978 K&R to prove my point and discovered
> that it isn't consistent regarding this style.

Yeah, it's not a question of acceptance or rejection, it's a matter of
personal preference.  I guess one of the few perks of this job is that
I can occasionally ask people to write code in a style that makes me
happy :)

> >   struct lsm_ctx {
> >   <tab>__u64 id;
> >   <tab>__u64 flags;
> >   <tab>__u64 len;
> >   <tab>__u64 ctx_len;
> >   <tab>__u8 ctx[];
> >   }
> >
> >> diff --git a/security/security.c b/security/security.c
> >> index 38ca0e646cac..bfe9a1a426b2 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -2167,6 +2167,104 @@ void security_d_instantiate(struct dentry *den=
try, struct inode *inode)
> >>  }
> >>  EXPORT_SYMBOL(security_d_instantiate);
> >>
> >> +/**
> >> + * security_getselfattr - Read an LSM attribute of the current proces=
s.
> >> + * @attr: which attribute to return
> >> + * @ctx: the user-space destination for the information, or NULL
> >> + * @size: the size of space available to receive the data
> >> + * @flags: reserved for future use, must be 0
> >> + *
> >> + * Returns the number of attributes found on success, negative value
> >> + * on error. @size is reset to the total size of the data.
> >> + * If @size is insufficient to contain the data -E2BIG is returned.
> >> + */
> >> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx __u=
ser *ctx,
> >> +                        size_t __user *size, u32 __user flags)
> >> +{
> >> +       struct security_hook_list *hp;
> >> +       u8 __user *base =3D (u8 __user *)ctx;
> >> +       size_t total =3D 0;
> >> +       size_t entrysize;
> >> +       size_t left;
> >> +       bool toobig =3D false;
> >> +       int count =3D 0;
> >> +       int rc;
> >> +
> >> +       if (attr =3D=3D 0)
> >> +               return -EINVAL;
> >> +       if (flags)
> >> +               return -EINVAL;
> >
> > I like Micka=C3=ABl's idea of supporting a flag (LSM_FLG_SINGLE?) which
> > allows one to request a single LSM's attribute.
>
> I don't, but I'll incorporate it.

Thank you.

> >   I don't think that
> > support has to be part of this initial patchset, but I do think it
> > would be good to have it in the same PR that goes up to Linus during
> > the merge window.
>
> As this patch set is intended to be what goes to Linus (isn't it?)
> I'll put it in.

Yes, but it goes to Linus via the lsm/next branch, which will likely
contain other patches as well; one of these other patches could be a
LSM_FLG_SINGLE patch if you wanted to focus on what you have here and
leave that to someone else.  Either way, it all goes up to Linus in
one PR so I'm not too worried either way.

What I do want to avoid is shipping the initial support in version N,
and shipping LSM_FLG_SINGLE in release N+1.

--=20
paul-moore.com
