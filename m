Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89135B7EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiINBxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiINBxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:53:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C96CD16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:53:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i19so9709613pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 18:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=SJ2CP/JNtkfOytiVks1nbSpxqs/NusXfw9ckRl6b8Rk=;
        b=Aisj/Dl35O0fbQh5IUvygt3dd/vR7pgWtW3gAC8ta6ttwufZpaofhguP0YZyTKIm3E
         Gus38C009OMLtvCOEsqGXqtCvba+jdxp+8TqWz2njIl3wHTrsLpOK5hLpdmoAf/sqpwn
         8yf+9lccBd4BGF2eQdsKK9i4X7aMoJ+0FWmYdfx6d1zhhZVGGRln4potgO/Jyi7UnhEX
         xuzgqqnlfa3aKwrgmzK4Pu4Hh+R0qTC+q6dAxPUM5WJ8NpdnsQ4UzGocBQGBL0wn2UNl
         d/wO3rBnD8omM0W5yxVkRNXxAc+qK8mTXTvl9WvllgD3gVxV32RcwtTTbW/udNu4pL3j
         Yalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=SJ2CP/JNtkfOytiVks1nbSpxqs/NusXfw9ckRl6b8Rk=;
        b=WrOBmh3l4/qWaXszUCIZ5tesxUwOUN80mqc2m4EHPgEiUYSKSoQgyvTORlase+52vP
         siuKcRFhsxA3kND+9Rw39vNB0U5D+bpmWtnA5iVeVb2AmlERGXkfnQst9nauMkfHGy6I
         oM2FcekebvPY0986mLBmJyWUIh6V1XJPRVJPtkjoJQVPz7bPYyV2ET0BD3zbktT44yKK
         SaZRtb/LNdBQngGcSh+RTJpUTlf0ajk1dLpfLt8W4PTumld3lcWGy2byctx4gF6VVwVb
         NyBbQO+wPf3eRO8UCpz6VVYWuu36qeMQvT2X7u70Boem0OhohrW56KLhp71Nb9NChMal
         WLOw==
X-Gm-Message-State: ACgBeo2T9A2u1ud+RmbEcj2XAze1nG9mqCtoT1GdUlDnn3Cc7IKZgWyu
        xHrFbMCychHYSBxloo8qhtY=
X-Google-Smtp-Source: AA6agR7THUpng+p5RIJX53wLmw2HPRD7n8GuHhRuJgHiiixQxR+Udu21QejCF72Hk9hhx9cCAp7pjg==
X-Received: by 2002:a65:57c2:0:b0:438:ac40:1460 with SMTP id q2-20020a6557c2000000b00438ac401460mr17784668pgr.216.1663120380020;
        Tue, 13 Sep 2022 18:53:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0017544b55277sm4353124pli.126.2022.09.13.18.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 18:52:59 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] soundwire: intel: Remove unused parameter ret
Date:   Wed, 14 Sep 2022 01:52:56 +0000
Message-Id: <20220914015256.22378-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

The parameter ret = 0 has not been used.
Return 0 directly instead of returning ret.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/soundwire/intel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index b006ae6efcb0..26fdf3577454 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -395,7 +395,6 @@ static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
 {
 	void __iomem *shim = sdw->link_res->shim;
 	unsigned int link_id = sdw->instance;
-	int ret = 0;
 	u16 ioctl = 0, act = 0;
 
 	mutex_lock(sdw->link_res->shim_lock);
@@ -427,7 +426,7 @@ static int intel_shim_init(struct sdw_intel *sdw, bool clock_stop)
 
 	mutex_unlock(sdw->link_res->shim_lock);
 
-	return ret;
+	return 0;
 }
 
 static void intel_shim_wake(struct sdw_intel *sdw, bool wake_enable)
-- 
2.25.1

