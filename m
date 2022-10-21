Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B223D60727C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiJUIgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiJUIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:36:36 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4745BC3560;
        Fri, 21 Oct 2022 01:36:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666341366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eHVJEOZ4ET+hU/ulp5QMblIs5IlHC0UEzv7fN95cwQ4=;
        b=Zcd+og4D0v6a3AJ0bF1sf7CxXN+tAgG4ie+AqfzUqW3d2Q1hYJMXE3yUqPx15ChZGkinqv
        +6vSXEO1EBlGJIQucDYYlB6LbMyoxBzdER2J4WfWTaKGs5ayIPNaZfB20ueaxvSi8J2beg
        Euqt2jz/7QkrXT2xdTIEsF1PzZ4hnxNLApURFFbnWvGzXe+TheDbhpwGKNgPomZEdAFylD
        7ou8+XeLYLFaJiqjK0JTakrDYnYSgdynoSc8WsMNtBm+C620spvEfjCODhBTIu+cHE1nP4
        5o+p6hVV26SFIPLlwmdWZK12Q83x8L4UqGQ8zqNGl1hnMecOydGqiHtqqm7kAA==
From:   Rui Li <me@lirui.org>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rui Li <me@lirui.org>
Subject: [PATCH] docs/zh_CN: Add subsystem-apis Chinese translation
Date:   Fri, 21 Oct 2022 16:35:01 +0800
Message-Id: <20221021083501.347066-1-me@lirui.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate subsystem-apis.rst into Chinese.

Signed-off-by: Rui Li <me@lirui.org>
---
 Documentation/translations/zh_CN/index.rst    |  5 +-
 .../translations/zh_CN/subsystem-apis.rst     | 66 +++++++++++++++++++
 2 files changed, 67 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/subsystem-apis.rst

diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index ec99ef5fe990..1250f2afd928 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -53,10 +53,7 @@
    core-api/index
    driver-api/index
    内核中的锁 <locking/index>
-
-TODOList:
-
-* subsystem-apis
+   subsystem-apis
 
 开发工具和流程
 --------------
diff --git a/Documentation/translations/zh_CN/subsystem-apis.rst b/Documentation/translations/zh_CN/subsystem-apis.rst
new file mode 100644
index 000000000000..5ceca6c3ca1b
--- /dev/null
+++ b/Documentation/translations/zh_CN/subsystem-apis.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ./disclaimer-zh_CN.rst
+
+:Original: Documentation/subsystem-apis.rst
+
+:翻译:
+
+  李睿 Rui Li <me@lirui.org>
+
+==============
+内核子系统文档
+==============
+
+这些文档会从一个内核开发者的角度去深入讲述一些内核子系统的运行细节。这里
+的许多信息直接来源于内核源码，加上一些必要的补充材料（或者至少是我们人为
+加上的——尽管有些并 *不* 必要）。
+
+**Fixme**: 需要更多文档组织工作。
+
+.. toctree::
+   :maxdepth: 1
+
+   driver-api/index
+   core-api/index
+   locking/index
+   accounting/index
+   cpu-freq/index
+   iio/index
+   infiniband/index
+   power/index
+   virt/index
+   sound/index
+   filesystems/index
+   mm/index
+   PCI/index
+   scheduler/index
+   peci/index
+
+TODOList:
+
+* block/index
+* cdrom/index
+* fb/index
+* fpga/index
+* hid/index
+* i2c/index
+* isdn/index
+* leds/index
+* netlabel/index
+* networking/index
+* pcmcia/index
+* target/index
+* timers/index
+* spi/index
+* w1/index
+* watchdog/index
+* input/index
+* hwmon/index
+* gpu/index
+* security/index
+* crypto/index
+* bpf/index
+* usb/index
+* scsi/index
+* misc-devices/index
+* mhi/index
-- 
2.30.2

