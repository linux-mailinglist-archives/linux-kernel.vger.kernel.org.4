Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8460DBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 09:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiJZHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiJZHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:07:55 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBD1A02EE;
        Wed, 26 Oct 2022 00:07:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666768071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CTBP1I1mRmYBPwpdaRic92IUFEYVxtGvgLAm+qZCAqU=;
        b=lhp/6OcotKc/4JhQdzutfYNOcvYbUinqWxDdhL5RIGS+KqaTkspIq+pIIrT+CR7k6xkdrQ
        6LhRvzBg47qqUV/B56CgHsNLx2V10Mdfob99gCkdOCI4sJY4/e4tuPmonePeX7iSbDjwne
        K9tlYiIkZpD9Mb39G72mZNGGm+3rZnt+OFOZ61jrpo6x0E56jZ/DZEh6e7WQ6bpS4CyHns
        YK6iImg1awnZ321EttOqf4OmCQNKl9Tst+yYEZf3DWd+wi3jwyjhL43myYnk2eDSzZXjJH
        srcl/euu5hC0Hfl+8Zo/LulqH/DkNJ5L/sFlAnQ7twy0zsNkohd01jPJ4aVYew==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH v2] docs/zh_CN: Add userspace-api/sysfs-platform_profile Chinese translation
Date:   Wed, 26 Oct 2022 15:07:32 +0800
Message-Id: <20221026070732.72818-1-me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the following documents into Chinese:

- userspace-api/sysfs-platform_profile.rst

Signed-off-by: Rui Li <me@lirui.org>
---
Changes since v1:
- Improve some translation.
---
 .../zh_CN/userspace-api/index.rst             |  2 +-
 .../userspace-api/sysfs-platform_profile.rst  | 40 +++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst

diff --git a/Documentation/translations/zh_CN/userspace-api/index.rst b/Documentation/translations/zh_CN/userspace-api/index.rst
index 6a7e82ac16b9..0f3483a46fa2 100644
--- a/Documentation/translations/zh_CN/userspace-api/index.rst
+++ b/Documentation/translations/zh_CN/userspace-api/index.rst
@@ -26,6 +26,7 @@ Linux 内核用户空间API指南
 
    ebpf/index
    no_new_privs
+   sysfs-platform_profile
 
 TODOList:
 
@@ -38,7 +39,6 @@ TODOList:
 * iommu
 * media/index
 * netlink/index
-* sysfs-platform_profile
 * vduse
 * futex2
 
diff --git a/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst b/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
new file mode 100644
index 000000000000..7d21740db125
--- /dev/null
+++ b/Documentation/translations/zh_CN/userspace-api/sysfs-platform_profile.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/userspace-api/sysfs-platform_profile.rst
+
+:翻译:
+
+ 李睿 Rui Li <me@lirui.org>
+
+==========================================================
+平台配置文件选择（如 /sys/firmware/acpi/platform_profile）
+==========================================================
+
+现代系统中平台性能、温度、风扇和其他硬件相关的特性通常是可以动态配置的。平台
+配置通常会根据当前的状态由一些自动机制（很可能存在于内核之外）来自动调整。
+
+这些平台自动调整机制通常能够被配置成多个平台配置文件中的一个，要么偏向节能运
+行，要么偏向性能运行。
+
+platform_profile属性的目的是提供一个通用的sysfs API来选择这些平台自动配置
+机制的配置文件。
+
+需要注意的是，这个API只能用作选择平台配置文件，用来监测所产生的性能特征并不
+是其目标。监测性能最好使用设备/供应商提供的工具，比如turbostat。
+
+具体来说，当选择高性能配置文件时，真实能达到的性能可能受制于多种因素，比如：
+其他组件的发热，房间温度，笔记本底部的自由空气流动等。让用户空间知道任何阻碍
+达到要求性能水平的局部最优条件，显然不是这个API的目标。
+
+由于数字本身并不能代表一个配置文件会调整的多个变量（功耗，发热等），这个API
+使用字符串来描述多种配置文件。为了保证用户空间能够获得一致的体验，
+sysfs-platform_profile ABI 文档定义了一个固定的配置文件名集合。驱动程序
+*必须* 将它们内置的配置文件表示映射到这个固定的集合中。
+
+如果映射时没有很好的匹配，可以添加一个新的配置文件名称。驱动希望引入的新配置
+文件名称时必须：
+
+ 1. 解释为什么无法使用已有的配置文件名称。
+ 2. 添加一个新的配置文件名称，以及预期行为的清晰描述，保存到
+    sysfs-platform_profile ABI文档中。
-- 
2.30.2

