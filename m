Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6984662EBF8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 03:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiKRCfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 21:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 21:35:53 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A672E8D49F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:35:52 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 321B6320005D;
        Thu, 17 Nov 2022 21:35:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Nov 2022 21:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1668738949; x=1668825349; bh=iXS5rnNN6KGyRE2PJSOSu9Q5tR9SxGRz/NB
        oxnHnE3o=; b=L3k1ECDbPMHp6Av60+4MBAOrax9uhhonBcOHlRj9ixsjSLE+vUY
        P46kjBipf/utAb0pXW3HKd4JUCaKZf0EDQRC4wVZxtHN1CUX8TuCWjzQCq1moxqy
        wMBb+rhTbTyFTXWGxUtwtry0wUHqh/PlWfnOIKT4NQll1PH4lRQz1OOLNO6HwBUM
        T1OEqBPtsPxMeZpNmLNst4uThX8b3wr29YhBw9Tw90Mx3HoCCVPb0ZEgdZYsJOXx
        4jYvvMxRCSB6HBBQVe2y+Hl9gIi5l0aCOzMQvBzJgmuGnHUNZr9xBLFYGISjLtjT
        o/k6B5f+QBRBd8kv5uw2IbuQVY8pES6IMig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668738949; x=1668825349; bh=iXS5rnNN6KGyR
        E2PJSOSu9Q5tR9SxGRz/NBoxnHnE3o=; b=l/wqCKL7HkibTjVT9rTeM96zNNg9i
        bUrp7eu4RoKTTWCmBp6GJKX+tMoKdvUsCkr80t0Y1u4hX2jNTfzxSd8SKf8ENDuc
        He9kmBbOEC8cyl2ZVZoD9Hfk4nk8E09RYr87FLtVl7OHq8RbSR97EcptVTI7Pu7U
        YMGPf34RwoM5R+vqgOonA5mtVv4pf/2VB9Rt/83rmYEk2yRgTpDqWN9J7tP9ewoM
        Npm97cs1YjrVquZZqMDshBmKI2m1mTUQUCzPIyMmqsznC9E0qU7VvEHMhN0/2U2G
        qiKTzte/ZcrNAkCP5mumX/od61/+wJDaNTd/J49MLnXZWcRfiVJZPL+mg==
X-ME-Sender: <xms:he92Y95jrwYIhB3Zybp1Qlq4-n3Jwrq33GYXQv216TOaFRuax2BkSQ>
    <xme:he92Y64VBUldd00Ndf4dDXsIXt4Vwrm2Bi3xDr6Tf17CtutwNLKjY6GGk9ve_ReTm
    r_eE-nmLJavgA>
X-ME-Received: <xmr:he92Y0fnbIA3fs_I0CiVKUWbBTmhypUYnI8zIl6a9m1OXDRTxb6dVAsu1j_esVvQNcVdVd7rWzgLiACZzHSnSSI_WyV5jAHoCuttaJTXX0VqZBdusds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeelgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffogggtgfesthekredtredtjeenucfhrhhomhepofgrrhgvkhcu
    ofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepleekhfdu
    leetleelleetteevfeefteffkeetteejheelgfegkeelgeehhfdthedvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:he92Y2Kvf5Lf9IO-eTS0KJiSeXvgriWrmxZxfVnTSE-6FBZnFhWQlA>
    <xmx:he92YxJ9i_6KgAUFtNRWLnx25MlRREMallN2nUMEoA05GNG9UxT9cw>
    <xmx:he92Y_wIQR2cciuNwFWnFh05XV0mx6Tg5xK_ZM5WzOH4Q8OxZUnKSg>
    <xmx:he92Y-FjTAi4ImC2SKQkwBLgrPZM1BpFt5qn2wFdGbZ8HJQUzk1dAg>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Nov 2022 21:35:48 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
Subject: [PATCH v2] xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled
Date:   Fri, 18 Nov 2022 03:35:30 +0100
Message-Id: <20221118023535.1903459-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux enables MSI-X before disabling INTx, but keeps MSI-X masked until
the table is filled. Then it disables INTx just before clearing MASKALL
bit. Currently this approach is rejected by xen-pciback.
According to the PCIe spec, device cannot use INTx when MSI/MSI-X is
enabled. Change the logic to consider INTx disabled if MSI/MSI-X is
enabled. This applies to two places: checking currently enabled
interrupts type, and transition to MSI/MSI-X - where INTx would be
implicitly disabled.

Fixes: 5e29500eba2a ("xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too")
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/xen/xen-pciback/conf_space.c          | 19 +++++++++++++------
 .../xen/xen-pciback/conf_space_capability.c   |  3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

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
-- 
2.37.3

