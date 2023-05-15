Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68547031AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242424AbjEOPgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjEOPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:36:43 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23F8E76;
        Mon, 15 May 2023 08:36:39 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-780bb3b96dfso3166329241.1;
        Mon, 15 May 2023 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684164999; x=1686756999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA4IB1y/0zA40bbsz8gGHddRZ25VjnnWWTbn2H/aqFU=;
        b=M+VjooXbspHOdGryjikqnJPNfMW1o/WJYytdNIgKCQxfuIDv6BCOmUtqBwqqXcsEZ+
         1I2gvC2ub7+us0YcUjSmSR5szqma5hloRRVoDLqAS/saMMkTt5e4ZdGB5IykbiZgvEg6
         UmXYzF41a4OKko//hvor+B8cC5wp5RNJLG1u3sonpri7cfP5rSvAImDic3Fp6QyfbePp
         lyyPz3G1XrQAJDX2X7Efhikm38/vt2rRRkJsZW09dfJ5x0PnUwD3G7gOeV45P66o/TFo
         MPZ4/T82VfqnUrvs5Sxp5pGxcFH1r9mzUdDHOK9fi5F5nqa8gMetNonWqKTYj7GOEHT9
         x5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684164999; x=1686756999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA4IB1y/0zA40bbsz8gGHddRZ25VjnnWWTbn2H/aqFU=;
        b=NuN81jSGNsTVyuTVEbVLgLAUooVyWQurAwzgR9+mANdceO/GlW3O0KcryCMeRH8dtv
         fQbKFZDqQ4NmvfBATkf0HqMs5SlDbUNymfG3bYxCV3WKxiEo9l4U79J2eU6P8j7qOGa/
         UZdxf7o4+81U3GQj0opPm6GaiHM3i6nvzvJ0vBPauRp39umFf0M5IHAmzGT6u9Q+0yW3
         KUfCjMJrNS8nevNPCrCQyMp3NwpQ9+Nz1YmYmQyxulcr1DkoT/UYxC/eci7JQZVvTLnL
         WqsGVxMmpU1S6VP5OVhYG9FbJWZ7V443poRw24mP8HABTyjKIgXulVj5/aq9Q0QSCGSO
         tSig==
X-Gm-Message-State: AC+VfDx7FbPwWjq7kXmj/JjGP2le+I6y0WekagOT8U37mr+aj5Q3SHi6
        quyU6S2QtTmdIMHy+wIoSGvvpphVuy7pm/qMneY=
X-Google-Smtp-Source: ACHHUZ7itdLeyapob4qAQ0nuroHmFht5p+khb30x/+O/+ELM/R37OLqtyBvuTFAy/xoYTA00t3/QpXz0Eelli2G6C2c=
X-Received: by 2002:a67:eb06:0:b0:434:85e0:834c with SMTP id
 a6-20020a67eb06000000b0043485e0834cmr11143862vso.20.1684164998575; Mon, 15
 May 2023 08:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
 <20230515133629.1974610-2-chengzhihao1@huawei.com> <20230515-sprachen-zeltlager-6925dfbe19c1@brauner>
 <CAOQ4uxjo3rzdrjmbXr=SgJbrBf_EA-HpXH25LORo_vPY=q0jWQ@mail.gmail.com> <20230515-dulden-symmetrie-3b5d934478d4@brauner>
In-Reply-To: <20230515-dulden-symmetrie-3b5d934478d4@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 15 May 2023 18:36:27 +0300
Message-ID: <CAOQ4uxjageSA8G1UR=9KPCYm80=GFLrwVonEotjOf0tpZDBY+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ovl: ovl_permission: Fix null pointer dereference
 at realinode in rcu-walk mode
To:     Christian Brauner <brauner@kernel.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, May 15, 2023 at 6:16=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, May 15, 2023 at 05:58:55PM +0300, Amir Goldstein wrote:
> > On Mon, May 15, 2023 at 4:58=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Mon, May 15, 2023 at 09:36:28PM +0800, Zhihao Cheng wrote:
> > > > Following process:
> > > >           P1                     P2
> > > >  path_lookupat
> > > >   link_path_walk
> > > >    inode_permission
> > > >     ovl_permission
> > > >       ovl_i_path_real(inode, &realpath)
> > > >         path->dentry =3D ovl_i_dentry_upper(inode)
> > > >                           drop_cache
> > > >                          __dentry_kill(ovl_dentry)
> > > >                           iput(ovl_inode)
> > > >                            ovl_destroy_inode(ovl_inode)
> > > >                             dput(oi->__upperdentry)
> > > >                              dentry_kill(upperdentry)
> > > >                               dentry_unlink_inode
> > > >                                upperdentry->d_inode =3D NULL
> > > >       realinode =3D d_inode(realpath.dentry) // return NULL
> > > >       inode_permission(realinode)
> > > >        inode->i_sb  // NULL pointer dereference
> > > > , will trigger an null pointer dereference at realinode:
> > > >   [  335.664979] BUG: kernel NULL pointer dereference,
> > > >                  address: 0000000000000002
> > > >   [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
> > > >   [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
> > > >   [  335.678939] Call Trace:
> > > >   [  335.679165]  <TASK>
> > > >   [  335.679371]  ovl_permission+0xde/0x320
> > > >   [  335.679723]  inode_permission+0x15e/0x2c0
> > > >   [  335.680090]  link_path_walk+0x115/0x550
> > > >   [  335.680771]  path_lookupat.isra.0+0xb2/0x200
> > > >   [  335.681170]  filename_lookup+0xda/0x240
> > > >   [  335.681922]  vfs_statx+0xa6/0x1f0
> > > >   [  335.682233]  vfs_fstatat+0x7b/0xb0
> > > >
> > > > Fetch a reproducer in [Link].
> > > >
> > > > Add a new helper ovl_i_path_realinode() to get realpath and real in=
ode
> > > > after non-nullptr checking, use the helper to replace the current r=
ealpath
> > > > getting logic.
> > > >
> > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217405
> > > > Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
> > > > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > > > Suggested-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  fs/overlayfs/inode.c | 31 ++++++++++++++++++++++++-------
> > > >  1 file changed, 24 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > > > index 541cf3717fc2..cc3ef5a6666a 100644
> > > > --- a/fs/overlayfs/inode.c
> > > > +++ b/fs/overlayfs/inode.c
> > > > @@ -278,6 +278,26 @@ int ovl_getattr(struct mnt_idmap *idmap, const=
 struct path *path,
> > > >       return err;
> > > >  }
> > > >
> > > > +static inline int ovl_i_path_realinode(struct inode *inode,
> > > > +                                    struct path *realpath,
> > > > +                                    struct inode **realinode, int =
rcu)
> > > > +{
> > > > +     /* Careful in RCU walk mode */
> > > > +     ovl_i_path_real(inode, realpath);
> > > > +     if (!realpath->dentry) {
> > > > +             WARN_ON(!rcu);
> > > > +             return -ECHILD;
> > > > +     }
> > > > +
> > > > +     *realinode =3D d_inode(realpath->dentry);
> > > > +     if (!*realinode) {
> > > > +             WARN_ON(!rcu);
> > > > +             return -ECHILD;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > If you want to return the inode wouldn't it possibly make more sense =
to
> > > return the inode from the function directly? But not fuzzed. Maybe Am=
ir
> > > has a preference. As I said, I'm even fine with the original approach=
.
> >
> > Sorry for not reviewing v1, I was traveling, even though it is hard to =
use
> > this excuse when I was traveling with Christian who did review v1 :)
>
> Well, I did only do it this morning. :)
>
> >
> > >
> > > static inline struct inode *ovl_i_path_realinode(struct inode *inode,
> > >                                                  struct path *realpat=
h,
> > >                                                  int rcu)
> > > {
> > >         struct inode *realinode;
> > >
> > >         /* Careful in RCU walk mode */
> > >         ovl_i_path_real(inode, realpath);
> > >         if (!realpath->dentry) {
> > >                 WARN_ON(!rcu);
> > >                 return ERR_PTR(-ECHILD);
> > >         }
> > >
> > >         realinode =3D d_inode(realpath->dentry);
> > >         if (!realinode) {
> > >                 WARN_ON(!rcu);
> > >                 return ERR_PTR(-ECHILD);
> > >         }
> > >
> > >         return realinode;
> > > }
> > >
> >
> > I think this helper is over engineered ;-)
>
> Yes. As mentioned before, I would've been happy even with v1 that didn't
> have any helper.
>
> > The idea for a helper that returns inode is good,
> > but I see no reason to mix RCU walk in this helper
> > and don't even need a new helper (see untested patch below).
>
> Looks good to me too.
>
> >
> > Thanks,
> > Amir.
> >
> > ---
> > -void ovl_i_path_real(struct inode *inode, struct path *path)
> > +struct inode *ovl_i_path_real(struct inode *inode, struct path *path)
> >  {
> >         struct ovl_path *lowerpath =3D ovl_lowerpath(OVL_I_E(inode));
> >
> > @@ -342,6 +342,8 @@ void ovl_i_path_real(struct inode *inode, struct pa=
th *path)
> >         } else {
> >                 path->mnt =3D ovl_upper_mnt(OVL_FS(inode->i_sb));
> >         }
> > +
> > +       return path->dentry ? d_inode(path->dentry) : NULL;
> >  }
> >
> > @@ -295,8 +295,8 @@ int ovl_permission(struct mnt_idmap *idmap,
> >         int err;
> >
> >         /* Careful in RCU walk mode */
> > -       ovl_i_path_real(inode, &realpath);
> > -       if (!realpath.dentry) {
> > +       realinode =3D ovl_i_path_real(inode, &realpath);
> > +       if (!realpath.dentry || !realinode) {
> >                 WARN_ON(!(mask & MAY_NOT_BLOCK));
> >                 return -ECHILD;
> >         }
> > @@ -309,7 +309,6 @@ int ovl_permission(struct mnt_idmap *idmap,
> >
> >         if (err)
> >                 return err;
> >
> > -       realinode =3D d_inode(realpath.dentry);
> >         old_cred =3D ovl_override_creds(inode->i_sb);
>
> Btw, if the reproducer that Zhihao has posted in the bugzilla link:
>
> #!/bin/bash
>
> mkdir -p /root/tmp/merge /root/tmp/upper/dir /root/tmp/lower /root/tmp/wo=
rk
> touch /root/tmp/upper/dir/file
> chown freg:freg -R /root/tmp/upper/dir
> mount -t overlay none -oupperdir=3D/root/tmp/upper,lowerdir=3D/root/tmp/l=
ower,workdir=3D/root/tmp/work /root/tmp/merge
> ls /root/tmp/merge/dir/file &
> echo 3 > /proc/sys/vm/drop_caches
>
> is reliable we should add it to xfstests...

If only it was that easy to trigger this race.
Look at the debug kernel patch named 'diff' in bugzilla...

Thanks,
Amir.
