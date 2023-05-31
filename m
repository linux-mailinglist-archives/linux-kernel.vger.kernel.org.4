Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0CE718E38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjEaWON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjEaWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:14:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6D1A1;
        Wed, 31 May 2023 15:13:52 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685571216;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N475Qv8/OwV8b+hkVUDlDliQENptv3wl8TaAvhVjmG4=;
        b=JUmVl0ViVE7nTnrkI4N9W4f7XjuaOIysk3l7fMMrV3P0CUnGBs9krSc0dXEd8+xbJbsKlR
        VpINFQ9qcEMR9PZMfL+/GJUaspYAtIHe/a2f6YpU/PGDrkWlcLOzvbLau4Jj/6m9xw6g+n
        2gICNArUcyrw0k8cQSKybaEnMnJYt853o4KuzzDAn1RDwZd7sVPDTJ4BKzwqOK5ufavHrp
        7dCzl5wfFEHRSgiW5/LAUNWMPQ/KJLbUoi9S0oEjw41IaUMxYSKwV3Y7Ky5kFCGJ/LbMaa
        6owEmNJ1n3/slxKBc+aZIQTIYFazqGEmSif61BPTbgwsHrQ+ys+WwaPKi3IdWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685571216;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N475Qv8/OwV8b+hkVUDlDliQENptv3wl8TaAvhVjmG4=;
        b=3v/WlxDYkja4ouB7s+C3siaSpElh6mEtj5mHtIYwStT8E2QfSKdGRppcUhp8YmSoxQA7NU
        8zPrwuvarXQXvoCQ==
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove remaining BUG_ON() and
 BUG() calls
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168557121537.404.10874117815747545344.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     89827568a82d5856f3c8d329d3c2bc0f47385eb9
Gitweb:        https://git.kernel.org/tip/89827568a82d5856f3c8d329d3c2bc0f47385eb9
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 19 May 2023 14:07:51 -05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 May 2023 09:35:00 -07:00

x86/platform/uv: Remove remaining BUG_ON() and BUG() calls

Replace BUG and BUG_ON with WARN_ON_ONCE and carry on as best as we
can.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230519190752.3297140-8-steve.wahl%40hpe.com
---
 arch/x86/kernel/apic/x2apic_uv_x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 10d3bdf..1836330 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -617,7 +617,8 @@ static __init void build_uv_gr_table(void)
 
 	bytes = _gr_table_len * sizeof(struct uv_gam_range_s);
 	grt = kzalloc(bytes, GFP_KERNEL);
-	BUG_ON(!grt);
+	if (WARN_ON_ONCE(!grt))
+		return;
 	_gr_table = grt;
 
 	for (; gre->type != UV_GAM_RANGE_TYPE_UNUSED; gre++) {
@@ -1548,7 +1549,8 @@ static void __init build_socket_tables(void)
 			return;
 		}
 		pr_err("UV: Error: UVsystab address translations not available!\n");
-		BUG();
+		WARN_ON_ONCE(!gre);
+		return;
 	}
 
 	numn = num_possible_nodes();
