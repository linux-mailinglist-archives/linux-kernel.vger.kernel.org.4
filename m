Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC45719B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjFAL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjFAL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:59:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1B51134
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 04:59:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1DA01063;
        Thu,  1 Jun 2023 05:00:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6C8AA3F7D8;
        Thu,  1 Jun 2023 04:59:37 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] perf/arm_cspmu: Fixes and cleanups
Date:   Thu,  1 Jun 2023 12:59:28 +0100
Message-Id: <cover.1685619571.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been working on adding support for the 64-bit extension and
devicetree probing[1], which I'm not posting yet since it's still
untested and may need a bit more work. However I think these preparatory
patches stand up well enough on their own so could land sooner.

Thanks,
Robin.

[1] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/cspmu-dev/


Robin Murphy (4):
  perf/arm_cspmu: Fix event attribute type
  ACPI/APMT: Don't register invalid resource
  perf/arm_cspmu: Clean up ACPI dependency
  perf/arm_cspmu: Decouple APMT dependency

 drivers/acpi/arm64/apmt.c          | 10 +++--
 drivers/perf/arm_cspmu/Kconfig     |  3 +-
 drivers/perf/arm_cspmu/arm_cspmu.c | 70 +++++++++++++-----------------
 drivers/perf/arm_cspmu/arm_cspmu.h |  4 +-
 4 files changed, 39 insertions(+), 48 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

