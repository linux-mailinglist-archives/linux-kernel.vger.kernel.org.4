Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9F96FF53D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbjEKO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbjEKO4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:56:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095FD1161F
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:55:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA9664EAE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8E1C433D2;
        Thu, 11 May 2023 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683816882;
        bh=m1qZnLNUr59jqVFSt129IJlQSsREApIN+nV6IniNnNg=;
        h=From:Date:Subject:To:Cc:From;
        b=f3iBGLysT3/Tg8hZF+uxUcVGBiNhtwbgQFOmoK4Tsb5x88awMANbWTKy+IZSWjOs2
         shKULSIMuPI2qBE28g5Hw9xyOnQa6lhZrrVzLnXDA8EzugUiCtyMsR9S4IkVEbKdDb
         szOHnBxA331m0sRE/FqAW+Or9hCtFclgtP5qEtT9alXY1xjq6r+BzE0f0KgH+I1ehW
         CC8pfggW84q2p6ftAZrg1CdKIU1rpOO58HaylsS/Pu4NwhxZ0ThTfX3TlBuOQlMEgV
         Y6U8cEhMo1ZWXknSlzwijMvzP0JeRwr45jaw5ZQG7ATj+cKRGfof/U6Lc3piscx84w
         h2lXcLcdh165A==
From:   Simon Horman <horms@kernel.org>
Date:   Thu, 11 May 2023 16:54:36 +0200
Subject: [PATCH] soc: ti: pruss: Allow compile-testing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230511-ti-pruss-compile-testing-v1-1-56291309a60c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKsBXWQC/x2NQQrDMAwEvxJ0rsB2yaH9SunBsZVE4CrGckIh5
 O8VPc7C7Jyg1JgUnsMJjQ5W3sTA3wZIa5SFkLMxBBfubvQeO2Ntuyqm7VO5EHbSzrJgdjEGl8c
 80wNMn6ISTi1KWu1A9lJsrI1m/v57r/d1/QCFskshfwAAAA==
To:     Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow compile testing of TI PRU-ICSS Subsystem Platform drivers.
This allows for improved build-test coverage.

No functional change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/soc/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 8c2a1036bef5..2cae17b65fd9 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -85,7 +85,7 @@ config TI_K3_SOCINFO
 
 config TI_PRUSS
 	tristate "TI PRU-ICSS Subsystem Platform drivers"
-	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
+	depends on SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  TI PRU-ICSS Subsystem platform specific support.

