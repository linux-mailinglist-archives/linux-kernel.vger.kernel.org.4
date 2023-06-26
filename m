Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A72173EACC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjFZTAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjFZTAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:00:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE78F2;
        Mon, 26 Jun 2023 12:00:38 -0700 (PDT)
Date:   Mon, 26 Jun 2023 19:00:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687806036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=30e9VrY39/o3XR14k+aVZA4WrmuG0PuMQ2f9fm/xCvY=;
        b=iQcX+1b7OImJbjJM+Pupa6G7ADzFFocpOgDt+BgTfqfiQp3DlbX/i6GqJieXrL3pN8cvxg
        8yeA+CG1baiID0npyclCDkBmhFM8R0PXwvGcb1Wh/7jTRBnBVLKJoe9ZvCHveSlaMnh2Lp
        VsAw6mrESDPtdHZrTy0sswuPULtGGqVqZdodXdoneyEHI/tAO9E2Nqownavtay0lNfLWRY
        mfdz/U2ME7ZsELyoaOFvlM84l8Kdztc9AAQV1UmsdiO6D7WyIpJf5Qnsoqy8hj2Fnxhz5w
        ZXdlFrHGm3VvkkkEgSzfwBkKrzw9Z7RtFV8UZSwkQQKpWf0Bo9WbYZ655QDbyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687806036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=30e9VrY39/o3XR14k+aVZA4WrmuG0PuMQ2f9fm/xCvY=;
        b=MKZgBEq7tRUeqFnUR1Wo9S0fe6JvPJXfgK+KlVfZy0VLHu3rq342fCDIo2uHc9hQCfeqIB
        RoZ0hhOyhFKKmyAg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix up tabs vs. spaces in early init comment
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168780603570.404.15377073915465012514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     8b380f9a45ca1716c69391cb01c0e27771bcec2c
Gitweb:        https://git.kernel.org/tip/8b380f9a45ca1716c69391cb01c0e27771bcec2c
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 26 Jun 2023 11:49:04 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 26 Jun 2023 11:49:04 -07:00

x86/tdx: Fix up tabs vs. spaces in early init comment

Fix up tabs vs. spaces problem introduced at commit time.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5b8056f..a03dff5 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -887,7 +887,7 @@ void __init tdx_early_init(void)
 	 * things happen on mismatch:
 	 *
 	 *   - Private mapping => Shared Page  == Guest shutdown
-         *   - Shared mapping  => Private Page == Recoverable #VE
+	 *   - Shared mapping  => Private Page == Recoverable #VE
 	 *
 	 * guest.enc_status_change_prepare() converts the page from
 	 * shared=>private before the mapping becomes private.
