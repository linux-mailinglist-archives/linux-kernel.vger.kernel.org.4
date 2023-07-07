Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF28E74B320
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjGGOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjGGOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:35:12 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2936F1FE6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:35:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-579ed2829a8so25075147b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1688740509; x=1691332509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3byNldQYPIXJHmP2gWtnYb97CCpo9o+8rBL4rOGmYI=;
        b=O+sNIMFB87eFKv59KzF3dXdq0akAoOhXxAYsi4up1srWeaMLB3uPvj4RXV1KolJ7J1
         SJ8TnlN6tOOt5IxKn6+QSbfvdVUP2pEx0kK+QtCM3hyO948Vq6sgwkHQfwTpwjkHp8OI
         kTOW/kHq3hukeFIKa8rciOZa7Z1EmENtgr7Z4zERYBUzd/rkYE+S0pgRgQdPolxeZIbI
         ZHjpsm+KzGotamfgtTJPCujYCr4NajLOq11slLTWRC5Wr6wUjlj/r1pNurMweaD5lahD
         ScwzDxMszuEdmarj8a/iONZ4WrhqT5HzAq2Q8YKzk0lW25NyBriZB/GkNnOJwPkdfHVF
         y86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688740509; x=1691332509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3byNldQYPIXJHmP2gWtnYb97CCpo9o+8rBL4rOGmYI=;
        b=hIpXhhSSJpOkMHcN93eubgi2bXefeirwiAHoN3EL0x22TTUcZIDegwhsbjxw6DzSbw
         aQx7oI1M2Dw+DBrnSfWZpIaUXrs5TSHv7Jw6boOFrGfekUKRezdFLseAoOn6YiSGzERc
         AA51txsLObn2brH6/78NG/vOvlraxfi7CaGORv64p44hgjxDNyGMZVYEhAbf7aag4ZMg
         +qe6k9xm4Zx1eA5JMO5q9zw4GHJxclK09My1dai02cHrHF/6Wa02tE5uQ1tHny2SuAcA
         YieYduTPK7o3e7sXDqbsrTae6m5GglGwJF6GElXhXLAfnxW2O+kwFgT5d4+LcKnOh0yO
         h1lQ==
X-Gm-Message-State: ABy/qLbWa2r0hXGvTsrISBBKIMTtbq/RHJ4hQlsyeHkOCcX74RwJIorr
        02x9o2CVPcl4BLP/AwnwJUtmEjTJTeSoEftqcbEn
X-Google-Smtp-Source: APBJJlECD+Fxdi9BNOzrpj5Usym5F7Y7TYpZF1e7TZ1QWeJ63Ak8CgJ0g21u5oIhLC4SE/PlJ7VT/jXb2Tha32fhQ6Q=
X-Received: by 2002:a5b:40d:0:b0:c12:29ac:1d3b with SMTP id
 m13-20020a5b040d000000b00c1229ac1d3bmr4758615ybp.11.1688740509290; Fri, 07
 Jul 2023 07:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
 <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com> <8fd08063bc6b4325b9785052d02da9f2@huawei.com>
In-Reply-To: <8fd08063bc6b4325b9785052d02da9f2@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Jul 2023 10:34:58 -0400
Message-ID: <CAHC9VhQGWWQgA9DBpq+q4XQerbN0SXAB8RG94G8uMD0-J968xA@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "eparis@parisplace.org" <eparis@parisplace.org>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "nicolas.bouchinet@clip-os.org" <nicolas.bouchinet@clip-os.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 2:49=E2=80=AFAM Roberto Sassu <roberto.sassu@huawei.=
com> wrote:
> > From: Paul Moore [mailto:paul@paul-moore.com]
> > Sent: Friday, July 7, 2023 3:44 AM
> > On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > Currently, the LSM infrastructure supports only one LSM providing an =
xattr
> > > and EVM calculating the HMAC on that xattr, plus other inode metadata=
.
> > >
> > > Allow all LSMs to provide one or multiple xattrs, by extending the se=
curity
> > > blob reservation mechanism. Introduce the new lbs_xattr_count field o=
f the
> > > lsm_blob_sizes structure, so that each LSM can specify how many xattr=
s it
> > > needs, and the LSM infrastructure knows how many xattr slots it shoul=
d
> > > allocate.
> > >
> > > Modify the inode_init_security hook definition, by passing the full
> > > xattr array allocated in security_inode_init_security(), and the curr=
ent
> > > number of xattr slots in that array filled by LSMs. The first paramet=
er
> > > would allow EVM to access and calculate the HMAC on xattrs supplied b=
y
> > > other LSMs, the second to not leave gaps in the xattr array, when an =
LSM
> > > requested but did not provide xattrs (e.g. if it is not initialized).
> > >
> > > Introduce lsm_get_xattr_slot(), which LSMs can call as many times as =
the
> > > number specified in the lbs_xattr_count field of the lsm_blob_sizes
> > > structure. During each call, lsm_get_xattr_slot() increments the numb=
er of
> > > filled xattrs, so that at the next invocation it returns the next xat=
tr
> > > slot to fill.
> > >
> > > Cleanup security_inode_init_security(). Unify the !initxattrs and
> > > initxattrs case by simply not allocating the new_xattrs array in the
> > > former. Update the documentation to reflect the changes, and fix the
> > > description of the xattr name, as it is not allocated anymore.
> > >
> > > Adapt both SELinux and Smack to use the new definition of the
> > > inode_init_security hook, and to call lsm_get_xattr_slot() to obtain =
and
> > > fill the reserved slots in the xattr array.
> > >
> > > Move the xattr->name assignment after the xattr->value one, so that i=
t is
> > > done only in case of successful memory allocation.
> > >
> > > Finally, change the default return value of the inode_init_security h=
ook
> > > from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> > > conventions.
> > >
> > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archli=
nux/
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  6 +--
> > >  include/linux/lsm_hooks.h     | 20 ++++++++++
> > >  security/security.c           | 71 +++++++++++++++++++++++----------=
--
> > >  security/selinux/hooks.c      | 17 +++++----
> > >  security/smack/smack_lsm.c    | 25 ++++++------
> > >  5 files changed, 92 insertions(+), 47 deletions(-)
> >
> > Two *very* small suggestions below, but I can make those during the
> > merge if you are okay with that Roberto?
>
> Hi Paul
>
> yes, sure, I'm ok with them. Please make them during the merge.

Great, I'll queue this up for merging once the merge window closes.
I'll send confirmation once it's done but just a heads-up that things
might be a little delayed next week.

--=20
paul-moore.com
