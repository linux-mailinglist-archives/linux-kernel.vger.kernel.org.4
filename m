Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D159767A104
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjAXSQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjAXSQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:16:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD74DE2F;
        Tue, 24 Jan 2023 10:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=udUpLgayI0SdNW12BCKKvCoh/6uaxuELj1ZkskTToMw=; b=xjAtajNIaLTa81A4ZM07krYwIi
        Sbku/EETtE1MA5+8k0vPJ3JaCU0HXAy1cTU8zsbOonywMZHxE6CAX5NCpeTYEn4P+n9fOh7IwKPMX
        qn3X066C+JBLVXGc3zsb/Nfrj/dCrmQyBbGrNpalO8RLVb7vzlgJ6ulB7F199haLSIfshp2uuBqMv
        ZRm1S8XsZwCkJTtfVbTQ72s5161qMcxjtkmPECsniP59EUxyR+hhbnY5aT4sbT+2Xm4XzpHNqez9h
        ECIAkJknXcDXpgdrohymX0nPZXK6DH2bG+bqYI8R41Ce5wCjhZN4xM/7Yllw4VyELO+jz7gtzhddg
        TgTv9XoQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNqi-004vab-93; Tue, 24 Jan 2023 18:16:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] trace: Kconfig: fix spelling/grammar/punctuation
Date:   Tue, 24 Jan 2023 10:16:47 -0800
Message-Id: <20230124181647.15902-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
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

Fix some editorial nits in trace Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 kernel/trace/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/kernel/trace/Kconfig b/kernel/trace/Kconfig
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -933,8 +933,8 @@ config RING_BUFFER_RECORD_RECURSION
 	default y
 	help
 	  The ring buffer has its own internal recursion. Although when
-	  recursion happens it wont cause harm because of the protection,
-	  but it does cause an unwanted overhead. Enabling this option will
+	  recursion happens it won't cause harm because of the protection,
+	  but it does cause unwanted overhead. Enabling this option will
 	  place where recursion was detected into the ftrace "recursed_functions"
 	  file.
 
@@ -1017,8 +1017,8 @@ config RING_BUFFER_STARTUP_TEST
 	 The test runs for 10 seconds. This will slow your boot time
 	 by at least 10 more seconds.
 
-	 At the end of the test, statics and more checks are done.
-	 It will output the stats of each per cpu buffer. What
+	 At the end of the test, statistics and more checks are done.
+	 It will output the stats of each per cpu buffer: What
 	 was written, the sizes, what was read, what was lost, and
 	 other similar details.
 
