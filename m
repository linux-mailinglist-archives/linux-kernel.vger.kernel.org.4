Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEC655B39
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLXVQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXVQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:16:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74319A445
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:16:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A5C060B0C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 21:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429B5C433EF;
        Sat, 24 Dec 2022 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671916594;
        bh=UD5jorQCVmKiXH0v3VkIP3iO7pPTI+aaxJhMgfUmopA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oc6cSSGgtRTQmJ86c8kAsul6M3Ygniaj0MO56wwfXbVITrjxApARWDw2K7umElNgo
         ATWv7q/bPgLcHXJLE6hNFIKdZaz1cI60NU6/8CFqqwYsOi3ruyJbSvPtRJPBlnMAdM
         Gw6jPpnWCgVVnXOm3NvCMpAN49KWZOYzZ9NOBHtUEwk2+jzSKWa6skt+5UsJeK6BLx
         n3+XPsXrDqdlui1E7FzFvDXr3IBGH50+dkFqV092+FLhQKL7I2pB5fSC9vcQtgyUW2
         1XHn5s5PgkSFWjF1na6LGTvnGeDlEx/FkP+UlgcQDBwBeVDWkBIgIUzq//sbcOsoSy
         qIwle/yYr65VA==
Received: by pali.im (Postfix)
        id C5B48720; Sat, 24 Dec 2022 22:16:31 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] powerpc/85xx: Mark mpc85xx_rdb_pic_init() as static
Date:   Sat, 24 Dec 2022 22:14:18 +0100
Message-Id: <20221224211425.14983-2-pali@kernel.org>
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

Function mpc85xx_rdb_pic_init() is not used out of the mpc85xx_rdb.c file.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index d99aba158235..b6129c148fea 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -38,7 +38,7 @@
 #endif
 
 
-void __init mpc85xx_rdb_pic_init(void)
+static void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
 
-- 
2.20.1

