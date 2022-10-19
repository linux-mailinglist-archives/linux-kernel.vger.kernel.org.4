Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1026047CE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbiJSNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiJSNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:45:00 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910E11C38;
        Wed, 19 Oct 2022 06:31:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666186272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLONnTrgE41xLuoR7aINxfaHvykieYVHakm2mQu46pE=;
        b=KCZ3cXrxe+PB+8Vud62pouWmnw8EOrEex984T5Iqz55u/3CuMNV+j9NEpU0qmBBqMQwwno
        2kiDr8xHqGnAVtyDZjovRWv0xynLRDYgI2msDGiegwnTNuKz536SnCuyoLj24hxnyyAr2D
        /qnxY+I1brSoE4oqkqUtTBupqe+KRGPadrgYw+VEbMOQNWJZvtZr58lna8z8kSk38Cswmo
        Y+XyVQ3WoFbyprmYvjEfITuVJMZZfXmZslH86lkUfJfuxtzmwu1SLSIvwDoySbhb0+epnS
        BqCzGWNHZiEkOdizwMN6OBUqVj9xtYCxqOTZfMsuOqaTv/7kOdGXP7y9LVO9/A==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH v3 2/2] docs/zh_CN: Add userspace-api/ebpf Chinese translation
Date:   Wed, 19 Oct 2022 21:30:22 +0800
Message-Id: <cdd100d92752f76827fa7abfcd9903b857d71044.1666185911.git.me@lirui.org>
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

Translate the following documents into Chinese:

- userspace-api/ebpf/index.rst
- userspace-api/ebpf/syscall.rst

Signed-off-by: Rui Li <me@lirui.org>
---
Changes since v2:
- Remove long English reference
- Remove ebpf from TODO

Changes since v1:
- Translate bpf subcommand title
- Align title
- Add space after doc path
---
 .../zh_CN/userspace-api/ebpf/index.rst        | 22 ++++++++++++++
 .../zh_CN/userspace-api/ebpf/syscall.rst      | 29 +++++++++++++++++++
 .../zh_CN/userspace-api/index.rst             |  6 +++-
 3 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst

diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
new file mode 100644
index 000000000000..d52c7052f101
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
@@ -0,0 +1,22 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/userspace-api/ebpf/index.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+eBPF 用户空间API
+================
+
+eBPF是一种在Linux内核中提供沙箱化运行环境的机制，它可以在不改变内核源码或加载
+内核模块的情况下扩展运行时和编写工具。eBPF程序能够被附加到各种内核子系统中，包
+括网络，跟踪和Linux安全模块(LSM)等。
+
+关于eBPF的内部内核文档，请查看 Documentation/bpf/index.rst 。
+
+.. toctree::
+   :maxdepth: 1
+
+   syscall
diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
new file mode 100644
index 000000000000..47e2a59ae45d
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
@@ -0,0 +1,29 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../disclaimer-zh_CN.rst
+
+:Original: Documentation/userspace-api/ebpf/syscall.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+eBPF Syscall
+------------
+
+:作者:
+    - Alexei Starovoitov <ast@kernel.org>
+    - Joe Stringer <joe@wand.net.nz>
+    - Michael Kerrisk <mtk.manpages@gmail.com>
+
+bpf syscall的主要信息可以在 `man-pages`_ 中的 `bpf(2)`_ 找到。
+
+bpf() 子命令参考
+~~~~~~~~~~~~~~~~
+
+子命令在以下内核代码中：
+
+include/uapi/linux/bpf.h
+
+.. Links:
+.. _man-pages: https://www.kernel.org/doc/man-pages/
+.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
index 3b834fe7e33b..12c63d81c663 100644
--- a/Documentation/translations/zh_CN/userspace-api/index.rst
+++ b/Documentation/translations/zh_CN/userspace-api/index.rst
@@ -21,6 +21,11 @@ Linux 内核用户空间API指南
 
 	   目录
 
+.. toctree::
+   :maxdepth: 2
+
+   ebpf/index
+
 TODOList:
 
 * no_new_privs
@@ -29,7 +34,6 @@ TODOList:
 * unshare
 * spec_ctrl
 * accelerators/ocxl
-* ebpf/index
 * ioctl/index
 * iommu
 * media/index
-- 
2.30.2

