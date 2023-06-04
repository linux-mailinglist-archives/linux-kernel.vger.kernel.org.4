Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1887214F7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjFDFpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjFDFpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC09FD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:45:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 180145C011C;
        Sun,  4 Jun 2023 01:45:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 04 Jun 2023 01:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685857507; x=
        1685943907; bh=JXJ2NslYvRvgyn5YNav5urVf+K2fXWuI2M0Mevtt7tE=; b=I
        ScD5GIrWiztYox8MM7twV5QDUCP8m7sHLqt9ppAGB3Iirq9eNw7GtczB5aLwpYiM
        Ny2xTcx9WU3uFsuK/HpX1xKbxKoNA2RoZjhsw6UqNfJgFQwRYgww3scsz2ci5ZD1
        1KwlkD8vcDHo6q0dMsR6eiXSeN2EJaWWPQE9KpVGiALasMYokMWlsw/0HhdVvZ+i
        d9ZCasfLMwM30UwaYaM8jmuxjzZLasISUON6KC/bSO5pcTvmRXWutf60Fer4eZdq
        gYAi59KstK54vrMg27bfw61PY8WS5LFvy+L2ghvN1Ux6AgGRinkJS6NVC7rNX6JP
        VZtAzdOlywrPgIWopjbfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685857507; x=1685943907; bh=J
        XJ2NslYvRvgyn5YNav5urVf+K2fXWuI2M0Mevtt7tE=; b=hswlGVHWgKOEG9WNF
        19pfyFY2rDxvHhAf/w2EqJmzdl3EAncc8p0SXXw8mCJu79O24N3EgwTnHjSts1CV
        VW7E5Uv0BlJR2YOv6wZzbboS941eCdypicIV17KXtxWVj6QuikOhRa+357teFSSy
        8OjaCU1TNIQGhEo7lfITARLncXDvqF8Y3yvUTkbojZ3gKbr7INu8EbKYgG1HBnzZ
        JPww3gnssE3ASb2IWwPpqAULqosKvNqSkqgoXZVg1eFrzd6qsl3Z3MKdF9YLlAQ3
        csYg6s+l6zMRZZejRkmnhmEWf7XOdyTt2DvUSTxrlv4iyyv+dW+gb7VdCWyJAYNQ
        oi5zw==
X-ME-Sender: <xms:4iR8ZCR_A39O_PvmrLRnwmvJkIF68WBOlqBgmC2Y3qeXUvfYYS00rw>
    <xme:4iR8ZHyW3e3MCREa64jojZxQ5-PHyGbLeq1qDDE88-_XKq4LfCHNIvsp2T2opVmmx
    8czF0tK06kW0MKPfSo>
X-ME-Received: <xmr:4iR8ZP3SPJZUndLz6zMdsbB9jp_Fykd3Hs5bcaY_RjwTrK8cHUKeypGRMIz-VfXWvo0Ih9drubazi5_7F0CXDPoH7dk1WJ-zXJVQ-QhJHF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
    ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:4iR8ZOCPlMm9ZBAN5JEy7aAz6OPxuGa9VpmMK8YT4EfXb7ykRfxKlg>
    <xmx:4iR8ZLhGSGwuOLCu-i9hbkNKLQXRUX7T7fMENm0xJ-TSgfBs_EWspQ>
    <xmx:4iR8ZKoI1kzpt5GoC8xYAGIFZvuZSY73y9cTrPIMa7KkZUqZpPHDVQ>
    <xmx:4yR8ZLJywO6vjFUkQXOmrobD506JzFWW6Lcoa9xX4TSQoYqb4HGaVA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:45:05 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] firewire: ohci: use devres for content of configuration ROM
Date:   Sun,  4 Jun 2023 14:44:50 +0900
Message-Id: <20230604054451.161076-9-o-takashi@sakamocchi.jp>
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

The 1394 OHCI driver allocates DMA coherent buffer to transfer content
of configuration ROM.

This commit utilizes managed device resource to maintain the lifetime of
buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 21eb13ea4dad..298667963538 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2052,8 +2052,7 @@ static void bus_reset_work(struct work_struct *work)
 	spin_unlock_irq(&ohci->lock);
 
 	if (free_rom)
-		dma_free_coherent(ohci->card.device, CONFIG_ROM_SIZE,
-				  free_rom, free_rom_bus);
+		dmam_free_coherent(ohci->card.device, CONFIG_ROM_SIZE, free_rom, free_rom_bus);
 
 	log_selfids(ohci, generation, self_id_count);
 
@@ -2385,10 +2384,8 @@ static int ohci_enable(struct fw_card *card,
 	 */
 
 	if (config_rom) {
-		ohci->next_config_rom =
-			dma_alloc_coherent(ohci->card.device, CONFIG_ROM_SIZE,
-					   &ohci->next_config_rom_bus,
-					   GFP_KERNEL);
+		ohci->next_config_rom = dmam_alloc_coherent(ohci->card.device, CONFIG_ROM_SIZE,
+							    &ohci->next_config_rom_bus, GFP_KERNEL);
 		if (ohci->next_config_rom == NULL)
 			return -ENOMEM;
 
@@ -2480,9 +2477,8 @@ static int ohci_set_config_rom(struct fw_card *card,
 	 * ohci->next_config_rom to NULL (see bus_reset_work).
 	 */
 
-	next_config_rom =
-		dma_alloc_coherent(ohci->card.device, CONFIG_ROM_SIZE,
-				   &next_config_rom_bus, GFP_KERNEL);
+	next_config_rom = dmam_alloc_coherent(ohci->card.device, CONFIG_ROM_SIZE,
+					      &next_config_rom_bus, GFP_KERNEL);
 	if (next_config_rom == NULL)
 		return -ENOMEM;
 
@@ -2515,9 +2511,10 @@ static int ohci_set_config_rom(struct fw_card *card,
 	spin_unlock_irq(&ohci->lock);
 
 	/* If we didn't use the DMA allocation, delete it. */
-	if (next_config_rom != NULL)
-		dma_free_coherent(ohci->card.device, CONFIG_ROM_SIZE,
-				  next_config_rom, next_config_rom_bus);
+	if (next_config_rom != NULL) {
+		dmam_free_coherent(ohci->card.device, CONFIG_ROM_SIZE, next_config_rom,
+				   next_config_rom_bus);
+	}
 
 	/*
 	 * Now initiate a bus reset to have the changes take
@@ -3753,12 +3750,6 @@ static void pci_remove(struct pci_dev *dev)
 
 	software_reset(ohci);
 
-	if (ohci->next_config_rom && ohci->next_config_rom != ohci->config_rom)
-		dma_free_coherent(ohci->card.device, CONFIG_ROM_SIZE,
-				  ohci->next_config_rom, ohci->next_config_rom_bus);
-	if (ohci->config_rom)
-		dma_free_coherent(ohci->card.device, CONFIG_ROM_SIZE,
-				  ohci->config_rom, ohci->config_rom_bus);
 	ar_context_release(&ohci->ar_request_ctx);
 	ar_context_release(&ohci->ar_response_ctx);
 	pci_disable_msi(dev);
-- 
2.39.2

