Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE402674745
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjASXgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASXga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:36:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3414C93734;
        Thu, 19 Jan 2023 15:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA82761DA8;
        Thu, 19 Jan 2023 23:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03692C433D2;
        Thu, 19 Jan 2023 23:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674171388;
        bh=6wxt7VnSObIZRqbgbFy9W3NyiZJxqTvxvpfGrf1eeYA=;
        h=From:To:Cc:Subject:Date:From;
        b=YCjvRfvX2p69GRCNIO6S1FQgKbxFW8OEDujWOsRI4uW6EDmPwMfOY8sOhYFP+W70H
         cB/KxyhfTO8H2WDUYuwz0TDojtmPNsNiUIUXl+wUqLptJNGQmbHc6rR0ohqKY8wl+8
         5Q97DlTrnW39jK0FqoiVyg7D7cbXAIbmHnunB9Fd/qOqPdk+m5ysjOkK91V81h6YZ7
         RLlCOs43PYEsVUBJdrDybRB0yDv2ZgWskpd2g5I/ubddgCjLfFl4y/VsNck7DUTO2S
         Ln7G/etNY/EJbMkGkSSVic3snGvW5G8OBxgVIpSiE3PUUNg2nJAc1SeSJr2kRSfNl9
         MdWWdtHWAzE7A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Update MAINTAINERS file to add tree and mailing list
Date:   Fri, 20 Jan 2023 08:36:24 +0900
Message-Id: <167417138436.2333752.6988808113120359923.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since the bootconfig related changes will be handled on linux-trace
tree, add the tree and mailing lists for EXTRA BOOT CONFIG.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 MAINTAINERS |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea941dc469fa..bba571b2ec1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7895,7 +7895,11 @@ F:	include/linux/extcon/
 
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

