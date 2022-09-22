Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903AA5E5AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIVFru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIVFrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:47:48 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C8DB4400
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:47:47 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4AEC73200A14;
        Thu, 22 Sep 2022 01:47:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Sep 2022 01:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1663825664; x=1663912064; bh=HTiACL8xrBd4oR3VgelAWNmCL
        H9hEi9gj1GAvInP2lQ=; b=oipLhFsV9rqwxDrBkS3KDOHEhF99HeDkCi1vqif0X
        vr2qEqDK9RW+tbo9mXU6D9Gj46z8c7G9/fp3aVnvdL1+kqlrwG680MqfXm9D91Wj
        aol2zHNoJWeIEVLWbl8ULPIUSXWpAEF8FhDAdtyvYUX8nSrIDxY/TFEiYuFZ/ul2
        kB7XMPTwDL74rx5qhPS1bSVrX0pngK6X7b1Wqgh0qFa31C48FxzCq0AS8XDICIMX
        hgIOGiJkR9kFW5CZk21fLcFythybFIqJjGJ8sqK9SJKS6TL++f8ml/z0TTVdeIEs
        RWPRBQJ2K99TePujBh85aUO31AFZHd1PTYwenGQYRs9vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1663825664; x=1663912064; bh=HTiACL8xrBd4oR3VgelAWNmCLH9hEi9gj1G
        AvInP2lQ=; b=cKNFiLe88tNeOvaO76WvWVcGvB5gnX43RWuy3HO8uHb4x7JSHRE
        +1PEDXiKeCAa6EauCOV+vegcnn6OaYMwh7BM78bf8CYxeWmECN/UoArsxQwUGoRO
        2Wvm3HmZPJknRpu11NvZqkuzsC754PqrPY8lAuExkP9Y7Z1j5NTOlEw9vDKkam2K
        ALTyJfTpjBMqyQXGIsZHXNc8Qd1RjP7GVCBs1mgiKo0ARlWOQ2eCSnb9NKyZD3/n
        V4QprjB+6cspHqgt4TJLJqP8KZ7XhvyyV5zHgej68TdKgfDSOukB2505nPvsdgBr
        j5tOIDvjJRQdo5Ld2i71SSdi+JQ0VgVYVuQ==
X-ME-Sender: <xms:APcrY9LSpDi1VSLXRVONXWFwG-_Z6pOKHDrwYKucG8IMWpDSReiyOQ>
    <xme:APcrY5KLJPF-xco5O87ToFXzhr77wKenMJNVpwvgLH6rYhdb1dSlnmia-fKSujVGq
    f16TlmgGw0aVRqJJw>
X-ME-Received: <xmr:APcrY1vx7L_Zc2RQn4T3wx2iHmJiqvkEcaFCGKRTqpK3EqywWGaJXvI9T1qRl8L_wk7EB9qzn2zfAFpqYTdIL6YCtaiFVv6mALDXjTiOtO5B_F0vvFJBWWpTE9hm1cbRODd8gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:APcrY-bxgUf2O0V3R4dmTMnOJzZ4eB_PymG_VxaLkVzo8a08OPOAMw>
    <xmx:APcrY0Zn9OGH4O4qRlkZU5Q2_YN8adMoG-fjeclP8WyqXjlaI0PuBg>
    <xmx:APcrYyB5RzPBglYtcX1PEdQXahpgDf8KwYLm8nMrwp20VbD7uA-9bQ>
    <xmx:APcrY5OQFJ5hdE9tELmOj953L6qcRViyId5DvCRZtZAEiLx8mZ9S9g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Sep 2022 01:47:44 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] riscv: Fix crash during early errata patching
Date:   Thu, 22 Sep 2022 00:47:41 -0500
Message-Id: <20220922054743.30159-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

Fix this by directly using the underlying kernel_mapping_va_to_pa().

Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/errata/thead/errata.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 202c83f677b2..83174f13783e 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -76,8 +76,9 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
 		if (cpu_req_errata & tmp) {
 			/* On vm-alternatives, the mmu isn't running yet */
 			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
-				memcpy((void *)__pa_symbol(alt->old_ptr),
-				       (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
+				memcpy((void *)kernel_mapping_va_to_pa((unsigned long)alt->old_ptr),
+				       (void *)kernel_mapping_va_to_pa((unsigned long)alt->alt_ptr),
+				       alt->alt_len);
 			else
 				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
 		}
-- 
2.35.1

