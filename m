Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369925E6514
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiIVOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiIVOYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:24:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35E3CF370D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:24:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85A1B1595;
        Thu, 22 Sep 2022 07:24:18 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.1.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C3433F73B;
        Thu, 22 Sep 2022 07:24:09 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/1] arm64: defconfig: Add Coresight as module
Date:   Thu, 22 Sep 2022 15:23:59 +0100
Message-Id: <20220922142400.478815-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still leaving out CONFIG_CORESIGHT_SOURCE_ETM4X because it depends
on the outcome of the investigation into CONFIG_PID_IN_CONTEXTIDR, but
I think we should enable these ones for now and start getting some of
the benefits sooner.

Changes since v1:

 * Remove CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y which shouldn't be
   enabled by default

-----

As suggested by Catalin here's the change to add Coresight to defconfig.

Unfortunately I don't think we should add CONFIG_CORESIGHT_SOURCE_ETM4X
which builds a few files until [1] is merged because of the overhead
of CONFIG_PID_IN_CONTEXTIDR.

[1]: https://lore.kernel.org/lkml/20211021134530.206216-1-leo.yan@linaro.org/T/

applies to arm64/for-next/core (e99db032d186)

James Clark (1):
  arm64: defconfig: Add Coresight as module

 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.28.0

