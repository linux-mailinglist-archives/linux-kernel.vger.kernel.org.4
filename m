Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8204574D53F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGJMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGJMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:22:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BF95C7;
        Mon, 10 Jul 2023 05:21:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E658B2B;
        Mon, 10 Jul 2023 05:22:40 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.29.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C59153F67D;
        Mon, 10 Jul 2023 05:21:55 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
Date:   Mon, 10 Jul 2023 13:21:33 +0100
Message-Id: <20230710122138.1450930-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This came out of the discussion here [1]. It seems like we can get some
extra big.LITTLE stuff working pretty easily. The test issues mentioned
in the linked thread are actually fairly unrelated and I've fixed them
in a different set on the list.

After adding it in the first commit, the remaining ones tidy up a
related capability that doesn't do anything any more.

I've added a fixes tag for the commit where
PERF_PMU_CAP_EXTENDED_HW_TYPE was originally added because it probably
should have been added to the Arm PMU at the same time. It doesn't apply
cleanly that far back because another capability was added between then,
but the resolution is trivial.

Thanks
James

[1]: https://lore.kernel.org/linux-perf-users/CAP-5=fVkRc9=ySJ=fG-SQ8oAKmE_1mhHHzSASmGHUsda5Qy92A@mail.gmail.com/T/#t

James Clark (4):
  arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
  perf/x86: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
  arm_pmu: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
  perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability

 arch/x86/events/core.c     |  1 -
 drivers/perf/arm_pmu.c     | 10 ++++++----
 include/linux/perf_event.h |  2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.34.1

