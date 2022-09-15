Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB46D5B9BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIONgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIONf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:35:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C157E1B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:35:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a80so9502255pfa.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IL+lTeKoKNnM0D4T5iURSuCMcFmdwkN0yoQHL7kM3QU=;
        b=N+96AQLlstuHqImdTr2LSX/ZnBJ0f+F9zbMkAXYaYRiapFmAkBFBOdH6EAn4XeoOW1
         ODs8ShLb2R+sf9gVUQpYta3zP/TyVKeQrViNL+TqMrsaOwF66MuJmKq+JtNe8pW9InMv
         TK2zI6Sog6X0n4110A1kova62JL7bDjXnAPqTDRAkmJqhSuqsuKq5hVv/nFXlKtwwP4K
         GrEw9y3xaakIditKUty5yZAGwIZL54T+I4Vweu/SDKp9+yfRa3yunGrcXm7jF8lw+a/u
         fNOFvcVdi4xeDuB6BVzhdQnrLGAMI768RYJWKNXBGVxXLTa7mysW7Z60PK/aNrvDkfC2
         fpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IL+lTeKoKNnM0D4T5iURSuCMcFmdwkN0yoQHL7kM3QU=;
        b=SroMm1MeeY5f5KDeIvCOQ95gkHrrMFbmEc3241Fh4s0oiGSWv4RtbUYt9nn3Ubykyw
         koaqZf3tjzoUWYHx8it0U3kjooAQr33Ii+ufQodhTxOtSTZkKuANaxso5Fp9g95XO8E2
         7hGmala8ODhXBiL2laNoRFwEEMfh9XaxqdjmLVPxuxcEL0+5sNW3rBYtX5DlyM/hByvb
         QwUAUphh4CDwMMfDWIUFkmxkbBWyv9hugzpVqHiBJbMDpYMcR2lUxJVreCY8ACWWQkdU
         yk2UHYffKEcGB8oin93LeIBFCyNoode5QUUgQ1s0I7B/KftO6Lsq+2Taprl+49Q5MIUe
         JzzA==
X-Gm-Message-State: ACgBeo3CODi0iW9NFQkW6hQZ2KdppUBb/+BUC++P6gl5y2MqK0hdOMer
        w/4RVGFH3Fa7/4jA2e+NE2xE/7NYXR0=
X-Google-Smtp-Source: AA6agR4nbC7lsZpLKN+Egl+cM1i0IoHU66jUuCJvnAHrBSS79cZoUCp3EswVZamj5iCevxKYh4CSQQ==
X-Received: by 2002:a63:d511:0:b0:438:91d5:5a43 with SMTP id c17-20020a63d511000000b0043891d55a43mr25182483pgg.587.1663248957559;
        Thu, 15 Sep 2022 06:35:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902710b00b00176c6738d13sm12827830pll.169.2022.09.15.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 06:35:57 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     ray.huang@amd.com, dsmythies@telus.net, rafael.j.wysocki@intel.com,
        Jinzhou.Su@amd.com, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        zhanglin <zhang.lin16@zte.com.cn>
Subject: [PATCH linux-next] tools/power/x86/intel_pstate_tracer: Use absolute path for grep
Date:   Thu, 15 Sep 2022 13:34:39 +0000
Message-Id: <20220915133437.36827-1-xu.panda@zte.com.cn>
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

From: Xu Panda <xu.panda@zte.com.cn>

Not using absolute path when invoking grep can lead to serious
security issues

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Reviewed-by: zhanglin <zhang.lin16@zte.com.cn>
---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index b46e9eb8f5aa..d6fae6e51d30 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -348,8 +348,8 @@ def split_csv(current_max_cpu, cpu_mask):
     if os.path.exists('cpu.csv'):
         for index in range(0, current_max_cpu + 1):
             if cpu_mask[int(index)] != 0:
-                os.system('grep -m 1 common_cpu cpu.csv > cpu{:0>3}.csv'.format(index))
-                os.system('grep CPU_{:0>3} cpu.csv >> cpu{:0>3}.csv'.format(index, index))
+                os.system('/usr/bin/grep -m 1 common_cpu cpu.csv > cpu{:0>3}.csv'.format(index))
+                os.system('/usr/bin/grep CPU_{:0>3} cpu.csv >> cpu{:0>3}.csv'.format(index, index))

 def fix_ownership(path):
     """Change the owner of the file to SUDO_UID, if required"""
-- 
2.15.2
