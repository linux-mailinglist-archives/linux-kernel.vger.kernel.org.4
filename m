Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B2608EBA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJVQ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJVQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:58:57 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C418644B;
        Sat, 22 Oct 2022 09:58:51 -0700 (PDT)
X-QQ-mid: bizesmtp87t1666457439tnrfffrl
Received: from wuhui-virtual-machine.localdoma ( [58.60.63.196])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 23 Oct 2022 00:49:58 +0800 (CST)
X-QQ-SSF: 02400000000000F0V000B00A0000000
X-QQ-FEAT: iVzOovY9ZxLI57ptDEI/2/CstWdqqB6ILnew/GcYIEneYn6AIk9dnlMFDvvDI
        aFLij5lGAvRo8yMnUJvwzJhr4wSPZKRm+RCmPk2bp9PxcOMEQfaXWbb3UpuSDY6qRVgfjhG
        Rj7oZLvxkm+FdKe5NaS/yIYzZyicKAFIUQZEdgN7Dvvzh6c+IDoMj7h8GK+vTxPmpSJhRNu
        SisLdLITX/ZXEZIs1+fNc6arEN2A6Wt2wTRi+Pq19UrhL3ZI/Gbv9R3heThOwffrO7fmVgE
        7RaIBGln8uB+MGH4TQPYmdAW3JVaZVlMi2plEwie895izckkhJgEGM+Xi2xJJA4mR5vW/MY
        uFXRWaWJqp6edlCSd6eMV0ZjRzZUxQtdIv2jB3u
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     alexs@kernel.org
Cc:     siyanteng@loongson.cn, corbet@lwn.net, bobwxc@email.cn,
        rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] docs/zh_CN: Update the translation of page_owner
Date:   Sun, 23 Oct 2022 00:49:51 +0800
Message-Id: <20221022164951.26679-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

