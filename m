Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B527214E8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjFDFpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjFDFpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7172ECE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:45:02 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DE92D5C010D;
        Sun,  4 Jun 2023 01:45:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 04 Jun 2023 01:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685857501; x=
        1685943901; bh=7jRIqu3WK9pbTJJNWXwjuu5GtvOIZ4uZ8MriEr/wEx4=; b=k
        u1d6ors0EbpVI5FlR5rTVFzpqJu6LMsMdlTg77PoSIDlXFHX5O0ItTui1zv1qmmv
        J12EqYAdnJ1b2xdfEetGnPPC0P42gASKH5SC15VSKU+32lKQ12qM4ZGpf6rKhdEd
        q/Vk8wNw/ZUqYakRdksyFRuYU7ZHI+XYBi7R19Vt91urwXDjTGHRIBqJJObtnSF1
        MTkIY03DfXgNwH8TXE4ta4mSOau8XlXZqkUpUW7W7M52+OIMOv5Eo0LQKSGo3Y8f
        uJNqo+8S0pVqvh0kYN7VfuayZ7D/5xJ6JfoVz4Hv4l05QSivyClPpQ/At8nDo/CM
        lod4F2prGnST55PUlQcHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685857501; x=1685943901; bh=7
        jRIqu3WK9pbTJJNWXwjuu5GtvOIZ4uZ8MriEr/wEx4=; b=C3qj/yvD+wSne5+Hm
        E/Kvl8ozuJo+inh35UDu1w0/F8r8JCY/HIoEWkZ4iD6D9AusN3qV0JlxyTIb1/1p
        lH5TrqTQbuXyFRtFC3haYTctLbgOUwpF2Hijfc2SR4mHCHxu0QacTMU04J0QhIcZ
        VdoIhCCw+U7mRme8w0Awk2+BopYjIqF82iqymS8t49vUwSsycq+77rTkKoALQe4x
        hwVd5B1BOgcKMDkmP4Mjy8PSc2oDTEL7h+7oFnPNqsQ1dA/InfhVqEuhrYkvW+i7
        UxHCZixBeCTcnEkOdJnjnWtJyPBjOoMUXvAgdyH8XLa1O5trBMr4J2wcGK+OYC7U
        GFT8A==
X-ME-Sender: <xms:3SR8ZCRT4QsDcg41F_5_JAF5n1CRzRLGpyAsYWwtgVyBJIVlk5yCWA>
    <xme:3SR8ZHzayKQaNDwV18GoZYz2W3wOob2L05ro9VEGk8QqVd-bKrfh2m3_okF_G85VF
    2v0RCoeIY0vx7l5gi0>
X-ME-Received: <xmr:3SR8ZP3GgIcSzQ4abw45fCLiDnYVWwvFHlOD1iEvd5pYBQd7fpaMBY2O8aKqkdF4VHSAGWzjqwJu1mBcOEaFWgGLY8JBI0-Cr1y-PquIez0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
    ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:3SR8ZOBzu4Bw6WrTopGmKoxjePElidT8snqVULV-kjB1WhVRDqAeAw>
    <xmx:3SR8ZLhar4how0Mo-BrEaU2Ego-OKoSPhvw4Qdf92usrbc5buyqLHQ>
    <xmx:3SR8ZKqMsXDAlj3vDexp6Ylbx07eHGSyRpfzRbbSI_rA9j-CYUyPgw>
    <xmx:3SR8ZLLmDoFnFVgMgMlniK8X4o7hNxuB__rc9wjlAye1V_-qIDRRcQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:45:00 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] firewire: ohci: use devres for misc DMA buffer
Date:   Sun,  4 Jun 2023 14:44:46 +0900
Message-Id: <20230604054451.161076-5-o-takashi@sakamocchi.jp>
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

The 1394 OHCI driver allocates a DMA coherent buffer for multi-purposes.
The buffer is split into three region for specific purposes; i.e. 1/4 for
context descriptors of AR request and response as well as 1/2 for self
ID handling.

This commit uses managed device resource to maintain the lifetime of
buffer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 26c64b60144d..3b31d90781fe 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3634,17 +3634,15 @@ static int pci_probe(struct pci_dev *dev,
 	 */
 	BUILD_BUG_ON(AR_BUFFERS * sizeof(struct descriptor) > PAGE_SIZE/4);
 	BUILD_BUG_ON(SELF_ID_BUF_SIZE > PAGE_SIZE/2);
-	ohci->misc_buffer = dma_alloc_coherent(ohci->card.device,
-					       PAGE_SIZE,
-					       &ohci->misc_buffer_bus,
-					       GFP_KERNEL);
+	ohci->misc_buffer = dmam_alloc_coherent(&dev->dev, PAGE_SIZE, &ohci->misc_buffer_bus,
+						GFP_KERNEL);
 	if (!ohci->misc_buffer)
 		return -ENOMEM;
 
 	err = ar_context_init(&ohci->ar_request_ctx, ohci, 0,
 			      OHCI1394_AsReqRcvContextControlSet);
 	if (err < 0)
-		goto fail_misc_buf;
+		return err;
 
 	err = ar_context_init(&ohci->ar_response_ctx, ohci, PAGE_SIZE/4,
 			      OHCI1394_AsRspRcvContextControlSet);
@@ -3736,9 +3734,6 @@ static int pci_probe(struct pci_dev *dev,
 	ar_context_release(&ohci->ar_response_ctx);
  fail_arreq_ctx:
 	ar_context_release(&ohci->ar_request_ctx);
- fail_misc_buf:
-	dma_free_coherent(ohci->card.device, PAGE_SIZE,
-			  ohci->misc_buffer, ohci->misc_buffer_bus);
 
 	return err;
 }
@@ -3774,8 +3769,6 @@ static void pci_remove(struct pci_dev *dev)
 				  ohci->config_rom, ohci->config_rom_bus);
 	ar_context_release(&ohci->ar_request_ctx);
 	ar_context_release(&ohci->ar_response_ctx);
-	dma_free_coherent(ohci->card.device, PAGE_SIZE,
-			  ohci->misc_buffer, ohci->misc_buffer_bus);
 	context_release(&ohci->at_request_ctx);
 	context_release(&ohci->at_response_ctx);
 	kfree(ohci->it_context_list);
-- 
2.39.2

