Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA35F4397
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJDMwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiJDMwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:52:13 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98731E73F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:49:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id E9C66407526E;
        Tue,  4 Oct 2022 12:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E9C66407526E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1664887713;
        bh=sUXQe+fwTdVPmAo3+a8ZUpQ/oAz1Unh0rRHenfdbYlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCMCrYiT+FOWYGq+lJxnlO9f5HYrGbScXzInZV0Esu90g/pETvwoYBKutOkbRCliS
         wA9djSKEnPs00zJzt8hbPIdf5U/mDcwtRV60fa8XaeWw9+azft5BHjHmZ3znx+TmJM
         /hX5g9zdZQ97G02AoifV+CPJe7reUaDTqoGxN0dg=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v7 5/5] x86/boot: Remove no longer needed includes
Date:   Tue,  4 Oct 2022 15:48:24 +0300
Message-Id: <d5028f358a43f6443a37efeb6e095286711ea42a.1664886978.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1664886978.git.baskov@ispras.ru>
References: <cover.1664886978.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/incldue/asm/shared/cmdline.h header already provides
COMMAND_LINE_SIZE definition.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/ident_map_64.c | 4 ----
 arch/x86/boot/compressed/kaslr.c        | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d4a314cc50d6..fdfe0e5f5cb0 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -33,10 +33,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 4a3f223973f4..39e455c105a7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -31,10 +31,6 @@
 #include <linux/ctype.h>
 #include <generated/utsrelease.h>
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Simplified build-specific string for starting entropy. */
-- 
2.35.1

