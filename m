Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D265E1DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbjAEAno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjAEAil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:38:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B4B1F;
        Wed,  4 Jan 2023 16:38:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 030D3B81988;
        Thu,  5 Jan 2023 00:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE29C433AE;
        Thu,  5 Jan 2023 00:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879095;
        bh=F6aQ6vvbp0e6OcVSUyTnleHkOEpf+ZhLzaidGHNo6qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRc1BevFOo0jEMuP3psUfI8LN5nfq+xryqEO+ola5YGJyy7JmBqkDxjpE/1bpzyQj
         z3nSL9AKI6u/H69Bbsi3gQcOdx8T7p1wovRH18XFg4Sno1H3wgegFqi3D9FDkknX6x
         QZbVKOSalV0H9d9v7wlTnGjizbf8HoaFSsz+gGJXNNQf9eCHhd5AJBQL2cSEMNxcBy
         BqvNTNjTv9d4IMjw8xXLTRo4BYCl+W6lZVdCwNn37bH0pVLkH3qLtoygxCrn+qZ/CD
         00loVj9LJNoL9C5s6cLimc+bLiPZK8rDPGJITohY3LD5T4HKhvWxl1bzwjPpt4T6Ex
         2r3BVymwwEB6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CD2585C1C89; Wed,  4 Jan 2023 16:38:14 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH rcu 13/27] drivers/hwtracing/stm: Remove "select SRCU"
Date:   Wed,  4 Jan 2023 16:37:59 -0800
Message-Id: <20230105003813.1770367-13-paulmck@kernel.org>
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: <linux-stm32@st-md-mailman.stormreply.com>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 drivers/hwtracing/stm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index aad594fe79cc5..eda6b11d40a1f 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -2,7 +2,6 @@
 config STM
 	tristate "System Trace Module devices"
 	select CONFIGFS_FS
-	select SRCU
 	help
 	  A System Trace Module (STM) is a device exporting data in System
 	  Trace Protocol (STP) format as defined by MIPI STP standards.
-- 
2.31.1.189.g2e36527f23

