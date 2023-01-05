Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA01E65E1E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbjAEAny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240711AbjAEAiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995B0C52;
        Wed,  4 Jan 2023 16:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44EB26189D;
        Thu,  5 Jan 2023 00:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A025C433AF;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=CxNoIVnojblXsI8lyz2C7HZU+DjFixYiXxVzbQ0VHio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxIGer1xiDRSnTm9x+cgEIpwPFleN8jJWt7nMRRFCSNe+IWTPwYTPyl5NaUl3Z4aU
         dadJN77L9NqR9PdFB9lFm8MfKtwIQ6jpV4quuiu01+O8ajM3E35AQh8cZdUl6nZBLZ
         nBXuH8yoJRw/hekFt71mCZkAz/R1CalnZBztCaLfVhLzuIZzJSRXdfAv22QWX6MG8E
         u76P2bubsn8cWa8WvKGHPc+Cq0NjeBXz+u6wzGCT0E+EZf7NEOCx3kHPSTYMCnit4b
         2mty9hdlvm3dC5fGSWvfeQLF7dP3gNWcdXW6PFQljLNrS9r5FAP33KYolJbT8xWfwz
         EENLg03YirXsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C5AAC5C1C5D; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH rcu 09/27] drivers/clk: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:37:55 -0800
Message-Id: <20230105003813.1770367-9-paulmck@kernel.org>
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
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: <linux-clk@vger.kernel.org>
---
 drivers/clk/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d79905f3e1744..b6c5bf69a2b2c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -23,7 +23,6 @@ menuconfig COMMON_CLK
 	depends on !HAVE_LEGACY_CLK
 	select HAVE_CLK_PREPARE
 	select HAVE_CLK
-	select SRCU
 	select RATIONAL
 	help
 	  The common clock framework is a single definition of struct
-- 
2.31.1.189.g2e36527f23

