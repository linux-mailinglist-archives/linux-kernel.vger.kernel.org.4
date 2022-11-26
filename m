Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CC6398F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiKZXll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKZXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:41:40 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A17D103
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:41:38 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CFC05C007D;
        Sat, 26 Nov 2022 18:41:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 26 Nov 2022 18:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1669506096; x=1669592496; bh=w8La255xXVxnIR3cniemxgpr5
        Ih0kN7ITTRYd2se9fw=; b=sqf6qn2xRtMfNHG6XRPyhYmZkhWPE1aNEncXv+m69
        9zbjDacLmOYZJqbcXAw3jqQcIodP1xcLMJ22p9sxNk3XBEJ4uUjB/BBr7GWwgnY2
        ia+43kwWX20Su2xE4ZDbJ/LcQY3A6f+IRu/v8kathzas3fgfhnC4pumVUNC7oZyq
        JuG9vYvIPscBV5sEhfepk2zv1mpnG3W0YC5aNVNW0kXhne4pyGkiwqqaD1++g59k
        uzvRRtLdYJFPKOnAxuZbVRTbGc9CDEUTArR7TdDBjH5XQEQeD0P+b+g8Y5KKVx+s
        D2D+8onoYBqmKSYbudaI1vRxhJ8J8EZZ+cfObXfM5kHrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669506096; x=1669592496; bh=w8La255xXVxnIR3cniemxgpr5Ih0kN7ITTR
        Yd2se9fw=; b=IbqWh3TaV6qKJQM08vxuTMuj3FyizQWqvb5brfdLWGbYOZlJPne
        wW7KmuLoGTGBoqeDQy3UN7vGsLMNysuqGlyANkXAgLTLy21NyykxEx8JMfVFAIsS
        kv9NIwm1lonJn3Pf3G7x4XUZCxh/ArpaI2mq/NH5KHFhzjYx8QKTfoppYXwXrMq1
        0TLremPYcnQxmvR/LpSIh2v9JDU1dYSMwIc5i2UCe9JgCwOyj2BMOZiV/dJacG0t
        lugpGyJv8rHDINidpMKTzRKj11+qOvJb8YEquvHW+xmZQw9ppeHLX1I76kjjntq9
        ae3XJ51TslXJ6k9eK8NFLsEl78fJ0Z6fSZg==
X-ME-Sender: <xms:MKSCY0rOhwgXOP_0jZY36oAHZcg2NFc3EgVVRmIZWgRdnoY7YoAyMg>
    <xme:MKSCY6ptV0WBzqWqmKc9BzOA-3ALwaRub-xYA3xZRahf0YJGcRj3qwMy97HwxlmR5
    DW94YBRIkWW3OhBvg>
X-ME-Received: <xmr:MKSCY5PF2I6wejzSAXzwPVEBYNwZOP1SS2MdIh2MFARhnUbpuWnW_b0cccCMmYjtMfiYoe00Ayl2MbHotSirJC1-9tuE-zqqtrA4cgBf5x4Ju3WiI84b_zwx8sX3EPwNy32M6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieekgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheelvddv
    fffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:MKSCY76dNXZPTT4FNdppGvplIpm4n07ijFJhABYDaISnB1Dlgpk06Q>
    <xmx:MKSCYz6i-OuOQulPLaZTMeUNtwHC_TbLvBHSykAY7AzFX5M5Aa4hfw>
    <xmx:MKSCY7hkr7BMIgXYnR_GURMZXDP6W4v1sZM8lr-oqdJ8OluZS4CtAQ>
    <xmx:MKSCY5QClTv7GAv9QTb2Ayly3zazOiioh9fPZrder1dcmg4fYoMPnQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 18:41:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] genirq: oneshot-safe threaded EOIs
Date:   Sat, 26 Nov 2022 17:41:31 -0600
Message-Id: <20221126234134.32660-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
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

This is the optimization that I promised back in
https://lore.kernel.org/lkml/20220701202440.59059-1-samuel@sholland.org/
and got back around to cleaning up. To quote that cover letter:

"A further optimization is to take advantage of the fact that multiple
IRQs can be claimed at once. This allows removing the mask operations
for oneshot IRQs -- i.e. the combination of IRQCHIP_ONESHOT_SAFE and
IRQCHIP_EOI_THREADED, which is not currently supported."

Or in other words, we reuse the oneshot infrastructure for EOIs instead
of masking.

There a a few functions/variables that probably should be renamed now
that I have muddied what "oneshot" means. I elected not to do that in
this version to avoid distracting from the functional changes.


Samuel Holland (3):
  genirq: Simplify cond_unmask_eoi_irq()
  genirq: Add support for oneshot-safe threaded EOIs
  irqchip/sifive-plic: Enable oneshot-safe threaded EOIs

 drivers/irqchip/irq-sifive-plic.c |  2 ++
 kernel/irq/chip.c                 | 21 ++++++++++++---------
 kernel/irq/manage.c               | 15 ++++++++++-----
 3 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.37.4

