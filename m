Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF53963B9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiK2GqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2Gp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:45:58 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2087.outbound.protection.outlook.com [40.107.14.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B8218BE;
        Mon, 28 Nov 2022 22:45:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgzLF+KWUrjddakuq9vpBSkZWgE47/6KWHR9BTr4Db72S3sD0tb0nYpMpuT3mChB5xBj1dO8IfXf1vjScw0nFrR1o5DWDNUtgRVfBFmF+dDjM0Nq+hzEBzwm8yjU/uN3MnnhFsk/KZoYVL8Ow8D+sIe5M73UvEU/DEhn6aVhy/f2CbymnujkZx3noPpdtNL5dgI/y4yd+Cm3qqC8Dj2EU39o9iP/R2RdDsxXHfcDIlNp9OdZ3IGt6bhNLZfcjGyHtU0HAP3BNR/Ang46KxoMTENFHOZmfOifCPc2R9W6DbqGbowdb+NCPFl9a0KB8Br28G0lr3ZGbjn8A6OXz2tctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKl4ZuyXBw3mTgtJkTsmXLjM9VwY6D/nhxdhp55qpk8=;
 b=WvJfLXrME8g0PlXkMURQoV2thSRxJA/Dd31+s+r+QCl5CFo7u0Cp8aT15kSjzI3FNayN4uHLbMXitcj7uL+9568iUxhy5HYT67lFHXCLPjXn0ZNMS/dsetHjgYuD6/F7BaqZxIAacO7mxEhAMptnHnlQDv5j0yfzQrfAP5AoSPTA9Rj0BVJMo42pgtetU5X4mTnNu5XNl09mnRnpL5jsGR3zIlHN2h6cw8rkVvsfrPUr4XmbI8KxLXMH+3fFVBz1Pc90F+4SLKV/MyxBjcFJNIS+U7ZTK0q/FaGIvXJrL5R3g0kSvnHfRf82SIWQ4Z13V/ZQZQW+2qM/H3vvhD3MrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKl4ZuyXBw3mTgtJkTsmXLjM9VwY6D/nhxdhp55qpk8=;
 b=Rp7bhIygwvb6mOHaGgkmwWoww+jmJBLbGjK1qpVott5+xnUlxM/zh4hZc8O3uoS19imOImW1rsmsRMhO/hXN2513bm4aY+s9nXpu6pNpg28YIw9uIEwsQj7gWpQqlpzP/UiMWLk9KN2xvgAr5LIFuQ71kCllX+i/YAHO5XB+4rQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com (2603:10a6:803:100::13)
 by AS4PR08MB7685.eurprd08.prod.outlook.com (2603:10a6:20b:504::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Tue, 29 Nov
 2022 06:45:55 +0000
Received: from VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454]) by VI1PR08MB4544.eurprd08.prod.outlook.com
 ([fe80::bcc7:bc51:bf44:1454%6]) with mapi id 15.20.5880.008; Tue, 29 Nov 2022
 06:45:54 +0000
From:   Gerald Loacker <gerald.loacker@wolfvision.net>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Gerald Loacker <gerald.loacker@wolfvision.net>
Subject: [PATCH v4 0/3] add ti tmag5273 driver
Date:   Tue, 29 Nov 2022 07:45:37 +0100
Message-Id: <20221129064540.3218982-1-gerald.loacker@wolfvision.net>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0107.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::36) To VI1PR08MB4544.eurprd08.prod.outlook.com
 (2603:10a6:803:100::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB4544:EE_|AS4PR08MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 55aaf4ba-aeb5-4fd3-64ff-08dad1d55d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGElvPEZM+NIkEzTxJBb8EoOBaHQwn3lkOeBV86EzmpiS3hDbeE2Quu785bfllbZ9+BbSuFfl215+KV6mfiwD9/vm6XYSx9qR9gDIvC7h4PeU7PeHEclGFYuF8HhGaFxlbeRLja9uDpP0U3RTWfxMYbDGYArcKe9j6MYKO8E5HJdzu2M+O1n7hwfE2bQIDCJpyvVV8aDWRQNgb2fhcwX13z7+gJtQGEIc7AudHrqsDy6rG3w25ZFPSWRQgBMfdLoycVwqubeRLfNVu1UE7/6BL8XZdn9yMX533j2lXvq0/4lCoeEfzhbUrNXK/B7Bh1Y9Ei2hK9x2X+SaCcuidnQORvIVa8GCdAInlpry5n4IkGIpXfI2ebp4QzAnpJ6VWop11V0LWrMdLlgXT5hlohQpOViy6Yz+wVW9HDmhq7IPrx2pLh5o4iR/DHFMhxa3FtGHHr7LXRUEyBOXWT0H4BD9C9UrF6gBnTobOjgxkRKydkblE8EBX0vplbyFHBv4lkso4snCWH7VJ1x2VHoHctdItNghPHp/KVpuG1JE+oWOf7KbBYFF4IcKO4eNBP7egerZeezi0gxxh6peihmipaBd6Hin/S1VsRkiUect2XsFO2oufxS177OIspQIwaNQXx5rJLw7KYFDuMKKMnSaUfHQik9ehjbmYBVpFHPEN7PwstYd43nAJUcGsl/oE9ZCK2H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB4544.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39850400004)(396003)(451199015)(6506007)(6486002)(86362001)(52116002)(478600001)(107886003)(6666004)(36756003)(26005)(316002)(2616005)(41300700001)(8936002)(6512007)(1076003)(54906003)(5660300002)(7416002)(44832011)(38350700002)(38100700002)(2906002)(66946007)(66556008)(4326008)(66476007)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrVKtCu5qBw+ot3TgfVDHZqF3jR1vX2nq4f20w9ucQBGZbiPB5/uRG1DQc7l?=
 =?us-ascii?Q?ld8iIi1cgt2JTlJ2BfKKnkZDLkC4/CofX3Rx3iepPMiAeiOWfxVUgokbkTkI?=
 =?us-ascii?Q?NG/SBIF469V/l0q9jRcrDuootb+1DH7rc6p9XOl8NppJ39x1H37IU10+w5CI?=
 =?us-ascii?Q?cMXgqYOWs0yiRRsZ1i/FkqnDYFPd8XlWu3HHXPNKDfTy3XOoj1IujWH7r6EH?=
 =?us-ascii?Q?u2g31gjJfPe+Kbnffe/6001ZwRHfkfSI3HBXH2csuRw7cBujCjuQy7kSLUEP?=
 =?us-ascii?Q?1P+SSdHV3XeQah1n4vfHBcbUJHUr6xnKcOiaNSiugWxHOaQCM1e8nPXMOne/?=
 =?us-ascii?Q?+Pfb435Lui77ln0CJzkoTnv3ls4SQFPr8rgvL4rsQEiywGjULOvAdzU7B1Wn?=
 =?us-ascii?Q?JOVOuTQOSkAbuntvGEwaTmwo2Xz40EuL+oa1drgao+Y2gD3VK7rGjKxvtA6F?=
 =?us-ascii?Q?HgXTMeovDIaplJVOPRzhyE3iI1Mi33o2RRhCD3ArtPO5blsmN8hXCN1nVRCA?=
 =?us-ascii?Q?dg3zStV1jiIFqjXCWZEtXzQEvwPzIiuto3ZFPAzbAPcrRyLNVG0yDc4bC7+m?=
 =?us-ascii?Q?+lICO6PWreHHU5XPjb6cqD9xCtvAR6e7ir3k9uExWdrTpcXxmUJZyJEfHJam?=
 =?us-ascii?Q?j4EELPva8sXlLO6FNH8YN2b3mI0lVxDX6jDlp8k/JIOdbPdgmdhkK7Y9Gi6C?=
 =?us-ascii?Q?c9lSa6OBuffCoYUdqzGP44m9vNUen4u//UoxkzdE8MdwCAEgzhT4dupOC/5g?=
 =?us-ascii?Q?NQptwyEu2C8zoDNGPmtdYEQCe7F6WnGP5RSbD1XAXDuciifY4cW2d063eUzn?=
 =?us-ascii?Q?nkclcX9oM5+zBlxbTrcXR5cGyEz+gJ8VvdkakyBrdtBNpMbOepgYnmWQCDxl?=
 =?us-ascii?Q?36spYJL2NHobakTjasDGdCtUEhICfETJGXsKUI2Xo4HZohRLvoZCDlPgP5bA?=
 =?us-ascii?Q?c3ZFbCiuQ9JkO4JtIlw8T4Hjonz2mEnHNy8819QLVYEEFfJWo0nJhCv5gwcz?=
 =?us-ascii?Q?xiNNz+m1b4Tnn7JM2PPXGz9xSLEhSqbKMajVnBx6E1b568b4raGhPmb73XYE?=
 =?us-ascii?Q?WoRU7NK04dZk0Da9hJo/8FARBp0fEThhllxi4hB0oeTukO5FZ5+32AQNyfJL?=
 =?us-ascii?Q?BO0EfE7k/KQanYoj0S4IN17pg0IGZhF8P5hr7rxmrWkxvtwTgI7iFXQUHSOk?=
 =?us-ascii?Q?1GuoPA8K1WRxAReBYjShgoCBNk1FQf4X90WioRIHW3+Ue3aXnDOB6C9+rjwh?=
 =?us-ascii?Q?XdJEnEgoFV+KemvkZvB55Q8CzhTSTyTENkiuNXt2J23un1ClBBv8dT1l1cZE?=
 =?us-ascii?Q?o4H1bpvMU6DGbeFQnznRdEsELV3VJwr3md+KAbukY3cLvEOHuA38g01ISjaQ?=
 =?us-ascii?Q?7CCLF9NC3wL2aQ0829vtir5uuxtrr87KkeUTDkRLSym1GoejcWVMSVqSjVhw?=
 =?us-ascii?Q?Utb2ypv63T3PCjCSNIhsdGeoSPgHWhuyPmE7ZS8y/RSKmByQ/e7rAZqI+4nq?=
 =?us-ascii?Q?6PcpwSGbkkAcldf+PCdsjoCy0ogz32K4S1q4M2y8r337JZVMyKCcxXJTYZaK?=
 =?us-ascii?Q?nAANWM47mTxcWaDJdw8MGAvItIFYEPa1NRJUTLIdw8GtjBkbY2kvclMmVCJz?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 55aaf4ba-aeb5-4fd3-64ff-08dad1d55d01
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB4544.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 06:45:54.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xU0cyKxik1+vHk2kVqkxkYqH7edX0mG4+HfFMcMORrmcIOO0f1T+/mZ6B1ipf13MCsKymC4cm+YVdnY1CRQq099UoJicpAehpwbK4Ie+xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7685
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

Changes in v4:
 - Add only struct for IIO_VAL_INT_PLUS_MICRO iio type to iio.h.
 - Simplified tmag5273_write_scale()
 - Removed unnecessary '!= 0'
 - Fixed regmap max_register
 - Simplified tmag5273_read_device_property()
 - Fixed some line breaks.

Changes in v3:
 - Added structs for iio types to iio.h. Using these structs for iio type
   arrays such as IIO_AVAIL_LIST makes the code more readable than just
   using (int *). It was suggested by Andy Shevchenko to move these structs
   to the iio headers to avoid different approaches.
 - dt-bindings: dropped quotes from strings
 - Added include <linux/bitfield.h>
   | Reported-by: kernel test robot <lkp@intel.com> 
 - Added include <linux/bits.h>
 - Removed <asm/unaligned.h>
 - Added missing "static const" for tmag5273_avg_table
 - Documented Device ID
 - Fixed index of tmag5273_scale definition
 - Clarify TMAG5273_MAG_CH_EN_X_Y_Z as an index
 - Removed unnecessary print
 - Introduced tmag5273_write_scale() and tmag5273_write_osr() helper
   functions
 - Use of match_string()
 - Format

Changes in v2:
 Thanks to Krzysztof, Andy and Jonathan for your detailed review and
 explanations on the first version. This patch includes all your
 suggestions and some additional cleanup in the probe function.


Gerald Loacker (3):
  iio: add struct declaration for iio types
  dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
  iio: magnetometer: add ti tmag5273 driver

 .../iio/magnetometer/ti,tmag5273.yaml         |  75 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  12 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/tmag5273.c           | 731 ++++++++++++++++++
 include/linux/iio/iio.h                       |   5 +
 6 files changed, 832 insertions(+)
 create mode 100644 .../bindings/iio/magnetometer/ti,tmag5273.yaml
 create mode 100644 drivers/iio/magnetometer/tmag5273.c

-- 
2.37.2

