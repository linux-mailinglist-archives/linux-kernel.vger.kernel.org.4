Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29F165E19B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbjAEAdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjAEAcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A494FCF1;
        Wed,  4 Jan 2023 16:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43EFD61890;
        Thu,  5 Jan 2023 00:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A20C43392;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=WftnrUIk94q4iEEufcs/Kz0b0tFiJM4QMAnOsD7FeXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmOQ6cv4wZdsoZZ0XTSaEA79LZsUdGi1FdpuHPubjBnF0KIHacwAouOS3CbMUB8yo
         njNf2wwkXiPt161rrZ4WEKEKSQFCfQVL+BtqfB4LUrsz+FISINGwG01PwyDTjBV6Si
         Eiuo9qWcmj4/9x9DzDiVPwcalHOhXUUs9Ij8jvzmTjyU+j1JYrii/9nWD3/rjHfH6U
         znihNtjftC3svAm8bVqboVfJY/1uLlG16liCPyOXDCrJZZaiNrk9tutC0wFACnRu3x
         PdROi0uZmw99V7yCw72mVeNLNIGjYG0bGzur6a6DcSuHit4DeA90cF32xth9hEa9ET
         3txy22g6wo6JQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 48E065C08E5; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/9] srcu: Fix a misspelling in comment
Date:   Wed,  4 Jan 2023 16:28:47 -0800
Message-Id: <20230105002853.1769401-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
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

From: Pingfan Liu <kernelfans@gmail.com>

s/srcu_gq_seq/srcu_gp_seq/

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index c689a81752c9a..558057b517b74 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -49,7 +49,7 @@ struct srcu_data {
 struct srcu_node {
 	spinlock_t __private lock;
 	unsigned long srcu_have_cbs[4];		/* GP seq for children having CBs, but only */
-						/*  if greater than ->srcu_gq_seq. */
+						/*  if greater than ->srcu_gp_seq. */
 	unsigned long srcu_data_have_cbs[4];	/* Which srcu_data structs have CBs for given GP? */
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	struct srcu_node *srcu_parent;		/* Next up in tree. */
-- 
2.31.1.189.g2e36527f23

