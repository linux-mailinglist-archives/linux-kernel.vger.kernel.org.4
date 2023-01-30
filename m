Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4666807BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjA3Ir2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236011AbjA3IrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:47:25 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE5E1025D;
        Mon, 30 Jan 2023 00:47:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nci/+GI+05AyXy9gQVXVqsbCpl1RxEiUMan5f1Sbu9a3t8X6E5yi7E1H+slhBRo0JjsgS5jzK145VvF1bkIUeLSOYadTSIX8YOFlO4ajv3BinWroa6JY9Gh1MFPtl6ewyhv09L9tqKESvqAHomoGKgmJIGPIX5RR5eVZIRM15Ab4ag2wmyRcTGyHtnGhqyp57VYEuN7kTGbA5TFGK/azGIrYLEO8OW31GO/QyqX1O1LCi6xOUpH+NKIdNVfaoJvmFqbnVG42Pr/GhTX101firL/NbQF9IAEt4p00h8xalD+Pj3n32J2gIgTY9l3/u8/3XlgzygDGiXn8R914wS4GQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WODDg5vaQT8E+XgOhr0lSBCbkJzy6fJtOc6uPEDrBe0=;
 b=crYfQ22o7rV1g3km8ykq2u3U3hN+qNmeNcmdZOhqt5nwfBlyJMSFdlFWqrnTiRHMQLRZwWSBZfgZHk6/baYi22X9JwnyVTqFNM2nuIfK1YR4negwBMFSeBkZzQWjgC0CxY0Qqx6XEMk1kZhqfrwuOa9z50Ht2joAGVajlCHJEz+3S5d5DqN0RB3Iiv+KLylbESPxXWZ+EtMxW4XRZ9mZ3VMuB3NEOYh02CrqiQUZpIpUVA4pzaSllSHHP+xM0cOUZPTcJ1b6Jqat1k2ecABo9vFTp3e409qtjLJZ7GuZ4pkaSW2dg3OQp5puWk4g5gVt47Iyo4RdX5XsVryiGufYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WODDg5vaQT8E+XgOhr0lSBCbkJzy6fJtOc6uPEDrBe0=;
 b=bc9+vc4rYWZR7uHXjPquXKe+35XvOar2BX2JjJgQyGuvZ1yeb3fBoBHndaUehf89WjB3vEKKtaV5GIoLIkMnv73dgKMd4BUA2tC7j7HkxZA5pgTkE/WFXQu1qlFnVxsnTWXgK5XsypzNr/M2AsEjCpHQL4NubYGNMcbeyZJ12q0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB9046.eurprd08.prod.outlook.com (2603:10a6:20b:5fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 08:47:21 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4718:6092:e763:4219%2]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 08:47:21 +0000
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
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH v3 0/2] media: i2c: add imx415 cmos image sensor driver
Date:   Mon, 30 Jan 2023 09:47:08 +0100
Message-Id: <20230130084710.297004-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 16912288-354f-49db-cd42-08db029e9a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u18j9cHgvFVv9p/fUfqSTvrHK8J6IJO6nnhB1p6QqNJlssm5WFw6iOhf108MvLpU/9WaLW1xpxZ7Oum7PZHIqXGBKig8o5WkeaELpIKRkmH9FAnPoYWNaemjlGBO1IP8af2o72Qw3OLIeS6GN3y8lPWbdwVbPgQdW88CqjmjcE8nXAGF/9wZwjkUTTNC1KKQ0QgyG0AB/QTIHG+XP1H39SvaUsMO6zU7xTAtzODTP+O7ZAoJLBBs5zhSa0ZHPSzSH7tjdmX2/1kG0JszXQVuGDIepVsZhYIL6slQLysqfAw7AeH+VRLfGkYp3nIY/Baqj03vD89DNspw9lB0yBrFjDHflic219ZuGjIVtQu2COjz+Tok3SrTd/CZ9oP/QOKkyuPvxl4MMpui4wyzt8DfPEeZpWPeK3rFHZ1q5OmoQSf0AJJA4RjGLCd1U/2Yn21xPez0diVAFpYe9P/nrAYeF+8TXoSE7DuE79bW7iYJNo/DMFNlTS8MQ090KTk8PysdjZeC6wwea73zxWTp4LVG0D5czWEpRoDXKpPUUKmaT499nubHgn0rl9JU/Ir4i9LwWfYamFNLvdqu3nXTwtN0/JUqB/3VqguuE68WA7b58BIsucetxPDAKfff1pKnxQYQNPbRteN43mWoUfFt9EXsFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39840400004)(376002)(346002)(366004)(396003)(451199018)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(8676002)(66476007)(8936002)(41300700001)(5660300002)(38100700002)(86362001)(1076003)(6666004)(6506007)(6512007)(186003)(7416002)(44832011)(2906002)(478600001)(52116002)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NXvqBGTT7xf/VrYniroFJoXmNpGVPCpG9YyUhhHzvap6a4NxDeJPs7UEBh3x?=
 =?us-ascii?Q?9/G4XObYN1pKcP4pzFnxnQkdurEoImQow9S0OV0fW5HKIrC+7AqD8mE78t4x?=
 =?us-ascii?Q?2WrO399OUra3u1Y4IKPOTFTJtEe8F/8QQNg1juqspym88jbKUZeUITJZ7/Pi?=
 =?us-ascii?Q?L1k8Aw0DwOwy0ZmWlHrw00hS/DifbULLQH0S1wPN+KdYWH7M6HvPYJa6B/ts?=
 =?us-ascii?Q?mkuzLmpFRss+H4UlyrkcpRVId0rSwEy1OhjwHVKcu1OAJxCEuuW00kDy6x/U?=
 =?us-ascii?Q?7EjDKDwWbHDlVIOSZSlwpieHD+iBJlWxwaQ8cU6pGvRkNUGZOaxbZB1BMXXy?=
 =?us-ascii?Q?VvGpx/QMrs9WnLEmC3XVp6i2K/k1/rfgC53Oe42J+ilRrMh2TijyximingHi?=
 =?us-ascii?Q?KD1TWTTUreRrllSTig5h8X9HYB+7i40W0vG2O/iuSDlCiEUfpjssiLhQUZ5t?=
 =?us-ascii?Q?nRw1YwyvdZAdnNgiWjPT2N5Dsmxg3fMV3lYC0dlG4vEIwhIT6xVvXRBPbez8?=
 =?us-ascii?Q?Oy1he1U0v6wYzJ1HIJvEMn6AyiePKBFsf7JQhszFL4YY8nvPN0Vkq0D6cURS?=
 =?us-ascii?Q?4mJ1SzHho5tRwCPoM4rw5dpRDc2tpGZLYcAq27NtoRvhR0K7zxNd/Pkmbja9?=
 =?us-ascii?Q?cO7iGRM6G+CepE6oQiPu9IxR4ZEhtUOzQrOfRzMGOGAjlo5UkxESU30pMJLG?=
 =?us-ascii?Q?HRSeolgAgnZvk3TDcSkNlIJTwCOZdwVoiJ7AqtiMiIn9BetLUyGGMxnZNJ4w?=
 =?us-ascii?Q?CwAroHt8ZRytahJlHNkgAmunCItMHYMQzD1eAL/LE8T9a5lY2+f9+lCM7vD7?=
 =?us-ascii?Q?lAkqo8IYoB7jUxoAfmVhwkhUOhixFGL7MDie0XcFurghOg93IIjkpn4iK26y?=
 =?us-ascii?Q?qVV3JVOKLSccgqW0ynEIgUclb4dKmTRQaLRucsShTE7bpI5vFkyKFKBwwZKS?=
 =?us-ascii?Q?RwlrxGwna7u0J1fBsyfy4VKDguF4KomEYJU8bDwZLLQolYI8c5ASCjZ1kYAb?=
 =?us-ascii?Q?Y9m6ixMDJM4b5IEd/krTBSi8wCvMTl0Mt0IfKZK7uDdhU+CdluZiYbFAQ26I?=
 =?us-ascii?Q?Co1DSHKipfYraqu4yaPdYe2GjM7H3jz8wbgwH0UiR+9DJTnSQ26stN+NPpuZ?=
 =?us-ascii?Q?WjBM5J0rR0baED2fAnV9fb6ZAq/INIE/0y0zecm/lNMK8mfgYAQsr9A8QIvT?=
 =?us-ascii?Q?AxU7WHgLjRBj0bgXfKk11YrG6N4ive2n5/KRUy2xQffI8K881FaKQNgOLAXM?=
 =?us-ascii?Q?3hkv2YYc8oZrpEpAcvbpnOZe/DbQ3uq1cT9gG7J+3cAHG2tYLYRuTPjfEyyu?=
 =?us-ascii?Q?Jx1Fyfg2drf39DXNSYCXlCoN9TKLuFvxWeo/vdeCQQ5uyqJbdcQtGa7WAze/?=
 =?us-ascii?Q?5xtl0osJPh2F2MBWuwKeJhQfuc8PAfU93dUWwvOva/g1FSCEAOpVvlMED3Cu?=
 =?us-ascii?Q?bVCehXEZz0VT7ZYKzgcI2Y+NVSsKmhWvob2dQj0NNM5AmpTkrdldLvdxXTjj?=
 =?us-ascii?Q?LgyOkbD18nezRDossR70eggpAhWOicnn3lmJjzDx073xTH3C2MO9QCtNyyYF?=
 =?us-ascii?Q?qe9VSO0s9qOntx/OfeSKiu9g1vxFk05wisvreXqapixxB+rrxruGfdzgz+hN?=
 =?us-ascii?Q?tZ50PKqd+kK6SEL6i/SyyHfx5ukwBNsJAzRRrIt2SWBN6xvIf/SnHrtXAEGt?=
 =?us-ascii?Q?DOFqMU17XKJJM68af7uCmBw829U=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 16912288-354f-49db-cd42-08db029e9a0f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 08:47:21.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0j7YoIFPAkkrbtqitwURnLA1IHEmhkCOQlnaSU4oCEaX9vcpMKZC+t+KLb9RvlpssbgGuh3g+ZYjMrla0w+CZfxW+3iU7FM/IQuXjzGfw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9046
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

Version 2 of this series fixes the port description in the devicetree
binding as pointed out by Rob Herring.

Version 3 addresses the comments by Sakari Ailus, Marco Felsch and Rob
Herring.

Looking forward to your comments!

Best regards,
Michael

Gerald Loacker (1):
  media: i2c: add imx415 cmos image sensor driver

Michael Riesch (1):
  dt-bindings: media: i2c: add imx415 cmos image sensor

 .../bindings/media/i2c/sony,imx415.yaml       |  122 ++
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   14 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx415.c                    | 1300 +++++++++++++++++
 5 files changed, 1445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
 create mode 100644 drivers/media/i2c/imx415.c


base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.30.2

