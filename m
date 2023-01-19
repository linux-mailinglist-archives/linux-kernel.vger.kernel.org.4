Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA1D673E33
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjASQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjASQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:04:54 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A8682994
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVqUovDaP0Eis0yf04LEyuGnbnC1xSyDtOGIyaojtyA=;
 b=V73VpP7Z56d4ftzhBcoPMGZ9SLcgx2v+yQRa3sVGW8+g+RNr3WXtcxzKfKEopOaf6/fA+oVFIJNkeDcVD8WlzEhCGDQTPC3x2omvjJtzgb1TPbzDurgNIOmdIMzQOHPIJc71uAF/aBhPajxfTksFhirqFMOVcl19qLOdkP2qfWo=
Received: from AM7PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:110::34)
 by GV2PR08MB9304.eurprd08.prod.outlook.com (2603:10a6:150:d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 16:04:49 +0000
Received: from AM7EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::c6) by AM7PR04CA0024.outlook.office365.com
 (2603:10a6:20b:110::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 16:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT043.mail.protection.outlook.com (100.127.140.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 16:04:49 +0000
Received: ("Tessian outbound 3ad958cd7492:v132"); Thu, 19 Jan 2023 16:04:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ae1d195896073eb1
X-CR-MTA-TID: 64aa7808
Received: from cb9ffc682106.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A654F2B7-F24F-4434-A2CE-8B00202A7FD2.1;
        Thu, 19 Jan 2023 16:04:06 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cb9ffc682106.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Jan 2023 16:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBt93A7pn/yhEWmvxLmH/8P+JHctCpPg7sYTkvGXHdiiSbGx1LXFtb/8WcPM7WPpbQzxXfWKB3Pix6TkYws1PmC0WQI2HJmtJ5ecffAPSWnH2cX4Bt0EX2DV1LbiQ6hf0/w0XC6FW/dExrMlB03pYBEs+qFe0ABLCKScmmaBgWYIVIxI2Ip1TUxu3WMDMl1lduIp+5Zil1rPHUNryZWl0kPJHBzSy9SkgaKgXXQGzOHeriFBQOCt7igUd944YUuGd0SzdRmcXuybF+QbybekDdZW43Nqg9qkmFwtj5UPiCyvYOn9f2T3Ctu+D5OalJsOcCp7IUKlZTOKjcQIbGwEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVqUovDaP0Eis0yf04LEyuGnbnC1xSyDtOGIyaojtyA=;
 b=lWIpeJ8qhIemmks1v+GMIPZlJ79+SYK0tidfOmXXx8EVUbVkiR7iF5XAvBB3wds/s/CnVUKnO4WVPZdV8rEqSCScdBYDbljIdGsezkPWBwMKyszzzt1cjsRhA8PCxeqwWvCPQvYXQ+sSJDUdp2Vb1sBzfAXkwb6czpElYSkHBXDNtkGBmyO/3tFVTJC44Z3CiOKJVenTJhg7tLGjEUBkYQAxE8djMWyY2EN92LgLR97E8AmNsbL0/KU1XWPTmpirj/aPgHt+rDv9JRYMdz0TJxCS7j2+6bTxniYUMsJ7BY+ivtGLcUw4BhFw0DhTMpaavlT0NEbDLz7CEgPFemnGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVqUovDaP0Eis0yf04LEyuGnbnC1xSyDtOGIyaojtyA=;
 b=V73VpP7Z56d4ftzhBcoPMGZ9SLcgx2v+yQRa3sVGW8+g+RNr3WXtcxzKfKEopOaf6/fA+oVFIJNkeDcVD8WlzEhCGDQTPC3x2omvjJtzgb1TPbzDurgNIOmdIMzQOHPIJc71uAF/aBhPajxfTksFhirqFMOVcl19qLOdkP2qfWo=
Received: from DU2PR04CA0342.eurprd04.prod.outlook.com (2603:10a6:10:2b4::21)
 by VI1PR08MB10121.eurprd08.prod.outlook.com (2603:10a6:800:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 16:04:02 +0000
Received: from DBAEUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::90) by DU2PR04CA0342.outlook.office365.com
 (2603:10a6:10:2b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 16:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 DBAEUR03FT022.mail.protection.outlook.com (100.127.142.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 16:04:02 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 19 Jan
 2023 16:04:01 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 19 Jan
 2023 16:04:00 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Thu, 19 Jan 2023 16:04:00 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-abi-devel@lists.sourceforge.net>, <nd@arm.com>,
        <joey.gouly@arm.com>, <shuah@kernel.org>
Subject: [PATCH v2 2/2] kselftest: vm: add tests for memory-deny-write-execute
Date:   Thu, 19 Jan 2023 16:03:44 +0000
Message-ID: <20230119160344.54358-3-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119160344.54358-1-joey.gouly@arm.com>
References: <20230119160344.54358-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: DBAEUR03FT022:EE_|VI1PR08MB10121:EE_|AM7EUR03FT043:EE_|GV2PR08MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cec80d-f04a-49ef-5aa3-08dafa36e497
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hQajnFbyiBtM6evBKQi+8/X+dow65HqZhKYZGVA+iJZDjLKrxsvrAZOiCBjxCysA7VHjnJSezMa8HBYQzGPp9ChJWfC7X76NMtNlZAi5qi57C8xbovpsWefWfEiobXj2bkUqN+2RbuV/OnovppztDdO+wjZw/kvCJ9cnKEhR/Vb3u9UAPLkI7ECcmcl+U1aWlUd2OgjtUdz1p9k6qO+5NQsIyeMnsjIcmSyCg6zCuBaZLoxTMYaIN/O7mgbQd2JSVajB/UIgzyU7CZgnm8XS6szjKwHkqg2AFiIDow5W1+DBgDG2GJteOqvpVcRVJZqT9S3ehcBKDoEmlblgpuynnZjlGIvuuDD9HI4YPRKSQG3MJWYLbPeUjjYoHlUgDMCBkJ1Ks+9RdHiAXCNUh/FJl4Nz7yBp7wrEKMPNk8siu0+QMQDSGTc5HMPeJznCLoHBu/8g2YNv9XaNdZ5FWSCMgSR78skWVK9l3w9E7l0zhTmNDHiUjFqNdWv9S3t2howiQ/1Ru/ZyPq2GdNczXUxvQW5i55ukKvkXeidGAoTXUaBFsAlbw8qK/qUYChv6tLmG9ll5OZ91yzARwwZlKgtdGedzAXwpE1DoPefc/pBWlpvPF7RWFKzi6+NFPOQ1DhzZPnU9zVneZ/aE7IUFbvyNGQcuLS1ClpumxMUcJ5AD6GStf6kbAYzVIcwSqG6DhmQmDl1AjHtnkXJG3AnfOkvTvY9Dpp64RdavF6SgY9HFA0o=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(81166007)(82740400003)(40460700003)(426003)(47076005)(40480700001)(82310400005)(36756003)(2616005)(8676002)(316002)(110136005)(7696005)(86362001)(356005)(54906003)(70206006)(7416002)(44832011)(41300700001)(5660300002)(4326008)(70586007)(336012)(1076003)(6666004)(8936002)(26005)(186003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10121
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 282693c1-6223-41a5-f24a-08dafa36c854
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtxxPvCY88uPV8+CuQ86eSgC33haRatHyTaaD7oWzGxfoQfGg3mKqvTslAAWzkUbcWW58ZIlJZn52IOT7uMcb0Cwv1Nk6CDfSio7qMO96nN9AJxN0rpp8SgnGS/bxW/PUVtBVxdquV2BNrw13G9aI/J4HyJ/KtGNNfjuWcvpvlOHUNy9vuJm1M2FGPTgWjBGuMn/fI8i/anc3QcDyZNvlyEH1HL6RjyRjCLO5oCyqjql7YcCHIsCtmK0rCaTRDZgTs7BiX0BlBUlxwTam/wbvNGBUWfxsgrOF536md7luLZUuEhkkiZgmsPD5gmJrNkA5MdqoQY0oFOnxuy+g4b/RBGDZqpwQwS16vGoECR8rhfZWPvzMFOGKJ48zlZibIkymrNLR52fZX8AF5EUKqfPkk305cfDD2idlJ1OECBP8wupF3ab4tE+KVIOrlEdxqwozglqeKJdpbDG40Tdxoevm6MVarEFsDiRCe7k32uYBmoxcuDsWSBRVR/DIACLeSP5VuJ5CBv9hcWVaCgVXavjGbgs82MxG73QnaW1uAPOTNBdDSNhdEUJ4Nu+8oeQpTI47ePdVMO6XZ4saCVph4kuWxeq+m9kGlmsOQnlYw/i9e4oRVmnCRXhTrTWt4C/mDLn0hY8MUIMei1AuL9XFVDXS47Qx9KNQF7gdZDGRBcjfC0YLY9z9glAc2KD5bpNJ6puz3E4MSMk/xm2v6OqpymwoQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(336012)(82740400003)(426003)(47076005)(44832011)(40460700003)(8936002)(36756003)(36860700001)(41300700001)(316002)(5660300002)(2616005)(40480700001)(4326008)(54906003)(70586007)(8676002)(70206006)(110136005)(2906002)(86362001)(1076003)(82310400005)(186003)(6666004)(26005)(7696005)(81166007)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:04:49.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cec80d-f04a-49ef-5aa3-08dafa36e497
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9304
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Add some tests to cover the new PR_SET_MDWE prctl.

Co-developed-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/testing/selftests/vm/Makefile    |   1 +
 tools/testing/selftests/vm/mdwe_test.c | 197 +++++++++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 tools/testing/selftests/vm/mdwe_test.c

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 89c14e41bd43..4e1a7b1d4c52 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -56,6 +56,7 @@ TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_PROGS += ksm_functional_tests
+TEST_GEN_PROGS += mdwe_test
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/mdwe_test.c b/tools/testing/selftests/vm/mdwe_test.c
new file mode 100644
index 000000000000..f466a099f1bf
--- /dev/null
+++ b/tools/testing/selftests/vm/mdwe_test.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifdef __aarch64__
+#include <asm/hwcap.h>
+#endif
+
+#include <linux/mman.h>
+#include <linux/prctl.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef __aarch64__
+# define PROT_BTI	0
+#endif
+
+TEST(prctl_flags)
+{
+	EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
+	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
+	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 7L, 0L), 0);
+	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 0L, 7L), 0);
+
+	EXPECT_LT(prctl(PR_GET_MDWE, 7L, 0L, 0L, 0L), 0);
+	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 7L, 0L, 0L), 0);
+	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 7L, 0L), 0);
+	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 0L, 7L), 0);
+}
+
+FIXTURE(mdwe)
+{
+	void *p;
+	int flags;
+	size_t size;
+	pid_t pid;
+};
+
+FIXTURE_VARIANT(mdwe)
+{
+	bool enabled;
+	bool forked;
+};
+
+FIXTURE_VARIANT_ADD(mdwe, stock)
+{
+        .enabled = false,
+	.forked = false,
+};
+
+FIXTURE_VARIANT_ADD(mdwe, enabled)
+{
+        .enabled = true,
+	.forked = false,
+};
+
+FIXTURE_VARIANT_ADD(mdwe, forked)
+{
+        .enabled = true,
+	.forked = true,
+};
+
+FIXTURE_SETUP(mdwe)
+{
+	int ret, status;
+
+	self->p = NULL;
+	self->flags = MAP_SHARED | MAP_ANONYMOUS;
+	self->size = getpagesize();
+
+	if (!variant->enabled)
+		return;
+
+	ret = prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0L, 0L, 0L);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("PR_SET_MDWE failed or unsupported");
+	}
+
+	ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
+	ASSERT_EQ(ret, 1);
+
+	if (variant->forked) {
+		self->pid = fork();
+		ASSERT_GE(self->pid, 0) {
+			TH_LOG("fork failed\n");
+		}
+
+		if (self->pid > 0) {
+			ret = waitpid(self->pid, &status, 0);
+			ASSERT_TRUE(WIFEXITED(status));
+			exit(WEXITSTATUS(status));
+		}
+	}
+}
+
+FIXTURE_TEARDOWN(mdwe)
+{
+	if (self->p && self->p != MAP_FAILED)
+		munmap(self->p, self->size);
+}
+
+TEST_F(mdwe, mmap_READ_EXEC)
+{
+	self->p = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
+	EXPECT_NE(self->p, MAP_FAILED);
+}
+
+TEST_F(mdwe, mmap_WRITE_EXEC)
+{
+	self->p = mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->flags, 0, 0);
+	if (variant->enabled) {
+		EXPECT_EQ(self->p, MAP_FAILED);
+	} else {
+		EXPECT_NE(self->p, MAP_FAILED);
+	}
+}
+
+TEST_F(mdwe, mprotect_stay_EXEC)
+{
+	int ret;
+
+	self->p = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
+	EXPECT_EQ(ret, 0);
+}
+
+TEST_F(mdwe, mprotect_add_EXEC)
+{
+	int ret;
+
+	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
+	if (variant->enabled) {
+		EXPECT_LT(ret, 0);
+	} else {
+		EXPECT_EQ(ret, 0);
+	}
+}
+
+TEST_F(mdwe, mprotect_WRITE_EXEC)
+{
+	int ret;
+
+	self->p = mmap(NULL, self->size, PROT_WRITE, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
+	if (variant->enabled) {
+		EXPECT_LT(ret, 0);
+	} else {
+		EXPECT_EQ(ret, 0);
+	}
+}
+
+TEST_F(mdwe, mmap_FIXED)
+{
+	void *p, *p2;
+
+	p2 = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
+	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	p = mmap(self->p + self->size, self->size, PROT_READ | PROT_EXEC,
+		 self->flags | MAP_FIXED, 0, 0);
+	if (variant->enabled) {
+		EXPECT_EQ(p, MAP_FAILED);
+	} else {
+		EXPECT_EQ(p, self->p);
+	}
+}
+
+TEST_F(mdwe, arm64_BTI)
+{
+	int ret;
+
+#ifdef __aarch64__
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_BTI))
+#endif
+		SKIP(return, "HWCAP2_BTI not supported");
+
+	self->p = mmap(NULL, self->size, PROT_EXEC, self->flags, 0, 0);
+	ASSERT_NE(self->p, MAP_FAILED);
+
+	ret = mprotect(self->p, self->size, PROT_EXEC | PROT_BTI);
+	EXPECT_EQ(ret, 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.17.1

