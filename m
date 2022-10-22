Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359A608EBC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJVRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJVRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:01:09 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A6E9526C;
        Sat, 22 Oct 2022 10:01:03 -0700 (PDT)
X-QQ-mid: bizesmtp85t1666458045tm8bz186
Received: from wuhui-virtual-machine.localdoma ( [58.251.166.8])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 23 Oct 2022 01:00:36 +0800 (CST)
X-QQ-SSF: 00400000002000F0V000B00A0000000
X-QQ-FEAT: DoD8xN2rKoxv9XYHxCitxjjL/t7Y0Mna03sGCJd9y8ACyAsHyTSv4Wr1tBiuv
        hBl9n4oeKq2c0os46RyIHXgmIGbgnCzhcClOC4hkKkDeYnMsNyIAt0jX+C3jSnNcatw2+Cd
        ABjtsLjHj98A6zlz78Fs/igvPVRuGSmhe7rplBMSIQ1ATBZANc/ny/Cmf0zhlUCJf7lWT0+
        sl4PoU/CaHaQxUiaYMVxYUidRBduWcpkwqSvIHNaTaIRV1fn6kXW7uad3+iHMcFGdVejthj
        s8QmZFsrRVCB/4Po8fA2u/eouGv+Gl5Nnymfz4cecRAuUX910GGo5en7BrwK+5LL0edKWli
        +In7xfbci9M5NXwKECHpTFK5PUIlKB2nUllAKf74YRn/kmH/Z+7LxiGGjWrcwA1j3aflxAP
        nG3yii5zyMw=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     alexs@kernel.org
Cc:     siyanteng@loongson.cn, corbet@lwn.net, bobwxc@email.cn,
        rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] docs/zh_CN: Update the translation of page_owner
Date:   Sun, 23 Oct 2022 01:00:33 +0800
Message-Id: <20221022170033.27123-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to commit 0719fdba5483 ("Documentation/mm/page_owner.rst:
delete frequently changing experimental data").

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 .../translations/zh_CN/mm/page_owner.rst        | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/Documentation/translations/zh_CN/mm/page_owner.rst b/Documentation/translations/zh_CN/mm/page_owner.rst
index 21a6a0837d42..2c4c02aab120 100644
--- a/Documentation/translations/zh_CN/mm/page_owner.rst
+++ b/Documentation/translations/zh_CN/mm/page_owner.rst
@@ -34,20 +34,9 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
 一样进行。这两个不可能的分支应该不会影响到分配的性能，特别是在静态键跳转标签修补
 功能可用的情况下。以下是由于这个功能而导致的内核代码大小的变化。
 
-- 没有page owner::
-
-   text    data     bss     dec     hex filename
-   48392   2333     644   51369    c8a9 mm/page_alloc.o
-
-- 有page owner::
-
-   text    data     bss     dec     hex filename
-   48800   2445     644   51889    cab1 mm/page_alloc.o
-   6662     108      29    6799    1a8f mm/page_owner.o
-   1025       8       8    1041     411 mm/page_ext.o
-
-虽然总共增加了8KB的代码，但page_alloc.o增加了520字节，其中不到一半是在hotpath
-中。构建带有page owner的内核，并在需要时打开它，将是调试内核内存问题的最佳选择。
+尽管启用page owner增加了几千字节的代码，但是这些代码的大部分都不在页分配器和它
+的热路径中。构建带有page owner的内核，并在需要时打开它，将是调试内核内存问题的
+最佳选择。
 
 有一个问题是由实现细节引起的。页所有者将信息存储到struct page扩展的内存中。这
 个内存的初始化时间比稀疏内存系统中的页面分配器启动的时间要晚一些，所以，在初始化
-- 
2.17.1

