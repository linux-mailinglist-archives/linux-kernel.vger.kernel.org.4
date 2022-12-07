Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87B5645A06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLGMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiLGMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:41:39 -0500
X-Greylist: delayed 107896 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 04:41:37 PST
Received: from mx405.baidu.com (mx414.baidu.com [124.64.201.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D173929C9D;
        Wed,  7 Dec 2022 04:41:37 -0800 (PST)
Received: from bjhw-sys-rpm015653cc5.bjhw.baidu.com (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by mx405.baidu.com (Postfix) with ESMTP id 628521C100053;
        Wed,  7 Dec 2022 20:41:35 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by bjhw-sys-rpm015653cc5.bjhw.baidu.com (Postfix) with ESMTP id 5AA83D9933;
        Wed,  7 Dec 2022 20:41:35 +0800 (CST)
From:   lirongqing@baidu.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, peterz@infradead.org,
        akpm@linux-foundation.org, tony.luck@intel.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/2][v2] cpuidle-haltpoll: Build as module by default
Date:   Wed,  7 Dec 2022 20:41:35 +0800
Message-Id: <1670416895-50172-2-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
References: <1670416895-50172-1-git-send-email-lirongqing@baidu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

Allow user to unload it in running

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpuidle/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index ff71dd6..43ddb84 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -74,7 +74,7 @@ endmenu
 config HALTPOLL_CPUIDLE
 	tristate "Halt poll cpuidle driver"
 	depends on X86 && KVM_GUEST
-	default y
+	default m
 	help
 	 This option enables halt poll cpuidle driver, which allows to poll
 	 before halting in the guest (more efficient than polling in the
-- 
2.9.4

