Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78E69208D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjBJOK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjBJOJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:09:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A0E74064
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F7B361DD2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB131C43445;
        Fri, 10 Feb 2023 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676038179;
        bh=gtKeflSOf/kRVKW9lvZG7UlWcNwX9gYbrJOAj1/IZRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQXYyBgD/vKrwdGKQ0x0+iUltbLAg5bsSTaW72Oos3ne4vHjakkeJNoKHMoLrsMR3
         JO9WGdZmWyo3n8tGhl8kSk3vEDGgaRrKzhWpde8OfJohw1Aoi0VXqQ5I+wng3XwWDS
         pG5AkMRXEoq2JiK9/GO1bRrXGazyvq00egHl69bOPtoeLuYtliEPEaJWGqDN0SBs6X
         23uZRwjunYcxr8Ekf0BVaTjGrdX8kXsza51ASUc0//fOGkULnR5nz/6URabnxDwmRo
         ORj0p4IT/A3Ah95EB8iMKgA9wwHy6wA7YssnD/TeqXGDtMdEGK9sLu8UY3IFANdA0F
         OWSNLhZO7yqVA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wei Li <liwei391@huawei.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6/6] MAINTAINERS: Remove stale email address
Date:   Fri, 10 Feb 2023 15:09:17 +0100
Message-Id: <20230210140917.279062-7-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210140917.279062-1-frederic@kernel.org>
References: <20230210140917.279062-1-frederic@kernel.org>
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

Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Peter Zijlstra <peterz@infradead.org>
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

