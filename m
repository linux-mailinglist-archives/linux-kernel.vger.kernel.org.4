Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4956E6A46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjDRQ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:56:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DBF04492
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:56:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8827111FB;
        Tue, 18 Apr 2023 09:57:40 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE4153F587;
        Tue, 18 Apr 2023 09:56:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [GIT PULL] coresight: Updates for v6.4
Date:   Tue, 18 Apr 2023 17:56:44 +0100
Message-Id: <20230418165644.114745-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
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

Hi Greg,

Please find the updates for coresight self hosted tracing targeting v6.4
Kindly pull.

Suzuki

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v6.4

for you to fetch changes up to 18996a113f2567aef3057e300e3193ce2df1684c:

  coresight: etm_pmu: Set the module field (2023-04-14 12:14:09 +0100)

----------------------------------------------------------------
coresight: Updates for v6.4

This is a relatively smaller update for CoreSight tracing subsystem targeting
v6.4, with the following changes:

  - Removing Mathieu Poirier as MAINTAINER for the subsystem, with updates to
    CREDITS for his contributions.
  - Fix CoreSight ETM PMU to set the module field

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

----------------------------------------------------------------
Suzuki K Poulose (2):
      MAINTAINERS: Remove Mathieu Poirier as coresight maintainer
      coresight: etm_pmu: Set the module field

 CREDITS                                          | 5 +++++
 MAINTAINERS                                      | 1 -
 drivers/hwtracing/coresight/coresight-etm-perf.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)
