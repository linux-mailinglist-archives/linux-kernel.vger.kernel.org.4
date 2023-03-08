Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E776B11BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCHTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCHTGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:06:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928FCF0E7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ngMH/zhaje2wHOkov9IPjpaygc1R4Q5RdawSh0ckTw=;
 b=b9lD5VOE63F4LTW/NcnlLsYqN1yRJDKCfmN53HV7zCzxV896xeJYYBb4WcyAx4MkxHHwas6Tmg1ZjU8GDKBBny/369kd8kGCs9QDybnMkHsJy/KbIL9zzmO6paIiq2v7GkHdWaRDag7oKDGiwan7/HoZsfvtMh2jJ/QG0GwL6yE=
Received: from DB9PR01CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::12) by AS2PR08MB9221.eurprd08.prod.outlook.com
 (2603:10a6:20b:59f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Wed, 8 Mar
 2023 19:05:12 +0000
Received: from DBAEUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::91) by DB9PR01CA0007.outlook.office365.com
 (2603:10a6:10:1d8::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Wed, 8 Mar 2023 19:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT053.mail.protection.outlook.com (100.127.142.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.18 via Frontend Transport; Wed, 8 Mar 2023 19:05:12 +0000
Received: ("Tessian outbound 2ba0ed2ebb9f:v135"); Wed, 08 Mar 2023 19:05:12 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5fb85c3ffdf5cf80
X-CR-MTA-TID: 64aa7808
Received: from c4f7aa247ee8.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DE0EEEA7-F096-42EF-93B1-B94774BA1AE9.1;
        Wed, 08 Mar 2023 19:04:29 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c4f7aa247ee8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Mar 2023 19:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKQd87d4mcSu0mETWowVv2YpzkNKLbSD6apU3peU1w9Ut683K781g08S9NMaVEnhQuVvYgcUzu1Wy37tO1OXXj3hcoWBHuVfQKu90yIETCrVwDJT8yfHOBZgmjdX94S1G5bO+4X1thOqv5WqIugPW3NWtIaz4uId2D4yYkFFR22Mb26q/jnhJEmWfOjGddZbGLj5tlYxoYMBpOto/6q4NApgzVjpaSnpDqVP1cdQ0s8KnyAeiK9AlJgNQ7oiXSO6TFi86o0HEf5bF92Nfm9Ff2iZFauiuccj2rjhx3n3A8XODULSE58j/M1pNXAT7qwGXsdQ2Kujg/BPkykFU2miTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ngMH/zhaje2wHOkov9IPjpaygc1R4Q5RdawSh0ckTw=;
 b=cQ0Td8Xg07BYcArS2rdCOljaCuQtTs/xD5A6pWnnEEwvd0Z+8C8I7WCjKTet2xw+YImD4Hcpf+AFzY9WWGiwjSkLKqiED0rpr64LILdmPXHz8YEMIYo63257q1CIcKGvJzLgVe4zjCM1WKgKRA29mcqkcu/e80blXqZL515UlnLjm4eZrsQCHqR7KAiDGFhZ9DgVRXa8QrIG2PMkg4hvJHFe0yyOhjo6sPLTZr1Q9nZb9mpQWynlGm5UajQ3/qCoHJIDYZkq3Aonzy4LLQwgxh3hguFSio0Wl+zJrVOpBESO9ORc9NzFAOhsKi2ogpbydg4KJd+Zyo5IGVX4haEudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ngMH/zhaje2wHOkov9IPjpaygc1R4Q5RdawSh0ckTw=;
 b=b9lD5VOE63F4LTW/NcnlLsYqN1yRJDKCfmN53HV7zCzxV896xeJYYBb4WcyAx4MkxHHwas6Tmg1ZjU8GDKBBny/369kd8kGCs9QDybnMkHsJy/KbIL9zzmO6paIiq2v7GkHdWaRDag7oKDGiwan7/HoZsfvtMh2jJ/QG0GwL6yE=
Received: from FR3P281CA0043.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::15)
 by AM7PR08MB5365.eurprd08.prod.outlook.com (2603:10a6:20b:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 19:04:28 +0000
Received: from VI1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::af) by FR3P281CA0043.outlook.office365.com
 (2603:10a6:d10:4a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 VI1EUR03FT019.mail.protection.outlook.com (100.127.144.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 19:04:28 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Mar
 2023 19:04:26 +0000
Received: from e124191.cambridge.arm.com (10.1.197.45) by mail.arm.com
 (10.251.24.31) with Microsoft SMTP Server id 15.1.2507.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:25 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <nd@arm.com>, <acme@redhat.com>, <catalin.marinas@arm.com>,
        <izbyshev@ispras.ru>, <joey.gouly@arm.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v1 1/4] mm: deduplicate error handling for map_deny_write_exec
Date:   Wed, 8 Mar 2023 19:04:20 +0000
Message-ID: <20230308190423.46491-2-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308190423.46491-1-joey.gouly@arm.com>
References: <20230308190423.46491-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: VI1EUR03FT019:EE_|AM7PR08MB5365:EE_|DBAEUR03FT053:EE_|AS2PR08MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fa76ca-11bb-458d-7899-08db20080b21
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qQX/qjjl8sAfGCDVVnb33wUjxclTB9xoj6Oob2uxyt3Rsu+yxLlMQ0Fqtr3tsuaN11NJ/uZraiZVs+HG37Xr7p5/jukJJc3FNlyyZcwy6DltL3Y3dnpaBNnGjQJ3ymKxmAt5H/JAuBwW0uMc2be882qbQsUaUqAmyqkRBhLmUHICohSrw09qjFL/6MnqzI1SefdnXCA+g3W/iZQgl4L13+qo3KMz7e7NdXg9gbsMkzF15sKJ0x8nX3wxe7iVOCTD15Pe0GImgSvi0GELqIRYZMNGJkMu47QMZBo0xgqn/wUUkUHXfH9rDF2jUljBSqvi1brDN78vQiS5as6VOhuFBXrBIKP4R1HeKtAzAaCZlKnQJ5K5I6Uw9J2Y5DnlZOkf0Cf1EWZcnMDeLffiIGoG/u8imCrz/w6/oe1T4RGsuPiCQUEYgq2nYAtJswrkwskJ7cygE94m5/sXrQdMV++AVl7KAuyf7vC1XOVZHQPDEabg80E3N5GidWxXDXhPCUlDYOWcf093cW66bS2uZE2agPYfAUjTSKZtp19eK4u/LS3UHBaNEOEHM6y6zSKhEuqFKTdLJKf4OZC9Kg+GbiZaDTbGhMQp8Hy+oRXdgJaRqUJw8i8ufQmUyW1KrS/2Mejy6p+dVzWIjB+AkQ25yrogJZZxaVjmwfbdkfpKonf5AUY8Iy8KlRcykYd1F67V2zlT
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(46966006)(36840700001)(426003)(336012)(47076005)(316002)(54906003)(36756003)(40480700001)(86362001)(81166007)(356005)(36860700001)(83380400001)(82310400005)(26005)(1076003)(2616005)(82740400003)(186003)(6666004)(44832011)(5660300002)(7696005)(478600001)(8936002)(966005)(41300700001)(4326008)(70206006)(2906002)(70586007)(8676002)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5365
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 44e180ce-b3d9-42b9-8b33-08db2007f0e7
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ko2UAr+fyhjT2jOglBrRQVvC8TgmxgbtzduCKnUQAUvqYFIxuflRHz5Xkt9Uptass4//cQpzl/lUqgOpvQEC2ZtGGuQ7UsUamaObCYw5DDxHG8NW2C/eso33aHefElJau1gICuWyt3O486iRkDH8C+kHHVxsErwMVyeEmr6JUT7ANjSftV4kFbzrs3jUNmm3o24THwMJ7W1Su4nZISFX0JVBSmpsfGfAow6iwpTq1M9aL6lwwcIhGH3HVEiQe79EQoOSR5F+/ez/6hFPGwt/YzJx4jRCx6kiLdkgZjTeLs/pXF4h09W4Cce5WIbxJfvbZWjT9GQrZyNP7/Kt3uiWjcAuzswZODcr/ljrO6+g78dkJLjORClnJEbn6XYaMQQrBBKwjZLZbgC4Ukh/trB9GkK2u6/Zqf5ybhRKKlr/JSl1pHQzfJRlA2ORv5TYTZ3IsIbztR1M2x89nbH2H8E4/hDhlRVczrAoD5NkFLY1yFNGSgv2oOEmlLl9IusizqrS+OYgmDrZ15X7vcauA2PrqY5Hprc8LERZwJnvUoNdunjTwfplI7ZzZZ+gToOzIw6stUioo/UiDWJkh39ji7Wpwp7nITT+/MhMdr5iNNyYt5piLBd5hjjr1ma2Ireiapg5KphAlK4zM+l0JxBtcEflt7OzfEj5lNQhlcmW7EnKkU6b1hjzudYfGfK7X1PXxasH
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(47076005)(426003)(336012)(54906003)(316002)(36756003)(40460700003)(1076003)(86362001)(186003)(82740400003)(81166007)(2616005)(107886003)(83380400001)(82310400005)(26005)(36860700001)(5660300002)(8936002)(7696005)(966005)(478600001)(6666004)(40480700001)(6862004)(41300700001)(4326008)(8676002)(2906002)(70586007)(70206006)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:05:12.1627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fa76ca-11bb-458d-7899-08db20080b21
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9221
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit cc8d1b097de7 ("mmap: clean up mmap_region() unrolling") deduplicated
the error handling, do the same for the return value of `map_deny_write_exec`.

Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
Reported-by: Alexey Izbyshev <izbyshev@ispras.ru>
Link: https://lore.kernel.org/linux-arm-kernel/8408d8901e9d7ee6b78db4c6cba04b78@ispras.ru/
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 740b54be3ed4..ad499f7b767f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2621,12 +2621,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (map_deny_write_exec(vma, vma->vm_flags)) {
 		error = -EACCES;
-		if (file)
-			goto close_and_free_vma;
-		else if (vma->vm_file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
+		goto close_and_free_vma;
 	}
 
 	/* Allow architectures to sanity-check the vm_flags */
-- 
2.17.1

