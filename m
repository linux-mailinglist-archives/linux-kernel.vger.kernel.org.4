Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2B7182FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjEaNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbjEaNoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C0312E;
        Wed, 31 May 2023 06:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41A563B5A;
        Wed, 31 May 2023 13:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D548C433D2;
        Wed, 31 May 2023 13:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540570;
        bh=Yf82SHwGrVuX0UvQMTsYcg5ZU/SYk+6Qnm6Aesvf6Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVHZVtNXwyQU0goE+Bz+/a4oXlC+VrydQNwyKKzbmIetuoSbHQie39TENwBF/Z7Xf
         ZVqHQgoQ4T0qQXG33eFfkQ5R8/oAF/X9clDrX2C+2FMRcxJm/sO5aoOazK+LxvWui7
         eY6VpyHxrP8Y+jNwINEeYsxs0iaRQzEw8KqxpV007UYyayn8TasgFcnniEHfX9L5o3
         iDvXWtPWRcSjOZJzCPOxdolFxEe8pHZlT8Ovtgwwr5LU6R/r9cKwPKRQikUH8J7qA5
         IVt37GUpiG5o7dNV9VhsuqGyIhjXxeLXZ6u9eRJVn/qPqNKKCqONSDPBLvDDvj7z67
         jrkRQBtmaRwmA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 24/33] MIPS: unhide PATA_PLATFORM
Date:   Wed, 31 May 2023 09:41:50 -0400
Message-Id: <20230531134159.3383703-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manuel Lauss <manuel.lauss@gmail.com>

[ Upstream commit 75b18aac6fa39a1720677970cfcb52ecea1eb44c ]

Alchemy DB1200/DB1300 boards can use the pata_platform driver.
Unhide the config entry in all of MIPS.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b26b77673c2cc..2f5835e300a8f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -82,6 +82,7 @@ config MIPS
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
+	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.39.2

