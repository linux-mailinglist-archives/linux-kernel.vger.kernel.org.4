Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D260C3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJYGSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYGSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:18:17 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D96A43179;
        Mon, 24 Oct 2022 23:18:15 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666678694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PfHEfbX+rpdt9GZNuVQDrplmUUgJamTim3fW50Ttv3M=;
        b=kgYJ+qw6Qz3M1VxF16vT1IgrIpJW6lcr34V3/QpN4VMQynlbDeoklvXGY9TZ18uLd8qotL
        wGTESYjDN0ayReISW5OxuiRvQNUpat/ayMW3lJyQiiBbLOxOWszmzls9XRTTcbamXfoZi6
        Vw6Xwioq9RMzOtVU8yYwm3sufZMN0fNCgBQGnWwpNpflKtACN+/4gZ32DSBZwjKjYNBzsA
        1DSFfuAx2JmbUds5fv6GWn3TfBBz8uzp5BRXfwrdZ1xDsTlD74AsSIQPEP053WLM2U2NlU
        Pd2jlwtBb3hVMrEWB0aSpHCTM/ZGc23PkSad11QDeAv68r8w9x8EzboifNucIA==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH] docs/zh_CN: Add userspace-api/sysfs-platform_profile Chinese translation
Date:   Tue, 25 Oct 2022 14:18:04 +0800
Message-Id: <20221025061804.35801-1-me@lirui.org>
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
index 000000000000..6e861f911424
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
+这些平台自动调整机制通常能够被配置成多个平台配置文件中的一个，要么偏向低功率
+工作，要么偏向性能。
+
+platform_profile属性的目的是提供一个通用的sysfs API来选择这些平台自动配置
+机制的配置文件。
+
+需要注意的是，这个API只能用作选择平台配置文件。其目的并不是为了监测改变所致
+的性能特征。监测性能最好使用设备/供应商提供的工具，比如turbostat。
+
+具体来说，当选择高性能配置文件时，真实能达到的性能可能受制于多种因素，比如：
+其他组件的发热，房间温度，笔记本底部的自由空气流动等。这个API的目的明显不是让
+用户空间知道任何阻碍达到要求性能等级的欠佳条件。
+
+由于数字本身并不能代表一个配置文件会调整的多个变量（功耗，发热等），这个API使
+用字符串来描述多种配置文件。为了保证用户空间能够获得一致的体验，
+sysfs-platform_profile ABI 文档定义了一个固定的配置文件名集合。驱动程序
+*必须* 将它们内置的配置文件表示映射到这个固定的集合中。
+
+如果映射时没有很好的匹配，可以添加一个新的配置文件名称。驱动希望引入的新配置文
+件名称时必须：
+
+ 1. 解释为什么无法使用已有的配置文件名称。
+ 2. 添加一个新的配置文件名称，以及预期行为的清晰描述，保存到
+    sysfs-platform_profile ABI文档中。
-- 
2.30.2

