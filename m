Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2977960BE64
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJXXQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJXXPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73569C17
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AAA7B811E4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84939C433C1;
        Mon, 24 Oct 2022 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666624329;
        bh=NR95fQD0AlurKJdHSHQWI8XxPL1W3GaIT4ou4lR6QNw=;
        h=From:To:Cc:Subject:Date:From;
        b=ne3asSo0nI4dvMnGPjosAE+OsWId8FpC8kbfzBopzbdRH2JVLhnrP9eE3vltMf4jz
         7pYNeXGx2MUuiBVWOL59XCbL4Zq1xN6ka11AAax9DGxy87yjkZz/qnYV0LDY83m1Lj
         3CW5ydF/KR7X1IEJf7+MqeVQQIuaFLrDlcHtXFaHSslhz02oOjOGNopjy2/T6OBtgD
         lRrh/cvFpWgDVYG2ND72R6G2pUZ1+oy+IWnvumaR9K5kXCdo8W5B/XEpUBUU0XFKiD
         er/F3Dozfy2xxx514/iwpT3ihAxwxEO2OmvYtcEOPhRmo12U4mmXnX8yV4Uqdd3F/m
         TubuGoBl4Jv6Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] coresight: cti: Remove unused variables in cti_{dis,en}able_hw()
Date:   Mon, 24 Oct 2022 08:12:01 -0700
Message-Id: <20221024151201.2215380-1-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following warnings, as the variables are no longer used.

  drivers/hwtracing/coresight/coresight-cti-core.c:93:17: warning: unused variable 'dev' [-Wunused-variable]
          struct device *dev = &drvdata->csdev->dev;
                        ^
  drivers/hwtracing/coresight/coresight-cti-core.c:154:17: warning: unused variable 'dev' [-Wunused-variable]
          struct device *dev = &drvdata->csdev->dev;
                        ^
  2 warnings generated.

Fixes: 665c157e0204 ("coresight: cti: Fix hang in cti_disable_hw()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/hwtracing/coresight/coresight-cti-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 4a02ae23d3a0..c6e8c6542f24 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -90,7 +90,6 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
 static int cti_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
-	struct device *dev = &drvdata->csdev->dev;
 	unsigned long flags;
 	int rc = 0;
 
@@ -151,7 +150,6 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 static int cti_disable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
-	struct device *dev = &drvdata->csdev->dev;
 	struct coresight_device *csdev = drvdata->csdev;
 
 	spin_lock(&drvdata->spinlock);

base-commit: 665c157e0204176023860b51a46528ba0ba62c33
-- 
2.38.1

