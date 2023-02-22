Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1899569F707
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjBVOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjBVOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3F3B3FC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:47:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDBC2B81230
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD26C4339E;
        Wed, 22 Feb 2023 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077232;
        bh=NHv2T4M6t3YcZt1kUoyxtpuC8v5xebDYXn942sZPC1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMn+Xg+QFyaDpYO0E6BpyUqeqGmDlgBBMKYEMIqvgN/H98zMYGaPN4Uq0rFnoCsBu
         tR6bonMsi9+qmL4BdwaYawwEBsOZObdXewrMkBug1CI7+uriwqKPXTyZzs48vIJdfu
         fAU55CEta+BA6FOXhOW5JOm7VCWcFs526FnrqzrR6OwoLEsd0F4SftzsnequpojC7S
         wDFZHiPuITun5zbc247ZGd8fIqkQrUBhmrxaCb3kMIFRagIeZkTEj464yA7byI5+m0
         9bRHeIJDLkrCyxhO2vZ9AbiBXKw0jESwdJHJxQCJW6GwX4WL3WR9zm8qMx83qoE3yE
         ot9hFyqNsXFZw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6/8] MAINTAINERS: Remove stale email address
Date:   Wed, 22 Feb 2023 15:46:47 +0100
Message-Id: <20230222144649.624380-7-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222144649.624380-1-frederic@kernel.org>
References: <20230222144649.624380-1-frederic@kernel.org>
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

