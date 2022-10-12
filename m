Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA75F5FC33E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJLJrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJLJrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:47:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D0EEB3B22;
        Wed, 12 Oct 2022 02:47:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8907D15A1;
        Wed, 12 Oct 2022 02:47:08 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0D7BC3F792;
        Wed, 12 Oct 2022 02:46:58 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 0/1] perf test: Fix attr tests for PERF_FORMAT_LOST
Date:   Wed, 12 Oct 2022 10:46:31 +0100
Message-Id: <20221012094633.21669-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

 * Add rather than replace the new value so that the test still passes
   on older kernels

James Clark (1):
  perf test: Fix attr tests for PERF_FORMAT_LOST

 tools/perf/tests/attr/base-record                | 2 +-
 tools/perf/tests/attr/system-wide-dummy          | 2 +-
 tools/perf/tests/attr/test-record-group          | 4 ++--
 tools/perf/tests/attr/test-record-group-sampling | 6 +++---
 tools/perf/tests/attr/test-record-group1         | 4 ++--
 tools/perf/tests/attr/test-record-group2         | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.28.0

