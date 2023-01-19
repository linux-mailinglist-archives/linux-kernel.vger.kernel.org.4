Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3A6673E27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjASQEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjASQEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:04:44 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA514ED23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWnBE/PL1egq8JVxHK3Rs1L98loH/NJaLJV0FmvDpbs=;
 b=tuQI7n/bMvlfnfQesj/RIZsa6OLWxdGJ9NVoYZQDCPz1Cv5HBqnZ7i7PL26q/SUi7ZXFreVvoATBEapBOacwlMW5DPjTaQr/ZNfbB5gNDWvGAmahcVLFpyoBChpKFDd5FFLWhho1/KNJV+3Z+wibfAlSS+hFtTFbRv2Vc95Z+As=
Received: from AM6P194CA0011.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::24)
 by GVXPR08MB7679.eurprd08.prod.outlook.com (2603:10a6:150:6f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 19 Jan
 2023 16:04:35 +0000
Received: from AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::e6) by AM6P194CA0011.outlook.office365.com
 (2603:10a6:209:90::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 16:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT058.mail.protection.outlook.com (100.127.140.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 16:04:34 +0000
Received: ("Tessian outbound 6e565e48ed4a:v132"); Thu, 19 Jan 2023 16:04:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: af47519074e9bf56
X-CR-MTA-TID: 64aa7808
Received: from ec8cb9d0b8ca.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A7BB288E-AA90-4770-AE10-D67636400B79.1;
        Thu, 19 Jan 2023 16:04:04 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ec8cb9d0b8ca.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 19 Jan 2023 16:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSnFPvfuaDbmy2+AvnEJIXu6h0FuC1yo4+8s2jRRPx0/FXI/QzlpzooiFE58IL0zlDDCPNFS2/ZJEPws4KgTqN1xOm9mA1tPbrzgXFm9mfNjnvx8fFw2oXEejtrpFm9QMnh6YcuWVRSiHI68XZl5am1V6AMAAhwSqIWl8EP5UY2awwPA47g++Ke0hNlkZ/nnH5M6BZiaYIaFjrsU2VLldNj617ZNBFte2crj41QqL5AIFe3qGmUgM0yb4ANXjkt5fgD7GM7Q+oY7nUXw2qJOhZOvtV0KSKl5Fn2pANkIZ5mxpwgXqBBEhMTNCRZEHuVDRJOQlyRbMMwtIwAUcSLKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWnBE/PL1egq8JVxHK3Rs1L98loH/NJaLJV0FmvDpbs=;
 b=eM7K4ANkMsi5JRA3qw+bmcjG4XaEewBdIaq11T0UsvVtJpyK1XS4zF7YcyF7SiAeEmI8vcv7yEXyW1gjrbWiH0nd87Z2UIYlHIHrwagZrDOopV0uTvAOBwNi5ssv4j3ZOgYiex0cDGjBh4XeX5FynB4771c8BTrTttbiSI5ZwBmW2XhV2+o9ErsELnuRIABeup+TD64s6qgb9m+a8EDHFV+8M+54tRMUduiMc+kEEj+SqIdvH1BXedQoaZxSk3NKTzXHPGFB+8tcaDRZcUUbfIrHdjoKkADrFSL3rpGr1eb1PovK6y3pxjzL9Ya8qnFIVaJyr+mIDEz1375E0ZleOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWnBE/PL1egq8JVxHK3Rs1L98loH/NJaLJV0FmvDpbs=;
 b=tuQI7n/bMvlfnfQesj/RIZsa6OLWxdGJ9NVoYZQDCPz1Cv5HBqnZ7i7PL26q/SUi7ZXFreVvoATBEapBOacwlMW5DPjTaQr/ZNfbB5gNDWvGAmahcVLFpyoBChpKFDd5FFLWhho1/KNJV+3Z+wibfAlSS+hFtTFbRv2Vc95Z+As=
Received: from AS9PR05CA0309.eurprd05.prod.outlook.com (2603:10a6:20b:491::12)
 by AS8PR08MB9528.eurprd08.prod.outlook.com (2603:10a6:20b:61c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 16:04:02 +0000
Received: from AM7EUR03FT056.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:491:cafe::38) by AS9PR05CA0309.outlook.office365.com
 (2603:10a6:20b:491::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25 via Frontend
 Transport; Thu, 19 Jan 2023 16:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 AM7EUR03FT056.mail.protection.outlook.com (100.127.140.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 16:04:02 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 19 Jan
 2023 16:04:00 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Thu, 19 Jan 2023 16:03:59 +0000
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
Subject: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
Date:   Thu, 19 Jan 2023 16:03:43 +0000
Message-ID: <20230119160344.54358-2-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119160344.54358-1-joey.gouly@arm.com>
References: <20230119160344.54358-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AM7EUR03FT056:EE_|AS8PR08MB9528:EE_|AM7EUR03FT058:EE_|GVXPR08MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: eff390a5-94b5-4384-56e7-08dafa36dbe9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: V0el0I3AGkk0QRLFORZua0C7VnSelmI4sgfJfChIFySVKJMlQYw0m9Fas65dnDBDjp4KcAROEgGw+yUJcMLAOiUCiqX6E6sgjgrPG9fwnUOf7uel8k3ASFZPD7oXZcvgXvodLqNP9DUH29oYHEzsJAmOuKreiUR+zXPR0QRiu4ujOmY0A6gPWul5YzIUnUj6x2OQYPaGEmTUWccxDRPt0cnSeM9R1WkDpTGDVmc4eA3761WAIfqVVXz8ODpW1vNAsJIGQkQGBu8MthRpmoPuMi7qeCavcT6EJaKEY/SEZ0HZXwJKMdUAWfnygD3FHO3yM00OSVYb6ukCGP0wuH/BmyxtN3BB++qzyCOoDiW2CPCA7rRL4bAyKPP1Yfwo43BkmXioA/RxrUfSZ0/WObGgb0CmeKziLPcV0uMFeruMYLDFZoW/henx4Y3XG5ZxqQ5Y1svsgs+C05UN/t3cGZBoVuPqL/OTyUx8oMmY62N3UjpGIh3ZVWOLknepD+tzADuIZq50MScprr/SPOttzXeJpC4brfoLar12hGFKPHb0DXqL0DSlZtwBqndwOkY12RA0QSN8quSR95bPuzE6kst5SPbLKsQAboLa09LXDrTFJxh8UcCDaoSeDN2PHvuIfif02CUh8TQDnbHEdc2Ft/LXrjo0glnNUJzNTV4qJuCGqyRBm5nVWrC1Yi8h9cBpNl3hJcC9vYFe5XWg7W9hnOx/H0TVDNV+IYP01vDCLZeoKTkzQgnnkHDrluS4TN91Yy+/b6YKpGyznwsITqTTnHLTmw==
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(41300700001)(4326008)(6666004)(8676002)(8936002)(70206006)(70586007)(2906002)(40460700003)(36756003)(336012)(36860700001)(2616005)(82310400005)(44832011)(5660300002)(7416002)(54906003)(110136005)(316002)(40480700001)(86362001)(7696005)(186003)(478600001)(26005)(1076003)(356005)(81166007)(83380400001)(82740400003)(426003)(47076005)(17423001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9528
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8b5ae33a-3b4f-454f-2bea-08dafa36c8bf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KS5B60ML4C3Z/fQ0uWQA1Zt/0SnivQp/KUNGLI7ZuqherPK1wDur9bjqnwTx6hzxpqhwRnIbETunTOW7Zd3KKxjS4mPMLELnYEvhGaEjjFTLmnZOmfhAD/qV/LlqvjhRpL6Dl4gyVnHiYZqyuR/jcZyWIpn0HUEQhw0NSPRRBGOvwCF66ICCAWNqM/Kv5nw0rpNohTcZ6sCSRFPH1t8u5qHE0T0sc69QdWMwY4JT7QKE469l7n23Ca5PJYhXUB/oNV6+5KwGChP07bVr1zdY8RNygfd6Z4XtWH8BZW0Gy2bYdffPwzplTIJDg9mdiruwbq0K7pyj4ymwnS+6+gsVq9mabypCvRdeIcWdUkNYWdIRjz1PTJ3VmRv0GU/zaW37or9OXeAFecasfocR+UlE9LZMBAvf056hmGGQ6tRESz9JwJfn6a4XofLvmAZiJFdyGTgeQESHW+3wG/FEIjAadG5NeUwlG83ROzee9LBmloYpfB1YTDJucQdOmdHCSAsiAxiX1KFDIRaAhvk9T+9AeIms9HieYUwrDRIOZIhfDcpC9dh2yd4bHRoddiuAbSFiPsUltPQP7NQNmkHYGAss9AtN9o99zm52IPIWockEQFx1QCdMKqXlMSUnI0pT7kcj5rVtA+7q+qmh64Pbz9y7fqxEQ2V+LgjijVXtHL3zdv4h8DhVPDy0CP4hynYq30LjQj75EXtdL2DNPpIjd3FSY6rkGCyhjW0iEEU7KtzcE8Y=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(86362001)(8936002)(83380400001)(47076005)(5660300002)(44832011)(426003)(40480700001)(81166007)(40460700003)(36860700001)(82740400003)(36756003)(82310400005)(2906002)(41300700001)(7696005)(478600001)(26005)(316002)(186003)(54906003)(1076003)(70586007)(2616005)(336012)(4326008)(8676002)(70206006)(6666004)(110136005)(17423001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 16:04:34.9933
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff390a5-94b5-4384-56e7-08dafa36dbe9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7679
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of such policy is to prevent a user task from creating an
executable mapping that is also writeable.

An example of mmap() returning -EACCESS if the policy is enabled:

	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);

Similarly, mprotect() would return -EACCESS below:

	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);

The BPF filter that systemd MDWE uses is stateless, and disallows
mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC to
be enabled if it was already PROT_EXEC, which allows the following case:

	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);

where PROT_BTI enables branch tracking identification on arm64.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mman.h           | 34 ++++++++++++++++++++++++++++++++++
 include/linux/sched/coredump.h |  6 +++++-
 include/uapi/linux/prctl.h     |  6 ++++++
 kernel/sys.c                   | 33 +++++++++++++++++++++++++++++++++
 mm/mmap.c                      | 10 ++++++++++
 mm/mprotect.c                  |  5 +++++
 6 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 58b3abd457a3..cee1e4b566d8 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
 }
 
 unsigned long vm_commit_limit(void);
+
+/*
+ * Denies creating a writable executable mapping or gaining executable permissions.
+ *
+ * This denies the following:
+ *
+ * 	a)	mmap(PROT_WRITE | PROT_EXEC)
+ *
+ *	b)	mmap(PROT_WRITE)
+ *		mprotect(PROT_EXEC)
+ *
+ *	c)	mmap(PROT_WRITE)
+ *		mprotect(PROT_READ)
+ *		mprotect(PROT_EXEC)
+ *
+ * But allows the following:
+ *
+ *	d)	mmap(PROT_READ | PROT_EXEC)
+ *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ */
+static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+{
+	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
+		return false;
+
+	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+		return true;
+
+	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+		return true;
+
+	return false;
+}
+
 #endif /* _LINUX_MMAN_H */
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 8270ad7ae14c..0e17ae7fbfd3 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -81,9 +81,13 @@ static inline int get_dumpable(struct mm_struct *mm)
  * lifecycle of this mm, just for simplicity.
  */
 #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
+
+#define MMF_HAS_MDWE		28
+#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
+
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..1312a137f7fb 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -281,6 +281,12 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Memory deny write / execute */
+#define PR_SET_MDWE			65
+# define PR_MDWE_REFUSE_EXEC_GAIN	1
+
+#define PR_GET_MDWE			66
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e886..b3cab94545ed 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2348,6 +2348,33 @@ static int prctl_set_vma(unsigned long opt, unsigned long start,
 }
 #endif /* CONFIG_ANON_VMA_NAME */
 
+static inline int prctl_set_mdwe(unsigned long bits, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5)
+{
+	if (arg3 || arg4 || arg5)
+		return -EINVAL;
+
+	if (bits & ~(PR_MDWE_REFUSE_EXEC_GAIN))
+		return -EINVAL;
+
+	if (bits & PR_MDWE_REFUSE_EXEC_GAIN)
+		set_bit(MMF_HAS_MDWE, &current->mm->flags);
+	else if (test_bit(MMF_HAS_MDWE, &current->mm->flags))
+		return -EPERM; /* Cannot unset the flag */
+
+	return 0;
+}
+
+static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5)
+{
+	if (arg2 || arg3 || arg4 || arg5)
+		return -EINVAL;
+
+	return test_bit(MMF_HAS_MDWE, &current->mm->flags) ?
+		PR_MDWE_REFUSE_EXEC_GAIN : 0;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2623,6 +2650,12 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_SET_MDWE:
+		error = prctl_set_mdwe(arg2, arg3, arg4, arg5);
+		break;
+	case PR_GET_MDWE:
+		error = prctl_get_mdwe(arg2, arg3, arg4, arg5);
+		break;
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
diff --git a/mm/mmap.c b/mm/mmap.c
index 87d929316d57..99a4d9e2b0d8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2665,6 +2665,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
+	if (map_deny_write_exec(vma, vma->vm_flags)) {
+		error = -EACCES;
+		if (file)
+			goto close_and_free_vma;
+		else if (vma->vm_file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
 	/* Allow architectures to sanity-check the vm_flags */
 	if (!arch_validate_flags(vma->vm_flags)) {
 		error = -EINVAL;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 908df12caa26..bc0587df042f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -762,6 +762,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}
 
+		if (map_deny_write_exec(vma, newflags)) {
+			error = -EACCES;
+			goto out;
+		}
+
 		/* Allow architectures to sanity-check the new flags */
 		if (!arch_validate_flags(newflags)) {
 			error = -EINVAL;
-- 
2.17.1

