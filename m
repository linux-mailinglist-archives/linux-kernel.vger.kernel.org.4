Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1913368FD14
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjBICZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBICZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:25:40 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380323C7A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:25:38 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so1259884lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 18:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BLMhakQIT48mGbHrdvPxdUIKakGtAAFrbhrtkAP1xIc=;
        b=NAuw8qmITfKbzgSAY21VWv7uWWfH8qzLzScXXCjfhcuNIlrl9EqTGg4Wh7knFgg/3h
         mhlJbw3wsvlQQD3Bg/BBQbuwmG6UFljokJ70KU0ULTVnR6IjlT9KCfmQMgIfGg7wEPOu
         z3BCRn0AEJPlgWrIvvbOnY3sIYMGtOFVxxtTML+ZbtwxxzS9a4v/3y058xHkObHJlgDW
         83ZdzIHbjjGHkUpc9NG4HNobv5LmofmRq6SLk7BvgI5zO69J0Bgl8hh4pEx2ipDbdfUn
         cEsxu6NGZuewYaiwOrzp2tpnZoxOVXyT5pyQTrxJMWzbYviD5pJGlvuChKh/vWcy0gKL
         5efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLMhakQIT48mGbHrdvPxdUIKakGtAAFrbhrtkAP1xIc=;
        b=uQVKBdZlzxQKcSBstx8e3W1WVQNkZDLx0qRhQOEi9VPQiaw3T5ixWPGXJm+w+vWC55
         mfFvlJSDv7EwhlY5r3GdTNMcmE5I2HIZPJcxv+xZI56FrgJDExn83G/GViwO3rv/0exN
         RQT8yzjcGGbtxPbav4nUtcabCs0t6VvLEnZOkz/EWIMjVMupM8/wpA/O50O7OP4M2BVQ
         4Yte0tjJJFGi7IQTXtL03OeHP9OJYRRG04QYP6jJOYUTw6YYVVr9x23juj0OFoyrVW1Z
         clBGwwrkWje5qqO2k3Tm4UZKn6wG/FKh05HnmIxs317jEoV5pDgXwOIDZxoNOa9c3Ifu
         fUsQ==
X-Gm-Message-State: AO0yUKVg5dCNUkDP8nrG2QCT4ZpVY4ZI/ZI/IvoSFxvUKWkXFicTv4Ai
        LVY5iyYb96N5iCcr8OkLkQSmMSQJ1c3fBQfNYHFyERzM5Hkh/A==
X-Google-Smtp-Source: AK7set+tR+Pcz4be1Z2RwNX+EtODsH6ZtIZ90H7521wMHix2MU+MxbvOK6lpRZgqnZpZBD4z1KCgHzehupj747EwbNU=
X-Received: by 2002:ac2:560a:0:b0:4da:fb89:fcc5 with SMTP id
 v10-20020ac2560a000000b004dafb89fcc5mr1469342lfd.192.1675909537133; Wed, 08
 Feb 2023 18:25:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675851111.git.chenfeiyang@loongson.cn> <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
 <CAAhV-H5AvXdpYok43xA+QNz+oDEkcmQDxRdGoZ6jWTApf9mDBw@mail.gmail.com>
In-Reply-To: <CAAhV-H5AvXdpYok43xA+QNz+oDEkcmQDxRdGoZ6jWTApf9mDBw@mail.gmail.com>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Thu, 9 Feb 2023 10:25:25 +0800
Message-ID: <CACWXhKnwez6oG4ErzsCe69N-cQp3Ymab=fEk798x6DyH311i-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tools/nolibc: Add statx() and make stat() rely on
 statx() when available
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     w@1wt.eu, paulmck@kernel.org,
        Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        jiaxun.yang@flygoat.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 at 19:00, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Feiyang,
>
> On Wed, Feb 8, 2023 at 6:18 PM <chris.chenfeiyang@gmail.com> wrote:
> >
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > loongarch and riscv32 only have statx(). arc, hexagon, nios2 and
> > openrisc have statx() and stat64() but not stat() or newstat().
> > Add statx() and make stat() rely on statx() to make them happy.
> Some bikesheddings, maybe it is better to use LoongArch here.
>

Hi, Huacai

Yes.

Thanks,
Feiyang

> Huacai
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > ---
> >  tools/include/nolibc/sys.h | 51 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
> > index c4818a9c8823..46b6b3bb3b4e 100644
> > --- a/tools/include/nolibc/sys.h
> > +++ b/tools/include/nolibc/sys.h
> > @@ -20,6 +20,7 @@
> >  #include <linux/time.h>
> >  #include <linux/auxvec.h>
> >  #include <linux/fcntl.h> // for O_* and AT_*
> > +#include <linux/stat.h>  // for statx()
> >
> >  #include "arch.h"
> >  #include "errno.h"
> > @@ -1048,12 +1049,61 @@ pid_t setsid(void)
> >         return ret;
> >  }
> >
> > +/*
> > + * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
> > + */
> > +
> > +static __attribute__((unused))
> > +int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> > +{
> > +       return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
> > +}
> > +
> > +static __attribute__((unused))
> > +int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> > +{
> > +       int ret = sys_statx(fd, path, flags, mask, buf);
> > +
> > +       if (ret < 0) {
> > +               SET_ERRNO(-ret);
> > +               ret = -1;
> > +       }
> > +       return ret;
> > +}
> >
> >  /*
> >   * int stat(const char *path, struct stat *buf);
> >   * Warning: the struct stat's layout is arch-dependent.
> >   */
> >
> > +#ifdef __NR_statx
> > +static __attribute__((unused))
> > +int sys_stat(const char *path, struct stat *buf)
> > +{
> > +       struct statx stat;
> > +       long ret;
> > +
> > +       ret = sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &stat);
> > +       buf->st_dev     = ((stat.stx_dev_minor & 0xff)
> > +                         | (stat.stx_dev_major << 8)
> > +                         | ((stat.stx_dev_minor & ~0xff) << 12));
> > +       buf->st_ino     = stat.stx_ino;
> > +       buf->st_mode    = stat.stx_mode;
> > +       buf->st_nlink   = stat.stx_nlink;
> > +       buf->st_uid     = stat.stx_uid;
> > +       buf->st_gid     = stat.stx_gid;
> > +       buf->st_rdev    = ((stat.stx_rdev_minor & 0xff)
> > +                         | (stat.stx_rdev_major << 8)
> > +                         | ((stat.stx_rdev_minor & ~0xff) << 12));
> > +       buf->st_size    = stat.stx_size;
> > +       buf->st_blksize = stat.stx_blksize;
> > +       buf->st_blocks  = stat.stx_blocks;
> > +       buf->st_atime   = stat.stx_atime.tv_sec;
> > +       buf->st_mtime   = stat.stx_mtime.tv_sec;
> > +       buf->st_ctime   = stat.stx_ctime.tv_sec;
> > +       return ret;
> > +}
> > +#else
> >  static __attribute__((unused))
> >  int sys_stat(const char *path, struct stat *buf)
> >  {
> > @@ -1083,6 +1133,7 @@ int sys_stat(const char *path, struct stat *buf)
> >         buf->st_ctime   = stat.st_ctime;
> >         return ret;
> >  }
> > +#endif /* __NR_statx */
> >
> >  static __attribute__((unused))
> >  int stat(const char *path, struct stat *buf)
> > --
> > 2.39.0
> >
