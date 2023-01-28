Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DC67F796
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjA1Lfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjA1Lfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:35:44 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB872E831
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:35:43 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4FFE03200921;
        Sat, 28 Jan 2023 06:35:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 28 Jan 2023 06:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674905741; x=1674992141; bh=4olYd8m5Y3
        m/Ketj4EwpMONs8K8Rrl0HRXvFBBCSojM=; b=bljsgFRJbyiyanK0zuGhiY2eKE
        1w8dNqZ6EXngJ3Xk9DEgDZND5FceFkvIGJ566U7Dcf/RoJU555MnVTZPhYxyf3ji
        9eGALqBWpsDzC3uVebiO2s+qseU6La9Ys4hirvioO8uw5uituT/tn9aOE3Pb9ASC
        BVIeBEpj32yj+/r/uOZ1YGtKAgCx8MeU50kd2PNdL8MBK5SvtwPdAATZq/gfd4Rv
        ZrQWlyHpi2ydEg6/tRcL3bgHV/th+uLA9ZIXXVQjsoKzUUDgB+p3sDN+t2Q8R1+x
        7/vwGmB8USIBumdPiT4RNJv4nhDMWEf1UmGS5X7Ye/LhrUb0XqLEnq+Zz8cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1674905741; x=1674992141; bh=4olYd8m5Y3m/Ketj4EwpMONs8K8Rrl0HRXv
        FBBCSojM=; b=hDpqJwehKURHYH2X8/xGLrBUD+TpPSYu9hCLfuI5QFBGzDM2b0z
        pshS+EG0vkK4avyUSz/Wxo0dk6nrCDESi9Dsi+wufoDQpKJ3p6iC8dGyhKzMbjos
        p3AiklKV/Xr36lAacL0uXPxysuRu7mPcv/zGkn0di7TYsKO4kZjujgFVJiTDVW6m
        FGIhak3pygmSfm/TZeV+/hFd5x/ME8SKcZCZ/s5MKapzueqeU0nqE9MaVdyv59aT
        tDSAqxrEaoWTaPGZST9BogqzWjMI0sWOsB9XuttBy7LWs6aToKeZlNRmuf2+G6ZA
        aWcwpnibBdh6JC2OXOUu4dxiHOytX6HM7xg==
X-ME-Sender: <xms:jQjVY3Slwgfj5AekHjbAcdhhLpAKlw0qydxNrqWkb-G2Uodxa-0TxA>
    <xme:jQjVY4zGbJXD2HpCyg83OP1HSkZcGaRTK8jmssJFIBhNc9yHxuIrMvZuz-RAfwN2n
    uFA4WYkMj6f1B84qbc>
X-ME-Received: <xmr:jQjVY82pIsIb9L2Lbejms4NdvZ8YaVyeaO5Tv2_Ljrx0r79lIc6CvnZXa3RXVGP1BAIuJ_T4j8LiFP71CMH3udn2Oe94PzflfUGxWxY5ebJ92qI3PCtTi2XfBC6TYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeludffieehueevtdffvedtueelleejuddugfettdevhfefffdvgffhjeehgfelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:jQjVY3DmL2FkvGSzKPA5kXJhldLQJNRkolLH6Xn67T4zKUuahAEsqg>
    <xmx:jQjVYwiC8TXuTDk08hHu4QEkz3RRs1eHo6QcvqvWVPUPefuwCLL98w>
    <xmx:jQjVY7op7kLEOSe10kzi3fnv10YhaevUoyDcc43a2LaLULLj9wHRSQ>
    <xmx:jQjVY5Wfs5iOzs8TkveFBWFXZv2RbTK_HHv07A8tdNkDX_zTTtFz7w>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 06:35:40 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dart: Fix apple_dart_device_group for PCI groups
Date:   Sat, 28 Jan 2023 12:35:32 +0100
Message-Id: <20230128113532.94651-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_device_group() can return an already existing IOMMU group if the PCI
device's pagetables have to be shared with another one due to bus
toplogy, isolation features and/or DMA alias quirks.
apple_dart_device_group() however assumes that the group has just been
created and overwrites its iommudata which will eventually lead to
apple_dart_release_group leaving stale entries in sid2group.
Fix that by merging the iommudata if the returned group already exists.

Fixes: f0b636804c7c ("iommu/dart: Clear sid2group entry when a group is freed")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/iommu/apple-dart.c | 51 ++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

This won't apply cleanly to iommu/fixes as it's based on the t8110 DART
changes since the USB4/Thunderbolt DART itself also depends on those.
That's not a big deal though since it's not possible to run into this
bug without complex PCI bus topologies which can only be created using
USB4/Thunderbolt on these SoCs and there's no support for that upstream
yet.

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index a1304ba3639b..02f7a1740b14 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -840,6 +840,29 @@ static void apple_dart_release_group(void *iommu_data)
 	mutex_unlock(&apple_dart_groups_lock);
 }
 
+static int apple_dart_merge_master_cfg(struct apple_dart_master_cfg *dst,
+				       struct apple_dart_master_cfg *src)
+{
+	/*
+	 * We know that this function is only called for groups returned from
+	 * pci_device_group and that all Apple Silicon platforms never spread
+	 * PCIe devices from the same bus across multiple DARTs such that we can
+	 * just assume that both src and dst only have the same single DART.
+	 */
+	if (src->stream_maps[1].dart)
+		return -EINVAL;
+	if (dst->stream_maps[1].dart)
+		return -EINVAL;
+	if (src->stream_maps[0].dart != dst->stream_maps[0].dart)
+		return -EINVAL;
+
+	bitmap_or(dst->stream_maps[0].sidmap,
+		  dst->stream_maps[0].sidmap,
+		  src->stream_maps[0].sidmap,
+		  dst->stream_maps[0].dart->num_streams);
+	return 0;
+}
+
 static struct iommu_group *apple_dart_device_group(struct device *dev)
 {
 	int i, sid;
@@ -881,14 +904,28 @@ static struct iommu_group *apple_dart_device_group(struct device *dev)
 	if (!group)
 		goto out;
 
-	group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg), GFP_KERNEL);
-	if (!group_master_cfg) {
-		iommu_group_put(group);
-		goto out;
-	}
+	group_master_cfg = iommu_group_get_iommudata(group);
+	if (group_master_cfg) {
+		int ret;
 
-	iommu_group_set_iommudata(group, group_master_cfg,
-		apple_dart_release_group);
+		ret = apple_dart_merge_master_cfg(group_master_cfg, cfg);
+		if (ret) {
+			dev_err(dev, "Failed to merge DART IOMMU grups.\n");
+			iommu_group_put(group);
+			res = ERR_PTR(ret);
+			goto out;
+		}
+	} else {
+		group_master_cfg = kmemdup(cfg, sizeof(*group_master_cfg),
+					   GFP_KERNEL);
+		if (!group_master_cfg) {
+			iommu_group_put(group);
+			goto out;
+		}
+
+		iommu_group_set_iommudata(group, group_master_cfg,
+			apple_dart_release_group);
+	}
 
 	for_each_stream_map(i, cfg, stream_map)
 		for_each_set_bit(sid, stream_map->sidmap, stream_map->dart->num_streams)
-- 
2.25.1

