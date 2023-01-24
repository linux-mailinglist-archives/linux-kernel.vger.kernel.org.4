Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE8867A10D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjAXSR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjAXSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:17:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064F355A1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=SntAzMBO3bJKyNhtYzvu12a2G3VGXSJyPQenLuZjxb8=; b=1ZesVOV+ndjJQBsRoDxfmxbL9T
        iUxjsU9Wk8h6qapNtgyURpnnGuDwB2W0ZrKTE0l11Zr1T+CHp+aqfXGMiWi8cfYx0PZgkLzWHS9l+
        J6xojKN4hy5sOaNgU8yOQ0wDrqpLfv0LoYAGs8Im/yX6ldY4jTvu+9rmqTNWtyWvlKBRX6MOM91Mu
        Wu+iuKsephs7j1zfZ/TjfYaeZXl2IAkbAIE6H9pxMF4kAu4mUerGKBwVCapw5Smz+XGm4oiuk1qPO
        WedJz3dAK/7DplZYNOqLLFHaopRWBXA0wCFOQfdYj+jMRyahQYzNCdZUueR7Y6VWC9vPO6kcQpa5V
        OszDu7gQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKNrm-004vqT-GK; Tue, 24 Jan 2023 18:17:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86: Kconfig: fix spellos & punctuation
Date:   Tue, 24 Jan 2023 10:17:53 -0800
Message-Id: <20230124181753.19309-1-rdunlap@infradead.org>
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

Fix spelling (reported by codespell) & punctuation in arch/x86/ Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -- a/arch/x86/Kconfig b/arch/x86/Kconfig
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1501,7 +1501,7 @@ config X86_5LEVEL
 	depends on X86_64
 	help
 	  5-level paging enables access to larger address space:
-	  upto 128 PiB of virtual address space and 4 PiB of
+	  up to 128 PiB of virtual address space and 4 PiB of
 	  physical address space.
 
 	  It will be supported by future Intel CPUs.
@@ -2607,8 +2607,8 @@ config CALL_THUNKS_DEBUG
 	  a noisy dmesg about callthunks generation and call patching for
 	  trouble shooting. The debug prints need to be enabled on the
 	  kernel command line with 'debug-callthunks'.
-	  Only enable this, when you are debugging call thunks as this
-	  creates a noticable runtime overhead. If unsure say N.
+	  Only enable this when you are debugging call thunks as this
+	  creates a noticeable runtime overhead. If unsure say N.
 
 config CPU_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
