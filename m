Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FCF6A077A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjBWLhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjBWLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:37:01 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDBD4E5D5;
        Thu, 23 Feb 2023 03:37:01 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A7D0132002FB;
        Thu, 23 Feb 2023 06:36:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Feb 2023 06:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677152219; x=1677238619; bh=SE
        VSeLr4YeKzVQBfQj2m8k28yjFkBt6zYOmqTsWGRHk=; b=tkgwUTQMf9ZUqyL7Pm
        dCQxjPqaAiYgMW3ulsYsZMv56+ATiKJ90DbWp96j/ASkWraUbkOkVVEtLxgkRqhB
        5KISa4zdGtMFV62h7FCIw9lnKYrSarmCPycp5A2mFeeKuNctbfdFd9724x8lR0k0
        puU42biv/3ngK6RsNcOuB0qm4RQfeCW9Jvh3yxEMhm9H13AXW4jVluO5nMxiwe/r
        AJumXHNOzF8tNCZ6Krb+fwSkMkUGp0x3RbnvV5yk+86Nbby2l7gsRagaiYE/XByl
        UscRAIJerz+p3Z2iHPJhjvnHinwUL/a3M2qII2YbPHXbevmLzB15VpkoB/h/jhq+
        J0yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677152219; x=1677238619; bh=SEVSeLr4YeKzV
        QBfQj2m8k28yjFkBt6zYOmqTsWGRHk=; b=n7K9bHnbvf+Sgdso3+qV9w/+4j4Wx
        P6V0HoS4s8nJerg8xH5n0LYdKLLZzA6bik/CeEsVPFS/AeO9T5UMBjF0c19NSq6l
        sGzMRrSmtF9TxVuWOoKB2JvT3Hiq10n/oHw+pRfoCUCitlf2Gvzt+rnoGvsO/9Fo
        vJ/HBNICnYsaRPy68KP6EmHJysUxZ24Lk+s1TstbLUS15XnqZByj7vBv5KS4YM7c
        w3a6JBQ4Rw8FA0KlXoVKutX+6He5pxE1+qFqUDy0zt6YVgQNv0LbxUnQ5tRV9jma
        GoilnAslD9j2Z+kX7piSp9V/3aAf2Qt8QpospLVNwCAqOyisIPIwncuvA==
X-ME-Sender: <xms:2k_3Y0LeqdD9VES44UJcs-iNFK0oPlM7azFd0AQ86qt93aoFnRctlw>
    <xme:2k_3Y0IK0d6nFckInNH4-14XXUHL_vkqQxgXupoNmAigFkFrVqWoisxlAG6370n7M
    xDxzLf1i7CI_ozpF9Q>
X-ME-Received: <xmr:2k_3Y0sCcVZTOmBbc19IMQjH1-DGV-O3XVtxGUOMyyjNrvBDs60YWe32rY19FLR5tCHzoXESMcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:2k_3YxbINMIlIGBy3Hj4IwM9eWgYDemlsNVp-aZSERGBtFmXqWb5Gw>
    <xmx:2k_3Y7a5yOBpO5VPDzRNVy6Tj2bc4AGYcC-jWnNw1VabkMo7Xvw6uA>
    <xmx:2k_3Y9Ay_5QHyHsXt5CiH-cKhawcVgA5qJHeqBWbmvakiL5L-eiEZw>
    <xmx:20_3Y5CZBxjeBjCCvPi3m55ULkI05ZiSp5TbTPX6a54wtqpCs7SSHw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Feb 2023 06:36:56 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/5] of: address: Fix default coherency for MIPS
Date:   Thu, 23 Feb 2023 11:36:40 +0000
Message-Id: <20230223113644.23356-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230223113644.23356-1-jiaxun.yang@flygoat.com>
References: <20230223113644.23356-1-jiaxun.yang@flygoat.com>
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

DT-based MIPS doesn't use OF_DMA_DEFAULT_COHERENT, but
might override the system-wide default at runtime.

Use dma_default_coherent to override default coherence for
MIPS.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/of/address.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 4c0b169ef9bf..c105d66a1fa4 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -1105,6 +1105,14 @@ bool of_dma_is_coherent(struct device_node *np)
 	struct device_node *node;
 	bool is_coherent = IS_ENABLED(CONFIG_OF_DMA_DEFAULT_COHERENT);
 
+	/*
+	 * DT-based MIPS doesn't use OF_DMA_DEFAULT_COHERENT, but
+	 * might override the system-wide default at runtime.
+	 */
+#if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
+	is_coherent = dma_default_coherent;
+#endif
+
 	node = of_node_get(np);
 
 	while (node) {
-- 
2.37.1 (Apple Git-137.1)

