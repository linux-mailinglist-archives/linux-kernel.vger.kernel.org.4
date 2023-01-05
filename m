Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51DF65E1CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbjAEAlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240700AbjAEAit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98255C42;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 485156185C;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69826C433AC;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=U+JNmGaLukQdGfoV+R2DP604qkOvEolb/RV2Clv2XIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jW9kE9w6GphGhw9Iug5nV0iloFRPqQiTQ8wW71s9lbUkhgxc7BmTwcbu3skPCx1wW
         svAa1qvvIIS2bpDtotm89534twxgMEmdZUlM5Zwq+hBHjoWkamazXtWpweY7ltoTvu
         zla2ZFlCg7vWAeNEe+uLfX3Y13swrX/AK+UavD+229AP4Q89RnHfhI1xGBQKB273eH
         ELiNK5JQhm3IFumgktlKoQ94sq1VdOn5VoahKNH4HGDItv+jLoLadiPAVX7Op0KZ/N
         o3Shumzvdy2zTutzws9tyNKAe5yMc+K15Q67rhWjLlVBdyVBMitKiEIkPEq5bfaRwC
         6iW0iv4KG+uKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C1FD55C1AE0; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH rcu 07/27] block: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:37:53 -0800
Message-Id: <20230105003813.1770367-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SRCU Kconfig option is unconditionally selected, there is
no longer any point in selecting it.  Therefore, remove the "select SRCU"
Kconfig statements.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 444c5ab3b67e2..5d9d9c84d5165 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -6,7 +6,6 @@ menuconfig BLOCK
        bool "Enable the block layer" if EXPERT
        default y
        select SBITMAP
-       select SRCU
        help
 	 Provide block layer support for the kernel.
 
-- 
2.31.1.189.g2e36527f23

