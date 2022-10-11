Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4192E5FAC09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJKGCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiJKGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:02:34 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7C7C19D;
        Mon, 10 Oct 2022 23:02:32 -0700 (PDT)
Date:   Tue, 11 Oct 2022 14:02:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665468150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMw2Iw480ZzNMI8qHj9tphsVypzxrxUENeARfx54heE=;
        b=D68WcEu96WOq73rUBq+DkYE1WALGmrTZe0RQFRNFGE8Dfk19QInDc8MVghZcT0Fa+rR2ig
        J1gDzl3Log//48IwQU6TWq8EX1FkzniZhynErLSZjn/a4KM/jfIaf5XpwcjGCSLCJyLASP
        Nf+f8G3kq6yD80kqUFk+5bsoWOdcmZQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Wu XiangCheng <wu.xiangcheng@linux.dev>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>, chenhuacai@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] docs/zh_CN: Rewrite the Chinese translation front page
Message-ID: <440d7cb3c9f1526ed7c2996aa88ba2bc7fdc018c.1665467392.git.bobwxc@email.cn>
References: <cover.1665467392.git.bobwxc@email.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1665467392.git.bobwxc@email.cn>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu XiangCheng <bobwxc@email.cn>

update to commit 0c7b4366f1ab ("docs: Rewrite the front page")

Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
---
 Documentation/translations/zh_CN/index.rst | 169 +++++++--------------
 1 file changed, 51 insertions(+), 118 deletions(-)

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 2fc60e60feb4..7be728bed46d 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -26,165 +26,98 @@
 顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
 的字符标点占用两个英文字符宽度， 所以，当英文要求不要超过每行100个字符时，
 中文就不要超过50个字符。另外，也要注意'-'，'=' 等符号与相关标题的对齐。在将
-补丁提交到社区之前，一定要进行必要的checkpatch.pl检查和编译测试。
+补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试。
 
-许可证文档
-----------
-
-下面的文档介绍了Linux内核源代码的许可证（GPLv2）、如何在源代码树中正确标记
-单个文件的许可证、以及指向完整许可证文本的链接。
+与Linux 内核社区一起工作
+------------------------
 
-* Documentation/translations/zh_CN/process/license-rules.rst
-
-用户文档
---------
-
-下面的手册是为内核用户编写的——即那些试图让它在给定系统上以最佳方式工作的
-用户。
+与内核开发社区进行协作并将工作推向上游的基本指南。
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   admin-guide/index
-
-TODOList:
-
-* kbuild/index
+   process/development-process
+   process/submitting-patches
+   行为准则 <process/code-of-conduct>
+   maintainer/index
+   完整开发流程文档 <process/index>
 
-固件相关文档
-------------
+内部API文档
+-----------
 
-下列文档描述了内核需要的平台固件相关信息。
+开发人员使用的内核内部交互接口手册。
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   devicetree/index
+   core-api/index
+   driver-api/index
+   内核中的锁 <locking/index>
 
 TODOList:
 
-* firmware-guide/index
-
-应用程序开发人员文档
---------------------
-
-用户空间API手册涵盖了描述应用程序开发人员可见内核接口方面的文档。
-
-TODOlist:
-
-* userspace-api/index
+* subsystem-apis
 
-内核开发简介
-------------
+开发工具和流程
+--------------
 
-这些手册包含有关如何开发内核的整体信息。内核社区非常庞大，一年下来有数千名
-开发人员做出贡献。与任何大型社区一样，知道如何完成任务将使得更改合并的过程
-变得更加容易。
+为所有内核开发人员提供有用信息的各种其他手册。
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   process/index
-   dev-tools/index
+   process/license-rules
    doc-guide/index
+   dev-tools/index
+   dev-tools/testing-overview
    kernel-hacking/index
-   maintainer/index
 
 TODOList:
 
 * trace/index
 * fault-injection/index
 * livepatch/index
-* rust/index
 
-内核API文档
------------
+面向用户的文档
+--------------
 
-以下手册从内核开发人员的角度详细介绍了特定的内核子系统是如何工作的。这里的
-大部分信息都是直接从内核源代码获取的，并根据需要添加补充材料（或者至少是在
-我们设法添加的时候——可能不是所有的都是有需要的）。
+下列手册针对
+希望内核在给定系统上以最佳方式工作的*用户*，
+和查找内核用户空间API信息的程序开发人员。
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   core-api/index
-   driver-api/index
-   locking/index
-   accounting/index
-   cpu-freq/index
-   iio/index
-   infiniband/index
-   power/index
-   virt/index
-   sound/index
-   filesystems/index
-   scheduler/index
-   mm/index
-   peci/index
-   PCI/index
+   admin-guide/index
+   admin-guide/reporting-issues.rst
 
 TODOList:
 
-* block/index
-* cdrom/index
-* ide/index
-* fb/index
-* fpga/index
-* hid/index
-* i2c/index
-* isdn/index
-* leds/index
-* netlabel/index
-* networking/index
-* pcmcia/index
-* target/index
-* timers/index
-* spi/index
-* w1/index
-* watchdog/index
-* input/index
-* hwmon/index
-* gpu/index
-* security/index
-* crypto/index
-* bpf/index
-* usb/index
-* scsi/index
-* misc-devices/index
-* mhi/index
-
-体系结构无关文档
-----------------
-
-TODOList:
+* 内核构建系统 <kbuild/index>
+* 用户空间工具 <tools/index>
+* userspace-api/index
 
-* asm-annotations
+固件相关文档
+------------
 
-特定体系结构文档
-----------------
+下列文档描述了内核需要的平台固件相关信息。
 
 .. toctree::
    :maxdepth: 2
 
-   mips/index
-   arm64/index
-   riscv/index
-   openrisc/index
-   parisc/index
-   loongarch/index
+   devicetree/index
 
 TODOList:
 
-* arm/index
-* ia64/index
-* m68k/index
-* nios2/index
-* powerpc/index
-* s390/index
-* sh/index
-* sparc/index
-* x86/index
-* xtensa/index
+* firmware-guide/index
+
+体系结构文档
+------------
+
+.. toctree::
+   :maxdepth: 2
+
+   arch
 
 其他文档
 --------
@@ -195,9 +128,9 @@ TODOList:
 TODOList:
 
 * staging/index
-* watch_queue
 
-目录和表格
+
+索引和表格
 ----------
 
 * :ref:`genindex`
-- 
2.30.2


-- 
Wu XiangCheng	0x32684A40BCA7AEA7

