Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7068F8B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBHURg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBHURe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:17:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF05247;
        Wed,  8 Feb 2023 12:17:33 -0800 (PST)
Date:   Wed, 08 Feb 2023 20:17:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675887451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=49o2DMV74m2/YRhGp6hKoz34L64JnGl89lPRWJulmhk=;
        b=4LYdjyp1qGgsg63DQ8YosMrhz77UwnR42DiKXWdb9qKNN1+QIlrTz1m0tAu7SJ9oMzXiDC
        WhrdI8pdT0CIm1qbDprWZsiirKu1ThVonEJqHognIe6posor+JGE+yJsIkeltzj7EWGOMe
        OMR4WkEWYcdnmP7iX97gquGEH7qO9NKO07Gdy6hTad6XRGAeS9pBDN9yPB98nAmuF33s5h
        Ftft3O3SRWDRBZsFV5jD6Qb2tjOfm3+Rpqy67Eclk6JwHrkWgFUeOMK1rOUPnbG0WD2hFj
        NB76r3JnOl+mWRux72YmN1cssHyf35ePv1ShW/t6/iw4sqdCa4a+8P7K2ieAVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675887451;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=49o2DMV74m2/YRhGp6hKoz34L64JnGl89lPRWJulmhk=;
        b=sVF/37RdkTeYtwVfzDtIN+JWFyc8RNaDfDcY7642Lt04eXvXjmEHDcVD800SDrXxG+k+II
        fz9khSEd1VOGFyCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add Lunar Lake M
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167588745117.4906.6363903779678696215.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f545e8831e70065e127f903fc7aca09aa50422c7
Gitweb:        https://git.kernel.org/tip/f545e8831e70065e127f903fc7aca09aa50422c7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 08 Feb 2023 09:23:40 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 08 Feb 2023 12:04:35 -08:00

x86/cpu: Add Lunar Lake M

Intel confirmed the existence of this CPU in Q4'2022
earnings presentation.

Add the CPU model number.

[ dhansen: Merging these as soon as possible makes it easier
	   on all the folks developing model-specific features. ]

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20230208172340.158548-1-tony.luck%40intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 347707d..cbaf174 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -123,6 +123,8 @@
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
+#define INTEL_FAM6_LUNARLAKE_M		0xBD
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
