Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4C64A3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiLLPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiLLPDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:03:08 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F0D13CC3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:03:07 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 18E98320096C;
        Mon, 12 Dec 2022 10:03:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Dec 2022 10:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670857385; x=1670943785; bh=+CpXX8ix7k
        82jmDw1nqAMg5CCW8sIBQI4jIZJeEyI2s=; b=hMqTNI2YoDdj8qMuqQMZU5X0+u
        QfNbVuXc0PpydR2jwiq65wYmAHSlmrfAMsXXogFuaKstLcUV2XDqDTOiBTRwCr4l
        bRSAhd+BkxuPdHjNXeLN04d0cgkfve7gFkmXnZQlrRS9HddR15ZXLq5uBUvtVpLT
        Kv08xTpVxiFNMWi6zcJW6z9Tgv4+sXdRRJQFIakKBE1n5ibEzJ3GcVeBRP7C2fiN
        XRgHNu+CavIazWYyugp6GXoxVVxUwjhOYUutgGqC/GaZkTNgCIsYJSZY+QzvkXMQ
        ULrJB8eRe+Rmz7yWNY3uiEXdaRI/8KtQXLVMpkpWmFrCooYAsYL5nlU9NOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1670857385; x=1670943785; bh=+CpXX8ix7k82jmDw1nqAMg5CCW8sIBQI4jI
        ZJeEyI2s=; b=NSh60PpcgpOdNtajtNTZci/2MnW4JO6a7Ab8BmmsUhZAhqg142Z
        qj5HLeJ2fQW+IWX45BIwAEACm0ZwlNRm4L5QZMswwhgYTNAfwLXrCVF4g7KkVQGh
        m//j3J3kf0XrXukq7jHGWHUweRSdlpdq8IpOXpx5sK8a5MSc92ImTitKKUXHW+GU
        wJfYt7zJnS3ar5CIXVrP4uQnMvF4A+HFHn0O5JHNWrzjp8AYkOLRmh/IfhNTk2pH
        mTS3N8qe96l1a/aOeCKnmOufOEVFPaZ8IZ8l5gVPTqNBqPO59qSgKAqxcYAO42kw
        Lqf99dT2imE0Kbe/nhFsEj6z2CH0xqlxi/w==
X-ME-Sender: <xms:p0KXY9L7jVGRecdtV1BsrpGHX5RZIuAq_hOo3KnAkW-F-kpVN7bJsw>
    <xme:p0KXY5IAQdMyZFucVMcC_XOmwJvVmH-WeZ-oIRxqQhgT6aRBkA8wxa6X43Uwe8ZbA
    APkFDtbcN6mekLqEXU>
X-ME-Received: <xmr:p0KXY1vCKHMWIABoHo5LTf47XWWrg3P8E4jTJdnb6Lf-IuRJbDPVUXLFTRXFl7ate8lDa_XRW89uIvIFgnEX9x9ZTREHL5Fs-W-Y4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
    vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
    hnpeehkeevvdelueejteeffeevgfeiueegleduhedtheeltdefteegkeejkeehffekteen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:p0KXY-buvwHA7HSMp70Id30aucwRcPklGX2Ugr7oOUWQ3b4BHN2fYQ>
    <xmx:p0KXY0YgpxuXYlP-PuMUkjnPElIt0fYiLVlexQOyxxk9sd8FSGzGaw>
    <xmx:p0KXYyA-luIp-6PvRcC9QBWwv44OjB9gpdc2fnxBl0piEvyZTt2zOA>
    <xmx:qUKXY07TExrqh8sQZz13bgtJRr4tnaMNOz21G5Xqc1qWmNKZ7-e8wg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 10:03:01 -0500 (EST)
From:   Klaus Jensen <its@irrelevant.dk>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, Klaus Jensen <its@irrelevant.dk>,
        Klaus Jensen <k.jensen@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] nvme-pci: fix doorbell buffer value endianness
Date:   Mon, 12 Dec 2022 16:02:43 +0100
Message-Id: <20221212150243.41283-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=k.jensen@samsung.com; h=from:subject; bh=pxJNDl8z/idTl/CswBiokgDVOX6TDTlQcOByQIFgEs8=; b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGOXMchwq1RBbre4jil8uMe7uh7Elh6G4BXztt+w Ocm9dCjel4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJjlzHIAAoJEE3hrzFtTw3pXW YH/1255wB1gfHisAM9eUIme2xEgthZVQugLOJyBqXCq5FJa+/oVw6273qSuBBffp008C4tlkUfgAB8 TjgD1tN1vgALVrHKmoIGCMebymjxrSH9EU93HYFXPRq0RGADgnWiOMo6Ucbg/M5SYOHJ1iDgQIB19l vCjLwDGyinwepk2KQrQCmf82ELy8lPLKQuP1E4AqXltCUFGT9ehTSnsKL9kO6qWcIERNG1oCLsph/y ZVI2USj35vR/8qiwIlJ5nNGZ7zrQ3g9KJVcRrlM04WYVHHLnBim0ul/uu0lKS5EKi40ETH2kpn1jle /PfqvfJUWdzYeBj0xWbVVm9k3dM/AUteAm6Khn
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp; fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/nvme/host/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f005e8569266..d12d4c3cb6d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -347,7 +347,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 					      volatile u32 *dbbuf_ei)
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

