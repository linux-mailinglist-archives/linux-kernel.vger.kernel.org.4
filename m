Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AF6632245
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiKUMgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiKUMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:36:01 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DFB5F51;
        Mon, 21 Nov 2022 04:35:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqwqG0EOlo54E+kE3rtfbnTp1Bn9GxFeR+OJOEewQBD2VR+Js2iFJHmL+QssCzfK27MWQ1mF4S7hp07B7m5ShCtOA485Fb3X43JN7+CrtJzmFZ5hNL8p7r4hmTaZplK8ht5BUm8M/T8MzmEj7a3sBWzNhM2ZbYlLnyGcIs9UfXqeSJRwys7mwzwQSZdAE7sodm0AKUVJ+VmIKc4eaN4dUxL8DU3pMBVKhTNS40MDn3MNqDJS789D1g4b8SxSY0qrsQA+PlbKtfU321qyFYYfR5DqawzODle0V/opQUw6cwbQwVi16Cc0TP+WCWQljiah+c8FI0FS5+JxDNTY9pifkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMIbZIeS3TrNf4epXTMOtweabCDD58kWrsnesSHSYoI=;
 b=AJYkUnFi61zKg74UHptK+HA/B+yLIIO+MyXUrFfitF53ccvG7NbYslRAEF0HByDem4+DDaz0nHEcGMpaCmYj6ZhFXvrroKHVQiCMxFmi1hZKNACFpz5lc/M2//cJ38MAdgYsM19vVZ/PQDqCg+Ml28fbKYaa1y8actGc1M3IwXKxty3tDTXUay3AJYBcv6RxDAloNi4Wp1eQcKBvPX+UoteXQJxHZ9L41QQhe0xJOQ9h1tFsA7QvMGC3PoI08F21TIAnygjmbet0rTr9Q9Un8IZJBIT8Uo/LYKyGRYjs/p1M8tl9XikJ0d5KOjdN1TC9fsir0ImeA/SNG3bzO2TEWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMIbZIeS3TrNf4epXTMOtweabCDD58kWrsnesSHSYoI=;
 b=gu8tzyrZaWVCiYJxtuy+89NATlThXWk6FtZHKJrAQzMYlULCMdnYarL85ZfOPobPYcqsDbGEFKIdgNV/f8JDUB0Jtjvb62gvKbSz+V6iP35+4LxhIXWk9VnbagOPe6UiNwM2l42CCAVOPiF+s+j6CPSRL8NJW0yWmijuo9P2N4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS8PR08MB7718.eurprd08.prod.outlook.com (2603:10a6:20b:50a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.13; Mon, 21 Nov
 2022 12:35:57 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5857.016; Mon, 21 Nov 2022
 12:35:57 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v2 0/2] add ti tmag5273 driver
Date:   Mon, 21 Nov 2022 13:35:40 +0100
Message-Id: <20221121123542.1322367-1-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0113.eurprd09.prod.outlook.com
 (2603:10a6:803:78::36) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS8PR08MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: b98629b8-8022-44c9-cee0-08dacbbcf081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: my9BUI8qt6H/rVESQ1ld1/jvUFc8cETuxUxa4qwGPviCvSWtFqi3K7Xdwt1PKF3nXenDBgETxuNol4tB3ngbx6d0jqc8iv7hzqiJYFYLfAWOtI+3HQFzgpHw67OOaj9DKIA8Cgv7HtOGwrCe91FD5khqc60/gDNeKAJxJNfKuW9kiYiwIKu8vpruabEhF05v2pZN7hvKOmh/P/02Rme2mv1zsMVyZpj20Nrb1EJWthTevk3R2VKFo1YO6Q/AIr4b4XjSx1Qxk5FPMU2sfWg0lLPaKSZeVnn/6eibKEX8NgmeoJ1EJXv/9kLDSR2sZERdLw1giU9ICXt1+N9UtE9M2Y000s/7RIgu/CaQtUNBHKts8mBgQuHgkGY0+Eg0pFBv62E8NNDByZFf0/2uCGe0Sg3kFjb6DXmuCaL3gR9xOT7Nr2W16KZAFh/HA7dGd8Ujoj78djpAUoFavqOJK+KFXOYk68lONnONabU4fUx8rrf5frRRVMwi02l06QAXH9OgKhpyIWj4dj6BZQKtiI+FC3lqFH6B+pBEgRAGujzyKCO/J7Kf3XBQ1IE4LNSrgVgNCOxIpcHmF9WKN8aInBQ9kV8jzzo7vRwdQhS7gqGfEGuQOavXlj1Yzy0182op0cABiRKVDIOL3g5WhA4ztwMt+eZqEHUxbxe8bEWeAdDmliLrBZjhpmHb+C+Bi9gdvV7A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39840400004)(396003)(346002)(376002)(451199015)(6486002)(2906002)(478600001)(44832011)(86362001)(8936002)(1076003)(5660300002)(6666004)(36756003)(107886003)(186003)(6506007)(41300700001)(2616005)(38100700002)(54906003)(7416002)(8676002)(66946007)(316002)(66476007)(66556008)(4326008)(38350700002)(26005)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?STw7Nb1Wad66p4tjeLWIItgKv/SiYnADbt26Nbwehm9rDNwCVafKXu8j6oYQ?=
 =?us-ascii?Q?RW3tb/QBlriav7KjqZPs1AH+ICIBako2LucaP2QbGS9L3U/Sr4nOMeNzdReb?=
 =?us-ascii?Q?8wrCh7bIjgzN6YHCGu3SFKlAMkD1Q5jeGVh1H1jheI5T7rDBlRJC5G+Hqz0w?=
 =?us-ascii?Q?NtLzb3DFHEjn84uq1SlzaCaxDZm7uFADuMu4i8MCF1r19QQr7fF+JSW72elJ?=
 =?us-ascii?Q?Q6Pw3xXWu3qEqQ6/YmIavMkchMhi2POpZvJQqQNY9nc8lYDlmRusM+jZqdmD?=
 =?us-ascii?Q?soGfPNlu9sapvyBHjjLyGQuxjOK3BSvooSuxJARElmdo4Rww73eeEYykAPry?=
 =?us-ascii?Q?ebU4KyJqDwwnPL82zwW2px7QRzDc8wuavttdmXV/ngvTX9zU/ox+sPRr0+38?=
 =?us-ascii?Q?jsktl+DR1X9YdJorKsebiKFafx8pFcnnlx136KA4L3avBSlpdEKwWylHO3lO?=
 =?us-ascii?Q?ekxLz6YqHWgpxubw13IVQu4SVZXO8oODmsBj2j//zqolqpiC2iNoKsMUNiWo?=
 =?us-ascii?Q?ZE5+PTSBiDr4tTnsCR2SyaUAoJ9pPbZUgCel1JYQ5qNsStAM+HciOttvTE8t?=
 =?us-ascii?Q?33+t4EMNUaP7Wq9c060Un6iVfiKgp40Sq8Mu9t8RrCvwpLzuCOQP8OW8vDoO?=
 =?us-ascii?Q?BCXg9kZltiaxvuKfpNoXMIvHMzZ/5n1cSJSdkYWcbQJO7+SKWAEAkCwuyzkQ?=
 =?us-ascii?Q?0orxNVdOn1hZWryZjcO6VoyxJ53drigU0WW5Pkj0kJ5P5aCOdlEgvrBAV+Lf?=
 =?us-ascii?Q?UMnX+caI4JoZxoJaXWVNTILMyknixhLfdEdobezcmoRhhaALXlcJThQFe6v/?=
 =?us-ascii?Q?Wx6Jx/y5Js85I0Q2C0nArY/0XeQZPHpf8lGCgNA4HowbBBo60eTlyvmhkrip?=
 =?us-ascii?Q?Iizuf9kkT4mBB12NoOQeq8+LKLtkO0HVEuGq6u7QtmgHJ0sEJo4BOEH2TwiU?=
 =?us-ascii?Q?L//bjW4HJ2J7esZqMxC6W1t//hGFYID5Mt4ecGZ+B0O9TLdJumICorXKwEtu?=
 =?us-ascii?Q?ctQhrbYl+a01mDHKPlBfioW9VtBHjljXpeYyGEyI55O1yGvSs84Fx31tmr8T?=
 =?us-ascii?Q?XYSXP0ZAlLY6zAQTboRtMNkrFCK0WNGArsuEFiqLpB4pR2nksq/xWBYPWHI9?=
 =?us-ascii?Q?PMUL9KdCo8AcBHvFwk4gkuKoWrwGQ2JiI5TWZB6RcMPBVfDWhsFK5+qH6RSv?=
 =?us-ascii?Q?8BQ55+5RJHjsSeI1w0fSQ10D1X6SPw0F1Ll4rc1uMC5Ghqr9VjA6VG0p/htJ?=
 =?us-ascii?Q?ZtI+kbqiGwRaKgTT6nzslGwX7acypzSOgeYpZzTECwNXn1UQzlcZW026aqvu?=
 =?us-ascii?Q?CUsCkCt2c/drB7CtwQEHJoJ+pAfSEr5jtbi4RhuZGtk8cxICHyB3Ml60BVVi?=
 =?us-ascii?Q?kRjlZuNOGiaCwaCaa7GFf3VBkJJHVPypBmCtUnUvanzrklUwG31xs2r9uF8q?=
 =?us-ascii?Q?29PPVcBpRyPlDKrpT/FGbrJApbHP1dGFyMfQHDhBAiDmmbNZdpKF5tp6i5iu?=
 =?us-ascii?Q?HwkHnRMZ1UEfRUe72ZOqA4ZhJpSdGbOnjydZ7CUzy5tovkMCykwmnTpW06Dh?=
 =?us-ascii?Q?2WFpHDsTDi8n4mcHjGm+4QgnqptujbEimkbSEJRisK6t5d8PkfRHOz+ET0Ot?=
 =?us-ascii?Q?Rw=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b98629b8-8022-44c9-cee0-08dacbbcf081
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 12:35:57.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+C3IKwq2Z5rEvvxRakTROY0tic2zSM1oFaW3IUWU12WtZTLj77JASQtz2Ww+cag+/FPwPiMdABTMknnj9JSKKddfUmAhc319AHVtl+maGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7718
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

This patch set adds support for the TI TMAG5273 Low-Power Linear 3D Hall-
Effect Sensor. Additionally to temperature and magnetic X, Y and Z-axes the
angle and magnitude are reported. The sensor is operating in continuous
measurement mode and changes to sleep mode if not used for 5 seconds.

Tests were done on a ROCK3 Model A board using the TMAG5273 evaluation
module.

Changes in v2:
 Thanks to Krzysztof, Andy and Jonathan for your detailed review and
 explanations on the first version. This patch includes all your
 suggestions and some additional cleanup in the probe function.

Gerald Loacker (2):
  dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
  iio: magnetometer: add ti tmag5273 driver

 .../iio/magnetometer/ti,tmag5273.yaml         |  75 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  12 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/tmag5273.c           | 725 ++++++++++++++++++
 5 files changed, 821 insertions(+)
 create mode 100644 .../bindings/iio/magnetometer/ti,tmag5273.yaml
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

-- 
2.37.2

