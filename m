Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B669CB39
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjBTMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBTMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:41:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DC81C7D3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50AC60E33
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F07FC4339B;
        Mon, 20 Feb 2023 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676896913;
        bh=NHv2T4M6t3YcZt1kUoyxtpuC8v5xebDYXn942sZPC1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GlbCimPPNQGcTfH8ASY5D50pKCtOsefO9GSslEo243k1D0GgcOHNUeGfnSV4q/05g
         ZcPdJxzg1TykmKZzVrzfMlhIe4Y3S0/1gaYvf8pryW2Xl5iqTQs4SPVB+YBDPGWbyf
         aTgF+UwXTikJIuFXqmErAnV27p/Bsi0tRROhJUXrLqRw1medHSv5hg4wMbp6gfJnZ1
         H7pVwOMu0GEDJ0N27cIX9P9s43SXMxsTgePsT0ewh7r5poJEO+w1l6FDrZPQgvcqb4
         iqGonbZBDu2ogpOHsdkvc4T06uC2101t4DXpLt19lV69a5sOxF7kbVhPChjcJI33We
         bQ26nxgy6Vm+A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6/7] MAINTAINERS: Remove stale email address
Date:   Mon, 20 Feb 2023 13:41:28 +0100
Message-Id: <20230220124129.519477-7-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220124129.519477-1-frederic@kernel.org>
References: <20230220124129.519477-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb1471cb5ed3..300ca61fa0bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14794,7 +14794,7 @@ F:	include/uapi/linux/nitro_enclaves.h
 F:	samples/nitro_enclaves/
 
 NOHZ, DYNTICKS SUPPORT
-M:	Frederic Weisbecker <fweisbec@gmail.com>
+M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.34.1

