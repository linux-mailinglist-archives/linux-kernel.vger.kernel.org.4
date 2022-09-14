Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22465B8F80
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 22:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiINUJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiINUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 16:09:21 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDCC844DE;
        Wed, 14 Sep 2022 13:09:15 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11e9a7135easo44085491fac.6;
        Wed, 14 Sep 2022 13:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=vWFLS0gZLXO9OIHvqTdorCpbMwFElLZDmi2Y+4PHdxw=;
        b=1rDbT5SBF+EnTjfe9vD/3Jk1CncEtPL+KZ7dczd41rNwoDFZTHgJvUQXBN8FdqeLIa
         JZ/0n1GqD1A2VTTukB+yCcF4Bh/53OU6kxhelIWEpxDxnuuxeCnLiKEi9NKDu6WT0plG
         l9qtdswQxKtetJQ0b+qATtOxRA6AOr6H92bvNv+JOUS32uSv3ySmB+Nwo0O5ENdonFO1
         h3NxvDxR9N3owuE+rZI6hJuz4ZbXBsd4LM2NDxuFsevbMw2lDrauCUBulqh30rj4IH3k
         K2Wtd/CInOh9ozhD8VuXmRf3s+l4GKj3F2kzM9WHu3OP0LtkqzerNwvXuKRbGzNYMR9c
         wwAQ==
X-Gm-Message-State: ACgBeo270l1sp5CHyzal9OZUAkREgCU7QfmCnC5O/q4kUZtmtYOzdxMa
        uG5yeZH5aKDdIG/xKimlYw==
X-Google-Smtp-Source: AA6agR6O4yTb/UaVRq8uwHX69CkO0wLmto8mg2j5AFejv1dyb9y0K9mUIE0ztP5eQDRoDs8Yx19cuw==
X-Received: by 2002:a05:6870:5810:b0:127:a331:1e76 with SMTP id r16-20020a056870581000b00127a3311e76mr3455406oap.292.1663186154401;
        Wed, 14 Sep 2022 13:09:14 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id r22-20020a544896000000b0033a37114eb0sm6745050oic.19.2022.09.14.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 13:09:14 -0700 (PDT)
Subject: [PATCH v3 0/3] perf tool: 'config3' attribute support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAME0ImMC/w3LMQ6DMAwAwK8gz1gCAyrpb5xgSqQ0QTawIP5OxhvuBhONYvBtblC5osWSK4a2gb
 Bx/gnGpRqoI+pcPyLrH3fRFY9SEtouPRJehIH9Z3ZhWiY3Q92eTdAr57DVn8+UnucFAC114G4AAAA=
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Sep 2022 15:08:33 -0500
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a fix to allow unknown 'configN' attrs and then extends 
perf tool to support a new config3 attr.

The config3 support is RFC for context as the kernel side support[1] is 
not yet accepted.

[1] https://lore.kernel.org/all/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (3):
      perf: Skip and warn on unknown format 'configN' attrs
      perf tools: Sync perf_event_attr::config3 addition
      perf: Add support for perf_event_attr::config3

 include/uapi/linux/perf_event.h       |  3 +++
 tools/include/uapi/linux/perf_event.h |  3 +++
 tools/perf/util/parse-events.c        |  9 +++++++++
 tools/perf/util/parse-events.h        |  1 +
 tools/perf/util/parse-events.l        |  1 +
 tools/perf/util/pmu.c                 | 16 ++++++++++++++++
 tools/perf/util/pmu.h                 |  3 +++
 tools/perf/util/pmu.l                 |  2 --
 tools/perf/util/pmu.y                 | 15 ++++-----------
 9 files changed, 40 insertions(+), 13 deletions(-)
---
base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
change-id: 20220914-arm-perf-tool-spe1-2-v2-cab789c5d598

Best regards,
-- 
Rob Herring <robh@kernel.org>
