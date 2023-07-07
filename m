Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCE874B523
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjGGQiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:38:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A01941FEF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:38:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CC8ED75;
        Fri,  7 Jul 2023 09:39:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AE4D3F740;
        Fri,  7 Jul 2023 09:38:18 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com,
        blakgeof@amazon.com
Subject: [PATCH 0/3] perf: Arm CMN updates
Date:   Fri,  7 Jul 2023 17:38:10 +0100
Message-Id: <cover.1688746690.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's another CMN update which unfortunately due to circumstances
didn't manage to be ready in time for 6.5. I realise it's a bit early
now, but I'm about to be offline for 4 weeks so hey. For anyone playing
along at home, the HN-S is not documented not in the CMN-700 TRM, but
in its own special supplement[1].

Thanks,
Robin.

[1] https://developer.arm.com/documentation/108055/0301/?lang=en

Robin Murphy (3):
  perf/arm-cmn: Remove spurious event aliases
  perf/arm-cmn: Refactor HN-F event selector macros
  perf/arm-cmn: Add CMN-700 r3 support

 drivers/perf/arm-cmn.c | 163 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 138 insertions(+), 25 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

