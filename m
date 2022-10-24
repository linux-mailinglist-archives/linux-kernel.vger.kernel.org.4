Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332C36097FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJXB4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXB4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:56:11 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2046.outbound.protection.outlook.com [40.107.215.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64676611B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 18:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1QFCM4crO3tKvWryeZlSaiBK1MvOnUTRcwjlAUoqjw0/SNlLD/8bNO4kM9F6xUbRgLJAvUiPuYAHZBKNzmMH0ggsE277mfndh3WpTGHmIrOsCxTyKOPRDUFZySO9mXOcKZEy/AvronVpHwI6YDY2zm9d144yGcf7iDOE1QqvNkdxO80HLlVQyTtxIBEzBIKQHOCO7sC1OQb8Gr1yRCf1M5/i1zJ1q52Zmbf8NMFVWWlFY4GAeyx71la0d3IuuFnE9H9Dw3DouTI3V5s8G/oa7xxi5DHg03aoxmhY0p8AX/Z1dt6+b3+WN74ODU77/3yCu9a1PYbBbmcFfv12lMxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK5Bar6cGn2sBYQsPrzMsdzvQck1NprUG52K+J+1m7U=;
 b=PJJU/6Dl37bqNWhys2c4H8kzlwDYqSRjPTF4G5Jr80eZsUqKXQm/Rbnpk5gzrwL2pG2diBhD52S+9kurmc8doQ9YNh5/tv7PF+Fp1NAPWlh24MslKJK4/1shU/ILT9hXxmkjSBh05Bs6Ouvj2AAQKZMwkk4Eslnr6OeKKEHs9ktc2N52jW95UZoF6gRZ5pxEmMcmDttorhNVbogtymKpJPUvgFT9cT+j90V4A80WYKnArvsRNV2jZD4Nndg8rdStoymrdA4aeSmb31XkXr59v+/vickdehkNH51kYRuY8xcm30No1XQO9EOI+vrTTLeRT8LM9f2H3uhG/tTVi0bb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK5Bar6cGn2sBYQsPrzMsdzvQck1NprUG52K+J+1m7U=;
 b=d6CvQCKpPhAShRb1v+s5c04Sm5uv0o3/8ofAjB10wgBuaETjAqS+e1Fh5OW2PCPdXXztoyeRi2yzrN7RHaHlruCtUfJd5/z8wbDp3XHO7FZFS8XLZFFUrMUlVBZDO4Eu6CwPx14p3d4pD4Ga7IUhBaTDFAKHbwOkBcDu/1j8RUvinLXKQv2AM1FwhjliqfGpDKFCETbUiUBryWisdavqXE2LKsW2E4vaHzAp9FOsjfT02qZxk3Ft8wxzQXycxpJ4qhihs2Y9+lO5lfgn+xUUtA26x4lX642OW9BRmYD9Wyy0218dg40edYWLlP/ItnyNM8iO/RJ+A0kuz7qyEIVUTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR06MB5995.apcprd06.prod.outlook.com (2603:1096:820:d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Mon, 24 Oct
 2022 01:56:05 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::5d1a:4f09:b125:9670%7]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 01:56:05 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     jasowang@redhat.com, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, lingshan.zhu@intel.com,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
Date:   Mon, 24 Oct 2022 09:55:10 +0800
Message-Id: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|KL1PR06MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d881dc-5bed-4381-917c-08dab562e919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tBgyqq5+kR2LbFzM7C+6R/UZAfzq9hfmC3DlQuU8gOTkbMbsLHudpeG/um894XAH+d0Bk+iBKeC6uBeypfai/J+01IQ9v5KeSoWzSvmRM6SokIb7kf758zV5ZLtdxxEoOEVTizmiwCwWrFsgK5V3eBtVFMI8lFqLkJsaQeEYFFqXSkAJd2x/WPb99t3Wmcbi9d/S879Ckd//fNtsr+1SljUfzzc0FJKOySZj8sfMcKcjcOaBCxpJWtXxasRqUHbxtEVdpLUwPitqD/BfdS1bmeCmzFYUAIDkHfeHoo1IyUbuY178Lp8ZmDSuDlZeqex4agqyEnDiXlF5As0Y9aBOLMgaKGf2Ewt4UFnvJ4v1vLs4aDRiqWH1bCAAiASwtWRpD1EAkdVeJQf8TRV7DLsCGlU+b/SCTmPJ18VDnfLvtSWbYGNdQ3lmuozqhk/hFQRKfIJ2uHmVrXwZypr6WF6ne3NuJEtDzOjEX6GR5NT1/qXgzjBSMSSSy3ixvRpPsoSsVXwQpeE+Hs9tCSTjY4J0Fx02U8E3PDrMhzOrz/ClDs7kTU4zbZ/ixbeYW03OdC6SIsQHmBS60io/T3/0Z+q6fNQvDlJdHptYwsZ5aGXNgAC6bnkfwGFo6BCCXmRE3GHpkGm7Kl9+ZRdhyvbn5xvtFhohEelUcPCssCgFLJ8v3GVD2GNn3bQw1ABOw6gvFSk8g8OCqzPU982D3ijwRxSJxTpt0CBod6fhFtmg37r3yrPHujw0wilcAMkbYAasPLRsajUGCy3I+Y0FKd0MmlyhLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39830400003)(136003)(396003)(376002)(366004)(451199015)(6486002)(186003)(1076003)(2616005)(2906002)(478600001)(26005)(5660300002)(38350700002)(66946007)(86362001)(316002)(6506007)(6666004)(41300700001)(107886003)(4326008)(44832011)(52116002)(8676002)(66556008)(66476007)(38100700002)(6512007)(36756003)(83380400001)(30864003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6Ttmmhq0+nM5HP1nbD3CpJWam6b9NNUPCCLhm+MPXVnLoo3Q+u9Bx8eUkz5?=
 =?us-ascii?Q?9DM47TYijfR/ff+E5HkmzRYuodA0bWB+2JRKWH8pI1ShdXBZGkp1khSPfAjP?=
 =?us-ascii?Q?IPOK6+hSh6t4RdKU9L//ed/Z5vgDe6kyZLFxlMPtL+E7MYIaVjH+zgJxQJX1?=
 =?us-ascii?Q?cUUqryXnOD/ucKR1gtJZ6WhbMfTWf0y6Wx1qToiMj01ugsqx1cK3ABiMW7Tb?=
 =?us-ascii?Q?rok4kaMYKTg7yeE5LnN009c4x2a++HB4qUEa8jbvkSFjYo0Qktulo9lpOqHm?=
 =?us-ascii?Q?WNRS7osAuEHp1dsFQedZXurW/dbo+X6TitpMVUn+18BRfQ9r3hJ6xN9qravw?=
 =?us-ascii?Q?XYhNgfw/N91Cs0Q9iQjg+nUauwqZMjr6lMltmHKmDJEZBq53B9bqZidqpLaq?=
 =?us-ascii?Q?ZbzEGI4ctj5Sa71q6o1Ch6N8H/k9YX4bVJ68PgukAt1pN7zE3uAqx3B6dVZK?=
 =?us-ascii?Q?4oWI8eV3/Ego/bLrTFH8oCj0E1Hg38LoQm1fShnK5ka05lv9ypkpgusmKV3k?=
 =?us-ascii?Q?lBKLKHV/1v+w802YAtunZgsrjOKMD9sxvsj9xhGIf9vi4f+OsDLoPeDaaE42?=
 =?us-ascii?Q?4V5khfImRAb4nd/CTtCcF6yEew7E5pEWAcBtb8O3cEJmDDqvZY3pRYnxrcKC?=
 =?us-ascii?Q?Z7/VP4lMQ9fVO3V6oB5DlynCQczaWD5OP5PfO1f+QX94tWsHqb4KDMt5ZtDN?=
 =?us-ascii?Q?QaVxup7+OYXXHOFZszSow5LiC5anYwOAcJsX7UB7utlqrWuNat2DlANX/GH1?=
 =?us-ascii?Q?VFLlMs9+YjW3HSABeTMgFqcb7Cgr3vLSo2JoUeqFDPw71OOd5pe1Vpkkr/ky?=
 =?us-ascii?Q?Bgcxqet5Tdhd600np5Fr2HXGxtLT1ZrQH33JDe4RYD6x3XOzGnHOt2urMwM8?=
 =?us-ascii?Q?FnMHXjHALUh2vkaKJ3yTTrOqpfGqIIA7juht87vGt6SHyZUnmPUnToAVum65?=
 =?us-ascii?Q?L/VZa+pGk9+7Ty31VNq0CZPBf7L3shKa7n9Jqrvv4bGFOvnqJMLARx6M+NrF?=
 =?us-ascii?Q?FxWS5WFLbGc1Da7xcc1jmPDQ61Gv7+gPyhhyVlGevCABhNcrMWIkXnXM9gvm?=
 =?us-ascii?Q?kSgezNb89piihCW/4ggZJzugfW+E0CigJzJBOso/xhhgjcddKbUxzra9hZun?=
 =?us-ascii?Q?incPOsgWFBFboXCzd+5NP1LUt0yMsuoiIvsntuT79x9lwH/d10+RI1fs/or3?=
 =?us-ascii?Q?K9OUMnixf4IXHd06lWCBq1pmaPHkN6z0lK1rccRNsBaSHMUEhn9LkMXj29jQ?=
 =?us-ascii?Q?BAqV9VNJaopoAaaDQ8ZwO0g1TXgpBBK+FT0yEzeb5GGCvYKBT4YlbjExJ2WN?=
 =?us-ascii?Q?YrHpZpMWt+suzzLWH5AIUVcX2y3WE2MLuE6XG8IlQpHfm/sXdZ9RFZrfpWrZ?=
 =?us-ascii?Q?R0KhsNVFjcSAGvLwl4yBDj8DOrka1YLVxNwsIUwTOFG7OgI+0yIDgGdMt+sG?=
 =?us-ascii?Q?f1W3dY52y7uWYs9qKwTGPoktEnqzHtGu5B0Lw3AzhvEOfFr1M7wT7LUY3oXa?=
 =?us-ascii?Q?NPnKGfWmSHMu6/NyLTN5nhHKJFuCCAFJjdat97yAqkyECkNXBNISb54u4IcC?=
 =?us-ascii?Q?GYfRH5y+ODkeAItwn4OSwN1TFUJcTgLaPq2oiJ+/sXSzG2rX8yExwVtSRlaG?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d881dc-5bed-4381-917c-08dab562e919
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 01:56:05.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IY/SjzHh1UgKo3SJ67CjxAjWOqRBn8wTo/r10YNJNnM/JHCYTrpR8oh0w91LrOLHVvO0nzPVPbyE1a2Z+rt7ZoBLt4VG3L369pYG2mI28iM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_vq_num_max of vdpa_config_ops is mean get the max size of vq,not
the max number of vq,it is kind of confused,rename it.
And get_vq_num_min rename to get_vq_size_min,
set_vq_num rename to set_vq_size,
rename implement of this ops also.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
v2:
	modify some log of git information,no code change.

 drivers/vdpa/alibaba/eni_vdpa.c    | 12 ++++++------
 drivers/vdpa/ifcvf/ifcvf_main.c    |  8 ++++----
 drivers/vdpa/mlx5/net/mlx5_vnet.c  |  8 ++++----
 drivers/vdpa/vdpa.c                | 12 ++++++------
 drivers/vdpa/vdpa_sim/vdpa_sim.c   | 12 ++++++------
 drivers/vdpa/vdpa_user/vduse_dev.c |  8 ++++----
 drivers/vdpa/virtio_pci/vp_vdpa.c  |  8 ++++----
 drivers/vhost/vdpa.c               |  4 ++--
 drivers/virtio/virtio_vdpa.c       |  8 ++++----
 include/linux/vdpa.h               | 12 ++++++------
 10 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index 5a09a09cca70..453331888cbb 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -240,14 +240,14 @@ static int eni_vdpa_reset(struct vdpa_device *vdpa)
 	return 0;
 }
 
-static u16 eni_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 eni_vdpa_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
 
 	return vp_legacy_get_queue_size(ldev, 0);
 }
 
-static u16 eni_vdpa_get_vq_num_min(struct vdpa_device *vdpa)
+static u16 eni_vdpa_get_vq_size_min(struct vdpa_device *vdpa)
 {
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
 
@@ -306,7 +306,7 @@ static bool eni_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
 	return vp_legacy_get_queue_enable(ldev, qid);
 }
 
-static void eni_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
+static void eni_vdpa_set_vq_size(struct vdpa_device *vdpa, u16 qid,
 			       u32 num)
 {
 	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
@@ -414,14 +414,14 @@ static const struct vdpa_config_ops eni_vdpa_ops = {
 	.get_status	= eni_vdpa_get_status,
 	.set_status	= eni_vdpa_set_status,
 	.reset		= eni_vdpa_reset,
-	.get_vq_num_max	= eni_vdpa_get_vq_num_max,
-	.get_vq_num_min	= eni_vdpa_get_vq_num_min,
+	.get_vq_size_max	= eni_vdpa_get_vq_size_max,
+	.get_vq_size_min	= eni_vdpa_get_vq_size_min,
 	.get_vq_state	= eni_vdpa_get_vq_state,
 	.set_vq_state	= eni_vdpa_set_vq_state,
 	.set_vq_cb	= eni_vdpa_set_vq_cb,
 	.set_vq_ready	= eni_vdpa_set_vq_ready,
 	.get_vq_ready	= eni_vdpa_get_vq_ready,
-	.set_vq_num	= eni_vdpa_set_vq_num,
+	.set_vq_size	= eni_vdpa_set_vq_size,
 	.set_vq_address	= eni_vdpa_set_vq_address,
 	.kick_vq	= eni_vdpa_kick_vq,
 	.get_device_id	= eni_vdpa_get_device_id,
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044c6442..c739e211ba97 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -519,7 +519,7 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 	return 0;
 }
 
-static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
+static u16 ifcvf_vdpa_get_vq_size_max(struct vdpa_device *vdpa_dev)
 {
 	return IFCVF_QUEUE_MAX;
 }
@@ -564,7 +564,7 @@ static bool ifcvf_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16 qid)
 	return vf->vring[qid].ready;
 }
 
-static void ifcvf_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid,
+static void ifcvf_vdpa_set_vq_size(struct vdpa_device *vdpa_dev, u16 qid,
 				  u32 num)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
@@ -695,13 +695,13 @@ static const struct vdpa_config_ops ifc_vdpa_ops = {
 	.get_status	= ifcvf_vdpa_get_status,
 	.set_status	= ifcvf_vdpa_set_status,
 	.reset		= ifcvf_vdpa_reset,
-	.get_vq_num_max	= ifcvf_vdpa_get_vq_num_max,
+	.get_vq_size_max	= ifcvf_vdpa_get_vq_size_max,
 	.get_vq_state	= ifcvf_vdpa_get_vq_state,
 	.set_vq_state	= ifcvf_vdpa_set_vq_state,
 	.set_vq_cb	= ifcvf_vdpa_set_vq_cb,
 	.set_vq_ready	= ifcvf_vdpa_set_vq_ready,
 	.get_vq_ready	= ifcvf_vdpa_get_vq_ready,
-	.set_vq_num	= ifcvf_vdpa_set_vq_num,
+	.set_vq_size	= ifcvf_vdpa_set_vq_size,
 	.set_vq_address	= ifcvf_vdpa_set_vq_address,
 	.get_vq_irq	= ifcvf_vdpa_get_vq_irq,
 	.kick_vq	= ifcvf_vdpa_kick_vq,
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 90913365def4..3ec0b911781e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1969,7 +1969,7 @@ static int mlx5_vdpa_set_vq_address(struct vdpa_device *vdev, u16 idx, u64 desc_
 	return 0;
 }
 
-static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
+static void mlx5_vdpa_set_vq_size(struct vdpa_device *vdev, u16 idx, u32 num)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
@@ -2299,7 +2299,7 @@ static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callba
 }
 
 #define MLX5_VDPA_MAX_VQ_ENTRIES 256
-static u16 mlx5_vdpa_get_vq_num_max(struct vdpa_device *vdev)
+static u16 mlx5_vdpa_get_vq_size_max(struct vdpa_device *vdev)
 {
 	return MLX5_VDPA_MAX_VQ_ENTRIES;
 }
@@ -2866,7 +2866,7 @@ static int mlx5_set_group_asid(struct vdpa_device *vdev, u32 group,
 
 static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_vq_address = mlx5_vdpa_set_vq_address,
-	.set_vq_num = mlx5_vdpa_set_vq_num,
+	.set_vq_size = mlx5_vdpa_set_vq_size,
 	.kick_vq = mlx5_vdpa_kick_vq,
 	.set_vq_cb = mlx5_vdpa_set_vq_cb,
 	.set_vq_ready = mlx5_vdpa_set_vq_ready,
@@ -2882,7 +2882,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_driver_features = mlx5_vdpa_set_driver_features,
 	.get_driver_features = mlx5_vdpa_get_driver_features,
 	.set_config_cb = mlx5_vdpa_set_config_cb,
-	.get_vq_num_max = mlx5_vdpa_get_vq_num_max,
+	.get_vq_size_max = mlx5_vdpa_get_vq_size_max,
 	.get_device_id = mlx5_vdpa_get_device_id,
 	.get_vendor_id = mlx5_vdpa_get_vendor_id,
 	.get_status = mlx5_vdpa_get_status,
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index febdc99b51a7..7fa411ba5f89 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -39,9 +39,9 @@ static int vdpa_dev_probe(struct device *d)
 	u32 max_num, min_num = 1;
 	int ret = 0;
 
-	max_num = ops->get_vq_num_max(vdev);
-	if (ops->get_vq_num_min)
-		min_num = ops->get_vq_num_min(vdev);
+	max_num = ops->get_vq_size_max(vdev);
+	if (ops->get_vq_size_min)
+		min_num = ops->get_vq_size_min(vdev);
 	if (max_num < min_num)
 		return -EINVAL;
 
@@ -690,9 +690,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
 
 	device_id = vdev->config->get_device_id(vdev);
 	vendor_id = vdev->config->get_vendor_id(vdev);
-	max_vq_size = vdev->config->get_vq_num_max(vdev);
-	if (vdev->config->get_vq_num_min)
-		min_vq_size = vdev->config->get_vq_num_min(vdev);
+	max_vq_size = vdev->config->get_vq_size_max(vdev);
+	if (vdev->config->get_vq_size_min)
+		min_vq_size = vdev->config->get_vq_size_min(vdev);
 
 	err = -EMSGSIZE;
 	if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index b071f0d842fb..59dd24cfe271 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -344,7 +344,7 @@ static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 	return 0;
 }
 
-static void vdpasim_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
+static void vdpasim_set_vq_size(struct vdpa_device *vdpa, u16 idx, u32 num)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
@@ -466,7 +466,7 @@ static void vdpasim_set_config_cb(struct vdpa_device *vdpa,
 	/* We don't support config interrupt */
 }
 
-static u16 vdpasim_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 vdpasim_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	return VDPASIM_QUEUE_MAX;
 }
@@ -697,7 +697,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 
 static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
-	.set_vq_num             = vdpasim_set_vq_num,
+	.set_vq_size            = vdpasim_set_vq_size,
 	.kick_vq                = vdpasim_kick_vq,
 	.set_vq_cb              = vdpasim_set_vq_cb,
 	.set_vq_ready           = vdpasim_set_vq_ready,
@@ -710,7 +710,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 	.set_driver_features    = vdpasim_set_driver_features,
 	.get_driver_features    = vdpasim_get_driver_features,
 	.set_config_cb          = vdpasim_set_config_cb,
-	.get_vq_num_max         = vdpasim_get_vq_num_max,
+	.get_vq_size_max        = vdpasim_get_vq_size_max,
 	.get_device_id          = vdpasim_get_device_id,
 	.get_vendor_id          = vdpasim_get_vendor_id,
 	.get_status             = vdpasim_get_status,
@@ -730,7 +730,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
 
 static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_vq_address         = vdpasim_set_vq_address,
-	.set_vq_num             = vdpasim_set_vq_num,
+	.set_vq_size            = vdpasim_set_vq_size,
 	.kick_vq                = vdpasim_kick_vq,
 	.set_vq_cb              = vdpasim_set_vq_cb,
 	.set_vq_ready           = vdpasim_set_vq_ready,
@@ -743,7 +743,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.set_driver_features    = vdpasim_set_driver_features,
 	.get_driver_features    = vdpasim_get_driver_features,
 	.set_config_cb          = vdpasim_set_config_cb,
-	.get_vq_num_max         = vdpasim_get_vq_num_max,
+	.get_vq_size_max        = vdpasim_get_vq_size_max,
 	.get_device_id          = vdpasim_get_device_id,
 	.get_vendor_id          = vdpasim_get_vendor_id,
 	.get_status             = vdpasim_get_status,
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 35dceee3ed56..dd3e72f79e31 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -521,7 +521,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
 	spin_unlock(&vq->irq_lock);
 }
 
-static void vduse_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
+static void vduse_vdpa_set_vq_size(struct vdpa_device *vdpa, u16 idx, u32 num)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	struct vduse_virtqueue *vq = &dev->vqs[idx];
@@ -617,7 +617,7 @@ static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
 	spin_unlock(&dev->irq_lock);
 }
 
-static u16 vduse_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 vduse_vdpa_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	u16 num_max = 0;
@@ -739,7 +739,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_vq_address		= vduse_vdpa_set_vq_address,
 	.kick_vq		= vduse_vdpa_kick_vq,
 	.set_vq_cb		= vduse_vdpa_set_vq_cb,
-	.set_vq_num             = vduse_vdpa_set_vq_num,
+	.set_vq_size		= vduse_vdpa_set_vq_size,
 	.set_vq_ready		= vduse_vdpa_set_vq_ready,
 	.get_vq_ready		= vduse_vdpa_get_vq_ready,
 	.set_vq_state		= vduse_vdpa_set_vq_state,
@@ -749,7 +749,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.set_driver_features	= vduse_vdpa_set_driver_features,
 	.get_driver_features	= vduse_vdpa_get_driver_features,
 	.set_config_cb		= vduse_vdpa_set_config_cb,
-	.get_vq_num_max		= vduse_vdpa_get_vq_num_max,
+	.get_vq_size_max	= vduse_vdpa_get_vq_size_max,
 	.get_device_id		= vduse_vdpa_get_device_id,
 	.get_vendor_id		= vduse_vdpa_get_vendor_id,
 	.get_status		= vduse_vdpa_get_status,
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index d448db0c4de3..e224610d3240 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -236,7 +236,7 @@ static int vp_vdpa_reset(struct vdpa_device *vdpa)
 	return 0;
 }
 
-static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+static u16 vp_vdpa_get_vq_size_max(struct vdpa_device *vdpa)
 {
 	return VP_VDPA_QUEUE_MAX;
 }
@@ -320,7 +320,7 @@ static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
 	return vp_modern_get_queue_enable(mdev, qid);
 }
 
-static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
+static void vp_vdpa_set_vq_size(struct vdpa_device *vdpa, u16 qid,
 			       u32 num)
 {
 	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
@@ -441,14 +441,14 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.get_status	= vp_vdpa_get_status,
 	.set_status	= vp_vdpa_set_status,
 	.reset		= vp_vdpa_reset,
-	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
+	.get_vq_size_max	= vp_vdpa_get_vq_size_max,
 	.get_vq_state	= vp_vdpa_get_vq_state,
 	.get_vq_notification = vp_vdpa_get_vq_notification,
 	.set_vq_state	= vp_vdpa_set_vq_state,
 	.set_vq_cb	= vp_vdpa_set_vq_cb,
 	.set_vq_ready	= vp_vdpa_set_vq_ready,
 	.get_vq_ready	= vp_vdpa_get_vq_ready,
-	.set_vq_num	= vp_vdpa_set_vq_num,
+	.set_vq_size	= vp_vdpa_set_vq_size,
 	.set_vq_address	= vp_vdpa_set_vq_address,
 	.kick_vq	= vp_vdpa_kick_vq,
 	.get_generation	= vp_vdpa_get_generation,
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 166044642fd5..47a68e878a2b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -397,7 +397,7 @@ static long vhost_vdpa_get_vring_num(struct vhost_vdpa *v, u16 __user *argp)
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u16 num;
 
-	num = ops->get_vq_num_max(vdpa);
+	num = ops->get_vq_size_max(vdpa);
 
 	if (copy_to_user(argp, &num, sizeof(num)))
 		return -EFAULT;
@@ -581,7 +581,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_NUM:
-		ops->set_vq_num(vdpa, idx, vq->num);
+		ops->set_vq_size(vdpa, idx, vq->num);
 		break;
 	}
 
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 9670cc79371d..78aee39fd47a 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -162,14 +162,14 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	max_num = ops->get_vq_num_max(vdpa);
+	max_num = ops->get_vq_size_max(vdpa);
 	if (max_num == 0) {
 		err = -ENOENT;
 		goto error_new_virtqueue;
 	}
 
-	if (ops->get_vq_num_min)
-		min_num = ops->get_vq_num_min(vdpa);
+	if (ops->get_vq_size_min)
+		min_num = ops->get_vq_size_min(vdpa);
 
 	may_reduce_num = (max_num == min_num) ? false : true;
 
@@ -189,7 +189,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
 	cb.private = info;
 	ops->set_vq_cb(vdpa, index, &cb);
-	ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
+	ops->set_vq_size(vdpa, index, virtqueue_get_vring_size(vq));
 
 	desc_addr = virtqueue_get_desc_addr(vq);
 	driver_addr = virtqueue_get_avail_addr(vq);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 6d0f5e4e82c2..759ae1c255ee 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -136,7 +136,7 @@ struct vdpa_map_file {
  *				@driver_area: address of driver area
  *				@device_area: address of device area
  *				Returns integer: success (0) or error (< 0)
- * @set_vq_num:			Set the size of virtqueue
+ * @set_vq_size:		Set the size of virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				@num: the size of virtqueue
@@ -198,10 +198,10 @@ struct vdpa_map_file {
  * @set_config_cb:		Set the config interrupt callback
  *				@vdev: vdpa device
  *				@cb: virtio-vdev interrupt callback structure
- * @get_vq_num_max:		Get the max size of virtqueue
+ * @get_vq_size_max:		Get the max size of virtqueue
  *				@vdev: vdpa device
  *				Returns u16: max size of virtqueue
- * @get_vq_num_min:		Get the min size of virtqueue (optional)
+ * @get_vq_size_min:		Get the min size of virtqueue (optional)
  *				@vdev: vdpa device
  *				Returns u16: min size of virtqueue
  * @get_device_id:		Get virtio device id
@@ -290,7 +290,7 @@ struct vdpa_config_ops {
 	int (*set_vq_address)(struct vdpa_device *vdev,
 			      u16 idx, u64 desc_area, u64 driver_area,
 			      u64 device_area);
-	void (*set_vq_num)(struct vdpa_device *vdev, u16 idx, u32 num);
+	void (*set_vq_size)(struct vdpa_device *vdev, u16 idx, u32 num);
 	void (*kick_vq)(struct vdpa_device *vdev, u16 idx);
 	void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx,
 			  struct vdpa_callback *cb);
@@ -316,8 +316,8 @@ struct vdpa_config_ops {
 	u64 (*get_driver_features)(struct vdpa_device *vdev);
 	void (*set_config_cb)(struct vdpa_device *vdev,
 			      struct vdpa_callback *cb);
-	u16 (*get_vq_num_max)(struct vdpa_device *vdev);
-	u16 (*get_vq_num_min)(struct vdpa_device *vdev);
+	u16 (*get_vq_size_max)(struct vdpa_device *vdev);
+	u16 (*get_vq_size_min)(struct vdpa_device *vdev);
 	u32 (*get_device_id)(struct vdpa_device *vdev);
 	u32 (*get_vendor_id)(struct vdpa_device *vdev);
 	u8 (*get_status)(struct vdpa_device *vdev);
-- 
2.25.1

