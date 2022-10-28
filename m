Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D6C610A78
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJ1Gmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1Gl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:41:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D454CA3;
        Thu, 27 Oct 2022 23:41:57 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:41:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ys34qWW4Z7K7/TZK5E/pIjGXK354KfwX9qXdP6H9+88=;
        b=CIF+fMETvclBI+8tTlWXmWTMfn2PCDE/58cnS/lfpby+AfcDDobyaPM7nkfQfWTelC+q1g
        pta3CGOrzXAHIvArjPlAp0+6Ff7j+FK4rb35BxKqna4L1ZyPHCD05mXtBG41A4E4sPut7B
        AblAh5KXpPgNtYFA+xLjK3buzE9aoxHCS4381hSypVwZHXR+rmZQGYvRwiZjoQ4iI9YhFe
        eyRye481a40lEK3lBznA+peZ8pepRcJJldc5Tjch65XHZJuPe72PvHp80OO8FE2yGemlfE
        1Y8OnHwXm48jMG8wLiP7gMjqC0XLXY5JmHRGuvOsF6e/ERT3XshAuq0wVjFbVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ys34qWW4Z7K7/TZK5E/pIjGXK354KfwX9qXdP6H9+88=;
        b=bHEssMReA/ylx0d8Obwz49oECaV6qm/3kw55wnPFPxbgVfHy8coy7E00mjzFQ5r/489zAE
        3cdEguYjWuYxhZDQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to
 PERF_MEM_LVLNUM_CXL
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
References: <f6268268-b4e9-9ed6-0453-65792644d953@amd.com>
MIME-Version: 1.0
Message-ID: <166693931431.29415.13952323879232067095.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     cb6c18b5a41622c7a439508f7421f8766a91cb87
Gitweb:        https://git.kernel.org/tip/cb6c18b5a41622c7a439508f7421f8766a91cb87
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Sat, 01 Oct 2022 11:37:05 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 10:27:32 +02:00

perf/mem: Rename PERF_MEM_LVLNUM_EXTN_MEM to PERF_MEM_LVLNUM_CXL

PERF_MEM_LVLNUM_EXTN_MEM was introduced to cover CXL devices but it's
bit ambiguous name and also not generic enough to cover cxl.cache and
cxl.io devices. Rename it to PERF_MEM_LVLNUM_CXL to be more specific.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/f6268268-b4e9-9ed6-0453-65792644d953@amd.com
---
 arch/x86/events/amd/ibs.c       | 2 +-
 include/uapi/linux/perf_event.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 3271735..4cb710e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -801,7 +801,7 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
 	/* Extension Memory */
 	if (ibs_caps & IBS_CAPS_ZEN4 &&
 	    ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
-		data_src->mem_lvl_num = PERF_MEM_LVLNUM_EXTN_MEM;
+		data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
 		if (op_data2->rmt_node) {
 			data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 			/* IBS doesn't provide Remote socket detail */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 85be78e..ccb7f5d 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1337,7 +1337,7 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
 /* 5-0x8 available */
-#define PERF_MEM_LVLNUM_EXTN_MEM 0x09 /* Extension memory */
+#define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
