Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE46C6937
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCWNLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjCWNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:11:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B83803A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 785E6626BB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 13:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7DCC433EF;
        Thu, 23 Mar 2023 13:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679577074;
        bh=/OLefhFZ4sSoFTXhUzU6IaDDgb/f3Tybtx2GNklSFZk=;
        h=Date:From:To:Cc:Subject:From;
        b=rWLRPOUFKadadg9y9Kg4aDNA6PX2eyrslleiTSZd8Rl5a+9bAFVMsuLgeDg9I8lSn
         nFVrfMFfHNMFzOtW6Dn0AF/FxudZs20bErVZ6Ya62L5K2rnkth6rcF5MohGU2rpGir
         0RKcqhwRySwxc2LXv7JW4XvwrIAtctgmdKslZ7tGHSWIIirCJ2vzl7BgCpbw8yHeTF
         U9BgvtDM/EjFikFXXAuQ4qo4L39x7X9u+S7lE9zryn0NgG8SD2cPQAsvU+646ZyyI+
         N/UrMv/RsDStFMphC+/DjFtaOZE+LYOQT4TEXBVxPDrguuF7vUPgNZwRS53wJGoLyf
         Pq+dE+zAL5RSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F13B64052D; Thu, 23 Mar 2023 10:11:11 -0300 (-03)
Date:   Thu, 23 Mar 2023 10:11:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf tools power9 JSON files build breakage on ubuntu 18.04 cross
 build
Message-ID: <ZBxP77deq7ikTxwG@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exception processing pmu-events/arch/powerpc/power9/other.json
Traceback (most recent call last):
  File "pmu-events/jevents.py", line 997, in <module>
    main()
  File "pmu-events/jevents.py", line 979, in main
    ftw(arch_path, [], preprocess_one_file)
  File "pmu-events/jevents.py", line 935, in ftw
    ftw(item.path, parents + [item.name], action)
  File "pmu-events/jevents.py", line 933, in ftw
    action(parents, item)
  File "pmu-events/jevents.py", line 514, in preprocess_one_file
    for event in read_json_events(item.path, topic):
  File "pmu-events/jevents.py", line 388, in read_json_events
    events = json.load(open(path), object_hook=JsonEvent)
  File "/usr/lib/python3.6/json/__init__.py", line 296, in load
    return loads(fp.read(),
  File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
    return codecs.ascii_decode(input, self.errors)[0]
UnicodeDecodeError: 'ascii' codec can't decode byte 0xc2 in position 55090: ordinal not in range(128)
  CC      /tmp/build/perf/tests/expr.o
pmu-events/Build:35: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
make[3]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 1
make[3]: *** Deleting file '/tmp/build/perf/pmu-events/pmu-events.c'
Makefile.perf:679: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
make[2]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....


Now jevents is an opt-out feature so I'm noticing these problems.

A similar fix for s390 was accepted today:


https://lore.kernel.org/r/20230323122532.2305847-1-tmricht@linux.ibm.com
https://lore.kernel.org/r/ZBwkl77/I31AQk12@osiris
-- 

- Arnaldo
