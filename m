Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96A56C5CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCWCkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCWCki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:40:38 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EB2ED62
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:40:34 -0700 (PDT)
X-ASG-Debug-ID: 1679539227-086e23383d19100002-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id ayoFbDVMQOAafL9L (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 23 Mar 2023 10:40:28 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 23 Mar
 2023 10:40:27 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Mar 2023 10:40:26 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From:   silviazhao <silviazhao-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <cooperyan@zhaoxin.com>
Subject: [PATCH 1/3] x86/cpu/zhaoxin: Introduce macros for Zhaoxin family numbers
Date:   Thu, 23 Mar 2023 10:40:24 +0800
X-ASG-Orig-Subj: [PATCH 1/3] x86/cpu/zhaoxin: Introduce macros for Zhaoxin family numbers
Message-ID: <20230323024026.823-2-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323024026.823-1-silviazhao-oc@zhaoxin.com>
References: <20230323024026.823-1-silviazhao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1679539227
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1227
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.106421
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create zhaoxin-family.h to define Zhaoxin family numbers in one header
file. So we can use the macros instead of open-coded model numbers in
other files.

Signed-off-by: silviazhao <silviazhao-oc@zhaoxin.com>
---
 arch/x86/include/asm/zhaoxin-family.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/x86/include/asm/zhaoxin-family.h

diff --git a/arch/x86/include/asm/zhaoxin-family.h b/arch/x86/include/asm/zhaoxin-family.h
new file mode 100644
index 000000000000..d54e0112207a
--- /dev/null
+++ b/arch/x86/include/asm/zhaoxin-family.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ZHAOXIN_FAMILY_H
+#define _ASM_X86_ZHAOXIN_FAMILY_H
+
+/*
+ * The defined symbol names have the following form:
+ *             ZHAOXIN_FAM7{OPTFAMILY}_{MICROARCH}
+ * where:
+ * OPTFAMILY   Describes the family of CPUs that this belongs to. Default
+ *             is assumed to be omitted.
+ * MICROARCH   Is the code name for the micro-architecture for this core.
+ */
+
+
+#define ZHAOXIN_FAM7_WUDAOKOU		0x1B
+#define ZHAOXIN_FAM7_LUJIAZUI		0x3B
+#define ZHAOXIN_FAM7_YONGFENG		0x5B
+
+#endif /* _ASM_X86_ZHAOXIN_FAMILY_H */
-- 
2.17.1

