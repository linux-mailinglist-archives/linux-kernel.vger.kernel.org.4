Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04CC7214E4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjFDFpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjFDFpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED17CE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:44:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E90245C0108;
        Sun,  4 Jun 2023 01:44:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 04 Jun 2023 01:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685857497; x=
        1685943897; bh=JB7K4eidj7H1KpxfnC6amlDwCbgE0URtV74lvVmVyE0=; b=Q
        kP7H19xJnIgyVj44WdEVh/W48SS/7U4wOy13xD+fw0ipdjZ3Lm44pZK4ZwrSiJQA
        b6VEyBL9JYFKwNXtOpmpSzEXcFjadgBtOcZTON7R8noC3eMQsYXYnzAa9SijWiDQ
        GujbnoyreZLoBKxS0B/UejA2fIQn3Td48PZf1dTLvsS64G+wB9pnC5jWw1gb/OL7
        29W4zvSEC3rMf4DNa8TEevjHvOyauK4HYcNbVQaD3/Dex8dHA3S9eDtI0ySGBqSJ
        ZC0DYgZRBK6j/LMCqIIjF5brQsEEiCFORjZaN1fr8xjgh22rBlgtlaBc9srvu6As
        gZEOzyZR2Kn9Bdi40M40A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685857497; x=1685943897; bh=J
        B7K4eidj7H1KpxfnC6amlDwCbgE0URtV74lvVmVyE0=; b=m507attTArW1hSN37
        3IFOIT2dhJH/7ohUHGHeD1KsxgIlBbKiEmAukzITKhmgIeJBYxkvhNm25RwEYjXu
        5ogvxAvVJfXiy1wRNZeu3WC3g3Nvt11G4i8+nZVjQ+cn6gJvMaJ8nf1/Y9vOqkBN
        kuhg7EqpbglPeccNeW1aj+2gWaSW69ZL5phn4cxQspx1pX17U6E1dr856DAl/+SC
        +HZExs++6ocflj5nkSOoePrKZedzosr4115dZ3XKrkXdGLyTAiCLve4m7vSmNSAr
        rp+oWEgEzqIfSZVMkKaohYp9mP3WvNQN/w/ts73g6j4QIs5LT4g+piZku499Ne0w
        Hhgwg==
X-ME-Sender: <xms:2SR8ZFTzu2ii0RxPfkVkQH3Mjh4UvNaAzvpw2ID4tzpo6BJy3RHxYA>
    <xme:2SR8ZOwuCuYkeozkGXnUmQgHDKz0_enHyCsJCuHFRxb4ON4uGa7GREuvJa36utl3h
    9_jCQ_aNh6vqOSqdms>
X-ME-Received: <xmr:2SR8ZK1abvlwMYwZOoZQLIrFO1n8T2s1wYecCJQd56r2HmIygv9hH_zHnE_t_95M4u16NtOyWQkR5pFDo0yFQPygnPpfurx-YULemvsPUZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
    ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2SR8ZNB10zvpIP60zGZxQGJrXbCaADwOJWXiH0781Ycq7LnIIi_yQw>
    <xmx:2SR8ZOjN5awH1OLhiXk7XYWbiKJw-eWT2kwZn4M42P_b_UW0yjWN0g>
    <xmx:2SR8ZBq4nZe9KM8pTbd6XEBWGXmoQsk9Oqe7uuSZB4_M3nAn94AkvQ>
    <xmx:2SR8ZGJA2WfHvYozHMmyxw7iOGlJIlGrc7Tpf6-5caTjCsnJkWsRyA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:44:56 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] firewire: ohci: use devres for memory object of ohci structure
Date:   Sun,  4 Jun 2023 14:44:43 +0900
Message-Id: <20230604054451.161076-2-o-takashi@sakamocchi.jp>
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

The managed device resource (devres) framework is convenient to maintain
lifetime of allocated memory object for device.

This commit utilizes the framework for the object of ohci structure. The
extra operation for power management is required in Apple PowerMac based
machines, thus release callback is assigned to the object to call the
operation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 06386c3b7f03..2b02cebcb0ae 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3557,6 +3557,15 @@ static inline void pmac_ohci_on(struct pci_dev *dev) {}
 static inline void pmac_ohci_off(struct pci_dev *dev) {}
 #endif /* CONFIG_PPC_PMAC */
 
+static void release_ohci(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	pmac_ohci_off(pdev);
+
+	dev_notice(dev, "removed fw-ohci device\n");
+}
+
 static int pci_probe(struct pci_dev *dev,
 			       const struct pci_device_id *ent)
 {
@@ -3571,25 +3580,22 @@ static int pci_probe(struct pci_dev *dev,
 		return -ENOSYS;
 	}
 
-	ohci = kzalloc(sizeof(*ohci), GFP_KERNEL);
-	if (ohci == NULL) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
+	ohci = devres_alloc(release_ohci, sizeof(*ohci), GFP_KERNEL);
+	if (ohci == NULL)
+		return -ENOMEM;
 	fw_card_initialize(&ohci->card, &ohci_driver, &dev->dev);
-
+	pci_set_drvdata(dev, ohci);
 	pmac_ohci_on(dev);
+	devres_add(&dev->dev, ohci);
 
 	err = pci_enable_device(dev);
 	if (err) {
 		dev_err(&dev->dev, "failed to enable OHCI hardware\n");
-		goto fail_free;
+		return err;
 	}
 
 	pci_set_master(dev);
 	pci_write_config_dword(dev, OHCI1394_PCI_HCI_Control, 0);
-	pci_set_drvdata(dev, ohci);
 
 	spin_lock_init(&ohci->lock);
 	mutex_init(&ohci->phy_reg_mutex);
@@ -3748,10 +3754,7 @@ static int pci_probe(struct pci_dev *dev,
 	pci_release_region(dev, 0);
  fail_disable:
 	pci_disable_device(dev);
- fail_free:
-	kfree(ohci);
-	pmac_ohci_off(dev);
- fail:
+
 	return err;
 }
 
@@ -3796,10 +3799,8 @@ static void pci_remove(struct pci_dev *dev)
 	pci_iounmap(dev, ohci->registers);
 	pci_release_region(dev, 0);
 	pci_disable_device(dev);
-	kfree(ohci);
-	pmac_ohci_off(dev);
 
-	dev_notice(&dev->dev, "removed fw-ohci device\n");
+	dev_notice(&dev->dev, "removing fw-ohci device\n");
 }
 
 #ifdef CONFIG_PM
-- 
2.39.2

