Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6309F70E4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjEWShy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbjEWShk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:37:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC71B1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 11:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C4962DAD
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 18:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B48C4339C;
        Tue, 23 May 2023 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867049;
        bh=EQ00lv5/W8EGFC0nJWEZGEzEXY5+IAnxZI57QWN4yuQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mv1sJt9juz0nueQ4tDJU9sjLCGuhvRj9F0PESg1tOvIPTmHgTps7t/2+lzMrc9z0i
         Uv0CmzSW+4Pi2xr8YTqHZCKgcC0vXYMdNZcb0PnGuIM06hURR9ds8eBnOGDLoduUS5
         V9wZoKX4uyVFM7UP16iNoxj0M9NeYDP1rN59MHQ+gsDR2Yx60WjH4QGZBL6ix2CB1A
         Od6oydfa/oCqqNZ7sBcC7Yukjc2ZU64voPVSrzg6RaxhdqdzWdcp/mmrxzQSnvSWvI
         qS8183nq5XbbhiE3Eb6r9clDxc0wxBIDUQAiq7TsaiRp0hemnu1wYeQT5rRPZHTF9O
         Yzo7XpamKm1iw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 23 May 2023 19:37:05 +0100
Subject: [PATCH v2 7/7] arm64/sysreg: Convert OSECCR_EL1 to automatic
 generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-arm64-syreg-gen-v2-7-4c6add1f6257@kernel.org>
References: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
In-Reply-To: <20230419-arm64-syreg-gen-v2-0-4c6add1f6257@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EQ00lv5/W8EGFC0nJWEZGEzEXY5+IAnxZI57QWN4yuQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkbQfUOJFmOLMG7nJxW7pEg75iGvryikvlRYKtIemc
 CBFf1hOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZG0H1AAKCRAk1otyXVSH0EX8B/
 4v1es9OfIXLT09KjiU20Tkupvd1plG9Rims05p7rLWOxpxgbadoRH674jh8V5NI4UG29CFDXLvLbn1
 kpt3UZBJllP3xkrHvn13T8mlSwrbscjeMD8HA/oCh1IW2AJBAcRUj/ZZA17nQ9bbE7cAh6ZAc9M+OV
 wI8JGyfdrmzI6DPdqQdGTdAMWh4Zcg90hxeYLirC/v97qpb83TGCcC6EZX+yZ7+jj6zEnNTR8vtJY0
 6rovWvaJG6P+eG8/N7lcwvVsFnjzlwQwqDTlwZ/xfErv3aWGD+gNnTcY9kGqhRIlFhGXf3iIIdkgU2
 uklhKKnA5ruLtjPCHfeA2ICnzgaoqU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert OSECCR_EL1 to automatic generation as per DDI0601 2023-03, no
functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 1 -
 arch/arm64/tools/sysreg         | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d9711f1e47b2..23a17da500a4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -134,7 +134,6 @@
 #define SYS_SVCR_SMSTART_SM_EL0		sys_reg(0, 3, 4, 3, 3)
 #define SYS_SVCR_SMSTOP_SMZA_EL0	sys_reg(0, 3, 4, 6, 3)
 
-#define SYS_OSECCR_EL1			sys_reg(2, 0, 0, 6, 2)
 #define SYS_DBGBVRn_EL1(n)		sys_reg(2, 0, 0, n, 4)
 #define SYS_DBGBCRn_EL1(n)		sys_reg(2, 0, 0, n, 5)
 #define SYS_DBGWVRn_EL1(n)		sys_reg(2, 0, 0, n, 6)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index e18ae1df41f4..41462785020b 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -93,6 +93,11 @@ Res0	63:32
 Field	31:0	DTRTX
 EndSysreg
 
+Sysreg	OSECCR_EL1	2	0	0	6	2
+Res0	63:32
+Field	31:0	EDECCR
+EndSysreg
+
 Sysreg	OSLAR_EL1	2	0	1	0	4
 Res0	63:1
 Field	0	OSLK

-- 
2.30.2

