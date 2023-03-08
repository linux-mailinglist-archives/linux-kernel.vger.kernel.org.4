Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977E26B11C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjCHTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCHTGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:06:30 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CDAD90C3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+JRz8Ag/13J/UuStpDABzWeR510tjFXJg4/TNsab/I=;
 b=x3XpgZ9nsZsG8H/wFqCaaGsncNnmtH5cuo8Ef8ES7IEyvCK10OH6b44Z2lYFritsEb93zaSzJmyhbS6+KhJqpXiJgyqqh/npLQWEa5PKdw9ZaBp7EaZqAiY+ZU37D4pcIJriDSlCiflV58QFZMxNLYl1JHriRPxAwhB6G+IM3vg=
Received: from ZR2P278CA0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:47::9) by
 PR3PR08MB5674.eurprd08.prod.outlook.com (2603:10a6:102:81::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17; Wed, 8 Mar 2023 19:05:22 +0000
Received: from VI1EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:910:47:cafe::36) by ZR2P278CA0033.outlook.office365.com
 (2603:10a6:910:47::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Wed, 8 Mar 2023 19:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT009.mail.protection.outlook.com (100.127.144.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29 via Frontend Transport; Wed, 8 Mar 2023 19:05:21 +0000
Received: ("Tessian outbound f2a8d6d66d12:v135"); Wed, 08 Mar 2023 19:05:21 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5cc5605e47040adf
X-CR-MTA-TID: 64aa7808
Received: from f53d93e3bc23.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5D2AE1C7-F145-40BE-A939-2AADDDA4E76F.1;
        Wed, 08 Mar 2023 19:04:31 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f53d93e3bc23.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Mar 2023 19:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMinw5k6ZlKVwXW213bW1OkD1Jhp2Bg5pK3LDVObxRqJV56JKJtgo9Sx4aDqJjjQpg442/TNIl2ZMTDy81r/OYhmrUq4+kkJCkEr0OpFLuYy/FmBSXAHHDDebrEPlzGvMxCxsy0mUU7xR5wb+m5jxUWka2CuEsFEaBj3b4dNy2/tfeaQdkXwrfJq2W/xTq4blpkwFQJJfE6LN/JWTDSraUf20Al3vPqayDtAC+OpfMMx8Cg88l2dlJrE1rBwemQRL0bcuC8T3ew+5nrflPKNp6pGyB0/pxe7pGceyExdZa8L2m6rbDbAtAe4YnFRBSfboo/64ErTPl2LDcjUwOXNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+JRz8Ag/13J/UuStpDABzWeR510tjFXJg4/TNsab/I=;
 b=YBgM5jYDEzaLQQY8AYBQjEEemMkLYjpWzk6Uh351ZGEqIJiY/iOG+3vzqxGU9rOD94yNcsMSE7UNKXah4RcyDeHEkeHREHHMm8LZt5qJRCArUBNi0TShRdmORAOmpiuNOgPqgcPcsqakt+ZfUjETaVJLzeoEYKerj64Ivg6nWS+yxO0tCY4gxWE9PZ1j0cqGq54NukxgGVCIlnWRRp5HhxULv/OZhfHwyk6qHF027EwInk2DIFKN3ftslU1TkfyX4M7Ed4wm6e9yAirq/ZgfApuyG6BvYAR+GFUZyRgw6luIBVswKdR/LchpzcpmaHMH+uVe7TSKQNucX3QPFuUDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+JRz8Ag/13J/UuStpDABzWeR510tjFXJg4/TNsab/I=;
 b=x3XpgZ9nsZsG8H/wFqCaaGsncNnmtH5cuo8Ef8ES7IEyvCK10OH6b44Z2lYFritsEb93zaSzJmyhbS6+KhJqpXiJgyqqh/npLQWEa5PKdw9ZaBp7EaZqAiY+ZU37D4pcIJriDSlCiflV58QFZMxNLYl1JHriRPxAwhB6G+IM3vg=
Received: from ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::19)
 by AS2PR08MB9737.eurprd08.prod.outlook.com (2603:10a6:20b:607::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 19:04:28 +0000
Received: from VI1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:910:1c:cafe::71) by ZR0P278CA0032.outlook.office365.com
 (2603:10a6:910:1c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 VI1EUR03FT055.mail.protection.outlook.com (100.127.144.130) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 19:04:28 +0000
Received: from AZ-NEU-EX02.Emea.Arm.com (10.251.26.5) by AZ-NEU-EX03.Arm.com
 (10.251.24.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Mar
 2023 19:04:27 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX02.Emea.Arm.com
 (10.251.26.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Mar
 2023 19:04:26 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:26 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <nd@arm.com>, <acme@redhat.com>, <catalin.marinas@arm.com>,
        <izbyshev@ispras.ru>, <joey.gouly@arm.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v1 3/4] kselftest: vm: fix unused variable warning
Date:   Wed, 8 Mar 2023 19:04:22 +0000
Message-ID: <20230308190423.46491-4-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308190423.46491-1-joey.gouly@arm.com>
References: <20230308190423.46491-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: VI1EUR03FT055:EE_|AS2PR08MB9737:EE_|VI1EUR03FT009:EE_|PR3PR08MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b46b0f-a758-43e9-6509-08db200810ef
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6Qc3K7ytWeHE7nxUwxoTxg38VQ/Vp2OvxkXDveMmmT6OXoLTakyA49PHe3galFJOtZ8l5wV1zhTZntclwHYq/DtKkmqfgJS+VFCoL15s/PSDZRNjMPKO7NMot3PavDfFKSP3HWRe8aU+Hnig4ei7gSbqwrS9Sh+x+jbM8DM2khmsQzUygENRhBJTGkkoXPzmdbGTubObQ0MxIEANDWGTb6lg1duspOtqGkGdVbKb27kkjd40TAygLTiZytOuq7UqXPbxHjvO8Iof/VyJEVj2QOMPxakBFoAlFYeMhjYGDP6EbC3HlEFXsrTDe0qkjUCUyPwE0Wo8yxHJDsuPloj979rLI5JIwSEgiiRz0oQI9zp3NdK1SDT2Fx1yJDdsyPuAiH23qrO3K27k1EisyM2oos/Mmx5RMf27V9sy6sOE4QIy9RM/WrKU6pulU5mEJsOZysFlRe9HtZhYLxA9to36d91nxKO7OlFOHQW5sTaSKhBOz2Hn31vV9Wyweyz1s/qbqDGTR2+73YFzPFA9oj0P5lBEm5N9aHPutXs/BGjjWMgA5SpnFFHtHfkOSRes3yw20pDOTZgM0RLoPtr7BGMFhP7mHOA3BLnKxcJcZTQr5bgIjnsxmEnadPfbF4HuAF5v8AXGn1N0gqai4OUe2SNPruOy7Vmsw7W2HXoIBXoV7OfyPaVS2Bgg7vfFjJUixUqBleFEirJ/+pixA+FJ9A5T3GmiJPE/PUYWjZTt4r5xtnE=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(4744005)(8936002)(54906003)(44832011)(5660300002)(70586007)(6916009)(70206006)(8676002)(4326008)(2906002)(316002)(478600001)(7696005)(36860700001)(47076005)(36756003)(426003)(6666004)(1076003)(83380400001)(41300700001)(86362001)(26005)(2616005)(82740400003)(81166007)(40460700003)(82310400005)(356005)(336012)(186003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9737
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 70e9fa00-cea9-4d13-668d-08db2007f101
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cO8V16wwD2+1pfMwbR1utvL/2Jc8n6teSLv6EjV+DeWBWxvlTFfcoRkK1q9wHGEMDNwwp5E2a3VhKSFWQuHxFt07CEHiKxLBNxYAl5khQNvM4Kk/8CZaJL6z63LEesb9NFcFIjlWc9gHraefJycFNDDb0Wo52SahFw1aor8BAi4Dk9MnJQ52I71UJ3D/zhFgPW6XBdmizP+eAZXiHXelb6TXZfKBhk5Dor82BImdoZ0YPiu8C1AR6qfB3aG39NpfFkT2yLGPRVEUfpS/FcBgDMzpe4CqpB8jQupI+UrxQfHOd+z+lDrzf/mmAlTWtrtA1R3VCMdL1IcipptaBrYMRM+et2AdLQtpq/7o+KrdeLpWBXA11m0GapvWoh4VtoG6Ak9aJ2m8Ypoqs5/1EbZydL6k8TiFNvmO0KeQ9kpp6e5qidq2IMkGzGQU/G5qsBZgWZC8rwQ4sGsu2s39Bp8m9lHzClueV3J3irJZywRNRFFodJnIiGka/Glkwdk2T1pK12xy5BPCrHbc8NCdblqaGIeCbJrLw4j5gAtptS9GkNO3te4GYZId4HRjY76645BmQXRzemV01LPNQn7e57IclK5FGVPGE9uwGNj2d4KYnRukGlGQG6fjI+S4ZMjZtxTF/ZGn8UVbSo9TTAmQORmgOw4FcxcjwNhuZiS6D8XshKxH3S5L/aMF1riFT2h7e+d/UiGe9yfgmqI56YYimTR2qg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(36840700001)(46966006)(40470700004)(186003)(2906002)(82740400003)(336012)(1076003)(44832011)(26005)(4744005)(2616005)(81166007)(5660300002)(6666004)(107886003)(36860700001)(6862004)(8936002)(41300700001)(86362001)(70206006)(70586007)(40480700001)(4326008)(82310400005)(8676002)(83380400001)(478600001)(316002)(426003)(7696005)(47076005)(40460700003)(36756003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:05:21.7915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b46b0f-a758-43e9-6509-08db200810ef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT009.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5674
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

Remove unused variable from the MDWE test.

Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
Signed-off-by: Peter Xu <peterx@redhat.com>
[joey: added commit message]
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/selftests/mm/mdwe_test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index f466a099f1bf..bc91bef5d254 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -163,9 +163,8 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
 
 TEST_F(mdwe, mmap_FIXED)
 {
-	void *p, *p2;
+	void *p;
 
-	p2 = mmap(NULL, self->size, PROT_READ | PROT_EXEC, self->flags, 0, 0);
 	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
 	ASSERT_NE(self->p, MAP_FAILED);
 
-- 
2.17.1

