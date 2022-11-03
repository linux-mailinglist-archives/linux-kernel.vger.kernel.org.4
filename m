Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B646179EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKCJ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKCJ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:28:17 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8E21057D;
        Thu,  3 Nov 2022 02:27:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j12so1366162plj.5;
        Thu, 03 Nov 2022 02:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aF9SCZOYOqwuCRWtDO+Kri8E5TpMnho7XD2CtgbqYc0=;
        b=b7EcIXacH91Qelc+VV9DqHnM4gDYc/WCC8Wnf1U1iRRrIjiZ3Gd5a0nTM83zBRoqXR
         aCrWJ/V0udsrsR65dS3rIv/ijySbIV6jez/PP3gLdDGe0lAduO12P5OJYw6/5kDkEqkw
         qAjj0zi7LdOxrXrOzoq0TAIpAjIDNNzf7dtanfCTvhwCaIYpqRwokCmHMRTHerrL+Pvw
         dV+vjZkWaR2RbWbIHuVkh7KVHkWXOhUYq/nuBOVGnPohp41bBr7ndbDdwTPR9AmLoqzm
         YtyM1RapXaVytwfy7Zkaz2WjLQd3oKznS03+JcPT0jH5KSBhQ7KwfpP0OvB5Vx6+xbQp
         gsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF9SCZOYOqwuCRWtDO+Kri8E5TpMnho7XD2CtgbqYc0=;
        b=UFUvdePw+eGp4CeO/jJU0Btm+ZaYXY2n/jkns5girJUCVkJcIR7ygHEJNfyKR5kolu
         3X5LeIhdxa7cTec52VFRE4X/fAyAELkCucKEu0UCeEObMOD9bstrX/mTwMsUoZDVuPUI
         O9jRDqubJbFhoY7AnSpH2Zj70QcrrDfAA404zHsEXru2TQ+P2ecbFKEH8iN+rWQS1/ZE
         6WI3Tr4WfP+adnI/5CCmPkv1rludvGS3R9CFFQRToxbRLR7gSYpOn7APk8M09T2v3XTn
         oaRhacXUQ5EtIxGOhPmoeeoKuJIDcT8/hSfJiRjPMshVEJyUUyeZWTbdanLM87Y3tS7P
         h5yw==
X-Gm-Message-State: ACrzQf23tZI8P14VaWR1iR+EbGDjdOJGulwwELpr8KNvcXTCIH7E7fAr
        p0Wa6DFeGg8PuUvsF6XlVls=
X-Google-Smtp-Source: AMsMyM4+zqTTSGTgjqft+ak4Qp7b8N8HRL45G/Q5OKiqSymM2orthr0wi99Ls53bPdY7HFIK/hPByQ==
X-Received: by 2002:a17:903:1112:b0:178:a030:5f72 with SMTP id n18-20020a170903111200b00178a0305f72mr29324771plh.12.1667467638702;
        Thu, 03 Nov 2022 02:27:18 -0700 (PDT)
Received: from ubuntu.localdomain ([118.73.150.53])
        by smtp.gmail.com with ESMTPSA id s4-20020a170902ea0400b00186727e5f5csm82129plg.248.2022.11.03.02.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:27:17 -0700 (PDT)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     peterz@infradead.org, acme@kernel.org, adrian.hunter@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v2] perf tools: exclude the include/perf/ directory
Date:   Thu,  3 Nov 2022 02:27:04 -0700
Message-Id: <20221103092704.173391-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3af1dfdd51e0 ("perf build: Move perf_dlfilters.h in the
source tree") moved perf_dlfilters.h to the include/perf/ directory
while include/perf is ignored because it has 'perf' in the name.
Newly created files in the include/perf/ directory will be ignored.

Can check:

Before:
$ touch tools/perf/include/perf/junk
$ git status | grep junk
$ git check-ignore -v tools/perf/include/perf/junk
tools/perf/.gitignore:6:perf    tools/perf/include/perf/junk

After:
$ git status | grep junk
tools/perf/include/perf/junk
$ git check-ignore -v tools/perf/include/perf/junk

Add !include/perf/ to perf's .gitignore file.

Fixes: 3af1dfdd51e0 ("perf build: Move perf_dlfilters.h in the source tree")
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes in v2:
- add 'Fixes:' tag in commit message
- make commit message more clearer
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index a653311d9693..fd7a6ff9e7aa 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -4,6 +4,7 @@ PERF-GUI-VARS
 PERF-VERSION-FILE
 FEATURE-DUMP
 perf
+!include/perf/
 perf-read-vdso32
 perf-read-vdsox32
 perf-help
-- 
2.25.1

