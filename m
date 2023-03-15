Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037876BA758
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCOFtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCOFth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:49:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845A422789
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:49:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n203-20020a25dad4000000b0091231592671so19244503ybf.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678859376;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p5ozhbExSp124prI8izec79T5UTSN1Zg2cFxKIFyy6Y=;
        b=JrfZ0lSsJj54ScQQ9WhIMYTt0H8N9wdsE3nBLK5R9cXi0g/lcmUOD0bfd0fsPKrdlL
         myNK2dv0DKDdXZmlYChFRrFd4lktPUVo4gNWbvVf7U5tPw39P6q9KkfNNzRoye65zP8J
         iZuM+pQNXIH6fWkaH1yn5dPJsZmcFWZLJQrT29tWYBp65pyj2M6b1sDKEwuPa1h1WrVU
         TpE0ZgkmA5vGDNhdgktHfsstetu71cn6HRNdDe76WQQyfd5aNNAAR2eAOwr8OibetnNc
         oKBvh/yN3Y3iOpwKBouxiABMpd0hukSRbJgizje2bH6VsJiKxmFcdpWe5JC+bRrJa4vx
         dmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678859376;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5ozhbExSp124prI8izec79T5UTSN1Zg2cFxKIFyy6Y=;
        b=ejkNw3kGqt3nzseZRem0DIaxxrtzg6WFSTSMwfODkDzT/wvOpCQDNR4tDfC8UmtQ82
         s6oQ7kO0k6xOL897l1pqILiL7ToeVz2D5MhVuYD/CGG7c/5Br+GR/7A+B2mPPlokXWXM
         4CR3poPFsxgZ+fuQcw39hQ06oypK4i8ngC58iht+0MzYHwydImKF3IHIeScgxs5wZOIq
         FM8MHXZz/RvvKR9a5p1rg2EoHY+/jpmio5C1wPnKeLud/1/nMSUCo3wCY4TqnQGJSVTA
         nrM+siNs6R/nGf4kr5c1n+YByx9taGh37fgdB9eUGbvZTdT5GLVuA19GC5q3G4DEtYfQ
         uzyg==
X-Gm-Message-State: AO0yUKUQXiMZvqdwwANhGexvZ1DysMVRF/Gt8VJPw+8DAm3DjFSZPOOl
        PImV0KRT8tcEywla+vIxWi1j8GtDEWhv
X-Google-Smtp-Source: AK7set8TochKdEZmoLnXQsFcpuT2ztvRyVTvffYAqiJOPG9v4eWrl3zu5SJZ3UqO6I7f+HmP9AhTGb90mro/
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2d4:203:72ec:5908:b03f:4293])
 (user=gthelen job=sendgmr) by 2002:a5b:386:0:b0:b0a:7108:71e9 with SMTP id
 k6-20020a5b0386000000b00b0a710871e9mr11023532ybp.4.1678859375798; Tue, 14 Mar
 2023 22:49:35 -0700 (PDT)
Date:   Tue, 14 Mar 2023 22:49:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230315054932.1639169-1-gthelen@google.com>
Subject: [PATCH] tools/resolve_btfids: Add libsubcmd to .gitignore
From:   Greg Thelen <gthelen@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After building the kernel I see:
  $ git status -s
  ?? tools/bpf/resolve_btfids/libbpf/

Commit af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
started copying header files into
tools/bpf/resolve_btfids/libsubcmd/include/subcmd. These *.h files are
not covered by higher level wildcard gitignores.

gitignore the entire libsubcmd directory. It's created as part of build
and removed by clean.

Fixes: af03299d8536 ("tools/resolve_btfids: Install subcmd headers")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/bpf/resolve_btfids/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
index 16913fffc985..52d5e9721d92 100644
--- a/tools/bpf/resolve_btfids/.gitignore
+++ b/tools/bpf/resolve_btfids/.gitignore
@@ -1,3 +1,4 @@
 /fixdep
 /resolve_btfids
 /libbpf/
+/libsubcmd/
-- 
2.40.0.rc1.284.g88254d51c5-goog

