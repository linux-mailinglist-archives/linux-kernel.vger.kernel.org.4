Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D133704CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEPLpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjEPLpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:45:53 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622EF4493;
        Tue, 16 May 2023 04:45:52 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4536ec953c1so4033346e0c.3;
        Tue, 16 May 2023 04:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684237551; x=1686829551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg5+aXCfNaiFZoVT2Tesak5ejXbAWGeXRp7IdG5203c=;
        b=sZPmYVv0BSOrk4BL09kppZhoy1uFGRfx9NOGcBbcGb9os4xKkzFOe9qkxzTvIzk/1b
         UGPwjV2YO6JIJ/2OXX7RaPpNzLPkXEpgOWF4rzMoFxby0OrkBH9jm+uyI6V4g7HzDXHJ
         UaXPo9wHfqDVxb3yXKs2RMPXtLyWJRNDAIPmdOXEZCZnlRbBfDWTS63hv5RFqNxIu14a
         zduvcSA9Shzb4jhug3d7yBQE7UZyjpkHTRPEnkpXpoDlizGAbPW641+tp7w1lrCyb5hv
         6tqaI9XHqxa6IoAy9OScJ5dOsOiVZf47hT/MQITi0JnaRuBJ7RTvlkGuxubVhUW/Jr0Y
         wOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684237551; x=1686829551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg5+aXCfNaiFZoVT2Tesak5ejXbAWGeXRp7IdG5203c=;
        b=GKhI1ZW6R665cMKilQLq8H0hDO60yRhJFgqukjEeMuPvaZD7OsDomx9wQbbjdmEmUb
         oNMqzqd5iZnF90eWTrgOMXIj7IWe7G3resv+i591HxS9GGuZdzOoGcf3vSoKOVIMrzZj
         fkoQfolRs1LLfKcEAciU8ypexfnupD2n35u2fygXuOk6WslBF31Jteiy9prfWtPwxyNu
         g968sDykRo03vPZosRvMCZDVe51bUqOeIrXN8/wNsvK9wbejEZaB3v2dxGlpgDu6EObI
         ehHEM9PjFdCPHoslqaOcybjyeYBhxPIPtwnBKzK9jzzI1FGZElon+nKTSA+rn1jN7x3l
         n4gA==
X-Gm-Message-State: AC+VfDxTtdsdkBijfNNIHr2QH0xjtMmLNxlqM5088RAl6lvQJjuujiN2
        blPeQh3d877CTYMDGir1sdTOWEWEvgTlQq0siofAxcxn6gTkcQ==
X-Google-Smtp-Source: ACHHUZ4M/2juCTzEtlmR/aYLqx0lUiFZugs4d93Eb/PBz/fdcvOVjWDgQULO1Nn24jBb+beOT4LMDnoEd5OjjB2PblI=
X-Received: by 2002:a1f:6dc6:0:b0:44f:eb0a:77db with SMTP id
 i189-20020a1f6dc6000000b0044feb0a77dbmr13461457vkc.11.1684237551062; Tue, 16
 May 2023 04:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
 <20230515133629.1974610-2-chengzhihao1@huawei.com> <20230515-sprachen-zeltlager-6925dfbe19c1@brauner>
 <CAOQ4uxjo3rzdrjmbXr=SgJbrBf_EA-HpXH25LORo_vPY=q0jWQ@mail.gmail.com>
 <20230515-dulden-symmetrie-3b5d934478d4@brauner> <CAOQ4uxjageSA8G1UR=9KPCYm80=GFLrwVonEotjOf0tpZDBY+g@mail.gmail.com>
 <53e81e0a-a99c-9a2a-7691-04789e2a2710@huawei.com>
In-Reply-To: <53e81e0a-a99c-9a2a-7691-04789e2a2710@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 14:45:39 +0300
Message-ID: <CAOQ4uxi9bhs0xKO-zCj-QiFzd-xZEp8DtG222vG-R6U5HBHcVg@mail.gmail.com>
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

On Tue, May 16, 2023 at 4:16=E2=80=AFAM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
>
> =E5=9C=A8 2023/5/15 23:36, Amir Goldstein =E5=86=99=E9=81=93:
> > On Mon, May 15, 2023 at 6:16=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> >>
> >> On Mon, May 15, 2023 at 05:58:55PM +0300, Amir Goldstein wrote:
> >>> On Mon, May 15, 2023 at 4:58=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>>
> >>>> On Mon, May 15, 2023 at 09:36:28PM +0800, Zhihao Cheng wrote:
> >>>>> Following process:
> >>>>>            P1                     P2
> >>>>>   path_lookupat
> >>>>>    link_path_walk
> >>>>>     inode_permission
> >>>>>      ovl_permission
> >>>>>        ovl_i_path_real(inode, &realpath)
> >>>>>          path->dentry =3D ovl_i_dentry_upper(inode)
> >>>>>                            drop_cache
> >>>>>                           __dentry_kill(ovl_dentry)
> >>>>>                            iput(ovl_inode)
> >>>>>                             ovl_destroy_inode(ovl_inode)
> >>>>>                              dput(oi->__upperdentry)
> >>>>>                               dentry_kill(upperdentry)
> >>>>>                                dentry_unlink_inode
> >>>>>                                 upperdentry->d_inode =3D NULL
> >>>>>        realinode =3D d_inode(realpath.dentry) // return NULL
> >>>>>        inode_permission(realinode)
> >>>>>         inode->i_sb  // NULL pointer dereference
> >>>>> , will trigger an null pointer dereference at realinode:
> >>>>>    [  335.664979] BUG: kernel NULL pointer dereference,
> >>>>>                   address: 0000000000000002
> >>>>>    [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
> >>>>>    [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
> >>>>>    [  335.678939] Call Trace:
> >>>>>    [  335.679165]  <TASK>
> >>>>>    [  335.679371]  ovl_permission+0xde/0x320
> >>>>>    [  335.679723]  inode_permission+0x15e/0x2c0
> >>>>>    [  335.680090]  link_path_walk+0x115/0x550
> >>>>>    [  335.680771]  path_lookupat.isra.0+0xb2/0x200
> >>>>>    [  335.681170]  filename_lookup+0xda/0x240
> >>>>>    [  335.681922]  vfs_statx+0xa6/0x1f0
> >>>>>    [  335.682233]  vfs_fstatat+0x7b/0xb0
> >>>>>
> >>>>> Fetch a reproducer in [Link].
> >>>>>
> >>>>> Add a new helper ovl_i_path_realinode() to get realpath and real in=
ode
> >>>>> after non-nullptr checking, use the helper to replace the current r=
ealpath
> >>>>> getting logic.
> >>>>>
> >>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217405
> >>>>> Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
> >>>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> >>>>> Suggested-by: Christian Brauner <brauner@kernel.org>
> >>>>> ---
> >>>>>   fs/overlayfs/inode.c | 31 ++++++++++++++++++++++++-------
> >>>>>   1 file changed, 24 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> >>>>> index 541cf3717fc2..cc3ef5a6666a 100644
> >>>>> --- a/fs/overlayfs/inode.c
> >>>>> +++ b/fs/overlayfs/inode.c
> >>>>> @@ -278,6 +278,26 @@ int ovl_getattr(struct mnt_idmap *idmap, const=
 struct path *path,
> >>>>>        return err;
> >>>>>   }
> >>>>>
> >>>>> +static inline int ovl_i_path_realinode(struct inode *inode,
> >>>>> +                                    struct path *realpath,
> >>>>> +                                    struct inode **realinode, int =
rcu)
> >>>>> +{
> >>>>> +     /* Careful in RCU walk mode */
> >>>>> +     ovl_i_path_real(inode, realpath);
> >>>>> +     if (!realpath->dentry) {
> >>>>> +             WARN_ON(!rcu);
> >>>>> +             return -ECHILD;
> >>>>> +     }
> >>>>> +
> >>>>> +     *realinode =3D d_inode(realpath->dentry);
> >>>>> +     if (!*realinode) {
> >>>>> +             WARN_ON(!rcu);
> >>>>> +             return -ECHILD;
> >>>>> +     }
> >>>>> +
> >>>>> +     return 0;
> >>>>> +}
> >>>>
> >>>> If you want to return the inode wouldn't it possibly make more sense=
 to
> >>>> return the inode from the function directly? But not fuzzed. Maybe A=
mir
> >>>> has a preference. As I said, I'm even fine with the original approac=
h.
> >>>
> >>> Sorry for not reviewing v1, I was traveling, even though it is hard t=
o use
> >>> this excuse when I was traveling with Christian who did review v1 :)
> >>
> >> Well, I did only do it this morning. :)
> >>
> >>>
> >>>>
> >>>> static inline struct inode *ovl_i_path_realinode(struct inode *inode=
,
> >>>>                                                   struct path *realp=
ath,
> >>>>                                                   int rcu)
> >>>> {
> >>>>          struct inode *realinode;
> >>>>
> >>>>          /* Careful in RCU walk mode */
> >>>>          ovl_i_path_real(inode, realpath);
> >>>>          if (!realpath->dentry) {
> >>>>                  WARN_ON(!rcu);
> >>>>                  return ERR_PTR(-ECHILD);
> >>>>          }
> >>>>
> >>>>          realinode =3D d_inode(realpath->dentry);
> >>>>          if (!realinode) {
> >>>>                  WARN_ON(!rcu);
> >>>>                  return ERR_PTR(-ECHILD);
> >>>>          }
> >>>>
> >>>>          return realinode;
> >>>> }
> >>>>
> >>>
> >>> I think this helper is over engineered ;-)
> >>
> >> Yes. As mentioned before, I would've been happy even with v1 that didn=
't
> >> have any helper.
> >>
> >>> The idea for a helper that returns inode is good,
> >>> but I see no reason to mix RCU walk in this helper
> >>> and don't even need a new helper (see untested patch below).
> >>
> >> Looks good to me too.
> >>
> >>>
> >>> Thanks,
> >>> Amir.
> >>>
> >>> ---
> >>> -void ovl_i_path_real(struct inode *inode, struct path *path)
> >>> +struct inode *ovl_i_path_real(struct inode *inode, struct path *path=
)
> >>>   {
> >>>          struct ovl_path *lowerpath =3D ovl_lowerpath(OVL_I_E(inode))=
;
> >>>
> >>> @@ -342,6 +342,8 @@ void ovl_i_path_real(struct inode *inode, struct =
path *path)
> >>>          } else {
> >>>                  path->mnt =3D ovl_upper_mnt(OVL_FS(inode->i_sb));
> >>>          }
> >>> +
> >>> +       return path->dentry ? d_inode(path->dentry) : NULL;
> >>>   }
> >>>
> >>> @@ -295,8 +295,8 @@ int ovl_permission(struct mnt_idmap *idmap,
> >>>          int err;
> >>>
> >>>          /* Careful in RCU walk mode */
> >>> -       ovl_i_path_real(inode, &realpath);
> >>> -       if (!realpath.dentry) {
> >>> +       realinode =3D ovl_i_path_real(inode, &realpath);
> >>> +       if (!realpath.dentry || !realinode) {
> >>>                  WARN_ON(!(mask & MAY_NOT_BLOCK));
> >>>                  return -ECHILD;
> >>>          }
> >>> @@ -309,7 +309,6 @@ int ovl_permission(struct mnt_idmap *idmap,
> >>>
> >>>          if (err)
> >>>                  return err;
> >>>
> >>> -       realinode =3D d_inode(realpath.dentry);
> >>>          old_cred =3D ovl_override_creds(inode->i_sb);
> >>
>
> Thanks for reviewings and helpful discussion from Amir and Christian.
>

You're welcome.

Note to self: there is be a trivial conflict with the change to
ovl_i_path_real()
return type and this patch from my ovl-lazy-lowerdata series:
https://lore.kernel.org/linux-unionfs/20230427130539.2798797-7-amir73il@gma=
il.com/

After Miklos takes your fixes, I will rebase.

Thanks,
Amir.
