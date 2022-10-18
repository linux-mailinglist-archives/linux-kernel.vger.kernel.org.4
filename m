Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1152D602A99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJRLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJRLzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:55:25 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2200997EF3;
        Tue, 18 Oct 2022 04:55:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666094122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hupgNoQdpyp2o8IVUE4hcgxanPErrHi/bqHICjKXEEs=;
        b=mrQkA5WVTIf9mfixRtZIuewlQflouJg2JZZeYBeVsipJEW9MPIkF39gS+adsgBMR+cIHZD
        Ri1CLhr7Ok+dABjxHV00/Qkgw40ZEKGGcW1IrJfNqvlqdQJKfH/AZU+SAVQOG6A9Ft/Ye3
        /XkzhfCRPquaROrrmV0KJZXqhVpGIg8AfPdz2S1A82Zwn9101Dut++3PTAozB69agaSNuP
        lzpyVjuGeJfgutbD09mbqkcqY+vi98zSksWC3oWNYmyGKTa60qw6ZlNIAeHfsWbUjdPLnS
        FmY/pNs890hOJa7RvROHcYQ8ALUxx1FsFiIJimh2XqpFycTjvB1McmxPRIOjpQ==
From:   Rui Li <me@lirui.org>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>, Rui Li <me@lirui.org>
Subject: [PATCH v2 1/2] docs/zh_CN: Add userspace-api/ebpf Chinese translation
Date:   Tue, 18 Oct 2022 19:54:52 +0800
Message-Id: <8d032bf9a69ac6703260ac91408562c562c03f2d.1666093699.git.me@lirui.org>
In-Reply-To: <cover.1666093699.git.me@lirui.org>
References: <cover.1666093699.git.me@lirui.org>
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
Changes since v1:
- Translate bpf subcommand title
- Align title
- Add space after doc path
---
 .../zh_CN/userspace-api/ebpf/index.rst        | 22 +++++++++++++
 .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 +++++++++++++++++++
 2 files changed, 53 insertions(+)
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
index 000000000000..17515728f544
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
@@ -0,0 +1,31 @@
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
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/uapi/linux/bpf.h
+   :doc: eBPF Syscall Preamble
+
+.. kernel-doc:: include/uapi/linux/bpf.h
+   :doc: eBPF Syscall Commands
+
+.. Links:
+.. _man-pages: https://www.kernel.org/doc/man-pages/
+.. _bpf(2): https://man7.org/linux/man-pages/man2/bpf.2.html
-- 
2.30.2

