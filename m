Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24855671A54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjARLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjARLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:16:43 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197F4460A9;
        Wed, 18 Jan 2023 02:32:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTN2eopzLfFLuC5lrlllAVZK1nKEx+tbJ79beUKoPpLIdWnxQ1a/lLCJJ0aU/tRup4HhIVcKOHosSHvjtTjQPHTEB/32IJId13RusYm/dyH6Svzxc0QRPs9fFMmX6ToE4l/Em/HpFYZNSYRUQC8pkvkCd8JnuYylHM9Q8jIru6Lf+DA3dKnE+t520CYKUuNk6yIhYPu10y5YgsAhCnkEhRddcs2ff5qN+HgdRd910bcwtByK32PuAKppiPR9whILwZKoV0Kdy/pqqhMjdgjF70IK4US/PGfXF3cqbtmqubQuYB2nWf7wrZ/3nGfeeIERjbbJb+7SLY9kPcQgaYfPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8G1UoNNXbcHDBEdpTNK2uuxre4yce3ZQryu7LCJ+5A=;
 b=ogBWWiFMGW76JGyiAacY/RVR6zoZ0CJfj5IZols23zryRUru1NNRgMWRDMLc/Cvx5FH7Eg2t6R3PLBX/TdTFdb1/PfKYFxuEpEwwQTpdIRwr4IRrB+R/jWcuEGKQ1BUvaHGKa6VzhuqnQh8HEBhFZ5HT20T7WUxWwSSrdBN83cFqlEViuDhPA6n4D4QEzVhaByqcqMPFgMoiXAS8tCIqFYCmqetftuPH9w36YtSuSWSz3yyMDZywaRi+idIlsChbpjYRVJrfOvNLmPb6dUSmwGQ/DAwX+4mkpEFCRevMHv3O0XMUWqFxXq4k4xLTGjRDg4/aAxr5PTWqH6uKe5fOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8G1UoNNXbcHDBEdpTNK2uuxre4yce3ZQryu7LCJ+5A=;
 b=RiGBO3RW0Mx4QYyNQIWwOxGusbz1Z4eAKzK730k2t8mxECPb+TZMW2quakuiilXOS9Q6e+Yfh2/V7LYXYbGZZrpsPxGLlFD/KAF1RoBUk3//YX1j6df0pambscJoeLE6WnGKC4mEmoQDHXDOh16RWHUTgd40oqnka6/GslqpHVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB5990.eurprd08.prod.outlook.com (2603:10a6:20b:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 18 Jan
 2023 10:32:53 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.5986.022; Wed, 18 Jan 2023
 10:32:52 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 0/2] media: i2c: add imx415 cmos image sensor driver
Date:   Wed, 18 Jan 2023 11:32:37 +0100
Message-Id: <20230118103239.3409674-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0021.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::17) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: a3515435-ec84-4b6b-c639-08daf93f5aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5dfyEcp7ogGOTeRk4q+BoP5vi1zDPUFrrzhtIaHJ+ioufboS+kTwPX00w0o85OX2CXO5KWh4Eqj/Y4P1H+rnRO6pz1HpuWOIpVdd0lsVGY/Sx0tyi87bOmgZKbCxP6ZVZIG6riWqKH7Yni+380p4QQlttOJoJwodfKu8+eTI5FSXUHwrEUsDFpOYFplPdX9s3yHf5XwHcOZooQY/DKowfJ35sav3A2vNAKgAwrc5bb39/Iv9TNyyVRdojvK+ioiI8ZjVbOxisi9iJ0CV9zt5ajC7Uai9SdXbXHdc8llgtFLu7kboqxHm5slKFWdNUUqzG+K95bax02owWFurT1Imr8iTjiodqZLA880wQq7TQ0kCwFiOYCPGcblJJpFQt5OYUH3XTLSOQTz0VLceVHmR4coGrAzqYY7Rs7YO46xlADiztOUTs61IxBcsVrLPkiyhHrTZu6yfNDwlHdPcGy/16hA+H6COpDgTIXJ81xCNC3Usa80YiPPlzFC7Oqo00q5h37zzjNDa9iiItvAgJbWQAXmKdEObmKDi+zc4HMYhj8AbSd89g5EnrlsjOssB+9Zr+z+jgZLIni0p50zyw1bfP7v6NSQgiixnht6ebTgEhOgDV7daJ7mN1qBJzqkupWWIgeNEXIytdTgtiknLw6w+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(376002)(396003)(346002)(136003)(366004)(451199015)(52116002)(4326008)(6486002)(478600001)(36756003)(86362001)(38100700002)(6512007)(1076003)(186003)(2616005)(2906002)(6666004)(6506007)(316002)(5660300002)(66946007)(7416002)(66476007)(8676002)(41300700001)(66556008)(8936002)(44832011)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G4Q9hvNUjp1Zc/orszwLL9juGFmWb1DMJzW4nmwQSJ/BrWwFfj3OPcloaXVk?=
 =?us-ascii?Q?q8MJLaH0Vgjrxtze14Cl2toomqGuvRte+d0OTv8HkTk2+u0FuMEjDPcx/6xW?=
 =?us-ascii?Q?bTbA8PSgzOmUBSwb8OClhhZIo7Gpuichjdl8a4cDj27FGKekqnwhZd6u6Bil?=
 =?us-ascii?Q?fvxoTvEWP8W9Yss1eMDGSsyYIXQ3K4h4pSL9O4kHYxv9iThXvMUB+6NjEoJr?=
 =?us-ascii?Q?MaKND8XXus+0MK/Sg25HLAjjc/2ZZfFQYR13wt7yU3jufCANbIsVoyy4xqGY?=
 =?us-ascii?Q?4eWsDP0ul7pdfysasudWleqoHLTt7+TXA2a3ZjzbsSxXtaJIHeRAS4Xdy30I?=
 =?us-ascii?Q?YSzOVr3+/ITa8pICcQHWGPSgvU8mSnP2UGukaVk+FM8NiG57JeAbRaGwJGZo?=
 =?us-ascii?Q?QWZJ3rrsA0aDhXTO9qNWoNtJOcMNpijammte/+wzJ+r92hiDyeYbn5AwLauv?=
 =?us-ascii?Q?3QzH0Dgeg1DcssMJqKxHtMT/rgRBh7bmleuSkU3Sn30x8P3xwG4OIAvoZ+R7?=
 =?us-ascii?Q?UsFqxHCBOAT6pvP42niW44HplvhlvFHfHcESvIK6KS+K6GfeHQ4UaO8CUajG?=
 =?us-ascii?Q?mA9D+cOkjLZKC3k19OChiGkNvfrZ3RIKtGf2seiEQb7fW52Ag2+VSV+4cprY?=
 =?us-ascii?Q?AbbYmzlOA/bD1F2I+D/7B7zcBThzakLXkfbX48DgZnmROfWA1epOc2BVafv0?=
 =?us-ascii?Q?uf7lJq9E+r7PGH5Wr31tbrl2z9H9k1pVKW1Qyq5T1ZIn03URcBLQ43vNVwSQ?=
 =?us-ascii?Q?7ObWS3T78cxd1ri4mT9B9lF5Z4uA4wN2qmKHKbYYYoHZt2pELVw3qagSDTX3?=
 =?us-ascii?Q?uwpK+3cMs9/JwPMv4seSNlpI6EEuGjRrZ59YQBXyCmmpb5OxwTnCNxgBywrB?=
 =?us-ascii?Q?TUBlwGiTdXd8aPe2jc9H0ERdht2fd+KBHITlFlRY06WUlwbcS1XownQmiAoA?=
 =?us-ascii?Q?/AapzULKHLz0esgWXbp4HwZmRy3NLG5+/1jlyz5g1zMWnUxyf5rxJOLsuoZo?=
 =?us-ascii?Q?hj4i4D6tXegrAPzLAOc7ee4fWW88XPHW8l+Qp7w2+KwniqDl+nhXOG7EBv+Y?=
 =?us-ascii?Q?d7kn0yUpTR6G4bYo/uzMRDhFITXsBpMlC7mIFWyVeyMGtT29dazt5JV04PZV?=
 =?us-ascii?Q?M1+Uoke3ZwugQ+ApWeZD9MU810Za0x6HdX34dr6a00y6JFdfz3T9HbFwHcvd?=
 =?us-ascii?Q?Ozn15VDw4wyx/3vxYWNJOiCYrt78lW1jqavD8MT+XE8n+ngb7u2a5E4CcRVw?=
 =?us-ascii?Q?FAgabkOjbzp19hH/2r5LiWcwWx09MebZjdrlAiLWvsvY1AA8KArMaU6VfqIr?=
 =?us-ascii?Q?GfshJqu8Kq2Eq1L/iQ/+G6eD1x1qLE0TY1LSvNFJ8CAOqH9XUmjbUvNM2Lwn?=
 =?us-ascii?Q?g0tn1xzwsDymcAHMoSVr56Mri1Zt1UMy+FxRcj5HgNjkrILt3jZw/sMrcnH8?=
 =?us-ascii?Q?BnymQdGbTtEHGFj5HPg6WoIf6w0gpEB0hWl8zWGJ00gxYHfbOySrz7MhTj3A?=
 =?us-ascii?Q?2n4rhTIyDIIN/Xh5E7IIpVxRgco99Q4IyJv3rq2ybXqkHGeK1+Ll2NzO8k8s?=
 =?us-ascii?Q?cGFXFYHI/php8c7rR2RwM5383afrymwrfT0UJDRoi8/WzH0JYdt2WuT+0IKf?=
 =?us-ascii?Q?QcVwn3eCEYKxnd1vcd3rAz35SH+m3lJ4aE8zCM+GELNFPeffIihTp3tvdilw?=
 =?us-ascii?Q?MPvGAg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a3515435-ec84-4b6b-c639-08daf93f5aa3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 10:32:52.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkVazKLUXHFZ3j6WrwKrtNBdAlHBk0fpFxxTiYfIhgU7dLLl2FuWi1vR2tMfoxffSb6d5JgLlmKgpqVFbX25Kbu/HhSA2frXmNxodJgVWWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5990
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds a driver for the Sony IMX415 CMOS image sensor.
The Sony IMX415 is a diagonal 6.4 mm (Type 1/2.8) CMOS active pixel type
solid-state image sensor with a square pixel array and 8.46 M effective
pixels. This chip operates with analog 2.9 V, digital 1.1 V, and interface
1.8 V triple power supply, and has low power consumption.
The IMX415 is programmable through I2C interface. The sensor output is
available via CSI-2 serial data output (two or four lanes).

Looking forward to your comments!

Best regards,
Michael

Gerald Loacker (1):
  media: i2c: add imx415 cmos image sensor driver

Michael Riesch (1):
  dt-bindings: media: i2c: add imx415 cmos image sensor

 .../bindings/media/i2c/sony,imx415.yaml       |  120 ++
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   14 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx415.c                    | 1296 +++++++++++++++++
 5 files changed, 1439 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
 create mode 100644 drivers/media/i2c/imx415.c


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.30.2

