Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC8655B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLXVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXVQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:16:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7D8A446
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7998B80139
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 21:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A20EC433D2;
        Sat, 24 Dec 2022 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671916595;
        bh=RoXrwfU/s5vurCwlxvo8Vd+Lw1JXCW4diLyk4VZ6JDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cR6u70y95h2R+t1gaD2QDSB2DCABAVBiIAvdmhHnHOXLA5fddVSelnAd4kZykVEg8
         h7TMpEtoktLZzwbmGMs2zY1albKs0iPtHZXmVSodhety7X0wFKGs6rYvEPrdiDJhdD
         lKR4zeg1DGvqF4Z0lW6o03pBsmCOh3Y4BUcD5egPGfpQVUAD68yM7bdTzKdmX1L0an
         lIs8V7x41KBM0lxjpe3+P/Mq+OUW0+5Zx47HsQyFC7H+oHt7oI0vCft9qyAWfTXldL
         WklfcVxPRxfcVsHjtyppKlGSOt+khxqXLSkU6fqQJw15cSrXVGZv/ncesqqkj4od/B
         juRWKj41jIDRQ==
Received: by pali.im (Postfix)
        id D4C5E9D7; Sat, 24 Dec 2022 22:16:32 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
Date:   Sat, 24 Dec 2022 22:14:19 +0100
Message-Id: <20221224211425.14983-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221224211425.14983-1-pali@kernel.org>
References: <20221224211425.14983-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function mpc85xx_ds_pic_init() is not used out of the mpc85xx_ds.c file.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index f8d2c97f39bd..9a6d637ef54a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -54,7 +54,7 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
 }
 #endif	/* CONFIG_PPC_I8259 */
 
-void __init mpc85xx_ds_pic_init(void)
+static void __init mpc85xx_ds_pic_init(void)
 {
 	struct mpic *mpic;
 #ifdef CONFIG_PPC_I8259
-- 
2.20.1

