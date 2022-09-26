Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8545E9993
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiIZGey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiIZGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:34:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEED32AA5;
        Sun, 25 Sep 2022 23:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUT2LYd++0v6AAs6ia6yLOmSd0rep7o0OdUOKyd6O0gjcDOTLaArMz9fQ2TvVAV5U+lev9nIlR3ORglby6sGidqyEKbK2Z+QK1pPu8RibiZg7MSm87Bm2c62JNCw7E5y0w7/UiCwBzycw6zrZ+errcsaIeCrYNnzkx97eGHHK0YE1uIkbSpRiSQFvvpg5QO8EQ8PsszEdVt1wEK3HQhG59+3j/8xyS1rQNrPuWiLhB4WbSdSMygNoMZoTW0HV2DaqwXO54tlgU1Z28a/XIwGTHZ6aRv0zW147vZKxu9KvfzIzMIODr3qI4l40qHw4g7TEokhFGvpTm6zm+CKcxElJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOuA1Bd28TiwObR6fOE205MHSHl7NkFLm06amo8rbi8=;
 b=BAwY9HQ2qhy7zSFe9Q28HmRgYXHkFz2/WupyXjuxWDYX8f8QjnGkCfpSlz2Y/5+2vm3dacREXTGMu+hFVIOl690/bui3ulh42Klylo+MdYrjcWqnckuL4czI/CuqxwjRhCO1eVDq7dkUs3Zes8AKcrF4KT5IbXInKCkX9Z18thAkZyBMIhT1JgOVdSA6IY/h2jYvgIp9bMDFyjssy5EhllxXpTbEIu5J5dtV2wAz1jK7oobLfsYFLJvlz0NcJLkFakoADPeLH2fdpJAOe3GfDAInbfXn3uy30U/riBg1igSxf2h53m9XalaAwFehliDEjxhpXPLXoPw5aE1oobHnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOuA1Bd28TiwObR6fOE205MHSHl7NkFLm06amo8rbi8=;
 b=oXFbNhfwgsbV07jDyoDoVmvsr5py4QnPVmpIz4ZOpWNy0jo/6o2UR+HoIf7Mf9bUqU/MlPBURx+G7gecG9n1EV5ma+47mOEB+/oOJeXND4ObYVrx6OwCn5Uw6PufmxqfFfVQEL+iIqB3Jef8Tvl2tFjSDtgmUQ/UoMlNv69syvI=
Received: from SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::21)
 by CO6PR02MB8819.namprd02.prod.outlook.com (2603:10b6:303:143::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:34:07 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:2d0:cafe::6a) by SA1P222CA0036.outlook.office365.com
 (2603:10b6:806:2d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Mon, 26 Sep 2022 06:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0037.mail.protection.outlook.com (10.97.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:34:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 23:33:54 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:54 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com
Received: from [10.140.6.18] (port=46254 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ochgf-000GAg-Q2; Sun, 25 Sep 2022 23:33:54 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH v3 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
Date:   Mon, 26 Sep 2022 12:03:26 +0530
Message-ID: <20220926063327.20753-7-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0037:EE_|CO6PR02MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e0adc3-da58-4088-0fe2-08da9f891cc8
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2C1uVYK3TvyQgFfGu/KaUYZAxkNsoGQQ2rpdGIC7vr388BEl1SLU1gGBF+t0mrjjoTEQVeX5jJfemM4V/7eo3Ot3sZ1lkMAyXNXzftvL/GzBO3JUQ50ZiLCv8HMASF0hgY+7iXpfHWJhAQiTdndHgM1kirWX/JGX4E/bNIfFGZSUtrWFvss6lhAj4L/g2x7WZR16/eWfW8wN4u42EsZnoyjhACHdzq8yBeYOKnwkUqKJfRVeEqubeY4EV3opoaYicrP4Zrc4PjkM/rFkCcl2+MT1au3oSj0MsdRmhNZbZo6cBuYI+iE0g/SYFfp9ciMESirx2rvZMR/d4wZo09yuyxjYpomfFm8QWZLofBRfbIyYcolxkHvpekKlxXMtxiq+m0XHOo0SZzcPsG0kEs7XcDTEpdlYQfL8aREZ7Qm8UW32wAPaB48EribwEUMd0irADVr5pfqxAXOQT0WFPfAmCJ+y8gxwUJlIfSf4L/WmaJfy4LLPVmgOfoejkBkqzBO25/tDbZlgAA3cXCWofACKmpN06FpVVeOUweo4yNBlbwFFoLVO1ffIr82Fwd9+xW60MsarsPR40daOfD+CdObb4lC0AeJfCXIt/0gxmtCKOjdxMYf0aJ4M+VIY73USG9/4zS8ScuUJWXRmFvoJzNzk03WSMeIcSf9Q+IL4RBhF4XZ7NxpUMAEqHh0qCjx/fnzB6Vc9dDDrzyG1DWI5W20ZnyVnIcI3UOKJ5JwfW6iH8kThHyVm+0qVdULf6+8PEhI5Eyhq5+pSVAkrw3XYrrvHBHYfLIH9ArafXgqm98+5E4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(478600001)(40480700001)(4326008)(70586007)(70206006)(316002)(110136005)(54906003)(36860700001)(356005)(7636003)(82740400003)(2616005)(107886003)(1076003)(426003)(336012)(186003)(26005)(40460700003)(6666004)(7696005)(83380400001)(47076005)(82310400005)(9786002)(36756003)(8936002)(4744005)(7416002)(2906002)(5660300002)(41300700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:34:06.7618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e0adc3-da58-4088-0fe2-08da9f891cc8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8819
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible to support QSPI controller on Xilinx Versal SoCs.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index fafde1c06be6..5ed651084896 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-qspi-1.0
+    enum:
+      - xlnx,versal-qspi-1.0
+      - xlnx,zynqmp-qspi-1.0
 
   reg:
     maxItems: 2
-- 
2.17.1

