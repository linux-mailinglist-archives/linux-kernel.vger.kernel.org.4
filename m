Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892FB608D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJVMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJVMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:06:32 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34B3237FB5;
        Sat, 22 Oct 2022 05:06:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666440385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nc63P9hRTQ/Z/eSeuCo+wraUic53v2hR6RRkGzpw6/o=;
        b=FH8LkjeN6X1aOippPiAt6lAMO3BdihGUSOP+TV97NxowGjFjYf9IbCytf+g4W7DTGULDe6
        SPZqgu7QkS151ixVQ6Lw5zHnCZnu8mh/6bOGuTKi5kb5A8E+xiGnpsIlVD0dz7M3MY7ZfR
        N7li2ZQLnQMn5pEV7ZOMYraFg4Je9fDekAaQWgVgUfRAYy11DW0B9MXvOtbKebCoe0qjTa
        bbrOvJxjtHG0ND5SmsJ02hCreeO+6Q3jEjJEqkboZm/LwjJhLFdNkQ21BaRp2ijVyuHVnW
        I5vtEK6juPKFwGm0TqrzuYbvrM2x6N12vectSwDlhaPb33kFBfXf63HjsSyJWg==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH] docs/zh_CN: Add userspace-api/no_new_privs Chinese translation
Date:   Sat, 22 Oct 2022 20:05:57 +0800
Message-Id: <20221022120557.381115-1-me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following documents into Chinese:

- userspace-api/no_new_privs.rst

Signed-off-by: Rui Li <me@lirui.org>
---
 .../zh_CN/userspace-api/index.rst             |  2 +-
 .../zh_CN/userspace-api/no_new_privs.rst      | 57 +++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/userspace-api/no_new_privs.rst

diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
index 12c63d81c663..6a7e82ac16b9 100644
--- a/Documentation/translations/zh_CN/userspace-api/index.rst
+++ b/Documentation/translations/zh_CN/userspace-api/index.rst
@@ -25,10 +25,10 @@ Linux 内核用户空间API指南
    :maxdepth: 2
 
    ebpf/index
+   no_new_privs
 
 TODOList:
 
-* no_new_privs
 * seccomp_filter
 * landlock
 * unshare
diff --git a/Documentation/translations/zh_CN/userspace-api/no_new_privs.rst b/Documentation/translations/zh_CN/userspace-api/no_new_privs.rst
new file mode 100644
index 000000000000..81bd16ce3ad2
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/no_new_privs.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/userspace-api/no_new_privs.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+============
+无新权限标志
+============
+
+execve系统调用可以给一个新启动的程序授予它的父程序本没有的权限。最明显的两个
+例子就是setuid/setgid控制程序和文件的能力。为了避免父程序也获得这些权限，内
+核和用户代码必须小心避免任何父程序可以颠覆子程序的情况。比如：
+
+ - 程序在setuid后，动态装载器处理 ``LD_*`` 环境变量的不同方式。
+
+ - 对于非特权程序，chroot是不允许的，因为这会允许 ``/etc/passwd`` 在继承
+   chroot的程序眼中被替换。
+
+ - 执行代码对ptrace有特殊处理。
+
+这些都是临时性的修复。 ``no_new_privs`` 位（从 Linux 3.5 起）是一个新的通
+用的机制来保证一个进程安全地修改其执行环境并跨execve持久化。任何任务都可以设
+置 ``no_new_privs`` 。一旦该位被设置，它会在fork、clone和execve中继承下去
+，并且不能被撤销。在 ``no_new_privs`` 被设置的情况下， ``execve()`` 将保证
+不会授予权限去做任何没有execve调用就不能做的事情。比如， setuid 和 setgid
+位不会再改变 uid 或 gid；文件能力不会被添加到授权集合中，并且Linux安全模块（
+LSM）不会在execve调用后放松限制。
+
+设置 ``no_new_privs`` 使用::
+
+    prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+不过要小心，Linux安全模块（LSM）也可能不会在 ``no_new_privs`` 模式下收紧约束。
+（这意味着一个一般的服务启动器在执行守护进程前就去设置 ``no_new_privs`` 可能
+会干扰基于LSM的沙箱。）
+
+请注意， ``no_new_privs`` 并不能阻止不涉及 ``execve()`` 的权限变化。一个拥有
+适当权限的任务仍然可以调用 ``setuid(2)`` 并接收 SCM_RIGHTS 数据报。
+
+目前来说， ``no_new_privs`` 有两大使用场景：
+
+ - 为seccomp模式2沙箱安装的过滤器会跨execve持久化，并能够改变新执行程序的行为。
+   非特权用户因此在 ``no_new_privs`` 被设置的情况下只允许安装这样的过滤器。
+
+ - ``no_new_privs`` 本身就能被用于减少非特权用户的攻击面。如果所有以某个 uid
+   运行的程序都设置了 ``no_new_privs`` ，那么那个 uid 将无法通过攻击 setuid，
+   setgid 和使用文件能力的二进制来提权；它需要先攻击一些没有被设置 ``no_new_privs``
+   位的东西。
+
+将来，其他潜在的危险的内核特性可能被非特权任务利用，即使 ``no_new_privs`` 被置位。
+原则上，当 ``no_new_privs`` 被置位时， ``unshare(2)`` 和 ``clone(2)`` 的几个选
+项将是安全的，并且 ``no_new_privs`` 加上 ``chroot`` 是可以被认为比 chroot本身危
+险性小得多的。
-- 
2.30.2

