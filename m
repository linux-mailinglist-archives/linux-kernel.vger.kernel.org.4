Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54475F4F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJEFPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJEFPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:15:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4060A5B7AC;
        Tue,  4 Oct 2022 22:15:41 -0700 (PDT)
Date:   Wed, 5 Oct 2022 13:15:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664946939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoBup4w991szcaY2ZysAfm7F7pOzbhyPnsKjuKDbP3Q=;
        b=EA6DjMyvwiAeLSpZa5fFdy5gkuCknFXJ7gfqlxRtxDIcDKa4r5SfeC39FiNv+4S3sJeWmU
        HW8MLd4D0OqWOMiYRlowUfz6IMZV3qG5mTuqLH1GcdYRGrXz2+K+YuZSiyFvfB6LUGPEL4
        AEiHMQ3Ksgs+ktl6AKHglFSUji+vKb8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] docs/zh_CN: add zh_CN/arch.rst
Message-ID: <13b46f164759cb88a8bc56e2e558e534d52523be.1664945550.git.bobwxc@email.cn>
References: <cover.1664945550.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1664945550.git.bobwxc@email.cn>
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
 Documentation/translations/zh_CN/arch.rst | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/arch.rst

diff --git a/Documentation/translations/zh_CN/arch.rst b/Documentation/translations/zh_CN/arch.rst
new file mode 100644
index 000000000000..1603f076b14d
--- /dev/null
+++ b/Documentation/translations/zh_CN/arch.rst
@@ -0,0 +1,30 @@
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
+
-- 
2.30.2


-- 
Wu XiangCheng	0x32684A40BCA7AEA7

