Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD8D70B1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjEUW6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUW6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:58:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14658BE
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BXUO1wgjEjTKJJJ0W0k6Aejv/+QwkUlBVT276pYvRHE=; b=Fj9xeJAJlkOs0Jj6NIZ1QfEjXc
        0kRSuhsYHT09Hjin7VlS3XoS9HKE87Xtm3oX+tkGIWNq9OgaaHsKk1iWSweA6QsdjRPE4SQZJMAUJ
        +oKtsiVOMpm/Jt7+/CxmosIOlMza3x8izRu3SRFwvrhUG8NrqJFodv3CxnE9ajnqMIOB0KaaNS4i0
        Rv2oUF1Py0wpAvmaYfbl+fbgTaQWBWoBlPEqbLmhPk37v9XVe/zRS+9EIvjY/jX1zMBQS+AZusuae
        oMEeHzNBB1OLmHQC7wC5ICywp+jf+ruw99lpim4Er9TA4FVMGPpFQYBDDvP8fEU3VvnxnOsN0yMNf
        3W9XlfcA==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0s0K-004oEt-0C;
        Sun, 21 May 2023 22:58:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH RESEND] x86: msr: clean up kernel-doc notation
Date:   Sun, 21 May 2023 15:58:19 -0700
Message-Id: <20230521225819.4737-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert x86/lib/msr.c comments to kernel-doc notation to
eliminate kernel-doc warnings:

msr.c:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Read an MSR with error handling
msr.c:52: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Write an MSR with error handling
msr.c:91: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Set @bit in a MSR @msr.
msr.c:104: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Clear @bit in a MSR @msr.

Fixes: 22085a66c2fa ("x86: Add another set of MSR accessor functions")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304120048.v4uqUq9Q-lkp@intel.com/
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
---
 arch/x86/lib/msr.c |   32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff -- a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -27,14 +27,14 @@ void msrs_free(struct msr *msrs)
 EXPORT_SYMBOL(msrs_free);
 
 /**
- * Read an MSR with error handling
- *
+ * msr_read - Read an MSR with error handling
  * @msr: MSR to read
  * @m: value to read into
  *
  * It returns read data only on success, otherwise it doesn't change the output
  * argument @m.
  *
+ * Return: %0 for success, otherwise an error code
  */
 static int msr_read(u32 msr, struct msr *m)
 {
@@ -49,10 +49,12 @@ static int msr_read(u32 msr, struct msr
 }
 
 /**
- * Write an MSR with error handling
+ * msr_write - Write an MSR with error handling
  *
  * @msr: MSR to write
  * @m: value to write
+ *
+ * Return: %0 for success, otherwise an error code
  */
 static int msr_write(u32 msr, struct msr *m)
 {
@@ -88,12 +90,14 @@ static inline int __flip_bit(u32 msr, u8
 }
 
 /**
- * Set @bit in a MSR @msr.
+ * msr_set_bit - Set @bit in a MSR @msr.
+ * @msr: MSR to write
+ * @bit: bit number to set
  *
- * Retval:
- * < 0: An error was encountered.
- * = 0: Bit was already set.
- * > 0: Hardware accepted the MSR write.
+ * Return:
+ * * < 0: An error was encountered.
+ * * = 0: Bit was already set.
+ * * > 0: Hardware accepted the MSR write.
  */
 int msr_set_bit(u32 msr, u8 bit)
 {
@@ -101,12 +105,14 @@ int msr_set_bit(u32 msr, u8 bit)
 }
 
 /**
- * Clear @bit in a MSR @msr.
+ * msr_clear_bit - Clear @bit in a MSR @msr.
+ * @msr: MSR to write
+ * @bit: bit number to clear
  *
- * Retval:
- * < 0: An error was encountered.
- * = 0: Bit was already cleared.
- * > 0: Hardware accepted the MSR write.
+ * Return:
+ * * < 0: An error was encountered.
+ * * = 0: Bit was already cleared.
+ * * > 0: Hardware accepted the MSR write.
  */
 int msr_clear_bit(u32 msr, u8 bit)
 {
