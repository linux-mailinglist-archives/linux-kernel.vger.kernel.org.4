Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D055E5810
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiIVBbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVBbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:31:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650179E8BF;
        Wed, 21 Sep 2022 18:31:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm5so6385658plb.13;
        Wed, 21 Sep 2022 18:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Md4huhpYv1cDGpWpaL4nk6AFG7O8XO2LLDYE/HfBOfQ=;
        b=GtXQcOEaSjiHypAGEQP3Oaz4i1QxNHIr/TOWCmkPQwiSlanvLq2mWufPtg1UKhNiN8
         Nz6Qf+4Kzd0oBRkceGQHmeeoj9heetXuSkukKCYCKL57iOmxv0SkAixm+wDJndp/UWsu
         0/nPvNsKTqulkjxjaeT65hlo0iW83UMDv6UCt0lRn+5GYMNWRTr8QD8szKivfBW0T+l/
         UPx56CLpnGDFu+KXqsyK5kjoZkshlqUf/LB/w3MwRZsSPRL9iCFUA028/fRjtdn63U05
         c2k+w92WEYy1ENrWiUJx1Xj4cBVm+GMMouL52RPRnjNJbCKompK9t+XiqsLchnCsVBGu
         wQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Md4huhpYv1cDGpWpaL4nk6AFG7O8XO2LLDYE/HfBOfQ=;
        b=O/0w0j/D60mvpdvgxy7eQ5TVXLkIc1OUKwtiacHUK9Qc9SOEnuhPBFeDVyRR1VHuE1
         TYsE/dzozf0hOYJbHc0QKASkxDYmH5CtjZPfrEnn2tKXi75k9ekVutfdXYVphxvXhCf8
         Bj+WzzOTuAZJz9975HxCMWb0eSBUzwnJ+xgYEru0IFgwo4T2CiDlyVH/dVYey2X/2EcA
         V2/FgGRGNdJkYANaUSoxZYX/jVCn86aoUm11qO6wqOVEXMja9s/Vs5qwxyKnYIh//8ul
         AX/P6cWVU7S9fZ6hYGXFbUKc67rXKGJ27vUQL4ae0aGRkgmMGTLTpE/CgRCMArn8+B4/
         Qclg==
X-Gm-Message-State: ACrzQf2ADw1Tbmvlv3+Za3FU0baQZu/BM4KfWBXxeigmXG0kIJUHihIw
        f5yuaBcV5eamROJfrXhg3CfSKueD0lM=
X-Google-Smtp-Source: AMsMyM4TId2/V19iHXuApj/eDS6jK5Ogd41FeWKLsKitiJifNKgGeREKbjG9L+xMlSw6eu2WcgF3TA==
X-Received: by 2002:a17:90b:3b50:b0:202:9e4a:2fdf with SMTP id ot16-20020a17090b3b5000b002029e4a2fdfmr1049333pjb.240.1663810308870;
        Wed, 21 Sep 2022 18:31:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u1-20020a626001000000b0053b9e5d365bsm2804315pfb.216.2022.09.21.18.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 18:31:48 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, andrii@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf llvm: use strscpy() is more robust and safer
Date:   Thu, 22 Sep 2022 01:31:43 +0000
Message-Id: <20220922013143.232870-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/perf/util/llvm-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 2dc797007419..3e218cb8f0ae 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -80,7 +80,7 @@ search_program(const char *def, const char *name,
 	if (def && def[0] != '\0') {
 		if (def[0] == '/') {
 			if (access(def, F_OK) == 0) {
-				strlcpy(output, def, PATH_MAX);
+				strscpy(output, def, PATH_MAX);
 				return 0;
 			}
 		} else if (def[0] != '\0')
@@ -99,7 +99,7 @@ search_program(const char *def, const char *name,
 	while (path) {
 		scnprintf(buf, sizeof(buf), "%s/%s", path, name);
 		if (access(buf, F_OK) == 0) {
-			strlcpy(output, buf, PATH_MAX);
+			strscpy(output, buf, PATH_MAX);
 			ret = 0;
 			break;
 		}
-- 
2.25.1
