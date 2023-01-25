Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40367B6C8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjAYQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjAYQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:20:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876816AD7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1070A6153F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19F6C433AF;
        Wed, 25 Jan 2023 16:20:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pKiVQ-004Mvt-07;
        Wed, 25 Jan 2023 11:20:12 -0500
Message-ID: <20230125162011.848693941@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 25 Jan 2023 11:18:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 11/11] bootconfig: Update MAINTAINERS file to add tree and mailing list
References: <20230125161824.332648375@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since the bootconfig related changes will be handled on linux-trace
tree, add the tree and mailing lists for EXTRA BOOT CONFIG.

Link: https://lkml.kernel.org/r/167417138436.2333752.6988808113120359923.stgit@devnote3

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70be8603c8d3..e64ba36ced78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7894,7 +7894,11 @@ F:	include/linux/extcon/
 
 EXTRA BOOT CONFIG
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/admin-guide/bootconfig.rst
 F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
-- 
2.39.0
