Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9826FD98E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjEJIfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbjEJIfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:35:05 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2075.outbound.protection.outlook.com [40.107.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A0B7DB2;
        Wed, 10 May 2023 01:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlyraTvVYBz1zu4ZqIxeBae4wMDAVQFRXHxpbJOjCp/fz22SFmSQsF3gjvvMysooT+GCpwLC99EZtTJENwbkZaGzQnhJFXBECciG6yOuv8SImifz9mcm4me0/Kv1tNzi2+S4Cz1+CeNgcZch7NZwkaNbw1iu7dmzrXK5RMPv0AL4yTc0bF0+6MN9Xffw1rzf5ZrBk+9Kqv8KPmtSenumt+GN5Opu1Ufa1G3z//T7qMrWDbFhsGYNqvYihVmiiFXWo+F6DMlYDt7TmNlkKE8fAGPxp6n4r8r2/lEHWnn+6+B/f7WTKkHXZKnKpmASeTXv2F8A72x7LOOH6MveyFN6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qii1ZbxvR3Y/vsb9KadoWCHWzBEywo+555t+U5AK1ys=;
 b=IvLL+bNqLzwbBnYzDWC/8RrEv/1IrXRB3NmUYMx6e8muCJod/tYOjWAOWU2EF4Waa1hlMeDR8kW4UJwm5meDeHyseSGT2c4HXS07THjborIeYe3QM7b+CqogIs3tmTggUdlHAAtqC0QQY9zKq+zzCaEOkzw0VS4BWhca1wDQCMRhCpZlv8xs/8jj3YB4z3jgco64WbkJhm55KCVfEertnVc4/Ko4rYURu9CYnUFQghUYgf8h1hpV4o6w46osHDYzJw1nZlvd6Lo6F8obaq6jYPyxvOAAR79KPqLxYviyTKatyTsqssDcW0psG70HUwDn6EdF//1Ml+M15InquYIjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNXPR01MB7204.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 08:33:24 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 08:33:24 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: arm: fsl: Enumerate Emtop SOM
Date:   Wed, 10 May 2023 14:03:09 +0530
Message-Id: <20230510083311.3692416-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN2PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::15) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNXPR01MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f5c1d6-1b12-4ddb-3d74-08db51313861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aytqTi87U/6u0sAExAO3f2feQCu81SEpDpT8I8MnRQsMi7FDfs/OeVEPZDMeDVGWeYwqhyor952f4yCX8T1k11qi0dbg1UqLkjsH0xFr1qtcRMgjLVm2EvRQhkbt6c8bXbf12qjC/6ja/xJDanxA13GgNu7/rDQOQ3XfPUmKbose7YX+tOJzLqvQtcyiwLv0H/SpDRgnXaUpGzNP8/USp56XBC5naLfhZyZV4LhWhGu+z5JE2nlg8g/Q/zAI+cGF31YSqEWyuAn2Tql97F3UprsEEzTTw/JZr1+Y8olSp40HrF0paONH3NxlDVSOyCOjUnX7ppBERjwizG94MdeFgujpYg4RhKYCqJyd0WfyAbaWnok/oQN5pi5QajxE/hnvEoXRqTF+R91jad68TFJFMGXPWtaAz/TUuXMITYa1ipuZYQy/3tS7PHpz3pVcZrPlZ2qRNzAuwNgn66EL8Zel1/Tt0DiPBzPw3vvDSPvdC7FHf+fiR9HWnImdTFHV4nL0t86194Di2yLD7G9/8eojzkkwG4J6poHKd6CxieNjUMoY6ZE6g42NgDGFf2b3e7ElVdctDv3hOzDaR5OkZETqliu+CYwWa3rR504MrFAm8o087stKgeiuLq6PgH1JEZ0b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39840400004)(396003)(346002)(451199021)(66946007)(66476007)(66556008)(2616005)(86362001)(38100700002)(38350700002)(54906003)(52116002)(6486002)(6666004)(186003)(6512007)(6506007)(36756003)(1076003)(478600001)(26005)(2906002)(4744005)(316002)(4326008)(6916009)(8936002)(8676002)(5660300002)(7416002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8xFSVAPnv07wWdsQLuaz/Snn5lr1Ik13sujbVoNmNl1+CLvj6SfnxdlrXix?=
 =?us-ascii?Q?P0jhO1hOWTNPeafLCvDMi1Z5OFQV53xw8Ytj4qHdgGhrJhjVA8xwhrnwHJj9?=
 =?us-ascii?Q?abPEQDjUzZIqPIV7qLc0XookIwoxghfb0ALn2QNaXxBhDjVcCHfiKNWwMZ1f?=
 =?us-ascii?Q?zBe2Zuf8POhC031yn81H43Us4Oi/24iFW2ttlctLsBX4mr5HUBV0ODxD0iPV?=
 =?us-ascii?Q?iJepEsDPoTLq0WoSj173mjGAbFwEuxgIkovYwfnmNkCEGg0k5AioLMLL3cXt?=
 =?us-ascii?Q?EW/cCXkEl1K1aaFwDUnWiGvTteKsv+A4QHIn/8qU8dznzLmjl4qixRygyVLv?=
 =?us-ascii?Q?ql2AXxds06C0w3TugygRnYZDux/+UpiK1GzD1cwHkb+zY9nbxVnvM2hfpF/A?=
 =?us-ascii?Q?W9z7lTsNS1y6Oja1Je0skNLQqESSk6BIGL6I+Bw9ILZu+QmwQG4Ex++aaGlZ?=
 =?us-ascii?Q?FJo/09DElVxS27IM/VcJYEsCPxJg+74TiGajTBuWpkjjg1djw29hTHSvrUMy?=
 =?us-ascii?Q?2FxzUIQvECpzioqFi/RfkuHZKiXHP3oyFe9v70b6lbjZDGvggxve52MjXll2?=
 =?us-ascii?Q?8OqmOA51t/hT5UNV33WKEyJ2Y5tJPgS22I6D0eOa/fXrByJ+ycpwjzvz4uZq?=
 =?us-ascii?Q?qNsteIBH/Wr68fQZZ6DXjLTA4wn+XVSEt6GxEbfWq/TEgcpcmrJNK+4RYoXn?=
 =?us-ascii?Q?/qYu3SEEzvLDJN71FLVnmfxVb1af71GPR+E1wLfDR8I3ijKdkNI/mqSo8NgN?=
 =?us-ascii?Q?LLNYCJq13P1pO5mOEAn1frav/7axVXKQXW+nx1L9iVuXXSCJlkxpJ+3rk4Qh?=
 =?us-ascii?Q?CcFNsZgVhuMRYRFtG/Ao+tjljWSIEcyugeW4WDmA9zTgg1Tfy70nUST9Hw53?=
 =?us-ascii?Q?i+aouLWRZeYKoH5dzkLBZbFTVW5nnDULdX2MsCxcraGnWpcO2Q5eaHFX3ykr?=
 =?us-ascii?Q?XkNq0Ea6Xz8DFP/N8NRu3dxpEXor68sx1jWatbBBjTMHzhfsgYoNU/k2CfXt?=
 =?us-ascii?Q?QrRrgXgA7gtmngluTkPApD4yDlDkZ8Tjit5a8c0Jq0QH7LllnvzEEiBHsh/w?=
 =?us-ascii?Q?ji+yiIwMWW72lUuvPGl2mXF68qD61f7rh+wtzZrk9juJQISh/1kAQZM43OpZ?=
 =?us-ascii?Q?OTyUk4083czH+e6gGwAId6I5HmxO1ykQlvylvSbok/xmmMvdSR76S7C+Jxya?=
 =?us-ascii?Q?gBVpFyElUL6L+Ugbs41B1eBX4gT1zq3l5FmZjDdUP+2NTXP3CROxXsQTw85/?=
 =?us-ascii?Q?ezctkTMWC4JT2wg1bwp2xmEb+AhfalPZab4bw5bKFwZ2VYhz4D4bhXpLdoZT?=
 =?us-ascii?Q?51xl9N9KsxKayGK04r+sbsY/TEL26SlIbJJu6+RgWgCyjE7xJLuRrUGqMshc?=
 =?us-ascii?Q?IRa2lPjleyUeJdtN8ha4/JWdLo/11ryBrUnjijm8yXhYT9owiho+gk6tt3C0?=
 =?us-ascii?Q?Fq+trJuvfAc3gpXElwcENMPRt+7Uy4BEKIlmtQtylbWJY11JlWyyiPuh0Jrm?=
 =?us-ascii?Q?zVn6AmYEdUk9DalRWR1X/knNSoTGJf0ZO3Xx78T1xHPVlZrukPv0Q4WwOYxJ?=
 =?us-ascii?Q?/o4RZMD7NvO/vDmdgB/FUd0yIDToqFMWLf4DepP6k3yAdSgGspp1jH/ItwPA?=
 =?us-ascii?Q?w8WU/srJWXrQsg9RbnnzOxc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f5c1d6-1b12-4ddb-3d74-08db51313861
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:33:24.5245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgleJ64OD7cdvleJM3g667iT3NJWJSdP6DoHAwt6HCR6D9ZumvBHYufiIGa0RmqFgQ5yuxbQ4OVlgPNFQ6HU/szv/lpfBdHGyIGWkFVjDPljYESCnI7g+RlZZlbxrmv8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7204
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries to the list of imx8mm boards denoting
the Emtop SOM from Emtop.

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 442ce8f4d675..06eb2c790f90 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -884,6 +884,7 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
               - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
+              - emtop,imx8mm-emtop          # i.MX8MM Emtop SoM
               - emtrion,emcon-mx8mm-avari # emCON-MX8MM SoM on Avari Base
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
-- 
2.25.1

