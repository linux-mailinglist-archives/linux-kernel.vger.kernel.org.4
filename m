Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7139163982C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKZTsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 14:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZTsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 14:48:08 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D7011455
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 11:48:07 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C2E55C0043;
        Sat, 26 Nov 2022 14:48:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 26 Nov 2022 14:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1669492087; x=1669578487; bh=WxeQ0lAHuyYH/JvUacQCXsHoL
        dHh41AbK/BFWlsX3M4=; b=NwhVCidjw1PRi+08H/StL0r26ZuCW0bTNx2YKncdI
        29maC4iHyIopvQL8gafncz7F8E1Gv6gksUAt1E28vD2hLLvxZFKwhTw8sIgj/BpG
        sOt6hYqMQcC7WLiOWimA6UMGiP28g0XJVN6BNSDCkmi/mVIj2V9WoMzfDxTIyBOg
        XrUiywY5fMCNC0KkztsDZbtjD9f/R4Zfn8uTjKiRfLlqYtk48QuyYYTV44YJSrkR
        R7FdUmEutw5XaQfU2z1j7BEkf9533qatt/cDd8MJj4Xr1jdWk8m+x+YKpr8GG884
        L/8bQX94jhStL6MX7l/pJALtusdevrXJJFtO+YfUZqENA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669492087; x=1669578487; bh=WxeQ0lAHuyYH/JvUacQCXsHoLdHh41AbK/B
        FWlsX3M4=; b=WUsvxM/M+de56HMHmHoc1r+qoW4Pi7goIcWptJIdnVGY1AIE3O9
        evSGns24IGJRTSbFlMohg/9idV2FIvYP0TqCO990lZHR035QMrGgQfU1mw4Co/5q
        oaqiqYLrVZs5jlwE/caWoCrhn19tq7BVebimC6q8v4G57XLi35QkHzcclUPlTv7l
        +Taj4akjHTN59Oompk79Zra407yBAP2pV01OZVBnn5XKzsLTtus2FRRVWbNBlA4Y
        5ymkFpNNBvEBIV8b1XzvanYPe/oslO27k5sthKxW7HIj4k/CvfnPNrXt64YzBgVl
        atZRoYEPh+CoHUiRlOoVF8Czjqg6MLNIhyw==
X-ME-Sender: <xms:d22CYxnqzsEvi1S2YQX2Ie6avrk42NaxEMoynsntMzSOyHia7U-KPQ>
    <xme:d22CY80-bjDSqGVdchYtFYu6OrL5esWliKbpivT9eeJJzCk1H48YF4EGdqjoL-UsZ
    mUR9nFPXI9k_KdvZA>
X-ME-Received: <xmr:d22CY3pDuU3yD6bpiUn7pCMrGCvH3XVR1TbHsHzx65qq6LeT5D3MlUtmsa7YM78sWVKdVd97Mgz1fnlwrfESC2vI_00NQSYoKg7QNsonFlc31yXWrsYuSK7Uu40tp6XG_YfU_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieejgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:d22CYxnD3M-bpB9-jJbG-VAHB5Bh_AzO4Pl_R8229A0-U_G9T7QD1Q>
    <xmx:d22CY_1Ll528ksUMZjc6X7v1aQfMeXowWZF0MwJrzDlI8efW6ah85g>
    <xmx:d22CYwtF0_vC05Za3PjN3y67ik--t9_9FTtKZ29o-jX3J9BIB-26zA>
    <xmx:d22CY_8Y1Ua_8mmxnHKgCESw9QkwKERcp0Q9eBp7P311TuINtVjakA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 14:48:06 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] irqchip/sifive-plic: Support wake IRQs
Date:   Sat, 26 Nov 2022 13:48:05 -0600
Message-Id: <20221126194805.19431-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLIC does not define any special method for marking interrupts as
wakeup-capable, so it should have the IRQCHIP_SKIP_SET_WAKE flag set.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/irqchip/irq-sifive-plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 2f4784860df5..ff47bd0dec45 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -187,7 +187,8 @@ static struct irq_chip plic_edge_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
-	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
+	.flags		= IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static struct irq_chip plic_chip = {
@@ -201,7 +202,8 @@ static struct irq_chip plic_chip = {
 	.irq_set_affinity = plic_set_affinity,
 #endif
 	.irq_set_type	= plic_irq_set_type,
-	.flags		= IRQCHIP_AFFINITY_PRE_STARTUP,
+	.flags		= IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type)
-- 
2.37.4

