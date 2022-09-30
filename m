Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5F5F0F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiI3QEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiI3QEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:04:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7091C2FB9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:04:30 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id k3so3982012ybk.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=P1gEZhNKaDm6D8ha6w3cHIovDhU070oj7JlZ7fmq3A4=;
        b=bjePujPzRlskjooOBqV8Lp6gqVCaEk41+Vz1BSH9r7H1FMx9rKzHRIYJQjHfsd3QT4
         iCpcpB6lO/vGV9ZKNkCaiDAIRaPRxWEmpgsu/0AgslJ39omODOVWVeSMzL0Zy255fU9+
         qZzS/e3q/+ODuXmskg9xC2IfBGjvFHeyOmgUwHCCnP1ar4ejmTnW/cKnau1L7wKmnkjZ
         WY5aBHheEpBJur8Ftze+0qr4vt13P7sLJaNvG+3yGJsBkWdE9rduWunxxrDMxj57QvLH
         zuqvVL1uXtUeanRDbQ0bn/vH4PzUyRSAsx4EhxuE7WJyLOcQt7UWtZICu+7DitY3qpD4
         jcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=P1gEZhNKaDm6D8ha6w3cHIovDhU070oj7JlZ7fmq3A4=;
        b=GWrMk0Kv1YY5pkZiyt7uAcEruveeQEO3FetsymPO/w/cmzqnoHE9DPwlGDvmz9ARXR
         USc7yGCxnmj5Gk4tmWHDxnPiCSfoEG1KG0BpHHDSQPEGF1SctlkN/R1TVH8GVN0hKVox
         9YhLd33oFCJDyhbTO4trbBM59OmFHaDGJZhCrh9Dugg87SqJ3lBbxlo5g/YKmAIZFEjp
         Tg8VgvCRcxG4wBZ8i3Hh2RnrKFItM2rwv3t/g6RcWm0JwNMtxfYziA2UBPzd82KaxSsp
         PgBLVUPW+kNz4cdipbOjk6AoWsZMVuC+tHEQGsuzalUm1CpXrH6mbW2gu7egz5TWNYyK
         poog==
X-Gm-Message-State: ACrzQf1bgF5hTS564Ixrecyp9vBonGYCrIUGT7V9plTbFTJgjd86zHka
        18LFT5a3tk7yqtVK4tkaTv5jj/IpgjvaGSvtjmQ=
X-Google-Smtp-Source: AMsMyM6IvjvFmlvXh9MuO/cssBogu4g1kedppJq5VKyB1gsGuRnuYVbu4r387jCZa4tSdKqbc61jcysXfE73oKXn5Xk=
X-Received: by 2002:a5b:90:0:b0:68e:26dd:c4a7 with SMTP id b16-20020a5b0090000000b0068e26ddc4a7mr9264930ybp.6.1664553869964;
 Fri, 30 Sep 2022 09:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220920014036.2295853-1-daeho43@gmail.com> <f4ce9486-f104-b0e2-25ed-f6de96316b76@kernel.org>
 <CACOAw_z=9H6jEQNd8C99c6xO55PJXWJOW7Q=78qtppgysebN2A@mail.gmail.com>
 <4aca0d00-d3b7-975f-6b72-ccd6f07d22e5@kernel.org> <CACOAw_wVU1gmH1gyWHYNqCpgy4KGKB+EZK6pbGL-h_1ToDV=vg@mail.gmail.com>
 <53df1b78-c611-6a22-88b1-74cc83a9e148@kernel.org>
In-Reply-To: <53df1b78-c611-6a22-88b1-74cc83a9e148@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 30 Sep 2022 09:04:19 -0700
Message-ID: <CACOAw_w_09sz8PxnSGzNmJwh1-y_3JoKbBu80VjgZgV1uxo7KA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>
> >>>> Hi Daeho,
> >>>>
> >>>> isize should be updated after tagging inode as atomic_write one?
> >>>> otherwise f2fs_mark_inode_dirty_sync() may update isize to inode page,
> >>>> latter checkpoint may persist that change? IIUC...
> >>>>
> >>>> Thanks,
> >>>
> >>> Hi Chao,
> >>>
> >>> The first patch of this patchset prevents the inode page from being
> >>> updated as dirty for atomic file cases.
> >>> Is there any other chances for the inode page to be marked as dirty?
> >>
> >> I mean:
> >>
> >> Thread A                                Thread B
> >> - f2fs_ioc_start_atomic_write
> >>    - f2fs_i_size_write(inode, 0)
> >>     - f2fs_mark_inode_dirty_sync
> >>                                          - checkpoint
> >>                                           - persist inode with incorrect zero isize
> >>
> >>    - set_inode_flag(inode, FI_ATOMIC_FILE)
> >>
> >> Am I missing something?
> >>
> >
> > So, f2fs_mark_inode_dirty_sync() will not work for atomic files
> > anymore, which means it doesn't make the inode dirty.
> > Plz, refer to the first patch of this patchset. Or I might be confused
> > with something. :(
>
> I mean FI_ATOMIC_FILE was set after f2fs_i_size_write(), so inode will be set
> as dirty.
>
> Thanks,
>

Oh, I was confused that f2fs_update_inode() is called in
f2fs_mark_inode_dirty_sync().
That is called in f2fs_write_inode(). Let me fix this.

Thanks,
