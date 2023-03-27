Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BED6CAF74
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjC0UKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjC0UJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:09:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B519AF;
        Mon, 27 Mar 2023 13:09:55 -0700 (PDT)
Date:   Mon, 27 Mar 2023 20:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/jg0IjOptV1RpO6xfMPKncUzgMu+5YqsOJB4MMvtx4=;
        b=ERrCNWv4o0+DbOFz0yFNgU5aso5HtbpKHBmAmJyvnZq6Ip1OGJtYSzQ+9wXp+YKicAaSCL
        fepRRwOpETnaQKwiDHN92AER7LEUxPJljPoU2jXwp6DiRo9WHeQCBbRG+A+zbzOEu/h3KL
        ooV/wogu5Miz8p/TsZU9FIT33ydw6OUNg8i6MCYzoS4QLEe5W2bhLSQS1RX2qRlvjTCPOc
        IOw5zB0q4S9g2cBY3FDhXsDkZqqwg4469ahq1mTBX/zLTOF/jopNLHQYRQE0j6HjBa2qGW
        v7NA5hSPOv29DAIt6sTu9TpDa9OHoQUWTGHKmwYVqkWpPuySpnz6ePko9q19cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679947793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/jg0IjOptV1RpO6xfMPKncUzgMu+5YqsOJB4MMvtx4=;
        b=XqaeGPDrzuMiNOqaa1Evo0LWoPkCsPydph7kCP25AEfefvI99qGOZYh2cBxLhDgTxrVWWp
        4H/nxRSOIUufn9Cg==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/hyperv: Reorder code to facilitate future work
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1679838727-87310-3-git-send-email-mikelley@microsoft.com>
References: <1679838727-87310-3-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <167994779344.5837.1535425214409753862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     71290be18f2deeae013482bf79cd526df61fcfcd
Gitweb:        https://git.kernel.org/tip/71290be18f2deeae013482bf79cd526df61fcfcd
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Sun, 26 Mar 2023 06:51:57 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 27 Mar 2023 07:56:40 +02:00

x86/hyperv: Reorder code to facilitate future work

Reorder some code to facilitate future work. No functional
change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Link: https://lore.kernel.org/r/1679838727-87310-3-git-send-email-mikelley@microsoft.com
---
 arch/x86/hyperv/ivm.c | 68 +++++++++++++++++++++---------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1dbcbd9..f33c67e 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -235,40 +235,6 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
 #endif
 
-enum hv_isolation_type hv_get_isolation_type(void)
-{
-	if (!(ms_hyperv.priv_high & HV_ISOLATION))
-		return HV_ISOLATION_TYPE_NONE;
-	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
-}
-EXPORT_SYMBOL_GPL(hv_get_isolation_type);
-
-/*
- * hv_is_isolation_supported - Check system runs in the Hyper-V
- * isolation VM.
- */
-bool hv_is_isolation_supported(void)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
-		return false;
-
-	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
-		return false;
-
-	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
-}
-
-DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
-
-/*
- * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
- * isolation VM.
- */
-bool hv_isolation_type_snp(void)
-{
-	return static_branch_unlikely(&isolation_type_snp);
-}
-
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
@@ -387,3 +353,37 @@ void hv_unmap_memory(void *addr)
 {
 	vunmap(addr);
 }
+
+enum hv_isolation_type hv_get_isolation_type(void)
+{
+	if (!(ms_hyperv.priv_high & HV_ISOLATION))
+		return HV_ISOLATION_TYPE_NONE;
+	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
+}
+EXPORT_SYMBOL_GPL(hv_get_isolation_type);
+
+/*
+ * hv_is_isolation_supported - Check system runs in the Hyper-V
+ * isolation VM.
+ */
+bool hv_is_isolation_supported(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return false;
+
+	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+		return false;
+
+	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
+}
+
+DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
+
+/*
+ * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
+ * isolation VM.
+ */
+bool hv_isolation_type_snp(void)
+{
+	return static_branch_unlikely(&isolation_type_snp);
+}
