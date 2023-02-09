Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61566900FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBIHOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIHOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:14:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B899CA24A;
        Wed,  8 Feb 2023 23:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=r8hE41Mkp5EbgMrksb3KX7Dta0yeg7VtidU0DErrk9U=; b=SSwLatKOiislYacsoo/Qi3JMlm
        b47ynisAwSrwGZYUASI66PxrUlyXGIC+yTFVomaUau58oZFIBo8jpLh1nKCHpGG1hzYaKwBa1fm5V
        MGzmE4oBMeEqrdn5s5zpFUd8r4fPoJzBc5Ip5AwXp99OeI1O5RmT/VlSbt0BYAksgp45OfAwRygNx
        i/pzyJ1nycNY+Xw/zZ/bZ4J0UyKubduraexKOGpFEp+Z26FQ29A6BoKJCASscbE4D41ElbfTj4DLm
        CFJF1BTGKjk9PTmvQUBILAJfIGvPULY2mO3cn6qHTxry4AKsGjQ6XNrMZ74qioxOvAb4QQpypQ9Ag
        iioQY5nQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ18F-000LPt-A5; Thu, 09 Feb 2023 07:14:11 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH 16/24] Documentation: scheduler: correct spelling
Date:   Wed,  8 Feb 2023 23:13:52 -0800
Message-Id: <20230209071400.31476-17-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209071400.31476-1-rdunlap@infradead.org>
References: <20230209071400.31476-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/scheduler/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/scheduler/sched-bwc.rst    |    2 +-
 Documentation/scheduler/sched-energy.rst |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -186,7 +186,7 @@ average usage, albeit over a longer time
 also limits the burst ability to no more than 1ms per cpu.  This provides
 better more predictable user experience for highly threaded applications with
 small quota limits on high core count machines. It also eliminates the
-propensity to throttle these applications while simultanously using less than
+propensity to throttle these applications while simultaneously using less than
 quota amounts of cpu. Another way to say this, is that by allowing the unused
 portion of a slice to remain valid across periods we have decreased the
 possibility of wastefully expiring quota on cpu-local silos that don't need a
diff -- a/Documentation/scheduler/sched-energy.rst b/Documentation/scheduler/sched-energy.rst
--- a/Documentation/scheduler/sched-energy.rst
+++ b/Documentation/scheduler/sched-energy.rst
@@ -82,7 +82,7 @@ through the arch_scale_cpu_capacity() ca
 The rest of platform knowledge used by EAS is directly read from the Energy
 Model (EM) framework. The EM of a platform is composed of a power cost table
 per 'performance domain' in the system (see Documentation/power/energy-model.rst
-for futher details about performance domains).
+for further details about performance domains).
 
 The scheduler manages references to the EM objects in the topology code when the
 scheduling domains are built, or re-built. For each root domain (rd), the
@@ -281,7 +281,7 @@ mechanism called 'over-utilization'.
 From a general standpoint, the use-cases where EAS can help the most are those
 involving a light/medium CPU utilization. Whenever long CPU-bound tasks are
 being run, they will require all of the available CPU capacity, and there isn't
-much that can be done by the scheduler to save energy without severly harming
+much that can be done by the scheduler to save energy without severely harming
 throughput. In order to avoid hurting performance with EAS, CPUs are flagged as
 'over-utilized' as soon as they are used at more than 80% of their compute
 capacity. As long as no CPUs are over-utilized in a root domain, load balancing
