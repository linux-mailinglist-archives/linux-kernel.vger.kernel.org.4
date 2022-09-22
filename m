Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1345E66F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiIVPXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiIVPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:23:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C10F3F90
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:23:09 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w20so9066240ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie-ntu-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eTqiu+JEQepYfkr0grzj7GIxoGAMXk8v+UIOpi4Aur8=;
        b=ESZuPVHX/B5V3ozQpIw1yEKpLwB5nwyzrH2ow6REEW8IthWTjNzrxTj4inagPSlmXe
         kBQGVYTf6I9Ns3iLTBF0MMrPy2QNQIPX5rtoyZkZIAoT3KFKW3l6Rfo+ci9xXrYCjoDU
         8QSPsvJMnngiPb2xqhlXE1BsR8gG40fHLsF0pL0CpZbmXneG69ZRp08wg3TLlZ2fo90H
         GpdK1G0sbDE3PS//HFmzHwIm6RMTfZ3NNEzZOWaNFwXkC9OZx8ScKAhANVVoBu2wWJLA
         leG/gHBgg7IKvwQUrUqnEgmk/Eza7ZBE5yHGZV3fHeoMFnbW88Ax52Wk9zi2yUjN6gta
         x2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eTqiu+JEQepYfkr0grzj7GIxoGAMXk8v+UIOpi4Aur8=;
        b=vXuj0yI9US9d3dh0w4MLwPm1Wr+dWWDKHbsHEIibIo+l0HpwyUnY5CX+JfGRz7UnuB
         j06m2QZ/ofSw+0dcv5WC4e5c59ZuSaRfXCQDCCCe63cHtHNXuOwRUu75XqWfkyeRVo5C
         GmXMwaOMUK1k3xM7qO//G5zg8qMtWH6vXq/xmDPZ7h9KGsGOVob4V+82Z64Eb7b/jpyZ
         kgaeyvoZnT+8a8rvA0RpZHfAiu8bGIodIN3yWuAMlzBPd+axgdcY3cgXqy/1kVqCIjuq
         C+1/4gxf7lk99LTOpBfWGY2mSC87wDn1T6sWbC37AlV4cOmmsQSGc6glxhUp1WIDT552
         4XTA==
X-Gm-Message-State: ACrzQf1Y0Hpj98G8wCybYYxdaRifcQEY4EKIm4PdP/JAkZ6P7W1Qf6yz
        jk80YDfb0ru6lcehcfVkgtPiD0YcEByAnwyUfv9h1NyNEl/2misT6PwsPeuFlhUAroC+qQ6AOqL
        SSS8zbRd3cd12umi7XUlwoed11+b/+bIK8gmVU2PKp9l8wNsVIYT6531PkLRi2Ces2S+nyY8+rX
        XKodzddjat2nC/r3PWU9rHnMFAAhHLUIUQFX+LGnjbF2o=
X-Google-Smtp-Source: AMsMyM6W3r7xtBR3XCYB4maKpp0PPL+x4X2TJ25gP8gHElNpp9U9u32HxmIqGMwdNMP7gwYe0tvOIw==
X-Received: by 2002:a17:902:76c7:b0:178:ab0a:19af with SMTP id j7-20020a17090276c700b00178ab0a19afmr3720927plt.164.1663860188751;
        Thu, 22 Sep 2022 08:23:08 -0700 (PDT)
Received: from nann-System-Product-Name.hitronhub.home ([182.234.33.150])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b00172ad9674e5sm4241797ple.291.2022.09.22.08.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:23:08 -0700 (PDT)
From:   Tze-nan Wu <r08922135@csie.ntu.edu.tw>
To:     tglx@linutronix.de
Cc:     mingo@kernel.org, dzickus@redhat.com, linux-kernel@vger.kernel.org,
        r08922135@csie.ntu.edu.tw
Subject: [PATCH] watchdog: Fix a typo in comment
Date:   Thu, 22 Sep 2022 23:22:45 +0800
Message-Id: <20220922152245.105581-1-r08922135@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the typo from "cannpt" -> "cannot".

Signed-off-by: Tze-nan Wu <r08922135@csie.ntu.edu.tw>
---
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 8e61f21e7..98201b425 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -282,7 +282,7 @@ void touch_all_softlockup_watchdogs(void)
 	int cpu;
 
 	/*
-	 * watchdog_mutex cannpt be taken here, as this might be called
+	 * watchdog_mutex cannot be taken here, as this might be called
 	 * from (soft)interrupt context, so the access to
 	 * watchdog_allowed_cpumask might race with a concurrent update.
 	 *
-- 
2.25.1

