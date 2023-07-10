Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB7B74E1E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGJXIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjGJXIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:08:17 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188B810D;
        Mon, 10 Jul 2023 16:08:16 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a04e5baffcso4141706b6e.3;
        Mon, 10 Jul 2023 16:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689030495; x=1691622495;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vf0fvL5fN8MurExCXhEJeP/D8yL9Qpt+oFEEwg0wzcM=;
        b=DE8z1iTACA/5CZQsSDa2U9wf8y5753+kcmqUFYv1C/tKA4tsyeyTM2I4pzbUZslO1d
         DiwXz0ifOheEGcxRI/tI1VwdA73HjKbKz7Uft3YbR6XxKPpsl2n/51GiLVPF02cdPlnp
         uvGa1DjUaaNrNJxl1whbtkA/GRuWPIgreiT2fNiZgQaq/jOK7TqnDwV+hAB7FIF5fXXT
         n5V/sdd1R0T4gYgLpatLsm3fXTjv2V3o0gABVK5Z3EudmrnMhamb6UWBlOJ+IzlJWCr5
         EDgCLVA2JJz3zdlM/I3HqpORezGSATttod+o9oLCYRUHsyA/A5jyPVGI8zjokx2NbHfp
         dqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030495; x=1691622495;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf0fvL5fN8MurExCXhEJeP/D8yL9Qpt+oFEEwg0wzcM=;
        b=bzDHwAYsKBtGkt2WyvNFmcfkxteknnfUQ8baqOHWsuVX8NhJ0kf1csCDO92HS1ZMVD
         8ldLB4vQvLcYL8ecJ28USf/jF+NL7z/1iePEl/5SGzYP4wGJE8Di5rN1LIF4fmbC8wE/
         l6sLbQ/082DZK8gdHOzqYN+YY+h3TWWL5ZGWdsT/JxxiCtHrw4ljjuuTFVzPA4MTnQjj
         HQv2QP/dgmxl9owrhazAhM/yXGLo8JV8bcZyvWke9AQcd9bFto/wkcHaWsa733y3WJus
         3CNqkPxtZA/UBBZk1MPs2KAsXfdk7JfvN6C0psWfRettcZ72AovG4IEJiCd38cKROTdC
         pLmw==
X-Gm-Message-State: ABy/qLbqOkvahQtC9M/3XQLNd16B2Kk4ReZwuG7KfgNIxZyNGyhezefJ
        U60BPOkczisrPMi54YWO/84=
X-Google-Smtp-Source: APBJJlH7hkB77Bscn3KRTkzaHfzCY2i6sf1I/xj+9kMS2tprITbkvtjLmKTBb5MsW9DZ13yjKFVCmA==
X-Received: by 2002:a05:6358:2813:b0:132:d42f:8e19 with SMTP id k19-20020a056358281300b00132d42f8e19mr9637245rwb.31.1689030495299;
        Mon, 10 Jul 2023 16:08:15 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id r27-20020a638f5b000000b005307501cfe4sm232292pgn.44.2023.07.10.16.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:08:14 -0700 (PDT)
Date:   Tue, 11 Jul 2023 04:38:06 +0530
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
Subject: [PATCH v3 0/6] Add support for Firefox's gecko profile format
Message-ID: <cover.1689024635.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Firefox's gecko profile format.
The format is documented here [1].

I have incorporated several changes based on feedback from the
previous version of the patch. However, there are still a few
remaining comments that I am currently addressing.

Additionally, I am still in the process of learning how to send
patches in a series, so there may be some shortcomings in this
particular series as well.

changes from v2:
- renamed mod to func
- removed unnessecary imports print_function
- removed shebang python env declaration
- changed _createtread to _createThread
- Commits in better order.

[1] https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md

Anup Sharma (6):
  scripts: python: Add initial script file with imports.
  scripts: python: Extact necessary information from process event
  scripts: python: thread sample processing to create thread with
    schemas
  scripts: python: Add trace end processing and JSON output
  scripts: python: Implement add sample function and return finish
  scripts: python: implement get or create frame and stack function

 .../scripts/python/firefox-gecko-converter.py | 221 ++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

-- 
2.34.1

