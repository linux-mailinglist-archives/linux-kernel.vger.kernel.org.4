Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A26269B9C0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBRL04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBRL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:26:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181F15CAF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:26:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A5C460B7A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D2EC4339E;
        Sat, 18 Feb 2023 11:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676719611;
        bh=RoXrwfU/s5vurCwlxvo8Vd+Lw1JXCW4diLyk4VZ6JDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpN4RX+zYfFJn15etn06qSov77BUIqo5+WG2LPPmev5iERncqKwxALpHcWNFZzpfh
         h8zMdh5a2x9pLQAcVh/AHUIJWRLEITbqgwMU6KQIU46ui/piXprYQoJeo4qjO5tfvu
         iLCFnBIclwFFOotp+LrKfZTWZFceOOsKmlv7rB04diNrqrprJrVMfA+GRLht36JyKv
         2twMGTNM1kV4kQdGWNFg+tqsgPiSK0vmi0gQMJUfvL0sjSmtZDeGzpQaLH3qwkFIwT
         Wk6jzpaVpaqIpAAyLwyDc7PcXfGoC/CrUf22SqCUljpmRrcZQfbX/T8Mz+Uia848u4
         LhkYfCK8TnB8A==
Received: by pali.im (Postfix)
        id CFE42CE3; Sat, 18 Feb 2023 12:26:48 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/8] powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
Date:   Sat, 18 Feb 2023 12:13:59 +0100
Message-Id: <20230218111405.27688-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230218111405.27688-1-pali@kernel.org>
References: <20230218111405.27688-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

