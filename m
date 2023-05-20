Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4E70AB2B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 23:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjETVj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 17:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjETVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 17:39:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24BE53
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 14:39:13 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-561fc920e70so60565697b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684618752; x=1687210752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=skIbHQXL89xTcGXjMUySFNmB7v0Lz7PRThViE6J7dUY=;
        b=XOhjWMQCujbQihpjnwMiF/SfmTXnOhr/Ys+ogxPguM/2oUktHMtmWjf0aUhcRyzCBh
         /kEz89yUIxWvTiuBpO6/Wjfh6R5quIC8RrwBjsMz56N1Y2yK9n3Cj9SRiHdx2dwl6IxK
         Le1AiISUDlsAWmd2yStz5460GT9pE4x2v1mY830nZULv4KAUzKO4xLF0NpKPOt7W9XFZ
         cvTCRVOpI2oh0KmGEIhbI/RnUkApGY6MlYpTXol3S0DG9VxNlofkeMqz3w/mMlc8bNhg
         +g6lwMsJQn6eGGP2hsP/o91kkTkhD689u5GWS8emvFQWY54mktJXLQtS/S2hKgd91VrV
         8TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684618752; x=1687210752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=skIbHQXL89xTcGXjMUySFNmB7v0Lz7PRThViE6J7dUY=;
        b=eHenl8B7oB1174y3AL9We+P+RM+G3AUyRltVL2rhsNL83wBoy0/3aHIYc1c+6fkU23
         mo1KwVUSxzfD+eRbU5Uugh5obMPsBjfgg+saZxCHVQhFzrk+mz+87bhx3yKbqzXoIadO
         MQuoShyfbsW7JJJZ9LdMtgfm4Rf4owAJGst1fkTdIyMsMW0tS84EnqBJrHj/rNoUFQ+o
         WulNGWIq0KCYwg2bb2P2SvSr8cWztVEzfHQUAjnNVtE2iRz6ih9t4hgdNiFW/9wauSto
         8NoPBFFvcmFscsbk51D12+zjniTLvJOFNWS0hB9a8DThNUAkAsac6dcxIDcoqJtvSWDy
         qk5w==
X-Gm-Message-State: AC+VfDzttPO/Fhw8Rp+f5Vs9vVP0xqb+HsD/gmwRSUKKtZmWbi5+OJ/+
        oAWbEW0c+DuD7Rf4kIF6qMZJPI5jJcPi
X-Google-Smtp-Source: ACHHUZ5NT94sAhhBSYkBg9+aQOzjs7EaWrlC4HRCrVmXKqfpsmVjx6ZkufUyOOHq8ozbnDIs1+yqYhmL4bo5
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2d4:203:988d:5c18:d518:3f0b])
 (user=gthelen job=sendgmr) by 2002:a81:ad50:0:b0:559:f89f:bc81 with SMTP id
 l16-20020a81ad50000000b00559f89fbc81mr3705340ywk.6.1684618752673; Sat, 20 May
 2023 14:39:12 -0700 (PDT)
Date:   Sat, 20 May 2023 14:39:10 -0700
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
Mime-Version: 1.0
References: <20230515161736.775969473@linuxfoundation.org>
Message-ID: <xr93jzx2el8h.fsf@gthelen2.svl.corp.google.com>
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
From:   Greg Thelen <gthelen@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.180-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:

[...]

> Baokun Li <libaokun1@huawei.com>
>     writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs

Sorry for not noticing this sooner, but I think there's a benign issue
in this backport.

v5.10.180 commit 2b00b2a0e642 ("writeback, cgroup: fix null-ptr-deref
write in bdi_split_work_to_wbs") contains:

+static void cgwb_free_rcu(struct rcu_head *rcu_head)
+{
+       struct bdi_writeback *wb = container_of(rcu_head,
+                       struct bdi_writeback, rcu);
+
+       percpu_ref_exit(&wb->refcnt);
+       kfree(wb);
+}

[...]

@@ -397,7 +406,7 @@ static void cgwb_release_workfn(struct work_struct *work)
        fprop_local_destroy_percpu(&wb->memcg_completions);
        percpu_ref_exit(&wb->refcnt);
        wb_exit(wb);
-       kfree_rcu(wb, rcu);
+       call_rcu(&wb->rcu, cgwb_free_rcu);
 }

Notice there are now 2 percpu_ref_exit() calls. The upstream, and 5.15.y
patches remove the cgwb_release_workfn() calls to percpu_ref_exit(). The
5.10.y fixup is below. It's not essential but might be worth applying to
track upstream.

From 416e0e8ab5ff41676d04dc819bd667c6ad3f7555 Mon Sep 17 00:00:00 2001
From: Greg Thelen <gthelen@google.com>
Date: Sat, 20 May 2023 12:46:24 -0700
Subject: [PATCH] writeback, cgroup: remove extra percpu_ref_exit()

5.10 stable commit 2b00b2a0e642 ("writeback, cgroup: fix null-ptr-deref
write in bdi_split_work_to_wbs") is a backport of upstream 6.3 commit
1ba1199ec574.

In the 5.10 stable commit backport percpu_ref_exit() is called twice:
first in cgwb_release_workfn() and then in cgwb_free_rcu(). The 2nd call
is benign as percpu_ref_exit() internally detects there's nothing to do.

This fixes an non-upstream issue that only applies to 5.10.y.

Fixes: 2b00b2a0e642 ("writeback, cgroup: fix null-ptr-deref write in bdi_split_work_to_wbs")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 mm/backing-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index b28f629c3527..dd08ab928e07 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -404,7 +404,6 @@ static void cgwb_release_workfn(struct work_struct *work)
 	blkcg_unpin_online(blkcg);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
-	percpu_ref_exit(&wb->refcnt);
 	wb_exit(wb);
 	call_rcu(&wb->rcu, cgwb_free_rcu);
 }
-- 
2.40.1.698.g37aff9b760-goog
