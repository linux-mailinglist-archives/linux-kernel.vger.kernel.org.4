Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3ECE64B19F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiLMI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiLMI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:58:19 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C72263C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 00:58:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 41494320094D;
        Tue, 13 Dec 2022 03:58:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 13 Dec 2022 03:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670921896; x=1671008296; bh=FP0rzqiJQt
        /rF/U3RUlHmYgTW149TX821ue5IQIrNFM=; b=X0OGGT+nCHg830BNua7z1xPHan
        oNx+n4Yp+IVebmm3trGF+Yu5koqw99DJj3lTiye9IupBVWutk89W5AJyAXPVDPBF
        djU6yTqfN/Cb0p9nE41vJAgMRCLpHD5kE8RpSDXJWM+hrINzRfcTnWQbqEkCBLKo
        cIyHXS15XBk2YSoghIUvY22qlfYwsxcEoT1aziU3Sd0dYGjqRjs7hg+BiZ2eWkc/
        VVC1ATo5dNHiDLOkNKeaAJ8tCs06IXtvaLzdLIrnJdwp7jvmCJa4swBiQum6rzh/
        fLaap6cOjFC39Zz7WVkAwlDOi3Gk61ZHlVqcftDZ3mgn+shd4/PC7hs8JdGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1670921896; x=1671008296; bh=FP0rzqiJQt/rF/U3RUlHmYgTW149TX821ue
        5IQIrNFM=; b=t2TRvXa3w7pdP7P4ZCbwIS6Lt7I8aa3Tmk0c3XD3lgFClZFt+Rq
        mgPngLi+6WpQffZglrrBsLLZPd1vLTeh+Ue31roKzXgFeMwlQOnHJ5FSqN7A4AzS
        zc9I8jx+zRw/WjD4/5hp2ektaCLeedP8rVn1VyMATM71fF01unP110vRSXpH6im/
        jfDdRzLKDSrC6AUqG5+/uu0pysdK565+VkqRPDzz3CHIzDs0kZCfThBYE4WU9ZoW
        EtTwdvSp/j5egHCQrCbfc0K6ZR2e+BwfgI2q9/0d/NaQ8BkBUb4t3DtdB+vd+GTx
        0GTvVBo2JcF1gCSlJJ1xEupjYjSGhl7lnnQ==
X-ME-Sender: <xms:qD6YYxTHldHefrusTHV4wzJ3c2ynZukkxfcITfEIPl_83zXfs0At0Q>
    <xme:qD6YY6zXB_Q2_HvI58XwitVKHpBUNpPyGxuXdzZJr2Wa4c3AEC3sLkMkBUXtvDwLs
    vT3PIxNhl8C1iC0BdM>
X-ME-Received: <xmr:qD6YY220C-UHrK4Z7V0vCoqYzf0PLb2m6IzM995WMsL88LxrhgRtDkU0b065-G0Vi4yYGz7N0JbxqhkcQH8ZM4yEgDCktlwquNl6Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelgdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
    lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
    hrnhepheekvedvleeujeetfeefvefgieeugeeludehtdehledtfeetgeekjeekheffkeet
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:qD6YY5AsdSlWx3rsru8XQCbgJ1BXP9tHYSqIDAbWBVQJdvUpcSuI6w>
    <xmx:qD6YY6gd8R1wEvx5B_GFaj5sYM58VdQBgfNoqEYsELfRcrFmMHAuqA>
    <xmx:qD6YY9osFeid18wz3qsICVB5KmVzTucQgdCQLrqkPyPwoGekUuOSfA>
    <xmx:qD6YY-ikBjJLgNolWKlmu7BiGoHqCJarVFeDJSiD_IukmEIEXCclxA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Dec 2022 03:58:14 -0500 (EST)
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, Klaus Jensen <its@irrelevant.dk>,
        Klaus Jensen <k.jensen@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] nvme-pci: fix doorbell buffer value endianness
Date:   Tue, 13 Dec 2022 09:58:07 +0100
Message-Id: <20221213085807.90656-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2902; i=k.jensen@samsung.com; h=from:subject; bh=15xlDKfwJnKgaIjGHtLnyv+UgBDU1MG0j2eNH02d/IU=; b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGOYPnvNNWaOlTo2UzcC/rkXUzhUFwOnAKhQSgit Ns3qYJKSBIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJjmD57AAoJEE3hrzFtTw3pl6 EIAIjvm8p5GpHWfYza1pxq5gDD/BeyoBUrRjrwsX2EddMQCvktg5YDQEIQ1LWTjP6+kJ1b+jk9K2kG uveguPFpisY+qpK8oTjV58Xp74sXiGnLy2DFC31QGy3OtlJpQyV81utBJyIsz/Q60iEMn4UNh0zrPB 1ZVGdQAG1l+uZ+YgdDhdP8+HMJgDlOe7pb0NW4ROfOeTQKt8mB9v4mB13xv45nJyC77/+HfS3Kg+A3 NFWHO4NlEVLIl6p41gXxKdo8CxRT8L8dZIbTDp3UKGFfCiJEgL9if40SHz8H6pjrBUa42hcanWoJBL YPbfOxZS5+0+XfD6SUX2cRXJ0vDCWR47IurqLF
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp; fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Klaus Jensen <k.jensen@samsung.com>

When using shadow doorbells, the event index and the doorbell values are
written to host memory. Prior to this patch, the values written would
erroneously be written in host endianness. This causes trouble on
big-endian platforms. Fix this by adding missing endian conversions.

This issue was noticed by Guenter while testing various big-endian
platforms under QEMU[1]. A similar fix required for hw/nvme in QEMU is
up for review as well[2].

  [1]: https://lore.kernel.org/qemu-devel/20221209110022.GA3396194@roeck-us.net/
  [2]: https://lore.kernel.org/qemu-devel/20221212114409.34972-4-its@irrelevant.dk/

Fixes: f9f38e33389c ("nvme: improve performance for virtual NVMe devices")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/nvme/host/pci.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f005e8569266..c8e65afa1025 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -144,9 +144,9 @@ struct nvme_dev {
 	mempool_t *iod_mempool;
 
 	/* shadow doorbell buffer support: */
-	u32 *dbbuf_dbs;
+	__le32 *dbbuf_dbs;
 	dma_addr_t dbbuf_dbs_dma_addr;
-	u32 *dbbuf_eis;
+	__le32 *dbbuf_eis;
 	dma_addr_t dbbuf_eis_dma_addr;
 
 	/* host memory buffer support: */
@@ -208,10 +208,10 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
-	u32 *dbbuf_sq_db;
-	u32 *dbbuf_cq_db;
-	u32 *dbbuf_sq_ei;
-	u32 *dbbuf_cq_ei;
+	__le32 *dbbuf_sq_db;
+	__le32 *dbbuf_cq_db;
+	__le32 *dbbuf_sq_ei;
+	__le32 *dbbuf_cq_ei;
 	struct completion delete_done;
 };
 
@@ -343,11 +343,11 @@ static inline int nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
 }
 
 /* Update dbbuf and return true if an MMIO is required */
-static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
-					      volatile u32 *dbbuf_ei)
+static bool nvme_dbbuf_update_and_check_event(u16 value, __le32 *dbbuf_db,
+					      volatile __le32 *dbbuf_ei)
 {
 	if (dbbuf_db) {
-		u16 old_value;
+		u16 old_value, event_idx;
 
 		/*
 		 * Ensure that the queue is written before updating
@@ -355,8 +355,8 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 		 */
 		wmb();
 
-		old_value = *dbbuf_db;
-		*dbbuf_db = value;
+		old_value = le32_to_cpu(*dbbuf_db);
+		*dbbuf_db = cpu_to_le32(value);
 
 		/*
 		 * Ensure that the doorbell is updated before reading the event
@@ -366,7 +366,9 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 		 */
 		mb();
 
-		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
+		event_idx = le32_to_cpu(*dbbuf_ei);
+
+		if (!nvme_dbbuf_need_event(event_idx, value, old_value))
 			return false;
 	}
 
-- 
2.38.1

