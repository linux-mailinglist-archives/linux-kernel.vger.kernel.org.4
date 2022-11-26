Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3A7639412
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 07:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKZGJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 01:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiKZGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 01:09:25 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107CC1F9EA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 22:09:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C38B5C00DB;
        Sat, 26 Nov 2022 01:09:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 26 Nov 2022 01:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1669442962; x=1669529362; bh=/r/5FKS1ZSeQJNg4RdB06WEIq
        +RLEgzS3SohRH6vLA0=; b=wk+gLi+sYjzoWtgoSLf0h9Rpl984GO8qgZR47uvCm
        drPMur6+dkSFLIjCcoyzpr4Ut+afuKw46R4VbU72TsdkV+1ZyKH3kl8jOSmivzYE
        C6sRaJpQFsv8Ftci3d6qhwkFrDYe10lIfPet2nimg9MS/7OQmlUDOVXMxcByf2ZU
        e5D6TxrMBkb+gFAJ3SFmUgo8y9S/LMkLuAm8D5x/3TWQZAtGJkoGTAXgN6qSQCnp
        yLOHMzumRfAVf0xw5s92WoUoB6prjeH/FBk/G7NrFMGE/F4DBO833YsqsmfqWgks
        lTV8PXIlwBQ6D+yxaHvXsBuHV+yRuXnef0bn1OCje0omg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1669442962; x=1669529362; bh=/r/5FKS1ZSeQJNg4RdB06WEIq+RLEgzS3So
        hRH6vLA0=; b=AGKRuj4YdIaqoDo9ZkVNaUCyAYqxFHYm1X3Ny79NuQ1fNwFiUg9
        RL1n8NqQzeoULAnJcuwzwF8+egi5nA5ZK5ioWyiOfHj/w1byYs7wG45RsnfQ2KIz
        Vw3y5c2jjHav3KfQN/psvMg+nGTC70NiwxJRH4O6I15+IKhlufiX4a+f3WqlPoo/
        8h/F28LC2cWc4gXTsKl6vaxAv4OHFRuyWkJCqvS/piXJjyU22MpNd9biLAocg8vs
        3IeLA/vwL9ae8iTC2chQFS+4DcMwNubRLoBMSugXs4gC67IG/qHa0sYAl+9x4E5n
        CtI/+HgVec2n6lrQu0oyJAY9zYjVZu7pLyQ==
X-ME-Sender: <xms:kq2BY09tzxltfKlUBS7ZKKjpQePRjX5Q93MsDbiyB0ChPmPWg9Hn1Q>
    <xme:kq2BY8ugUOiVS6nxMjWRN4WUZGoupFCKmXIhf5CHS8_xL0pQZOeftOjzqJQkjsv_F
    GQRb-v1WMjJXTARdg>
X-ME-Received: <xmr:kq2BY6AwT5cqHpqyQaampGRoPPqbqeAG1XGPGcURO8KpFvwcZb_zEewKVWCCwZ1ZfnqInnu3w6OMpzbpq6BvdL-AE2u0oC--D16PDW_v6g9_rKg8SHsysotCZLbrRNuA14QM_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:kq2BY0fgymp1uoKDkrcQFEy2L-JOTWeCSbXM-AIbmrlWNZAzRa2WGA>
    <xmx:kq2BY5MMmU0E-2vgFS3KlFxZVMLkO_sCTMuzSvH0Q6r_aJSJ_e56pg>
    <xmx:kq2BY-kI4R2kTnxAgE7jGLXki526qSxoxe3x4s48rRV430gxQYTSXA>
    <xmx:kq2BY1DEvv_rPSgihWwu0dMUcwqDPGvRExZKK3H3kbB60jCK4341_Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 01:09:21 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: Fix crash during early errata patching
Date:   Sat, 26 Nov 2022 00:09:19 -0600
Message-Id: <20221126060920.65009-1-samuel@sholland.org>
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

The patch function for the T-Head PBMT errata calls __pa_symbol() before
relocation. This crashes when CONFIG_DEBUG_VIRTUAL is enabled, because
__pa_symbol() forwards to __phys_addr_symbol(), and __phys_addr_symbol()
checks against the absolute kernel start/end address.

Fix this by checking against the kernel map instead of a symbol address.

Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Fix __phys_addr_symbol instead of avoiding it in the errata code

 arch/riscv/mm/physaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index 19cf25a74ee2..9b18bda74154 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -22,7 +22,7 @@ EXPORT_SYMBOL(__virt_to_phys);
 phys_addr_t __phys_addr_symbol(unsigned long x)
 {
 	unsigned long kernel_start = kernel_map.virt_addr;
-	unsigned long kernel_end = (unsigned long)_end;
+	unsigned long kernel_end = kernel_start + kernel_map.size;
 
 	/*
 	 * Boundary checking aginst the kernel image mapping.
-- 
2.37.4

