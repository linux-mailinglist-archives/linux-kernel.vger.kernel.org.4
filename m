Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80374BC49
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjGHFob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 01:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjGHFoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 01:44:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BCC26A5;
        Fri,  7 Jul 2023 22:41:09 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-2633fe9b6c0so2627346a91.1;
        Fri, 07 Jul 2023 22:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688794864; x=1691386864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sXFLgdySN27+OmaB0qUhEi9pRI3x4DTx6V9k7go5av0=;
        b=eYzRafkE3bJ655p/TyOYzRrcoMEtBSw3TvOVzKamhZmQIN2p97CEnXazPlVD1IL0qr
         z1EYmmOtnud4Ohh8Wxre7m3yDtFNa9C+gBPlbOD3ar36lEEXQAzHL9brXwG+SRC5TE57
         hwvjAko/9J5y3jM67Zt5GVKgngSiIAr54PZrQRjS6nV2y3xCBq8vrOkq66/SVQLq1aA/
         2W9Wb5oxY3Twnsw6aPGA0/bPVBGKY854p8kvW6oe0OsUfgkSHOszHZZTDcSATpXvGKmQ
         Ix+32CeRN2Zfwi0xoi1NBX2nsJiXXpZ+76s5jExp/r171ecSnYrPlTdtDvFNnHh5HAXj
         AFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688794864; x=1691386864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXFLgdySN27+OmaB0qUhEi9pRI3x4DTx6V9k7go5av0=;
        b=ZNqclVxtczOdodATsCbXp5/JjMnBRAbnD5xEeoznapKevzo8PK3Ag1ViPqAuv3aI7Y
         KZ5BGooLrQ07ir+pxPhzHXzHA9LYtxkeDUKaqi96qGW7odQ75gWx5Taw8al76odbXXRa
         IrEK7r9nDnhplh5ZmeQuhYsct6YNUXIfUE5YVEmIU/yohbg3pjgl/NQ0pF9oNDP+OSeT
         AkZY7iUj2VpaQgjBJFlf6Xn27soBWRIb+iHzyyKIsjvSNhFDvVgMz0sJ/yyy92/5IuaS
         QtZAfn4Qj8n1iD9Y6HmXFHJeI/Q2D3mmywm7m8qthUS1tkSrZE+4I/VfiJPQ3/nlE7fp
         A5OA==
X-Gm-Message-State: ABy/qLanPmXewvVfA67bJ/iTHrYeD0Vc9cQhKlnoFy6+Oyk8o0ZTbaUT
        CtxRB2Q+sU7R99RexxyZyOA=
X-Google-Smtp-Source: APBJJlEqbCYl1Rciyc/ejr/5IHQZOh2iw9V8AJy4r3PVeOy+1uyqXbkKKDwQVYqYFx6FovyFiLAxRg==
X-Received: by 2002:a17:90b:1812:b0:262:f550:6413 with SMTP id lw18-20020a17090b181200b00262f5506413mr15459640pjb.6.1688794863629;
        Fri, 07 Jul 2023 22:41:03 -0700 (PDT)
Received: from localhost.localdomain ([113.251.4.177])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a284f00b00262e5449dbcsm2548354pjf.24.2023.07.07.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 22:41:02 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     corbet@lwn.net, siyanteng@loongson.cn, bobwxc@email.cn,
        alexs@kernel.org, gregkh@linuxfoundation.org,
        nabijaczleweli@nabijaczleweli.xyz, carlos.bilbao@amd.com,
        me@lirui.org
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_TW: rewrite index.rst
Date:   Sat,  8 Jul 2023 13:40:52 +0800
Message-Id: <20230708054052.45967-1-src.res.211@gmail.com>
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

Update zh_TW's index.rst to the version of commit 0c7b4366f1ab ("docs:
Rewrite the front page") with some reference from commit f4bf1cd4ac9c
("docs: move asm-annotations.rst into core-api") and commit eef24f7054a6
("docs/zh_CN: Rewrite the Chinese translation front page").

Signed-off-by: Hu Haowen <src.res.211@gmail.com>
---
 Documentation/translations/zh_TW/index.rst | 156 ++++++++-------------
 1 file changed, 56 insertions(+), 100 deletions(-)

diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index e7c83868e780..fe0c8b34bafc 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -17,157 +17,113 @@
    內核文檔繁體中文版的翻譯工作正在進行中。如果您願意並且有時間參與這項工
    作，歡迎提交補丁給胡皓文 <src.res@email.cn>。
 
-許可證文檔
-----------
-
-下面的文檔介紹了Linux內核原始碼的許可證（GPLv2）、如何在原始碼樹中正確標記
-單個文件的許可證、以及指向完整許可證文本的連結。
-
-Documentation/translations/zh_TW/process/license-rules.rst
+與Linux 內核社區一起工作
+------------------------
 
-用戶文檔
---------
-
-下面的手冊是爲內核用戶編寫的——即那些試圖讓它在給定系統上以最佳方式工作的
-用戶。
+與內核開發社區進行協作並將工作推向上游的基本指南。
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   admin-guide/index
+   process/development-process
+   process/submitting-patches
+   行爲準則 <process/code-of-conduct>
+   完整開發流程文檔 <process/index>
 
 TODOList:
 
-* kbuild/index
+* maintainer/index
 
-固件相關文檔
-------------
+內部API文檔
+-----------
 
-下列文檔描述了內核需要的平台固件相關信息。
+開發人員使用的內核內部交互接口手冊。
 
 TODOList:
 
-* firmware-guide/index
-* devicetree/index
-
-應用程式開發人員文檔
---------------------
-
-用戶空間API手冊涵蓋了描述應用程式開發人員可見內核接口方面的文檔。
-
-TODOlist:
-
-* userspace-api/index
+* core-api/index
+* driver-api/index
+* 內核中的鎖 <locking/index>
+* subsystem-apis
 
-內核開發簡介
-------------
+開發工具和流程
+--------------
 
-這些手冊包含有關如何開發內核的整體信息。內核社區非常龐大，一年下來有數千名
-開發人員做出貢獻。與任何大型社區一樣，知道如何完成任務將使得更改合併的過程
-變得更加容易。
+爲所有內核開發人員提供有用信息的各種其他手冊。
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   process/index
+   process/license-rules
 
 TODOList:
 
-* dev-tools/index
 * doc-guide/index
+* dev-tools/index
+* dev-tools/testing-overview
 * kernel-hacking/index
+* rust/index
 * trace/index
-* maintainer/index
 * fault-injection/index
 * livepatch/index
-* rust/index
 
-內核API文檔
------------
+面向用戶的文檔
+--------------
 
-以下手冊從內核開發人員的角度詳細介紹了特定的內核子系統是如何工作的。這裡的
-大部分信息都是直接從內核原始碼獲取的，並根據需要添加補充材料（或者至少是在
-我們設法添加的時候——可能不是所有的都是有需要的）。
+下列手冊針對
+希望內核在給定系統上以最佳方式工作的*用戶*，
+和查找內核用戶空間API信息的程序開發人員。
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
-   cpu-freq/index
-   filesystems/index
+   admin-guide/index
+   admin-guide/reporting-issues.rst
 
 TODOList:
 
-* driver-api/index
-* core-api/index
-* locking/index
-* accounting/index
-* block/index
-* cdrom/index
-* ide/index
-* fb/index
-* fpga/index
-* hid/index
-* i2c/index
-* iio/index
-* isdn/index
-* infiniband/index
-* leds/index
-* netlabel/index
-* networking/index
-* pcmcia/index
-* power/index
-* target/index
-* timers/index
-* spi/index
-* w1/index
-* watchdog/index
-* virt/index
-* input/index
-* hwmon/index
-* gpu/index
-* security/index
-* sound/index
-* crypto/index
-* mm/index
-* bpf/index
-* usb/index
-* PCI/index
-* scsi/index
-* misc-devices/index
-* scheduler/index
-* mhi/index
-
-體系結構無關文檔
-----------------
+* userspace-api/index
+* 內核構建系統 <kbuild/index>
+* 用戶空間工具 <tools/index>
 
-TODOList:
+也可參考獨立於內核文檔的 `Linux 手冊頁 <https://www.kernel.org/doc/man-pages/>`_ 。
+
+固件相關文檔
+------------
 
-* asm-annotations
+下列文檔描述了內核需要的平臺固件相關信息。
 
-特定體系結構文檔
-----------------
+TODOList:
 
-.. toctree::
-   :maxdepth: 2
+* devicetree/index
+* firmware-guide/index
 
-   arch/arm64/index
+體系結構文檔
+------------
 
 TODOList:
 
-* arch
+* arch/index
 
 其他文檔
 --------
 
-有幾份未排序的文檔似乎不適合放在文檔的其他部分，或者可能需要進行一些調整和/或
+有幾份未分類的文檔似乎不適合放在文檔的其他部分，或者可能需要進行一些調整和/或
 轉換爲reStructureText格式，也有可能太舊。
 
 TODOList:
 
 * staging/index
-* watch_queue
 
-目錄和表格
+術語表
+------
+
+TODOList:
+
+* glossary
+
+
+索引和表格
 ----------
 
 * :ref:`genindex`
-- 
2.34.1

