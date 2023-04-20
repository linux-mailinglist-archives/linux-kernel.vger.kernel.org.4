Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96B56E9B34
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjDTSCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjDTSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:02:18 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C01A30FE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGbbR2CLl9acNcZDWqkg/eUVapXZfG4o9mXTI7XuwwPsei1d21YiztM0BCqM/vJsoeYPgxfw/qjJSzXFo6Z7biRqUNrsf8xd5/skuVNGXgVVxCGXCJXYwDGl8lC03l2EFbkCxyCyoTvU5T8rudty4xfy4Wh/L9vxylPAzZZ3BR/ZDm3oOaFV2dbsxrz6f/Qg85Inzlots4iJWH4TbFXBwxAEey+ep8Zy3Wac41Hue6dNeBboXQGbP1FXjZp0I6DOOZfl6q7RaicBXAf/mN2Y/qbW5o2yhlXni2U82YOy6dKI+zYfV6v8VGbp2fDaomBX7dbNUmY0ECPaa/rT3JB7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxqJ5IBbhy+fCWT9fb77Vyhxl3ZnqBz+QVmgIItm90w=;
 b=nYr5EqjTReRn75E8ivuIEePhnX1eiTKzP0rNm5zV74dh9EYn8D+lNKDhsYdYxnj3/DzzmckbeSyTp3PGdWjduUzzKp8X6KK8k4q6MAPEKgGETP2CD4Nw2Dpn2zEAcpSf7s9EyIGK+l9Z/y8ogRICNDppp9juc4XfMvlBoiJ7MxrgpoXIHF6hFqSgaMFLxj+w1uLwNMWCi6T34mWL6DKBA6G+ssJlCOo8P64HdcaZ27PAfkGNm6YFA+VQ7WelDGg76CW0COH7TXGQSQoTcJcVtTyNQfsG3bEHGoR3FXSsF1aWadrwHG0bvOkRmRFMYDF69HTywtDZ9hHRfJi0uhLzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxqJ5IBbhy+fCWT9fb77Vyhxl3ZnqBz+QVmgIItm90w=;
 b=LbDNJ401UcGFg0oFrHvWXcG6dIAaZpdWtdJnMxtzhgWoc09YEDXLxediS47oeco1T1ykr6/+dRjORpKy8JT9i5AhYIhrnK92IL1p2Z2eSo2lyQHQ42iXfME4hTmhxx3aoaCvtWsYNZC9cheScB6Ee1ICYf+1wx7CMhpCLZdv1Cs=
Received: from MW4PR04CA0341.namprd04.prod.outlook.com (2603:10b6:303:8a::16)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Thu, 20 Apr
 2023 18:02:14 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::1e) by MW4PR04CA0341.outlook.office365.com
 (2603:10b6:303:8a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 18:02:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 18:02:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 13:02:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 13:02:12 -0500
Received: from ethanolx1adehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 20 Apr 2023 13:02:12 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <Syed.SabaKareem@amd.com>,
        <Vijendar.Mukunda@amd.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH] ASoC: amd: ps: Update copyright notice
Date:   Thu, 20 Apr 2023 18:02:12 +0000
Message-ID: <20230420180212.3101178-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: eaccda1f-f918-493c-3180-08db41c95eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/Lk84ELL7Vi8XapnPZzdxN1bG9J1/cE1BC5lmohkW8yy+qEnTVj5o+B/UuzHGyf87CW2McSQAuHPY237rMQsbm6o/+S+JBQR4HS6WhN6QYQL+A5djr+/axDjyp4rU06+X/aFBvLgWv1Yd53VlTVnLFNc069fmrXg2uBhNLHTb3kEXM/HU16TSqJeb/E01uF/HUVC0uqa85M7FPBN0WbDz99KBKU/CWxzvNCdZcgOXqSEmO0OIrJHVHX2lNVY6/QPHr+5K6TCb2B9e3X5Na88B3q0yLedfmdom0X4PZWdOUjxPTqD89RHBoRhL9uMATMLH5CU+FjKpM6vr0bMTnW2EUlWupUB3UrW7+SiYu0aWDgPN3m/PuJ7/F0KgX6zT7ZtQnSELfxeHfMxZLRmQ/w1pxipjsNW0fvXvNQPZ5Ga0hHH8hJ4DGvF5SCJAsZx5rcYH50e/qYE8wn29A4VDcEcSM1f18WfL2pPVHwCuxTNrFck7HnIKXYBPZThtO3Ty2IPvUSUEKJ18ltchey+iAwmlF2Aq7xgNx2NeS/vRaIfRwRbDWMrpvZScYA5lg+1pAHmm5NOqQEjoiqxeQNPxf2W3zDZeprKg/7cGngqJB7oPjbKwD4Uf70NyyOAmvx+nasKrFGtTk7NWV06HyWC5bs93i/N8D+2P45Cb12NZliS1yei4qha9sZ6NKnlCgflB/26KmoV1QsHK5N4JuoTMZwwPgBEAN/4JSJtvcg9AbTw1I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(8676002)(8936002)(40480700001)(47076005)(336012)(426003)(40460700003)(15650500001)(86362001)(83380400001)(2616005)(44832011)(2906002)(4744005)(36756003)(36860700001)(82310400005)(186003)(54906003)(6636002)(1076003)(26005)(110136005)(316002)(70206006)(70586007)(478600001)(4326008)(7696005)(41300700001)(356005)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:02:13.8198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaccda1f-f918-493c-3180-08db41c95eeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most recent changes to ASoC, such as new module parameters, date to the
year 2023. Update copyright statement accordingly.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 sound/soc/amd/ps/acp63.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 5e7f9c1c1b0e..587c206114a6 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -2,7 +2,7 @@
 /*
  * AMD ALSA SoC PDM Driver
  *
- * Copyright (C) 2022 Advanced Micro Devices, Inc. All rights reserved.
+ * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc. All rights reserved.
  */
 
 #include <sound/acp63_chip_offset_byte.h>
-- 
2.34.1

