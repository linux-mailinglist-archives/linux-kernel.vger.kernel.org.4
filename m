Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2D5E6517
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiIVOYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiIVOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:24:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF875EBBDF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:24:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E21716F8;
        Thu, 22 Sep 2022 07:24:21 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.1.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D00A3F73B;
        Thu, 22 Sep 2022 07:24:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 1/1] arm64: defconfig: Add Coresight as module
Date:   Thu, 22 Sep 2022 15:24:00 +0100
Message-Id: <20220922142400.478815-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220922142400.478815-1-james.clark@arm.com>
References: <20220922142400.478815-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Coresight to defconfig so that build errors are caught.
CONFIG_CORESIGHT_SOURCE_ETM4X is excluded because it depends on
CONFIG_PID_IN_CONTEXTIDR which has a performance cost.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ef3467092ded..d699933cab45 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1340,4 +1340,12 @@ CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
+CONFIG_CORESIGHT=m
+CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
+CONFIG_CORESIGHT_CATU=m
+CONFIG_CORESIGHT_SINK_TPIU=m
+CONFIG_CORESIGHT_SINK_ETBV10=m
+CONFIG_CORESIGHT_STM=m
+CONFIG_CORESIGHT_CPU_DEBUG=m
+CONFIG_CORESIGHT_CTI=m
 CONFIG_MEMTEST=y
-- 
2.28.0

