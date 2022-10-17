Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9AC601033
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJQN1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJQN1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:27:38 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D72D631D8;
        Mon, 17 Oct 2022 06:27:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666013255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XT97/4ianI21dvpEGBZUSrkd+v0AEJCqTHZ0j4rZrRE=;
        b=AbtJiFNm1eCMnjmcmIdRcfMOy384xBxDlZ5YNpOkfb9P5ZhTJX1rrnjn/egQvFwOQ5oadR
        3cEgAZVgwEZ2QDjv/lUxGpT3paqEatsUNNB8sCVk5d6Jh2UknkR7sI+0Crg8tOslRt4r4e
        SCMpviQCGJXKEbyACempE+XvzQGEQDKIHhu5UycExtOrWNf6vcUJu7WLDFaltV6HM6XBih
        8/nYf13ZBNkXWzaeWOhSpC5ouDnqfLzgc45XO7fUDJleQWH5q71cWUwUwNsZBqSCsTSjUg
        L00YZRJgltLmzYgYxdr1q/Y800cwG1qKE7LI8J52PWQDG1oyJinq0s/hkHaMEw==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rui Li <me@lirui.org>
Subject: [RESEND PATCH 2/2] docs/zh_CN: Add userspace-api/index Chinese translation
Date:   Mon, 17 Oct 2022 21:27:05 +0800
Message-Id: <455e3da0b5b07058d2b7d09c74388b4789ccc877.1666009558.git.me@lirui.org>
In-Reply-To: <cover.1666009558.git.me@lirui.org>
References: <cover.1666009558.git.me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

