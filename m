Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB13962D9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbiKQLmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiKQLlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:41:47 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EAB4B981
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:41:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A48665C018F;
        Thu, 17 Nov 2022 06:41:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 17 Nov 2022 06:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1668685302; x=1668771702; bh=5Hp8B5ibzq9PE++sS2FmCLXLWnvRx0WKWkG
        DICvery8=; b=XLW2Y5LlGasq5/yW0AGCXIhwRQR01dr8Gg1ST7fCFUblQ/xp/Gs
        jGNz+xLMRbE4DtNzzfAGroV8+fgobWBJcjz8GNR4XpiaRtNuVjfHFta1iYUCwTtX
        N5m1fyR+LAhTZwh4llPsC3tFMR1xHYZ6Zk4IWxyB/6lNS0nRdSdKDJvpZBI2cq2R
        g6WbNhn+HCHP4x38xNOy3h3iQHYhjlRL72TBFjYgj/+m485nRdeShySBHIa2Qmjx
        GHhUFup7JtwPergDM38yApBR/QLtikhd8drBPuZ/GqILARp2HZ4Bxr3+t8Q60FRO
        HiEIKSE/uy/Gaa95atWIs7ltOID2r3xuiGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668685302; x=1668771702; bh=5Hp8B5ibzq9PE
        ++sS2FmCLXLWnvRx0WKWkGDICvery8=; b=t86OowYVgnKExhpiOft5nF5yLOuXL
        Ky7yp6hRfOzqzZ69nls2SqCmFZflynB5w3puHMW4ZO7c7h2HcoeuIjf/wO+f+c07
        hAzwacA3IKTp92kFEjbBSD74oXHop3J2PRFxK6vaz5ZJIhISi9tN8knGiauvKOPz
        RIs0EfWtvMBcxcdIQY7DY3A0g9DHLC2jwKxvOF8gMxbnVsmZwGpHQ8ZB0k/dJe8/
        +w+3wrb2Jaa7Dg+uWICnNe0Bc8zVyE2GFBWauAkI0u1b6pvOifyvOpf0kOJ+ruLw
        pFNxgzUOZDQvOJT8fOGLIS6eh8ilqNwD2QjF0k4vk1Khjykc4KVHQjDKg==
X-ME-Sender: <xms:9h12Y67c1Bp-yr1wFD_ab-4uxftuJjg-e_E7Ywzriv9K9VTs1pC34Q>
    <xme:9h12Yz5mREd-IBtTCDO6X79QQi1UTqQHuMA-nGlhW8e7IsD2KxPMaM7GN5GNaVlUD
    0sXh3YblbvIVA>
X-ME-Received: <xmr:9h12Y5eUg8hrNiuaFHe3THCZTR3WzBI3lsX4XT90D8s6mERQDoCwCDOoAYRorRXIf53kKMxDEaazMUoPYYXJnm1ZbihXnVecT5WU_oXCnm9JQG__0ic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeekgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepleekhfdu
    leetleelleetteevfeefteffkeetteejheelgfegkeelgeehhfdthedvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:9h12Y3JanckpXKof0E2oF7b_jbBV7FV8WbRlxnidAAWpU0ULVflyVQ>
    <xmx:9h12Y-KynbBK7QdiJ-0yTIETDLxyyYdm918F7SpCwa3esIjOa6gDgA>
    <xmx:9h12Y4zSGkfReIjmlZdoiCIlmE_WkWQeE5S2nvV4srstBmOSnWvO3A>
    <xmx:9h12YzGQ9Kpb6lK_Ba0OZ87dJ2dTb2n-IDavDoph4z7PraX5hFulJQ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 06:41:41 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
Subject: [PATCH] xen-pciback: Consider MSI-X enabled only when MASKALL bit is cleared
Date:   Thu, 17 Nov 2022 12:41:17 +0100
Message-Id: <20221117114122.1588338-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
the table is filled. Then it disables INTx just before clearing MASKALL
bit. Currently this approach is rejected by xen-pciback.
Allow setting PCI_MSIX_FLAGS_ENABLE while INTx is still enabled as long
as PCI_MSIX_FLAGS_MASKALL is set too.

Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too")
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/xen/xen-pciback/conf_space.c            | 2 +-
 drivers/xen/xen-pciback/conf_space_capability.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index 059de92aea7d..e8923bffc175 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -313,7 +313,7 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 				&val);
 		if (err)
 			return err;
-		if (val & PCI_MSIX_FLAGS_ENABLE)
+		if (val & PCI_MSIX_FLAGS_ENABLE && !(val & PCI_MSIX_FLAGS_MASKALL))
 			ret |= INTERRUPT_TYPE_MSIX;
 	}
 	return ret ?: INTERRUPT_TYPE_NONE;
diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 097316a74126..5c851f916ebc 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -242,6 +242,10 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
 		if (int_type == INTERRUPT_TYPE_NONE ||
 		    int_type == field_config->int_type)
 			goto write;
+		if (int_type == INTERRUPT_TYPE_INTX &&
+		    field_config->int_type == INTERRUPT_TYPE_MSIX &&
+		    (new_value & PCI_MSIX_FLAGS_MASKALL))
+			goto write;
 		return PCIBIOS_SET_FAILED;
 	}
 
-- 
2.37.3

