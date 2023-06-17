Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D14E734163
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjFQNkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjFQNkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:40:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E510D1;
        Sat, 17 Jun 2023 06:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqvsqIfFgWQTLiPkIz6Jc/BS+ufHVk7+velvesfUSOUMi+RorIaQEwGG2T+H32/FOvOPgf+qkfqwKSfG5U8VagFy7N9sq5E83K+6225VTNA93c51GhkO3ADoQrPj0THJkRAKlcTGMI99TtmJJHa8QfZYF5E8tKwaCHkg5boNkXh+4OUsUQyG5+YHPqi7MkFjg97JHR8gz6kX1DwRtF2cPotmx0X6PHMYXuGIIdSMSjyxLnz+pgt1qCxk5+Fa5Cd3KGNcz4bhmAnsB5epCAESe0GG3BKpGqLg7xbaoM7+b4lci2u+3lSbelB17LS2SBIt35s6w+D/leuJPL8FJ0qePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioR9MoR1eanEI/pKKnNsQuIg/ogi1h3W03uLtHjTm9s=;
 b=ZR0ylxIhZmGfqGPX0EmHFS9pK9mLi2jbYwpFZ7217DCAMLfNj/1xYwc4Lsxl/V7n2Yo7MmnWYjlDB26H/l4r8bHr/Yp2hwObO2m9tQHgbVnVL/D3t/hYyaGzVY+iX4ndB6Tn0zQ9aGdlYP0ssC5AF250Lub6MiAZA90CaBUciixViYfvfU1npRh6pKNmrIykKATiuGIgBW3Xl4k3JS5pMRSMXMHa+0jqv3vKj8dh5KYXLsAUHzgvA/bG1FNH+/Nt7n4iNkavpoPGEsyYlcELpyIH/xUPWDVuJRPK3aO4wWBXRZH4/NS4lA1+ArJF2Q8OfGC9YJOR2GtX4ekRvoJ0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioR9MoR1eanEI/pKKnNsQuIg/ogi1h3W03uLtHjTm9s=;
 b=XkF108ofpvaXeQF7oO75iwZUIDU+IGvlBk5o1llHmSuTlMYWd7koMWpS+Mhw7JObvb36xoJSXxfeBPjSQ2cvUgG9OZSZRolRrcfgpxXCpJaqneVkhmDSrtAr85XOHl9M0IokPPW/ku7Yf4o0gba4MNwUcndjk3OZg60TNbWJTYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8220.eurprd04.prod.outlook.com (2603:10a6:10:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.33; Sat, 17 Jun
 2023 13:40:33 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 13:40:33 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Andreas Kemnade <andreas@kemnade.info>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 3/4] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
Date:   Sat, 17 Jun 2023 16:40:08 +0300
Message-Id: <20230617134009.23042-4-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230617134009.23042-1-josua@solid-run.com>
References: <20230617134009.23042-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aadbc94-01e4-42d9-576a-08db6f386c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HozOzAw/jnNIeBa7/wf5XpDHzYTf3N3toG4gJ9narqCqJgLBNanHvMhY2283/7RaZqR0aGgaOUo446rL2Sx7HLpIYbPT5DcGkiAEeqkpwEA1TWePR8r0ygzho7V1UeAX8KKh6O73gMAQDKTB3RBK3YwPC42GDYDn7r7qXTuyMMcjWjtu7372YPEZ/Nx/lx7REaCXpdla80ow+pMmyQjsc8h+Q4iRosJVH87GtN0laIHX3ViMElVEqwS0mpwTTevSs+Brp8VzGR3OH7KQ7ZKau72XV6K06Vz/DLrgv7Pc9y9GHRer76DN+LGTiSOMaZS95m+ciI5Mjwz+tdC3JK0f8dla2i8cu2mK8nE1FoGSyogO7ahrhjdKp0OvakmUIXujdJlHfix50J6qWVzYdZ3k6TsTU2taoEOt5QGP0HCxMx1GxFIzGv4Nvsb+01kWdQjHf/UefCB1/chfwGuuqCnKE5gY+w+OAwyXILJ5siEQwC6W+E+46k1VwyZtyezaHemCJyRbKe5DtwRAKkeQ4H4w2NjNayf7qoqGkJ1Gy4RVHEGSEYUcCx36VaI+ctUT90EbkTiG1RZg1Gq647r4UtrhbCSvYhVjWR0h9Qk9+AFEYYZ7L7OigNHjhEtOm3HOES81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(396003)(366004)(346002)(451199021)(38100700002)(38350700002)(6486002)(6506007)(1076003)(83380400001)(26005)(186003)(2616005)(6512007)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(4326008)(36756003)(6666004)(478600001)(52116002)(66556008)(66476007)(66946007)(316002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2RoBG9bLVYbcZxQDowh8LBc626TrZeK2KvWbuSQAj8IwukAB8jb/QuxOP9wn?=
 =?us-ascii?Q?oKLIV35bh9NnA7+qsD2zJ6i69q8M4+sFppvxK1vyJQFl+Hy4fa/DXi0s5wm3?=
 =?us-ascii?Q?moFnzw5RiTvwPjdyG/wivBO83ryp8GACGy2UUUKgGKYZSo+4+x6wROelNAWm?=
 =?us-ascii?Q?4sZD6ec9JYTbQ3OlkVe58jzfq1fNDYfz7/czC6ZA22laLuIQuAXyGvOmm3Md?=
 =?us-ascii?Q?A9t9C1l900gMQkOqKPWmkVXm9kLNOPUga4SaYz1DibgWGSVy1CFVqgSOUpNm?=
 =?us-ascii?Q?/1yQFdLdmrBISnRvpBfQoLTPoR0kDyp7Tvl1sT6gcPAJGrqhDjKK84wb5asQ?=
 =?us-ascii?Q?tH+4x5FYZksAU5LW9krJyLzAYKtbhEkoL6499B4EKjeV7YEM+tVYqAzSJTRp?=
 =?us-ascii?Q?aEnc1QNrFbIW4DeHPDYBP8g1BX6hnfA7njeyOndFntRlKpzDTTintotEA8pR?=
 =?us-ascii?Q?bD2o9bPOr6iBY67SBGWllWWGSELhbDwGsbWFidJFHS5SN9ISSVzP3JRki/w5?=
 =?us-ascii?Q?QBj38EsRsXB9rUyXANX7jpGlQsUGTr3qc7FS1HMRPFrz2MpHCBuuxx2MHik+?=
 =?us-ascii?Q?dCgx4MH2Kv71x1UAtvrDM5Y34iEr99j0Pd9h8K/ktSRxnRRi9BrDGir9vwd3?=
 =?us-ascii?Q?0GEXOCiQLMdTwomvx1juASj1w8nmXMrdf/EqCn58PVetjdMhzHw9gvoqc4jA?=
 =?us-ascii?Q?bTR9i+YE9EJ5LKs+8BbkjupZRW32MPRcJaFtTEwQ97sL7M9B6zHrrsRUosZS?=
 =?us-ascii?Q?akPkI5Sf1kGJevXL9BkeviMydWHlrBqIiXU3ROtsaZHst1L1taycBIVJ8Ldd?=
 =?us-ascii?Q?Nt8ipaJsVbsjBK8MgflfqbEz4rP9NRZRmzFPJbUgUMOufyVrv18E62AMucIy?=
 =?us-ascii?Q?y+tHysxCCIxEuXjqp03luCkm97IBgSFhU1Grrpz9YVK6kvoLKuWKgCWqfHYi?=
 =?us-ascii?Q?Xm8z1IshuOkM3wI7pXQTP7akc43WuzX1PH8lkz2bgO2+7EOpdeZ6OMhPk/+H?=
 =?us-ascii?Q?582qLXxyOFwti/qVbNMJWPbQkhHLdPCPZPElem0fQDGes83iFAtGaqWYHtlU?=
 =?us-ascii?Q?S8UMGaMGUKmbICvOgrHG3q6NvmF7X8w4i/PLgq285oGSsx32oOcPH/56tXL7?=
 =?us-ascii?Q?beGlsVW/YEiBUr1ccQAuFqkYyiocvMzwr2J8lyiVoIqlzV02uUeIruTayyrR?=
 =?us-ascii?Q?Oo5zbY47e0dinoTKA2b7nfy57rY2CGfP9un5Adu4n8RIcunWxcqznJ1d0hr+?=
 =?us-ascii?Q?HVCzmXSTpxO3CyjTbg0TkMBQoqN4z72pQSJ9Sv9lKoJSlgnt1PQ34eBCFn9i?=
 =?us-ascii?Q?+Yu40kmmF2Fb35OOWbz5ieQ6G3svLlowFatdWpXYqr+0fb/e8cyvylfBqFV7?=
 =?us-ascii?Q?V5YPE16xoLg7lwcSSYySb0QD41wnxj5CW6rJXDff/Zfte7vgb3bhHyZug3Q1?=
 =?us-ascii?Q?n1yQNoeA9i7aHHGRXds/rGx4Q2hlpJ775vZQfucRfHObye3CWQFFSId9kOeA?=
 =?us-ascii?Q?gwatX0WHnYoNb6hZe1PWnnbuNF51NPky2zlR7QNpj8livMXOq1CMAl5Md05h?=
 =?us-ascii?Q?vltwhqSiGFS+IOKD/qfs+mAdUjy/grVd6CvQ9n+F?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aadbc94-01e4-42d9-576a-08db6f386c54
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 13:40:33.0301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vThZY6oENUUwLl1//yoo6SrTLo+DzWhPWKI3YwyHjaOPd2fBYycJfarQ1BZjlnJAhFPpT1Wr7zEePVJgWmSrOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8220
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

