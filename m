Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658DE73415E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjFQNkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFQNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:40:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56329B5;
        Sat, 17 Jun 2023 06:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcWRXl8UaDu2LvMgiAytdI5uejyD5tGuHqFtYcz9pF5JpaV5Jxi7o8f0jnkEnK6msBywxIDmNwUXlLN4J7lBGYdDRyr8ibw/42BMTTwQy4YlWlXCfFSiriTK5njlwPMTtKSKG5UKn4YrOY5dwTNT9aU2tLNlCp2pWFyJODrn1vNnVrbnuzYEJXPGH95514+O4NE/uirK1enqoaFIZhoPn5gZUg6hoWaPy18ujcceXsHT+zNhXQoOiNbAiiTw8dfhkFxh+IM5D07/JDA+rNJnXRM2HGUUeygCys2+/Uq1PKctwpkuuwSnERvcSVwccXLPBkRhZLKeb/JTxe4S5wgfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS0sd2fCjCcu1EDyY9PsaHFOhTHLkMaQNrEhYdtxiPA=;
 b=PUrTIq8lvs3bFUvM11Cd1fZsh1xtv7z31ifNmWDWmqVv4/5ZJJ8oTU8PzkjZB4KjIL90L74j9g29eN50v1giPizD/RQzEdqUwS9Nfh9nV63uR/8kunM8bHn4pvepdEt1nFBVzzXe0ywsPI7r63DvR3TyuQhIYsrtto+2C8mJTGtsXZaZR/3MVwmBd54YbE1f6E0SbZlNiIxfkxCre4IdR2PhBC8USaEZWXiS84Lxxom72pBVu+ez1nQX5WR+kwxK5ur0RUTBuFBXxrNxL04QV+5Fe9qCQA2EVg51tp44LJPtyvfqGCDVbeAjHKHXDlNlSKXY/Ykdl7By/0r76JKCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS0sd2fCjCcu1EDyY9PsaHFOhTHLkMaQNrEhYdtxiPA=;
 b=os9A0AYlKTzcCUw7W+Z+aidSpagtHnU2KyrF6l7O5IjopyqSoVnFs6Lq2qNVdh5Jx1YrC7zxsZnxfe8gQ3lkPAty4UdjUn0KkxvPmj+WDGHnEnldB/9JQ7GokSmNpF5pQd9ENDQv42/eVMLm36rUDguEXJMWL6a4n3PW8T4Loro=
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
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 0/4] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Sat, 17 Jun 2023 16:40:05 +0300
Message-Id: <20230617134009.23042-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::15) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9965b0-96f1-4b21-19a8-08db6f3869f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HTsLjr1wjRi2TZkSphBmiDyUIPpa9f9KyZ/aiqoD6RDDl8OQNmrrZT7WtdNOWJ4oR2O/ux1Uw6dcXR/K2m2EUh7+cbgBZLsSeP9AjhrkPJuV0EbxPJrDcxPVfzEl2z7EBLEu5yAedvYDfNu21tMzQh0zhyIHzHu2eJnUcOsRuW/FVNC0Ic3Xd3I8qDElQIaUkym+14ID4ZOhcjaevWcHaiTAax3RV7e/+fKhE92rdrsh7C7EH+9fxnonkR42bFNp3pFxdzXSbdywjnlBKAmz28h/B4c8oqSezgPQgpREXNCQje+9A0qE3gWMYGIabT6BBnh5sfvrvRfh0+bhRX+dLRZkz0eEJhd2rHSOzr4lQBpDeVRA4y2sg1Lvz5JvigttKQJug8/thcVd1c6LWDeLDX5g5594CF+aiMli6ih5EL5KiS3hw6aybrE0IaU/o+fU+FDS0diNQV2nf8q8eRlWvmP8NWxpUZlFOMw5jVGjt5hdO+hbnpq3sYIxbm0kgIQO/kdmBpkkbDTJynIJN+AyHfN1r2KtYYkX7s/KUTHIDkSlvPTHsrIp0T3TeHti+ZXgyPI2lmHmAbn/N6aEPaSln57NpIi/7mFoDVkYzV9jrdVn8NRSUWO/nNWruuuPocz0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(396003)(366004)(346002)(451199021)(38100700002)(38350700002)(6486002)(6506007)(1076003)(83380400001)(26005)(186003)(2616005)(6512007)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(4326008)(36756003)(6666004)(478600001)(52116002)(66556008)(66476007)(66946007)(316002)(54906003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JruYQ+QvQg1Ugasoi4BXJz8Sraew/D5SJ/9eyyM90MGVCM1qmyLBAyD9rxlN?=
 =?us-ascii?Q?NtW5n+wIvgcSPOGf3AMdoQY5KpazzsmkTFL2BbNh8rBrxu7mnz4ik7B98YAn?=
 =?us-ascii?Q?NACSRR5rYrPyFp+g4vpiNIQ2wWq5fxrDNEBjcPdB8CCLFZe15mhFow5KmlKn?=
 =?us-ascii?Q?XZVC4tsrs2mGycVxKp8jtUpk4r3V5vjhGTz85jgxNRdRbvB2/L9svO+0HAuW?=
 =?us-ascii?Q?QtYSM7Bytv/DtQG6ln6fs+S1GWhY7xJW9YgNmsbVtyLixRlBqZfoaYUUidxp?=
 =?us-ascii?Q?znR45CCvifIK5vfDpAQmxjsQ0bDu5ek+kA4vKliu3rO3E3cWB2Z/wP8RKcZC?=
 =?us-ascii?Q?TM3cSoYtQgxW7inF5KkV6daSQBONMbNxs5fkf1d2PCIoC6d8bhPBehS0h4z3?=
 =?us-ascii?Q?jY5Owyt8qRU2FkcgIuPWwHtmK9g4sOlB6refCfCZ4BZaIMHVkpZAZubRGAXG?=
 =?us-ascii?Q?Y3V7FmrSgfBzfX0uc7T/ujy8Tvt/L+Q9uwT6Tl52JJtEXuk+RL/ox+hqltn0?=
 =?us-ascii?Q?UIva/fKiD3zgfUkWfgr/ol/dHsaXZ7r6EVrr9ycQFKCtq9qud00Fmz/clTNT?=
 =?us-ascii?Q?0yhcVHxESeDsFYBI050NuR5kcvLOMEbPQuGPrUl4G9HeqvA0x8tZkCQIL24d?=
 =?us-ascii?Q?lrBL3fu3rCEB2o+lPlhhUYfhwlzJmF+1CGwY8AtKSoinDuDitmF+x3t1GM4Z?=
 =?us-ascii?Q?jC2UPFjhLjOG4aW4tpDHe31nKq2B4YYbdI6c3VY2Dd856AW9RQbsed8op+XM?=
 =?us-ascii?Q?J/ECGt98UaWIni8ot8JH+VBjGYRYhKs0O5ky25L4CnjtHGBdE6RrzSr3PUqR?=
 =?us-ascii?Q?QkCTKNZJq41xNIq6S0oLH70vEUeIBid6GvNU9z8XE/RmPCoGt6mUuvmZzTGz?=
 =?us-ascii?Q?i3aWc+P2kOqNQmUCx3yRVq1giz3zafY5xY1uIIGg7MPBu+r3PSI/1/8yvjse?=
 =?us-ascii?Q?3+kRahalBD6UF7zgCfk0DopFK2tDYfm/AVsskJMk7GD0GeB1DRu7fABRyaB9?=
 =?us-ascii?Q?ATSqIhuDDIHheHRRPsPrrfd5Q1DLdax+ygsU5Z34L42SGmN1yUZ8jjPAVPrO?=
 =?us-ascii?Q?sYjDLnqYktqPcbizHl6ihXp/xHILd6TgMhIxs0yCAyP+59bKsiN2aUmg2PsT?=
 =?us-ascii?Q?S82Ron+1hrJWYU7Peh/1eidpHeRcrbLOMlsKjFw5jDwKKZy9VNzUU55hqdK8?=
 =?us-ascii?Q?JEl4FX2Fxz82MVtS4TVp7CVOeFOD1fjXVsojjPCxguSPY/O3cNVIWGevuBSG?=
 =?us-ascii?Q?hHYGV2LOOS7MMkolGKJo/g1UcAvrNV1ZdYKkOAnalgRBakj9Du6CZff7Np3o?=
 =?us-ascii?Q?BDyWPJlODIbv1smJn4OoCeBQIG0mdPnjg98MXGJVBTEoU0DiUAoC7uI/wAyw?=
 =?us-ascii?Q?x176sI4vgU+R0/UxwmmpO6GuOGSqO90ePMuW0aYVOFpJ8yMIWXBmWuDgDwGM?=
 =?us-ascii?Q?snjn2r5VcZvrnmfWTzH35HOiAXJT6HBUE4/ksG+KoSPLQTPIGOOvpa9IXCPU?=
 =?us-ascii?Q?sOh+XG7O7VpwNjMlmXrLIRQawTI5J5QsBykbyHTdzrfDX7v64MHgAqeU5s3m?=
 =?us-ascii?Q?coSfuS96P2co9bHGvk2zrYPMNaT/b906Q1LY5vLJ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9965b0-96f1-4b21-19a8-08db6f3869f2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 13:40:29.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuhsDInMe0nkCX4x5FXVofCRbHC7QkMX8px5nbrjD14sxk2Jr2Vr8waLZYEz3Dql5vPzwdWQ9psKchzul9JY5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8220
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
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  75 ++++
 6 files changed, 465 insertions(+), 1 deletion(-)
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

