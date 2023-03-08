Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0746B11C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCHTHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCHTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:06:36 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2072.outbound.protection.outlook.com [40.107.247.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8329FD23A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 11:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqmVyUwfdIXMSdsfbqcR8+VI/lT/ItFCOlmJM5KrgQ8=;
 b=8hPzQAsfYW5HDHxH3AQserUX6UAYUmdWTPbeKh+VILvrDoK2t0rL/aXtEtfSbUENpEZfJGMdV5a11/rd8BJYUIoJ+tNeezYUeIQ79IStj9vRQnlIABs0h/8fsxMxmxYQtB90Xh38rUqhGiGDAaJPd9cC2QX3pts0y6BsAqswC/E=
Received: from ZR0P278CA0121.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::18)
 by GV1PR08MB8378.eurprd08.prod.outlook.com (2603:10a6:150:a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Wed, 8 Mar
 2023 19:05:27 +0000
Received: from VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:910:20:cafe::13) by ZR0P278CA0121.outlook.office365.com
 (2603:10a6:910:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17 via Frontend
 Transport; Wed, 8 Mar 2023 19:05:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT005.mail.protection.outlook.com (100.127.144.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.29 via Frontend Transport; Wed, 8 Mar 2023 19:05:27 +0000
Received: ("Tessian outbound 55ffa3012b8f:v135"); Wed, 08 Mar 2023 19:05:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: adbd3f86ccc876a2
X-CR-MTA-TID: 64aa7808
Received: from 59a80f6f64c7.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6384491A-7F9C-4F23-8EB6-FC90409321FD.1;
        Wed, 08 Mar 2023 19:04:35 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 59a80f6f64c7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 08 Mar 2023 19:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWUMLH0iwm8K3Hg5HbEERc11k9FkI2h7bMmN+9assH+5Nkyf2AUd6V7MLF0Gi+EDRIo0aLd1+qh3P1kqipWZo1MTvIM4As3A8omNJ8xri1rL6iS6ZkbQ8Rwn8Dy33dzQ+GjSxvYsrrIImpqF7eYD1KMFTd6edZdu4wEx6BMEtXVCv1J1EC/7B3tlldddkbaACyxWB/sKG3QGM7qtdKghgtgr0VOndsMTdVAdf1+e4r2qvPCa751x1codY6Fw2wawQQIFzKkhxT3aFJRdwi1uvW5XXXPz2/pl46sqoASUeDw/cHWKxWoylodQhVP+5gnG4dxgvsJ6LWfl+cwIayM5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqmVyUwfdIXMSdsfbqcR8+VI/lT/ItFCOlmJM5KrgQ8=;
 b=TsGLIySAP88st/x6Y7AopHgaRVLM2PZPLD4jPlPvdKWp3AzNoZGre9UTDp10yDW+Og96ER+i48PxQv10cTFBwL0Bvii+XUsSwiLK6v8z4JdedT0DpgLR8vDK1VuTWZWWEvwJNShTwwHN6oY9NPIKu4kEnwFfgNRxC3jLglunQ04G4XecrnLQPGfuT4yj0Z2xp99EyPwxtGD2F1b1qGrsZhyIg9fGtp1raJaT/x8ZZTqRKZCqO7xhDBOykuK3Ltqeaba+0KtD5xCyeHO7IVKqv1O+NLeVizOzBEGVwhkkYJ2RK8DpzMt4s+S+2gC6652ZbXqTUw0kHz+SND1RmpPuiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.67.248.234) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqmVyUwfdIXMSdsfbqcR8+VI/lT/ItFCOlmJM5KrgQ8=;
 b=8hPzQAsfYW5HDHxH3AQserUX6UAYUmdWTPbeKh+VILvrDoK2t0rL/aXtEtfSbUENpEZfJGMdV5a11/rd8BJYUIoJ+tNeezYUeIQ79IStj9vRQnlIABs0h/8fsxMxmxYQtB90Xh38rUqhGiGDAaJPd9cC2QX3pts0y6BsAqswC/E=
Received: from FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::22)
 by DU0PR08MB9464.eurprd08.prod.outlook.com (2603:10a6:10:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 19:04:31 +0000
Received: from VI1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::d0) by FR3P281CA0049.outlook.office365.com
 (2603:10a6:d10:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16 via Frontend
 Transport; Wed, 8 Mar 2023 19:04:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.67.248.234)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 40.67.248.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.67.248.234; helo=nebula.arm.com; pr=C
Received: from nebula.arm.com (40.67.248.234) by
 VI1EUR03FT019.mail.protection.outlook.com (100.127.144.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.17 via Frontend Transport; Wed, 8 Mar 2023 19:04:31 +0000
Received: from AZ-NEU-EX03.Arm.com (10.251.24.31) by AZ-NEU-EX04.Arm.com
 (10.251.24.32) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v1 2/4] mm: fix error handling for map_deny_write_exec
Date:   Wed, 8 Mar 2023 19:04:21 +0000
Message-ID: <20230308190423.46491-3-joey.gouly@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308190423.46491-1-joey.gouly@arm.com>
References: <20230308190423.46491-1-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: VI1EUR03FT019:EE_|DU0PR08MB9464:EE_|VI1EUR03FT005:EE_|GV1PR08MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: add10388-0e19-458c-db7c-08db2008143e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yVe/hZbdq74TZC6YHNzACkg+Dg9+CX0fnV0yUBfzbphYdSPacKkVf7ev2dz32NSFJgwArDlQFFaIgySvs/+Wu2cUb4NTBpN995d3D1ZubpAsYVo0UcuazSgGUHRC+XKrUnKlZI+zwF35dUE7jSOQCcieNW9uZb9OtiU5nYq1OpMNkuhk+Yzm0Lyk4128AhzgsBcoKN+ls2eqRJgz4bFjiGUN1D1hHEn56YZmqAXC8juayU7hjZzfvtDslXIvCMzvWB2duXoM96fVqsY5PUcrkkTKjVM+U2OEzJOmUiXFmV3Xp5xi2SX3DRnvf5N39YyHo74Dl7sH4gNiwg1+yEuKyuDN7FbpR6PiWagaVmccq60o7ZXkB55PClhfB2h5XSnI8mxwDtY0GyBTp6ccISQN585t1FmW1+a6JJIonnJSgHb+2wxYQJLTM2pWaWYG6HddnYI+Bq+gk5QnVFyIKW6cdZ2R6Zh/o2L3ET1rxbMK9z/vcRnszJCJ07VDtCniUn056TBmpxUf3sSqEH/Q3Uwy1MChXXjPxEfpFKGZIJLeClDQPkpB0/qRYi/V21WbHoL8cP/65Bv/zECULMtEjMM7X8pBeP8GKvjkhey6qKKP7NM3b29Map0Wu+GLEZO3gcBi5wSTctuTEswwwNrndxLm8G/tAttQnW68tZLNesHADDUUyWyeG/cs4ibSCg/cctr7DFBJcDa4sNdE8SAmRSUTOBZ/52iFw2OZuONIqyeIMJY=
X-Forefront-Antispam-Report-Untrusted: CIP:40.67.248.234;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(4744005)(8936002)(5660300002)(44832011)(4326008)(70586007)(70206006)(6916009)(2906002)(8676002)(316002)(54906003)(478600001)(7696005)(36756003)(6666004)(426003)(47076005)(1076003)(36860700001)(966005)(356005)(41300700001)(2616005)(82740400003)(81166007)(86362001)(40480700001)(83380400001)(82310400005)(26005)(40460700003)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9464
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a508581-d722-4db4-3fe7-08db2007f30e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0KdRxxCs0mR8f/kgMJKXyyGkMGbm/4Ytmsk2SAduGqav006a+UbQH9vEPetQ80XsHe8E3SKfTcGVwlLnJjKVP7nZxwtKQyS0c2CtbDcOtwziU/flY/ZvSkxDyVbMzDM7s+JVStVYt2E3MrIz+m9gK0nUTFapIsvcLppwTJMSYEzJa3wnQvLQxXD3YkxRmzInczc6+mGKOaXyc1zAvlrkBAe5uwClIJEX1h/ezNMpLqQ2Ey/1HKAkXaRCu8K2Kr2uzr6M+0TUUyZzVoqV0PeOhZSPTSRdgAhpuAjG+m2Con8yJkXYUi0QUFfbTAU/J8OutC1clpzap6G5BlP68gzPy9D8Kq+1JiC4PdFOe69W3SaPVCmsG135UN6mWm1R15fDCRiikOIN+uHON9jfdwOxeV7Szgt8EpUNBvVi8Cy8OdoncAptcxbnnHSwsmVM3nFy06zxFhcTM8GFmqDM8TC5Pk5k7BXNYVctU7stzdyWjhFJuiXTY+62vLa96uhp2+GN8BEmWXHv45rOSwSqrM1f6387a8jemjGP12jjLSPXh7SfBfBmeo7MvT3y1vMSMtHkFIPOhs95hdB9AuUKpRokvAkk4AyfVepFc4TjtyNK1xNc7/+ZfubRYYkl0UlqXWVgIOdgwfSO+eE8Ty5HI2KkJ65D2VUZiabjc9t8VgxBZ5qii+I7NgYgYLD2CUnwzIT
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(40480700001)(426003)(8676002)(4326008)(47076005)(70586007)(70206006)(83380400001)(336012)(26005)(186003)(316002)(40460700003)(36756003)(6666004)(107886003)(478600001)(966005)(7696005)(1076003)(2616005)(54906003)(81166007)(44832011)(86362001)(2906002)(82740400003)(41300700001)(82310400005)(5660300002)(36860700001)(6862004)(4744005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 19:05:27.3610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add10388-0e19-458c-db7c-08db2008143e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8378
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4a18419f71cd ("mm/mprotect: use mmu_gather") changed 'goto out;'
to 'break' in the loop.
This wasn't noticed while rebasing the MDWE patches, so fix it now.

Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
Reported-by: Alexey Izbyshev <izbyshev@ispras.ru>
Link: https://lore.kernel.org/linux-arm-kernel/8408d8901e9d7ee6b78db4c6cba04b78@ispras.ru/
Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mprotect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 231929f119d9..13e84d8c0797 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -805,7 +805,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 
 		if (map_deny_write_exec(vma, newflags)) {
 			error = -EACCES;
-			goto out;
+			break;
 		}
 
 		/* Allow architectures to sanity-check the new flags */
-- 
2.17.1

