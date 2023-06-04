Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D57214F2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjFDFp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjFDFpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05724E3
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:45:09 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 68DCE5C0111;
        Sun,  4 Jun 2023 01:45:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 04 Jun 2023 01:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685857508; x=
        1685943908; bh=8Dgw6YabWHeE3yFvx/mYzF63i5Jthx10ANgrdir9jFg=; b=c
        8VkNef3khD1nmcuYxU0YMDaeIkjKmM6/dQ1C78y+R1DdGXEVzX6duY9f9yy65bA3
        QOUsLgIYTFRK6BeZHtsaGnbIfMrbuj2MTtnYD581VSqcMqWhbWi987VHOObzcj0X
        HAFs0yNmqKS+PyjNUrFVRImSH7YijYlkhjQxiVfAJdQAIfak+fgTPOld9HvQRslS
        DrhMip0HfOkbDDxT0yph/t1khcHD1T54Ig/FgB6bEacwYruzxtwg4p7Sm3r/KdlK
        qHOJVKNf2/f3UeJGcPIwbPre+PowOUphnziy/uP7DUWSKRZrCPYrrIMUrHn7F48P
        mD9vL4W1riC3oXA1/+qVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685857508; x=1685943908; bh=8
        Dgw6YabWHeE3yFvx/mYzF63i5Jthx10ANgrdir9jFg=; b=rUWG8i8nOUhPylllv
        5T9v78GAfyD+Pt8BFDUwCMaTvVnwD9GghX03WFuysDoa69Ql1KHd7Ogpk18kyWvj
        az0EUW3TFPzfT9rmS6aFuTmdutWE/nheL9jrAgSkG2ovt9A2X/GGf2bh7Hqr5eVB
        7rbm2ogery0tw1DAmmJo1YIl7kFLue2+lq3eNVl0kCvUkX+5JEQvBHHw0dZ3batz
        BpROmzHieiaSq8v+TX3tgu5WX1qNPGEScG3qOlbgeyG6pIV7ccIbg4C98fBK+1A1
        vmkGtFxR4KbTtS1W6jAwTu7ki7yte6te9w8GE6OuaLAu9qhcuIvxcxLQcPAuhQmp
        qrOcg==
X-ME-Sender: <xms:5CR8ZNa76eQXyIUT9e-QFrRKS5dBZkZlJY4Rb-E7fxgktQ3SHd9KpQ>
    <xme:5CR8ZEZahXvfClBKdkx1dYVgLqw_8AqidF0rT8Pc5ANnH9r1TYC98_WDEzZDMMsGO
    lHOOeXM5C1No1IJ1KI>
X-ME-Received: <xmr:5CR8ZP-rykrPuokG6X8OBhujoD4q3ymkmwHk4HySpj8JP8lsyRg8NzPPTJkQNmYObEHGWQLaNO-Wg2cm2ISqOPLrFT9L1bXnlcO87rQFRhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
    ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:5CR8ZLrByeTLgT6nlWR8MkBfszt4OjUmgR1fFbIndQ2YIeXmX1N_zg>
    <xmx:5CR8ZIpcsM1osDqlGuawdNA-jI_9OcMH0t5vinWHFyM4DazF-YxXMw>
    <xmx:5CR8ZBT_WYMHSKst6EJg3VwpN60UtvDrxXT5KHRKQQ1sVMBzYhuE7w>
    <xmx:5CR8ZPSpG-p-1GtXBTBumhIiy8g5jnS5WCuZqf7wXMSqa2UgBN0m9w>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:45:07 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] firewire: ohci: release buffer for AR req/resp contexts when managed resource is released
Date:   Sun,  4 Jun 2023 14:44:51 +0900
Message-Id: <20230604054451.161076-10-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230604054451.161076-1-o-takashi@sakamocchi.jp>
References: <20230604054451.161076-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 1394 OHCI driver allocates several non-coherent DMA buffers for AR
request and response contexts. The buffers are mapped to kernel virtual
address (VMA) so that the first page locates after the last page. Even
when large payload of packet is handled crossing the boundary of buffers,
the driver operates continuously on VMA.

No kernel API is provided for this kind of mapping, while it is possible
to release the buffer when PCI device is going to be released.

This commit moves the call of release helper function to the callback
function of release resources.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 298667963538..7e88fd489741 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -677,6 +677,9 @@ static void ar_context_release(struct ar_context *ctx)
 	struct device *dev = ctx->ohci->card.device;
 	unsigned int i;
 
+	if (!ctx->buffer)
+		return;
+
 	vunmap(ctx->buffer);
 
 	for (i = 0; i < AR_BUFFERS; i++) {
@@ -3556,9 +3559,13 @@ static inline void pmac_ohci_off(struct pci_dev *dev) {}
 static void release_ohci(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
 
 	pmac_ohci_off(pdev);
 
+	ar_context_release(&ohci->ar_response_ctx);
+	ar_context_release(&ohci->ar_request_ctx);
+
 	dev_notice(dev, "removed fw-ohci device\n");
 }
 
@@ -3643,17 +3650,17 @@ static int pci_probe(struct pci_dev *dev,
 	err = ar_context_init(&ohci->ar_response_ctx, ohci, PAGE_SIZE/4,
 			      OHCI1394_AsRspRcvContextControlSet);
 	if (err < 0)
-		goto fail_arreq_ctx;
+		return err;
 
 	err = context_init(&ohci->at_request_ctx, ohci,
 			   OHCI1394_AsReqTrContextControlSet, handle_at_packet);
 	if (err < 0)
-		goto fail_arrsp_ctx;
+		return err;
 
 	err = context_init(&ohci->at_response_ctx, ohci,
 			   OHCI1394_AsRspTrContextControlSet, handle_at_packet);
 	if (err < 0)
-		goto fail_arrsp_ctx;
+		return err;
 
 	reg_write(ohci, OHCI1394_IsoRecvIntMaskSet, ~0);
 	ohci->ir_context_channels = ~0ULL;
@@ -3663,10 +3670,8 @@ static int pci_probe(struct pci_dev *dev,
 	ohci->n_ir = hweight32(ohci->ir_context_mask);
 	size = sizeof(struct iso_context) * ohci->n_ir;
 	ohci->ir_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
-	if (!ohci->ir_context_list) {
-		err = -ENOMEM;
-		goto fail_arrsp_ctx;
-	}
+	if (!ohci->ir_context_list)
+		return -ENOMEM;
 
 	reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, ~0);
 	ohci->it_context_support = reg_read(ohci, OHCI1394_IsoXmitIntMaskSet);
@@ -3680,10 +3685,8 @@ static int pci_probe(struct pci_dev *dev,
 	ohci->n_it = hweight32(ohci->it_context_mask);
 	size = sizeof(struct iso_context) * ohci->n_it;
 	ohci->it_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
-	if (!ohci->it_context_list) {
-		err = -ENOMEM;
-		goto fail_arrsp_ctx;
-	}
+	if (!ohci->it_context_list)
+		return -ENOMEM;
 
 	ohci->self_id     = ohci->misc_buffer     + PAGE_SIZE/2;
 	ohci->self_id_bus = ohci->misc_buffer_bus + PAGE_SIZE/2;
@@ -3720,10 +3723,6 @@ static int pci_probe(struct pci_dev *dev,
 
  fail_msi:
 	pci_disable_msi(dev);
- fail_arrsp_ctx:
-	ar_context_release(&ohci->ar_response_ctx);
- fail_arreq_ctx:
-	ar_context_release(&ohci->ar_request_ctx);
 
 	return err;
 }
@@ -3750,8 +3749,6 @@ static void pci_remove(struct pci_dev *dev)
 
 	software_reset(ohci);
 
-	ar_context_release(&ohci->ar_request_ctx);
-	ar_context_release(&ohci->ar_response_ctx);
 	pci_disable_msi(dev);
 
 	dev_notice(&dev->dev, "removing fw-ohci device\n");
-- 
2.39.2

