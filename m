Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2465E157
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbjAEAKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjAEAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D143A20;
        Wed,  4 Jan 2023 16:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 645CFB81983;
        Thu,  5 Jan 2023 00:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20065C433F1;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=FzkboUT+mHioIWdRgUQ1Pv6Fjcpxk2Vxw+5VTWcH2nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhW5Rhk3h2P9grPu6H10yXEuYHKBByIe20q+iFWnIfNGQ1cwb16yxu7B2q7gjumgQ
         0aN0xbb09qJD7v0Lh9Cro2zHAGWj8PFl5iyMunQo/OPYucQv/4YWDvcfkHpBynTtK+
         C4ebexVsFiikvYgfcfmwABl5vPGZHqGah36/BSEbmiGmUEW4TaGpSz7jQndsZruSfF
         iGX+uO5t/QqGA3vcT1yibcrTCEFGLmUfFL9vxLCobdxRTxktt6YbycOY7cvP1+txGu
         P3u3VKsP2jiJdR8/qRGt/z4kUeOIq6xUF5m4Q7jDmoMmkIxM0jy4WZD3RPku8c57fQ
         c5NWon8K8MoPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C5B835C086D; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/15] doc: Update NMI-RCU.rst
Date:   Wed,  4 Jan 2023 16:09:42 -0800
Message-Id: <20230105000955.1767218-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates NMI-RCU.rst to highlight the ancient heritage of
the example code and to discourage wanton compiler "optimizations".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/NMI-RCU.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/NMI-RCU.rst b/Documentation/RCU/NMI-RCU.rst
index 2a92bc685ef1a..dff60a80b386e 100644
--- a/Documentation/RCU/NMI-RCU.rst
+++ b/Documentation/RCU/NMI-RCU.rst
@@ -8,7 +8,7 @@ Although RCU is usually used to protect read-mostly data structures,
 it is possible to use RCU to provide dynamic non-maskable interrupt
 handlers, as well as dynamic irq handlers.  This document describes
 how to do this, drawing loosely from Zwane Mwaikambo's NMI-timer
-work in "arch/x86/kernel/traps.c".
+work in an old version of "arch/x86/kernel/traps.c".
 
 The relevant pieces of code are listed below, each followed by a
 brief explanation::
@@ -116,7 +116,7 @@ Answer to Quick Quiz:
 
 	This same sad story can happen on other CPUs when using
 	a compiler with aggressive pointer-value speculation
-	optimizations.
+	optimizations.  (But please don't!)
 
 	More important, the rcu_dereference_sched() makes it
 	clear to someone reading the code that the pointer is
-- 
2.31.1.189.g2e36527f23

