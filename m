Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68AC7304DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjFNQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFNQ1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:27:30 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 09:27:29 PDT
Received: from zulu.geekplace.eu (zulu.geekplace.eu [IPv6:2a03:4000:6:3a8::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE402121;
        Wed, 14 Jun 2023 09:27:29 -0700 (PDT)
Received: from neo-pc.sch (unknown [62.144.54.52])
        by zulu.geekplace.eu (Postfix) with ESMTPA id 8EEFC4A0DBC;
        Wed, 14 Jun 2023 18:09:55 +0200 (CEST)
From:   Florian Schmaus <flo@geekplace.eu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Schmaus <flo@geekplace.eu>
Subject: [PATCH] docs/scheduler: fix typos in sched-bwc
Date:   Wed, 14 Jun 2023 18:09:39 +0200
Message-Id: <20230614160939.156850-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two typos in Documentation/scheduler/sched-bwc.rst.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 Documentation/scheduler/sched-bwc.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index f166b182ff95..90a6e11d4465 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -31,7 +31,7 @@ Traditional (UP-EDF) bandwidth control is something like:
 
   (U = \Sum u_i) <= 1
 
-This guaranteeds both that every deadline is met and that the system is
+This guarantees both that every deadline is met and that the system is
 stable. After all, if U were > 1, then for every second of walltime,
 we'd have to run more than a second of program time, and obviously miss
 our deadline, but the next deadline will be further out still, there is
@@ -59,7 +59,7 @@ At the same time, we can say that the worst case deadline miss, will be
 \Sum e_i; that is, there is a bounded tardiness (under the assumption
 that x+e is indeed WCET).
 
-The interferenece when using burst is valued by the possibilities for
+The interference when using burst is valued by the possibilities for
 missing the deadline and the average WCET. Test results showed that when
 there many cgroups or CPU is under utilized, the interference is
 limited. More details are shown in:
-- 
2.39.3

