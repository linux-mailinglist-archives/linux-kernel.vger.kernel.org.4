Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DD673CFF5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjFYJ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjFYJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:58:11 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3075E78;
        Sun, 25 Jun 2023 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1687687079; bh=H4NWls1bUMGdPdN2OveQqxUMkhksKubc1e0oOz7s4Zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sHDre7+MIxe4WQ9QS0lzPx9Dumw9urre45a1mvqRpkjtJDoLDxkzHMPjfE2HZVtFf
         D42CXGxQnJjuBmQwADvU4RY2meRUwyzlTkSahMQ7vkFUu+mEA0m/eFxMh77v/zMZdY
         uYXa4Y64sAkFaB33r0rvJAsQ818oKanHu7sbiNeA=
Received: from ld50.lan (unknown [101.88.25.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 44E61605E5;
        Sun, 25 Jun 2023 17:57:59 +0800 (CST)
From:   WANG Xuerui <kernel@xen0n.name>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 8/8] Makefile: Add loongarch target flag for Clang compilation
Date:   Sun, 25 Jun 2023 17:56:44 +0800
Message-Id: <20230625095644.3156349-9-kernel@xen0n.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230625095644.3156349-1-kernel@xen0n.name>
References: <20230625095644.3156349-1-kernel@xen0n.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: WANG Xuerui <git@xen0n.name>

The LoongArch kernel is 64-bit and built with the soft-float ABI,
hence the loongarch64-linux-gnusf target. (The "libc" part can affect
the codegen of libcalls: other arches do not use a bare-metal target,
and currently the only fully supported libc on LoongArch is glibc
anyway.)

See: https://lore.kernel.org/loongarch/CAKwvOdnimxv8oJ4mVY74zqtt1x7KTMrWvn2_T9x22SFDbU6rHQ@mail.gmail.com/
Signed-off-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/Makefile.clang | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 058a4c0f864e..6c23c6af797f 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -4,6 +4,7 @@
 CLANG_TARGET_FLAGS_arm		:= arm-linux-gnueabi
 CLANG_TARGET_FLAGS_arm64	:= aarch64-linux-gnu
 CLANG_TARGET_FLAGS_hexagon	:= hexagon-linux-musl
+CLANG_TARGET_FLAGS_loongarch	:= loongarch64-linux-gnusf
 CLANG_TARGET_FLAGS_m68k		:= m68k-linux-gnu
 CLANG_TARGET_FLAGS_mips		:= mipsel-linux-gnu
 CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
-- 
2.40.0

