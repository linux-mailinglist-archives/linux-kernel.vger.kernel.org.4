Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F136E4337
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDQJGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDQJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:06:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2012.outbound.protection.outlook.com [40.92.98.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EDD170D;
        Mon, 17 Apr 2023 02:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4MAE+jUYx3qKtSOB5yjtHzsXCQmlAKJ+mFFRrPsC2Y1VQjwL/KFtNh5lYkBrbhnBFft7vzpBBKaaAe8+fjDeULh9ZnEuomcwp53BML7en2+uWc0VO4aq4Z3GezPKDMFCgDPnxJhZ30IhUyOQoCP4EmP2bCu38Ki3zJOYCYcREIU66/pB+hARBuHLeA7nM6XVU02Wa92JmlzBXGxsylWeVSOehoacDMgghn6tQyMoLnhRqpHdQ572iJEqf+tQyEyWUxwaNZVRVNpVecOSWOau8cy7mDg8kvI6MXtnBX80Kjr9HvXbLVmxZCMVZvNiVMa93Lc8xUuQ5CNix0VyPoJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhWLhu4JU+QN22lrMV2K382MssL2r8BvosQ7/45E5M0=;
 b=DcFx2mlG1p032oV9v2En3OMBumm8R45RhOSPyn+10mzGWd/m8I8q/MnlgsHeZNGtVHndt743MBRxumkp1mlf6SsQfp6ztYvaBR8ZqCHmMz97BZ0VSENhOHnb4CwGuDZlpe4KoMxqlYTJooP4A09YHsvquyDothMdbdIDIAZ8hJ0Jkmk+Va/Qm+8RwNB464w8CeFuNSOIkSvW9lMRSnOcDEAJmw83+IBjrHEHVB3GuQ8rDp5BpGzm2CTb0RtZl0/OwaIsd8KtRMTRC7vXAbbmk7325nNjq4pvY3PcgJ7b8tratuD5QjI6ppS4E/Aq/iMdOGpAZcyzB+1FTT7PznFNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhWLhu4JU+QN22lrMV2K382MssL2r8BvosQ7/45E5M0=;
 b=dusxlbsypmLaF6zUk+IkivDKjTCK/f/VfxkrkihwxERUWv8J/LUbMq2AwFpvnxYyHsukVafme0EKg7KjYop02cm0yM57ZKgZ7ATgaJ6AwZWpBv5KavzfP/XKplrkzcfe+89OLAu2ueSncm9+p2VPJVq7k4jpHRkhaMqb3ybCL9w+sWBJ4wsrdwMB16mYADJwMbXQUCzWEJFj8nxqtQc2zqO+hqmfED8+lTzQ7T4ZDXSoQKI2MdGQm1fY8sQdjyjoqYjxZBQhI8IyXapPRdo5ni+PJVaEGpCoRdAs6wTirZ9N+8HMx7cBhi7ygkfID+EhPUtoNAYiRNMdSqidlVqQjQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OSZP286MB1558.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 09:06:36 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 09:06:36 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 0/4] Add X-Powers AXP15060 PMIC support
Date:   Mon, 17 Apr 2023 17:05:34 +0800
Message-ID: <TY3P286MB26113C9B81C7F768E082AD52989C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2XZAt9odJYWEEFow2Kp/InqBLZQ55ndE]
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20230417090537.6052-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1558:EE_
X-MS-Office365-Filtering-Correlation-Id: 9350e431-ed42-42a3-65e4-08db3f230bee
X-MS-Exchange-SLBlob-MailProps: qdrM8TqeFBt4L0NyuJRuV4esNsX8sXI/ldJY5nzmH0pgrVDjiBa1MkX4lrpdQqW83K14EhYEE9kazVZEGn4ccUpAUbUeMoabd/Qed0DckqB+mJCUk+h21dQsz6pkyJaCYC1GNRwrFDx8hjSm8JC97YtyzTqB8ryXD1Km2tUNJuWQGMTJscMGxFX6yNMPE5dkS57oxrjdSw9GyP6gukEKF6bpjrVUDEsqNKHtlzVvLYTpw+9xku8VarzfKGnnH6+SuxNiMXMwJS6RdJEyUhFCJU8O5z6+EgZrhy6PzfeVQ0fq/x3afzbfBxpuUFA/zCMY0c8T6sgFNPTYEXjhqVb49s87rozUcVYnDyV3xrboT6EZDXgB7VS4sPQTOPMSiGg8tp7SG6Le3g0mfGzJpgJkpzbZAtBnp5Mbgog9khCdRXIcOf4jgaNJ0t0xWEvWmfFaDHdg27np3DIGUdRNiJmIcDr5lONz7rOiDCkNxIUYtaPOJdDGRPakj9b249kmoKW0YttMDWNgvob+hNC9nY3MFHJ2zDGuSbKYSNHQFt+HHzXdsEpRErxvJZkiTWR+SBfkF3PTJ6xKtu6Yniwllwj0zwBthszVJ6WyOM6rEydY8IDg9X9yPJsSp2LtUfXG2KoI8XbnGNYam4iz6rptD7wWDg+oq+Acq4UfecITi+RJDyi7BfzdSBtCFNtvYAT2e8S9OIy9HyUzlDE2c9c5dukqtKCFPCX6RBO4KQweN0+g146aNqiIlBSIw36cy/miuZTnN8LH4AvmocRS3trXsq5zPitdgC0B61gp
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNoQTojFDlHOKg6B9hwOcuizO9pOb/PRRVWXdsn7RFB0Tn9iJoYnIbO+reV/WcdSQ8wbz6zTF/2rx6BsNAGJ4GUri91xzg5L3hgcrIIVoCNdTaqTcQCQ8pauzzDpdqk6cklkWZN2VgQ7SDi4n5tFfMSPd1yNAOILEfdiCx7ziwfTNm3rRYqS2WObH4kDv1lkp58aFcUiGQ2oIlQNV9RT1aTOwTf7X/SP1XEdStU6s+AsubqBwy2uN38awBkyypkw2ZmApKzMj0Tc/PyVHGhHpEcW9jXVeLiWwX0YUfvF/kjEBQMOs7eiIelReKdl7CnPnsexAsUdpPnY4PXNgx34YTk4DVevyOAOQg2sOt6L6Aunjl0PHsqzkBtY0Hmaot7Bu+JKUN00PxGvzD4KT63fZk/grvjQ7E1QNjRrnLDHzql2SC2lOcMvIKNpT3L2zDcVbEvaqzgMYtl0pIRjmnOLagwjpassf7TaIIC+aZJTnpiv036aMLAGZj2jYl/1ObmUOvXBXaYh2hpUfyM8fY5MIEyzFPgiKD7W+3OkGDT6z9bdm9J3Venyqm8FPWLfX6z/UXtOncuiHH/gopR67JxrsusHhUlis1tjILht5HASfejjuQEjzHhXLqv8Pm0HlV+g
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ird7GhzZXCOHouJYTrQrSM9KfV6e+1gNIZPhmKlkvQzqEipqCp4z8u00CHAt?=
 =?us-ascii?Q?cMQVQrtxUofx0eNx2+bPPsCk7oM1RbJ7q2nOQWgpFGTFZFnIRBmJt/Xvf+Wc?=
 =?us-ascii?Q?hVquCu53cyxsNmyWTLBRcj9jFNIhmqzjkoUhsYfNUkKT3wxOP1XJVoM6HYx0?=
 =?us-ascii?Q?Z6ff6X39fyjWq6gOL2edV7Pd6ZoU8V0OtshjEuEaWGKd0pgk1RorMIDP9IfR?=
 =?us-ascii?Q?H/OaEbQYLZo4JzQh5r6jbv3wqG9+kym/KdTKVaBq9s0b/iioxmKS14qpDlXZ?=
 =?us-ascii?Q?BrUb4BmiGjS5gSf+ZL1y2LqEoxYjN3sQy3sC451fnCN5eOIlDMlxchiSYqXy?=
 =?us-ascii?Q?V1UyiG2bxkhl6wCsBz2p2qQd0HuBIniAIxH8PVzFMv/JyOIgN3tsJm5GYMdu?=
 =?us-ascii?Q?9lGty7aDiNL4kKsBV1ltzWYe2B1fYhPyk0D31ED9jBRuhRey58htjOeSLM0k?=
 =?us-ascii?Q?REXrHqjFeT4PL43MkvKAmsnIjIIXhm6oLrSTTKw56vL9dWY2/wu6le8oOiAD?=
 =?us-ascii?Q?LE6SbMMocQdOG9Ko0PFSE38yXzp8c5m1zJH4dgxG/gjXZLBOXBqASKZhFSUK?=
 =?us-ascii?Q?DEkC8d3rzjfoY0caSwCFy/zojzeJiQ508OzHwi1/tmPk2KjN/V7QCrQUr+jh?=
 =?us-ascii?Q?dH1I5lUb44fsGDTbWbGnizC+zPn+W97uzTtMgcRAaAFdfKBbF74j32FY4EyD?=
 =?us-ascii?Q?XVb2QE3U2mIxezU4250oBj5t/6PT7dCcPV5gNU9BwDsU7cgm1dXvm17dIq8w?=
 =?us-ascii?Q?25Sxe7U5cONNRVfaxygJG36epXrVg/O97WzyY179VfiI8er0sO33i4ad567m?=
 =?us-ascii?Q?mEi0sSecxBFq0TqWjuAkjk7lnQ9MFBXyVpMMcHlHl/n5RJem5c3zvrL412bS?=
 =?us-ascii?Q?8C88PPihGbcBI1wOzUbKT9MQByGPN/wrCC/u5Vdd6rkXn/jAClcgAXPGTkar?=
 =?us-ascii?Q?+PIDagwDIRE3ZQ8QtIDFpnkMpMZrFz/Xu1eS7rJVxMuv/g63rnAmIhfNWvMQ?=
 =?us-ascii?Q?/74AhvFMX4Ygs+/mN3xEJjt9H4olElyc7vbarQOzNG+z1aibpU/Mdx9n+i31?=
 =?us-ascii?Q?BEnwfX+m+N0CA1jgrJ46TpVof7R+DcA6VJEH8rQLdHNjAvZb0PwnX08IAH1E?=
 =?us-ascii?Q?vQibytVgn1clECH0HFvG0k7S0W7Z6WDcpwFr279X2OPxzcNYuMcVcw8yUqFU?=
 =?us-ascii?Q?FeNT+ywj/7P5FUqrhV0j3w9C0YGKp5ybc+reaQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9350e431-ed42-42a3-65e4-08db3f230bee
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 09:06:36.3584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1558
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for the X-Powers AXP15060 PMIC, which is
a general purpose PMIC seen on different boards with different SOC.
This series were tested on Starfive Visionfive 2 board.

On this board, IRQ line from PMIC isn't connected so PEK function is
completely unable to use, so IRQ existence detection is added to patch 2
to avoid initialization failure.

Besides, its GPIO/LDO control logic is quite different from other chips
and is not easy to add support for it basing on existing axp20x GPIO
driver, so I didn't add support for it in this series. Maybe others
could do this.

Changes since v1:
 Patch 1: Move cpusldo before drivevbus (Krzysztof Kozlowski)

Shengyu Qu (4):
  dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant
  mfd: axp20x: Add support for AXP15060 PMIC
  regulator: axp20x: Add AXP15060 support
  regulator: axp20x: Set DCDC frequency only when property exists

 .../bindings/mfd/x-powers,axp152.yaml         |   3 +-
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          |  90 +++++++
 drivers/regulator/axp20x-regulator.c          | 237 +++++++++++++++++-
 include/linux/mfd/axp20x.h                    |  85 +++++++
 5 files changed, 404 insertions(+), 13 deletions(-)

-- 
2.25.1

