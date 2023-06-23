Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8673B8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjFWNow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFWNoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:44:34 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE226BD;
        Fri, 23 Jun 2023 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687527858; bh=A/+xsnM5BmDYFUpJ1w+uRG48h4f/gI8zKnMGjRgeidc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjTUhw+2wYJEO4aFkjXMrZWLdyXKMr06aCIb9So6lhCFu6m/TZAv6HBWx8i3reXur
         7UPdVIMipxJQKanw4OrOCJi5+Tg57YV8zBuIM7lHjONv3TypbpUj8BLfatdj8jWaHQ
         IOshJ+oGJdDY+lIF0hd7KGMVMvHgDaXA+cKI46mQ=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B6473605FA;
        Fri, 23 Jun 2023 21:44:17 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH 9/9] LoongArch: Mark Clang LTO as working
Date:   Fri, 23 Jun 2023 21:43:51 +0800
Message-Id: <20230623134351.1898379-10-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230623134351.1898379-1-kernel@xen0n.name>
References: <20230623134351.1898379-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

Confirmed working with QEMU system emulation.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index c8e4f8b03c55..7c5d562b2623 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -51,6 +51,8 @@ config LOONGARCH
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
-- 
2.40.0

