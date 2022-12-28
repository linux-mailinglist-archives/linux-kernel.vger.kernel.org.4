Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC28657179
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiL1Aoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiL1Aot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:44:49 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5ADFB8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 16:44:49 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D7B5B5C00CC;
        Tue, 27 Dec 2022 19:44:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 27 Dec 2022 19:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672188286; x=1672274686; bh=lJKh5hLUSVyNtGb27sEl8iKUo
        pQtksa0I8JjuVzm/jY=; b=zsXQvkbc4qvvStb1M0jQ5bPd3f+tBhq0STct4u3nu
        QFwp83KoW0i4X//TVOFdjcNsGpo1Oc38whYYa4fcxGZZ2eckTsIBQzascSQqMPP8
        6OVXIpr4QS8lrMMTycvQ91m6h4MABLc40u0OqDZrJBcGVSwkIfn+8Ccw333WRn/o
        OKeY58lnAe0WBBFmQeUQFR4qZzeXq7m4JcZlPBMBwtsb30OK9N8DOfDdvrlofZtM
        PaYpS2orM7rveegfgrhS8t5AIsR+VvHlMG/64g7Eu8EEkiqSvkapcpYnVuxzuOtO
        wltFE3GW16yFFeXEIMF+HykbGcx2QWkWNG51VzbZTeSdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672188286; x=1672274686; bh=lJKh5hLUSVyNtGb27sEl8iKUopQtksa0I8J
        juVzm/jY=; b=jpUgIno+86qYFaeGQn5+s30NUnkg/CCRVzjVp9GW/E0dR7mLEL6
        0DZXdgLmi4IMPbDCHBE6s3l6QB+KlxDqkQernCkEGU2ihv+i16/qN+hh+qornvRW
        iFBeM82wFAPlLX4qBIGjFMdw3ttGCWogLIZoXxqtEM2fEHC/r5Fg5EzdEBMf8lLV
        0DRy/AoepLZX1Gdu93AduwHcuDl1i957/hv5Es+1pO6bFDj34JJty1Af5u5HfPdF
        qbkN18LEkOeCeLS54EDRbc9ELnnqA8p7qMbMtdxFAKtYA+m/eQlKTsStnCSvhrOL
        aT/WId0KvRn/4djCWMHJxr8BoTi89658xVg==
X-ME-Sender: <xms:fpGrYwPR4xuCgO4e8y3P4kgryvMjk42PLPqwkWkoMEUIv3yhqZ5w0Q>
    <xme:fpGrY2_Mgh6SUqXB3ZIOmu2p2OjixDgn19CWxyBsVtHs3SKDvCDgW-jpLL_dugSev
    Pd_XqC8j6VxseP_hg>
X-ME-Received: <xmr:fpGrY3QdETEsIgjk2Ux7Dl81HunUTSYYv6VmsQTyWSeYgQ58vR-14Tv6BeEuJHSIP7YX_dYVHSb0qiLGdqbCW_3sULwLMM941T22UNW1VjW0fAFXaWEVWGinr7qTtQOzWC2YNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:fpGrY4suk0hdHM_fE1N5dEqeRltOyr9UMHDbkEc3qJa3vTaFnMv_wA>
    <xmx:fpGrY4d349C_7MaAlYDu9H52k22l5DFzr0D5ndAdsyDjxF0N6r2nLQ>
    <xmx:fpGrY83KlxEYWxV4AhgP7btqrSfpWVu29JBVjUs1vfimRgLwes5UBg>
    <xmx:fpGrY2tQhPmgQHCdvI7buI3rSUz3bXzdEKsHeUnnZLA2DefNNoaDMQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Dec 2022 19:44:45 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] clocksource/drivers/riscv: Increase the clock source rating
Date:   Tue, 27 Dec 2022 18:44:44 -0600
Message-Id: <20221228004444.61568-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V provides an architectural clock source via the time CSR. This
clock source exposes a 64-bit counter synchronized across all CPUs.
Because it is accessed using a CSR, it is much more efficient to read
than MMIO clock sources. For example, on the Allwinner D1, reading the
sun4i timer in a loop takes 131 cycles/iteration, while reading the
RISC-V time CSR takes only 5 cycles/iteration.

Adjust the RISC-V clock source rating so it is preferred over the
various platform-specific MMIO clock sources.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clocksource/timer-riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index a0d66fabf073..55dad7965f43 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -73,7 +73,7 @@ static u64 notrace riscv_sched_clock(void)
 
 static struct clocksource riscv_clocksource = {
 	.name		= "riscv_clocksource",
-	.rating		= 300,
+	.rating		= 400,
 	.mask		= CLOCKSOURCE_MASK(64),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.read		= riscv_clocksource_rdtime,
-- 
2.37.4

