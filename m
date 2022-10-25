Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72C60D507
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJYTzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiJYTzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F328E17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5725D61B0B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 19:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB72C433D6;
        Tue, 25 Oct 2022 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666727713;
        bh=LHxPXgJSeStUU4r7az4EysTl2+3HCQRlrc0uwfLrm7s=;
        h=Date:From:To:Cc:Subject:From;
        b=h2jcai28jCPYvodz6FvftC4x1Ej2dEKohaXmlQpAOQTotBXUUAfV+JAfUgFsM8yhD
         twu598BfJz1kcx160tgE/k7laqbZ4mn6GLQRofN+FAkBAR1KcMBHRDsdYFabIvEB+J
         lzr+VntGnoL5Yd+kRRs33eYKJbaOvU8+2QxKW+t1epOK6w0OC0d4uvyDBt/sULcCCm
         VCvep91dFIQNKYhBzQutVbAmK6N+KxhehyiDTjFKiQvadX6ljjDo4QZwyL4Sd9lEzc
         Of7Ux4MLNjJwqYPuu4qPAWh3Bf/hXYLW1SLgAe2Op/LYxYK/qXpxz+b4THpFA1hgmo
         eHt/maMNS791g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F584404BE; Tue, 25 Oct 2022 16:55:11 -0300 (-03)
Date:   Tue, 25 Oct 2022 16:55:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf amd: PERF_MEM_LVLNUM_CXL -> PERF_MEM_LVLNUM_EXTN_MEM
Message-ID: <Y1g/H2/ljZ1rGmM9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi,

	I'm updating the tools header copies and noticed that a previous
sync brought PERF_MEM_LVLNUM_CXL but now this got renamed to
PERF_MEM_LVLNUM_EXTN_MEM, so I had to add this change to the sync of
tools/uapi/linux/perf_event.h, please ack.

Thanks,

- Arnaldo

⬢[acme@toolbox perf-urgent]$ git diff tools/perf/util/mem-events.c
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index b3a91093069a5715..c80fce18025051ae 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -295,7 +295,7 @@ static const char * const mem_lvl[] = {
 };

 static const char * const mem_lvlnum[] = {
-       [PERF_MEM_LVLNUM_CXL] = "CXL",
+       [PERF_MEM_LVLNUM_EXTN_MEM] = "Extension mem",
        [PERF_MEM_LVLNUM_IO] = "I/O",
        [PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
        [PERF_MEM_LVLNUM_LFB] = "LFB/MAB",
⬢[acme@toolbox perf-urgent]$

-- 

- Arnaldo
