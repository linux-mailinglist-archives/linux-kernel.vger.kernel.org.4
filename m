Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3758732F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjFPLIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345372AbjFPLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:08:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A2D3C05;
        Fri, 16 Jun 2023 04:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwuZGcvP+66ve7+35d0XT32yn/ZpIWvnsjDpUpUGEE/NyHsdqPvIck77TxH5Oet5FF1rDGtpa9N2UrF9Ao4is5LMhMY7g6g9YqvAUZaNsvqOVHQR2kW7AaJWPh/eIBG1wIIfn2G9WVR7IixaBZYBEcMPB/GKGYSo1W5TqlHckxqYLOJjzZFb7FTjLVpmjnipjdpTR0+AqvyKKwD2pRcueQyAsBkN/SjeOuBr3QVXOJsoRA2HLjfp1sF37ldSjnULMW+cgYCgBn1Xms3csxVAQ5oB9TysL6IgZHYCJfH0Mp/oF6N5UpZuhYnDtxh+F9aUVeiIv3OpbJCF1ZgxZiHSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICcbByvqEQPoW59hXNbDAJF7fRvfPYjjnHdom3UIdzc=;
 b=Z5jkxGckiwW3XBQx8YKLx3IXZDJFxe9RVVsXsT9u2lLkWMsbPtNxcgI4KJPDw74AfSxy1YHErARrx6N/TE6G3djrWi/d7C3Tmii81me7AQRSmcavG2riQELqFATagFgV2w/L0NsiXE5pXzi7EnnLIRhflnzWggaSwrcXMu8xEalJJMLAR6QqvGJZHArWIf3PKLzNOITSQuUge0ltbjm3NuDTMZS6smMxKc7OLRd/scCUIldtzKMYKoDmYw0KaRFxORDHGA75fCnotFpcJZ36ZAULtrag+aUWFR123sP1/UN83dZEkzaC15V1w0Vne7xEflGEVUHxzjvAiyUO+vvRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICcbByvqEQPoW59hXNbDAJF7fRvfPYjjnHdom3UIdzc=;
 b=Gp/uxF2Ji1I1OjIbdzaw+BJwxVNVeVZ+bkAjljpXsb84E7j55zDd58eH8xTu4zDi/hOW2gYoXZVvTlcFqpUEo6Lc2tX3xfDdSfd/gyrSrZA85hNbXb/4jOSC3d5cuM01sbLxr5msyAHpaZhYhUBjUA2XBnroJ/PfNUHto6UA3L8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAXPR04MB9491.eurprd04.prod.outlook.com (2603:10a6:102:2c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 11:06:30 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 11:06:29 +0000
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
Subject: [PATCH 0/3] arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board
Date:   Fri, 16 Jun 2023 14:06:07 +0300
Message-Id: <20230616110610.32173-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PAXPR04MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: cc06da4d-191e-4001-e1b0-08db6e59bc83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NCtLUhPVizNNUuh4aYYj3XXscQ4x7378pR5tARUJYOIB1Ba8ZmX5eMLp7yLvF4oQVFG1998Uf1DJfJ7yv8mnGD5VCdPQ1YCVME/k2/eH03kT4KCCkSBEgA8+WWgVihZkyh5N2clsgR0ql6PLZQflJA+mWTwfHhCsUZB1dPY8IAI/Yz4bpDp5bumK7rfHqYHmhvefN/sA5h4XAdhTE66sMlAH4donDyJ6Bgapo5gPwTr1c3wCxLmwdIYLF2wzRzOaTLIt36pFRWTQofa/MVeKVg80Ty6ZLkaibQZgacxaFxdEN1YWX8s2Gb7sqnrnPY2qGrnyYlntVbssMNueoEJMbI+WRuq2D8Y6Xkd2Sf9rV26KEoicuz5RkAkFcHjkP9pElJ+h07eaaDHTgtHJ/eqZMjMMRx6+WIpIihMG8xU1RgAdRBKWgcNqZKpoBCLFUCog40PAfEVX1P2O/9nWRXZKqEKpGWks9/B7K+MsfB9jJ9oGdGgt3BKoShlPb/Y6UIzT3O58fkC57OLEyktkNvEIBovqp7pVSvh84v84EMN7m/OKQ+MpPjJpBm8HiM08NFMkJfbruMwwwZmZWoY/Yzw0TdJaV0ZUU80hquQSvef3qYnYH1Jo5X5+BPbL9xKbGAlT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(136003)(376002)(346002)(396003)(451199021)(478600001)(86362001)(52116002)(6486002)(6666004)(316002)(41300700001)(38100700002)(38350700002)(83380400001)(66556008)(66946007)(4326008)(66476007)(8676002)(8936002)(2906002)(5660300002)(186003)(54906003)(6512007)(26005)(6506007)(1076003)(2616005)(36756003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oQrGZe7UzItwBP80eyU1aDqCe/99moj444V2rxPeme7W12rhzM85mzdTJOWJ?=
 =?us-ascii?Q?5aZjZr1Wsb1HzteMoQ4l8HTurNzJ3oCI/+JJx77k0Oiqorm7sNd6e7i4Senq?=
 =?us-ascii?Q?RX0d4o/+YWcS8YEEUHYoMV9kuQX4nYRVkncpVgg62r0AughUXiqZ3iFP3AGW?=
 =?us-ascii?Q?w5L1Xt2jV37/FzVzzVhA1gNnulLI2mX+cq2YoC4m8qOIdXi2uhCUgCwkkka9?=
 =?us-ascii?Q?11D7gOHVV43Tgxeg5JAtTRPq3PQG0nSGyZ/3UD6ok9GahnfNpZdY6EbxCKFN?=
 =?us-ascii?Q?OVu2EagS3lJiA3XfOnN7xxr6fyA7WmRQg07fZgCXUMJs8mrWRah4wwhlg6hX?=
 =?us-ascii?Q?Jny/GmanONPYJWjHUMamPm3gTQ85QQs2GVzZpDDHVy6FbBNN6BW5RYMLRj3q?=
 =?us-ascii?Q?ikVFDRp2mxD2FPUatsCHQ6k6gZmMZC2pxZLMEN8yFdF5ePb24Yj703uZYtA9?=
 =?us-ascii?Q?zSkF/lf9UvUUeBOozu0Vq+gsQPvhh6O5UtVs39P7PJBYFL+F5NeVtvng/Q1p?=
 =?us-ascii?Q?hpsk7y3tfxJSxtN8jMcES4HPBelvlYY720PNhB21EGc+C994tcGb4rQUxSvM?=
 =?us-ascii?Q?Khj5Q/IxYSfhv2IsDrKCLVxQAjzVj0vwspkRaePCdHr3lwG4hkgs3sJa++pc?=
 =?us-ascii?Q?65ONTLgF8GGbnxGvx4AJ385lmA5pRLDgxQEk+/UidAZkT+2dh6DVu5USy/M1?=
 =?us-ascii?Q?wXUJz7ESWKpeOvtDew0aQuUWV3Yx4Z16jAC6EyMx7uPi9hZNtsLne0467qEB?=
 =?us-ascii?Q?MZICYedDYlVJU9cSBjJfeJp0vnIej85m2+8IEv45yPr6E6zg8yUyJhaOxXBD?=
 =?us-ascii?Q?8jQUXF/yOlpxPHMPPtSItAzawnTLOt8HU8QDEZzBzUluSHJp0yhVLXrH7d+U?=
 =?us-ascii?Q?K9nf8+EGTEymgYEbgS+F/3GfG54tt9iEeQkZkIuzn5xmlyZNLiuDu0IafxTR?=
 =?us-ascii?Q?S+6MmzHx1DPQ7XmXuX61oEJMs0IYtJqvb6uinv9ucn3Ndl/GG4WpDJO91dKB?=
 =?us-ascii?Q?WWqQyfLJnHT9icyZmK7bguzAwSrLIrOo3ONdBY/Re3p6ijbBxXPL8JjPoF0s?=
 =?us-ascii?Q?pi/mJvnt3JnwY3j0Gutj/QEmYo/WIHp941ImqDcGdvwpub2e+lrWFM9LlJRy?=
 =?us-ascii?Q?TD6v4lQ3GkiCw5Eo8pVEl44qGuUiNwfzdknmqfSJw8eujclFgiLcoovo7cPO?=
 =?us-ascii?Q?GeE/vepkKEgmYz/ZwPLxEPcIlKlAuo0CAhWgeyaA3+m+gsHMc4yT2hgSN+P6?=
 =?us-ascii?Q?dtsd4qyuTa5g3pF+mVdvyneQR7ylcksiVkdJH+OHEJ20GhdAEwfr59gngh5l?=
 =?us-ascii?Q?LSAGRkC6DDuANmggBVJ7waxOMj8XsLLz0/5Ls4JetAHKCIf1Ojoogxea2Mag?=
 =?us-ascii?Q?UA76JxcOohCvM+wXBPW/vn/bMCbC/ohG3PU3GjbUb9sLHoRB3uKTufxVJpGI?=
 =?us-ascii?Q?1+Nkbk5xCxIIlup+prbH7/s4R2JnDldFZQuu4YYW2u6EX6CRrfjMix6kN75a?=
 =?us-ascii?Q?y9UbOnGizB5f1pzrCQ7D5ktrjV94Yw95krozHPDE1XfsGOTXABA/JbSW/Vr0?=
 =?us-ascii?Q?u5IBKUmJNn3VYArXSSSD5OI1uKfi67XfssMlN+tv?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc06da4d-191e-4001-e1b0-08db6e59bc83
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 11:06:29.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOhffNOjLi2jM/BiKHZtQ5Y0mH8jRr3DiC10moOSiaVd4wb5tC4DNOQJoZaHF9Ccvw6Ob2w1WEMUPjH3n3tKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9491
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
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

Secondly the MAINTAINERS file has not been modified.
Is it required I add myself or *someone* for these new dts?

Josua Mayer (3):
  arm64: dts: lx2160a: describe the SerDes block #2
  dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
  arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board

 .../devicetree/bindings/arm/fsl.yaml          |   2 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   6 +
 .../dts/freescale/fsl-lx2162a-clearfog.dts    | 369 ++++++++++++++++++
 .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  78 ++++
 5 files changed, 456 insertions(+)
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

