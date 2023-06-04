Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2CD7214E9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjFDFpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFDFpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:04 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0024CE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:45:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CDF75C010B;
        Sun,  4 Jun 2023 01:45:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 04 Jun 2023 01:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685857503; x=
        1685943903; bh=+SNfvwUr3HkWtVX9bEAgYqWbf/gfUOCX+tboiD/Fg6E=; b=U
        BKnq3yjaySl29OZGcuVREvQa7DIsvzGjsohKjledhFIpHuB+S1t0tmGcbSXr5cuT
        U0BrjF+Ul6dNeuxKnY1NPpFWcDkOd0mfFt65ZYmcWCnIsg6AAjgnmgesb51knJv4
        SXP6lmhR3DlSHSJHNng37Fw8vbS5W57BUjifNR4gTfQtSdbM/dvBYLmoNuNFHYzV
        XeQ50z6xFcLtUZ9wyqsDzqTdwqMq9jJGBkVpOrc8QteyIE1URHXbZXcbrw+kXye7
        ZqS71cW8lEMieirU/yTGTYFR1kaiIU+vVpVbE/UMhEY/DTqAlsFHQ3C7DsORiQnV
        RM1HsbK7ea9dMSEt3xuQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685857503; x=1685943903; bh=+
        SNfvwUr3HkWtVX9bEAgYqWbf/gfUOCX+tboiD/Fg6E=; b=LNqi2PjRROO7RKxpJ
        yHd/hNIAkT+GCDHleqUSADoh+fg7o4h5WP74eC3oDRYG6EKfYBYnKZz3AcP//k+n
        j/0UdvBVPPHmeh4n/DsW+McNVTukQF02fP5CLtcrWNJS/yC0ek3oYgg1roeK3FYI
        ScXei7pSOIH3aNPynV5xtJtn+/xyMb0oRp4KYJlagg05VcJnymaeC+5AakUjh5YA
        Cvd6c2STF1wAOwgAlYz9Tq1NxhIkZAvYn3ymlOEl7HmSUXaJNkWZnONR+zq3N+fC
        2Z1u0CaGCD/vh+mK8Qn6AgF4F7vhMUGGcxW3VqYGxu30zKFXMITm5boEgiOpTo8c
        LtcWQ==
X-ME-Sender: <xms:3yR8ZIiKIX02ThH__93_mW-jqro3tbwYbC7Nck870qugw4Yzi6Dv9g>
    <xme:3yR8ZBBIFFfOcaHiY0NmgJ94aegwr_e4XSnccksuvoTU--D-F1i095NiwBQGowpXc
    CJHbuVR2RCCwFl_QrU>
X-ME-Received: <xmr:3yR8ZAFngZJSnQ8drCD-Tb3ROajvjy0TBUNgnr6a6HSRZbDWo5Z7Fe21Nhjm-qkJXajteJ5suxUyUaTJsI-bOUO3ewO6ioo04t-bJIt2pdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevfefffe
    ektefgveegfeelheffhfeujedtjeevtefhkeevkedtjeejvddtjefhjeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:3yR8ZJQtc7t4CAgPtQPjggMx6VafvIJVimbkMJbiTHBCPKoGrUMZoQ>
    <xmx:3yR8ZFwkseMtEY8ak5MUXRUhiWFmDrdXgVNuwqkEv2l2Obg6fMkfCA>
    <xmx:3yR8ZH6_zeYEgrLUwBR0nbF86znG9F9opNo8XENOYX3ZKmq7G_D9dw>
    <xmx:3yR8ZDYDGuzKLkrOxr9ScSx7K0aLFQ_kDOY9OQM2r0TsLAdvqwxplA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:45:02 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] firewire: ohci: use devres for requested IRQ
Date:   Sun,  4 Jun 2023 14:44:47 +0900
Message-Id: <20230604054451.161076-6-o-takashi@sakamocchi.jp>
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

The 1394 OHCI controller register handler to single interrupt number.

This commit uses managed device resource to maintain the lifetime of
requested IRQ.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 3b31d90781fe..cb6b43e3f67e 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3697,17 +3697,16 @@ static int pci_probe(struct pci_dev *dev,
 
 	if (!(ohci->quirks & QUIRK_NO_MSI))
 		pci_enable_msi(dev);
-	if (request_irq(dev->irq, irq_handler,
-			pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED,
-			ohci_driver_name, ohci)) {
+	err = devm_request_irq(&dev->dev, dev->irq, irq_handler,
+			       pci_dev_msi_enabled(dev) ? 0 : IRQF_SHARED, ohci_driver_name, ohci);
+	if (err < 0) {
 		ohci_err(ohci, "failed to allocate interrupt %d\n", dev->irq);
-		err = -EIO;
 		goto fail_msi;
 	}
 
 	err = fw_card_add(&ohci->card, max_receive, link_speed, guid);
 	if (err)
-		goto fail_irq;
+		goto fail_msi;
 
 	version = reg_read(ohci, OHCI1394_Version) & 0x00ff00ff;
 	ohci_notice(ohci,
@@ -3720,8 +3719,6 @@ static int pci_probe(struct pci_dev *dev,
 
 	return 0;
 
- fail_irq:
-	free_irq(dev->irq, ohci);
  fail_msi:
 	pci_disable_msi(dev);
  fail_contexts:
@@ -3759,7 +3756,6 @@ static void pci_remove(struct pci_dev *dev)
 	 */
 
 	software_reset(ohci);
-	free_irq(dev->irq, ohci);
 
 	if (ohci->next_config_rom && ohci->next_config_rom != ohci->config_rom)
 		dma_free_coherent(ohci->card.device, CONFIG_ROM_SIZE,
-- 
2.39.2

