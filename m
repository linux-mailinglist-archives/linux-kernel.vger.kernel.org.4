Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E22C6F22EA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjD2EfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 00:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjD2EfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:35:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB732D73
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 21:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Gt7eAaz60O9ddrcN7cZOXzCyhIJbxCHtRLFEQS4tDho=; b=rZ7zY8x3udSIsRS60oUKFPwvfx
        gpI3gz6YFpxg91ZNSlKyjOwuxKiGKVFZGHjvnWFqTPD6hG/a3aLorpqIaHlpA8fW7J0APmYKV92d0
        UUpHMtGfaWsseQNmZCCfEw/qrwqkEzaCzIZK0TjYeZY26GKV1VRxeV/dRVVfKjyMDaB7dJMMf5aW3
        iAzgUzbDVdpHm3lbdi054CMnrIgJFsajWfzMl144/Zuf3KuAcLdTaCDsBPzXEvBCQb7osEVA0kKtM
        oTsuc33hJR0wKhnfAX9VI/8upJRKb7SNGxfkKYAKOMdxzl4P6jZ3sRsMCJX2PXzB/zpWDYkxbYVKK
        o9GCZdQg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pscIc-00CE7S-1J;
        Sat, 29 Apr 2023 04:35:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: delete empty config entry for PPC_86xx
Date:   Fri, 28 Apr 2023 21:35:03 -0700
Message-Id: <20230429043503.19385-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop an unused and empty "config" entry for PPC_86xx.
It has no keyword entries under it and the following line's
"menuconfig" for the same Kconfig symbol is what kconfig uses.

Fixes: d8267c1a3686 ("powerpc: Add 82xx/83xx/86xx to 6xx Multiplatform")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/86xx/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff -- a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-config PPC_86xx
 menuconfig PPC_86xx
 	bool "86xx-based boards"
 	depends on PPC_BOOK3S_32
