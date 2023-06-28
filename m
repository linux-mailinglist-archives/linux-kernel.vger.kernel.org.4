Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD2740F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjF1Kxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:53:52 -0400
Received: from foss.arm.com ([217.140.110.172]:53582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231189AbjF1KxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:53:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BADAC14;
        Wed, 28 Jun 2023 03:53:58 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.27.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BAFA3F663;
        Wed, 28 Jun 2023 03:53:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        masahiroy@kernel.org, leo.yan@linaro.org, broonie@kernel.org,
        Aishwarya.TCV@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1]  perf tools: Add a place to put kernel config fragments for test runs
Date:   Wed, 28 Jun 2023 11:53:01 +0100
Message-Id: <20230628105303.4053478-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since RFC:

 * Changed arch filename convention to use the ARCH= build time values
   instead of uname

It seems like there were no objections on the RFC, apart from maybe
changing the perf tests to run as a kself test. But that's probably not
going to happen for a while, if ever, and these fragments can always
be moved in that case.

James Clark (1):
  perf tools: Add a place to put kernel config fragments for test runs

 tools/perf/tests/config-fragments/README |  7 +++++++
 tools/perf/tests/config-fragments/arm64  |  1 +
 tools/perf/tests/config-fragments/config | 11 +++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 tools/perf/tests/config-fragments/README
 create mode 100644 tools/perf/tests/config-fragments/arm64
 create mode 100644 tools/perf/tests/config-fragments/config


base-commit: ad5f604e186ac08d12c401e34ea96c09c38ddbc5
-- 
2.34.1

