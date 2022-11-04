Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674361A214
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKDUWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiKDUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:22:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F24C242;
        Fri,  4 Nov 2022 13:21:59 -0700 (PDT)
Date:   Fri, 04 Nov 2022 20:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667593317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/89bIBY0RSkqVteTwXt3Qyj4gljpdxQaHrKe/YxAtM=;
        b=GsOA/jHiSfPieVYVijcuWeIcw1tIIg9ZC1J+1lXFmgPuIwJI30aYc4FjcHgA0OqpLqnmMp
        EEufuUBxJAkOkLMw/l9YTotVEpqRVfPBnHrEl702dlZ3Hyo0RKxfEnFKRK+91koNkrtw23
        1O1ZHtXSEfjJB0jW5S1z4Pfyff57rOaaBEI6h2UrkE62+UtC2+4Hz3l1nMHwoILS+GYFwt
        /PU/u0ELnq6+o+62z3mz+hkAnGbGh6uFfdep4B2xZI5lnzH/MHI43idUv3Wt8moJ0+w0On
        NP3IBNkhsVACfR/x6utsFRmVWh5wKKHaUeO3i9fdtIfox2/1VQ9rwdrPXJmw0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667593317;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J/89bIBY0RSkqVteTwXt3Qyj4gljpdxQaHrKe/YxAtM=;
        b=8vP1PVeXPNzJuLILWKcR4yJ1j+JGwpNYRj0oR7b/wWvy3bJR09bTyjgWaHv+j6gCvJO4Ih
        El+Dttsw09KVKyBw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add several Intel server CPU model numbers
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221103203310.5058-1-tony.luck@intel.com>
References: <20221103203310.5058-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <166759331563.4906.3844769797250286252.tip-bot2@tip-bot2>
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

Commit-ID:     7beade0dd41d42d797ccb7791b134a77fcebf35b
Gitweb:        https://git.kernel.org/tip/7beade0dd41d42d797ccb7791b134a77fcebf35b
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 03 Nov 2022 13:33:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 04 Nov 2022 21:12:22 +01:00

x86/cpu: Add several Intel server CPU model numbers

These servers are all on the public versions of the roadmap. The model
numbers for Grand Ridge, Granite Rapids, and Sierra Forest were included
in the September 2022 edition of the Instruction Set Extensions document.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20221103203310.5058-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5d75fe2..347707d 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -107,6 +107,11 @@
 
 #define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Golden Cove */
 
+#define INTEL_FAM6_EMERALDRAPIDS_X	0xCF
+
+#define INTEL_FAM6_GRANITERAPIDS_X	0xAD
+#define INTEL_FAM6_GRANITERAPIDS_D	0xAE
+
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_N		0xBE
@@ -118,7 +123,7 @@
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
-/* "Small Core" Processors (Atom) */
+/* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
 #define INTEL_FAM6_ATOM_BONNELL_MID	0x26 /* Silverthorne, Lincroft */
@@ -145,6 +150,10 @@
 #define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
 #define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
 
+#define INTEL_FAM6_SIERRAFOREST_X	0xAF
+
+#define INTEL_FAM6_GRANDRIDGE		0xB6
+
 /* Xeon Phi */
 
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
