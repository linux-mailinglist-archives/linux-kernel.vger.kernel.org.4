Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DDA6F1E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346592AbjD1S5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbjD1S4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFD6A61
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktw+74u9weME0/4vNUekAGDZyKua5ED+qE2CsbAtLlzxUHOvkxPU1sIUJ9Y6vD6IkRSqfr7GZ/1T/QtI1qk3tlOGzGd/g1mw9j5OD8UK5Y/ESBXi07pl7eQLQ1ccD9saEqDZcr9LxVH/oOEKuKcnOG97FSlzPH6eMcRGTLFPDo3M4q94y4tPAGsvg4meijrkDEOlvNvftEq4WuNwHQC+X/B9oHqWB+uLKELnAxB1Cz2bcyGVND1hy01OiMxlWtX+Hk1kadb5G8ygacrB4Zs/rnvkJ/HVkaDvEmJGOj7N2O+cegBGSUGGq5IN2LAEXef+lG5lgfeTOA/jeC9nPYz5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHybiOC7Pf0gITiZl7S51v7l9OkBzy7ZYhRpPscQGGk=;
 b=cBtURS1xqZUzBf1YGZG2y3Ru0ASaKuuO/09nIjuh/xVetJ//SYLjRMTjg6bHP4nBBLRIxDkfYkt9Lw7YhB77mh8Ox97YEfUNqLm+tatnkPbWHjapa7XpS2uB/a9bXjzqGpYG42+DXoB0Wy9Kk0d5P3lGpBm4ElHPp7y/0AcrM8zMadvCIAMsjD6LxRw8u94zwv1IcmGuTT6CitAQUf5jVuor+Gtt9EJvJ0vQpLkPrY48KT5TM4chD38nBQgiCyLSozrmHDzqbqVKgCQVsN/tIGN5YqBFzNQxQ7iWAAaSGekDcQ+jA25HrZPo07a59vy+9vwvaAJCDz1rIs4616RohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHybiOC7Pf0gITiZl7S51v7l9OkBzy7ZYhRpPscQGGk=;
 b=qjfnb1Lb1vIy19dYX1kT2T0VNUjD1GBHMMVdUmJElktEyp3QXOBxe5M1288rseqvpQGizIoPiRCh40Edh/bdCgretSawb62keL2MWdmMOB1eeMsynH5s3zoJ1L5UMnX8ydPqkK2E11NNHF6zNCzT3DcHg//MfhHBO/SIc84m6W0=
Received: from DM6PR11CA0050.namprd11.prod.outlook.com (2603:10b6:5:14c::27)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 18:56:13 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::59) by DM6PR11CA0050.outlook.office365.com
 (2603:10b6:5:14c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 18:56:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:56:12 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     David S Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 10/10] crypto: ccp: Add Mario to MAINTAINERS
Date:   Fri, 28 Apr 2023 13:55:40 -0500
Message-ID: <20230428185543.8381-11-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230428185543.8381-1-mario.limonciello@amd.com>
References: <20230428185543.8381-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ae8a04-a329-4fa5-db8f-08db481a3d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWCL/dxfFbS59VIBuarZGTf7yLet9Uyw8vriOrN+5kN5h6xP2V0bRz4FHKJ+Q+wahfKHG/BpaiVdKzGSrzSxfIu6HdQF6p2C+tp6KrSsdg1nKJH7DRW1XB1w+ffnjBx9QqtmQtk2ThJXTHhOp0ZazYs1FB2cgFW6rCAndSNqdXJQD8xg+o51duKNvOZt59EYXNWSi/dBS87kA64LvH9lUIWwVz7f/WwsvU5Jung0DZXoKMlJb0NkwaA5cT5VvaMK7vEWzow7Hubn/eg8HnZ8wMJpoNToSEUA/0MXIw1BAx4OzEQP03dSR2FdA9TNikxkyHPnmYKmTUkp7vJSdvcND+mVnN7OlmWv1ZAlcWK3GOjCCSSPfl+a5S3nMixDLHa4gmPCxfRlwq79L0v914g8exL9krb/8SYPH/qISFtJ7oDKamrDSifFGj8vrK4/rUj4eybIB0pIrA9tMB/z8/cr+T2VpePe8u0cJJtgAP8ylQPHMzpGvi7s5f4JR2Uw9d7qK0TNEsdTSjFqreqgy04O4DyAV+WtsoylZlanyWP+ge52h2hO6zSGvGbAssn/yKWlhc2+Ek7ngYKCF3tHmvgkbTLrkYHMjCyG7LlZTw4pd6suCfF1JSkg5yEgK11qwLRuJHZ/O9ILgbmJMHCRKD7dEUxNnn1LTC3Fz0o0grd3w+mnPZvWLjaXmxw2lRmf7Y39XUsN/24qYGEmU/y6OkivoR1NFUhxJqK3MA4xFn2MUqo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(4744005)(2906002)(36756003)(82310400005)(40480700001)(40460700003)(7696005)(36860700001)(47076005)(2616005)(186003)(336012)(16526019)(83380400001)(426003)(6666004)(44832011)(1076003)(26005)(70206006)(110136005)(478600001)(70586007)(4326008)(356005)(82740400003)(81166007)(5660300002)(316002)(41300700001)(8676002)(54906003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:56:13.6089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ae8a04-a329-4fa5-db8f-08db481a3d3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will maintain the platform access interface and dynamic boost
control support.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45ee4e6faf9c..9feefcca232d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -980,6 +980,17 @@ S:	Supported
 F:	drivers/crypto/ccp/sev*
 F:	include/uapi/linux/psp-sev.h
 
+AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DBC SUPPORT
+M:	Mario Limonciello <mario.limonciello@amd.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	drivers/crypto/ccp/dbc.c
+F:	drivers/crypto/ccp/dbc.h
+F:	drivers/crypto/ccp/platform-access.c
+F:	drivers/crypto/ccp/platform-access.h
+F:	include/uapi/linux/psp-dbc.h
+F:	tools/crypto/ccp/*.py
+
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-- 
2.34.1

