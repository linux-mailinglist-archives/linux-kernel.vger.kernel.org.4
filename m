Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781BD67ED8D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjA0SaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjA0S3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:29:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0B87366;
        Fri, 27 Jan 2023 10:29:31 -0800 (PST)
Date:   Fri, 27 Jan 2023 18:26:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674844017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=epPoCWc8lGbiioSxrNPnfmFjDOPTiTahBLnIiajrU/Y=;
        b=ziJZodseiKILLmtpkluvnOLFn1/6jS9ARfIdThOBMuem14ZGoTVlRjMTp1Lj7N+mV7Kh/a
        MwpwkLVUvHm/oj0hk9Re9Atj4SHx03VG5hZjTgKDyGe4hh8nsfG6Cl3Sw1ZT835PlbB3KY
        rSzWjZ8rrzOQ+MzDgeYDq+5w+dzgBpYeffeS2mAP66A/qrPIg0Lufh/50x/5trQwSVNXnP
        2i/aL6rvWOA3F/VLrxAdWCJFGwgIP2XJXhpPwKTLbA21XPegveaus4zUeY36EntH34uqZ0
        +7Tibnfm/HCbKVfxCZ38x01NLCvUsxe8oqKk9sqL24sWCXhHiaEXu78LoCMi6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674844017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=epPoCWc8lGbiioSxrNPnfmFjDOPTiTahBLnIiajrU/Y=;
        b=BLj40Xuox4ZzyRrGqCI08kd5MKIKCjk0xYBkYgRly35IUAa6/Cl2aGk99OZ8xG0iuOXQlC
        6s9ZhXoC1uyZaCCg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix typo in comment in __tdx_hypercall()
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167484401749.4906.16764493763561549726.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     3543f8830babe2666051fb239545f51e0aae4c84
Gitweb:        https://git.kernel.org/tip/3543f8830babe2666051fb239545f51e0aae4c84
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 27 Jan 2023 01:11:53 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 27 Jan 2023 09:42:09 -08:00

x86/tdx: Fix typo in comment in __tdx_hypercall()

Comment in __tdx_hypercall() points that RAX==0 indicates TDVMCALL
failure which is opposite of the truth: RAX==0 is success.

Fix the comment. No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230126221159.8635-2-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdcall.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index f9eb113..74b108e 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -155,7 +155,7 @@ SYM_FUNC_START(__tdx_hypercall)
 	tdcall
 
 	/*
-	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
+	 * RAX!=0 indicates a failure of the TDVMCALL mechanism itself and that
 	 * something has gone horribly wrong with the TDX module.
 	 *
 	 * The return status of the hypercall operation is in a separate
