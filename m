Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B76962F9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242145AbiKRPtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiKRPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:49:50 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F098B100
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:49:49 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 96280320029B;
        Fri, 18 Nov 2022 10:49:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 18 Nov 2022 10:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1668786586; x=1668872986; bh=KqQEuKxfkbRxTU5nDAZWsBYliBRDq3obTAX
        NYs/tvIE=; b=LHwyay5CtX5MpoR1iLOr8PAfRyE37G7z4XYVAbrRIz/WZCIn+av
        5/sb3jQ1GeRJCdrrEV+LYGsuzghXdL2mgSL4HE+w6deMaPZES3L96l7GlPN6Qa/F
        3i2X84FaMkaqd8uJRPosVDOsmpl5Pq6scuPW3M8dRp9LujqbpbbSZYJZH6hsFrKa
        xQzWB9gi7aUbWQppWD4f1t1zp6YFMBUtqFJ1lmJdNEIo0/HSq7O51sB62pJCxHkm
        oZEq0TDSUN/p/NYXHJ2l2fI7c6jbmRfmqke20ho4CnaDDdrDx8OuPDJ79T8EX2vy
        I/k4V8i7soF8+CgSZ5QzuI0PHvNCbKf2+yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668786586; x=1668872986; bh=KqQEuKxfkbRxT
        U5nDAZWsBYliBRDq3obTAXNYs/tvIE=; b=lYaJGjVJkv/Wx0CHAk/JR4cjQZOi8
        ouePFaQuyM0eTxEQjeiCLnUtNWgYs5+tzUfaWbpZwTJy/D/Z9LlaGQgpgUhqGWzP
        c+4D5zANcspwHF1gf7yR8XN5UUWe/XlEeQUDkFseLC8XmaWBcHRYui660Xs/Ydy1
        IE2JegSQWUOV7ZEuj+0Nf+pk8ItWH24ZVCPgPt1r5cHg/x7QAuMNbMfEq8XToY7d
        45S9WBa06KZPxdkokEmhOizI+g3xqr+R7DXTA3kS+3gnLCCR4wOWrM78FBfbcbMY
        YXtn+wkFDsvgUEiZrTd06LeDj4tQw78rR+OkiV1R/B/yKlKLFQ6H4lHiA==
X-ME-Sender: <xms:mal3Y5h2s0SAIu7AYYR2Ljk8Nkk2qVK81MU6DjG8Z10MIzcLDJ38Qw>
    <xme:mal3Y-AqDOmZq-EummTFHmZUN-j2czr8RkVS8cNCrcpRhCrcpb4cQWVGm-xMDlXdw
    _CgxYO1JQJN-g>
X-ME-Received: <xmr:mal3Y5HZk-bKV_aZEyMIlTTD_S4a71xmStx9L1PvfkdsJZ6epff9MDZ3DWozS2MgoyQkpPe7PjpJ54uLLx53fKTcBOAdTQCqlHUvuqFNFS1uAgUPY_U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrhedtgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepleekhfdu
    leetleelleetteevfeefteffkeetteejheelgfegkeelgeehhfdthedvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:mal3Y-RU-5Yzmk9KfZNVmM49J_cfXADtNHxJixdzSpRAeymdh_OogA>
    <xmx:mal3Y2zBu00d8jf_FVavc88jqhftd4AC3rTkakG8MuIk9iHi6w9ufQ>
    <xmx:mal3Y07_LkErtCrLmbUa5RYlbBhM4iwoZma1vWTbegV9A16dhDc1Vw>
    <xmx:mql3YwvkzGryKrWF4yHBO2gNhLPlf29KzNX5F4PqVEJte4XkKEcSxw>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Nov 2022 10:49:44 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
Subject: [PATCH v3] xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled
Date:   Fri, 18 Nov 2022 16:49:23 +0100
Message-Id: <20221118154931.1928298-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
the table is filled. Then it disables INTx just before clearing MASKALL
bit. Currently this approach is rejected by xen-pciback.
According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
enabled (in other words: enabling MSI/MSI-X implicitly disables INTx).

Change the logic to consider INTx disabled if MSI/MSI-X is enabled. This
applies to three places:
 - checking currently enabled interrupts type,
 - transition to MSI/MSI-X - where INTx would be implicitly disabled,
 - clearing INTx disable bit - which can be allowed even if MSI/MSI-X is
   enabled, as device should consider INTx disabled anyway in that case

Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too")
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
Changes in v3:
 - allow clearing INTx regardless of MSI/MSI-X state, to be consistent
   with enabling MSI/MSI-X
Changes in v2:
 - restructure the patch to consider not only MASKALL bit, but enabling
   MSI/MSI-X generally, without explicitly disabling INTx first
---
 drivers/xen/xen-pciback/conf_space.c          | 19 +++++++++++------
 .../xen/xen-pciback/conf_space_capability.c   |  3 ++-
 drivers/xen/xen-pciback/conf_space_header.c   | 21 +++----------------
 3 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index 059de92aea7d..d47eee6c5143 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -288,12 +288,6 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 	u16 val;
 	int ret = 0;
 
-	err = pci_read_config_word(dev, PCI_COMMAND, &val);
-	if (err)
-		return err;
-	if (!(val & PCI_COMMAND_INTX_DISABLE))
-		ret |= INTERRUPT_TYPE_INTX;
-
 	/*
 	 * Do not trust dev->msi(x)_enabled here, as enabling could be done
 	 * bypassing the pci_*msi* functions, by the qemu.
@@ -316,6 +310,19 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 		if (val & PCI_MSIX_FLAGS_ENABLE)
 			ret |= INTERRUPT_TYPE_MSIX;
 	}
+
+	/*
+	 * PCIe spec says device cannot use INTx if MSI/MSI-X is enabled,
+	 * so check for INTx only when both are disabled.
+	 */
+	if (!ret) {
+		err = pci_read_config_word(dev, PCI_COMMAND, &val);
+		if (err)
+			return err;
+		if (!(val & PCI_COMMAND_INTX_DISABLE))
+			ret |= INTERRUPT_TYPE_INTX;
+	}
+
 	return ret ?: INTERRUPT_TYPE_NONE;
 }
 
diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 097316a74126..eb4c1af44f5c 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -236,10 +236,11 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
 		return PCIBIOS_SET_FAILED;
 
 	if (new_value & field_config->enable_bit) {
-		/* don't allow enabling together with other interrupt types */
+		/* don't allow enabling together with other interrupt type */
 		int int_type = xen_pcibk_get_interrupt_type(dev);
 
 		if (int_type == INTERRUPT_TYPE_NONE ||
+		    int_type == INTERRUPT_TYPE_INTX ||
 		    int_type == field_config->int_type)
 			goto write;
 		return PCIBIOS_SET_FAILED;
diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index 981435103af1..fc0332645966 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -104,24 +104,9 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 		pci_clear_mwi(dev);
 	}
 
-	if (dev_data && dev_data->allow_interrupt_control) {
-		if ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE) {
-			if (value & PCI_COMMAND_INTX_DISABLE) {
-				pci_intx(dev, 0);
-			} else {
-				/* Do not allow enabling INTx together with MSI or MSI-X. */
-				switch (xen_pcibk_get_interrupt_type(dev)) {
-				case INTERRUPT_TYPE_NONE:
-					pci_intx(dev, 1);
-					break;
-				case INTERRUPT_TYPE_INTX:
-					break;
-				default:
-					return PCIBIOS_SET_FAILED;
-				}
-			}
-		}
-	}
+	if (dev_data && dev_data->allow_interrupt_control &&
+	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
+		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
-- 
2.37.3

