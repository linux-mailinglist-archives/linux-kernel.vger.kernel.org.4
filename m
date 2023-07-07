Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2350F74B4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGGQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjGGQDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:03:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE31FD7;
        Fri,  7 Jul 2023 09:02:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1440145a12.1;
        Fri, 07 Jul 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688745777; x=1691337777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz2VWnFVFBivjxHouAs3v8rOM5YARDXnKOaiqqreg4E=;
        b=ebDPq2pM1jyC0tcMjor7MZqFDn2ZJVv8eoAfbpaDTbOnV1sWDZjJCmb/xFB14TFCUs
         th6wDss4tb2OUi9kgqtdpZRcpMTdYRaBXAwh/b6zOxl09T5iiqD8iSUgKP99Wge+NU4Z
         3nz9CfAf+DA2l+NcyUvdnsw0C8vnRSM6hzk6IZmhKtK19EkjpLKxUHK5iVA25wEKLSSJ
         ixBGSyohFytUn3XRnAprvvfKFlr0TJ5Rn/ukzz72BNH+qQmTVxjI+KtSWVhHyKjxwe4C
         ZrAm/N3+AchJZCgTixNpYrE/rU67ouhtNCznWNkvW6dUW4CX/n49LRUY6skxbc0mIT3V
         gUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745777; x=1691337777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz2VWnFVFBivjxHouAs3v8rOM5YARDXnKOaiqqreg4E=;
        b=Qfoee09Bvz7cRmtE0c1jHsJ66nuONfrroZkqbeZ96CCkytb85WKVT7tcSwzbhD1niK
         UhKN0VNT0IGluDDsZSwPZyY8uHiR/sgQXvFI/nQO//Kc3OnM4dNV/wIpzrcxMKibhJu7
         Pydl5ernXOZfAHnsHXu2ud3Hp2lx+TASNnRw9MpJtu2vAhorvvlBLOxgFkOwxzUhOAMA
         C0E69s1QDPL47Gpl8jOxswDuxEri0vhk1g9KYW5nAucahyeVVFqHAJF+gui6srOzWNdx
         ihd2FQgbWhAywy/yuk91Jv8+e96WGk/Ry3O/jmZ3a+wqnZIgG5LkFJ1I6DXdNRC5cSV0
         bXUA==
X-Gm-Message-State: ABy/qLaxJEOua2DWOahZyh12nN9zmyCm4jqvxEt7LOPEYvIDub884af9
        UJrUfxXsSq2+UV/IJAIo/2s=
X-Google-Smtp-Source: APBJJlEhvF6qvGTxptVbQ2a5IT1hk9/daEV0nwtyWj/wEQNzL1juadbBXenHtDypKpZ2fwjhP1oe/A==
X-Received: by 2002:a17:90b:38c8:b0:263:fc27:662c with SMTP id nn8-20020a17090b38c800b00263fc27662cmr5189247pjb.39.1688745776880;
        Fri, 07 Jul 2023 09:02:56 -0700 (PDT)
Received: from localhost.localdomain ([113.251.4.177])
        by smtp.gmail.com with ESMTPSA id gz18-20020a17090b0ed200b00263dfe9b972sm1770154pjb.0.2023.07.07.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:02:55 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net, siyanteng@loongson.cn, bobwxc@email.cn,
        alexs@kernel.org, gregkh@linuxfoundation.org,
        nabijaczleweli@nabijaczleweli.xyz, carlos.bilbao@amd.com
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: change my own email address
Date:   Sat,  8 Jul 2023 00:01:19 +0800
Message-Id: <20230707160119.26873-1-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous email address was abandoned due to some reasons by myself, and
thus shift the email contents mentioned from the old email address
(src.res@email.cn) to the current version (src.res.211@gmail.com).

Signed-off-by: Hu Haowen <src.res.211@gmail.com>
---
 .../translations/zh_CN/dev-tools/testing-overview.rst     | 2 +-
 Documentation/translations/zh_TW/IRQ.txt                  | 8 ++++----
 Documentation/translations/zh_TW/admin-guide/README.rst   | 2 +-
 .../translations/zh_TW/admin-guide/bug-bisect.rst         | 2 +-
 .../translations/zh_TW/admin-guide/bug-hunting.rst        | 2 +-
 .../translations/zh_TW/admin-guide/clearing-warn-once.rst | 2 +-
 Documentation/translations/zh_TW/admin-guide/cpu-load.rst | 2 +-
 Documentation/translations/zh_TW/admin-guide/index.rst    | 2 +-
 Documentation/translations/zh_TW/admin-guide/init.rst     | 2 +-
 .../translations/zh_TW/admin-guide/reporting-issues.rst   | 2 +-
 .../translations/zh_TW/admin-guide/security-bugs.rst      | 2 +-
 .../translations/zh_TW/admin-guide/tainted-kernels.rst    | 2 +-
 Documentation/translations/zh_TW/admin-guide/unicode.rst  | 2 +-
 Documentation/translations/zh_TW/arch/arm64/amu.rst       | 2 +-
 Documentation/translations/zh_TW/arch/arm64/booting.txt   | 4 ++--
 .../translations/zh_TW/arch/arm64/elf_hwcaps.rst          | 2 +-
 .../translations/zh_TW/arch/arm64/hugetlbpage.rst         | 2 +-
 Documentation/translations/zh_TW/arch/arm64/index.rst     | 2 +-
 .../translations/zh_TW/arch/arm64/legacy_instructions.txt | 4 ++--
 Documentation/translations/zh_TW/arch/arm64/memory.txt    | 4 ++--
 Documentation/translations/zh_TW/arch/arm64/perf.rst      | 2 +-
 .../translations/zh_TW/arch/arm64/silicon-errata.txt      | 4 ++--
 .../translations/zh_TW/arch/arm64/tagged-pointers.txt     | 4 ++--
 Documentation/translations/zh_TW/cpu-freq/core.rst        | 2 +-
 Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst | 2 +-
 .../translations/zh_TW/cpu-freq/cpufreq-stats.rst         | 2 +-
 Documentation/translations/zh_TW/cpu-freq/index.rst       | 2 +-
 Documentation/translations/zh_TW/disclaimer-zh_TW.rst     | 2 +-
 Documentation/translations/zh_TW/filesystems/debugfs.rst  | 4 ++--
 Documentation/translations/zh_TW/filesystems/index.rst    | 2 +-
 Documentation/translations/zh_TW/filesystems/sysfs.txt    | 2 +-
 Documentation/translations/zh_TW/filesystems/tmpfs.rst    | 2 +-
 Documentation/translations/zh_TW/filesystems/virtiofs.rst | 2 +-
 Documentation/translations/zh_TW/gpio.txt                 | 8 ++++----
 Documentation/translations/zh_TW/index.rst                | 2 +-
 Documentation/translations/zh_TW/io_ordering.txt          | 8 ++++----
 Documentation/translations/zh_TW/process/1.Intro.rst      | 2 +-
 Documentation/translations/zh_TW/process/2.Process.rst    | 2 +-
 .../translations/zh_TW/process/3.Early-stage.rst          | 2 +-
 Documentation/translations/zh_TW/process/4.Coding.rst     | 2 +-
 Documentation/translations/zh_TW/process/5.Posting.rst    | 2 +-
 .../translations/zh_TW/process/6.Followthrough.rst        | 2 +-
 .../translations/zh_TW/process/7.AdvancedTopics.rst       | 2 +-
 Documentation/translations/zh_TW/process/8.Conclusion.rst | 2 +-
 .../zh_TW/process/code-of-conduct-interpretation.rst      | 2 +-
 .../translations/zh_TW/process/code-of-conduct.rst        | 2 +-
 Documentation/translations/zh_TW/process/coding-style.rst | 2 +-
 .../translations/zh_TW/process/development-process.rst    | 2 +-
 .../translations/zh_TW/process/email-clients.rst          | 2 +-
 .../zh_TW/process/embargoed-hardware-issues.rst           | 2 +-
 Documentation/translations/zh_TW/process/howto.rst        | 2 +-
 Documentation/translations/zh_TW/process/index.rst        | 2 +-
 .../zh_TW/process/kernel-driver-statement.rst             | 2 +-
 .../zh_TW/process/kernel-enforcement-statement.rst        | 2 +-
 .../translations/zh_TW/process/license-rules.rst          | 2 +-
 Documentation/translations/zh_TW/process/magic-number.rst | 2 +-
 .../translations/zh_TW/process/management-style.rst       | 2 +-
 .../translations/zh_TW/process/programming-language.rst   | 2 +-
 .../translations/zh_TW/process/stable-api-nonsense.rst    | 2 +-
 .../translations/zh_TW/process/stable-kernel-rules.rst    | 2 +-
 .../translations/zh_TW/process/submit-checklist.rst       | 2 +-
 .../translations/zh_TW/process/submitting-patches.rst     | 2 +-
 .../zh_TW/process/volatile-considered-harmful.rst         | 2 +-
 Documentation/translations/zh_TW/sparse.txt               | 6 +++---
 MAINTAINERS                                               | 2 +-
 65 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
index af65e7e93c02..69e7e4cb2002 100644
--- a/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+++ b/Documentation/translations/zh_CN/dev-tools/testing-overview.rst
@@ -3,7 +3,7 @@
 .. include:: ../disclaimer-zh_CN.rst
 
 :Original: Documentation/dev-tools/testing-overview.rst
-:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 ============
 内核测试指南
diff --git a/Documentation/translations/zh_TW/IRQ.txt b/Documentation/translations/zh_TW/IRQ.txt
index 73d435a0d1e7..fd78ca720298 100644
--- a/Documentation/translations/zh_TW/IRQ.txt
+++ b/Documentation/translations/zh_TW/IRQ.txt
@@ -7,7 +7,7 @@ help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
 Maintainer: Eric W. Biederman <ebiederman@xmission.com>
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
 ---------------------------------------------------------------------
 Documentation/core-api/irq/index.rst 的繁體中文翻譯
 
@@ -16,9 +16,9 @@ Documentation/core-api/irq/index.rst 的繁體中文翻譯
 者翻譯存在問題，請聯繫繁體中文版維護者。
 
 英文版維護者： Eric W. Biederman <ebiederman@xmission.com>
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版校譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/admin-guide/README.rst b/Documentation/translations/zh_TW/admin-guide/README.rst
index 6ce97edbab37..7fc56e1e3348 100644
--- a/Documentation/translations/zh_TW/admin-guide/README.rst
+++ b/Documentation/translations/zh_TW/admin-guide/README.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 Linux內核5.x版本 <http://kernel.org/>
 =========================================
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
index 41a39aebb8d6..b448dbf5ac87 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-bisect.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 二分（bisect）缺陷
 +++++++++++++++++++
diff --git a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
index 4d813aec77d2..9a3de3bff5e7 100644
--- a/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
+++ b/Documentation/translations/zh_TW/admin-guide/bug-hunting.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 追蹤缺陷
 =========
diff --git a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
index bdc1a22046cf..bd0c08aab8ea 100644
--- a/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
+++ b/Documentation/translations/zh_TW/admin-guide/clearing-warn-once.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 清除 WARN_ONCE
 --------------
diff --git a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
index be087cef1967..9e04aeac1a5c 100644
--- a/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
+++ b/Documentation/translations/zh_TW/admin-guide/cpu-load.rst
@@ -2,7 +2,7 @@
 
 .. include:: ../disclaimer-zh_TW.rst
 
-:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 ========
 CPU 負載
diff --git a/Documentation/translations/zh_TW/admin-guide/index.rst b/Documentation/translations/zh_TW/admin-guide/index.rst
index 293c20245783..2804d619201d 100644
--- a/Documentation/translations/zh_TW/admin-guide/index.rst
+++ b/Documentation/translations/zh_TW/admin-guide/index.rst
@@ -3,7 +3,7 @@
 .. include:: ../disclaimer-zh_TW.rst
 
 :Original: :doc:`../../../admin-guide/index`
-:Translator: 胡皓文 Hu Haowen <src.res@email.cn>
+:Translator: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 Linux 內核用戶和管理員指南
 ==========================
diff --git a/Documentation/translations/zh_TW/admin-guide/init.rst b/Documentation/translations/zh_TW/admin-guide/init.rst
index 32cdf134948f..db3fdf611080 100644
--- a/Documentation/translations/zh_TW/admin-guide/init.rst
+++ b/Documentation/translations/zh_TW/admin-guide/init.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 解釋「No working init found.」啓動掛起消息
 ==========================================
diff --git a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
index 27638e199f13..ea51342879c0 100644
--- a/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
+++ b/Documentation/translations/zh_TW/admin-guide/reporting-issues.rst
@@ -16,7 +16,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 報告問題
diff --git a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
index 15f8e9005071..65c8dd24c96d 100644
--- a/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
+++ b/Documentation/translations/zh_TW/admin-guide/security-bugs.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 安全缺陷
 =========
diff --git a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
index d7b3c4276417..ebe3812ead82 100644
--- a/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
+++ b/Documentation/translations/zh_TW/admin-guide/tainted-kernels.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 受汙染的內核
 -------------
diff --git a/Documentation/translations/zh_TW/admin-guide/unicode.rst b/Documentation/translations/zh_TW/admin-guide/unicode.rst
index 720875be5ef8..7908b369b85b 100644
--- a/Documentation/translations/zh_TW/admin-guide/unicode.rst
+++ b/Documentation/translations/zh_TW/admin-guide/unicode.rst
@@ -7,7 +7,7 @@
 :譯者:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 Unicode（統一碼）支持
 ======================
diff --git a/Documentation/translations/zh_TW/arch/arm64/amu.rst b/Documentation/translations/zh_TW/arch/arm64/amu.rst
index f947a6c7369f..21ac0db63889 100644
--- a/Documentation/translations/zh_TW/arch/arm64/amu.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/amu.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/amu.rst <amu_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res@email.cn>
+            Hu Haowen <src.res.211@gmail.com>
 
 ==================================
 AArch64 Linux 中擴展的活動監控單元
diff --git a/Documentation/translations/zh_TW/arch/arm64/booting.txt b/Documentation/translations/zh_TW/arch/arm64/booting.txt
index 24817b8b70cd..3cc8f593e006 100644
--- a/Documentation/translations/zh_TW/arch/arm64/booting.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/booting.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 M:	Will Deacon <will.deacon@arm.com>
 zh_CN:	Fu Wei <wefu@redhat.com>
-zh_TW:	Hu Haowen <src.res@email.cn>
+zh_TW:	Hu Haowen <src.res.211@gmail.com>
 C:	55f058e7574c3615dea4615573a19bdb258696c6
 ---------------------------------------------------------------------
 Documentation/arch/arm64/booting.rst 的中文翻譯
@@ -23,7 +23,7 @@ Documentation/arch/arm64/booting.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
 本文翻譯提交時的 Git 檢出點爲： 55f058e7574c3615dea4615573a19bdb258696c6
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
index fca3c6ff7b93..ca7ff749a67b 100644
--- a/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/elf_hwcaps.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/elf_hwcaps.rst <elf_hwcaps_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res@email.cn>
+            Hu Haowen <src.res.211@gmail.com>
 
 ================
 ARM64 ELF hwcaps
diff --git a/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst b/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
index 10feb329dfb8..a17858c978d6 100644
--- a/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/hugetlbpage.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/hugetlbpage.rst <hugetlbpage_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res@email.cn>
+            Hu Haowen <src.res.211@gmail.com>
 
 =====================
 ARM64中的 HugeTLBpage
diff --git a/Documentation/translations/zh_TW/arch/arm64/index.rst b/Documentation/translations/zh_TW/arch/arm64/index.rst
index 68befee14b99..a62b5f06b66c 100644
--- a/Documentation/translations/zh_TW/arch/arm64/index.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/index.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/arch/arm64/index.rst <arm64_index>`
 :Translator: Bailu Lin <bailu.lin@vivo.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_arm64_index:
 
diff --git a/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
index 3c915df9836c..c2d02cd5017d 100644
--- a/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/legacy_instructions.txt
@@ -11,7 +11,7 @@ or if there is a problem with the translation.
 Maintainer: Punit Agrawal <punit.agrawal@arm.com>
             Suzuki K. Poulose <suzuki.poulose@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
 ---------------------------------------------------------------------
 Documentation/arch/arm64/legacy_instructions.rst 的中文翻譯
 
@@ -26,7 +26,7 @@ Documentation/arch/arm64/legacy_instructions.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者：胡皓文  Hu Haowen <src.res@email.cn>
+繁體中文版校譯者：胡皓文  Hu Haowen <src.res.211@gmail.com>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/arch/arm64/memory.txt b/Documentation/translations/zh_TW/arch/arm64/memory.txt
index 2437380a26d8..0280200e791f 100644
--- a/Documentation/translations/zh_TW/arch/arm64/memory.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/memory.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 Maintainer: Catalin Marinas <catalin.marinas@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
 ---------------------------------------------------------------------
 Documentation/arch/arm64/memory.rst 的中文翻譯
 
@@ -24,7 +24,7 @@ Documentation/arch/arm64/memory.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/arch/arm64/perf.rst b/Documentation/translations/zh_TW/arch/arm64/perf.rst
index 3b39997a52eb..645f3944a0f4 100644
--- a/Documentation/translations/zh_TW/arch/arm64/perf.rst
+++ b/Documentation/translations/zh_TW/arch/arm64/perf.rst
@@ -5,7 +5,7 @@
 :Original: :ref:`Documentation/arch/arm64/perf.rst <perf_index>`
 
 Translator: Bailu Lin <bailu.lin@vivo.com>
-            Hu Haowen <src.res@email.cn>
+            Hu Haowen <src.res.211@gmail.com>
 
 =============
 Perf 事件屬性
diff --git a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
index 66c3a3506458..f6f41835a54a 100644
--- a/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/silicon-errata.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 M:	Will Deacon <will.deacon@arm.com>
 zh_CN:	Fu Wei <wefu@redhat.com>
-zh_TW:	Hu Haowen <src.res@email.cn>
+zh_TW:	Hu Haowen <src.res.211@gmail.com>
 C:	1926e54f115725a9248d0c4c65c22acaf94de4c4
 ---------------------------------------------------------------------
 Documentation/arch/arm64/silicon-errata.rst 的中文翻譯
@@ -23,7 +23,7 @@ Documentation/arch/arm64/silicon-errata.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
 本文翻譯提交時的 Git 檢出點爲： 1926e54f115725a9248d0c4c65c22acaf94de4c4
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
index b7f683f20ed1..c0be1d1e0d01 100644
--- a/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
+++ b/Documentation/translations/zh_TW/arch/arm64/tagged-pointers.txt
@@ -10,7 +10,7 @@ or if there is a problem with the translation.
 
 Maintainer: Will Deacon <will.deacon@arm.com>
 Chinese maintainer: Fu Wei <wefu@redhat.com>
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
 ---------------------------------------------------------------------
 Documentation/arch/arm64/tagged-pointers.rst 的中文翻譯
 
@@ -22,7 +22,7 @@ Documentation/arch/arm64/tagged-pointers.rst 的中文翻譯
 中文版維護者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版翻譯者： 傅煒  Fu Wei <wefu@redhat.com>
 中文版校譯者： 傅煒  Fu Wei <wefu@redhat.com>
-繁體中文版校譯者： 胡皓文  Hu Haowen <src.res@email.cn>
+繁體中文版校譯者： 胡皓文  Hu Haowen <src.res.211@gmail.com>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/cpu-freq/core.rst b/Documentation/translations/zh_TW/cpu-freq/core.rst
index 3d890c2f2a61..f1951e1b23bb 100644
--- a/Documentation/translations/zh_TW/cpu-freq/core.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/core.rst
@@ -4,7 +4,7 @@
 
 :Original: :doc:`../../../cpu-freq/core`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_core.rst:
 
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
index 2bb8197cd320..671b1bf0e2c5 100644
--- a/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpu-drivers.rst
@@ -4,7 +4,7 @@
 
 :Original: :doc:`../../../cpu-freq/cpu-drivers`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_cpu-drivers.rst:
 
diff --git a/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
index d80bfed50e8c..49088becd5fa 100644
--- a/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/cpufreq-stats.rst
@@ -4,7 +4,7 @@
 
 :Original: :doc:`../../../cpu-freq/cpufreq-stats`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_cpufreq-stats.rst:
 
diff --git a/Documentation/translations/zh_TW/cpu-freq/index.rst b/Documentation/translations/zh_TW/cpu-freq/index.rst
index 1a8e680f95ed..c6cf825b57a5 100644
--- a/Documentation/translations/zh_TW/cpu-freq/index.rst
+++ b/Documentation/translations/zh_TW/cpu-freq/index.rst
@@ -4,7 +4,7 @@
 
 :Original: :doc:`../../../cpu-freq/index`
 :Translator: Yanteng Si <siyanteng@loongson.cn>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_index.rst:
 
diff --git a/Documentation/translations/zh_TW/disclaimer-zh_TW.rst b/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
index f4cf87d03dc5..0d0ffb1ca4e8 100644
--- a/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
+++ b/Documentation/translations/zh_TW/disclaimer-zh_TW.rst
@@ -7,5 +7,5 @@
 
 .. note::
      如果您發現本文檔與原始文件有任何不同或者有翻譯問題，請聯繫該文件的譯者，
-     或者發送電子郵件給胡皓文以獲取幫助：<src.res@email.cn>。
+     或者發送電子郵件給胡皓文以獲取幫助：<src.res.211@gmail.com>。
 
diff --git a/Documentation/translations/zh_TW/filesystems/debugfs.rst b/Documentation/translations/zh_TW/filesystems/debugfs.rst
index 270dd94fddf1..ddf801943c92 100644
--- a/Documentation/translations/zh_TW/filesystems/debugfs.rst
+++ b/Documentation/translations/zh_TW/filesystems/debugfs.rst
@@ -14,12 +14,12 @@ Debugfs
 	中文版維護者：羅楚成 Chucheng Luo <luochucheng@vivo.com>
 	中文版翻譯者：羅楚成 Chucheng Luo <luochucheng@vivo.com>
 	中文版校譯者: 羅楚成 Chucheng Luo <luochucheng@vivo.com>
-	繁體中文版校譯者: 胡皓文 Hu Haowen <src.res@email.cn>
+	繁體中文版校譯者: 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 
 版權所有2020 羅楚成 <luochucheng@vivo.com>
-版權所有2021 胡皓文 Hu Haowen <src.res@email.cn>
+版權所有2021 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 Debugfs是內核開發人員在用戶空間獲取信息的簡單方法。與/proc不同，proc只提供進程
diff --git a/Documentation/translations/zh_TW/filesystems/index.rst b/Documentation/translations/zh_TW/filesystems/index.rst
index 4e5dde0dca3c..789e742fa3c5 100644
--- a/Documentation/translations/zh_TW/filesystems/index.rst
+++ b/Documentation/translations/zh_TW/filesystems/index.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/filesystems/index.rst <filesystems_index>`
 :Translator: Wang Wenhu <wenhu.wang@vivo.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_filesystems_index:
 
diff --git a/Documentation/translations/zh_TW/filesystems/sysfs.txt b/Documentation/translations/zh_TW/filesystems/sysfs.txt
index 280824cc7e5d..a84eba2af9d3 100644
--- a/Documentation/translations/zh_TW/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
@@ -22,7 +22,7 @@ Documentation/filesystems/sysfs.rst 的中文翻譯
 中文版維護者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
 中文版翻譯者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
 中文版校譯者： 傅煒 Fu Wei <tekkamanninja@gmail.com>
-繁體中文版校譯者：胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版校譯者：胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/filesystems/tmpfs.rst b/Documentation/translations/zh_TW/filesystems/tmpfs.rst
index 8d753a34785b..2c8439b2b77e 100644
--- a/Documentation/translations/zh_TW/filesystems/tmpfs.rst
+++ b/Documentation/translations/zh_TW/filesystems/tmpfs.rst
@@ -5,7 +5,7 @@
 :Original: Documentation/filesystems/tmpfs.rst
 
 Translated by Wang Qing <wangqing@vivo.com>
-and Hu Haowen <src.res@email.cn>
+and Hu Haowen <src.res.211@gmail.com>
 
 =====
 Tmpfs
diff --git a/Documentation/translations/zh_TW/filesystems/virtiofs.rst b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
index 2b05e84375dd..086fce5839dd 100644
--- a/Documentation/translations/zh_TW/filesystems/virtiofs.rst
+++ b/Documentation/translations/zh_TW/filesystems/virtiofs.rst
@@ -11,7 +11,7 @@
 	中文版翻譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
 	中文版校譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
 	中文版校譯者： 王文虎 Wang Wenhu <wenhu.wang@vivo.com>
-	繁體中文版校譯者：胡皓文 Hu Haowen <src.res@email.cn>
+	繁體中文版校譯者：胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 ===========================================
 virtiofs: virtio-fs 主機<->客機共享文件系統
diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/translations/zh_TW/gpio.txt
index b93788a2628b..555e4b11a5c7 100644
--- a/Documentation/translations/zh_TW/gpio.txt
+++ b/Documentation/translations/zh_TW/gpio.txt
@@ -8,7 +8,7 @@ or if there is a problem with the translation.
 
 Maintainer: Grant Likely <grant.likely@secretlab.ca>
 		Linus Walleij <linus.walleij@linaro.org>
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
 ---------------------------------------------------------------------
 Documentation/admin-guide/gpio 的繁體中文翻譯
 
@@ -18,9 +18,9 @@ Documentation/admin-guide/gpio 的繁體中文翻譯
 
 英文版維護者： Grant Likely <grant.likely@secretlab.ca>
 		Linus Walleij <linus.walleij@linaro.org>
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版校譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index e7c83868e780..5e7e3b117b42 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -15,7 +15,7 @@
 
 .. note::
    內核文檔繁體中文版的翻譯工作正在進行中。如果您願意並且有時間參與這項工
-   作，歡迎提交補丁給胡皓文 <src.res@email.cn>。
+   作，歡迎提交補丁給胡皓文 <src.res.211@gmail.com>。
 
 許可證文檔
 ----------
diff --git a/Documentation/translations/zh_TW/io_ordering.txt b/Documentation/translations/zh_TW/io_ordering.txt
index 1e99206c8421..03f86840c139 100644
--- a/Documentation/translations/zh_TW/io_ordering.txt
+++ b/Documentation/translations/zh_TW/io_ordering.txt
@@ -6,7 +6,7 @@ communicating in English you can also ask the Chinese maintainer for
 help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
 ---------------------------------------------------------------------
 Documentation/driver-api/io_ordering.rst 的繁體中文翻譯
 
@@ -14,9 +14,9 @@ Documentation/driver-api/io_ordering.rst 的繁體中文翻譯
 交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
 者翻譯存在問題，請聯繫繁體中文版維護者。
 
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版校譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版校譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 以下爲正文
diff --git a/Documentation/translations/zh_TW/process/1.Intro.rst b/Documentation/translations/zh_TW/process/1.Intro.rst
index ca2b931be6c5..f236fe95a6c6 100644
--- a/Documentation/translations/zh_TW/process/1.Intro.rst
+++ b/Documentation/translations/zh_TW/process/1.Intro.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_process_intro:
 
diff --git a/Documentation/translations/zh_TW/process/2.Process.rst b/Documentation/translations/zh_TW/process/2.Process.rst
index 9d465df1f6c3..17bb4e07d171 100644
--- a/Documentation/translations/zh_TW/process/2.Process.rst
+++ b/Documentation/translations/zh_TW/process/2.Process.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_process:
 
diff --git a/Documentation/translations/zh_TW/process/3.Early-stage.rst b/Documentation/translations/zh_TW/process/3.Early-stage.rst
index 076873ca0905..636e506fd196 100644
--- a/Documentation/translations/zh_TW/process/3.Early-stage.rst
+++ b/Documentation/translations/zh_TW/process/3.Early-stage.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_early_stage:
 
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index 7fc0344ed16b..adb5339aab6a 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_coding:
 
diff --git a/Documentation/translations/zh_TW/process/5.Posting.rst b/Documentation/translations/zh_TW/process/5.Posting.rst
index 280a8832ecc0..27015622ad63 100644
--- a/Documentation/translations/zh_TW/process/5.Posting.rst
+++ b/Documentation/translations/zh_TW/process/5.Posting.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_posting:
 
diff --git a/Documentation/translations/zh_TW/process/6.Followthrough.rst b/Documentation/translations/zh_TW/process/6.Followthrough.rst
index 4af782742db3..5073b6e77c1c 100644
--- a/Documentation/translations/zh_TW/process/6.Followthrough.rst
+++ b/Documentation/translations/zh_TW/process/6.Followthrough.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_followthrough:
 
diff --git a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
index 4fbc104a37ca..2cbd16bfed29 100644
--- a/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
+++ b/Documentation/translations/zh_TW/process/7.AdvancedTopics.rst
@@ -11,7 +11,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_advancedtopics:
 
diff --git a/Documentation/translations/zh_TW/process/8.Conclusion.rst b/Documentation/translations/zh_TW/process/8.Conclusion.rst
index 044fcc118bef..1207991d1570 100644
--- a/Documentation/translations/zh_TW/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_TW/process/8.Conclusion.rst
@@ -10,7 +10,7 @@
 :校譯:
 
  吳想成 Wu XiangCheng <bobwxc@email.cn>
- 胡皓文 Hu Haowen <src.res@email.cn>
+ 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_conclusion:
 
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
index 949d831aaf6c..920bb0f36974 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct-interpretation.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/code-of-conduct-interpretation.rst <code_of_conduct_interpretation>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_code_of_conduct_interpretation:
 
diff --git a/Documentation/translations/zh_TW/process/code-of-conduct.rst b/Documentation/translations/zh_TW/process/code-of-conduct.rst
index 716e5843b6e9..e3087112f0bc 100644
--- a/Documentation/translations/zh_TW/process/code-of-conduct.rst
+++ b/Documentation/translations/zh_TW/process/code-of-conduct.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/code-of-conduct.rst <code_of_conduct>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_code_of_conduct:
 
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index 61e614aad6a7..83862e4d3b64 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -15,7 +15,7 @@
                  管旭東 Xudong Guan <xudong.guan@gmail.com>
                  Li Zefan <lizf@cn.fujitsu.com>
                  Wang Chen <wangchen@cn.fujitsu.com>
-                 Hu Haowen <src.res@email.cn>
+                 Hu Haowen <src.res.211@gmail.com>
 
 Linux 內核代碼風格
 =========================
diff --git a/Documentation/translations/zh_TW/process/development-process.rst b/Documentation/translations/zh_TW/process/development-process.rst
index 45e6385647cd..f4cf5c2bbc82 100644
--- a/Documentation/translations/zh_TW/process/development-process.rst
+++ b/Documentation/translations/zh_TW/process/development-process.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/development-process.rst <development_process_main>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_development_process_main:
 
diff --git a/Documentation/translations/zh_TW/process/email-clients.rst b/Documentation/translations/zh_TW/process/email-clients.rst
index 4ba543d06f3b..ae63e41d9cee 100644
--- a/Documentation/translations/zh_TW/process/email-clients.rst
+++ b/Documentation/translations/zh_TW/process/email-clients.rst
@@ -14,7 +14,7 @@
         中文版校譯者： Yinglin Luan <synmyth@gmail.com>
         	       Xiaochen Wang <wangxiaochen0@gmail.com>
                        yaxinsn <yaxinsn@163.com>
-                      Hu Haowen <src.res@email.cn>
+                      Hu Haowen <src.res.211@gmail.com>
 
 Linux郵件客戶端配置信息
 =======================
diff --git a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
index fbde3e26eda5..8e4db8baa0d1 100644
--- a/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
+++ b/Documentation/translations/zh_TW/process/embargoed-hardware-issues.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/embargoed-hardware-issues.rst <embargoed_hardware_issues>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 被限制的硬體問題
 ================
diff --git a/Documentation/translations/zh_TW/process/howto.rst b/Documentation/translations/zh_TW/process/howto.rst
index ea2f468d3e58..306f5b77b4b8 100644
--- a/Documentation/translations/zh_TW/process/howto.rst
+++ b/Documentation/translations/zh_TW/process/howto.rst
@@ -16,7 +16,7 @@
                    鍾宇  TripleX Chung <xxx.phy@gmail.com>
                    陳琦  Maggie Chen <chenqi@beyondsoft.com>
                    王聰  Wang Cong <xiyou.wangcong@gmail.com>
-                   胡皓文 Hu Haowen <src.res@email.cn>
+                   胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 如何參與Linux內核開發
 =====================
diff --git a/Documentation/translations/zh_TW/process/index.rst b/Documentation/translations/zh_TW/process/index.rst
index c5c59b4fd595..d742642dab01 100644
--- a/Documentation/translations/zh_TW/process/index.rst
+++ b/Documentation/translations/zh_TW/process/index.rst
@@ -9,7 +9,7 @@
 
 :Original: :ref:`Documentation/process/index.rst <process_index>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_process_index:
 
diff --git a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
index 8f225379b12c..963ecece3db1 100644
--- a/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-driver-statement.rst
@@ -6,7 +6,7 @@
 
 :Original: :ref:`Documentation/process/kernel-driver-statement.rst <process_statement_driver>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 內核驅動聲明
 ------------
diff --git a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
index 99e21d22800d..2861f4a15721 100644
--- a/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/zh_TW/process/kernel-enforcement-statement.rst
@@ -6,7 +6,7 @@
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 Linux 內核執行聲明
 ------------------
diff --git a/Documentation/translations/zh_TW/process/license-rules.rst b/Documentation/translations/zh_TW/process/license-rules.rst
index ad2b80f97123..503b6701bde4 100644
--- a/Documentation/translations/zh_TW/process/license-rules.rst
+++ b/Documentation/translations/zh_TW/process/license-rules.rst
@@ -6,7 +6,7 @@
 
 :Original: :ref:`Documentation/process/license-rules.rst <kernel_licensing>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_kernel_licensing:
 
diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
index c9e3db12c3f9..5657d5cd18d4 100644
--- a/Documentation/translations/zh_TW/process/magic-number.rst
+++ b/Documentation/translations/zh_TW/process/magic-number.rst
@@ -12,7 +12,7 @@
         中文版維護者： 賈威威 Jia Wei Wei <harryxiyou@gmail.com>
         中文版翻譯者： 賈威威 Jia Wei Wei <harryxiyou@gmail.com>
         中文版校譯者： 賈威威 Jia Wei Wei <harryxiyou@gmail.com>
-                      胡皓文 Hu Haowen <src.res@email.cn>
+                      胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 Linux 魔術數
 ============
diff --git a/Documentation/translations/zh_TW/process/management-style.rst b/Documentation/translations/zh_TW/process/management-style.rst
index dce248470063..e9d29024f4c9 100644
--- a/Documentation/translations/zh_TW/process/management-style.rst
+++ b/Documentation/translations/zh_TW/process/management-style.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/management-style.rst <managementstyle>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_managementstyle:
 
diff --git a/Documentation/translations/zh_TW/process/programming-language.rst b/Documentation/translations/zh_TW/process/programming-language.rst
index 144bdaf81a41..e33389676eed 100644
--- a/Documentation/translations/zh_TW/process/programming-language.rst
+++ b/Documentation/translations/zh_TW/process/programming-language.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/programming-language.rst <programming_language>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_programming_language:
 
diff --git a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
index 22caa5b8d422..33fc85c2cc51 100644
--- a/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
+++ b/Documentation/translations/zh_TW/process/stable-api-nonsense.rst
@@ -12,7 +12,7 @@
         中文版維護者： 鍾宇  TripleX Chung <xxx.phy@gmail.com>
         中文版翻譯者： 鍾宇  TripleX Chung <xxx.phy@gmail.com>
         中文版校譯者： 李陽  Li Yang <leoyang.li@nxp.com>
-                      胡皓文 Hu Haowen <src.res@email.cn>
+                      胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 Linux 內核驅動接口
 ==================
diff --git a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
index 9bb0d9b4f3ac..29d9a70a1868 100644
--- a/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
+++ b/Documentation/translations/zh_TW/process/stable-kernel-rules.rst
@@ -15,7 +15,7 @@
         中文版校譯者：
             - 李陽  Li Yang <leoyang.li@nxp.com>
             - Kangkai Yin <e12051@motorola.com>
-            - 胡皓文 Hu Haowen <src.res@email.cn>
+            - 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 所有你想知道的事情 - 關於linux穩定版發布
 ========================================
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index ff2f89cba83f..12bf6f5ca5c6 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -4,7 +4,7 @@
 
 :Original: :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
-             Hu Haowen <src.res@email.cn>
+             Hu Haowen <src.res.211@gmail.com>
 
 .. _tw_submitchecklist:
 
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index 3f77ef5d48a0..0746809c31a2 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -13,7 +13,7 @@
                        時奎亮 Alex Shi <alex.shi@linux.alibaba.com>
         中文版校譯者： 李陽 Li Yang <leoyang.li@nxp.com>
                        王聰 Wang Cong <xiyou.wangcong@gmail.com>
-                       胡皓文 Hu Haowen <src.res@email.cn>
+                       胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 
 如何讓你的改動進入內核
diff --git a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
index 097fe80352cb..469cb5b3a07c 100644
--- a/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
+++ b/Documentation/translations/zh_TW/process/volatile-considered-harmful.rst
@@ -17,7 +17,7 @@
         中文版校譯者： 張漢輝  Eugene Teo <eugeneteo@kernel.sg>
                        楊瑞  Dave Young <hidave.darkstar@gmail.com>
                        時奎亮 Alex Shi <alex.shi@linux.alibaba.com>
-                       胡皓文 Hu Haowen <src.res@email.cn>
+                       胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 爲什麼不應該使用「volatile」類型
 ================================
diff --git a/Documentation/translations/zh_TW/sparse.txt b/Documentation/translations/zh_TW/sparse.txt
index c9acb2c926cb..56fb17fd1359 100644
--- a/Documentation/translations/zh_TW/sparse.txt
+++ b/Documentation/translations/zh_TW/sparse.txt
@@ -6,7 +6,7 @@ communicating in English you can also ask the Chinese maintainer for
 help.  Contact the Chinese maintainer if this translation is outdated
 or if there is a problem with the translation.
 
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
+Traditional Chinese maintainer: Hu Haowen <src.res.211@gmail.com>
 ---------------------------------------------------------------------
 Documentation/dev-tools/sparse.rst 的繁體中文翻譯
 
@@ -14,8 +14,8 @@ Documentation/dev-tools/sparse.rst 的繁體中文翻譯
 交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
 者翻譯存在問題，請聯繫繁體中文版維護者。
 
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+繁體中文版維護者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
+繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res.211@gmail.com>
 
 以下爲正文
 ---------------------------------------------------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index 0022277a9405..13e7ddf46cd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21612,7 +21612,7 @@ F:	kernel/trace/trace_osnoise.c
 F:	kernel/trace/trace_sched_wakeup.c
 
 TRADITIONAL CHINESE DOCUMENTATION
-M:	Hu Haowen <src.res@email.cn>
+M:	Hu Haowen <src.res.211@gmail.com>
 L:	linux-doc-tw-discuss@lists.sourceforge.net (moderated for non-subscribers)
 S:	Maintained
 W:	https://github.com/srcres258/linux-doc
-- 
2.34.1

