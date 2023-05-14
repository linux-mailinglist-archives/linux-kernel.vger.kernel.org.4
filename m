Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF09701D74
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjENMkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENMko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:40:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2033.outbound.protection.outlook.com [40.92.22.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC476171A;
        Sun, 14 May 2023 05:40:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjEjil2m411O4tGYDBn8EnB2Pnb8j8Xw8LqmUuTcK8wTV0Bwb9CEl9/rBXnMS6+9NTJXtSKcC8x82Zcn5XLX6GF416PeTrbM0l2QaSNRN/pUwS7/xRjxEcnb9fO0588srTpIxOWYJZutOzLwVbf8HTfn/wKOcmiTf1AjWTj2vQQENbc9BRtvYKRaNQPIpB6NmHmHpHZct94Gk7TzFTkVQL4J4ohSh4eE1vVBLwEi8Kw3PtUew0TTRy2zHp3bDB1VbJO6O+WWjN6OyH1BJ8xICX3ZD5nfNowlXNDAc+AojeSfIYVUqjn4WuOx0mgmmq/VEhMH3rBooddru4e0wUQgag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=698T1Cy6WgLbwyGZhVhCliVVUv72/7UjChjO3mdgn18=;
 b=Z3nconx1WAk1QVK3Q6m7lKAXqImHkxo6S2lN/Adv/hMT4WiC8WafetZsftGHSmnZLbd8HCltybDJQKzqSLYBGp38Ku4IzkR2/3vMYAUC8RexTJzH7R/Lo0MV1tyE7MKMzsihjJFml6oYlev5sIIUUu0SVA66B+WywX0sTAQ5gFqeSfYC6+2kATYyLePh29r730rTlsozDnYibFicRQxSNYPvwZjmBVHsLKxgPqzm08xRqPCuLMubQwkxwc6ZJC7mUc2f5Bs0YKdDlkCXLrOr/zzbUhFNRAmgKtzOAlwDOLAcG0Wv8g88Wve8CDZRN8f8Y9YC2PTbsJK2rEtmnMZ8lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=698T1Cy6WgLbwyGZhVhCliVVUv72/7UjChjO3mdgn18=;
 b=Ly1ZCrLptJLQcDM+QjGhDmOuuZPI+BITuRD73jTOnJg1dHhjPn0PvreqWdQH7oi4TtpkM4Knr0yNKQQiSRexwK3le62kDDwlyWvm+vki2oiRCKRh3vaOtkRjeYaFFSJ3FzNU4nI6sQcKp/CZqfIAFUGmDPFqLxKF/OK9QIA4k3aV+7NPRjxR//rL2vOgMldQ4cyQizi4kuJxpEpl4UM9/2zaSy+uL0vedG99TZrUdAfxoE2W3oI5xEXISP4ytmN0RkdKxM8v/mMzvHWqsFT4uJRCuSSfbG74vmkHQDjP5CwOKIc64AZKd2t1nLAD7UNWbVO4q9rpZUnNDd2CP+LxUw==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sun, 14 May
 2023 12:40:40 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6%5]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 12:40:40 +0000
From:   mirimmad@outlook.com
Cc:     skhan@linuxfoundation.org, Immad Mir <mirimmad17@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drdb: fix debugfs_create_dir and debugfs_create_symlink error handling
Date:   Sun, 14 May 2023 18:09:53 +0530
Message-ID: <CY5PR12MB64555F99E4FEF60569050F1FC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tJd0WXLAoyVk04nGJM361qXFzOHtPRcJmIJ51imX9NF+j97awYgX5lYQ/x7vTc8B]
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <20230514123953.165278-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: f047ca86-1f1f-48c7-752a-08db54786c9a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5TO0RQX3rSGiRFZ3g1Tadnx/c4PBEVkoXmC8U/spbnQRP3hnYw4lB08cflE/Wfq2+MI/Har7Jnbu9GvDnfVP+5pj8h4T8kkFsxhjeUSiIUZO8oPltPqy97mNxRXaiOQ6AZpqe5W0OrwxwyuUFO5Re9oeVfXdBKj/Zb4BueJpcwZmRMqJTgigyjSQ+QG0BVysTQre25Jed3oYB+a0B+LZV3+iEuc3Fd2/9RpCD4jnOCpbPxisfabzVOIhmQk/dPSed+LrLaRKFIBrY32/XcTo2Vo9ryIX1WmWqRG+AcvT/wHD8AFRNUmFGC45AIz28dRhQcnmwIlQMnYEXVy7LG/aKaMeJztoWamUim4L1v97+oczE3m9XAMZt+g/wwYAFHd5dk4AalHdsqOajq+OIvnHZee8ZvULoRFQK1zJkPF+0qPBwpkh6DHNPeDHkj23iuffRsax2otT4SppfOD3KO3nas/OcR51S0R2o6raX7C2VOtEZ9eo1tQUmmZ4McnpmCV9ls0TMt4zu16GWDWa7voO3D+O8QUqE1dgPzxFY66Uz7ZA9NG6QFT7+KZEJCVBgy4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37go9AgTI7o9pljF+SIigUAmbZtyECxDvY6RRO5eV76g2NiVXcgsheQHYEUQ?=
 =?us-ascii?Q?btuhEk/2DN5BfT3uKJHscQmS1gjcI7fLiAmBH1mgqkXR2Kjy7fLNrd8d2SMv?=
 =?us-ascii?Q?ixzZX2N0QOzGoErXUiv1ur2uda982IjfzdfD97siCTFnyanpjTyXdsvCzdYq?=
 =?us-ascii?Q?Tmo3yrIx9re+HGvxiE9MxHa3/C/PCXqkCCEGRVc1yvOZYJG2nxGOcM70zqPR?=
 =?us-ascii?Q?FB3I2WfYwSI5bpYryxGYqNC6tT8QQaBaRTcfK8ijAwGybAsE7i3fop3TSj5w?=
 =?us-ascii?Q?X+3XK+abz/CQbelthGEthr07RE8ey14sO/lFQI6E8Ccfp2G9e70b9/LzYFmn?=
 =?us-ascii?Q?h+f7OmmBjEeddqc7ldxsR9L8LwmqtE4U+Zg/iHhjBGIep+lrxMHoItcXIpUc?=
 =?us-ascii?Q?gOR9ySdc/EEVRg0+HJzm9ikmsaQweabu0maPLVh8AILfu3QLLUuIh0UYMVzb?=
 =?us-ascii?Q?O3lN7qPjrObN5gqlmO6hsn8Cbus8L35bRsZ+B/XAldLoMdo8iwP4FMsGw+qA?=
 =?us-ascii?Q?Bi+YoZnj6ZfZ0UWqg/IL5Xl9R1MhjwUYPnVNwVOUhXpl6Z/CAq0xCND4r+Y0?=
 =?us-ascii?Q?rbwvwCvb8hcpwhRL/LM9cmWm0K3q6+uoMp4878AjA7r6Slzs/8w3Z4FHsjq7?=
 =?us-ascii?Q?saZMXyJYFc7T5WNUK6nhvwySNhs4o9ubhAxRcdsIFV2MGVy3OFZ/CjUZ/mW+?=
 =?us-ascii?Q?GiQboVEq3P4nh/kzWnQUM6oZmb4c6x7Sk9sMQMStmxdlTneBMKPVVWw5pcJM?=
 =?us-ascii?Q?ETbYK1K1xAwZnZxFs/8V4amh/VwqY6cA7xCxLdPvJ8OeA4LcKRXyItFGDdmk?=
 =?us-ascii?Q?a+qXRz90ez12q/m8dknRmqbpTNNyKJyHEppC2tjMcnuYaVoiF3gOfAR4LoLc?=
 =?us-ascii?Q?R7fXeKNqgfkN7BhnIyi2ynH2rkNzbQJ0FUyNdHE+q/PtkDkHAbXyvFFttS+I?=
 =?us-ascii?Q?rIQ5yMrkBzBDbjOJQkLooBIAl69n8BV+kmXBtq+Gh9p7XDjf2Wrid/n+LW/+?=
 =?us-ascii?Q?AetwkYKtu5qvgPpPxo3yi/PU1pwpyXXirGCWofroKa3R3VfZQeIQti6DqXtF?=
 =?us-ascii?Q?E9gGMvaCv56zsbr74cSPNvoIgrscdnyCgVZb2ZQsjOUetWxve+aIVYuAQ7S6?=
 =?us-ascii?Q?2kgvRxfQuMqjWF9g4wR4p964JE38pqwT9Y54UJxhFF+Ecn974VrGCwYZ6wVI?=
 =?us-ascii?Q?x2GQ7eMps8T4rfcmvm64maSJyMF16KJEHcIj+CSQeOVEmk8E9wGud8MbWtD+?=
 =?us-ascii?Q?cNKAlC8HL0z2SV0Vb0Iq6QzHDlNl6NedCvAd3Yr+qg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f047ca86-1f1f-48c7-752a-08db54786c9a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 12:40:40.4300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

debugfs_create_dir and debugfs_create_symlink return ERR_PTR incase of
a failure which must be checked with the inline function IS_ERR. This
patch attempts to do the same.

Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
 drivers/block/drbd/drbd_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index 12460b584..1cec65563 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -781,6 +781,7 @@ void drbd_debugfs_device_add(struct drbd_device *device)

 	snprintf(vnr_buf, sizeof(vnr_buf), "%u", device->vnr);
 	dentry = debugfs_create_dir(vnr_buf, vols_dir);
+    if (IS_ERR(dentry)) goto fail;
 	device->debugfs_vol = dentry;

 	snprintf(minor_buf, sizeof(minor_buf), "%u", device->minor);
@@ -789,9 +790,12 @@ void drbd_debugfs_device_add(struct drbd_device *device)
 	if (!slink_name)
 		goto fail;
 	dentry = debugfs_create_symlink(minor_buf, drbd_debugfs_minors, slink_name);
+    if (!IS_ERR(dentry)) {
 	device->debugfs_minor = dentry;
 	kfree(slink_name);
 	slink_name = NULL;
+    } else
+        goto fail;

 #define DCF(name)	do {					\
 	dentry = debugfs_create_file(#name, 0440,	\
--
2.40.0

