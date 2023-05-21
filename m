Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D214870B1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjEUWdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjEUWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:33:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE91FE;
        Sun, 21 May 2023 15:33:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 907EA5C002F;
        Sun, 21 May 2023 18:31:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 21 May 2023 18:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684708292; x=
        1684794692; bh=zsryuoGv1+n96XBFSmSM7IggLdXyxGy+UDE+DUNZJ18=; b=B
        qlYXmYvBpidE+Qenb6cuppxjzlhYt1a5tG/Bsm57DLr77SPTNbcMrNxqLFWKEpEh
        ne4fRaUzBcyw56zQAVCwlf5nQKTDdvgBfgOXqRr4AdP7tqAQUmZF1Qd1yBrV8yut
        Ehjx+O5Psu2JpNZDk/DX+evM4tnTMUAK4YxWud4t5CbBUj33hWD2yIBtfFRNg3u9
        h2VJRoxxjn9dM+dU6oJp/H34RoPEkU2hhRF8DawuabAnUqOjCR4QoRxUX2rZISG0
        5l3inRBilBrL08VAk32ebWkqJS76i19IHc0Taci5bRsKSOK1MDnQ86yRn44iUWdq
        BlMfpKsehBLJzA2gXZhWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684708292; x=
        1684794692; bh=zsryuoGv1+n96XBFSmSM7IggLdXyxGy+UDE+DUNZJ18=; b=o
        6cK3P00kK6WJNedgnlsGRiKp/ysFxsLRHVihy92pzGEwdGI45rIyDDmZjCtocenw
        wrIFGnaue+Z1e1cPEubGXUA32rNGoquy1pSMWidxNVS0yd1V3IBdRybAmk1CRoY4
        edHcLoiiafiilWpQz0W+nzDQXu7PQQfW+ADO8wg9Px9DNnl+lclf578i6S4Zm1Ka
        91t8JnGdkciTljB7pT3y2VLDh5DJlsv565DnoCStRQAJvVMit3DpJBKm3L0kc0F8
        QUX/j4eDzS6UGcTzBJmlA7F4ch5HZULOIV9qb0BrBKHsVejUHdM5zWgO0kz5shAY
        fNOi9NtwNmaHi+aIoYp4Q==
X-ME-Sender: <xms:xJtqZD8kq1PMIbDWgSVDJ_-HZshy6S7JDpAdxcVXOgURSryjdIoVuA>
    <xme:xJtqZPskebalGH9Cd88fikxPFdeAQ5hVNKYpcbeIHdcmZdFpCrm9em2x6dZm7I-ZF
    G3fdfmYoHPk4jKIK4w>
X-ME-Received: <xmr:xJtqZBCZkkF0yYL38aR6-pi1YYaODxCEjbxNqF-jXIzzNhYSG4DKTWyp_fvd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:xJtqZPf3kuDvYOr3KCgnmxCfCsUC-ZDzO8kedl5TTf17yki4JLx4Fg>
    <xmx:xJtqZINCU6_xorQghQVeVwhU0THz_iJkVT9CR8clGR2CitihukS7Sg>
    <xmx:xJtqZBmg39-1n_JwdAaBekkH5XPDr1dUr2qnEY_odu9a0BJl2gcfWA>
    <xmx:xJtqZFq77nxlOq_JwlrZyuNebSgra7ytvqACRZMDmUO-H9b42tX9zA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 18:31:31 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/3] MIPS: Select CONFIG_GENERIC_IDLE_POLL_SETUP
Date:   Sun, 21 May 2023 23:31:23 +0100
Message-Id: <20230521223124.21911-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
References: <20230521223124.21911-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hlt,nohlt paramaters are useful when debugging cpuidle
related issues.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 arch/mips/Kconfig                               | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 515cd1f88ea2..9c502d3aa0cd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3694,8 +3694,8 @@
 
 	nohibernate	[HIBERNATION] Disable hibernation and resume.
 
-	nohlt		[ARM,ARM64,MICROBLAZE,SH] Forces the kernel to busy wait
-			in do_idle() and not use the arch_cpu_idle()
+	nohlt		[ARM,ARM64,MICROBLAZE,MIPS,SH] Forces the kernel to
+			busy wait in do_idle() and not use the arch_cpu_idle()
 			implementation; requires CONFIG_GENERIC_IDLE_POLL_SETUP
 			to be effective. This is useful on platforms where the
 			sleep(SH) or wfi(ARM,ARM64) instructions do not work
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5f52bdecb4c9..e437bf43ecfc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -45,6 +45,7 @@ config MIPS
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
-- 
2.39.2 (Apple Git-143)

