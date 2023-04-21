Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5B36EAB01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjDUMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjDUMz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:55:26 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2057.outbound.protection.outlook.com [40.92.98.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129723590;
        Fri, 21 Apr 2023 05:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElZK0Ev5rbTb2cVIf+mQGDZYO4g9dA8HXoZLj5a+N5iegW8YwPnaGwvuDm4GBoofbOX1c+x5OUhxAHea8NlgidGsVmvpVfym5q9J83NdBYSd2R0KO0HNGBSjk3cRvV4geHKvfKsmY/ZyUagwmqoTflfL2KhJ2q2GEwXaItW//TO8TYkR8A2q5aenZi1sZIOVxLSJz21xnOqmXME0AaJNrYuZsdlYEQoPNSyAlf6n+sXwAQ57SgTrX1mihI00ycRIvZ6khloX/l0wJds5lJG/XBFaivpWILnwVeXw1kxqx+XGrS79zuxkWtrV4aK0K3eRFZm8TGIHIhnVs1vk8Baebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY2pTY8kUUdFTh2z8x8In2ZsYg1xABHrgzb1S/dzqZY=;
 b=NR+x30MF09MJcRRUfixJ8HaysHl3Fe5MFsW2oj911dBHjkmtA6LBiOspg8EiSH5PGh1tXDkUMJ2LXU605Fzb3qTHrb7IjaBwg2rL6jQjKRjuFjvVTld1IIOgHstiGGfT2XPY7NhFSh0f6hfZtRHNGk/PEXAcqhi0nT+KTiIsPmE9B8U1mhbO/Y94Qba3x9qfl0r3nvg0GZ+6VwaCo4tW8Mq+pmD1eWoCtS5nYxI6CCDD5Ijltui91o0wxxP6j1TZ/khotKPvyhWIVJmALxIX7aSUqMUIHLIBP3jlc681B7xjpycSh8gIyso1Asv1UBnJ6zpDxwT7TLceiVa46yVg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY2pTY8kUUdFTh2z8x8In2ZsYg1xABHrgzb1S/dzqZY=;
 b=ewsilWUFqa/b/bs0oYGUKqDUqhzN4dLWSr5fVr6SySI2dtBNTw40b6GA7FV58V+CCnYg32oxH/0brwqtfcPo7eVHnhdBPdx6Bcl01ZHutNSmbvPxtvWEOoIh6tTDjsTvsvCzBLJhrxTNFUvKS/dmk5AvnaRjaeifDeMpMSmNcp6HxsF2/T6MWVPtQ5lxIjoIawnuto5BLD8IKoF9MzvV+gMtXaZ69leozQ/JkRRt0MqzM3Hf5fN0k80VRoTa/MQHoVma0IQ8dmJqe0119kZrtGmcFrUql7dzHhfK1c7l0bWgMHTwV+pVbU7MVcFA6XBfN5tt4Bd6Ci7JySnmiPvCPA==
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:d9::7) by
 OSZP286MB2459.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Fri, 21 Apr 2023 12:55:22 +0000
Received: from OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317]) by OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4ac1:a1e6:7a7:f317%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 12:55:22 +0000
From:   Yahu Gao <yahu.gao@outlook.com>
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        yahu.gao@outlook.com, Yahu Gao <gaoyh12@lenovo.com>,
        Jiwei Sun <sunjw10@lenovo.com>
Subject: [PATCH] drivers/ata: Improve performance and readability
Date:   Fri, 21 Apr 2023 20:54:40 +0800
Message-ID: <OS3P286MB06322266ED2913AF0F6172219E609@OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZOTzQl5VOUNvbPwkkRwHdbMRzhAbQrqb]
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:d9::7)
X-Microsoft-Original-Message-ID: <20230421125440.3365-1-yahu.gao@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0632:EE_|OSZP286MB2459:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5d464b-45ba-4aa7-3608-08db4267aac5
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO+pwSJDZ6uR9xq1vwH3MjLkzsJ7EDxhfx7TqHfQJTxHQmnSagDGwE+KsQm1mE7x9zCpSpOm8/XkHRhBRfXDUSEPziIrZ1lmtKAgNNKRhiFKRWOLv7SDR+hTuAcGX9z6aoU8A48k6DYx4n5qIhv3CD9/AyA4TBM6338MUKCRY8QzqL3izXoHVTj4vUegIe2kFUHoSjNEFBF4FY2IcbxH5i+HE9uN3YFBq+BoHzzZtHecs8cOdQNA2hy4iYIkzElInG4fsRzLOiC1m/IX5vYmEkf1yxWSZXaz+Cba80GhODp4zH94zMiYj1BE/49Nswdhn6GDQ+zsBlc7iw7L4GvAC977kteNloQydHHtAKWvSJc64m3p8ZLE368VVmmckwI3agv43IUd/LT92kQdEW4OZn6NvZT+KoPcx/m+ov3pnFmucgK7RPXhhXSobcVRwGbMPw5YcP3IgwajUvO+JPWcbbp+dJHcb1iYsp6cTNUa6WDWwNH9eR3XbYBAQYmUIKCGetHcbyJOQMwXexIyfWOYIKWCdoDsUQczQFeH0nMhasSKoLvmsZe6P6ueQkPh56lSqDlWhjCic/HT60kCTIOedZ1hWNNiHXZEYzhNk7NflOw5kH0ai3vFsF2Mj3i9tcPCnxEqeP822dQ4pcoEn9vxzUzpTSflxChKW+4Fw/44/OJpnWjXbk58Ha9LBZuP+NrgOISXCLHKLJwaGw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnAvCd0yEedOB6KcVkiN9GDVHu0G9JXy171Cq68aj7Jnlf+axRKPujBWL5ZDOPocrEmcraofwyAs4n1J4SDc4J/3VBOoOcjZLh/3GZZf3M4bGYRTyuoNyrx7x1NWuWsn0mBPxUbSuBwwMXxBLQ+4ZxsmR9H7obTz4TUVt+ryjHwrcOw5dO4cXoe09tqXC9LqHEj6Bw60xcPiN6QH91rWuZ3SaKIUhnUQQooq6Q0BgqGK6wlVfecGVQoBb6YWnEiuISr3BNq4ji+puQgkyDW+6iGOHyteZzZCZjLmUsEWsvQgBg/t9VMF3wyTxfvkVNIiObUqro8mi0gcj8o5w+lMMeYHFPNf78+tG5H6f046ROVtbfo+AWPmRf0FzFF+ZOUQGK+drq8c01/NgXaVf+p9BhYPhFGB71K4ybJwsNE5p+hzPcZBm/7xXKDXFdBWKYpH8uIYWE+7+4mLb6F4aeS0EhEYIv3jAtW7BWFCbnCunKcErbLaAMjyOhsMt4OS7zU17WSRGuyS4Wy9l1guyjYSizIoZZt0QZ1BsLmkHuRcrOdbrzAKtQl79rsBC6kfrvX9tVAwrOzmx2PLQlp/CprDD955egYHQIAFkFco51x/1hZSsMDq2bK13ap7Ez1NJ0f/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4FBtIwdRHWgNx3AOnysx9cVdPOsU4UtX/D1FmdtnwsxGlF9hY7bHSIMjcu4S?=
 =?us-ascii?Q?YOLMxSRqMWPgpNJedl+sLN8R2vNFpy86pzjLWZNT8PwirqHL1rM60BPRPBXi?=
 =?us-ascii?Q?nt+qQ5BnBaFMtctluVbluzDpP6HYMB6GKeq6+cmc0z1tmnCXNGpmz7mGfios?=
 =?us-ascii?Q?BC9IIjG864izbJZkIC9LwiE7T8DbMrBln4IlgI+2qaftPBLc3nHOq60N3Lem?=
 =?us-ascii?Q?TJTQZ4gzKVy1nc5EZIjNjyQ1nOb5wswyz21B0t1ViYCAfiSmqIAlgvw1xoll?=
 =?us-ascii?Q?CRM5T9QB7cGxhO1AMR+YSnaIgMJGCh2jWjpg9dOi79IkzNzeVvpfYyext7F8?=
 =?us-ascii?Q?JTB8tXrmSY7vQNMWQWd+RxWw59r1cyyvVWlsOt/w21y4qO5Eg4z1f3o67lpa?=
 =?us-ascii?Q?4phmkcfktx/uMClP0HeGDO043jkwE5irVvQHioQ3DMY/4ig9ABfJWmUZV+Ai?=
 =?us-ascii?Q?W4KjiXxRjXm1RDecnZ2HrXHnF7YRLRjCpdD/YDdveML85hD4eyYitv0vtbEC?=
 =?us-ascii?Q?ALqfm8IyzfbCreZzEOU7/BLKbQ6lbci++PUBpXm9EKtTgjKcE7c6SHuYIwc4?=
 =?us-ascii?Q?cGY/wcCk0UzMbsXvmh/q26NBMUCLtEuewnbQ+zwxkfuHTJGBGZ5XMBQW2sd7?=
 =?us-ascii?Q?dsU28C6YM+bnHIZ1UuPh01VO3+9YmwdNWRvogiSGkpMS9ZH1eLy/E95R9J/k?=
 =?us-ascii?Q?QDCKyVPft07O/9pXNf2Teym3VLutBkel8TKdiUMTgc3Uf00RnmW+00Rs3wSv?=
 =?us-ascii?Q?yQnVUKdgQFtci8guLf+V3F533lfkbMF5Q/ked7BqVeQmeS63Vj2seorSFa8/?=
 =?us-ascii?Q?crIcMlIZQnQV7JnYxDQ1usovu/vwWnP7RsZrSOQIKhuV8mcKF2ymLziY5Ax0?=
 =?us-ascii?Q?pU/iuUoGZWJdYEDjEuRcWmXG1gHFiwsqt8dvqI+cfUUsWVkKVqJ8JgfvEDYU?=
 =?us-ascii?Q?fVgswqtxTFSYb4I0rRIDojmnbwcuprjrI1bqxp9/UCmKO6Alg9b9n3iTChNQ?=
 =?us-ascii?Q?7zbVB4MYNi07dMuGjDztP1wk0YcfquPMmvSt45t2a6T/z164uQ/KDQeRrpRH?=
 =?us-ascii?Q?yamPMtv708AvORA6B6A3omi2/3FvxCtiJgTarXsBZXWcmzSAMNEJcKmODrIZ?=
 =?us-ascii?Q?S6WYAF+hfHyju+V11kK7aPu1eZ5114yiADNfH0L8cbVLa/BaFfLUD8tLapf7?=
 =?us-ascii?Q?7tiS8bAQj5CZWpsRHFFE19AGNjJn7HRK1uk3fg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5d464b-45ba-4aa7-3608-08db4267aac5
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0632.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 12:55:22.1650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2459
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

Replace conditions of avoid issuing [P]IDENTIFY to PMP.

Reviewed-by: Jiwei Sun <sunjw10@lenovo.com>
Signed-off-by: Yahu Gao <gaoyh12@lenovo.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14c17c3bda4e..53f65d751189 100644
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
+	if (new_class == ATA_DEV_PMP) {
 		ata_dev_info(dev, "class mismatch %u != %u\n",
 			     dev->class, new_class);
 		rc = -ENODEV;
-- 
2.39.1

