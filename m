Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0896FFA55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbjEKTjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239134AbjEKTjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:39:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6763AD3A;
        Thu, 11 May 2023 12:38:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D2016511A;
        Thu, 11 May 2023 19:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F25C4339C;
        Thu, 11 May 2023 19:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683833921;
        bh=700v+BH6np3ZE2csfybYbvwJxbWyFN/w9HcRP7KclC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FZO9/I7GCdmbC9TB0RLGelNbx5t+VROPiRUrpFCZEn4cXEptRbOcN7ffQWCuHncNY
         eKJzoVhn3dX+ex0sx7H97JznNUQta8OAt0dAjdD7sfHuRtulMVWYBBFBjbASBF5YdS
         w7ikivl+nBgANcsjLxhHuyjs9726kY6KjeuSu+2o4yq5HanNeMweeYgTe5/9v8rmnx
         AE5/byR2Vuy+coR2x5yIdYd4Fx3yJU+D98FQOpcc+pq1Ti/za49n3QgCY8VHIt6b8Z
         DfZscg5XSCIBJVxgf3Is/B9IqeKPp8gcw6wFWG2G2ievQfe4SRW3yBhL1ZgYRD8BzA
         6Vu20hF+n/PIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 08/11] LoongArch: Add ARCH_HAS_FORTIFY_SOURCE selection
Date:   Thu, 11 May 2023 15:37:51 -0400
Message-Id: <20230511193757.623114-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511193757.623114-1-sashal@kernel.org>
References: <20230511193757.623114-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qing Zhang <zhangqing@loongson.cn>

[ Upstream commit d4c937c2a57bbba24790be6fe7a791456f5fbb60 ]

FORTIFY_SOURCE could detect various overflows at compile and run time.
ARCH_HAS_FORTIFY_SOURCE means that the architecture can be built and run
with CONFIG_FORTIFY_SOURCE. So select it in LoongArch.

See more about this feature from commit 6974f0c4555e285 ("include/linux/
string.h: add the option of fortified string.h functions").

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3ddde336e6a56..3e5d6acbf2409 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-- 
2.39.2

