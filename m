Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8E6DD911
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDKLNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDKLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF491449C;
        Tue, 11 Apr 2023 04:12:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6A9745C0098;
        Tue, 11 Apr 2023 07:12:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Apr 2023 07:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681211566; x=
        1681297966; bh=nTO6Ylpmk7/Iff7I5htSerd/uHZn47TmohbEAcaDuVI=; b=k
        F008sRZX7LingIautpxvaTwqE3oUkC7QTLhyOXkz6YKJb7WdaTTbCcwcGVGzjyGW
        HeCj3jyHJ7Y/qHUIjTgYb1xYECR56vlhNhWqpjkTFDh7ks90p4PUeEGY+OkISVt0
        Nm1PDDd9Kcj9kbIWU3/OK1g2dGyj2cQTCY2G/DizlwxqDJA2om5ZQ+XFLBeLyyfl
        j3PfM7syorDuhWlIJ2m/iqmx8lhOlbKUVeAWuNogtjBWfPfLAvht8Dloj5ERYD5O
        yPXwft8r2IsGsAdcipKmln3NomILrf5Y/+iYPlTgl3ma6CDczr/Ye/AIcSqBI0Wk
        SjQvjGa4fD+fHMSR3PYuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681211566; x=
        1681297966; bh=nTO6Ylpmk7/Iff7I5htSerd/uHZn47TmohbEAcaDuVI=; b=O
        QgtJ9YZfCrkLi4sU7qzvg97o1qigbQHx+yUShqlaN5mOjvnr+J+eul2VW1/oq2bR
        vRreAvyjiqw4u6K+Lr26ikuX59245ffA90bGnqpKcc57MME0ib9ijg8wnGAZabnz
        /5jus8wu9oqib+pbhxzqtTB5ZricCmuE4MytX2WoavZVyBIxKD56AdD76276/6+l
        ml/np3l7uUr8WzRr6LvTUCyIMbgZhcOXnCgLMchk+nGL/EdtOQmsoTX6plPxUvy+
        EyaIoUu4qMkvSVr1rOlTJd5qSYrAcL8Cfg0mmr0f3WTZigkfvU9f17nYneD7yxwh
        P8B1S/iDujltnd5JgJQxg==
X-ME-Sender: <xms:rkA1ZD-WXadIrB422P3Dz2ZTJWf5pUGcfHre0vIoSCXHN2LQEnvWOg>
    <xme:rkA1ZPuu38Pf1FtvSEQflNqYxy8afv7qYp4L3CSHVnkKvMs1gmKfI3nKZAr1YSBxa
    G7C9XY7mYh3Agdnsjs>
X-ME-Received: <xmr:rkA1ZBBbN07iFBC2C5lfIn2uAbgjSeZK7G67DPe5UWJ1EP8nbwobGnmvQctX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgepvdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:rkA1ZPeRBSGTGRsQit5Y7PEKHHBiIwVbaKgSBSJxerzUjqpFsczntA>
    <xmx:rkA1ZIPUeg76tFU0K8FxGOfs7MACBYLqn_GRmDnLgaAYOdqPn8F4_A>
    <xmx:rkA1ZBnK5Ih8BjuGao4pfmIe8EryKzf8BUhJR6YYvFVkLxKv--69WA>
    <xmx:rkA1ZNr5SGHFhUpGwjebgrEIJwNBz_gJTPg4DePU2y70L6lSkYsafg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:45 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 6/8] MIPS: c-r4k: Use cache_op function for rm7k_erratum31
Date:   Tue, 11 Apr 2023 12:12:23 +0100
Message-Id: <20230411111225.55725-7-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
References: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM assembler is not happy with offset that may overflow immediate field.
Use cache_op function instead of inline assembly to fix build error:

arch/mips/mm/c-r4k.c:922:23: error: instruction requires a CPU feature not
currently enabled
                        "cache\t%1, 0(%0)\n\t"

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/mm/c-r4k.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 420440cc40b1..89603d033180 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -915,25 +915,20 @@ static inline void rm7k_erratum31(void)
 	write_c0_taghi(0);
 
 	for (addr = INDEX_BASE; addr <= INDEX_BASE + 4096; addr += ic_lsize) {
-		__asm__ __volatile__ (
-			".set push\n\t"
-			".set noreorder\n\t"
-			".set "MIPS_ISA_LEVEL"\n\t"
-			"cache\t%1, 0(%0)\n\t"
-			"cache\t%1, 0x1000(%0)\n\t"
-			"cache\t%1, 0x2000(%0)\n\t"
-			"cache\t%1, 0x3000(%0)\n\t"
-			"cache\t%2, 0(%0)\n\t"
-			"cache\t%2, 0x1000(%0)\n\t"
-			"cache\t%2, 0x2000(%0)\n\t"
-			"cache\t%2, 0x3000(%0)\n\t"
-			"cache\t%1, 0(%0)\n\t"
-			"cache\t%1, 0x1000(%0)\n\t"
-			"cache\t%1, 0x2000(%0)\n\t"
-			"cache\t%1, 0x3000(%0)\n\t"
-			".set pop\n"
-			:
-			: "r" (addr), "i" (Index_Store_Tag_I), "i" (Fill_I));
+		cache_op(Index_Store_Tag_I, addr);
+		cache_op(Index_Store_Tag_I, addr + 0x1000);
+		cache_op(Index_Store_Tag_I, addr + 0x2000);
+		cache_op(Index_Store_Tag_I, addr + 0x3000);
+
+		cache_op(Fill_I, addr);
+		cache_op(Fill_I, addr + 0x1000);
+		cache_op(Fill_I, addr + 0x2000);
+		cache_op(Fill_I, addr + 0x3000);
+
+		cache_op(Index_Store_Tag_I, addr);
+		cache_op(Index_Store_Tag_I, addr + 0x1000);
+		cache_op(Index_Store_Tag_I, addr + 0x2000);
+		cache_op(Index_Store_Tag_I, addr + 0x3000);
 	}
 }
 
-- 
2.39.2 (Apple Git-143)

