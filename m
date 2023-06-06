Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D59272445F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjFFN1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFFN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:27:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDEC10C0;
        Tue,  6 Jun 2023 06:27:37 -0700 (PDT)
Date:   Tue, 06 Jun 2023 13:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686058056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=obX2WX9h0kIhbFoPF8VBp4LjF5H5wMOuTw92LriOL+8=;
        b=vGEkZ7bwfa8F34l4jjXUvwtPHL5TvWBt2G7D81GkvosLt/wXTUJlO6R68k4xlCzOmksE07
        kmQEJyQOzbpN9H+dduOqUrrDQLA4gasvBP2kWTHQ9VBA6AwIGkdilGtud5MASFRifsOowO
        tkBDlZFBPKsUtpZgsEmsD4Mj3QwGakZIu/X7rgJXsTrQS9GgIFUbxApD/2IpNgAWqk7ztB
        MGgOdgy1cTOPLi2ryHXLqzHgfmoQYUpbBVqUgaj+jXWT9DJqSrO2hIrnE/i4wLrzauMFOi
        +p7TKxxd26Pd/J1Rs+8slIQHhsZhv6m0haMiWFl7VZNSZ1R1ljYs8HvScUj0dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686058056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=obX2WX9h0kIhbFoPF8VBp4LjF5H5wMOuTw92LriOL+8=;
        b=CgE+P5ZpJvCNZpCsdC52cwaGA1KklVSIQHDlMT8JJAoIDWL4Zvyys04ItUAuOuA0KSHvRG
        eWVaPx+1qswFkEAQ==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/lib/msr: Clean up kernel-doc notation
Cc:     kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168605805581.404.4652362165400702070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b26d3d054de18f2334e06985e508083b2f32a101
Gitweb:        https://git.kernel.org/tip/b26d3d054de18f2334e06985e508083b2f32a101
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Tue, 11 Apr 2023 16:45:03 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 06 Jun 2023 15:19:50 +02:00

x86/lib/msr: Clean up kernel-doc notation

Convert x86/lib/msr.c comments to kernel-doc notation to
eliminate kernel-doc warnings:

  msr.c:30: warning: This comment starts with '/**', but isn't \
  a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
  ...

Fixes: 22085a66c2fa ("x86: Add another set of MSR accessor functions")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/oe-kbuild-all/202304120048.v4uqUq9Q-lkp@intel.com/
---
 arch/x86/lib/msr.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index b09cd2a..47fd9bd 100644
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
@@ -49,10 +49,12 @@ static int msr_read(u32 msr, struct msr *m)
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
@@ -88,12 +90,14 @@ static inline int __flip_bit(u32 msr, u8 bit, bool set)
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
