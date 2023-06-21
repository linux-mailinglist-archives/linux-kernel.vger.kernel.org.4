Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F03739025
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjFUTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFUTfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:35:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7473610F2;
        Wed, 21 Jun 2023 12:35:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668709767b1so2954305b3a.2;
        Wed, 21 Jun 2023 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376134; x=1689968134;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vUyZ7pvZFvTax/yPxI3TKMDV88xCJbdm/hiSAJgg4Q=;
        b=fLWnNmx0Qan8RyeQSDp5zcYGGw8zVNhJKZ5TSpDffkOiCJeoz5sfZ4T4rrWZQhqZlL
         QmgLFhJitHhAl51lY2YVycXWXz0WO/hLtBhUh+DRyEHOP+8xb1ubT7/A3Uh6Yzui52Kr
         bqZ8gPL6DP2pt7ioZ1z1pS2N+RbP/PdL6C52jnQGMHlp477KYFp0wroDOQaQTK2Rly/6
         k58sXwoMJzMyZpHmYg6g5BkUV1fBB2BMaWJWhuYRm1BJ2EmR+XJ7ux5vG6pKyHN2ExEG
         Vh4b6EoF0/wDZJwi3HF/fsIioSSNyNXcgLerj1Z5kEdF5iiHlmMhhdGXq/O2NchdWmy9
         hMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376134; x=1689968134;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8vUyZ7pvZFvTax/yPxI3TKMDV88xCJbdm/hiSAJgg4Q=;
        b=a5czkz+4NUkO8ELe073Mt0ikFFWPfkCCdlZOQfSOphkthgs8Ljg0SUx7X9/4VXo66Z
         ypvYC7gC1vZB2GfrWZcj1IG/vaWgr7j2rowUL8QsPB0PSBI+Y86Ps1EbyTqJtf6wWKAm
         7YokFfhhewj3/2MhngN2I1KQyzu0D0Htx22znB0GL3O1/KL+xQoaTZ87odcC8hlnkOW6
         jyiplJ1ndzsIumXXRCMy4mxxGZUoXiA80L4RQlyKB8nImCkd0Ni+SIJQjRg2HC+E6lyY
         XIKxgUVj8DczBMozijDtCKaHDxAYeLJz/4Jks+i5P1T/+I1ySczCrXzG21jVmTCCc4qR
         fX4w==
X-Gm-Message-State: AC+VfDwpcJKsnoY1LaMviNvUcCwCf3Ig6AP2+xyFqQOGJksEicFLGRDh
        gy7N5jdLqZa1hS22PHzedyw=
X-Google-Smtp-Source: ACHHUZ4vTCPCH0BMswHA5OsFi5Lf1cOYHsNeV8rtBxn0aEe0bfHaosv11xHdB9A5cJZiDeg1TZqo+Q==
X-Received: by 2002:a05:6a00:1483:b0:65d:d5cd:6f17 with SMTP id v3-20020a056a00148300b0065dd5cd6f17mr18077523pfu.24.1687376133736;
        Wed, 21 Jun 2023 12:35:33 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id j25-20020a62e919000000b00662610cf7a8sm3333028pfh.172.2023.06.21.12.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:35:33 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:05:26 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Add support for Firefox's gecko profile format
Message-ID: <cover.1687375189.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Firefox's gecko profile format.
The format is documented here [1]

The series adds a new python script that can be used to convert the 
perf script to gecko profile format. To use this script, use the
following commands: 

perf record 
perf script -F +pid > perf_data.txt
python3 firefox-gecko-converter.py > gecko_profile.json

Also dont forget to change the chown of the output file to the user[2].

[1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
[2] https://bugzilla.mozilla.org/show_bug.cgi?id=1823421

Anup Sharma (9):
  scripts: python: Add check for correct perf script format
  scripts: python: implement add sample function and return it
  scripts: python: Introduce thread sample processing in
    convertPerfScriptProfile
  scripts: python: Implement parsing of input data in
    convertPerfScriptProfile
  scripts: python: implement function for thread creation
  scripts: python: implement get or create stack function
  scripts: python: implement get or create frame function
  scripts: python: Finalize convertPerfScriptProfile and return profile
    data
  scripts: python: Add temporary main function for testing purposes

 .../scripts/python/firefox-gecko-converter.py | 249 ++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

-- 
2.34.1

