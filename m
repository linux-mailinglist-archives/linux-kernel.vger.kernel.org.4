Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BDF6398F7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiKZXls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKZXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:41:40 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A6EE2E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:41:39 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E14D5C008E;
        Sat, 26 Nov 2022 18:41:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 26 Nov 2022 18:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669506099; x=1669592499; bh=yC
        ipfaxvp8AqE8QMs96bMtJmPASK9bHZYxYCfkqHdhk=; b=asvuakl6YyLt4vtn55
        jwrccaQ/opR+wF/RCwaTPSW4saJF897p3Hck1RH3am8PyBwbO9WwKXv3u/aIDYnq
        xHIhLe5xb++/UEpHNCQAnYH/I23athqlgzmYKsfrruJKPtK5wZENCQcCE14vYVbB
        rzKodXK2s4nLTB6lupftAj86RDwMch2KknxRDOJlTAOlVCtzh288WxnM1cLyNPio
        IIExMha0ywYjfo7KJHeuAOuVfV2RLxuaksoCPH/t9p0xUfeuc59LQNH/ZrC9s8ML
        10/tzerxMLY8674c2wlZAXoDbNHpp6U5/HZV+89l5EYiB93wj8uMrrZ9KQ4NueMz
        UF5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669506099; x=1669592499; bh=yCipfaxvp8AqE
        8QMs96bMtJmPASK9bHZYxYCfkqHdhk=; b=cPcfMZMCjmljy+g9iBLqCnorTMx+I
        hN/4fIDtJiN0hOAQ998vBsRPpT57/QVRdvzBEVSgQTqVgXBqoCOJepN0p/y98gc5
        aI9Zsn6hs2kpdG1OYYTh7FYG8zAJbTDnVzYBl/bY5On3Zadp1Pi0l0TIkzggTzGt
        tjUS4lmGJU5xlNJom/g17//+lWgrVEmfpjR5m5FAm75yukLHPLWhVemlHgHquix1
        Z96gD3w6I65GJtrRGaV96X/euHIEgpUHycZIjy+ofV146snV+G99f6qTVw6Qk6ie
        S+qYQC2Lk5bj1cGJm7AwTxvLW8jnS2opR3DILie6JBUipDjtM2M8EuE9A==
X-ME-Sender: <xms:M6SCY-DXHp9_lBhloi29CabRsXpwoZHBXjM0H0-8unmALOSWw8Y9zQ>
    <xme:M6SCY4hGiwAPzpzF0gKjt82Y2dfDN7Tv9qA5M_8j8f42g04GAqeKkIVPJwTjeNP9b
    rIoM3PoDdQmSiGYbQ>
X-ME-Received: <xmr:M6SCYxmQa0nLfx8dXKRwLfP2p_Ar22voc-LwoOikdl8aYD94fhy0FCSGOEOPDyhKbovxmQf2h4ltoFsS1yFL1RskyAypNcwjvPzoutZDiqXGwsstijIod1-5gsg8nPbH-g5qxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieekgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:M6SCY8w8MrC2b89-BTfB_LzW9h-XqpK5AEj210lsVVHvnXgVp5QHYA>
    <xmx:M6SCYzTvVliOs7DT9Los3H8iWDBaDdL0tVxoqJX3Kcd52OUdj7lqWg>
    <xmx:M6SCY3Ytw9TeWPM7Fh9B9TGdwFJjqHxjRhhwiDQ4CQcVEQYKPCvbbQ>
    <xmx:M6SCY0LUOnGZSgEz3OzBzFrW-rYUpimKMcAHBS2J1e_5iVZXb-lLFw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 18:41:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] irqchip/sifive-plic: Enable oneshot-safe threaded EOIs
Date:   Sat, 26 Nov 2022 17:41:34 -0600
Message-Id: <20221126234134.32660-4-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221126234134.32660-1-samuel@sholland.org>
References: <20221126234134.32660-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defers the EOI until the IRQ thread has finished, avoiding the need
to mask the IRQ while the thread is pending.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/irqchip/irq-sifive-plic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index ff47bd0dec45..d8fc3354b38c 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -203,6 +203,8 @@ static struct irq_chip plic_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_ONESHOT_SAFE |
+			  IRQCHIP_EOI_THREADED |
 			  IRQCHIP_AFFINITY_PRE_STARTUP,
 };
 
-- 
2.37.4

