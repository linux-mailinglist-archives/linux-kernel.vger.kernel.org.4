Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA33473BA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjFWOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFWOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B92D5E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FF561A77
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 14:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A44C433C0;
        Fri, 23 Jun 2023 14:45:41 +0000 (UTC)
Date:   Fri, 23 Jun 2023 10:45:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [for-next][PATCH] tracing: Fix warnings when building htmldocs for
 function graph retval
Message-ID: <20230623104539.0b167b12@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: fc30ace06f250f79381a8e3f6ed92dd68e25a9f5


Donglin Peng (1):
      tracing: Fix warnings when building htmldocs for function graph retval

----
 Documentation/trace/ftrace.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---------------------------
commit fc30ace06f250f79381a8e3f6ed92dd68e25a9f5
Author: Donglin Peng <pengdonglin@sangfor.com.cn>
Date:   Fri Jun 23 15:17:28 2023 +0800

    tracing: Fix warnings when building htmldocs for function graph retval
    
    When building htmldocs, the following warnings appear:
    
    Documentation/trace/ftrace.rst:2797: WARNING: Literal block expected; none found.
    Documentation/trace/ftrace.rst:2816: WARNING: Literal block expected; none found.
    
    So fix it.
    
    Link: https://lore.kernel.org/all/20230623143517.19ffc6c0@canb.auug.org.au/
    Link: https://lkml.kernel.org/r/20230623071728.25688-1-pengdonglin@sangfor.com.cn
    
    Fixes: 21c094d3f8a6 ("tracing: Add documentation for funcgraph-retval and funcgraph-retval-hex")
    Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
    Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index b7308ab10c0e..f606c5bd1c0d 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2792,7 +2792,7 @@ option, and these limitations will be eliminated in the future:
   especially when larger types are truncated, whether explicitly or implicitly.
   Here are some specific cases to illustrate this point:
 
-  **Case One**::
+  **Case One**:
 
   The function narrow_to_u8 is defined as follows::
 
@@ -2811,7 +2811,7 @@ option, and these limitations will be eliminated in the future:
   If you pass 0x123456789abcdef to this function and want to narrow it,
   it may be recorded as 0x123456789abcdef instead of 0xef.
 
-  **Case Two**::
+  **Case Two**:
 
   The function error_if_not_4g_aligned is defined as follows::
 
