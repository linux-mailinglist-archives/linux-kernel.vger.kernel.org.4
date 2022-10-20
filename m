Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525ED606A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJTVta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJTVt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:49:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DF04187
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:49:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5E91042;
        Thu, 20 Oct 2022 14:49:25 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 29FEA3F7D8;
        Thu, 20 Oct 2022 14:49:18 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, james.clark@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [GIT PULL v2] coresight: Fixes for v6.1
Date:   Thu, 20 Oct 2022 22:48:32 +0100
Message-Id: <20221020214832.850389-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find a couple of fixes for coresight subsystem. I have addressed
your comments from the previous post :
  - Removed 2 patches that were not really critical for v6.1 
  - Fixes tag is added
  - Fixed git repo URL.

Please pull.

Thanks
Suzuki

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git  tags/coresight-fixes-v6.1-1

for you to fetch changes up to 665c157e0204176023860b51a46528ba0ba62c33:

  coresight: cti: Fix hang in cti_disable_hw() (2022-10-20 22:34:23 +0100)

----------------------------------------------------------------
coresight: Fixes for v6.1

Fixes for coresight drivers for v6.1

  - Fix possible deadlock CTI mutexes (LOCKDEP)
  - Fix hang in CTI with runtime power management

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

----------------------------------------------------------------
James Clark (1):
      coresight: cti: Fix hang in cti_disable_hw()

Sudeep Holla (1):
      coresight: Fix possible deadlock with lock dependency

 drivers/hwtracing/coresight/coresight-core.c     | 7 ++++---
 drivers/hwtracing/coresight/coresight-cti-core.c | 8 +++-----
 2 files changed, 7 insertions(+), 8 deletions(-)
