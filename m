Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4055F3B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJDCSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJDCRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:17:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4CD3DF1A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:16:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e8-20020a5b0cc8000000b006bca0fa3ab6so11843639ybr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=1Fr2K5+nGwAaJU7O66cM9z/u4Ic+WMsu462XEdN8mXE=;
        b=eDuZOFLXZOAhkECusE5OKfNo+zlrq1YLat4R0rqtq9h+aJDtLYv7z/NCYzE0BEeocb
         QSkoih/iMjTqIY+XlZdCQnfbsXmEcG4kiz68Dt/Cq3qN43RvMByvx9u5nCyaseXiMhGL
         wva1iD2Go+PLfFrov5/Fx8AiMTNkl0VjV2NXMcAvQCOrGHrfuHhSI95xZeE31+4vYLEr
         rwJee+Ifi2PHRQKHclnAs3JyENIjUGfQXplVu+CQQOJbe5U4vrElK17aaqUVv/G6IwXz
         rU4/LEP6zgoGQx5PEbTisLULcJRFUfMVZHdPW1xcPD+ARCElroTvP83ETs6tz6wR3Rw6
         x1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=1Fr2K5+nGwAaJU7O66cM9z/u4Ic+WMsu462XEdN8mXE=;
        b=tEXDXEMqc31km8o04fskH6IVn2vde4yJl9PPAYtcERVkn32/v2Ur6lZfmP0mbDNXOc
         cNPFQiry7J2RWIFHHtSfFJ6De2ae0bg4YjtD/Gm+ARGE7+PhJM/K7sogd8ML1XbJVcEV
         skDIcnF93w2wQz3LwPzdNRM2byDdZWQqU3lTdW2vq91fTOrALixNaJPfhn0hhN1Mm2tD
         o4bl2UB61gY8tvuF1uBiIcpQzW75Ka9r+l+t4oQmVSsf0dc4aCxuY+PVdXXgjrIJwrPF
         PK+r3hOVC3a1y20oEUXuBZthX7LlGPYCJhUKUmqySrymFbghGz/k8hS0EDNXIUu+WFNK
         KJFw==
X-Gm-Message-State: ACrzQf0riCimQOuuzimkC/YVrjPbSxZ1PY6PCHj1Wfe2OenrWyg2l11l
        suRQ63cnjePPzzYKpIUn5QUREH0HzQmo
X-Google-Smtp-Source: AMsMyM69JWLeqb8fvC27sn/8K64yRaH1g/N4YiGgljL/mdexMvfSnxvcZeR8/uTHfWBdTk7Lp/wcXbLH6HX8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a86d:8afd:70b1:9b0c])
 (user=irogers job=sendgmr) by 2002:a25:f304:0:b0:6be:e3c:9724 with SMTP id
 c4-20020a25f304000000b006be0e3c9724mr3475463ybs.145.1664849805040; Mon, 03
 Oct 2022 19:16:45 -0700 (PDT)
Date:   Mon,  3 Oct 2022 19:15:59 -0700
In-Reply-To: <20221004021612.325521-1-irogers@google.com>
Message-Id: <20221004021612.325521-11-irogers@google.com>
Mime-Version: 1.0
References: <20221004021612.325521-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Subject: [PATCH v3 10/23] perf vendor events: Update elkhartlake cpuids
From:   Ian Rogers <irogers@google.com>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        samantha.alt@intel.com, ahmad.yasin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cpuid that was added to https://download.01.org/perfmon/mapfile.csv

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index bc873a1e84e1..6c8188404db8 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -5,7 +5,7 @@ GenuineIntel-6-(3D|47),v26,broadwell,core
 GenuineIntel-6-56,v23,broadwellde,core
 GenuineIntel-6-4F,v19,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.16,cascadelakex,core
-GenuineIntel-6-96,v1.03,elkhartlake,core
+GenuineIntel-6-9[6C],v1.03,elkhartlake,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-(3C|45|46),v31,haswell,core
-- 
2.38.0.rc1.362.ged0d419d3c-goog

