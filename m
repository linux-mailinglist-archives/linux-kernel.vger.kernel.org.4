Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7872D0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbjFLUtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjFLUrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E9E1FE0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5D2D62F0C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155F6C4331D;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=gUcb6xxKECKBFd/6RrJssqZdkk+hQheiI8GLvg8JYiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0l6AqtOGHF0a1f6kc2WjhvUoZDmzs9x4t6FUnGRMy/hJj7F0i/T9ht6bsJzUByR2
         3wHFaIry48mj1NL1QU0cQWu7t8j7fAA6EGG6XomAO1UgKCm7IkeUAzqIa1cdHlyhpT
         S+GQcQDCPZYyOkhNMmRPYTD3WC9Ndd5JhjoE7GYvzw5Y1TE4rhIW69H1QJ0RvuwSbw
         1pjL1Hyxlvd0qSlO1KcN/6oE3H1yorCuipKjXlCdj3HRJbuZILl5h0JWgMg1YMkjfD
         juODaxffU2TKdSEdiiV5mCbrw6R1Kv6AtMDr63Gged8vbzcw9PSsRUa5q/D+3CmB/x
         PdFlxh+d+JF5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAD18CE3A78; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 29/53] tools/nolibc: reformat list of headers to be installed
Date:   Mon, 12 Jun 2023 13:44:50 -0700
Message-Id: <20230612204514.292087-29-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

This makes it easier to add and remove more entries in the future
without creating spurious diff hunks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/Makefile | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 9839feafd38a..e37c3ac86e23 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,22 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h stackprotector.h std.h stdint.h \
-             stdio.h stdlib.h string.h sys.h time.h types.h unistd.h
+all_files := \
+		ctype.h \
+		errno.h \
+		nolibc.h \
+		signal.h \
+		stackprotector.h \
+		std.h \
+		stdint.h \
+		stdlib.h \
+		string.h \
+		sys.h \
+		time.h \
+		types.h \
+		unistd.h \
+		stdio.h \
+
 
 # install all headers needed to support a bare-metal compiler
 all: headers
-- 
2.40.1

