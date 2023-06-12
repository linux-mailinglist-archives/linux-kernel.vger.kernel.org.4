Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4559E72D10D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjFLUvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjFLUsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B410109
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCB2262F1B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8D9C43332;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=j0LQ24TQ8hn7bjW10yO2qmeOU+M13OFAUcFTpL2cefU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCuC8fh+QlxTCY5xG4i8JuKCqO6tlVs/PbKHrohOTgt7hDdpeMUPOI/iz7Ng7D2t8
         78IW6X+b+68e7mvsqzIGcxl0JheD7E0GAPAporUUanzCkR57d5jxMcigGsZr3ZZGMV
         0smqwOPlKxXQv3skFuB4e5qCjSmoRxyGSsquzu5HgIQ7T/1uktnJAORlPRbHRprpg3
         ABx65KvMs0jAd0Ce2AtSYrzgtMGBZY4pB++FO2LdfLyCfi2A+7/H1ANlwoaTA3PVbP
         Ptj0a5Hfwjco3Z0zXj5f3cnwEWbw5lxNw2yj6rJ464VPzJCpuoJTnu9vQyOak43Jmd
         f0vfmf9vw2NpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1DB65CE3A8D; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Zhangjin Wu <falcon@tinylab.org>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 46/53] selftests/nolibc: use INT_MAX instead of __INT_MAX__
Date:   Mon, 12 Jun 2023 13:45:07 -0700
Message-Id: <20230612204514.292087-46-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhangjin Wu <falcon@tinylab.org>

nolibc now has INT_MAX in stdint.h, so, don't mix INT_MAX and
__INT_MAX__, unify them to INT_MAX.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7d4b8d12050d..ff3da9539809 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -936,7 +936,7 @@ static const struct test test_names[] = {
 int main(int argc, char **argv, char **envp)
 {
 	int min = 0;
-	int max = __INT_MAX__;
+	int max = INT_MAX;
 	int ret = 0;
 	int err;
 	int idx;
@@ -984,7 +984,7 @@ int main(int argc, char **argv, char **envp)
 				 * here, which defaults to the full range.
 				 */
 				do {
-					min = 0; max = __INT_MAX__;
+					min = 0; max = INT_MAX;
 					value = colon;
 					if (value && *value) {
 						colon = strchr(value, ':');
-- 
2.40.1

