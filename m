Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9185A5B5599
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiILH4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiILH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:56:49 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356728E35
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:56:49 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r17so7516994pgr.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=CjZpT49OVAVxmJO/AP+ckUQZ2rv6fE3U03oMNO2AxxM=;
        b=dcPLjCWjguSLTWCNIbDuA+lDjVdOs0uI/M+GyN/pyBm1RJxlusrSUBd6MYodvzilVn
         rSPgAG0Jemuk3vyZRoh6WIbOG/dgaTCjUxo9CS+taSY6DJaKDuu///HqxKP1h/lVE6KH
         /ma0hkPp/XyU/OEdFU02yjEGQ9ez2wH46lH1/t6M37AWiAwJQgeDEG+vE1JfN8pEi5K7
         IDN0ITi1XqXjYh32BPn/ClBQbbZBcSEJ0zxznauBoYt/8dNy8Ylu7nIM3lGWwyUBmn9E
         9nX1MbDFh2hsEO6+ejIxTbd/GyL+m0PQppF2JKhDp33uqd4UWF1WNOUVwdk+UEauDne7
         u3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=CjZpT49OVAVxmJO/AP+ckUQZ2rv6fE3U03oMNO2AxxM=;
        b=yGAmJ+L4/G7Ky6g43cf15+Cr5CAycf5Yfuk0bmrKztbHVhxZf7ngHwjBV8+5LDbxNn
         XL96YmaIIre3pFitjj0AMoiSrZp9k+Rp4Y6xjnkbnsLLPpHRp2U4wP46vgkycv2X6f+b
         aHn5zslGuXrw0hxf/jCU+OZEVo3lQORX7mKfMaSDCZ0UMkG/oKyi0QW1GUH/pEOtGT7f
         QUA30/xiMuzhWpgX6+hBssRviW0qV2TFGzmMRAgNL7znG6A1YAqzsVlWCWqxMVoTPRIc
         fG/YxE9QHl35IQqpe9/GfEmVmlZGC+lT3rNuAFhKBE+SxLfaQmwCZXET9/Zhk38XtVWR
         AJvQ==
X-Gm-Message-State: ACgBeo3f7wYfGe9ZhWhpzi1LfP2FCRgKbon75X3B8yS4XzJDMagNL5A+
        5gel2iaFsMY7DG5OV1XwOEU=
X-Google-Smtp-Source: AA6agR55tNn4NxbUxVlWIZern0hu+u//yc5oBEXGvv75gcNiFusN3sdknH8IMW+3awCX1Izubgjqng==
X-Received: by 2002:a63:f018:0:b0:438:6321:ff0f with SMTP id k24-20020a63f018000000b004386321ff0fmr15769865pgh.462.1662969408578;
        Mon, 12 Sep 2022 00:56:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i17-20020aa796f1000000b00540d03f522fsm4680049pfq.66.2022.09.12.00.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:56:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     olivia@selenic.com
Cc:     herbert@gondor.apana.org.au, linux@dominikbrodowski.net,
        Jason@zx2c4.com, kvalo@kernel.org, ebiggers@google.com,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] random/core: remove duplicate included header files
Date:   Mon, 12 Sep 2022 07:56:31 +0000
Message-Id: <20220912075630.17120-1-xu.panda@zte.com.cn>
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

From: Xu Panda <xu.panda@zte.com.cn>

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 drivers/char/hw_random/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index d7045dfaf16c..f01dce80553b 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -21,7 +21,6 @@
 #include <linux/sched/signal.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
-#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-- 
2.15.2

