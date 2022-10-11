Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B515FAC07
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJKGCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKGB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:01:58 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD512AC4;
        Mon, 10 Oct 2022 23:01:57 -0700 (PDT)
Date:   Tue, 11 Oct 2022 14:01:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665468115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULRG9WjRWYkhn806M12bYVFkQhq5NIyWYQ37SBu+Uew=;
        b=f9OW5ZFD6RcOW9/pXUk4eqW6g3btkfY/+JBY/6hiFuy/q9vlzs+P1Bopu8vV7DhP2aIbvt
        Ax5wKEdZJSruB/Yg/81VcHbwxEyVokYXN/7IAsOdgUjIvDZF74qJA4kStJpoSwSUGtnaBc
        5XCIN2ybt6voHVhKLkyVh8XohOwaTjI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] docs/zh_CN: add zh_CN/arch.rst
Message-ID: <4e9675ac83a06f2597d069f44a94c4e2cbd7ab2b.1665467392.git.bobwxc@email.cn>
References: <cover.1665467392.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1665467392.git.bobwxc@email.cn>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu XiangCheng <bobwxc@email.cn>

Add an entry for all zh arch documents.

Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
 Documentation/translations/zh_CN/arch.rst | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/arch.rst

diff --git a/Documentation/translations/zh_CN/arch.rst b/Documentation/translations/zh_CN/arch.rst
new file mode 100644
index 000000000000..690e173d8b2a
--- /dev/null
+++ b/Documentation/translations/zh_CN/arch.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+处理器体系结构
+==============
+
+以下文档提供了具体架构实现的编程细节。
+
+.. toctree::
+   :maxdepth: 2
+
+   mips/index
+   arm64/index
+   riscv/index
+   openrisc/index
+   parisc/index
+   loongarch/index
+
+TODOList:
+
+* arm/index
+* ia64/index
+* m68k/index
+* nios2/index
+* powerpc/index
+* s390/index
+* sh/index
+* sparc/index
+* x86/index
+* xtensa/index
-- 
2.30.2


-- 
Wu XiangCheng	0x32684A40BCA7AEA7

