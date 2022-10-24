Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A0160B5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiJXSlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiJXSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:40:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0FC1759A;
        Mon, 24 Oct 2022 10:22:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k8so8624610wrh.1;
        Mon, 24 Oct 2022 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jYf7cTB4wDVQpysigBRvPC/XQ9ZNHdrnvPwPX4mSzYs=;
        b=ZtbjaQFrkNjsUuUy2r1veI7zdJmUQBlKdcg8EY691iFQsz4/fvFVeHJL0JZ5Z5+WMe
         8t24dv6AwIwCv71gQfgEOwq0jm9Q6LJ9rAVawleQ/KrrNErlGgEcEJkorwXT5Boy8n5c
         GwX02Jh7vMyjQR3cF65f0siOmQUp/wcjTCzKnslrriz5psty1cJ3U5FWABv7MDzInSeY
         ZzxH+kpCsf8c3vEcZp5nP2WfO9QfUjkBN3xt/1MQrDUTpirv82tDA8fvChKCOi4ozdoB
         42ztCXuut/sb/17z2BhpuZ2DyGxBw/6cjHdY1aT7lKl2JlIgYIkLnl3Jxt7mV/vHXNkf
         1o6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYf7cTB4wDVQpysigBRvPC/XQ9ZNHdrnvPwPX4mSzYs=;
        b=avGNW09O+bSG6GhzuZL+QJ4ZhIOxmdNRL/uXWf3YKK/y11CflDu4B95MaJYZhQI5Qc
         60kBeZExamxwHid97nML6UvwOAnpJZJuflZggQBykocGssUq/aQPanOzfCNMrosjEXTe
         3phNjgWfuJ5I5YoQch4fDi3bjii7kmDoqZI8zedP38CIsbHUe7FPB47b/xcVQ0Kw03q7
         BBwqy4wrZFUKPP2vCDRb85LDcIQ9Byal4T+anw8bZbSE+RNfOdcWAZ6QUnscxNaFkDmL
         gWGnLLHgNbR4K4bZw9VwTVPZTt0dajwjc7XcciejY2aDqs3Bqh2Z4OckO3mhgkcUmKqz
         dR1g==
X-Gm-Message-State: ACrzQf3AoFD13izflUJ7MkqBh7VP/jv7pd0WiuqSZ6HGgW9eIiETKMYr
        b4FOosuRBYjA3aGQPprnvyzvN6wDti/DClDF
X-Google-Smtp-Source: AMsMyM6aq2UQDlHmeTkXIJvJ9kWzInvPWV2UA72I3i2TsH9IXL+6obK98pW6NhB5zlKTxgDbROWQAg==
X-Received: by 2002:a05:6000:788:b0:22e:412b:7959 with SMTP id bu8-20020a056000078800b0022e412b7959mr21871223wrb.491.1666627863318;
        Mon, 24 Oct 2022 09:11:03 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b003c6f3f6675bsm8873808wmo.26.2022.10.24.09.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:11:02 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: asus: Remove variable count
Date:   Mon, 24 Oct 2022 17:11:02 +0100
Message-Id: <20221024161102.2171702-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable count is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hid/hid-asus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index b59c3dafa6a4..f99752b998f3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -219,14 +219,13 @@ static void asus_report_tool_width(struct asus_drvdata *drvdat)
 {
 	struct input_mt *mt = drvdat->input->mt;
 	struct input_mt_slot *oldest;
-	int oldid, count, i;
+	int oldid, i;
 
 	if (drvdat->tp->contact_size < 5)
 		return;
 
 	oldest = NULL;
 	oldid = mt->trkid;
-	count = 0;
 
 	for (i = 0; i < mt->num_slots; ++i) {
 		struct input_mt_slot *ps = &mt->slots[i];
@@ -238,7 +237,6 @@ static void asus_report_tool_width(struct asus_drvdata *drvdat)
 			oldest = ps;
 			oldid = id;
 		}
-		count++;
 	}
 
 	if (oldest) {
-- 
2.37.3

