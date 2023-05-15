Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23B7021C6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjEOChg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbjEOChb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:37:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2040.outbound.protection.outlook.com [40.92.98.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9086B8;
        Sun, 14 May 2023 19:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW51PlF6C30GNUvps70X50UuiinTcMdNTkWNaxkxuTaA4HWS1Km00hMk3iBastiFIQH6Y/0Nwo6JE5Zoq79jOgT2SaIvvEAgIvOocUSArTsRnlF9++t66zmWCephuV1uAF5DH9IcFJvDaVy6CkQurihpyINAdxFkDn7t4ispVtvknyrdfjABJsEwacvALXnqbX0+zyKUSb3Qszs91xiEj1RItmZcdPxhVPUi7nKWzGAjStPQgYA+kAMvpAgYJRde96DcYDe37yz0vhziR/7D8LsffUGmcpkiLmrg9RTMRGIJPcXJKK56VrRkK44HgwlvpHF4Rhd66uup7LjWGB56bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XY59rOFlkGPlORf+kVDsYxk89suEwM7CTq/ZKpjLUTI=;
 b=aKiSxvM+zJeEbSYXYQbr2EGy/7UrCV/r4h0IXjatidLWyThQlXYjDRn6QVuV165BU/e8DsbAktwO3K6yyZEYPFVgNMQf/UYtxFuZ9Z9pxqBmu7EsctznIpKTb4K0h6XjwOhe4GpkrXtpSAtpGTVFaF+H4drwkb+1ZOJq5p7q/FZkNA1tp8IcX0hfNuQtw3Z5ffOqBDnJNCHN2D44uYoFbv2CI4o/DFBpSCfdXxPe+nNi75XexpP0a+O5W9nswsmy2LwHOGlxc/7NJVqnY9T27eG6Yn9sfftjNnZCQB4RpBtw5833WuaPdA9gkK2rCIR63Lyr38Z32KhUwK2Pou3giA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XY59rOFlkGPlORf+kVDsYxk89suEwM7CTq/ZKpjLUTI=;
 b=Ml6pmwX++YRv34qDQSX9zbYMqD0mkWuSj21WUjob7NNVLCFycAPLw2wY9AOxtzEDdELkERhpjxv8pKTL2JYmXsJUGFvVnXaKnkdQ05nrT7NMw+e9ODNyUOARJWKTNRPh7rU8Ni3zIoXpWsfWurzwzHFx14Zy2GPBwQz2W/XD3DI7Si7UYWXDVn/jkAyvcUnItZmUsmnACf9amfLfS+8uUbRcm93D/X2yU4aX1esgXMovFdxZa+vTvv3CZmO6FW53ThnTuykVX9XtVadt347xi+po0YIesYM9CpIc8KpknsnIv/Smg05WX+fECgV50jC9jTXhHTHXy+sDg+1PHOBWyg==
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d9::7) by
 TYTP286MB3504.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 02:37:22 +0000
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::dc0c:66b7:19f4:48ad]) by OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::dc0c:66b7:19f4:48ad%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 02:37:22 +0000
From:   Yahu Gao <yahu.gao@outlook.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yahu Gao <gaoyh12@lenovo.com>
Subject: [PATCH v3] ata: libata-core: Simplies if condition
Date:   Mon, 15 May 2023 10:36:58 +0800
Message-ID: <OS3P286MB0632EC8F4BE2127EF092F59B9E789@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9PpA/4siy5S5idJJdg1OegB6vLhRltQ7]
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d9::7)
X-Microsoft-Original-Message-ID: <20230515023658.37239-1-yahu.gao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0632:EE_|TYTP286MB3504:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f29d1f-1a28-4509-6bbf-08db54ed4f5f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LU0Qt1J2ehYXT9gVczmWySeYf7GiuTBE21MurZiXKIjZtbg3D2ZS3fzEJGb+Tfc24ts/0Q/oMSrjwCWsjKAnIjhAKPzzpRMcSnVovWKw4IF61WY9yFkx1tQYUcKDZeYQ7zHMhSYI5KFsIqWzG7U+SN/Nz0tWy08lggSi2p762rwfHl+mCur1NtLhxc4V+CWnDkXZ0sSqCaE+i2S+Sw1/hT5O6kO8IOkL2wsyp3C+XYBJjVqe3T91nBWX5nfNgYC9O0Bbtc6ae1KfGgCl1+fSdCOv2sLFelLDppMpxxT/lf8kPj1NS1BI3QEjg9y1RJzIOiPlqZlTNaauq17CYfOeSIhhmzVxO1JL54u5oSzBxT8kyo5g+hDNln0npiEqslNu+Q7iF/YKGrdDdoNimfjVdPi+ZefTIzoeWGe4l6Y2LDilGuojeiIlhF889laRuD4zvNWH8+qZ6hYRosMyzKl3ss0G0RXRxSy3X91jFr+gOlXq/G8Lt7O6z/kEzV0BDQeiUKkQCRkuoVMBB0SbvI+7x4pDDATsi+kHWh/Fd+KTangjA6pxMyxPuk/Ykvpi5O5n
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GuMLHOYwMREY5sxTR8gKJATxy1iEXxxfAiCpDItqaP8+mu02Sl1siEGbpnwc?=
 =?us-ascii?Q?ZNtRIpnATuCl0bzXz7RuxAmi9VGreAYRkFG037nxmpj6Q6d4YOlUlE3ho8qN?=
 =?us-ascii?Q?0/WcOI+egoC1L3xdhU05Z77DVb8jgT7wTIhBC7S8xXyELQuUnOpQjakjzecr?=
 =?us-ascii?Q?nyZk68kaKVbFtdxlIfs2jUwsZ+iFEGYbxs23ga9h92Rp3EgDVFEZhwR+fU5R?=
 =?us-ascii?Q?Q0XHC7hn6VVg7zKxYsTszeXzceemAXWeNR5xggD4plYNXHsRQ6csIL4DQkRe?=
 =?us-ascii?Q?8SKOMcEovuhc29XY7e58ZNCA1n+ln1OC6/x1TeuLV2w5d0STATs9nT4ma2ta?=
 =?us-ascii?Q?N1adi8sA50c9G90Yn5uXpcbHGEexF4J7u7MQvzSQGEx1QlL0Gy6MDHOIx8Q/?=
 =?us-ascii?Q?GOBvHjhxPSv9DihTsR/6poIs0E583T+9F0cOZ7Hnvq+5G5cTZM3FsaTRTHl5?=
 =?us-ascii?Q?oCY3wM6+JKSt28DAvEwctgmU9uTNFNZxBkMpnxxl3GSlFFuDRuvunwRFvX0P?=
 =?us-ascii?Q?k4QlWTJ9JjUSW5jiEI2dFD2olCDOhJ8CyZSY4ApqsEAhbrvqH+aEwVvg8QBt?=
 =?us-ascii?Q?7jcww3lHq7uQhLlFZ1GCNN8xWUpDHbpDpe5dXVOi623yAYxduWRLehJP++P6?=
 =?us-ascii?Q?rQExYVbtH3EM5pGXwikP69kwGohLXmqhi5w3aQL9Kc0PaZxqFfJOOKnHP+an?=
 =?us-ascii?Q?InmcOyn48uS8a7yH+0fL8uI0iUSTWX6GCM6q8laE9eDhhey2wOdT5GhGWwVe?=
 =?us-ascii?Q?ZxQr2pyF88KAD3+rq02eMSaklWH1RhB9yCHoyfkJkboKQW1fu9pJ7ylGmHUF?=
 =?us-ascii?Q?tW3U/BI71JdoS647fy/EtTKMJKyTxlqExidXwwjeK21Cnz0LbRpHitLo4yDy?=
 =?us-ascii?Q?5rDlJZ4fofGgbaaj+Z/ZsfS60JlMCik67m7aBuztFNQRntUKR+v/ml2gReW1?=
 =?us-ascii?Q?0RTH9HtPGsEPqk4w3iZ2H+PQyZQs/ULRIWDe9y171wIY+fN+cBKxqmXLHGM9?=
 =?us-ascii?Q?H8V8xvh8SqeIQ6/uSTnWeU9lggnr3LKwk46VoidwQc4APZjZgv0A+Us4Icz3?=
 =?us-ascii?Q?yQTluqOyALeZ1xmUjgtugB4CB4kJSqgSoLt5k9Xa0BucMU8A64n8xjTvD1Co?=
 =?us-ascii?Q?zkSr49eS0VgsBTeAIFVN9rmFpJUppSQFrZTJta47SqnkKYIlH8JYAsoRneID?=
 =?us-ascii?Q?iovQE4lm/KvR602qSlP0fWf/7Tge5Yn9zUTw3Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f29d1f-1a28-4509-6bbf-08db54ed4f5f
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 02:37:22.3527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yahu Gao <gaoyh12@lenovo.com>

Simplify the condition used in ata_dev_revalidate() to not
issue identify commands to port multiplier devices.

Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>
---
 drivers/ata/libata-core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Changes since V1:
 1. Update the subject
 2. Add more descriptive
 3. Remove review-by without email
 4. keep "ata_class_enabled(new_class) &&" condition

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14c17c3bda4e..2c9472b00f17 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3802,11 +3802,7 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 		return -ENODEV;
 
 	/* fail early if !ATA && !ATAPI to avoid issuing [P]IDENTIFY to PMP */
-	if (ata_class_enabled(new_class) &&
-	    new_class != ATA_DEV_ATA &&
-	    new_class != ATA_DEV_ATAPI &&
-	    new_class != ATA_DEV_ZAC &&
-	    new_class != ATA_DEV_SEMB) {
+	if (ata_class_enabled(new_class) && new_class == ATA_DEV_PMP) {
 		ata_dev_info(dev, "class mismatch %u != %u\n",
 			     dev->class, new_class);
 		rc = -ENODEV;
-- 
2.39.1

