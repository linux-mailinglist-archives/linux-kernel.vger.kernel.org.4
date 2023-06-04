Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57E37214E7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjFDFpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFDFpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:02 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2316BE0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:45:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8F8FE5C0110;
        Sun,  4 Jun 2023 01:45:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 04 Jun 2023 01:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685857500; x=
        1685943900; bh=Sz66tRqOl7u4PP0rtKdaeKmYwO41z2vXEGUTAqF6eOk=; b=o
        89WvoV8bluHsnci8TokM/pj5qc/eiLfisRvUK4fZo2RVGYR42fpiC94IYdfd0gU9
        W1cG/Pfs1AFMYof5UTMjmfM23YMNEuv6SuHDoaN6n8cY7kJlVzb6AVgjoLuoz7VB
        lAJNbOpGnJwqTedt4JEJijVZfq+I1j6QCei4Ft1cpYw1qgzmyeg0e0ncLjijkCom
        Vrl+BXuaPCdD4SdtZWS5xxU4cGYQqnuqCVJyLqXfLDZ2b303lg6ZErlS+04crCvX
        aRl2yh86C4GiNSxX+pjsBnyM/wYgRhsoJ28oe7qAHGbLylBEk2i1JfzNIJleiFB+
        /ol7Ze39MU9wN7HWemtXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685857500; x=1685943900; bh=S
        z66tRqOl7u4PP0rtKdaeKmYwO41z2vXEGUTAqF6eOk=; b=LmCckfrTic7A+wlL1
        Zlq2lEBWP4sNyoGKP2exgaS0E1/MIxFteoSDU9q6gqZd+KaTGt/8A+XLehuSvVRr
        DK7epqbP4oBeaIBpatYiNeyZZwfWl84THx5gXv+yHalBsHILmcfkpOFzZaLbj9JC
        6Wgb2BI6Atss+5EfAxhbDHbc/n8ALZHzaKuFo22mYYC6vR/3B0DsfErI9wB997Mw
        Q5/GSrM0NSsx6PcGCFHlvfxZyyiWDNtq6EBsIQz8ib7fgNfE5axxyjTBcaEoFJJU
        cOMTouNJPnzRerNSMSA0NpHNvQs4tx67S+4Yy9YEjUTN3hzgG+ptUz95sLT8oVkI
        QhD3w==
X-ME-Sender: <xms:3CR8ZMatPDz7yyyR2nz6UaMlh5P91lsVjMejk0NhY7Fz7Ab4fAWTew>
    <xme:3CR8ZHb9c1jpNFBKhTTNk4odIYt_6mi5iuVgH3I84HCwUOFUs5JyPpb-Ueiper4EO
    HgR50aFv8CvEnyZIPk>
X-ME-Received: <xmr:3CR8ZG9HQ9Ms82cB036l6ylb9HJz6EReZP5M1EopNBqXpRfVubZt3h81At0sYhQ-HvkAqwhV0B6MNeSznSPCcbhywLm08s7LuU4fqkSEzDc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
    ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:3CR8ZGqQCsf3YoPpI6E3D8ds2z6peEiPntjXNJs8vZKFDUcmLr0pRQ>
    <xmx:3CR8ZHp9OofVVIKB9i0WoEyK6jdV6L3evfkHwlNVq99AbRoSFow_2w>
    <xmx:3CR8ZESlARquTdiWEVLMV11dSwTa1nXk1JZkelw97ogZ5WQUo_QZng>
    <xmx:3CR8ZGRDYnEicNku_yI-xuvJZZvkLQEp10xmV2_bLNm6wI8ochR2wA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:44:59 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] firewire: ohci: use devres for MMIO region mapping
Date:   Sun,  4 Jun 2023 14:44:45 +0900
Message-Id: <20230604054451.161076-4-o-takashi@sakamocchi.jp>
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

The PCI framework has the convenient helper function to check and map MMIO
region with managed device resource.

This commit elaborates 1394 OHCI driver to use the function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index f3d0882a876c..26c64b60144d 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3608,18 +3608,12 @@ static int pci_probe(struct pci_dev *dev,
 		return -ENXIO;
 	}
 
-	err = pci_request_region(dev, 0, ohci_driver_name);
+	err = pcim_iomap_regions(dev, 1 << 0, ohci_driver_name);
 	if (err) {
-		ohci_err(ohci, "MMIO resource unavailable\n");
-		return err;
-	}
-
-	ohci->registers = pci_iomap(dev, 0, OHCI1394_REGISTER_SIZE);
-	if (ohci->registers == NULL) {
-		ohci_err(ohci, "failed to remap registers\n");
-		err = -ENXIO;
-		goto fail_iomem;
+		ohci_err(ohci, "request and map MMIO resource unavailable\n");
+		return -ENXIO;
 	}
+	ohci->registers = pcim_iomap_table(dev)[0];
 
 	for (i = 0; i < ARRAY_SIZE(ohci_quirks); i++)
 		if ((ohci_quirks[i].vendor == dev->vendor) &&
@@ -3644,10 +3638,8 @@ static int pci_probe(struct pci_dev *dev,
 					       PAGE_SIZE,
 					       &ohci->misc_buffer_bus,
 					       GFP_KERNEL);
-	if (!ohci->misc_buffer) {
-		err = -ENOMEM;
-		goto fail_iounmap;
-	}
+	if (!ohci->misc_buffer)
+		return -ENOMEM;
 
 	err = ar_context_init(&ohci->ar_request_ctx, ohci, 0,
 			      OHCI1394_AsReqRcvContextControlSet);
@@ -3747,10 +3739,6 @@ static int pci_probe(struct pci_dev *dev,
  fail_misc_buf:
 	dma_free_coherent(ohci->card.device, PAGE_SIZE,
 			  ohci->misc_buffer, ohci->misc_buffer_bus);
- fail_iounmap:
-	pci_iounmap(dev, ohci->registers);
- fail_iomem:
-	pci_release_region(dev, 0);
 
 	return err;
 }
@@ -3793,8 +3781,6 @@ static void pci_remove(struct pci_dev *dev)
 	kfree(ohci->it_context_list);
 	kfree(ohci->ir_context_list);
 	pci_disable_msi(dev);
-	pci_iounmap(dev, ohci->registers);
-	pci_release_region(dev, 0);
 
 	dev_notice(&dev->dev, "removing fw-ohci device\n");
 }
-- 
2.39.2

