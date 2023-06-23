Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAD973B126
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjFWHR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWHRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:17:55 -0400
Received: from mail-m11873.qiye.163.com (mail-m11873.qiye.163.com [115.236.118.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB2C6;
        Fri, 23 Jun 2023 00:17:53 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [113.87.232.96])
        by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 13D87900455;
        Fri, 23 Jun 2023 15:17:32 +0800 (CST)
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH] tracing: fix warnings when building htmldocs
Date:   Fri, 23 Jun 2023 15:17:28 +0800
Message-ID: <20230623071728.25688-1-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUwfVkkdQkgaT0tIGUxMTVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSFVDTFVJSElVQk1ZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a88e71d87e12eafkusn13d87900455
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRA6HSo4FT1IDAIuOCwUAUwe
        QjFPC0xVSlVKTUNMTktPTU5JTENMVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpIVUNMVUlISVVCTVlXWQgBWUFJSkpNNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building htmldocs, the following warnings appear:

Documentation/trace/ftrace.rst:2797: WARNING: Literal block expected; none found.
Documentation/trace/ftrace.rst:2816: WARNING: Literal block expected; none found.

So fix it.

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
 Documentation/trace/ftrace.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index df2d3e57a83f..172f35c7308f 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2786,7 +2786,7 @@ option, and these limitations will be eliminated in the future:
   especially when larger types are truncated, whether explicitly or implicitly.
   Here are some specific cases to illustrate this point:
 
-  **Case One**::
+  **Case One**:
 
   The function narrow_to_u8 is defined as follows::
 
@@ -2805,7 +2805,7 @@ option, and these limitations will be eliminated in the future:
   If you pass 0x123456789abcdef to this function and want to narrow it,
   it may be recorded as 0x123456789abcdef instead of 0xef.
 
-  **Case Two**::
+  **Case Two**:
 
   The function error_if_not_4g_aligned is defined as follows::
 
-- 
2.40.1

