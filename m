Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3935BFB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIUJhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiIUJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:37:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FE38A1DC;
        Wed, 21 Sep 2022 02:37:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso5191322pjm.5;
        Wed, 21 Sep 2022 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=sJJX94+/0btCCV0Ia97XtFOi6t10e2FyYXS5c7QNc2Y=;
        b=VuS7lgBrSbeDQc2IODEN0g+qBQ4v0QM/IDN9g+xfeunYPG+Bw96+o21dgt0l5TcVsA
         EV/18pVXN/4kgeykZOjEME3GhEuw2OvmZiTZIZQe8PYyN3ca6PFixW2l+B4mQhjAXvVT
         xJJIhT4FkwjVEP6E5aJbGvyLU+Ks8dtY4NUDDHByxKJCRbhLSh/mhxsECZCUIxDn17Qv
         mD5ouwldSzKS9yuP3hBa/0enezkP2n1G3WvFpcg8ZhvIW2NQ9c0by4yF62shWXpUUn5G
         VcxheWM1NXIljkAIogn26QUNwmPBhpXydUqFJDozPR3mpl/jOBDGbHg5k7SyYg9al5Nt
         Yflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=sJJX94+/0btCCV0Ia97XtFOi6t10e2FyYXS5c7QNc2Y=;
        b=MAdWEB6nqdyiG4jE7ZCaqmzzK8CYOq1IoH2pAWl/XmBP1gBlPkGW2e4H+sJUoouZpu
         mJBfTxqmrIwZa9tLR0SBXc/dIKI2CvPz5/8sk2+VZ/rn25lwxhFMX/oxcUEvH1Bhcwpx
         TDou5x/5qs0eB7oYri8GsxjUeFxlvxEuUq57ZbsHQqKVXyEYKksID4VWPe1hNPWLqnC0
         YwEIU42rWR5/gtODH41lEK48Vw6zVEGMVUjMvg0PTeIPCbpjRdOB6BOWQbtEGrwVE/Z7
         rck8Y+FEf0bOEnul+bdko83rPS268JLLi4222W3yDlEEpUg7+D6hVur+EbLr36Q6t0hV
         mvQw==
X-Gm-Message-State: ACrzQf2sA+uozYLZiA2+4+2eJ2z2Uj4uDvqAFqgJeYeC/jOl/PyMGzkI
        Xg2eRbuBaK3/RKOflreQeuk=
X-Google-Smtp-Source: AMsMyM6GNJSwlUtliFAUq2n4xXwYL/tbtbMb8gCUBtfq7LixVOSOfnDQvVSU/rXtGFclvPjrHW1Y6g==
X-Received: by 2002:a17:90a:fc98:b0:202:52cf:c117 with SMTP id ci24-20020a17090afc9800b0020252cfc117mr8367520pjb.26.1663753021133;
        Wed, 21 Sep 2022 02:37:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f126-20020a623884000000b0052e987c64efsm1663993pfa.174.2022.09.21.02.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:37:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     acme@kernel.org
Cc:     mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, andrii@kernel.org,
        songliubraving@fb.com, irogers@google.com, davemarchevsky@fb.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] perf dso: use strscpy() is more robust and safer
Date:   Wed, 21 Sep 2022 09:36:54 +0000
Message-Id: <20220921093654.230855-1-ye.xingchen@zte.com.cn>
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
 tools/perf/util/dso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index f1a14c0ad26d..f2a684f86b82 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -318,7 +318,7 @@ int filename__decompress(const char *name, char *pathname,
 		unlink(tmpbuf);
 
 	if (pathname && (fd >= 0))
-		strlcpy(pathname, tmpbuf, len);
+		strscpy(pathname, tmpbuf, len);
 
 	return fd;
 }
-- 
2.25.1
