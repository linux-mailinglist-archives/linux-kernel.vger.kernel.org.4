Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29365B758
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjABVQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 16:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjABVQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 16:16:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3060A44D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 13:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=JXtvhHvWzIHQPuNeBeoCkgU8wFjBB1XzC954y/8TQCU=; b=uZ3b34JknfiJ/XYwVfdzr1x7QW
        YO9jFUyixkwz8tTMR2XM352DNe9JqLnxjhU9hEIlip5lVQUX5Dzut2eC6R77GlbgrJqVgd+Y+fvqo
        3VQ9RueDgsYP8RdAtXUeIHYep6D0gdTPUMxnwWkBp5nT+3hlQ9S//YtRFf3GwztJEfyMwTLmx0vOP
        UO83DGAx7rDA/5xJ/RtYi2CBjJJ/sUnk92tUOLUKrF+o0mfhnZVnN8aUbKBuMDYdHT3NNIW/izAKY
        NJFEZMFlcjt78Js81NOsPan/a02whbeL5rJ5c8RISzy1kjptcVs6WRVQA2zyEPQ3Ls14Eq6YoGvJ0
        66K5ET5A==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCSAJ-00EIs0-J3; Mon, 02 Jan 2023 21:16:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Neal Cardwell <ncardwell@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/win_minmax: use /* notation for regular comments
Date:   Mon,  2 Jan 2023 13:16:14 -0800
Message-Id: <20230102211614.26343-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use kernel-doc "/**" notation for non-kernel-doc comments.
Prevents a kernel-doc warning:

lib/win_minmax.c:31: warning: expecting prototype for lib/minmax.c(). Prototype was for minmax_subwin_update() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/win_minmax.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/lib/win_minmax.c b/lib/win_minmax.c
--- a/lib/win_minmax.c
+++ b/lib/win_minmax.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * lib/minmax.c: windowed min/max tracker
  *
  * Kathleen Nichols' algorithm for tracking the minimum (or maximum)
