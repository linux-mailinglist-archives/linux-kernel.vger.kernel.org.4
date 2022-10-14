Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC2B5FEB98
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJNJ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJNJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:28:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5BE1C69F0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:28:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l22so6043776edj.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cBer2GEwLDqWtk5rNwSGvKwXRghOgJjbD3n6X1wartM=;
        b=UjN6FvcMrQ05sUSCbxoj1X+dk5aCbKAug4Zhrw1lSFehGFbPwwAaFvE8Y/eAdHDHJr
         QEmx0uC2PRrm5YXh7ti8X8HT5KNko9uZ5YWO7YkLRKRQqI5tuB7SgJ7dslu8b8zhfHHY
         UnCneiEe4ag5EwoSs1tmEFYkgKxyMzTghPJ2KF0O+Ddha1GMoiUsG3zbwWgZ/e8VbplG
         1F1/2tnO2tUTl+qY4XDXvd0CHbKMJDlAXsYJ7o1IO5VnYiPRSR1Fc84dVZAYDUI3xZep
         rYFnia0OeHLYV6mWoKq+hnVpOdAzRP3vQCvEjymhNdol521ylk7BCu3KFONMwuB0fw5J
         K+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBer2GEwLDqWtk5rNwSGvKwXRghOgJjbD3n6X1wartM=;
        b=p1HaUFeEXxqWEKPXNy/0mcCBNV6fsaEyC4ePyeoi5NdxEcIWYNIowSOzOG5fQhLoPu
         M7d58dZTRY+lAlk2JC69eRYPmKsub3oezK8ckmN0iklYElSwnb47Bc1wvdkUlDwP8bK+
         ++ixr2/1fT7/wsQSW7IqFvsBW3DtVZ12EJpD+nG29CErEHlDUt7FSm7DPw+Ra8a4DOV1
         PhymEKbfU0gykgyVffIT8CyKbFKqUSzaJ+V1EVEm/qxYI6rhi96bTq7XETn8o5FKWKZc
         ughd26XswyYG91cjCnNYzH4HusLs+M+/r21zwGSZdQ712qLYHLHxEpIugYCTDF7vMGY7
         vrHw==
X-Gm-Message-State: ACrzQf3KznrRTBtNM2CWwWr5SQoOaUHn5vM9WtqJwxHnG0YoW0rbI0dE
        v6JvuLyqwhPF5NNseoJ9Qrw=
X-Google-Smtp-Source: AMsMyM6UGyEz1LW4PLIUwy0ytiyRMNKbVy8ESAvMJJrHNBsldcs92w+lRPXXTCrVmp8HoLzveEKGFQ==
X-Received: by 2002:a05:6402:5288:b0:457:22e5:8022 with SMTP id en8-20020a056402528800b0045722e58022mr3432691edb.244.1665739693493;
        Fri, 14 Oct 2022 02:28:13 -0700 (PDT)
Received: from gmail.com (1F2EF605.nat.pool.telekom.hu. [31.46.246.5])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906191000b0078ae49ad169sm1259842eje.91.2022.10.14.02.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 02:28:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 14 Oct 2022 11:28:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [GIT PULL] sched/psi changes for v6.1
Message-ID: <Y0krqnKlHb/gp9Za@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest sched/psi git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-psi-2022-10-14

   # HEAD: 34f26a15611afb03c33df6819359d36f5b382589 sched/psi: Per-cgroup PSI accounting disable/re-enable interface

PSI updates for v6.1:

 - Various performance optimizations, resulting in a 4%-9% speedup
   in the mmtests/config-scheduler-perfpipe micro-benchmark.

 - New interface to turn PSI on/off on a per cgroup level.

MERGE NOTES:

 - The cgroup interface was suggested & acked by the cgroup maintainers.

 - There's a merge commit in the tree, because the changes rely on
   driver-core kernfs changes to hit upstream first. This is why
   this tree was sent late in the merge window as well.

 - There will be a new conflict in kernel/cgroup/cgroup.c when
   merged into your tree at 9c9155a3509a.

   Most of the conflicts are straightforward, but there's a semantic
   conflict between these two commits:

     cgroup-tree/upstream:   8a693f7766f9 ("cgroup: Remove CFTYPE_PRESSURE")
     sched/psi tree:         34f26a15611a ("sched/psi: Per-cgroup PSI accounting disable/re-enable interface")

   8a693f7766f9 removes the CFTYPE_PRESSURE flag, while 34f26a15611a adds
   new uses. This semantic conflict will result in a build failure on
   certain configs.

   The resolution I used in -tip is to remove the two new lines adding
   CFTYPE_PRESSURE flags use in 34f26a15611a.

Thanks,

	Ingo

------------------>

Chengming Zhou (9):
      sched/psi: Fix periodic aggregation shut off
      sched/psi: Don't create cgroup PSI files when psi_disabled
      sched/psi: Save percpu memory when !psi_cgroups_enabled
      sched/psi: Move private helpers to sched/stats.h
      sched/psi: Optimize task switch inside shared cgroups again
      sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure
      sched/psi: Consolidate cgroup_psi()
      sched/psi: Cache parent psi_group to speed up group iteration
      sched/psi: Per-cgroup PSI accounting disable/re-enable interface

Johannes Weiner (1):
      sched/psi: Remove NR_ONCPU task accounting

Peter Zijlstra (1):
      Merge branch 'driver-core/driver-core-next'

 Documentation/admin-guide/cgroup-v2.rst |  23 +++
 include/linux/cgroup-defs.h             |   3 +
 include/linux/cgroup.h                  |   5 -
 include/linux/psi.h                     |  12 +-
 include/linux/psi_types.h               |  31 ++--
 kernel/cgroup/cgroup.c                  | 104 +++++++++++-
 kernel/sched/core.c                     |   1 +
 kernel/sched/psi.c                      | 280 +++++++++++++++++++++++---------
 kernel/sched/stats.h                    |   6 +
 9 files changed, 362 insertions(+), 103 deletions(-)
