Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60215601036
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJQN1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJQN1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:27:36 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3595E56D;
        Mon, 17 Oct 2022 06:27:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666013251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1dQDWM4/VSnTQoKiY6vSDDALOOAIL8qqA0imL4WIO4=;
        b=cVW2Ijnpl3yuVPTSEwbt8IR4vwmXIZN40rvN3st9EcwEDEffHn4WZccJzE6SqAIer/GM6Z
        zwt92dsZnr0ICUQ+w89TufdIOeELrqX9EU6sjEAVTo3z6iqhuKptlXddiN+lWr7HLXCGVv
        zWCKX8lwoRvAUY2Rep7vSUj+gP6FlOUCqJupEhqN8ukXzLpuRmzy7s4t7dAxF5jyGibe4o
        aWZ2o7uCXkf6DVYrBsPEzJKK+9URxtV/aYEi7i+OkdSjnbdggMNSAFzdyNwtmQqgIX2VJB
        f94ivLHxfoK3vAeio3lp0gAquA+PTNOGcplnTEmgEyUuSatFAoi8TIfC19Yyfg==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rui Li <me@lirui.org>
Subject: [RESEND PATCH 1/2] docs/zh_CN: Add userspace-api/ebpf Chinese translation
Date:   Mon, 17 Oct 2022 21:27:04 +0800
Message-Id: <9de67db2daac59bfb9af4c02f262bb43cc63c4c5.1666009558.git.me@lirui.org>
In-Reply-To: <cover.1666009558.git.me@lirui.org>
References: <cover.1666009558.git.me@lirui.org>
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

Translate the following documents into Chinese:

- userspace-api/ebpf/index.rst
- userspace-api/ebpf/syscall.rst

Signed-off-by: Rui Li <me@lirui.org>
---
 .../zh_CN/userspace-api/ebpf/index.rst        | 22 +++++++++++++
 .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
 create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst

diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
new file mode 100644
index 000000000000..9f0af275eb69
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
+==================
+
+eBPF是一种在Linux内核中提供沙箱化运行环境的机制，它可以在不改变内核源码或加载
+内核模块的情况下扩展运行时和编写工具。eBPF程序能够被附加到各种内核子系统中，包
+括网络，跟踪和Linux安全模块(LSM)等。
+
+关于eBPF的内部内核文档，请查看 Documentation/bpf/index.rst。
+
+.. toctree::
+   :maxdepth: 1
+
+   syscall
diff --git a/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst b/Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
new file mode 100644
index 000000000000..56bfa9bc7887
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
+bpf() subcommand reference
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

