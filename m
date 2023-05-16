Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665F704E04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjEPMrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjEPMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:47:02 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A51D122;
        Tue, 16 May 2023 05:46:58 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-453859b6b18so2088225e0c.3;
        Tue, 16 May 2023 05:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684241217; x=1686833217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl50wTUeOZF25t4IkNhKUoFdpuHrFZ4x2mhQ8xO0ymg=;
        b=pIe4aiW0v9WOIzD89Fo2ZFvsJyTSN5dq+oCYm6yQ36TCS19lHHqAI+t58dY4T8IOCj
         5o06YSd4Y27cRhvkG8gfF3sXtIrzBaPd+kVUEDOpqlZpUjNm7VguH09s/92r5J+r6Kj1
         oCpMhDu8xutYVVsASXyhUYk72KJ2tv4PpfydZcXW13EbtG8knFFGShFT/zUfY+QIr9gE
         31gvoy62f2UwCbMxgY59U1P/WFw+aoRXASiv2hCRP02EFt7CQXwmszNb64Dg5pkuoMji
         9HaFEuk9LKWT6Hcfs3yvf0BiFfs/QsVHm2ogK3VRx/dNs1Daf+EDFlfj6p5koo6XCx86
         1JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241217; x=1686833217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hl50wTUeOZF25t4IkNhKUoFdpuHrFZ4x2mhQ8xO0ymg=;
        b=G8F8CV9RpQcoy/Q9H0LgEqRvIb3V70fjVLzGO8xX0ipMymB3+U1shevQS+MN5oK/G7
         xYJRDJ6AZw0mo72opvzX/tMBGs/SlAvvUx3rko4WOpDrplvLvv75PQr1KbZZRiQhr0yQ
         q5+huSaw42BFfae6rcLb+94G3G0t2KriiJRQV76//Blc6DpZmrTTyRlm6LMCcb50k2Ht
         8yTwGd2i6b8wGueCbXm/Acl0CuAxg9cyeh94NQxsy6iwEoTeVZntoPGHc6Hj15QtgU5w
         N/CYLOPms5ddzqKutP44sV4Xpx18iz3td4bfJ3ff/kZb0hKSJi1cJC8AnQ3ACXc64cVv
         d5jA==
X-Gm-Message-State: AC+VfDxRy4lAeJCuHJ8XTTn7JtQpmtNyLD8xGddYix9SuIiDg0xZ9NQI
        svt6cr04pNp7h0bpuZh1C89RK4Nmgn6+sYDdk10=
X-Google-Smtp-Source: ACHHUZ4lDGjF5lxrx9P2QZ9TgcVMgYPU6VtByZSaiIfusyMq+aURJqVrFxfUnylPFivtHsxII3HjUPbb3IuFvs1tZ9w=
X-Received: by 2002:a1f:bd47:0:b0:44f:cc25:2007 with SMTP id
 n68-20020a1fbd47000000b0044fcc252007mr12388960vkf.11.1684241217408; Tue, 16
 May 2023 05:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230515133629.1974610-1-chengzhihao1@huawei.com>
 <20230515133629.1974610-3-chengzhihao1@huawei.com> <CAOQ4uxj-j-ugHrvvfS+XF=rzE3NH_NaZgf4_rWBxvaGYO3iN-w@mail.gmail.com>
 <1f11e2f3-bdf8-553c-82fa-b24619e28e73@huawei.com>
In-Reply-To: <1f11e2f3-bdf8-553c-82fa-b24619e28e73@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 15:46:46 +0300
Message-ID: <CAOQ4uxigfZhtfBv9VLvfcxcyj7NjYs9-rJycAep0xCNefnHm5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ovl: get_acl: Fix null pointer dereference at
 realinode in rcu-walk mode
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     miklos@szeredi.hu, brauner@kernel.org,
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

On Tue, May 16, 2023 at 3:25=E2=80=AFPM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
>
> =E5=9C=A8 2023/5/16 19:40, Amir Goldstein =E5=86=99=E9=81=93:
> > On Mon, May 15, 2023 at 4:39=E2=80=AFPM Zhihao Cheng <chengzhihao1@huaw=
ei.com> wrote:
> >>
> >> Following process:
> >>           P1                     P2
> >>   path_openat
> >>    link_path_walk
> >>     may_lookup
> >>      inode_permission(rcu)
> >>       ovl_permission
> >>        acl_permission_check
> >>         check_acl
> >>          get_cached_acl_rcu
> >>           ovl_get_inode_acl
> >>            realinode =3D ovl_inode_real(ovl_inode)
> >>                                drop_cache
> >>                                 __dentry_kill(ovl_dentry)
> >>                                  iput(ovl_inode)
> >>                                   ovl_destroy_inode(ovl_inode)
> >>                                    dput(oi->__upperdentry)
> >>                                     dentry_kill(upperdentry)
> >>                                      dentry_unlink_inode
> >>                                       upperdentry->d_inode =3D NULL
> >>              ovl_inode_upper
> >>               upperdentry =3D ovl_i_dentry_upper(ovl_inode)
> >>               d_inode(upperdentry) // returns NULL
> >>            IS_POSIXACL(realinode) // NULL pointer dereference
> >> , will trigger an null pointer dereference at realinode:
> >>    [  205.472797] BUG: kernel NULL pointer dereference, address:
> >>                   0000000000000028
> >>    [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
> >>                   6.3.0-12064-g2edfa098e750-dirty #1216
> >>    [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
> >>    [  205.489584] Call Trace:
> >>    [  205.489812]  <TASK>
> >>    [  205.490014]  ovl_get_inode_acl+0x26/0x30
> >>    [  205.490466]  get_cached_acl_rcu+0x61/0xa0
> >>    [  205.490908]  generic_permission+0x1bf/0x4e0
> >>    [  205.491447]  ovl_permission+0x79/0x1b0
> >>    [  205.491917]  inode_permission+0x15e/0x2c0
> >>    [  205.492425]  link_path_walk+0x115/0x550
> >>    [  205.493311]  path_lookupat.isra.0+0xb2/0x200
> >>    [  205.493803]  filename_lookup+0xda/0x240
> >>    [  205.495747]  vfs_fstatat+0x7b/0xb0
> >>
> >> Fetch a reproducer in [Link].
> >>
> >> Fix it by using helper ovl_i_path_realinode() to get realpath and real
> >> inode after non-nullptr checking.
> >>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217404
> >> Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
> >
> > Note that this bug is also in 5.15.y, in method ovl_get_acl().
> > I hope you will be able to follow up with a simple backport for 5.15 -
> > i.e. only need to add a check for NULL realinode at the beginning.
> > There was no realpath back then.
> >
>
> Sure. I notice that there is a '[ Upstream commit xxx ]' field in 5.15
> patch, so may I backport it after the fix applied into mainline(6.4)?
>

Yes, you need to wait until the fix is merged to mainline before
posting a backport.

You'd usually prefix the patch subject with [PATCH 5.15] and send
it to stable@kernel.

It'd be good to mention the changes from upstream commit,
because this is not a trivial backport.

Thanks,
Amir.
