Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752F734160
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjFQNkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjFQNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:40:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B729210D1;
        Sat, 17 Jun 2023 06:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwVAP5GiwzgoXA58DvsYuxrefNstWReo+9cgSprFYX6BsrvAy2kNVUl7NsCbq59NmfAGKRxc9Y+BGoVhDcufLTy/1HIdLUdKByoYWI3UUzCA1kXODlPmuyVkxRIpyxL7Ny/H0TX7cDvgLxIkC+I3UxMWW4W9pq8Ktw5Fm5To8j4MfHhPtmXrggYpnVEafWo/bULWfzbd930syx2mZdNUTv/XFImpSBCCbc77Okn2DMV7cBYKczw0ddI8b9sxuNHVb9V6ivfL2k/t/OsYqNSjEuF2NjdULgIdjS7Hdw3EWrhikSMoaQwMDuA4Zsx3cATwcA+1FgAPJqwYtKD9Y07cjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3P4IeMRZLwo/YRicrA79JgdAVN0iC/qiXtjWlXoXLdw=;
 b=kZDcvunZqNspYgT9knnDrGtwxmrmjVt7zbeha1H8LIocoVyyYqj4BSiGGLcIqhviX0W00CzYLJEHfhT5flC4McMRcmCLfLzmxREQiuOR1KQJLDWP9exANMK+rHAAeo2ph/KeqXPjJ2L2ctiNa9+7xZdJ1se8x0yRIeDnu0Vm8rZHX1dj7119wITK3TGzjzNQNqvvaMMgFihtfran0mZAJDipJf7wnb38SU3uTj1o2YQLf8tI9PRKAQ7ME+ioSL+6SRozdXM1TKPptLHifHPH/3rYVA113TDNEiO7x+xrOnKwnxr2dwWIPAvagf5YjolkZe9ZT5R2lnC5mBVaqOmXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P4IeMRZLwo/YRicrA79JgdAVN0iC/qiXtjWlXoXLdw=;
 b=o5+jQTm7hjGBRuZJNE+P7Wxv6zsZZzOpOmhzX3dljShth0Ac1C15Ip2zq0viZ3XaQsuXrRyFfZ1DX8ns+FD012p79UNsE+W1pl1H7bXAAe/KdV6TwaV0mwxM9l5sLVnpyBAE4EWgbiObJDnFKgCMl1OOFAPjcoPE50VIIePMOv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8220.eurprd04.prod.outlook.com (2603:10a6:10:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.33; Sat, 17 Jun
 2023 13:40:29 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 13:40:29 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Josua Mayer <josua@solid-run.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 1/4] arm64: dts: lx2160a: describe the SerDes block #2
Date:   Sat, 17 Jun 2023 16:40:06 +0300
Message-Id: <20230617134009.23042-2-josua@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2c9d913-e2db-42d3-8553-08db6f386a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5p0wgSq1Pod1Sn4CdQ/WGuYS2zeCLcWiy6vZ3/ij6z0NTF4PupOxlSdktIePysWlkyiERFdohLjQ99IMlDbhAuOeZDsVSMNeIbIG5/GuKJL78mDz50YkifgOMHlbfLXHLYDWry7JOi3VvfIlsEWZ7v6cXTz0kOuo/lZFOieono5ntwsng14gOliCrHqKp6J3lKES859Yh96gYpgG9lq9WdXQxMfjsCGR0UeN3OJm4wDrRHadVuZVbk6LLRy9VUynRZuErvr/U1N8+OJUXzSkyTKYUAPT3d2y4gLYDlntV/bK8praN7xYk+XOaoUmiVglNzcw/NAxrLnTmGw+RaePXyQWiD4IBTc8sIJRIxnFyXcJ4JxlXyZ8sizKZ4FuZQW4z/v2ZZzolH72mHvzgsnIiZZTII5sPIE1laetYzXVahVYAMNXy4R7Yqgj10qJbS7zHj6nx4akqxnHqtKuXr7nG0ySzkhCLLInaSf5HXHk7FcbzapvtRZsGiMGSW8y+zzfd1e0MtSZJnVtgsogxK+shRM9PrryOobLIwdsFdjj/n5W0YCo0Mp2yO63xjYU1ZAO/ojHBRk5nwsFL1oVwxPXuAKg9juxccVvpTMsTOmQQIXfeMrVWvxFBYuWRcGDbmA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(396003)(366004)(346002)(451199021)(38100700002)(38350700002)(6486002)(6506007)(1076003)(83380400001)(26005)(186003)(2616005)(6512007)(5660300002)(4744005)(8936002)(8676002)(41300700001)(2906002)(4326008)(36756003)(6666004)(478600001)(52116002)(66556008)(66476007)(66946007)(316002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PiH84nCxayxcBQQ0Bcve2juVbAVozm3rSKXAGaoYcghnZbmr9vLkajwtsRyY?=
 =?us-ascii?Q?U5SebJ72ftIrgyQf3GKlgWoGrAfeJhV3QTaUa+lbab4mNg7kTkuKEZBV+zsb?=
 =?us-ascii?Q?BjmjRh5ryn0U2Jp5OI1NYh6l5s3+NSgv4c0zAqkQshtmOb4FZufX99QTfW8u?=
 =?us-ascii?Q?7SnRRXrgGCawrMXAjRL4/e/yxU+GwgfKdBvmWD2y5HaVJFZMCjiK2RH+V+70?=
 =?us-ascii?Q?f6SgUrUThRayXuEJTGRKWlRjb82zbl/8K71llRSCpDKxltmBZyhIEdJyApsK?=
 =?us-ascii?Q?VvU5gu/7XLXrUt8akdp28d+EYtoRcnSwpQu09kz06LmrSbVy7/KbifmQESb/?=
 =?us-ascii?Q?9dcpZao0LxWmpVeoZbD/wsX1cmgRm8aVOZH9bBh+NYQMCmdxNzjVrQf8/2U5?=
 =?us-ascii?Q?5VOuiura81dhid06qfmDa8O2x/UegGBDgQO7kROjkcMPhsmf5EBB9guBOjdK?=
 =?us-ascii?Q?xGtQFg+5wlzowRIC+VRAfCoth9eewKbqb4ix0Pc/JoWoEva5BuD7StmOkK02?=
 =?us-ascii?Q?6yxlTEEJhAIvFcCO9Ned/5LdPjBQdsiSTWYZz3WTqVo+z+xRbbav3Y4e1I/+?=
 =?us-ascii?Q?AsncTGNrnmaqT7naqZE1meWK8fMjao62YuMCJvawHRLoSLO3KrxQATkPl6nB?=
 =?us-ascii?Q?3EsXlT1xV9b9PeZUNPYcdS3scMsjaZwoe9/X5HZHpcIJU1AMet04L7oI6uhA?=
 =?us-ascii?Q?q5BX2+enNWyPbDumSEMFCCi4SIkINpUumzZocWuoGeugi+iAzqDKNJ11snug?=
 =?us-ascii?Q?hbbzNHbPBb47Wi468UwlnvnmTzhYni9oRUrl6e859MBSf+o70qNb4MrfyXdP?=
 =?us-ascii?Q?UXjTGiuIRJe0XZnwSQVyMwuCPLQoqOihtc+gSF3dtvcliQ/uDqfmXpRJVUGo?=
 =?us-ascii?Q?OjufSYi/wuUf5m+4ditwvfR0GS0kbVKjPIECoxH/uUn00DGso4f+Kp0Ti1i1?=
 =?us-ascii?Q?Ds4wSz7lXotPu1rCAMDYKuigt7EA1/8L9WhU654wV5T9dp8uCu3oxVR00Lnb?=
 =?us-ascii?Q?w3yDp8Lt86TwJzSEUnKkWdMQGP9NXfy5xVAelTgEOq8xp6sSdMv6zF54xQaj?=
 =?us-ascii?Q?vdH9AgqCjPXoxvZRx1AecQ2dM++80qujvaBFphvL5dib3Hm3TK+KPXw2hSsK?=
 =?us-ascii?Q?llmJxQRTynqix+RkWLHMQkErWSJqT2+zvEjYKkqN1wi6tQ5ShogMvIYo+Uqz?=
 =?us-ascii?Q?Ko6MxLAzQLcTZH/YZ26syY0S/CmytthPtZTPverafnXClTjjy7ALxRWplodN?=
 =?us-ascii?Q?NKkVj3ZEFEAO62u9avvrfjGcdiE5B5iibmobIR1HxdPICuy3lc4n7kTQIdyG?=
 =?us-ascii?Q?+tQHTf6IQ7W5ycQ3mupb3s83J4sr5G81udCkKoqXFSitf3oOaj8nz7IvWP3b?=
 =?us-ascii?Q?IWcZY/Dpdm2KT5TMxJmsF1BkvArFxJse5vkbFvcxMhElABTe4RlhjhZaXEI2?=
 =?us-ascii?Q?5+I2tQAJoN02CsIRQN6LxdBBq90AjLQI6VzsBECaIYxEArtKK6Q9pxWv1ilk?=
 =?us-ascii?Q?04kzhymbSpMiqpaOtS88RMVSSrAd93Kd9mfFEXD8Myx/qX2r+1BCpZeeXXQH?=
 =?us-ascii?Q?TBN2JmzpBTKJ0mlLG4p9dKnVjPfkGO++FqSRrxHn?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c9d913-e2db-42d3-8553-08db6f386a64
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 13:40:29.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgDkA4uwO5N6GbmYuQ9b52pO9OOC2N63WDJATDVSOvNL6fktGY8p/HSLo8DvOzhgSJXW3TKcI6ObHP6O40Cb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8220
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for the LX2160A second SerDes block.
It is functionally identical to the first one already added in:

3cbe93a "arch: arm64: dts: lx2160a: describe the SerDes block #1"

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index ea6a94b57aeb..2e68c05181dd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -626,6 +626,12 @@ serdes_1: phy@1ea0000 {
 			#phy-cells = <1>;
 		};
 
+		serdes_2: phy@1eb0000 {
+			compatible = "fsl,lynx-28g";
+			reg = <0x0 0x1eb0000 0x0 0x1e30>;
+			#phy-cells = <1>;
+		};
+
 		crypto: crypto@8000000 {
 			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
 			fsl,sec-era = <10>;
-- 
2.35.3

