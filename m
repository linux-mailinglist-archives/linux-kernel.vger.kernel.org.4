Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A21637D81
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKXQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKXQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:12:37 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2084.outbound.protection.outlook.com [40.92.99.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5446A31DC5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:12:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Asj9lJu6wj8MqB7mcX5RnaZtGAKfCnNSf+IENN8Arrk79z83OOg0km4IkmF6LP0TXZ0FBRzmYeBJB1RroWcVkNpoM4OWtqoK6vXvm3bjXwwfmfzGYEgbJhG6cSYo49VL2nIIUVdE5HQduCUGMCfyk+YmXMbzi4LZs2XlOmWYxAyUs5VJLSsPqqNJIEYVw9hTIfdXstm7/vKpVF567BshQ76Nxw/ktmT+xjR6Cr6cbfHHP7sO0+U8/hWYf1WEKkU0i60/sU4Luz7YKzsOYvr3/vXfmSi6mxPyPEipjufYXTQr48MY7kits8MLYfAAYdKJSJ32zYIGBgul5hwPDTipZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oSy9yQZH5R5/p4/8fEIlcDnnh2H6/yjKN583nHGNJs=;
 b=IJJUaWjKC3DxrnGvCvR40XgUj4AMRk8p0vp3Qqffm3/Y0/RoD4/62PkWSXvWX2hiGqsBu0ycLyhagsJNZNq0PiZsgEpbR/Iz9P2MMvOLTPfmuWLZzW0j9oBuf2L3CVUjgdF2Mvrb1TupYNMbdrTSOjjhgwkWwuq3h5UCSUMZbKNVeCTYc9ZATVWD7zOcThPZqEyKKkUDJVIu5KFR9qsz0tdvPPxoL5LdtREY/lQgIgQqnGsSKWTfBVplDeX0tdq9A7rLVydVSeV1DfxwnFrszGPA6bMT5pK/9WCMG32vB/2ZW6YrPih6eGgj4SLVgnLFTIkGoyNGUbC0t8d54XTwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oSy9yQZH5R5/p4/8fEIlcDnnh2H6/yjKN583nHGNJs=;
 b=VAMSvUatEb/TGKnSZ52p0ptF1gq7vTVb/UCO6bl5fdezfYNEeHAaeEoMcKKTv6kVk9RT0ZwxeaEujjLsvIKxisU6tJC9jm2FatlCazPepocUuGf1BM10TEoP5y35N7kd3kJeG3/+wnja5lpTAYRu17nWVxl2pMRZTzXy3lUygKWexbAmq6S0p5ZHLcy1a5oICW0QAbQcqhNq6NPXA18UuwxL3lSSaMM8osOq5EoT/56lC30bv+1YWE/K/UjSgWDv4ivSRnXBGBgj0pBofsJUJFk4z4McMcLLoHxVcSbKOSsQg/n9am4pNlTlial0cd7uAyqH/mfQT/yKT7mRRnRYkA==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TY3P286MB2500.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:22d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 16:12:30 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 16:12:30 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] virtio: Implementing attribute show with sysfs_emit
Date:   Fri, 25 Nov 2022 00:12:14 +0800
Message-ID: <TYCP286MB23232A999FE7DBDF50BA0FAACA0F9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [f5yVnEJd0MoYagV/6DprvozslHZppvEUe5x30n5CTeY=]
X-ClientProxiedBy: TY2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:f6::21) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221124161214.6852-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TY3P286MB2500:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caaca33-57af-42ec-f96f-08dace36afc9
X-MS-Exchange-SLBlob-MailProps: a+H6FLLcF3pgf3IU6ogmyh93lLTDqxb2nEJRI+uM4TUnxu1qVOs6TNMz0OE4UBF7oStf0KWX4qCzJ7nC//dw/Egi0ePVUQtpnnRslIkB+7tB86WfVQXQUudN9BeohT/Q9IDs80Jm6qhfYEFMkBaFZ5hMIl8IkvUuYAIVGCB6onA69Db5pngi/OU6XQAfk7t9icdjVP27B0sCd45/70Ty1QAdQlg6bfOHAqnfsrJpy2hrQhrsSwowww7fgr+fH/0rykkHk3mhzl+jh6iyzr1g+NVrajtHTxVMOEcN9pwuQfsr0FSi1BMBfwyZ/9obzhQf06cnMR+kGTA4PBO97av/7/K0d69OK1M4AP5kf/m1dFJ3KyMCVMIO7sa+oCfrHxlNMvmnxBwFW8Hm0cMhAVtFAURGimI2eQgDkdOJT/WWyB30Nr/4rntYXhuOSTbot72sQrly35S1243u2gYIE2Dj9Rf6Sh9gsQ51q1fJLXMJm1mQZ9km3bI7SdA1xRYcvB2fLrCDDzYjpnUGbDd5EGiPUzQPQ5cL3hKfZ255i2wCdMzq3mS2i/nwRoshSAwtw432nkOIl7QtNvzhn8RzjEBy7M4/QZ83LUNmeM2C8/AAm3BW3upevBPEe35s3Q+h/TxY242SaWIil0xvENdd/fI6eejrUT8igvgcvUADsKgOQw1k0BE+USLoUM0mAZq1/OiR1dsL6kqkGIki9PU/n5aQKGkVap8wf7kTdQ+h1h2F19uBS1bwehIUf9YGBYmcCtgawyWQyBn0HYhrEDtAJTsBQxmBggeKhi+zIk1pystyZZVN5eXJ20rKM0NVvM198lia
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuiwWyH4Dx2NnIa4Uw9thKLs9y2dEJrwQPrH3/Z7iAyNs4t1EttRrfLnmcLilHT+QyHQ8foOZPA6SDbf+5r+4xp+6GtENfqt5MJj2w1UAMjatlfni62yzm03y/df7UDhmUu6E23jjpVBFi1haGrxP/U405KAsQXhc8ja5/hnNeWIFSoBIEAO4VM46wORFr1/tUtAGrS76uWhC0Pp5j/kHAYuZq62LZRAheq6yfpRARTp0vtm2kj79FIEKOk0WqwO+wDaPLh/Y1TKC3Pr4ZGy7uwVEo+qMvhEbILKlR0jHGkXSmzqySkHkKbnt1vo0YTtH9hO6zKfUqlwfv5mc8k2vjt2bOpjtjVxg+lhZK2U5ynPRg4R6K517MILfjJQxu4HS7SKJ7eJQA+sEyw/lNlUXyz8igRZ8cs4toE4JI71EGrFrrcyMbLv82Azvu2GX/+M3ifY9Y7l/qyVP7E97GZEdlKdj1qoPrWFILGCYBm6qb3HYvgnAi2vcdp6dOzXPXasdxmNZGVHZl3Xol6zewSqjVQBO4zfFtv261aKLuxb+m0z33J/80igE9lnerwk4wF+f4xy/gKXx/nDdB7tcUlUO2h+QWIZosjvSDoR+dCi7r2zW9CchBm/8E4PfoyuO2J8hTQljnw6A6QKk+/O/T+N+g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tAimtW9hkAtkO5XW8nnoPts9gksx+SVEhtKN/2cTE0ctbmKl3mRj2GizS15V?=
 =?us-ascii?Q?xd7hSx/nU3mGyCqxMrj8/o5MlWXB/y349u1kvgSNwVjMN0CulITWw9O0XFUg?=
 =?us-ascii?Q?y76KnGSxj1zTP2QG3LQiUlo+JVbnOE+L3O7FIjWgwpjrMOBjfe77SFxOGZ5P?=
 =?us-ascii?Q?6zlpfKHWk/HASDLLVw1oiMrI6kc65cwXcJtjWPhvfGAb+tsvcbbugUlt2Py7?=
 =?us-ascii?Q?yi8GNrblF7AMkGSRoxjsjxdVCPUd5g4CRcOBqDxxCoLu+AYuUkJFcnFChXSU?=
 =?us-ascii?Q?P9rELuuCTNfeshp0v1SfzPRQJl6FZhmHWm14zjV8ZQ7/KKJrTzc1BOKFLqA5?=
 =?us-ascii?Q?RfsBdMPyR7E+WctH1FYCGAxkMPiAaczsgpLATs5rLqBI32AXcZsjNmOnP30P?=
 =?us-ascii?Q?DcnjBtS3YqA6oFlweURBfoFJjy01x0fn4pFm+cjuGrx/zhbAW7vjkC0q0Vfh?=
 =?us-ascii?Q?Q4XBwxNAZUZM4xXFuu3eiHAhPst5rIq/tUhPt3W+Hf2K+J9AoaBc3Ukab0fB?=
 =?us-ascii?Q?eRmNFo2zOgzieY6U8WaW0I+L3A1K9WuCltjgm5cXyKirMO0Or7lSoidDrBb8?=
 =?us-ascii?Q?y1Ef1RLKq2tFS5JZG0jpNVIRISJ3IdLw3iBYJX7p50FI6fKUn493jUuNRVdA?=
 =?us-ascii?Q?s4yEpuTsfCVXf7qRmF4N66TfIioY3rHbvl+tyhk40J7VjsSnhOaxQ6Cd+Ysg?=
 =?us-ascii?Q?U7OfyJfeNGSEdeCM0kvIt7DplyKq9XYroTKQKXTjq5jO6MIFbZtaunxg4CzY?=
 =?us-ascii?Q?hBZ9336XKm2xb2Z4wifz/kxrPm0dSvTGldZqc3LiLWmMgeZ3zdYt+wJm/xqA?=
 =?us-ascii?Q?PfEjV4Do+zfLJJG3n5/2UiaYf5n8wwsikTCzCh/8JTmSNIn/6C5mQ3MAw4xf?=
 =?us-ascii?Q?oJtahE7W7k0JP9FQr4F6PuOY8ovfARTPh8GIH7rS5b6gSzAYtMsO7ePxzAcq?=
 =?us-ascii?Q?t9/0Z2c2+2iK3HW+sYCWP/oUhmUqoCwO2OzyvMWmvZbeDI1WrNtmgrzlaEZP?=
 =?us-ascii?Q?vInaZsbAMPz7BPUiBbk2Cyae57bRPg+5xSMR5w9/IgglgGXc1N4LEUKOHS5A?=
 =?us-ascii?Q?HkDR1pQTcNU4ZYMRSPCtBrz/iV7fHsLM/dF1A4Ir5QDfvCNIb/VAnxPlzhwS?=
 =?us-ascii?Q?ndSDp9CUd2iUNtnVEqAMN59ZZ52nZPI7nlylxIGl/pu7q6MSoUaXrUSd24wG?=
 =?us-ascii?Q?ehzxLBRT7Q9jhduGPxUsWy0bJpsbMsA6mKZJTE9vFbaZgjxYXUyv+hXzzaKn?=
 =?us-ascii?Q?4J1u5uG2SRoD5HIRkqc1ynuCPjbOwq4sTFtjj6UC3g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caaca33-57af-42ec-f96f-08dace36afc9
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 16:12:30.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace sprintf with sysfs_emit or its variants for their
built-in PAGE_SIZE awareness.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
v1->v2:
- Remove callback sanity check.

v1:
- https://lore.kernel.org/all/TYCP286MB23234D3251765359630AD72ECA0C9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/

 drivers/virtio/virtio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 828ced060742..b9a80aedee1b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -15,7 +15,7 @@ static ssize_t device_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "0x%04x\n", dev->id.device);
+	return sysfs_emit(buf, "0x%04x\n", dev->id.device);
 }
 static DEVICE_ATTR_RO(device);
 
@@ -23,7 +23,7 @@ static ssize_t vendor_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "0x%04x\n", dev->id.vendor);
+	return sysfs_emit(buf, "0x%04x\n", dev->id.vendor);
 }
 static DEVICE_ATTR_RO(vendor);
 
@@ -31,7 +31,7 @@ static ssize_t status_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "0x%08x\n", dev->config->get_status(dev));
+	return sysfs_emit(buf, "0x%08x\n", dev->config->get_status(dev));
 }
 static DEVICE_ATTR_RO(status);
 
@@ -39,7 +39,7 @@ static ssize_t modalias_show(struct device *_d,
 			     struct device_attribute *attr, char *buf)
 {
 	struct virtio_device *dev = dev_to_virtio(_d);
-	return sprintf(buf, "virtio:d%08Xv%08X\n",
+	return sysfs_emit(buf, "virtio:d%08Xv%08X\n",
 		       dev->id.device, dev->id.vendor);
 }
 static DEVICE_ATTR_RO(modalias);
@@ -54,9 +54,9 @@ static ssize_t features_show(struct device *_d,
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
 	for (i = 0; i < sizeof(dev->features)*8; i++)
-		len += sprintf(buf+len, "%c",
+		len += sysfs_emit_at(buf, len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
-	len += sprintf(buf+len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
 static DEVICE_ATTR_RO(features);
-- 
2.25.1

