Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07C5FA3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJJSvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJJSva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:51:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A211DF0C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:51:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so6911452wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHxfYRRBz6dDvIZIbha75zItKgdN7DRvBB/BdujSutA=;
        b=FrOEX1fowbDGJqL0kFOl5u+cx57jpmcv97/VlyGSVunxlfQXvSyMo77FY33fGpOhqL
         7akRUrYS8Ou6Hr6aHdIFKe69sCQZaicm2uPGF7oWa/BgZ6u+fG/bvcBYGTg2Pis/aPTv
         7WpRNFTePVYZQJqipcVa6CdeENDxPy4+vp9UmBxSHGcLV0cFEXFt5VReaTzecEyv5evF
         cUpPjMqnKhmsIXrDE+iw2CWy0HeV+CVaHVQJCLqfwCmvAwTE9glU4ocCJ8YsHfFFYOFx
         Vq9ORS7WywEQzqc/PCel2TYWSvevBzSpjWUpNFkNismbXVedgLO+sqrIUMXQNeiBQAQs
         jGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHxfYRRBz6dDvIZIbha75zItKgdN7DRvBB/BdujSutA=;
        b=mqY04Xznft7Y3p+ZCAJ0sDnYuj+nUov0l0t9HxzLaIpgK6BmKvipU8LG/Jh3+Bhyb8
         gf/7JSOAnl0bLrjW0XUc+4GviG+pHR5iz6oZRYxd6+9T7zfkKx26s7HZuMkQzB5QQRNL
         9D/ubI76bN2Vh8z/uEVRwX/F8MgTHVu6vctGMxojsBoubQP76io3WD0V8PAVaoTi6Jpj
         XFLKp/hiJeZr28F4GnZnZU2S5hmimEwZJm0qrGx+Kr9eztoSnU8OM3yizKac3jDXxI6i
         PY8iUS87FyBkAwrBPa6JBaY+kt624e6DMihZyH3SJDBOBzTtlxeqW9oGl9Rxf/FZP1R7
         PD4A==
X-Gm-Message-State: ACrzQf103fnJZz31vaxz4myvv9RCtKL0uO9S3za7sfKMaJ3vu8vtDW19
        bTf0fE8ecHBNAP85FnZvf1y0JSbP30FCFKocLp/+1w==
X-Google-Smtp-Source: AMsMyM5AKLWySZlXmYn97zNtwveG+wQlrLJ8/5UDHDwNZ6wcqBCJ0tO96aERRvSCo5LOXiEqmTwv5Hwe/To6GSNfaAw=
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933e with SMTP id
 fc13-20020a05600c524d00b003b491ee933emr14106351wmb.80.1665427886879; Mon, 10
 Oct 2022 11:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000385cbf05ea3f1862@google.com> <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org> <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein> <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
 <Y0Rn5qzP6MjayoCz@slm.duckdns.org>
In-Reply-To: <Y0Rn5qzP6MjayoCz@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 10 Oct 2022 11:50:50 -0700
Message-ID: <CAJD7tka2jwPnYyCmLu0T5Oq_X-LJCx7TVqLayLPS_6fOjqf93A@mail.gmail.com>
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

On Mon, Oct 10, 2022 at 11:44 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sun, Oct 09, 2022 at 03:10:36PM +0200, Christian A. Ehrhardt wrote:
> >
> > Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
> > error when used with CLONE_INTO_CGROUP. However, the permission
> > checks performed during clone assume a Version 2 cgroup.
> >
> > Restore the error check for V1 cgroups in the clone() path.
> >
> > Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
> > Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
> > Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
> > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
>
> This feels too error prone. I'd rather revert the original commit. Yosry,
> imma revert f3a2aebdd6. Can you please add a separate function which allows
> looking up IDs for cgroup1 hierarchies if absolutely necessary? But,
> frankly, given how inherently confusing using IDs for cgroup1 hierarchies is
> (fd for cgroup1 identifies both the hierarchy and the cgroup, id is
> inherently partial which is super confusing), I'd rather just not do it.

The purpose of f3a2aebdd6 was to make cgroup_get_from_fd() support
cgroup1, which IIUC makes sense. It was unrelated to IDs.

There are currently two users of
cgroup_get_from_file()/cgroup_get_from_fd() AFAICT, one of which is
the fork code fixed by this commit, the second is BPF cgroup prog
attachment. I can send another patch to add explicit filtering in the
BPF attachment code as well.

Alternatively, we can have separate functions that do the filtering if
needed. For example:
cgroup_get_from_fd() / cgroup_get_from_file() -> support both v1 and v2
cgroup_get_dfl_from_fd() / cgroup_get_dfl_from_file() -> support only v2

We can then use the versions with filtering for all the current users
except cgroup_iter (that needs to support both v1 and v2). WDYT?

>
> Thanks.
>
> --
> tejun
