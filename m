Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038D704DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjEPMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjEPMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:35:23 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16FE109;
        Tue, 16 May 2023 05:35:21 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-43278f6d551so4605762137.1;
        Tue, 16 May 2023 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684240521; x=1686832521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXLd+qQmX0FsCgMXT8rvK+TSyI9E2USdcpb12MiG34w=;
        b=XG/GTw5mXgiuvUu2BmZcZJQFUmr/xcNaKds9BVGfiYyTRnjRj2DKvW5v4MdNx8yAEc
         ONZ+n+I2j/FReA/ONJPI3SsnPwWSi8qjFXsD7JX/81+a8IzVYqSH4giMfFHcCf8F8WYe
         7sQxruK6yqZvoT/ZEJzzznoK/zpDzUkgbFZYjDo1WsJmtTB+vW+c4bQvrBfS8nSj9xqN
         0YBR25wxliw5Tr67CI8lXt2qVjLJu5gTRFbYjGEh2Evjn3hO0img40Q0Wtymvkqd/GL6
         XczXHrVxg9f0PVwVqtX/MoEoCtwHCs8arGjeoZo6/BlvtO5Pv8ZuYMXVZPqKcHMZpTVN
         MF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240521; x=1686832521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXLd+qQmX0FsCgMXT8rvK+TSyI9E2USdcpb12MiG34w=;
        b=EwdjtuKSUu4RvA8R0OxUxJZQOvxhHu4CtJ2tdpehDL19EGKLsKG9EXV2GIggSwSWGi
         31vPD9L2Z8FhDGIRmMUGXWSD/m5WZhAQkhaR8dyMVmwcqbOhSDFztw5xx3892G8N3zr7
         nky+/3c8BIezxbTnJetdeSvN6FjqJI4Z0CVXd/RnZ+dKJdUP48WnmqpHdO0gDOEEe8NH
         s8arvH2xDBbbkC/qkV2iL/M4BVaWPYItPvq0J6h1UUYAxkr/yBGHOox8wWKS2AomD803
         QWzRxzWAVJaW3CGwqvoULP2lTGzQgiXTlQkMwCuah1QsdRLCSYnoNEgGzKeS0y1E3K3K
         +vHA==
X-Gm-Message-State: AC+VfDwqumda+5dMnlhKKvcupAvToVCCuY8PQkARhKAUQ6D3lwIjpDU/
        V55axV/Y9M6/tJ5GfZKI8QWgzqruYeXV5c+GCF8=
X-Google-Smtp-Source: ACHHUZ4H7g5AkqankTsyiYod+hQprVSptqqA4m1ZDBD4Nzy1PUMdg+1ojcDEOTlxo6pdFhPDSTFcDoFhGIx7XdVmDRo=
X-Received: by 2002:a67:f44b:0:b0:434:8401:beae with SMTP id
 r11-20020a67f44b000000b004348401beaemr14781316vsn.34.1684240520854; Tue, 16
 May 2023 05:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
 <20230515133629.1974610-2-chengzhihao1@huawei.com> <20230515-sprachen-zeltlager-6925dfbe19c1@brauner>
 <CAOQ4uxjo3rzdrjmbXr=SgJbrBf_EA-HpXH25LORo_vPY=q0jWQ@mail.gmail.com>
 <20230515-dulden-symmetrie-3b5d934478d4@brauner> <CAOQ4uxjageSA8G1UR=9KPCYm80=GFLrwVonEotjOf0tpZDBY+g@mail.gmail.com>
 <53e81e0a-a99c-9a2a-7691-04789e2a2710@huawei.com> <CAOQ4uxi9bhs0xKO-zCj-QiFzd-xZEp8DtG222vG-R6U5HBHcVg@mail.gmail.com>
 <06361c3e-9f78-6f44-9cd0-e39e1eb9c546@huawei.com>
In-Reply-To: <06361c3e-9f78-6f44-9cd0-e39e1eb9c546@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 15:35:09 +0300
Message-ID: <CAOQ4uxhOng=b3i9J5TXLuQiCfYJS=c49L2RA2ikg4LR_Ans=ww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ovl: ovl_permission: Fix null pointer dereference
 at realinode in rcu-walk mode
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Christian Brauner <brauner@kernel.org>, miklos@szeredi.hu,
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

On Tue, May 16, 2023 at 3:27=E2=80=AFPM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
>
> =E5=9C=A8 2023/5/16 19:45, Amir Goldstein =E5=86=99=E9=81=93:
> > On Tue, May 16, 2023 at 4:16=E2=80=AFAM Zhihao Cheng <chengzhihao1@huaw=
ei.com> wrote:
> >>
> >> =E5=9C=A8 2023/5/15 23:36, Amir Goldstein =E5=86=99=E9=81=93:
> >>> On Mon, May 15, 2023 at 6:16=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>>
> >>>> On Mon, May 15, 2023 at 05:58:55PM +0300, Amir Goldstein wrote:
> >>>>> On Mon, May 15, 2023 at 4:58=E2=80=AFPM Christian Brauner <brauner@=
kernel.org> wrote:
> >>>>>>
> >>>>>> On Mon, May 15, 2023 at 09:36:28PM +0800, Zhihao Cheng wrote:
> >>>>>>> Following process:
> >>>>>>>             P1                     P2
> >>>>>>>    path_lookupat
> >>>>>>>     link_path_walk
> >>>>>>>      inode_permission
> >>>>>>>       ovl_permission
> >>>>>>>         ovl_i_path_real(inode, &realpath)
> >>>>>>>           path->dentry =3D ovl_i_dentry_upper(inode)
> >>>>>>>                             drop_cache
> >>>>>>>                            __dentry_kill(ovl_dentry)
> >>>>>>>                             iput(ovl_inode)
> >>>>>>>                              ovl_destroy_inode(ovl_inode)
> >>>>>>>                               dput(oi->__upperdentry)
> >>>>>>>                                dentry_kill(upperdentry)
> >>>>>>>                                 dentry_unlink_inode
> >>>>>>>                                  upperdentry->d_inode =3D NULL
> >>>>>>>         realinode =3D d_inode(realpath.dentry) // return NULL
> >>>>>>>         inode_permission(realinode)
> >>>>>>>          inode->i_sb  // NULL pointer dereference
> >>>>>>> , will trigger an null pointer dereference at realinode:
> >>>>>>>     [  335.664979] BUG: kernel NULL pointer dereference,
> >>>>>>>                    address: 0000000000000002
> >>>>>>>     [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
> >>>>>>>     [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
> >>>>>>>     [  335.678939] Call Trace:
> >>>>>>>     [  335.679165]  <TASK>
> >>>>>>>     [  335.679371]  ovl_permission+0xde/0x320
> >>>>>>>     [  335.679723]  inode_permission+0x15e/0x2c0
> >>>>>>>     [  335.680090]  link_path_walk+0x115/0x550
> >>>>>>>     [  335.680771]  path_lookupat.isra.0+0xb2/0x200
> >>>>>>>     [  335.681170]  filename_lookup+0xda/0x240
> >>>>>>>     [  335.681922]  vfs_statx+0xa6/0x1f0
> >>>>>>>     [  335.682233]  vfs_fstatat+0x7b/0xb0
> >>>>>>>
> >>>>>>> Fetch a reproducer in [Link].
> >>>>>>>
> >>>>>>> Add a new helper ovl_i_path_realinode() to get realpath and real =
inode
> >>>>>>> after non-nullptr checking, use the helper to replace the current=
 realpath
> >>>>>>> getting logic.
> >>>>>>>
> >>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217405
> >>>>>>> Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()"=
)
> >>>>>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> >>>>>>> Suggested-by: Christian Brauner <brauner@kernel.org>
> >>>>>>> ---
> >>>>>>>    fs/overlayfs/inode.c | 31 ++++++++++++++++++++++++-------
> >>>>>>>    1 file changed, 24 insertions(+), 7 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> >>>>>>> index 541cf3717fc2..cc3ef5a6666a 100644
> >>>>>>> --- a/fs/overlayfs/inode.c
> >>>>>>> +++ b/fs/overlayfs/inode.c
> >>>>>>> @@ -278,6 +278,26 @@ int ovl_getattr(struct mnt_idmap *idmap, con=
st struct path *path,
> >>>>>>>         return err;
> >>>>>>>    }
> >>>>>>>
> >>>>>>> +static inline int ovl_i_path_realinode(struct inode *inode,
> >>>>>>> +                                    struct path *realpath,
> >>>>>>> +                                    struct inode **realinode, in=
t rcu)
> >>>>>>> +{
> >>>>>>> +     /* Careful in RCU walk mode */
> >>>>>>> +     ovl_i_path_real(inode, realpath);
> >>>>>>> +     if (!realpath->dentry) {
> >>>>>>> +             WARN_ON(!rcu);
> >>>>>>> +             return -ECHILD;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     *realinode =3D d_inode(realpath->dentry);
> >>>>>>> +     if (!*realinode) {
> >>>>>>> +             WARN_ON(!rcu);
> >>>>>>> +             return -ECHILD;
> >>>>>>> +     }
> >>>>>>> +
> >>>>>>> +     return 0;
> >>>>>>> +}
> >>>>>>
> >>>>>> If you want to return the inode wouldn't it possibly make more sen=
se to
> >>>>>> return the inode from the function directly? But not fuzzed. Maybe=
 Amir
> >>>>>> has a preference. As I said, I'm even fine with the original appro=
ach.
> >>>>>
> >>>>> Sorry for not reviewing v1, I was traveling, even though it is hard=
 to use
> >>>>> this excuse when I was traveling with Christian who did review v1 :=
)
> >>>>
> >>>> Well, I did only do it this morning. :)
> >>>>
> >>>>>
> >>>>>>
> >>>>>> static inline struct inode *ovl_i_path_realinode(struct inode *ino=
de,
> >>>>>>                                                    struct path *re=
alpath,
> >>>>>>                                                    int rcu)
> >>>>>> {
> >>>>>>           struct inode *realinode;
> >>>>>>
> >>>>>>           /* Careful in RCU walk mode */
> >>>>>>           ovl_i_path_real(inode, realpath);
> >>>>>>           if (!realpath->dentry) {
> >>>>>>                   WARN_ON(!rcu);
> >>>>>>                   return ERR_PTR(-ECHILD);
> >>>>>>           }
> >>>>>>
> >>>>>>           realinode =3D d_inode(realpath->dentry);
> >>>>>>           if (!realinode) {
> >>>>>>                   WARN_ON(!rcu);
> >>>>>>                   return ERR_PTR(-ECHILD);
> >>>>>>           }
> >>>>>>
> >>>>>>           return realinode;
> >>>>>> }
> >>>>>>
> >>>>>
> >>>>> I think this helper is over engineered ;-)
> >>>>
> >>>> Yes. As mentioned before, I would've been happy even with v1 that di=
dn't
> >>>> have any helper.
> >>>>
> >>>>> The idea for a helper that returns inode is good,
> >>>>> but I see no reason to mix RCU walk in this helper
> >>>>> and don't even need a new helper (see untested patch below).
> >>>>
> >>>> Looks good to me too.
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Amir.
> >>>>>
> >>>>> ---
> >>>>> -void ovl_i_path_real(struct inode *inode, struct path *path)
> >>>>> +struct inode *ovl_i_path_real(struct inode *inode, struct path *pa=
th)
> >>>>>    {
> >>>>>           struct ovl_path *lowerpath =3D ovl_lowerpath(OVL_I_E(inod=
e));
> >>>>>
> >>>>> @@ -342,6 +342,8 @@ void ovl_i_path_real(struct inode *inode, struc=
t path *path)
> >>>>>           } else {
> >>>>>                   path->mnt =3D ovl_upper_mnt(OVL_FS(inode->i_sb));
> >>>>>           }
> >>>>> +
> >>>>> +       return path->dentry ? d_inode(path->dentry) : NULL;
> >>>>>    }
> >>>>>
> >>>>> @@ -295,8 +295,8 @@ int ovl_permission(struct mnt_idmap *idmap,
> >>>>>           int err;
> >>>>>
> >>>>>           /* Careful in RCU walk mode */
> >>>>> -       ovl_i_path_real(inode, &realpath);
> >>>>> -       if (!realpath.dentry) {
> >>>>> +       realinode =3D ovl_i_path_real(inode, &realpath);
> >>>>> +       if (!realpath.dentry || !realinode) {
> >>>>>                   WARN_ON(!(mask & MAY_NOT_BLOCK));
> >>>>>                   return -ECHILD;
> >>>>>           }
> >>>>> @@ -309,7 +309,6 @@ int ovl_permission(struct mnt_idmap *idmap,
> >>>>>
> >>>>>           if (err)
> >>>>>                   return err;
> >>>>>
> >>>>> -       realinode =3D d_inode(realpath.dentry);
> >>>>>           old_cred =3D ovl_override_creds(inode->i_sb);
> >>>>
> >>
> >> Thanks for reviewings and helpful discussion from Amir and Christian.
> >>
> >
> > You're welcome.
> >
> > Note to self: there is be a trivial conflict with the change to
> > ovl_i_path_real()
> > return type and this patch from my ovl-lazy-lowerdata series:
> > https://lore.kernel.org/linux-unionfs/20230427130539.2798797-7-amir73il=
@gmail.com/
> >
> > After Miklos takes your fixes, I will rebase.
>
> Thanks for rebasing, so you will take v2 with modified helper
> ovl_i_path_real(return realinode)?
>

Please post v3 with the modified helper for Miklos to take.

Thanks,
Amir.
