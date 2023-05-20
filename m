Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0827670A8EC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjETP4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETP4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:56:00 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FC6F1;
        Sat, 20 May 2023 08:55:56 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-437db5afe3dso990988137.0;
        Sat, 20 May 2023 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684598155; x=1687190155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orJAHN5Xc8HN0mmq42o00+hRomyoGvyhMDm6onJN/eo=;
        b=iQzYkyOov4Q+XHkgUmrE30ov24bBU0s99EyM4UNnr+cgzIfPIZ9LCY1oke2o5cSaYo
         BLm9taYuD/T3IXMltTJ/7W17Zb2Se2qHhH4DSkLtM/Jbkugt84koxuk1rN+V5qj/kaSF
         cUiHD94YUyETz4u4WSj6VutbZleIq3E0vIg8YJxRJTnMhh8oO2owz2XyPiHwW+/pgS9N
         dZAibQzCJ7aTnfkh//YzKgMMJmTcgZWWdQSDCjfH9WtycAN4WJwF4OkgW3FYSx0egs9m
         d7Gt04zsrxNI6P9HsH7VMJzfioqwFUCJZmZ99CJ0gj4vUd8d+RL5Upmc4HeN+FnXGfqT
         By5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684598155; x=1687190155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orJAHN5Xc8HN0mmq42o00+hRomyoGvyhMDm6onJN/eo=;
        b=YjTKv6KD6euttWxovFayToHlj2G12P1mFJLrxrw3nWcm8/HMzd/q2siLTh4kvA/TOJ
         Da5eu3mekpfhwOIrUyDYRw3fjzq03kl8KO9oQK5eI8hdDdqRKccMQC3EQ3tT+1Cs06GL
         1qmnNrqFIq+m7bDZ+lJX7FjVU6LkOi5AwaNOpqzqPTD3bd1Uf9Mjcq9qNDZ4gjTS6cSn
         d5q4JSJhiVnoESetAVGPUnQysyfGUkuYaq2hORIINmXJLk4mf5YXZ9kjFsT27rtdChw+
         KAdc/6igG5fmthSceu8/btC6rFBW4PDa9vvPiHmhoKh3yreX/V2nEM4r8AgHlXV3H4EC
         vzRg==
X-Gm-Message-State: AC+VfDxUlbRtuaZav/oWjT8spP/sbrpnumBu1WpFFyEXVOKknoQWfEPZ
        lgUffm9iMjXhvx6JncNTCKRpiYXL4fPMgvlSsg0=
X-Google-Smtp-Source: ACHHUZ7cJg8BEZOSL1lL60NSEHp0A+DjlLLXE9ITv2L14LXSx1aWqqCTQQKQle4b/6vLuSN2Th5GyckBsiT9+elRI1c=
X-Received: by 2002:a05:6102:116:b0:435:5148:b0e4 with SMTP id
 z22-20020a056102011600b004355148b0e4mr997518vsq.7.1684598155445; Sat, 20 May
 2023 08:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230520120528.339680-1-andrea.righi@canonical.com>
 <CAOQ4uxjOgWDqufLcabkkPcxvFcrehzoDuO0d6kdJZuoiRBKStw@mail.gmail.com> <ZGjI8Hutt9JwuN/i@righiandr-XPS-13-7390>
In-Reply-To: <ZGjI8Hutt9JwuN/i@righiandr-XPS-13-7390>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 May 2023 18:55:44 +0300
Message-ID: <CAOQ4uxi9xJWYdQnjbx7Z8ZdtB8REvnCVdg0BonWdpK0DWi5Utw@mail.gmail.com>
Subject: Re: [PATCH] ovl: make consistent use of OVL_FS()
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, May 20, 2023 at 4:19=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> On Sat, May 20, 2023 at 03:33:32PM +0300, Amir Goldstein wrote:
> > On Sat, May 20, 2023 at 3:20=E2=80=AFPM Andrea Righi <andrea.righi@cano=
nical.com> wrote:
> ...
> > > @@ -97,6 +99,8 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap=
(struct ovl_fs *ofs)
> > >
> > >  static inline struct ovl_fs *OVL_FS(struct super_block *sb)
> > >  {
> > > +       /* Make sure OVL_FS() is always used with an overlayfs superb=
lock */
> > > +       BUG_ON(sb->s_magic !=3D OVERLAYFS_SUPER_MAGIC);
> >
> > 1. Adding new BUG_ON to kernel code is not acceptable - if anything
> >     you can add WARN_ON_ONCE()
>
> OK, but accessing a pointer to a struct ovl_fs that is not really a
> struct ovl_fs can potentially have nasty effects, even data corruption
> maybe? I'd rather crash the system now rather than experiencing random
> behaviors later...
>

What you would rather do does not matter here.
No new BUG_ON() is a rule set by Linus.
Yes, some people (security people mostly) will prefer to crash the system
over an "undefined" behavior later, but many non-security people would
much rather have some processes stuck or crash than losing access to
the entire system.
There is no one good answer, but it is Linus who gets to decide.

> > 2. If anything, you should check s_type =3D=3D s_ovl_fs_type, not s_mag=
ic
>
> Hm.. is there a fast way to determine when sb->s_type =3D=3D overlayfs?
> Using get_fs_type() here seems quite expensive and I'm not even sure if
> it's doable, is there a better way that I don't see?
>

Not sure what you mean.
This is what I meant:

+extern struct file_system_type ovl_fs_type;
+
 static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 {
+       WARN_ON_ONCE(sb->s_type !=3D &ovl_fs_type);
+
        return (struct ovl_fs *)sb->s_fs_info;
 }

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f97ad8b40dbb..0c1f9d1e9135 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2083,7 +2083,7 @@ static struct dentry *ovl_mount(struct
file_system_type *fs_type, int flags,
        return mount_nodev(fs_type, flags, raw_data, ovl_fill_super);
 }

-static struct file_system_type ovl_fs_type =3D {
+struct file_system_type ovl_fs_type =3D {
        .owner          =3D THIS_MODULE,
        .name           =3D "overlay",

> > 3. It is very unclear to me that this check has that much value and OVL=
_FS()
> >     macro is very commonly used inside internal helpers, so please add =
a
> >     "why" to your patch - why do you think that it is desired and/or va=
luable
> >     to fortify OVL_FS() like this?
>
> Sure, I can send a v2 explaining why I think this is needed. Basically I
> was debugging a custom overlayfs patch and after a while I realized that
> I was accessing the sb->s_fs_info of a real path (not an overlayfs sb),
> using OVL_FS() with a proper check would have saved a me a bunch of
> time.
>

I think if you add this extra pedantic check, it should be ifdefed with
some Kconfig for extra debugging.

Maybe you could add CONFIG_OVERLAY_FS_DEBUG like some
other fs have. I am not sure if fortifying OVL_FS() is worth it, but
maybe this config will gain more pedantics checks in the future.

It's really up to Miklos to decide if this is interesting for overlayfs.

Thanks,
Amir.
