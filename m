Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1E4718352
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbjEaNt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbjEaNsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:48:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D615DE43;
        Wed, 31 May 2023 06:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 088FE63703;
        Wed, 31 May 2023 13:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3129C4339C;
        Wed, 31 May 2023 13:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540627;
        bh=svi6qGxnp1fm22+G3/CI2v8WGSS1aZUBN7qrdBbVMgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpTDsp4WxZUuaCuN5BXVf4enU4UdGHTp9uIc2EHiTbOIbCQ4P5CQHMKP0OqWUffk1
         ji9JRvIRyC9+MjZwPdQzae0d8nXp0tHXfe7LcCmWBbuyx1yK69cem9S3SIBme4UgBl
         7DtzfNey2VlzN6mqqW0EtbitnU9DxEWxONKDkKwuWh9HNiYDcBM/c65/a1GS00CVoi
         pyikvFcLv9k8YpW2OR2PjToCvMnt+cq6s5kg262Fntto5veE1j0AK/fOZHOAiRBqK9
         lcZxFUZaYSanM/bGKlEWyzyP+AzfYj3d3Ck7fqrhEfI4+hyLTWg1rbBzdDiI5abpl6
         tlQ+gAOQslj2w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 17/24] MIPS: unhide PATA_PLATFORM
Date:   Wed, 31 May 2023 09:43:13 -0400
Message-Id: <20230531134320.3384102-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
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
index 393eb2133243f..56c0f75e7a76e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -81,6 +81,7 @@ config MIPS
 	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
+	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-- 
2.39.2

