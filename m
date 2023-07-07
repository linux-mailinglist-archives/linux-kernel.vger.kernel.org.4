Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009F674AA01
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 06:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGGElN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 00:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjGGElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 00:41:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D61BF4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 21:41:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c6e4d4c59bcso126661276.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688704868; x=1691296868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckOL5yFaE2flgZND4kc95RvBBFmf8gW77xFQV6lXywU=;
        b=wsUTUzSvSu209HVqegIZt7JwhstZ2QHOs8ZxtV29iwAJ9L5PrSdy//fIcId6deP46F
         l0BdDKaldHTdo3UyF/Y/Oipztc9NiXwaV1yFLsNIYqFC3VKBjxMn4y5m1sI6FDNq0fS7
         RPfjpNaS1FEQiiYT33fl8k2zryDpsK40pLGSl8qOlOep1j9kzjO1dO4ki77WPpBRGBzh
         ySheUrWUnCsfmQBYUzjfU/hezEves3eMO78aZV2BBU9MTSmC6yB5DpBtvVr5hx0S8lBQ
         1pHYdkeb5OOfdnpQMgm0CkVyFIXMUjHrx9I33Y16iSglvWsGa7IuiadJJwbF/vxgsFfu
         W6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704868; x=1691296868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckOL5yFaE2flgZND4kc95RvBBFmf8gW77xFQV6lXywU=;
        b=bnyTXjFKL+HM5HTS8DKtR0i6SUwP85czGezGZYsPCjtMrsDcokiNW18eG0/LVhmmVB
         t9WdnBqm5pADJwK3lPtHcq3p89oncalgsEFq+jkIHqIeZ5qjTaRHT+gvt+e+vEl1ZZhE
         ba3OBKW/f7Z1eh4iQFxLZd67Wg3S/uosK2aJyrDvVSbiCw5LXcAi6cI+9cv41JqJ5ktP
         SbXd7dGo3Kf5TNylvYRjoSvbR9pkZZ3QSoDjys8mYUZBIyPB5Muq6Eod4usCXrsitnOX
         ax63TjMN9WW/Nff3eRjdv4Rb1/GnAGQJzriocA/4D2shhrrDq7FjB6zbQQMi4zoxtwH5
         9sWQ==
X-Gm-Message-State: ABy/qLYeHQJwPocHJ1MG5uTFA8bZC+4pDDRKmIGgvCMBB6FQ5PZSo95W
        9d65yRksd94Q07ByWOFiCy/Awe8WwlDo3Uk7lyUD1T9shpdyhOou3sPzjA==
X-Google-Smtp-Source: APBJJlG4Mp7SGvFnM5AUda+Jrz6qEig89UbtxySFOP/2+BOpyys6uA2AiKCRcDvyH4yy2lBCB7/UqN+vcuqQj5t4bAI=
X-Received: by 2002:a25:f826:0:b0:ba8:2a74:155 with SMTP id
 u38-20020a25f826000000b00ba82a740155mr4920668ybd.32.1688704868051; Thu, 06
 Jul 2023 21:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230606124939.93561-1-yu.ma@intel.com> <20230606192013.viiifjcgb6enyilx@revolver>
 <20230705165411.tfqqipcla7exkb7k@box.shutemov.name> <20230705173348.rxgzxge6ipb4hapy@revolver>
 <20230705190601.4atlxzh2wxc7zlu6@box.shutemov.name> <CAJuCfpHu+etUuRkaw=hyBN6pHV3sP8-Mov3YKqUMU-EqNfHsHg@mail.gmail.com>
In-Reply-To: <CAJuCfpHu+etUuRkaw=hyBN6pHV3sP8-Mov3YKqUMU-EqNfHsHg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 6 Jul 2023 21:40:56 -0700
Message-ID: <CAJuCfpH9zir38eNBwxGqraZ6P1i3KyA05aHupSYz4yLqXGA3AQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Yu Ma <yu.ma@intel.com>, akpm@linux-foundation.org,
        tim.c.chen@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        dan.j.williams@intel.com, shakeelb@google.com, pan.deng@intel.com,
        tianyou.li@intel.com, lipeng.zhu@intel.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 3:04=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jul 5, 2023 at 12:06=E2=80=AFPM Kirill A. Shutemov <kirill@shutem=
ov.name> wrote:
> >
> > On Wed, Jul 05, 2023 at 01:33:48PM -0400, Liam R. Howlett wrote:
> > > * Kirill A. Shutemov <kirill@shutemov.name> [230705 12:54]:
> > > > On Tue, Jun 06, 2023 at 03:20:13PM -0400, Liam R. Howlett wrote:
> > > > > * Yu Ma <yu.ma@intel.com> [230606 08:23]:
> > > > > > UnixBench/Execl represents a class of workload where bash scrip=
ts are
> > > > > > spawned frequently to do some short jobs. When running multiple=
 parallel
> > > > > > tasks, hot osq_lock is observed from do_mmap and exit_mmap. Bot=
h of them
> > > > > > come from load_elf_binary through the call chain
> > > > > > "execl->do_execveat_common->bprm_execve->load_elf_binary". In d=
o_mmap,it will
> > > > > > call mmap_region to create vma node, initialize it and insert i=
t to vma
> > > > > > maintain structure in mm_struct and i_mmap tree of the mapping =
file, then
> > > > > > increase map_count to record the number of vma nodes used. The =
hot osq_lock
> > > > > > is to protect operations on file=E2=80=99s i_mmap tree. For the=
 mm_struct member
> > > > > > change like vma insertion and map_count update, they do not aff=
ect i_mmap
> > > > > > tree. Move those operations out of the lock's critical section,=
 to reduce
> > > > > > hold time on the lock.
> > > > > >
> > > > > > With this change, on Intel Sapphire Rapids 112C/224T platform, =
based on
> > > > > > v6.0-rc6, the 160 parallel score improves by 12%. The patch has=
 no
> > > > > > obvious performance gain on v6.4-rc4 due to regression of this =
benchmark
> > > > > > from this commit f1a7941243c102a44e8847e3b94ff4ff3ec56f25 (mm: =
convert
> > > > > > mm's rss stats into percpu_counter).
> > > > >
> > > > > I didn't think it was safe to insert a VMA into the VMA tree with=
out
> > > > > holding this write lock?  We now have a window of time where a fi=
le
> > > > > mapping doesn't exist for a vma that's in the tree?  Is this alwa=
ys
> > > > > safe?  Does the locking order in mm/rmap.c need to change?
> > > >
> > > > We hold mmap lock on write here, right?
> > >
> > > Yes.
> > >
> > > >Who can observe the VMA until the
> > > > lock is released?
> > >
> > > With CONFIG_PER_VMA_LOCK we can have the VMA read under the rcu
> > > read lock for page faults from the tree.  I am not sure if the vma is
> > > initialized to avoid page fault issues - vma_start_write() should eit=
her
> > > be taken or initialise the vma as this is the case.
> >
> > Right, with CONFIG_PER_VMA_LOCK the vma has to be unusable until it is
> > fully initialized, effectively providing the same guarantees as mmap wr=
ite
> > lock. If it is not the case, it is CONFIG_PER_VMA_LOCK bug.
>
> Jumping into the conversation.
>
> If we are adding a VMA into the tree before it's fully usable then we
> should write-lock it before it becomes visible to page faults. Kirill
> is right that there is a problem and we should not rely on
> vma->vm_file->f_mapping lock here. Instead we should write-lock the
> VMA before adding it into the tree even without this change.
> IIUC, the rule with mmap_lock is that VMA can be safely modified if it
> is either isolated or if we write-locked the mmap_lock. With
> CONFIG_PER_VMA_LOCK the same rule should apply to per-VMA locks - the
> VMA should be either isolated or we should write-lock it. Here we are
> adding the unlocked VMA into the tree and then we keep modifying it.
> This did not bite us because modifications are only done to
> file-backed VMAs and we do not handle file-backed page faults under
> per-VMA locks yet, however this will become a problem once we start
> supporting that.
> If we all agree to the above I can post a change to lock the VMA
> before adding it into the tree.

This patch is addressing the issue with per-VMA locks here:
https://lore.kernel.org/all/20230707043211.3682710-2-surenb@google.com/

>
> >
> > > There is also a possibility of a driver mapping a VMA and having entr=
y
> > > points from other locations.  It isn't accessed through the tree thou=
gh
> > > so I don't think this change will introduce new races?
> >
> > Right.
> >
> > > > It cannot be retrieved from the VMA tree as it requires at least re=
ad mmap
> > > > lock. And the VMA doesn't exist anywhere else.
> > > >
> > > > I believe the change is safe.
> > >
> > > I guess insert_vm_struct(), and vma_link() callers should be checked =
and
> > > updated accordingly?
> >
> > Yep.
> >
> > --
> >   Kiryl Shutsemau / Kirill A. Shutemov
> >
