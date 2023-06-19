Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE22734EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFSJCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjFSJC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:02:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656D9B;
        Mon, 19 Jun 2023 02:02:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPYgQvM43zI/TpSSfiDWzCrrCytNi5LKivXYPFa44RJ6zJgmPmthYGRC2wtfdhH8P8lpyMzG7nklvdaqKZNzAi8Su+XPRgp1aYJlRKIrKo6kBeJH82+YgZAIMigdKLSUlh7JePnF9a2GHmpJaqixFTQ1gGD3km6DIAO7hxut+HKc4257+5M87EctBL41djvKdXjemy6F4mrki0iQiwRFRzCahYMwfWkti+E+wbisj7l5y+iEAeWysdrb65cWRO7ZdWznoyhYhLQylQI0thYQ7gF2OeUltXts6pX1emXLFLff0GyAgJv0NOkGnZfGSwR3uqqiBV9//gKc7/nCbpFZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H2jGjKz+35/PSAl2sJFb27Pb9Jwju/vIYFpMDrBGuY=;
 b=fOP8zXMkhA7eknJj2afvaDVJVWMRgtgsKagKHA37dIyP+gT7b9nraJLp32XfiELZ6zirzFoqg6cLnDkLEbIOw2XSBYQd3FrzDxqXAckvn9khKZLjP/Z+DH5Ewyna3leeu03VKeFMY0hP9KcKkgZOC5JDHHyLt8kTc6sszoEry2ks01A6SqtQaq8qhbt/8Eegmy8wwWAERT3Rl0ZzZxIDZ3pxuddFXhZ+joGDx8ml8J/ocuL24dUrHaEIugJ53a9EiFjBma+yDewFi8OLlurF4NGkGDEs3v0GIzfvJMb9qI0Sw+BxEcwttykdORFUNj+gzhogAmne/BNEx0EZfbkO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H2jGjKz+35/PSAl2sJFb27Pb9Jwju/vIYFpMDrBGuY=;
 b=Ib40bpLpBEtbzCHNh4wuCVTZrZedWSibVdKjn7bkuGHCiBvZ8cXA+xzAmQxYaIgiGT1SxVBRTD9q90n4BATcdchSJBzPd2RRivnvbcjHQzh/tGOIqLJ0CvC05iX+C9TGal90q4cb+u5MpKShKmJgAvqYEZ2YDAtYR8DwYLiW2dk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 09:02:20 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 09:02:20 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 3/4] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
Date:   Mon, 19 Jun 2023 12:00:25 +0300
Message-Id: <20230619090026.22713-4-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230619090026.22713-1-josua@solid-run.com>
References: <20230619090026.22713-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 2506a568-6439-45c8-9897-08db70a3e34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6eWmHW/jOJ40R+eZJpWIi2+IpKSig5HIg/MnMfpRcHTj83P43AgaAyZFiPr9ER67tt0ir33CX1rU+kSsNI8ftJpnTXz5Z3vpBNbc9HIgh8F4mykOYeNl6DECCHLGrQaohziZg19+dgl+iBuvw/Rhi2/L6aUnGNwDRJ8MRx1y9C2qUEdPQafVLHvhmIJKSEGfzCPNIf5ZBQHVSK5vouS3riwU0BDsD2h+Uj59heuPxm9779YC/rXCIncqwvKG1mayAyqLT8DJn+kU7FRps/41yCin/tXiYzu1xCqA32kopXoHBPz26cPCMVh4qojvfipRGRlzlHguFDuky6B/biOiTIN3sMgD2oyzaANe2/XMoKj/qQro1O0vM0CfcNjWtYD+o3oHGGQcq6Dics0HjIOwrgT8YbW7wT8Eo2hVAOvFswCNJcImApFrMMDM2xzKYQBeeUD5NrqWTVDRwr6YzbBGPLsGf5oIqAo/5oxXqZOcj3RlgdiDhMI+kbA0+B9neeC9JlsSBKnVfc1PVw55QF5ZMoCDXUb8HuFBmNTyIuEIN3BjJY/1RpGJBzgDqF+5u72nG4a4HGr4NfK/rsMATVrBnqshV5c0O2xJ3IotCl4JCILwAkm2fZUVZi5VxaICmsE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39840400004)(136003)(396003)(346002)(376002)(451199021)(478600001)(6486002)(1076003)(6506007)(52116002)(7416002)(5660300002)(86362001)(2906002)(36756003)(4326008)(54906003)(8936002)(8676002)(41300700001)(66556008)(66476007)(66946007)(316002)(83380400001)(2616005)(38350700002)(38100700002)(186003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjErSEKZyfEPfus41JpJJeBpqQQS2lI0UDpd5WfLNJedmbrEQBBF8qF2r6A3?=
 =?us-ascii?Q?IHbnaa1qAbcdphzgZgJjc9WLgV9/gk3QvUJ2QCfIpOb6k5my4Ip+gr9EFE8M?=
 =?us-ascii?Q?wYE1DMLpptMaa8aLGHasb89tz6dPSLuGSdFfAh/TMHjKlZ8cM6xZlakV3d11?=
 =?us-ascii?Q?8zHTfxnggJhFagUXz58r49FPinywHUJxt+FX871j5/xMrFw7Hcs+N4RkXFI+?=
 =?us-ascii?Q?7TnzWhRDa5M3529a0oiypGWb1VHC6l6a5HpLCAwG3TOU4XJye8EhIyA0uRXi?=
 =?us-ascii?Q?xUXXEy7REZGqw4koh2kLIb2tXai/fSYGfL2e5zeVLITx775XqEYHs/B24IES?=
 =?us-ascii?Q?ykpDC7SM7Vbt1WQYm9UI1a0/L0C3PoK7/nJSqOzGODB6l8jlz/UPMDjgJR1B?=
 =?us-ascii?Q?AQmQRMIMHLFX5XWaFV+0C8CzXK0iClxL275LB9at5X9ZaoSIJG4udv02egfu?=
 =?us-ascii?Q?ohavoAgvHsXomwC3kBfmB+eLjgmAw1OdUUdFfbBD9I7Hczl1g+hRZsFUai7l?=
 =?us-ascii?Q?ubCPVi2+iOqO6JJV4OiDj2gVIq8qtKSrGYMVcm2ua1pR6souK5wVuOTBImX0?=
 =?us-ascii?Q?NaR+B/X7Q9chBFbdlUK5JiuXx44DqgmKg80ebKLQgWAtSkLoIYoI8ZmF220F?=
 =?us-ascii?Q?3dnGp1ZRXV+e/v1kE9gwsZT0i95lK2kM05QolY7zA5r78y75BcuJ1APe7Oco?=
 =?us-ascii?Q?qz7MYA1PMcccMbo1YYNqI+07jUedY8uLkeoN1O0fctbt/PIe0aU2CAnrwkzl?=
 =?us-ascii?Q?2E+rGzNm8lm7plDNV3aoL88fM64wQiRp2Urz7OijlLhuNZHQDWTWT4yIkdzW?=
 =?us-ascii?Q?g4r6ViMlUal+VYYlylF2hAyqkPeJKj0wAINFMuJc+Lpf5bD4SiE+6MoBvQD2?=
 =?us-ascii?Q?cRU2WYT6ydkqGhGzR3JZoPF0/+TjHleEIpmPYOJ+9byZ/QTWQN7KVZMqf1JN?=
 =?us-ascii?Q?LkhzFvG3dlqdpZwXNNm6ZtrbS+b+esRqpU/MUHLR2Rxc6xSS3TSCbs3NmETW?=
 =?us-ascii?Q?irps8Q0pEcCmSoXlhUBJuwLJ0JYXRA9UxhzijpPlsV80vGjg/nzDCs1euq/4?=
 =?us-ascii?Q?BKGL/BZGSHcw6yLoST2U1ER3vKSs8JXAfhAw2cUdU7TGlRUw8coarMPLej3d?=
 =?us-ascii?Q?GfMNGPmpdG3kdlHq0mPMUDRjBCeTnueCdUj79q53KDpnagd6pkY6oQlGOieG?=
 =?us-ascii?Q?sdCUzYT60dI1JcPaXjchUQxMpwdKeGQHZQ+8DhQH4QyhE0tTV0y5AHdff9I3?=
 =?us-ascii?Q?i6lW0Ukde7EVDR977Dp2gOKFOVnnw8qLi+QTSFnIhloPfBtfQLVY4xs7vsWf?=
 =?us-ascii?Q?S0qZJ0Pde+PIfO75es+Wpj/pSu/yJbwWghQP6oN658kl6cVPT4fR9/2EJh5B?=
 =?us-ascii?Q?Ac5baQzvNpTm/5hzodc9jQNsGLzIzArslzKSKCRYYs+4Kr+r4cpqlj5rh4fL?=
 =?us-ascii?Q?9LERJEUVjTci9dNV66NmoYT5t0tyfOBrkrEAxqS65EM4M22hVOJQlsPAQJA7?=
 =?us-ascii?Q?+TrLcvvKrb18VZvYsbX1DLFbBNJgXpsZWM6Hyho/Mry7vlCUgwx7p1egV/ve?=
 =?us-ascii?Q?4Tpe4D8uOWBtHBC+g5Up778abxaYAvv6hPgEFqxN?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2506a568-6439-45c8-9897-08db70a3e34c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 09:02:19.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgsbG/9fDafHgChEGFlQ3O/PwfyNBW6zKvwswa6TEIEmq4nsw3+1tozi7+yFY8rS00lLgveDnjN891DP6qKPpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SolidRun now have 2 product lines around NXP Layerscape SoC:
- LX2160A COM Express 7
- LX2162A System on Module

LX2162 is a smaller package and reduced feature set to LX2160A;
LX2162 SoM is also a smaller form factor and reduced feature set to CEX.

Since both product lines are physically incompatible,
the existing group "SolidRun LX2160A based Boards" has been renamed to
include "CEX" in its name, meaning products based on LX2160A COM Express
Module, following this pattern:
"solidrun,<board>", "solidrun,lx2160a-cex", "fsl,lx2160a"

Add DT compatible for both SolidRun LX2162A SoM, and LX2162 Clearfog
boards to a new group based on LX2162A SoM, following this pattern:
"solidrun,<board>", "solidrun,lx2162a-som", "fsl,lx2160a"

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
V1 -> V2: fixed to not break existing boards
V1 -> V2: explained new board / som DT binding in commit message

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 15d411084065..51911a89ebb4 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1370,7 +1370,7 @@ properties:
               - fsl,lx2162a-qds
           - const: fsl,lx2160a
 
-      - description: SolidRun LX2160A based Boards
+      - description: SolidRun LX2160A CEX-7 based Boards
         items:
           - enum:
               - solidrun,clearfog-cx
@@ -1378,6 +1378,13 @@ properties:
           - const: solidrun,lx2160a-cex7
           - const: fsl,lx2160a
 
+      - description: SolidRun LX2162A SoM based Boards
+        items:
+          - enum:
+              - solidrun,lx2162a-clearfog
+          - const: solidrun,lx2162a-som
+          - const: fsl,lx2160a
+
       - description: S32G2 based Boards
         items:
           - enum:
-- 
2.35.3

