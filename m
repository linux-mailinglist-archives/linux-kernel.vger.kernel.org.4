Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8855FFF0A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJPMIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:08:36 -0400
Received: from mail-200160.simplelogin.co (mail-200160.simplelogin.co [176.119.200.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445B231EDE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=dkim;
        t=1665921541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XT97/4ianI21dvpEGBZUSrkd+v0AEJCqTHZ0j4rZrRE=;
        b=JNUEUrNdwsWxcdLSJ7c3RahxF2N+WOxt4aZprkTdRIVGm9yeqFlcG6Yg0ya/2uoE1Mwji5
        5+sU+0nUy/BEh0A9Gvc6kPIR4BCNPG0Hulx8ajawfLBnDBLH8eDolxNGHVJj9fNOVCR3x5
        zmOmUPRr928K9Qb25hrj9srpMBw/CjU=
Subject: [PATCH 2/2] docs/zh_CN: Add userspace-api/index Chinese translation
Date:   Sun, 16 Oct 2022 19:58:44 +0800
In-Reply-To: <cover.1665919802.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <166592154155.8.13781703774239604072.69288121@lirui.org>
References: <166592153626.7.4500669936128595360.69288105@lirui.org>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 69288123
X-SimpleLogin-Want-Signing: yes
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate userspace-api/index.rst into Chinese, add it into
zh_CN/index.rst.

Signed-off-by: Rui Li <me@lirui.org>
---
 Documentation/translations/zh_CN/index.rst    |  2 +-
 .../zh_CN/userspace-api/index.rst             | 50 +++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index ec99ef5fe990..272414971ce9 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -90,12 +90,12 @@ TODOList:
 
    admin-guide/index
    admin-guide/reporting-issues.rst
+   userspace-api/index
 
 TODOList:
 
 * 内核构建系统 <kbuild/index>
 * 用户空间工具 <tools/index>
-* userspace-api/index
 
 也可参考独立于内核文档的 `Linux 手册页 <https://www.kernel.org/doc/man-pages/>`_ 。
 
diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
new file mode 100644
index 000000000000..4f5bc5530ebd
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/index.rst
@@ -0,0 +1,50 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/userspace-api/index.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+=====================================
+Linux 内核用户空间API指南
+=====================================
+
+.. _man-pages: https://www.kernel.org/doc/man-pages/
+
+尽管许多用户空间API的文档被记录在别处（特别是在 man-pages_ 项目中），有关用户
+空间的部分信息仍然可以在代码树中被找到。这个手册意在成为这些信息聚集的地方。
+
+.. class:: toc-title
+
+	   目录
+
+.. toctree::
+   :maxdepth: 2
+
+   ebpf/index
+
+TODOList:
+
+* no_new_privs
+* seccomp_filter
+* landlock
+* unshare
+* spec_ctrl
+* accelerators/ocxl
+* ebpf/index
+* ioctl/index
+* iommu
+* media/index
+* netlink/index
+* sysfs-platform_profile
+* vduse
+* futex2
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
\ No newline at end of file
-- 
2.30.2


