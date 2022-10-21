Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DCD607F99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJUUSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJUUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:18:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5A629F114;
        Fri, 21 Oct 2022 13:18:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E43AB82C93;
        Fri, 21 Oct 2022 20:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAECEC433D6;
        Fri, 21 Oct 2022 20:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666383522;
        bh=9N8hC43F53uZw3GUeYPmUFhh7KM4AYDCYlgMmHNSMks=;
        h=From:To:Cc:Subject:Date:From;
        b=pAPQH6Ma/i6sfdSdfOn98fL1TD3501f1E5jKOHMJY6M75NyN2XLX5E+aJGAtOp0Xt
         kG/lhzDu+uLlL10cTUepsLxvfESaf9vvZM6FQfVBPwK/NkrmRNmAugI26n2ElhgmSx
         UFWwbmVuF+vfgKwGiL3JvuqPQAKQagW+qMC3ArklDhvYdFBOMP09i+QnYpOGsTFdWH
         hDkSHFxJUaMjZV82bt1087addmv8lNkUAo+pOHQ77jLCHRP/SkGMZpoAIKRqPnNici
         TWxKYQJ+YX4yO8YoO9pUnjP+nUVbaoAlyTTSP9ke4jCu7teFZvJHL+Kkr27Zl/0vC4
         VSQIPc7BEag/A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] alpha: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions
Date:   Fri, 21 Oct 2022 15:18:38 -0500
Message-Id: <20221021201838.306176-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---

[Sorry for the noise; I sent this a few minutes ago, but it bounced from
all the individual recipients because of DMARC issues]

Previously posted v1 4/15/2022 at
  https://lore.kernel.org/all/20220415190817.842864-1-helgaas@kernel.org/
and reposted v1 10/13/2022 at
  https://lore.kernel.org/all/20221014001911.3342485-1-helgaas@kernel.org/

Changes from v1 to v2:
  - Drop the ia64 patch because Andrew applied it
      https://lore.kernel.org/all/20221021045245.99636C433C1@smtp.kernel.org/

  - Split sh and alpha to separate series

 arch/alpha/include/asm/io.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 1c3605d874e9..7aeaf7c30a6f 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -14,10 +14,6 @@
    the implementation we have here matches that interface.  */
 #include <asm-generic/iomap.h>
 
-/* We don't use IO slowdowns on the Alpha, but.. */
-#define __SLOW_DOWN_IO	do { } while (0)
-#define SLOW_DOWN_IO	do { } while (0)
-
 /*
  * Virtual -> physical identity mapping starts at this offset
  */
-- 
2.25.1

