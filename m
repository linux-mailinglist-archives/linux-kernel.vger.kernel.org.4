Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF081748E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjGETlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjGETlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:41:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F8F1722;
        Wed,  5 Jul 2023 12:40:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2553663f71eso22971a91.3;
        Wed, 05 Jul 2023 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586057; x=1691178057;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pObkK+38n3BsjxC8qgyXxaX1CWlHSEh6zRyjSwENwf8=;
        b=EFyk7sKmdsaEHog1LrxTEJO3pC6Wol+4hWTDuavwR6El39rsDU/yIEUxj1n4ry7aLi
         dh+IYPOxNsf3GT3Pit8pfAZbnmQD7UYpH13DRubLGwr5YG3dtteA1K4sZ+kSBcS1n2mP
         pADYHrnyvgM5C14DV/nTO/ZaJl0HxQ+HRmrqfMO+teBJ9Ethj0q4feSI6v/zDa2eo+ox
         snzPZySgHfK5PPMhKQ7MYHaLMFcv1hbRFQfbwn8ibpWQ6MzaLmlgCRhRUhqObf8v8Eus
         O2HfeGFEIWMSzgwTHkkqz+m+Fei1ZVHmwkhyINB09nvpx5KYPw9WAFs92yoo46MO21fH
         ulUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586057; x=1691178057;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pObkK+38n3BsjxC8qgyXxaX1CWlHSEh6zRyjSwENwf8=;
        b=CL8qH/avlXH5dGnWlERhNKiON3RiftXUQQneQph6K2ODB+S28AvgREUj1ao1vYECNz
         e9CxXCzxa/FGk2kgkRzbYa6PoqRhd9xMKx3FTM8XBVI9cAVYKn4raY9i8tHS4Xfnte+R
         gZtjXEAhBfTZM4UpmXmvTbu6FGlEqENwiafXJNlKkVVQFxswKjk8+envDEyDRNQ5RlyS
         9MBu3FykZtlr7BuZWexVM4IsMfPUP9wXAZcYyf3ciqYOzPUIvWzNYiTZmBm1CHgetIht
         82ZHJL1vKlFMN8JV157GcEPnNhc6nm8oFX/vCds+Lq4b6Dl5JcOtQN7W/kRRGqbD/QBT
         G6/A==
X-Gm-Message-State: ABy/qLabZOAxfUtKpy4g8hsNg2lbO9Pmh6ZtAB+SRkAqycNfUS3j1tU6
        am1Fk3FXiDot+co1hrRutv4=
X-Google-Smtp-Source: APBJJlEbwEg3/RSsJ4VRKfr/j589N7gICgDWfNF2FLF9Ma1g+qL40bsCMOoBc4k6tblFaA+X+uSobg==
X-Received: by 2002:a17:90a:a4b:b0:262:ec64:f941 with SMTP id o69-20020a17090a0a4b00b00262ec64f941mr13182264pjo.5.1688586057013;
        Wed, 05 Jul 2023 12:40:57 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id gb3-20020a17090b060300b00256a4d59bfasm1780042pjb.23.2023.07.05.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:40:56 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:10:47 +0530
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
Subject: [PATCH v2 0/7] Add support for Firefox's gecko profile format
Message-ID: <cover.1688585597.git.anupnewsmail@gmail.com>
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
The format is documented here [1].

I have addressed few comments from the previous version of the patch
like using perf script python interface to process the samples. Also
fixed trailing whitespace and other minor issues.

[1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md

Anup Sharma (7):
  scripts: python: Extact necessary information from process event
  scripts: python: Introduce thread sample processing to create thread
  scripts: python: create threads with schemas
  scripts: python: implement get or create stack function
  scripts: python: implement get or create frame function
  scripts: python: implement add sample function and return finish
  scripts: python: Add trace end processing and JSON output

 .../scripts/python/firefox-gecko-converter.py | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

-- 
2.34.1

