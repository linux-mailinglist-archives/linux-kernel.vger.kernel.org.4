Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F369BBC3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBRUTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBRUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:19:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF114989
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 12:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB33DB808BE
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 20:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E18C433D2;
        Sat, 18 Feb 2023 20:19:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pTTgC-000xsF-0Z;
        Sat, 18 Feb 2023 15:19:32 -0500
Message-ID: <20230218201931.992043332@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 18 Feb 2023 15:18:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        zhang songyi <zhang.songyi@zte.com.cn>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 1/8] tools/rv: Remove unneeded semicolon
References: <20230218201821.938318263@goodmis.org>
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

From: zhang songyi <zhang.songyi@zte.com.cn>

The semicolon after the "}" is unneeded.

Link: https://lore.kernel.org/linux-trace-devel/202212191431057948891@zte.com.cn

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 50848d79b38b..ad28582bcf2b 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -519,7 +519,7 @@ static void ikm_usage_print_reactors(void)
 
 		start = ++end;
 		end = strstr(start, "\n");
-	};
+	}
 
 	fprintf(stderr, "\n");
 }
-- 
2.39.1
