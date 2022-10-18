Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2F602A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJRLzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJRLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:55:27 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254DE9AFB0;
        Tue, 18 Oct 2022 04:55:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666094125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgQBXm1dv4ujn38yEqX7tGehxSC+vaQSz42cTrCDBX0=;
        b=cmkJgAm9Z/g95AzBIckx9+AySMDFOs09DIvHgoRMO0cwmSHUbHBWLut/zsjiJa0zLq/jRg
        4QF0KlMvu3STax+6Pky0JWJ1Zf4R2XpahP7wnnlmMR2HBe0YZRTpO60drjYC6fFeJWpKyb
        IKRZWfOBl+KyB2ucsvAghI5zxhpvd9uWLaQ0if/zk1itWq9Nfhh0RfTkzvbdjYDfoiBooB
        GRRyUtrAfpb4fHh5OXgEbRfRYYOSmY56HLdXgGKKAorMQWM4L/eNDX5dXUDeutw80poyun
        gokBznO3ehIg2yCi1JgEOiXMVQQCBGsFUOaj4PQGM4zCl3HujVzysFqVPGpnlQ==
From:   Rui Li <me@lirui.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>, Rui Li <me@lirui.org>
Subject: [PATCH v2 2/2] docs/zh_CN: Add userspace-api/index Chinese translation
Date:   Tue, 18 Oct 2022 19:54:53 +0800
Message-Id: <88e6c1390068bff71e16ebd375e684d8e663dee2.1666093699.git.me@lirui.org>
In-Reply-To: <cover.1666093699.git.me@lirui.org>
References: <cover.1666093699.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
Changes since v1:
- Align title
- Change some translation
---
 Documentation/translations/zh_CN/index.rst    |  2 +-
 .../zh_CN/userspace-api/index.rst             | 51 +++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
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
index 000000000000..df1e1572e3f4
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/index.rst
@@ -0,0 +1,51 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/userspace-api/index.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+=========================
+Linux 内核用户空间API指南
+=========================
+
+.. _man-pages: https://www.kernel.org/doc/man-pages/
+
+尽管许多用户空间API的文档被记录在别处（特别是在 man-pages_ 项目中），
+在代码树中仍然可以找到有关用户空间的部分信息。这个手册意在成为这些信息
+聚集的地方。
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
-- 
2.30.2

