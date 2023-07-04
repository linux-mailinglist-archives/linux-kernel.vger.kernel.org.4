Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2C7468E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGDFYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:24:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DE9BD;
        Mon,  3 Jul 2023 22:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fiR1+lFkN2QVNdbkR0zd5B6McX2iHjjNhF7dWolHvAY=; b=od2wZMvbbm+a53f1gqi9uGaZ7D
        A14n+3uWiMVP/UqCNg8bHm39l054jjJdJT/iod1S9+2mCrBwlDAuzUARuJ4fp8UiMRoqMzkf8plsi
        +6Bw2JZDgRXGnDjQG9MVT7IKyk8fFkXsq7raPYW+jH4FMWp17ThqD9nkwn6yMu2Y4WgkR47ToiAEr
        HsHo6kWdzsxixrS1k9f4DZXRge7Gfqqc9Uqme1WxTeNlkm2GIC4LvVxh++UMYQR1wue7FIb0r71Jg
        v4TnMuqXw6SgOeQpv2wUfgHa49GiOmnP4wS4vG7R851Guu9E67UfipygyLTf8dBVhCoyTcGjAppLw
        ADjrG16A==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGYWE-00CCEU-0C;
        Tue, 04 Jul 2023 05:24:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/3] docs: time: make separate section for time and timers
Date:   Mon,  3 Jul 2023 22:24:03 -0700
Message-ID: <20230704052405.5089-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give time & timer APIs their own section and begin adding
entries to that section. Move hrtimers immediately after
this new section so that they are all together.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/driver-api/basics.rst |   27 +++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff -- a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -15,8 +15,8 @@ Driver device table
    :no-identifiers: pci_device_id
 
 
-Delaying, scheduling, and timer routines
-----------------------------------------
+Delaying and scheduling routines
+--------------------------------
 
 .. kernel-doc:: include/linux/sched.h
    :internal:
@@ -33,16 +33,16 @@ Delaying, scheduling, and timer routines
 .. kernel-doc:: include/linux/completion.h
    :internal:
 
-.. kernel-doc:: kernel/time/timer.c
-   :export:
-
-Wait queues and Wake events
----------------------------
+Time and timer routines
+-----------------------
 
-.. kernel-doc:: include/linux/wait.h
+.. kernel-doc:: include/linux/jiffies.h
    :internal:
 
-.. kernel-doc:: kernel/sched/wait.c
+.. kernel-doc:: kernel/time/time.c
+   :export:
+
+.. kernel-doc:: kernel/time/timer.c
    :export:
 
 High-resolution timers
@@ -57,6 +57,15 @@ High-resolution timers
 .. kernel-doc:: kernel/time/hrtimer.c
    :export:
 
+Wait queues and Wake events
+---------------------------
+
+.. kernel-doc:: include/linux/wait.h
+   :internal:
+
+.. kernel-doc:: kernel/sched/wait.c
+   :export:
+
 Internal Functions
 ------------------
 
