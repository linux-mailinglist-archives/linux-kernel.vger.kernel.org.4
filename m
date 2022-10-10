Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DC45FA468
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJJT6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJJT6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:58:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10A176463
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:58:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so18476559wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6HrtySy9XPYjnFDZdWqwUmVcceWIKpnpDQvWGrRgzM=;
        b=oQPQ3OAAt1WB8LjB7L0hC5xeFnh2oA0pM1JfruGIr62qZq6V90FMLghUmoqn2u2gji
         ccPYv701/q66Ibp7waR6y7eKaAVQyiU6FgOYsbH9PjHeou5eGiZbJ1j3x31+Qc/BH9Ju
         DAiQLpdYl+JtbIP1y7Ksk41SMm9oRXCvsJVMpnVO3goG9/Al5VkioeP8xV61hHc+3OgY
         QdBQiqpag8mf/VebQI0XAbEQhCbdhPFec3cc35l05e7vKmZNkljCJpW/I9q8NCik0z96
         i7oBSQRXUKKeOWpr/ElfY1urBUI1HDPHzU9XosFg7TVELRBaYO59UZlxIGo5v4gWuEnP
         NpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6HrtySy9XPYjnFDZdWqwUmVcceWIKpnpDQvWGrRgzM=;
        b=Pn2USjSYrGxvyLDwnn8ezfBXux0jsS+GFAgykSh8kjNqpseS9N7ggfPTgEyFwFYvMO
         Jc0MLgANDuxbCt2rDY+r3PCB4SjDZ+/kQ1aKZFr91GUiWThHkF5mBbOYfBurAHvY8Prj
         gvL5i586oTAqZbIpGDJ8Cds1G1yNRvEum0LMOCS4iUYwSxtuQ4YMosZMhaLGwXcfMF5V
         FoduobEgYTi4H9e21yUVpNj39Rs7sfRdMHjdE2H6q9Na9tEXLk3eMgzlUpe5qmVlLpMT
         JEe29GYfDwtFqK0f4xkTbI3HosWfU/M6zQVplllhYW7RKeozO2Z/je5e+TrclvlafnY7
         GXnQ==
X-Gm-Message-State: ACrzQf0e+RwVH1D7pd9y1wjAobkUmSRrgJ8ER0VxFnIt4xcTalvsqpQv
        ZtA+ZG+7JqJ2hydVuLh2Z9iRuksi8s/lEvhSiW32KQ==
X-Google-Smtp-Source: AMsMyM70tA5A/yGmyzpgzCtzk4znFvgglfKku7yBnUE97CBhU+XfotHjYCk5oNv5ZuB/CPceSXwcMi1YPTyOzK/r5Tk=
X-Received: by 2002:a5d:6741:0:b0:22e:2c5c:d611 with SMTP id
 l1-20020a5d6741000000b0022e2c5cd611mr12826001wrw.210.1665431890907; Mon, 10
 Oct 2022 12:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000385cbf05ea3f1862@google.com> <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org> <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein> <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <Y0Rn5qzP6MjayoCz@slm.duckdns.org> <CAJD7tka2jwPnYyCmLu0T5Oq_X-LJCx7TVqLayLPS_6fOjqf93A@mail.gmail.com>
 <Y0R31xyfivqtKb9h@slm.duckdns.org>
In-Reply-To: <Y0R31xyfivqtKb9h@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 10 Oct 2022 12:57:34 -0700
Message-ID: <CAJD7tkaQeFYq6prHiTiGeEyC-ka8ujAFXV--BkROJbVDaOZ78Q@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
To:     Tejun Heo <tj@kernel.org>
Cc:     "Christian A. Ehrhardt" <lk@c--e.de>,
        Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:51 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Mon, Oct 10, 2022 at 11:50:50AM -0700, Yosry Ahmed wrote:
> > The purpose of f3a2aebdd6 was to make cgroup_get_from_fd() support
> > cgroup1, which IIUC makes sense. It was unrelated to IDs.
>
> Ah, right you are. For some reason, I thought this was ID based.
>
> > There are currently two users of
> > cgroup_get_from_file()/cgroup_get_from_fd() AFAICT, one of which is
> > the fork code fixed by this commit, the second is BPF cgroup prog
> > attachment. I can send another patch to add explicit filtering in the
> > BPF attachment code as well.
> >
> > Alternatively, we can have separate functions that do the filtering if
> > needed. For example:
> > cgroup_get_from_fd() / cgroup_get_from_file() -> support both v1 and v2
> > cgroup_get_dfl_from_fd() / cgroup_get_dfl_from_file() -> support only v2
> >
> > We can then use the versions with filtering for all the current users
> > except cgroup_iter (that needs to support both v1 and v2). WDYT?
>
> Yes, but please leave the existing ones v2 only and add new ones which
> allows cgroup1 too.

Any suggestions for the new names though? Given that the new ones
would be the ones that will support both versions, I am not sure how
to name them differently in a meaningful way. Maybe something like
cgroup_get_all_from_[fd/file]() ?

IMO, we can rename the current versions to
cgroup_get_dfl_from_[fd/file](), and the new ones (which support both)
as cgroup_get_from_fd/file(). In this case it's obvious that one
version specifically works on "dfl", aka cgroup2.

Alternatively, we can have separate versions for v1,
cgroup1_get_from_[fd/file](), but then callers that want both v1 and
v2 will have to make 2 separate calls unnecessarily.

Thoughts?

>
> Thanks.
>
> --
> tejun
