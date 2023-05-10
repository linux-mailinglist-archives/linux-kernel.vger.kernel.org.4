Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4756FD969
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjEJIcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjEJIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:31:53 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2063.outbound.protection.outlook.com [40.107.239.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D507072BB;
        Wed, 10 May 2023 01:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4AcR7FWQpQ4AJkZCPUt5z0HCTPamPXQMtEKMswz0SFtdhPw8zXOBuuWj5A7TqfXFeazjS8VBVGcVm9547WnGAuPLbH9RzqfWcR1VxkPlcjOw/PYi/nnwYP+qycZfbfuZlf+BbHJ6SpB62VbApAxD7q2OvBzAcwCQ3gOwAufbvQ01jGh4KH5+h96fZs6/5wBaBpmpoLgjDUOUxP/eZnxWEQu3yiT+MJ92VqVyjs77BlhRaSzJpYlu3DOjbR/a2gVdkZRlJ+/s1qg3Gghcvj1u9GV1xBzw8Hl4J8yW2xlb3bbSkRBbkWQ9H3pyXUJvPVcExhLKAvowWUO8Vj6TSD3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU7cT8aARxzzE8bICdRCrF3LSm2DMcz24D7O2Eq/zRE=;
 b=CsRYFGlD8txSHlxmK2MZpIYAPx4x0+4Pa7UvX3eqf0x84KIsNn95iwCLmqi+PaC/hN6eB57qrRWJW4ALcmRIC8dE9Juo/GqC9A+yByh/BxVgUrZ2dO+o12u5sVWG3DhU652MBl2uf8P1etKi7mVzMq9lwLdKcNFCzyEft4dB+NbDiUMzdehn5yewLCPrK8tKtgsU/queAySBBxClggi46MQ9p32CsqOtR6ZYZgro91Eu2x+Uiot6NF5ATbHcS0inOsWrK0NIVPHTbH01+Jr8d3RL6fHyAPOUU6BEURiU0VzZNBoGNI6+F9+IBCLLZAk0sSOv/Zu1oDhJ4/v2CtW9yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNXPR01MB7204.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 08:31:41 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 08:31:41 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, marex@denx.de, frieder.schrempf@kontron.de,
        stefan.wahren@i2se.com, marcel.ziswiler@toradex.com,
        festevam@denx.de, Markus.Niebel@tq-group.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Subject: [PATCH v3 0/3] arm64: dts: Add initial support for Emtop SOM IMX8MM
Date:   Wed, 10 May 2023 14:01:04 +0530
Message-Id: <20230510083104.3692006-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN2PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::22) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNXPR01MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bada2b-18b5-4a20-0570-08db5130faf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ahu8Upw026A1Yxsl0manJKJtCwgSTtx0XIGikwMv2szSWAoV/a7P50TXZVLnTKD+L8CPQ5cgN3HoMFSZFdKcf3epHsUYW8m79o/UyUNiQKVkGg+WGhPMwFiFEqn8bNLjKAvE9UmPIJvkZWS4u4EkeFa3gGBMqoTkaXhfuLxC/j0x7EKS/5sEJq3tjAIPn1pMrxlJ5JXfCko16LGBW5GPhAOc8/qsNpr6aWSsmwcla8PpKsDLfp/PWU1s/s+MhQGGRyd2SG85AfXBoYlrnOfVKJqGXb3+mp4nUxJeMjXhqz8uSkFQ4+j06aR7VJIPUk5JWtdTpigeBX17QRrAeIHVoBUnk93JE2tphKGEWnz2p8mo46bk+HT77mmFdhWLc0PUUQqvp2DXwz0hlfVK7NGxihSKdyVm+gqQVISiaT+IIRz1sAuLNivijFMSNhK6Z5aGtWX8+es1hNjtBV/TDpHR5LNnOSKFWn148uZ7KugoHtlg5p9EWIuiV+nUbiZnJR5PsuMZO0L3QRYb6cwmJKb0Npvl1OZh9hVGRB0nUJTcwxqQJgjr7T8cBdLRNuxQ/pLQSqKXErC9UNLGn+ODEiYGUoPYc9XazxjoSF86lnEsybH6MHBvlqddgmNlNOx4GcHgQopjqSefJrEIXkRcv8DpZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39830400003)(396003)(346002)(451199021)(66946007)(66476007)(66556008)(83380400001)(107886003)(2616005)(86362001)(38100700002)(38350700002)(52116002)(6486002)(6666004)(186003)(6512007)(6506007)(36756003)(1076003)(478600001)(26005)(2906002)(4744005)(316002)(4326008)(6916009)(8936002)(8676002)(5660300002)(7416002)(44832011)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHbaoxFrQEt9faMFzrw2vpnChCC2sjsrBPK8ueN1pSR50wDwdUVT/YEseFNP?=
 =?us-ascii?Q?Ieq9FpIdNrHkLo5sBNw3Xes8HsCDqPjyr/BG36mfVNcXFqiQX4AuFWwWToQ9?=
 =?us-ascii?Q?RKvG1CKcQxiAuywjGVpnfBaYxHnHpjfnJTjuXteN9X3sm2G2rWno/d6ZU+0d?=
 =?us-ascii?Q?UQ7DRfe3th8c/i0NS9fvZn7SDFwfwTmaFwh9zWQdmN7mS13ulVMGEQ+Qjj91?=
 =?us-ascii?Q?uCutW6FURJktVZvLn2qczHnkJG9LTYwKHE8EuAbgFPz65sB0Bs0IHMHOSLIN?=
 =?us-ascii?Q?3nWqohFL46XgmsYuf0AsS0SYHFDgQBk+ar1yfarB9uGuv3LLMrep9svH/Qk4?=
 =?us-ascii?Q?9UQiL/bzZ2xNN/AjDbIr4cd6raQEGQ70jmcWt48Nuix/I03VfYzjKzMXqkVA?=
 =?us-ascii?Q?LUYDJOLnat1B3b13mBLlP6vbzrF4sWg9BQJ8XRWLziadhpZkQ4dCGBouvZgX?=
 =?us-ascii?Q?Nh0rnriy/mz+MxFjvob4ZoYR+g10Wv1+IG/bYBl/rbUocJU4UA1eM3s7IuY7?=
 =?us-ascii?Q?dVrO1sA4Z8O6hJIysbhRaNODyVo8RAXc5ltvorwArho75e9/IusIZw1nhaAg?=
 =?us-ascii?Q?g5vSu/Y8hSm+5dGbugGFsQ7xlKvhPttZIXE2Pnml8nurkvmTtQnBdLoBZVNF?=
 =?us-ascii?Q?oVvsbfRTD7S6Sb7g7/McoRNnutj3hM8Skc37VqDUDJ8VuQ/k4l5SmYONikRu?=
 =?us-ascii?Q?T57WAhk8cIkXvDhQkkAA2O40b7hDxvbVCKb7Wc+AA5gxsB3TGr7WZRnOYbVp?=
 =?us-ascii?Q?6T9g7RQz3Yg24YcjqD1s57v8Xzb97mojE5lJQJyJmzzmVuQMzIYyx++ue8qj?=
 =?us-ascii?Q?Da93v/uFYQwuPJRem+mPHauC/bOak/JYM1vgz7WyNxIvX9Lf+uB7GiCDMbQy?=
 =?us-ascii?Q?EpHz1iKOmPnW2zGNeMLaMR4vtWsrIdzAnSJiHVHt33FhLPxp4W/I6Iyt8Ln1?=
 =?us-ascii?Q?W4myGovW0B/hvxKqozWHQxqjvhltM/hYHhgUmr9r1TvTLGZ+ATOR8uyNIlfN?=
 =?us-ascii?Q?aNq4rrvVCUxO3lLym0J0/4NcyuD5RJX6ecx/Pkv6dfnn+vUfLmoc9Dy+mvn0?=
 =?us-ascii?Q?G6I2H+gUamsOvRkFtRiXNnxPvLbBvZh6OM+V+cM9Ck0h+W1COqB+cR9zdXdf?=
 =?us-ascii?Q?A+0neNRjtvQZT2Srfzp5zGIZgOZr/Ahw8SVYBeErdJH8wA6QMo9cKJxkcW10?=
 =?us-ascii?Q?G654CgetkwSGCc7yUIo12+t0KfSmxrshTYfpHcTyHE+7kjoRJbcFkEYW1/F5?=
 =?us-ascii?Q?CfmimRGJe59tZOLXqR2CwYO7XDvKFW2Y2epwz6YC1upvrPKu4LHPnuOIbEjv?=
 =?us-ascii?Q?sXKR8CMpIv/lKvNQ1IwXuuwzaq+GICEKXBWeAdSECdme5nZ1o/qOHzDa9ct1?=
 =?us-ascii?Q?hgpAqCZ+enmNP/xu3IDB/9klr8QGVBMcLw/yMeUgrcz0Ja5io5GbG82T/j7U?=
 =?us-ascii?Q?gLqMRXXL5xLTHPNcp5ZhwokkaxHtBOF4Zt6CXHWaaAqjtUA06hHWIGMySHEh?=
 =?us-ascii?Q?5+9B29ni78LxGt+80riFfDQWOfUWb+gb24TkiWHwKEsjT/jfReMNKcaC2jT7?=
 =?us-ascii?Q?EuZotFIIcFOHS0a3IDMJ45ZGDI/U+/fVA801/JBaYAPA+d1PM3lW+cWCGLsx?=
 =?us-ascii?Q?//pCnlzVyNJuinJrhxnd+WI=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bada2b-18b5-4a20-0570-08db5130faf4
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:31:41.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgJhvu0L6zhMdPxw3KIku6oxMHP29ZQJ30nF9drBXt14OZilX/IBSXa/qWIBWF9483oAdfR0sNtOKRo6iQdDi1XLY7H+cUJSEYXt906kVhC4Cg6i6R0J8FtJU2xM9zK3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for Emtop SOM based om IMX8MM.

Change in v2:
- in patch 1/3:
        - Update dtb add order in Makefile
        - Update proper prefix/name in dts
        - Removed stray blank line
        - Add pinctrl-names

- in patch 2/3:
        - Update bindings

Changes in v3:
- in patch 1/3:
	- Removed dead code
	- Fixed style and indentations

- in patch 3/3:
	- Update vendor prefix


Himanshu Bhavani (3):
  arm64: dts: Add device tree for the Emtop SOM IMX8MM
  dt-bindings: arm: fsl: Enumerate Emtop SOM
  dt-bindings: vendor-prefixes: Add Emtop

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/imx8mm-emtop.dts | 261 ++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop.dts

-- 
2.25.1

