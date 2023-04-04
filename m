Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872AE6D5EB9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 13:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjDDLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjDDLLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 07:11:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1CB90
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 04:11:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B524C14;
        Tue,  4 Apr 2023 04:12:19 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7E5AB3F6C4;
        Tue,  4 Apr 2023 04:11:33 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, james.clark@arm.com,
        anshuman.khandual@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        gregkh@linuxfoundation.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] MAINTAINERS: Remove Mathieu Poirier as coresight maintainer
Date:   Tue,  4 Apr 2023 12:11:17 +0100
Message-Id: <20230404111117.569795-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Poirier is no longer involved in maintainig the CoreSight self-hosted
tracing subsystem.

Mathieu, Thank you very much creating and maintaing the subsystem all these
years !

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 CREDITS     | 5 +++++
 MAINTAINERS | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 847059166a15..216e86f56dd9 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3459,6 +3459,11 @@ D: several improvements to system programs
 S: Oldenburg
 S: Germany
 
+N: Mathieu Poirier
+E: mathieu.poirier@linaro.org
+D: CoreSight kernel subsystem, Maintainer 2014-2022
+D: Perf tool support for CoreSight
+
 N: Robert Schwebel
 E: robert@schwebel.de
 W: https://www.schwebel.de
diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..6c971e95a6fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2091,7 +2091,6 @@ F:	arch/arm/boot/dts/cx92755*
 N:	digicolor
 
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
-M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
 R:	Leo Yan <leo.yan@linaro.org>
-- 
2.34.1

