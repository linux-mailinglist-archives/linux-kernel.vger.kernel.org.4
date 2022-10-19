Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC16047CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiJSNpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiJSNob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:44:31 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432A0199886;
        Wed, 19 Oct 2022 06:31:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666186257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjuWJVNhkBvpGyB36JX1wwbKTh+Ncxz/qy06/EtkAxA=;
        b=JjwMk2ka730u9Fk4Et1ZdFdXTU80c10Qs5qqtXUSf9fROQhlCbPRNA6cQfJqVhkPyzSCXe
        D4rxGmSexAj0R7lmY2RdqZchJzGMDJvOc8ehTrTSICiYLD5fUOU2bhIeP+d/Dp2vNT7vYL
        nTBrYUHDgumpRmFVeZBhbxHqoWoDa6xL3lgSBBImoXk7oRou1Bb/l8i1tzHcjY+1cNQ0zc
        oFvzfb75mK1S1PriJxpuX4pGPNTY4aBPVBpx7QVuks8i3pgmotEW9lOWBR76oFuje57/vH
        KcTsoBOjPleRsFMJL2W+Me4IcfegXjXQcPUvC4eFbQRAuygsgTz0I7WgFcqNvQ==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH v3 1/2] docs/zh_CN: Add userspace-api/index Chinese translation
Date:   Wed, 19 Oct 2022 21:30:21 +0800
Message-Id: <76b86e687034d5347e1e49c4acfc28e9c45abe47.1666185911.git.me@lirui.org>
In-Reply-To: <cover.1666185911.git.me@lirui.org>
References: <cover.1666185911.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate userspace-api/index.rst into Chinese, add it into
zh_CN/index.rst.

Signed-off-by: Rui Li <me@lirui.org>
---
Changes since v2:
- Change patch set order

Changes since v1:
- Align title
- Change some translation
---
 Documentation/translations/zh_CN/index.rst    |  2 +-
 .../zh_CN/userspace-api/index.rst             | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+), 1 deletion(-)
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
index 000000000000..3b834fe7e33b
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/index.rst
@@ -0,0 +1,46 @@
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

