Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B4617558
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 05:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKCEDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 00:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiKCEDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 00:03:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569913E8A;
        Wed,  2 Nov 2022 21:03:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p21so769062plr.7;
        Wed, 02 Nov 2022 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1H2zzTzRPTmUgI0UyMApMa3/ZtTK/YRKX99EEtraxW0=;
        b=Iks06j2hpnu7NyiHNXf+EYE54sE7V+2ljQ/+GqgpeM9Mfi5TPGHkWx7IrOr0LJo+vP
         ZgDPfRsBkKdzaDoyeZnaae3lvf2B5xE4A+r2Bz4MdpXWtuhWLfgVlXBzdvDJSwppxuda
         uLbSR/+3h6THx3WZ7YqIaEwumCrnoZrPjhZw7T7RqtStir3TBmwHCbQgjr252HETUukn
         vArPbrHBPHPqHhd8kFN0sfD2TiUENp9ZAF7hDi7cWO/yfluXZyFkjzh3NkjUjeRqmR9w
         sECI7/EKstRBqPjhCaOCO2XdQu935Kl2TiDLVz1Cr9qLxj2fqWo8CSzxLbuJ3KHHsjHh
         1M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1H2zzTzRPTmUgI0UyMApMa3/ZtTK/YRKX99EEtraxW0=;
        b=0U0LDYHagkapX/lfFg0/MpihFrfheGjHuZhtGS8u7sMSUAMCHf6WBJJ1FLgf79dfQW
         n8gnlNTSClpWreg3OtaEZLSA08D528+VAEug9cMbI6RbGs36j8TaR+BCWz8/zP7XHNus
         v/l5AQezkzAGw2btgNNky0CFcLfUAtRouenpSUVU2vUXzV4NEsHxycNBtVa9EmvzTbD0
         TYBKnNu9ag9p7ic9Mlv65kDlfHf/aGYb/Vx0t2fINzuk1oHHJZ2yf3+YSqeM1SrPNCbS
         5KcKROsIje+YiI4Seb5ikTwIDOTFuJVN7nUNNJO3sPe2mioOotFuRCQsOqri8q0zuZdQ
         pMJA==
X-Gm-Message-State: ACrzQf2kQtj9+8jGHZtzqEt6PpHIGQ+BBkRbbIefksvLjZzSPnkf/UOX
        cowygOmhdEyLkC0cDHcyT94=
X-Google-Smtp-Source: AMsMyM6GkRw/oMp+ZihyZQWKtOLxFzkFpTpqxKDS+mO3j2623gGYJ3XmzauiVZ/Rr42wDZor2zxmXg==
X-Received: by 2002:a17:902:db12:b0:187:2596:8b0c with SMTP id m18-20020a170902db1200b0018725968b0cmr17755125plx.172.1667448221816;
        Wed, 02 Nov 2022 21:03:41 -0700 (PDT)
Received: from ubuntu.localdomain ([118.73.150.53])
        by smtp.gmail.com with ESMTPSA id qe15-20020a17090b4f8f00b0020d9c2f6c39sm2208742pjb.34.2022.11.02.21.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 21:03:41 -0700 (PDT)
From:   Donglin Peng <dolinux.peng@gmail.com>
To:     peterz@infradead.org
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] perf tools: exclude the include/perf/ directory
Date:   Wed,  2 Nov 2022 21:03:21 -0700
Message-Id: <20221103040321.56233-1-dolinux.peng@gmail.com>
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
without updating the .gitignore file, causing new files in the
include/perf/ directory will be ignored.

Add !include/perf/ to perf's .gitignore file.

Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
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

