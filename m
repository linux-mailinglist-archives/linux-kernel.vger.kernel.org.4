Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5223639415
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 07:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKZGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 01:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 01:15:59 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC02201A1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 22:15:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B10075C00BC;
        Sat, 26 Nov 2022 01:15:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 26 Nov 2022 01:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1669443358; x=1669529758; bh=hLJUpZI/f7CpelvMplO2oQQt3
        hxU+GpZrdXUTH/HZis=; b=oK3G74Mh1+qwvqE8Jcp19vt9rSZediknoMzlwigqV
        NgAhattWRXTqTb05nFF6I0HTMVS9l5TACIM+WLaN/XE1seaoRnXzOmTViYHPtLY8
        VNFXyHaVOmUkath/fAySUAd99SCSX90LzoYrKXbEqiN3yLjMMAfphD+R3gneKeMk
        WpeRn8efsMd2rcLggV/Espx+b4kSy0fsRZpWN5nJTujh+iBgYfARAVcmMHHbpHY7
        w/boQXEQ984IwBKjrInfXYl/VqLH82dmFheuaJ8vkhOGJfRwrgEgwYaX7ruVEO1G
        VafT6R4A6lNTsg9rCYr/pMHh+6dz5N9I25eaZOUjQcUVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669443358; x=1669529758; bh=hLJUpZI/f7CpelvMplO2oQQt3hxU+GpZrdX
        UTH/HZis=; b=YjSv9StU6p9jBx6hNQEX9xloESK42X7RLve5kT4VRiXX8rINBz/
        5V5mPerP/s+hYqVOaXcs7ePX5TJ1HUJYfRu43C8rvi2YeUr9Uk5+YuqjYfeSuWVD
        Vtz6ww0Kcp4eDQsnSMEKYuGi8M6/+iXF++EkzUz8Xu8O+IgkpddcleZaove/kjXD
        auJqd+0VWS7aanSAVOXQevXWvXhRe8KEwsJjUAQVQkY+6JcDJXfjA9wbvS4Wwuzc
        wkm5KWzgPet02XKFvuDHpH4TlQnQpvC1RHi6c+pIvQ+6upDi8vmKEUr7+xmScaZV
        JoRNfhPJ3vHW75wdxJ06wA7Jvl8DLrbnpyw==
X-ME-Sender: <xms:Hq-BY6O9A0Jcru6yMKlTvJo4ChWa2ofbiRZkxCzUMCxmp-51pPKrSw>
    <xme:Hq-BY49MMuyPMEA-NgXmLJGRKSjA1jA7UiI8YOPDQMnOKqmbOOXI_Vz6tVymdhQUj
    4F-vhO4xuXFowNMWA>
X-ME-Received: <xmr:Hq-BYxRrZ0_Qq5tvpsao7BiCj3oa71L9RVUCkGbhATh0Vnkcdh9pRD2sMp5V1VVQnehNwcNh9K6LIUiTnvpE58RJSi2etjhFCOS0bLtOe165bLNY1qAAovBY231ARHYwzox5bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Hq-BY6v7jwyuvbep-2IxUawV_KxYC8TlqvyUrD549pT82kB3CPqPuw>
    <xmx:Hq-BYyeOUT3hIbwbDlfQYV_Ubi2vsqA1fDsZ0UhEdoFlJ0y2BOf2Og>
    <xmx:Hq-BY-0sS8Dv4TgqYzM9hlT79gs7Zbw8k9p_v6V8uD4eeRCdDmjooA>
    <xmx:Hq-BY6TRt4N3yvc4Xh9sVSc3b52Xw7IJW0LKw8apnyTfB1WRshe_Bg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 01:15:57 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: Fix NR_CPUS range conditions
Date:   Sat, 26 Nov 2022 00:15:56 -0600
Message-Id: <20221126061557.3541-1-samuel@sholland.org>
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

The conditions reference the symbol SBI_V01, which does not exist. The
correct symbol is RISCV_SBI_V01.

Fixes: e623715f3d67 ("RISC-V: Increase range and default value of NR_CPUS")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fec54872ab45..acbfe34c6a00 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -319,9 +319,9 @@ config SMP
 config NR_CPUS
 	int "Maximum number of CPUs (2-512)"
 	depends on SMP
-	range 2 512 if !SBI_V01
-	range 2 32 if SBI_V01 && 32BIT
-	range 2 64 if SBI_V01 && 64BIT
+	range 2 512 if !RISCV_SBI_V01
+	range 2 32 if RISCV_SBI_V01 && 32BIT
+	range 2 64 if RISCV_SBI_V01 && 64BIT
 	default "32" if 32BIT
 	default "64" if 64BIT
 
-- 
2.37.4

