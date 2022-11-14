Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65A7627A89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiKNKcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiKNKb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:31:26 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962D11A076
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:31:25 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D047F5C01A3;
        Mon, 14 Nov 2022 05:31:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 14 Nov 2022 05:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1668421884; x=1668508284; bh=ucONn4Vdr4H2NM0BX9SZfqEHZEPMffIrGjL
        SNtqQzlM=; b=Vp72NYFefjy9vy3UqOS+H1WUdeGDGamvbwiqHAR/1cOB1t/JaIS
        QD3NER9FDpkdrBLDdMcGdcqUSXEIi7rZpWY5OcbOaEdz9auBDmv4pXIxSha505H6
        aY33T9v5S4K82NwBzx35OkcmqjEa+M44EO71+8+JC27Ui2QgiBUf443CmI924Qm+
        Ttxde/WDwa4/Ye7C5Fz4ptyhJMPV76oF7GnFsSz9LjFzN/0me48J98KRjuy6+Bf7
        /Tlmu4Ff8jvuPClkb+Dszw8dHKd7eXuUQBN081XIwJfrrjAN7thpY3HBgXBxQ1IZ
        LrV7xaXl80LKnTBxGf4/yrRxaqYeKmDnbGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668421884; x=1668508284; bh=ucONn4Vdr4H2N
        M0BX9SZfqEHZEPMffIrGjLSNtqQzlM=; b=JFF542PckgJqbVZS+4Do7YSqN+jSO
        TKt7h2BkG/G2j+sv5jYmGCUy6L1WiHZplZuxwFTUwZLWTVkzOHDD39s5WIIYGMaW
        EcWM1M9FKtiM/qU47tnZDbAePVpE48iW96buzCy9YL3h9Ec97p8DO9mL1xa7CDZW
        EDkxZ7AM1gSJQhBlqH5oLpimul8pSU4erAGCtfEs1zhaaBJOce0mwqdMe121Gean
        kFkLGyJ9GV9iCDjVlLA3PYRhxHFKeZcC7mYHakHlCTPq4VZkNwbyijS4uKxZCugR
        yryKiOapq7xmT95ay7kxSkg7ZT+EYDmuN4fkBSu5Kgir892NoVsqHhHww==
X-ME-Sender: <xms:_BhyYy27Q0ClfbgulPGQk2fW584f8VfxeovAQ0mB-n8n3RZFBHl4rQ>
    <xme:_BhyY1E8cxIIEzea3J0glo8xwUxC7zooaZ6LvE3y__iXCksmg4tikxeQ6YxJiuxhQ
    17iBEY4R-ddSQ>
X-ME-Received: <xmr:_BhyY67MTTOqtCCMnSe9wf1bQauUbEeQz474qmPvqCScIYyEP_MACR3gggp3sJgWTZiHejhJG-u4uvYMsbyV6v2gidAxuWy8JBAa32iEsXED9vc3W08>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeelkefh
    udelteelleelteetveeffeetffekteetjeehlefggeekleeghefhtdehvdenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhes
    ihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:_BhyYz3mT5dWEqWvimriUa9brLKMPwbAy0M0OmBnJK2jHIxy32be7Q>
    <xmx:_BhyY1GaX5ju4DbggbGCupJWT8ENO1GWPcNzgjy_gaAirsxlSSielg>
    <xmx:_BhyY88W7MZuYV0O7LKLzo5T7yxUDWTu78t5-QiJoSOc-Gw8zZoSWg>
    <xmx:_BhyY1DnLAmq-xPE0Yhqvmd3DyXhvdQdhBctMGB418W-SSrPirsKng>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 05:31:23 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
Subject: [PATCH] xen-pciback: Allow setting PCI_MSIX_FLAGS_MASKALL too
Date:   Mon, 14 Nov 2022 11:31:08 +0100
Message-Id: <20221114103110.1519413-1-marmarek@invisiblethingslab.com>
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

When Xen domain configures MSI-X, the usual approach is to enable MSI-X
together with masking all of them via the config space, then fill the
table and only then clear PCI_MSIX_FLAGS_MASKALL. Allow doing this via
QEMU running in a stub domain.

Previously, when changing PCI_MSIX_FLAGS_MASKALL was not allowed, the
whole write was aborted, preventing change to the PCI_MSIX_FLAGS_ENABLE
bit too.

Note the Xen hypervisor intercepts this write anyway, and may keep the
PCI_MSIX_FLAGS_MASKALL bit set if it wishes to. It will store the
guest-requested state and will apply it eventually.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/xen/xen-pciback/conf_space_capability.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index 5e53b4817f16..097316a74126 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -190,13 +190,16 @@ static const struct config_field caplist_pm[] = {
 };
 
 static struct msi_msix_field_config {
-	u16          enable_bit; /* bit for enabling MSI/MSI-X */
-	unsigned int int_type;   /* interrupt type for exclusiveness check */
+	u16          enable_bit;   /* bit for enabling MSI/MSI-X */
+	u16          allowed_bits; /* bits allowed to be changed */
+	unsigned int int_type;     /* interrupt type for exclusiveness check */
 } msi_field_config = {
 	.enable_bit	= PCI_MSI_FLAGS_ENABLE,
+	.allowed_bits	= PCI_MSI_FLAGS_ENABLE,
 	.int_type	= INTERRUPT_TYPE_MSI,
 }, msix_field_config = {
 	.enable_bit	= PCI_MSIX_FLAGS_ENABLE,
+	.allowed_bits	= PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL,
 	.int_type	= INTERRUPT_TYPE_MSIX,
 };
 
@@ -229,7 +232,7 @@ static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
 		return 0;
 
 	if (!dev_data->allow_interrupt_control ||
-	    (new_value ^ old_value) & ~field_config->enable_bit)
+	    (new_value ^ old_value) & ~field_config->allowed_bits)
 		return PCIBIOS_SET_FAILED;
 
 	if (new_value & field_config->enable_bit) {
-- 
2.37.3

