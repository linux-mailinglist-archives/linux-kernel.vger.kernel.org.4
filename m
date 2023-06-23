Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2396C73AF41
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjFWEHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFWEHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:07:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BC2113;
        Thu, 22 Jun 2023 21:07:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3110ab7110aso236487f8f.3;
        Thu, 22 Jun 2023 21:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687493240; x=1690085240;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHnnqjUS6BXCy4/vP5kyam1IW+RxpOFtTIv68cjgZwY=;
        b=Nl1pjP6e0BnX17fs1Ilpfz9p/O/UOTMCsZTwoaKbTh2ZDlS61xXJ/DA8zgpOeAY9r7
         kwhwMbYoMWPh59CNR/UerfvVTGR/q5FBXZBXFB9d6zWs9RJvtTmJ/SNkMznqk553kxo8
         19btuCvCqtZHPCzy7LzuHF1xgBlbMQD8O3vKnAn8kOr5f1IrGDhRmPM6SfitICdnxfty
         bjVYFHcEUZHhhF03ZJ1Yv0Fp6b7GxV8QUX3KgxPfgHVlZE8MW4kMu7B38g6vgPoQg6nY
         Y1cDnwyZFTKrDZ2qypGje0U/ID5njuz7QT+m/1yhZ7ugEQXQtenpNC8fz4z/6J0jHnCr
         NAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493240; x=1690085240;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHnnqjUS6BXCy4/vP5kyam1IW+RxpOFtTIv68cjgZwY=;
        b=blez9eU/nY3uyqAipC0IoY2HaAnaBy2Qy6FSwSwlvAk/Th+03MEsswxiz9YHoXtzXi
         fwBKqrqxlpnBpwKSETXqqcsncQMiH/hT0f6slOGEpPrIwkRXnQjEWgApxN2Q6YFRcxEy
         CvUZ6iDLr8VtKv+rnSPaMsbLnCsWcpcPAOR4yVSIAUmcV93/X4CzE6+8VUpAEVUUovkI
         yMOKB88DMOKV3sr7qbVMr9q7XNqrQwjOeSj7Ro5wM4qdG4uECu1/PtU9n1doi2BVcZNt
         soiTdnwvSjt93NSEIdEBeZICJYzMjSaKp+6Ti774MHkKH3ZCPzwX0G6T91yMHoY+HBJK
         p1+g==
X-Gm-Message-State: AC+VfDyRHQgOPDPZWhVn9441CpphT7clFCrmnmTQwdpPGywB/B2x5Lh+
        N1MuQ3ExK3L934OvJbNkRns=
X-Google-Smtp-Source: ACHHUZ7a5aMaPTCpVaSkC3PjakclmgWrsCO5d1l5Pp9cx8gqFz5Ntdx2xY3vbi7y8TFG9vjU507zwA==
X-Received: by 2002:a7b:cd89:0:b0:3fa:77f2:e255 with SMTP id y9-20020a7bcd89000000b003fa77f2e255mr2124517wmj.5.1687493239986;
        Thu, 22 Jun 2023 21:07:19 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:851e:d01d:5e81:992f])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003f727764b10sm1127534wmg.4.2023.06.22.21.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 21:07:19 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] watchdog/hardlockup: fix typo in config HARDLOCKUP_DETECTOR_PREFER_BUDDY
Date:   Fri, 23 Jun 2023 06:07:17 +0200
Message-Id: <20230623040717.8645-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a5fcc2367e22 ("watchdog/hardlockup: make HAVE_NMI_WATCHDOG
sparc64-specific") accidentially introduces a typo in one of the config
dependencies of HARDLOCKUP_DETECTOR_PREFER_BUDDY.

Fix this accidental typo.

Fixes: a5fcc2367e22 ("watchdog/hardlockup: make HAVE_NMI_WATCHDOG sparc64-specific")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c4be7ba93b56..781f061ec0fa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1075,7 +1075,7 @@ config HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	bool "Prefer the buddy CPU hardlockup detector"
 	depends on HARDLOCKUP_DETECTOR
 	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
-	depends on !HAVE_HARLOCKUP_DETECTOR_ARCH
+	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	help
 	  Say Y here to prefer the buddy hardlockup detector over the perf one.
 
-- 
2.17.1

