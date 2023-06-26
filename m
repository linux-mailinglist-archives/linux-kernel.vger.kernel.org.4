Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7190C73ED07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFZVpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFZVpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:45:30 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C42CE6F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:45:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6689430d803so2031202b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687815929; x=1690407929;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ajw1mb7NLaeaQBGBPndmOfeS9gpHb3Dov0JICgF+vg=;
        b=RJIElG2Xu7zStuW23gGmAxrrGFPyEsxQGsI6vGIJpZeW1He9Q0I7W23CsSC7UehVF2
         ZaBSIMkiJ90ywZePCDuOfGmh3wRVNu9jx1MKMGsJggncoIE0rXoMrgafX/TSbYhsWvcg
         +KHuDtmTMa6vVT4wFg2W2NGrajvE1P0scI/SK4HcCNUhUW1jWYJFuPgzHDv8JAvdIH4W
         51OEnpgjpU0nQWvniwjs4CZ+v8QaDpqD4RqTu+TyE7ideUdIt+aJl0M9XH/McudLHe44
         08ccKDcVDmoyiL4k4plLIU/yaT+vLhPlLFGXVdPCcPyyUDxEQMF577AiOL3XQiuamEoR
         O4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815929; x=1690407929;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ajw1mb7NLaeaQBGBPndmOfeS9gpHb3Dov0JICgF+vg=;
        b=hhLs8Urao1hJJp32YRPQhl8ieaNSgFvWS9kPiKP7GXV05aJ8NeSesmU7KlamWdl0ui
         FoNZS6fBlDmfJ+zpgq81wMJ1AF2QshjRG9+pSkf5wBDQwF9chVxkPXR/1VMWXke6hQBw
         sexz9+VW49ItEbOq5OljGf3EcjQA+93h3ZPG0bF166YclGXh3Uw/Aph/dkT//xB83/2r
         DwHXlsT1JHYffNLYoMx0LQEy6meRlp2Q8QGnnurpxJPIGw59orea4+9We9F1ijidNkBZ
         uV1hdPpOFwiPqFmqcWgFv7cRPUewziMg4Ruxikh21ugAin7/GK31ZVYwhO5kOhibpFiq
         Zz7w==
X-Gm-Message-State: AC+VfDzxB6te+In0/qQ68lZbGAEXNDJ3uWW2xTFlzARL2LLd7DeXfX8+
        YWGXXw4HHOiuoO8l1WsZ6hRy1nb9WHRr2w==
X-Google-Smtp-Source: ACHHUZ4M9Mg9GohFqB49/jg+LC4K34AUEzFt1Z2mHMSPXcCeOCJ0KA1GQ4bZW425KMD4kZtgqWlNuQ==
X-Received: by 2002:a05:6a20:9191:b0:10b:9dc1:c5e5 with SMTP id v17-20020a056a20919100b0010b9dc1c5e5mr28496695pzd.34.1687815928846;
        Mon, 26 Jun 2023 14:45:28 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id k26-20020aa790da000000b00642f1e03dc1sm4294080pfk.174.2023.06.26.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:45:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jun 2023 11:45:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue changes for-6.5
Message-ID: <ZJoG-BptcGoHII35@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab:

  media: nxp: imx8-isi: fix buiding on 32-bit (2023-05-08 09:10:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.5

for you to fetch changes up to 18c8ae813156a6855f026de80fffb91e1a28ab3d:

  workqueue: Disable per-cpu CPU hog detection when wq_cpu_intensive_thresh_us is 0 (2023-05-25 10:46:53 -1000)

----------------------------------------------------------------
workqueue: Changes for v6.5

* Concurrency-managed per-cpu work items that hog CPUs and delay the
  execution of other work items are now automatically detected and excluded
  from concurrency management. Reporting on such work items can also be
  enabled through a config option.

* Added tools/workqueue/wq_monitor.py which improves visibility into
  workqueue usages and behaviors.

* Includes Arnd's minimal fix for gcc-13 enum warning on 32bit compiles.
  This conflicts with afa4bb778e48 ("workqueue: clean up WORK_* constant
  types, clarify masking") in master. Can be resolved by picking the master
  version.

----------------------------------------------------------------
Arnd Bergmann (1):
      workqueue: fix enum type for gcc-13

Paul E. McKenney (1):
      Further upgrade queue_work_on() comment

Tejun Heo (7):
      workqueue: Add pwq->stats[] and a monitoring script
      workqueue: Re-order struct worker fields
      workqueue: Move worker_set/clr_flags() upwards
      workqueue: Improve locking rule description for worker fields
      workqueue: Automatically mark CPU-hogging work items CPU_INTENSIVE
      workqueue: Report work funcs that trigger automatic CPU_INTENSIVE mechanism
      workqueue: Track and monitor per-workqueue CPU time usage

Zqiang (2):
      workqueue: Fix WARN_ON_ONCE() triggers in worker_enter_idle()
      workqueue: Disable per-cpu CPU hog detection when wq_cpu_intensive_thresh_us is 0

 Documentation/admin-guide/kernel-parameters.txt |  12 +
 Documentation/core-api/workqueue.rst            |  32 +++
 include/linux/workqueue.h                       |   2 +-
 kernel/sched/core.c                             |   3 +
 kernel/workqueue.c                              | 322 +++++++++++++++++++-----
 kernel/workqueue_internal.h                     |  24 +-
 lib/Kconfig.debug                               |  13 +
 tools/workqueue/wq_monitor.py                   | 168 +++++++++++++
 8 files changed, 500 insertions(+), 76 deletions(-)
 create mode 100644 tools/workqueue/wq_monitor.py
