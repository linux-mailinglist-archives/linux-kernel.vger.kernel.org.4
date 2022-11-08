Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8386621EBE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKHV4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiKHV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:56:33 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F16317B;
        Tue,  8 Nov 2022 13:56:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so23070276wrq.3;
        Tue, 08 Nov 2022 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWi8AsnAXr1L5oWziawccETw/TpocZBIIBOJfBTzhJE=;
        b=pjyFWfPlWsQy1nigSqke8Z0vXoHkUnsJH/2DB4nkoRCuL+5G3QbHge3HcayNZzFM57
         fp1M3nPpxluF6CSUTGvF+qk+TVJ3UjY17/hoQJcGOWZvr5U0Qa7fvgKH/98XqfDcO6xp
         zJjl+zRGWCCYwX4QWwvvDCSZ5QNT9J3bYb+p6qnbszVghd8dC9JhZn9LXjRJj9mXVgxS
         KP4getsFS2tUGMkXJVR/EE44/nMw6XOhJYYl9R5L///w9YU7yIl9PNywnaPsyGI3JXJ3
         h8RpWwTPGffZoQYt1voeCE8arRE4qjkrHX31rYSQKBumqkz9q87EeTFy9eW2oWRs1P4J
         6pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWi8AsnAXr1L5oWziawccETw/TpocZBIIBOJfBTzhJE=;
        b=cQ1FMls8X9GSbIgPvYmlcBDBPSdTW4pvf44RIFILA+4GXxpMqZDaOig0nuKKJbLRRe
         n05AwhbH/l+3MTc0k5D6kxMAKMNA7jzOLp3bijsFr9OAXgZRMiBiJfsrj8wTTjI4sORj
         DLyfEVJz6Fr4e9uI3JShZAOmRoafhnf7cVtOFK35U9SCIs0fHNxV7Z7Y9m7dxrwST02d
         L03IObU5vPM0CECC3sSCZB8HzjFKbyAtVbQatB4gavWi8PfjpQiblWwDlIS6BGoMMSG7
         SVEz7sm05gw/sQkJAHXG+z8Y15zJv6S18uHSr803Ii9fbR0OHxR79aXKD0hmQ3WvhcaA
         m+SA==
X-Gm-Message-State: ACrzQf01qfKhJaJhjNKnSFjS4c9RIdfwXuGLSL/4jrh69IYfX8VZ7+tT
        LCjhLl/GdTqPYenBZGtzVMg=
X-Google-Smtp-Source: AMsMyM5ORItwMz8VDKtN780mz5LkE8pwEh5xtrCs0HjkrgOdXkxarj2n4V3w0AnPPRI1+oKRW/V7wQ==
X-Received: by 2002:adf:f701:0:b0:236:e2b2:3b69 with SMTP id r1-20020adff701000000b00236e2b23b69mr27489598wrp.532.1667944591163;
        Tue, 08 Nov 2022 13:56:31 -0800 (PST)
Received: from localhost.localdomain (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.googlemail.com with ESMTPSA id m3-20020a05600c4f4300b003b47b80cec3sm17050256wmq.42.2022.11.08.13.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 13:56:30 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] clk: qcom: clk-krait: fix wrong div2 functions
Date:   Tue,  8 Nov 2022 22:56:25 +0100
Message-Id: <20221108215625.30186-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Currently div2 value is applied to the wrong bits. This is caused by a
bug in the code where the shift is done only for lpl, for anything
else the mask is not shifted to the correct bits.

Fix this by correctly shift if lpl is not supported.

Fixes: 4d7dc77babfe ("clk: qcom: Add support for Krait clocks")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 45da736bd5f4..293a9dfa7151 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -114,6 +114,8 @@ static int krait_div2_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (d->lpl)
 		mask = mask << (d->shift + LPL_SHIFT) | mask << d->shift;
+	else
+		mask <<= d->shift;
 
 	spin_lock_irqsave(&krait_clock_reg_lock, flags);
 	val = krait_get_l2_indirect_reg(d->offset);
-- 
2.37.2

