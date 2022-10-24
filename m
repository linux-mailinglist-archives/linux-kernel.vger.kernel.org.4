Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD160B964
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiJXUKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiJXUIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:08:22 -0400
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA3FA00B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:28:14 -0700 (PDT)
Received: from 104.47.18.112_.trendmicro.com (unknown [172.21.10.202])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 246CA10117735
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:42:04 +0000 (UTC)
Received: from 104.47.18.112_.trendmicro.com (unknown [172.21.205.29])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id DEAFD10001789;
        Mon, 24 Oct 2022 13:41:03 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1666618863.214000
X-TM-MAIL-UUID: b0f190fd-d9eb-42e2-b2cc-fdc8da235882
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown [104.47.18.112])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 346EE10000E35;
        Mon, 24 Oct 2022 13:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmAjHzIOjCk7vkFLcdP+StSRCeKMCP4gQ9a0DHpHwRXfV2NESGqPWT+dvTH3eneznNPzvfzVDAyLT2RM/pVVnQmluoG3dA7oRK0WkHSTxtYOYuR/OJhzQbyrOPJEHaDCGiBbK3siGLvdnDVLxmI4JLETm6tZaWZm0LQXD7HFcGZk7r6K/+XzIMNRTGJecVW15Q9Ydm0jr3zSWx4hOkV22lElDYp8pKDFcJTw2iKDSkTA2DuOG2iQ+aftnDa/5ryBCPbaCFlQYVKRspGpmJQkCBmQk8wVFiSGUIVRprUotBdzy0CWZk9OtTJPeIIfDylraDMc/M98D/wiirXzwJYAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYKgG0LMSWdFCkFBvpgRCf6xvkpxbpR1Y/IhJK8NIQk=;
 b=KUDmAjpsAKrf/05H0kiQHxB/yMjL3LKhmMghZ/7dTPaffFkCSe5h/BKx1kE+Q9h9eDH5hZFR4UZuHUR8Q+pvsMSv2lkl/UdOeo4Ja9gz8dxpRxp78OlWeBnQNZWfvFlfRnY23FsL8Y0T+xOAhRFyP1tsvjTbEid0NA13HgCoPNMxwL4VVpdSH5oqO35r/Jho+h6j8jotMBcUxGxNapXqSAMX2ZSC9PtaBYNH/suhvdAYlgaJTchgaVolu1dxyPHD6xZCQZCZV/QlhFMHmnJLw1E+q7J0y3Jm0rferFXFUmG4XVT9FTsvP2XnSSt4pdXvYl30o3A5MOYkP0hzveif+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=opensynergy.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Igor Skalkin <Igor.Skalkin@opensynergy.com>
To:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        mst@redhat.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: [PATCH v4 1/1] virtio_bt: Fix alignment in configuration struct
Date:   Mon, 24 Oct 2022 15:40:33 +0200
Message-Id: <20221024134033.30142-2-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
References: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
 <20221024134033.30142-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT022:EE_|DB9PR04MB9402:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c75e319a-f447-456e-2f51-08dab5c56392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wA0se/z6o7k6ZL3OJlKvuK0BDNeTJT9ccRZ/Qu9TyzboRfef8em0w+Wz4tKdORuVKS1sWurI+zsjN8UTMAVQTciCR3c4DaLKxG8ZRPjbDKTiyiDH/Q38WOT5nMkkemNBMGKd6OR7a6MYE+B/c1h3fAeWXTkg2WVCjZXbreuNIBf2QpJQkg+nu8vrdjA/f7rmsaLvi+bGxCqW5wOs/2992caERdvm1GavuC0hArs5HFG7c+kbOoimouBFrSXiy0atdFKQkUOmI5sxqIfcnkO2xfsFTK9ue5qZ5BHa5e37x3y2btu8+PQ0I2xfhDfWK04joXx4tG0hv0m3sdJ5frEZuoS8ihnywbP7L4lV5QomLqBWmKKOSLdjsaD8r43sVxT6LD5cRxuCD1yEjUoyH8Juxrz8dUc10FAiwV12FIf26vMzX81GCNORLo16L2YKhLm+4Gx2oHKDaustT/7UrItF3rwISsYWJvGxbjevvT7GOYNx1D4FdNZnIL1w83ppzuujwcALMavnois9kFYxZ8xppEu2yKzQQ4WslzRDdfLccNFKGD90HmAhXH/LZ+OuInPc/kkx9QdU48vQneyf6tXb0iLXBBUBTwXqOgzE+4dHnfAGcnTWFsZyq6xZaY9/ppZti7DU9PG61F/1/CO07dLV+YncRUaHsaM3iOaKS/ogVa4jyzh9xVhkQ+1wDsrXlM6naK2sU0MS0TlqqeBNK5lhiHGJA1/nuHHj3zL6bWV0rfEBtm2H6KP0tN7PXWvNHpE3KqpfyCr6JUKyjtjdNmrAKi4aB71DlQwiPQOeBC9b5HQ=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(376002)(396003)(39840400004)(346002)(136003)(451199015)(46966006)(36840700001)(5660300002)(36756003)(2906002)(478600001)(316002)(42186006)(4326008)(70586007)(70206006)(8676002)(41300700001)(8936002)(966005)(83380400001)(81166007)(40480700001)(36860700001)(107886003)(86362001)(47076005)(1076003)(26005)(336012)(186003)(2616005)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 13:41:00.9118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75e319a-f447-456e-2f51-08dab5c56392
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT022.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9402
X-TM-AS-ERS: 104.47.18.112-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27220.007
X-TMASE-Result: 10--2.074400-4.000000
X-TMASE-MatchedRID: HLZKLD98mswxZoNWTqFxuUXBhxFdFgcQBXngI6jFvpeueqlDxh8ToXMW
        fmr8UEU8gRXUy3f9jsQW+rN4H33dkdyU5e20qrzVuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUilv
        Ab18i4hOxIT6WtCo5I1cnoO4Nx+loO4kcA8kjsz9kiLB9qoJwH0pO/ORUaZ3FmyiLZetSf8m2Ie
        O/ulJw0egL5WVEeE7IO+2BPnSgMUYgBwKKRHe+r/ruL7dkRPghkqsE8rtkLcxTSZ4Q3ZLFG9HYN
        coLyNp5fTcDEEc/mG4=
X-TMASE-XGENCLOUD: f6ff373a-9dcd-4842-ba0d-9f3476168479-0-0-200-0
X-TM-Deliver-Signature: 79B49BEBBC56D98A64CE6F581C975E27
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1666618863;
        bh=KtfCxF3VhIYx3CXyDTo5AKzO6JYre2ypx27bbgcYq2k=; l=2894;
        h=From:To:Date;
        b=05Tmzxa60CNLJ3rU94Y7O0bxToQZJTwCTyplR+bJt75UYGHfp/y18c/wRNTOMJ34m
         MMu0uGUzeAbxw1VpvYUqfmPhsLsCAuN78r99FEYARTUij4UDO1d7X0PczxLSaubD9v
         o6A8au7V3pfdB4RVn9IigKwEPyIJ58Rz2Eyq+sqtu3HyqlW4w97oYSYP/1h5SFRMgV
         Qy065aJ31GFl66l63YHtgfkirGgCa1ODcYWODzFPNOfuqfBYdJiDq8Dq8VxmLykek1
         mfiI2FVNshSUaaiJtyI5K5waqNAyzBGy3Kmgywi6QaZuN8ZzjoqCo8WZdIjyt8aYnN
         uYR4XxxhrJZXA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current version of the configuration structure has unaligned
16-bit fields, but according to the specification [1], access to
the configuration space must be aligned.

Add a second, aligned  version of the configuration structure
and a new feature bit indicating that this version is being used.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
---
 drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
 include/uapi/linux/virtio_bt.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 67c21263f9e0..35f8041722c8 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -306,7 +306,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_VND_HCI)) {
 		__u16 vendor;
 
-		virtio_cread(vdev, struct virtio_bt_config, vendor, &vendor);
+		if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
+			virtio_cread(vdev, struct virtio_bt_config_v2,
+				     vendor, &vendor);
+		else
+			virtio_cread(vdev, struct virtio_bt_config,
+				     vendor, &vendor);
 
 		switch (vendor) {
 		case VIRTIO_BT_CONFIG_VENDOR_ZEPHYR:
@@ -339,8 +344,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_BT_F_MSFT_EXT)) {
 		__u16 msft_opcode;
 
-		virtio_cread(vdev, struct virtio_bt_config,
-			     msft_opcode, &msft_opcode);
+		if (virtio_has_feature(vdev, VIRTIO_BT_F_CONFIG_V2))
+			virtio_cread(vdev, struct virtio_bt_config_v2,
+				     msft_opcode, &msft_opcode);
+		else
+			virtio_cread(vdev, struct virtio_bt_config,
+				     msft_opcode, &msft_opcode);
 
 		hci_set_msft_opcode(hdev, msft_opcode);
 	}
@@ -387,6 +396,7 @@ static const unsigned int virtbt_features[] = {
 	VIRTIO_BT_F_VND_HCI,
 	VIRTIO_BT_F_MSFT_EXT,
 	VIRTIO_BT_F_AOSP_EXT,
+	VIRTIO_BT_F_CONFIG_V2,
 };
 
 static struct virtio_driver virtbt_driver = {
diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
index a7bd48daa9a9..af798f4c9680 100644
--- a/include/uapi/linux/virtio_bt.h
+++ b/include/uapi/linux/virtio_bt.h
@@ -9,6 +9,7 @@
 #define VIRTIO_BT_F_VND_HCI	0	/* Indicates vendor command support */
 #define VIRTIO_BT_F_MSFT_EXT	1	/* Indicates MSFT vendor support */
 #define VIRTIO_BT_F_AOSP_EXT	2	/* Indicates AOSP vendor support */
+#define VIRTIO_BT_F_CONFIG_V2	3	/* Use second version configuration */
 
 enum virtio_bt_config_type {
 	VIRTIO_BT_CONFIG_TYPE_PRIMARY	= 0,
@@ -28,4 +29,11 @@ struct virtio_bt_config {
 	__u16 msft_opcode;
 } __attribute__((packed));
 
+struct virtio_bt_config_v2 {
+	__u8  type;
+	__u8  alignment;
+	__u16 vendor;
+	__u16 msft_opcode;
+};
+
 #endif /* _UAPI_LINUX_VIRTIO_BT_H */
-- 
2.37.2

