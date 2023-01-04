Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F83D65DC09
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjADSXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjADSXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:23:17 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDBC19009
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:23:16 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x28-20020a056a000bdc00b005826732edb6so4488417pfu.22
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/6gSWZH/V4L9BXpFay4ZvL5sJpJpduz8JVO3laT9niY=;
        b=HVNO+DZbPX858fjsSZfcBnQtKwvK+sazRDKA3G8FPcsF/NcHqJmGDgsjqzoAkbfXCT
         BMsjZAWKxMAZiXB8r4f3xoWNCnMDaDo7mimAG+Mua3zBEk6NZecZ/S9ONhaGP1ltwUTG
         hpi+VrHfMzfHjd8PKvbVZJJBwgLnmWHyXVbbqWj50LoF1aPDB3yuhjhtGZ2trdbmHn30
         qvcGQFl98YyxU0gaDQ3YlZNSFg9UpJeGNgBZkFUq0Ki37LMJBLNmL2hG01zVa7mUzucX
         jn6f9dOUZ8EpZRn9V6hOv1ylol0BR4uoI3IK2xGQiIuYS6BAmbAfqleGdsJibYUGzI0C
         a0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6gSWZH/V4L9BXpFay4ZvL5sJpJpduz8JVO3laT9niY=;
        b=yFvSUMKTsokkpgSjLwCM1sPuhLvHUwNaYY7cKfexsAhbSXx1P1x2fdvXi8df6mp/BK
         +1/8wHp8JJiXUJuV88t2fe21834zPTL8zP5/9LbjalaluxNZBLuZpvDpdEQsNLhSS5UB
         MJYi4JP5waeT90HezLfDgnAfvfWBc4Ylhbk5AQYQ4GS8QnOawWt7Ep9/e1f+ABfvJk0u
         fqVToMDZIFRnIU3Hby0+kwtpNVfRoK6Ia80cHfRD6HkqCwRFnIi3Ow76Z8IKRICoTe61
         0OO91k6Z3iuJ/IySGKPIISG6T4kidSMXrXdWcY3vEQ4mdwzmso64Yf/WCSg1QJBkZOjv
         P9ag==
X-Gm-Message-State: AFqh2kp4lA5kQZkq7rxZ6aCzkULUtzsezNL598O2Ca+PV0+8TDvEpqPe
        pHtOejMq7owzfFFZuKdWGnqXnI72xoiT1Mw=
X-Google-Smtp-Source: AMrXdXuvros/MWUdVxz/GhSEPlyh4EujXXdYhnVNNFaI8S/EulfAVHXaNA+UWO7MqB3yl07M5DDVMfcYy7Dg/Nk=
X-Received: from jesussanp.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5f10])
 (user=jesussanp job=sendgmr) by 2002:a05:6a00:d4e:b0:581:a3e3:13fc with SMTP
 id n14-20020a056a000d4e00b00581a3e313fcmr1603877pfv.42.1672856595837; Wed, 04
 Jan 2023 10:23:15 -0800 (PST)
Date:   Wed,  4 Jan 2023 10:23:13 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104182313.3164736-1-jesussanp@google.com>
Subject: [PATCH] perf: Add missing sys/types.h include
From:   Jesus Sanchez-Palencia <jesussanp@google.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>
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

Not all libc implementations define ssize_t as part of stdio.h like
glibc does since the standard only requires this type to be defined by
unistd.h and sys/types.h. For this reason the perf build is currently
broken for toolchains based on uClibc, for instance.

Include sys/types.h explicitly to fix that. This is a follow up to
commit 378ef0f5d9d7 ("perf build: Use libtraceevent from the system").

Signed-off-by: Jesus Sanchez-Palencia <jesussanp@google.com>
---
 tools/perf/util/trace-event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index add6c5d9531c..9b3cd79cca12 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stdio.h>
+#include <sys/types.h>
 #include <linux/types.h>
 
 struct evlist;
-- 
2.39.0.314.g84b9a713c41-goog

