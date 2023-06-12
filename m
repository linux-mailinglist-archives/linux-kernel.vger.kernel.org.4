Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05E972CC3A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjFLRQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjFLRQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:16:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A264F10F4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:16:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6712E1FB;
        Mon, 12 Jun 2023 10:17:25 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 519EE3F5A1;
        Mon, 12 Jun 2023 10:16:39 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, ilkka@os.amperecomputing.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf/arm-cmn: Identifier support
Date:   Mon, 12 Jun 2023 18:16:31 +0100
Message-Id: <cover.1686588640.git.robin.murphy@arm.com>
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

Following on from the disussion on Jing's proposal[1], I've had
confirmation that we do actually have a reliable hardware identifier,
so this mini-series does a bit of refactoring to wire that up and then
expose a sysfs identifier based on it.

Thanks,
Robin.

[1] https://lore.kernel.org/r/1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com/


Robin Murphy (2):
  perf/arm-cmn: Revamp model detection
  perf/arm-cmn: Add sysfs identifier

 drivers/perf/arm-cmn.c | 165 +++++++++++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 56 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

