Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD84734F01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjFSJCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjFSJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:02:26 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD6898;
        Mon, 19 Jun 2023 02:02:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiNhp44KLWca8qPEh0gSTpeBJ+b+62D0VllmzLBYoNbxpw7R2Aw1j8kMa9bKVaqdufxQnv0kMJWqlP5TECsQ8Lx8siZyz3Dxa3yiiRS1g/MrovQFQNk3AafbkS8asrL85xfv0jU/bGwLP64nBh52w/pvFonIdZfvhYwYExL1Uqb7U5UNhTbzriKqeJ0DF6dXYb3EbxGItGec5ss40vTeiQHkjkSKmNADFPr6qWGAh9r1g5Gwbw2Z67pfDxGDnNVCCpYPp8ASEkZ1uZ3dxdazh3syD3iXsgrNG1Gl2uL2Ahoh3rSdjnYAGdKX082/PoEh+4a2TAaqVaSHITr4UNWPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEW1KOUycMJBikiIkfHC/uXRkQQAxjE9CIqrb8AWo/0=;
 b=gioGF5yhgQ6HkOnC1UDO/T+oiK/RlEIoi4PFql7y+lSWeOrGcYBelU91Zx6u8gK/Og5vL6Qs5BhiU3J1j2/rNHFQm/kGWPLXmU2UZO0TB2Q1e2v19hOGnsj9T13mOvo+OmgUPtsd6nQ/RmbC/vGUzWxKhHXdJxVYqjHVKZkoXTEUhh38WYJHaniu2J3cnhlOZOwLra/5ISxlQL1IFcZg3OK2IECvw1Q3OZs8sbP/KQmnpX6jseupVOoHKJ297dY8dj5YwFcvt2ISCp+YhtXPb9WfqjO0/zOqb4INi62tYNCJ5ip/+EBHN2oO2hATDyU043P570XyDxtfRLJhr3FCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEW1KOUycMJBikiIkfHC/uXRkQQAxjE9CIqrb8AWo/0=;
 b=UIjlHKcHVIOezRmOkfBddPH59eZSPZorjy6ZaCMycm6+VgSVIb1WM/srno/VxoVAb3jXSCHgK64ywiUhYlx7epHQDg7j3iQ1MVhHcy0trdwzEwVogw0dPTzYSYTAWvhe9yNKhgdSC+3BCWnBfoafWjlNtscuFn7stK0MHhR+7+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 09:02:17 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:02:17 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 0/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Mon, 19 Jun 2023 12:00:22 +0300
Message-Id: <20230619090026.22713-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 959758f3-1434-458f-9d56-08db70a3e174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jCIcyp2DK98FoL8UZwWvcWIThwIJSiRfOFseynIXlm5HN3Iiw0Jif6bZ1n8vGeHqtnA95Pwq84a+cl/fHPfuYlSZM0Mr2epAj1bOa6ER8yvqlV14NT+QTucqYFbjy+Orz+VXGOadI/HJvLXmakN238qTu3y2SIH6BIcVQDIBx43JYBGufvJb6FGnuxUTKAhOEIc4kr5huA84V2ukb/akerPO4FcGx2XhJ+55Wm4G3P98Bv3MoUDVd0k7Cm8zKA6RraZzuFh4Zwurwb0LgLR4tYG7rkKtnD6Aaa4JZy/Ynd3JE1G+tdzUtxjP+uJzL5GmCCnroYDc+/+NCXXCGvHjbwziMCNAz8DUhpTxxTSEpZj40HCOwGQ4vJSnEr+t2pE9j7pIhqGAMPQeGZz46EXCaTzzYvB+LVwDAMq3kHZf3Te0GlEbS084VtKKy4LcKfF9hjZIhWmhu4dSQmj9rB/gp8FdukDjNFlmZEafs2K/a3/D17E5qUttQKmvLou5zM+S0bLxznMNe+O9cEFuMt/cWpZI/LhUOHYYWocsLyxhtLGzojqXn6tscjySnkhYQVJofNxkbgYI/HNJK3n61R7HznXRQZu5cdomzP1gxeErCsLiIqz4yztTRr2PzGG43r74
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(136003)(396003)(346002)(376002)(451199021)(478600001)(6486002)(1076003)(6506007)(52116002)(6666004)(7416002)(5660300002)(86362001)(2906002)(36756003)(4326008)(54906003)(8936002)(8676002)(41300700001)(66556008)(66476007)(66946007)(316002)(83380400001)(2616005)(38350700002)(38100700002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ePVHJkArSBDoK4nScjtRBIfzI66B9arPQt1PLOf7I5s17uzKfSdMXZXKlxF0?=
 =?us-ascii?Q?e6iWBSHPXuItP+ZoTgdiDw/igbuQtLpLaWW5WDRkpaytLl0kChPGqC4P7duE?=
 =?us-ascii?Q?9DyytpydZyptB95AvA7duTE3/HZHLEdiWgClzZuyuw84Pf4OWm7TwikUdm0x?=
 =?us-ascii?Q?9LYDoBRt3anMAvP67CQp32lXmNIwWWDtm9cMk6M1LCg19bLoXw/EUfehG7kD?=
 =?us-ascii?Q?hamdX8YmIPHGDUFjniS38kO1Z2m5nAoaqEMGtq81B2+HHF/1wNFfwilHCTgy?=
 =?us-ascii?Q?yJnv+moKyzAi779rDOZg5vyDmk6AERweu7zXX85X5100G7zzqHrJu4g/7+G2?=
 =?us-ascii?Q?CsnH/Q2EPHUXhHlY47SNOrSJPtHha4Ln42Ij8LnVHWKENaRvgJLMakeiuDR2?=
 =?us-ascii?Q?xzCMAh9SG2go+nonUSjwOsvwpJnHFVwDXZfPnmZ0tKsqYUfHGRElENo8uSVq?=
 =?us-ascii?Q?LtdKEjRyASMhnefg71+wpc22n3L+MTVon5JOjFU/tDM+FsIBH+gCo5u/d+qA?=
 =?us-ascii?Q?jqpUudlJs+SaFEC2btMcs8oJ95XkwADRI78kc8nTClnnHGLEYt1SQZ/9zw2q?=
 =?us-ascii?Q?jgH+DKDWnAmbuuUk6uQh319/5OemM2jGEgsc+g2N6HFJL3pMdOkaMECfFGvB?=
 =?us-ascii?Q?kQrIhapODZ7LifDdHN6sW0GwJKWVF7EQrecOC299Kq8Od1ih5pnZ2FK9H1S1?=
 =?us-ascii?Q?L+KyQRb+TRErjDIAeoXakUopcY1sQPQZVdJpojtZ12oDjg6wAr6lNa6MwBcz?=
 =?us-ascii?Q?EYGzQWOAAMYmzcu7+jMkYAzJYTD94wfpjs2m/1AhRBP98DnjGxruBZ6ZSHSf?=
 =?us-ascii?Q?7Ga/d+pmy6NNGcB0so/K8uK7McsmUEc2nYYYbKVGXh/i4GWSlfYZei00TX9h?=
 =?us-ascii?Q?Yez4aIVe/8NUobPAU0tpAfU7Hzy4qIfli0CXISJvbY97ekklpQsAyTaTX+Bo?=
 =?us-ascii?Q?8iPUfBI8Ay5qBEc+XD+jTnu18csuaXbdGY3jEcIlPBCjfpo5xJ8FE4vGk96E?=
 =?us-ascii?Q?TwjhMkalZpvanLIRnnd2BRq/BqvbVx/7iFKydbnT2JYYYoX7Q3++nSE8U4UW?=
 =?us-ascii?Q?dEaEolHutUrJhFD3urF2HCj6gGIxae9RK2xMg8A3ttMWttcTDkvLu7i2k0IG?=
 =?us-ascii?Q?3BZEJs9r/ipsSaVTVQS+5Epfo1ayzvg5AF0AE31/knBBHmrGXszGGEnuwu63?=
 =?us-ascii?Q?GNtlHm0GnkuaoiIwfYA5GVjgA1Yee83Bp8MwHqG1fV/qvf2KoFwkwyNK4g+P?=
 =?us-ascii?Q?rWqjN3thdKEC+LF71udbMRovfzyd36vVGiuA+FJtNWZW8i2lAZSEq4WOzOgL?=
 =?us-ascii?Q?ZzQ6ucfvGl4zXUlFkmNWV8P/31aPISD7YIn17Hpj596bWPxq3Wc8I2bS1McB?=
 =?us-ascii?Q?MCHRTdNc99bCLJvR/sm7J5PP6D+2tHUBvrgPchTWaxL6fsZB/tWv9KyrPNkr?=
 =?us-ascii?Q?uE7T9IxukamGSb7HjEjZ7x4MOOKLrFwlyfQVWgylln7k1buBR9Kitf6QAsNC?=
 =?us-ascii?Q?VfP02iWXZQVeSwibOF74Q/P05zS9a3EqYuA8ZHW5uIz2RQj9XATGx6HHd3Tu?=
 =?us-ascii?Q?hFgAxqcfRw/EpTpn0xOdL3MvKykKM+LdCvrra2Ro?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959758f3-1434-458f-9d56-08db70a3e174
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:02:16.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKrsWWw0LBO1bFjHbu/P141cmPnl2//w/WiIyN1jegeLz/qBGigYZj20mKf+0l6eQEhXBmOLDj6CDMIz7pkioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SolidRun LX2162A System on Module (SoM), and the
Clearfog evaluation board.

This patch-set introduces:
- dt node for lx2160a serdes block #2
- dtsi for lx2162a system on module
- dts for lx2162 clearfog

Firstly Please note that checkpatch was complaining about the EEPROMS:
- DT compatible string "st,24c02" appears un-documented
- DT compatible string "st,24c2048" appears un-documented
- DT compatible string "atmel,24c2048" appears un-documented
However to my eyes these *are* already documented in at24.yaml,
and are also used in existing device-tree.

checkpatch is also complaining about various parts of lx2160a.dtsi,
as well as the use of "sfp" property in dpmac nodes - which are common
across layerscape based dts.

Secondly the MAINTAINERS file has not been modified.
Is it required I add myself or *someone* for these new dts?

Changes since v2:
- fixed property order in som dts such that compatible is first property
- added reviewed-by tags to bindings patches

Changes since v1:
- fixed DT binding changes to not break existing boards
- explained new board / som DT binding in commit message
- added missing DT binding for dpaa2 mac "phys" property
- reordered "compatible" and "reg" properties: first "compatible", then "reg"
- replaced chip-specific DT node names with generic ones

Josua Mayer (4):
  arm64: dts: lx2160a: describe the SerDes block #2
  dt-bindings: net: dpaa2 mac: add phys property
  dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
  arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board

 .../devicetree/bindings/arm/fsl.yaml          |   9 +-
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml      |   4 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   6 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 371 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  73 ++++
 6 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
-- 
2.35.3

