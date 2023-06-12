Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD11972D11F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbjFLUvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbjFLUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C5E170E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02CD862F2B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2696C4339C;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=m54V3BXYYYooIJldJgkaYR8kVbGMqD7cVsRVfWDay0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spOZrdvFz0K6d+kGIjeQcrpII7KW8yKKYd3Eil3uZOUEzveFbILDXlD5w5K7Lg8Bq
         hRdvCF0ixWbdTjOmrpX38iUzhYwOvHj+9uput8ThlpyvdH66IIii+s37IhvOqvTEDH
         JnOdBnoOhwrfO4THp0cLeteQ6cpE8Wc/O5Bu/L527m/5eU61ujDV7JU3S885blSJFj
         lGgORVDdTGgEbx736hhMrtT0SXyeVWaV0buRAYW8glK2Cmml7FpCK/d8/98MIY56Cm
         +06vGQ87LDWghnGzILPya3Kt2waQ7KvmRx7ONWHeREkEVVYDqRSJ+AzTtePfv2tpDL
         gwqY5RIq1PtPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E1C2DCE3A6B; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 25/53] tools/nolibc: fix typo pint -> point
Date:   Mon, 12 Jun 2023 13:44:46 -0700
Message-Id: <20230612204514.292087-25-paulmck@kernel.org>
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 2d5386a8d6aa..82b43935650f 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -7,7 +7,7 @@
  * the syscall declarations and the _start code definition. This is the only
  * global part. On all architectures the kernel puts everything in the stack
  * before jumping to _start just above us, without any return address (_start
- * is not a function but an entry pint). So at the stack pointer we find argc.
+ * is not a function but an entry point). So at the stack pointer we find argc.
  * Then argv[] begins, and ends at the first NULL. Then we have envp which
  * starts and ends with a NULL as well. So envp=argv+argc+1.
  */
-- 
2.40.1

