Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25B7214F0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjFDFpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFDFpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:07 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B9AE1
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:45:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BEDDC5C0115;
        Sun,  4 Jun 2023 01:45:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 04 Jun 2023 01:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685857505; x=
        1685943905; bh=yKzOsoG8xy2knPDZZ291nFvnf2PQCsND9mtXsk0fr2Y=; b=f
        uFVAxM25bqj3Ds6KmaGZfcKXCBwT8mpA6dp+saiduhBzHF83rSROBQ8CyfecGOjX
        S96DDx9wJX6tNHZGzduHeHwr/TmWza+CSKoht6pa3WHwg7SfhCZtvk2C+ZmPqkj2
        gm/xs1bgWp8M3xFi6DKhKn1v2SrmijDhaEzSphuZAMXixu/FSN1ctNYZe6srm8dX
        bvuQYXhSNn4gnGx+LA6NfZEwu21nuxRaEafb6QPox2qQ6ja3g+K+ECRD0wrABVOW
        cdZ8/735DWgg40ypU5RyNWfQdrlQIV/pIo+JP/0xbN6qkz7QKkWi355LgzyuIdp+
        atCnUKuGJT1OEfv35tNaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685857505; x=1685943905; bh=y
        KzOsoG8xy2knPDZZ291nFvnf2PQCsND9mtXsk0fr2Y=; b=wFL0zxvE79MqrhgcR
        GIol5duV+8ZAfStb6QzsH2XqKvAPr2gRFXPiwzQh1fGowYN4OYNs15j8Q0+UGAWg
        5+9DEU6pGoGcwo8RL/3wHhSjJHiEGKItul9/u5EYBByBX2gLX5Wi3ev6NKb6Qiec
        GiTIxeGGf/0fIzdVknxElNsUC3nuib7O75MO9sS+WuNnPP1AoCmZO4eEXaUPsczk
        2/pwUuyGBqrnOyvX3ZnlzWSTM2xA6OjgsAnEscnY6WMbIUC5RzrxI3mZzl/I+F4q
        AFqMFSqar0zzi8mD5uaSMv5RTCIT5P1UKq3YWzpTRcmrxclXiYJ6xvQaJP+WI/dF
        +pFtA==
X-ME-Sender: <xms:4SR8ZD04_zOtddzSHXc4ivYOhCxHrK9theEm8TBqzAtamrF8wrrkZg>
    <xme:4SR8ZCHcY3aTcyFBIUdi-HkWJAmcdgmpU63Cmt5gnoyC3T2kEHvbkqmO-a0A7Ipmn
    BFr44G6FSVDkx83hDo>
X-ME-Received: <xmr:4SR8ZD64FqQvogYMSqzuYnEc4h86ZdN9Z4364gPX5e2l8Ysp2ltWDFGfHic9BqJl38i7KtuBawCE38pFwfOddFvUE4kKw9xNp_yhSgqaYYc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
    ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:4SR8ZI2SPynFl0pX4qAoQWADgVO8IxI3Et4zU7j7EbrT_03nEXcV5g>
    <xmx:4SR8ZGHY-0nkpJR7S68bLnEnjVYsj_6tH34v8_Sydc1ADSdq-L2I5g>
    <xmx:4SR8ZJ_j9NyLPhsdX3q15LKx18K7vollYBE_aUkJd9ryrDa1PqVtjw>
    <xmx:4SR8ZBNfn47l-CIJLxKjIwoXn-imOXoXXzbumdGOzY7bimZjCQIXFQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:45:04 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] firewire: ohci: use devres for IT, IR, AT/receive, and AT/request contexts
Date:   Sun,  4 Jun 2023 14:44:49 +0900
Message-Id: <20230604054451.161076-8-o-takashi@sakamocchi.jp>
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

The 1394 OHCI driver allocates DMA coherent buffer for descriptors of IT,
IR, AT receive, and AT request contexts by the same way.

This commit utilizes managed device resource to maintain the lifetime of
buffers.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 086505bd1729..21eb13ea4dad 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1105,8 +1105,7 @@ static int context_add_buffer(struct context *ctx)
 	if (ctx->total_allocation >= 16*1024*1024)
 		return -ENOMEM;
 
-	desc = dma_alloc_coherent(ctx->ohci->card.device, PAGE_SIZE,
-			&bus_addr, GFP_ATOMIC);
+	desc = dmam_alloc_coherent(ctx->ohci->card.device, PAGE_SIZE, &bus_addr, GFP_ATOMIC);
 	if (!desc)
 		return -ENOMEM;
 
@@ -1165,10 +1164,10 @@ static void context_release(struct context *ctx)
 	struct fw_card *card = &ctx->ohci->card;
 	struct descriptor_buffer *desc, *tmp;
 
-	list_for_each_entry_safe(desc, tmp, &ctx->buffer_list, list)
-		dma_free_coherent(card->device, PAGE_SIZE, desc,
-			desc->buffer_bus -
-			((void *)&desc->buffer - (void *)desc));
+	list_for_each_entry_safe(desc, tmp, &ctx->buffer_list, list) {
+		dmam_free_coherent(card->device, PAGE_SIZE, desc,
+				   desc->buffer_bus - ((void *)&desc->buffer - (void *)desc));
+	}
 }
 
 /* Must be called with ohci->lock held */
@@ -3657,7 +3656,7 @@ static int pci_probe(struct pci_dev *dev,
 	err = context_init(&ohci->at_response_ctx, ohci,
 			   OHCI1394_AsRspTrContextControlSet, handle_at_packet);
 	if (err < 0)
-		goto fail_atreq_ctx;
+		goto fail_arrsp_ctx;
 
 	reg_write(ohci, OHCI1394_IsoRecvIntMaskSet, ~0);
 	ohci->ir_context_channels = ~0ULL;
@@ -3669,7 +3668,7 @@ static int pci_probe(struct pci_dev *dev,
 	ohci->ir_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
 	if (!ohci->ir_context_list) {
 		err = -ENOMEM;
-		goto fail_atresp_ctx;
+		goto fail_arrsp_ctx;
 	}
 
 	reg_write(ohci, OHCI1394_IsoXmitIntMaskSet, ~0);
@@ -3686,7 +3685,7 @@ static int pci_probe(struct pci_dev *dev,
 	ohci->it_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
 	if (!ohci->it_context_list) {
 		err = -ENOMEM;
-		goto fail_atresp_ctx;
+		goto fail_arrsp_ctx;
 	}
 
 	ohci->self_id     = ohci->misc_buffer     + PAGE_SIZE/2;
@@ -3724,10 +3723,6 @@ static int pci_probe(struct pci_dev *dev,
 
  fail_msi:
 	pci_disable_msi(dev);
- fail_atresp_ctx:
-	context_release(&ohci->at_response_ctx);
- fail_atreq_ctx:
-	context_release(&ohci->at_request_ctx);
  fail_arrsp_ctx:
 	ar_context_release(&ohci->ar_response_ctx);
  fail_arreq_ctx:
@@ -3766,8 +3761,6 @@ static void pci_remove(struct pci_dev *dev)
 				  ohci->config_rom, ohci->config_rom_bus);
 	ar_context_release(&ohci->ar_request_ctx);
 	ar_context_release(&ohci->ar_response_ctx);
-	context_release(&ohci->at_request_ctx);
-	context_release(&ohci->at_response_ctx);
 	pci_disable_msi(dev);
 
 	dev_notice(&dev->dev, "removing fw-ohci device\n");
-- 
2.39.2

