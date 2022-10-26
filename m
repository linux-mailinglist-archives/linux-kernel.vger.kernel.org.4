Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5652B60DEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiJZKlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiJZKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:41:33 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D6A033A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:41:31 -0700 (PDT)
X-QQ-mid: bizesmtp72t1666780860thlpjusd
Received: from localhost.localdomain ( [101.6.93.82])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Oct 2022 18:40:46 +0800 (CST)
X-QQ-SSF: 0140000000000060B000000A0000000
X-QQ-FEAT: rGm7xzoh3hl3ya5sdSHuKGIIU47rr/fjDyiOLrmcLON1wIvSddcUSf+DDWDU6
        NACAphMLViC2kF9KRr/8fPaM9cG+p9AoXQtAfI/yZNMEcQt5G3zgMiOtXUG3OblLtxq2+b2
        bs6Aen9/b7YT8b1MIlWAHuIFvvTZFlQ+gOED3tByPWzVdNFEkBTjQA+9fVV5g2RZBfciQEp
        hdm8N7btrbiOzOzHqflybP6uY01MZjrMchRycFsc/a5GbTfz6n4uZcQK2lWT2IxfJUYEt4E
        M1n+M1rT5VlnH0yy/F1nwzBtxiGlHz5Jw6enyciIzBCbkp2EPvEEiOLMW6wshtOOFQ2QncE
        0x/NKiFIAsEJQtTllmhLBFWQpzN6QHVIYoRm269ADO9ovCNFc0FKtx431pFRzmFk3t9PR0+
        wgJjvPN4/e4=
X-QQ-GoodBg: 1
From:   Wen Yao <haiwenyao@uniontech.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, dennis@kernel.org, tj@kernel.org,
        cl@linux.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Wen Yao <haiwenyao@uniontech.com>
Subject: [PATCH 2/2] riscv:kconfig:select HAVE_CMPXCHG_LOCAL
Date:   Wed, 26 Oct 2022 18:40:15 +0800
Message-Id: <20221026104015.565468-3-haiwenyao@uniontech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026104015.565468-1-haiwenyao@uniontech.com>
References: <20221026104015.565468-1-haiwenyao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We implement an optimised this_cpu_cmpxchg API,so select HAVE_CMPXCHG_LOCA
to open cmpxchg-local feature.

Signed-off-by: Wen Yao <haiwenyao@uniontech.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b48a3ae9843..8e19df5a8227 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -88,6 +88,7 @@ config RISCV
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
+	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
-- 
2.25.1

