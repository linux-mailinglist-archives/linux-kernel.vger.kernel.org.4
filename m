Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0546870B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjBAVub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBAVu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:50:28 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE91CA34;
        Wed,  1 Feb 2023 13:50:25 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id BA9EF240006;
        Wed,  1 Feb 2023 21:50:20 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Carsten Haitzler <carsten.haitzler@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 0/2] Script style improvements in lib/coresight.sh
Date:   Wed,  1 Feb 2023 22:49:43 +0100
Message-Id: <20230201214945.127474-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 2 patches improve the efficiency and quality of the
lib/coresight.sh script.

The first one uses grep's `-c` parameter to count the results instead of
piping it to `wc -l`.
The second one replaces the use of backticks (`...`) with $(...) as the
former has several potential issues while the latter does not.

Diederik de Haas (2):
  perf test: Replace 'grep | wc -l' with 'grep -c'
  perf test: Replace legacy `...` with $(...)

 tools/perf/tests/shell/lib/coresight.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.39.1

