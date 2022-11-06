Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED561E34E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKFP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiKFP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:56:33 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2064F584
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:56:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f5so24437946ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 07:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOHosJl9lkO1Iv3ZimhOShlhVXlpDYR4N2IHLcu5P0Y=;
        b=eEWvvSqFdIfw1AlpUpWg7apUAXPXxrk3PyeREO3P4PDBezBARfCDSN6CFEK8Ir1FLG
         T7QEKAUp2uNCfWCF6XK8SDTliZwMwiPFNylYwfm9vdvUsdP+29vIikbVd1IUmF2a3VYc
         apRB2DxJOXM3F/yxO8f4Wgw7msSgYW2ZyZW88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOHosJl9lkO1Iv3ZimhOShlhVXlpDYR4N2IHLcu5P0Y=;
        b=oX5ri0s/Kk38PSw8YluiolzYIzbafjygrgwLQzGJXlJWJVlW1bzX6wx/Rfel1PpTXL
         CO/NGtYGuBW1pC68HhEkH+xHqJV4SP4fwq1TJ/HFBx9VowZxhh9qPKevA2Ah7h0P1Hc8
         2K21+S77HVF3ktWHIhaxj/iNgu34sKrlQYamYJ7c46jxB980MOY+BJ+lY2AF9o4JRSif
         k1m4IcC0VYNEwABBe6j6pKF4XhpOqzuExKiX9rkpca+JwPFMxY9Sz+5/ZOop0JP2PTPL
         wg/UdV5quj0CEnOv0ulW6m1UQruT34WFKQlv+wO1Jm7gDWcZsikeJnTy27YyLtENGUzk
         JssQ==
X-Gm-Message-State: ACrzQf1XcFgFgKYxkw3TylJF3ZWb4KWvUS+n25/l9bNUlIKZXRvvsThB
        x8WiV3kFzftMbyOqT02Ww07YAQSFYqPipA==
X-Google-Smtp-Source: AMsMyM6gD4uBb0fok1qavZTLp/aAQ2Cq5WrylG0Q1BxAc22kYvBoeZdPCU9pK4SL1bQU9o30kM75Ng==
X-Received: by 2002:a17:907:7613:b0:7ae:4969:4540 with SMTP id jx19-20020a170907761300b007ae49694540mr7664648ejc.498.1667750190055;
        Sun, 06 Nov 2022 07:56:30 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-76-31.retail.telecomitalia.it. [95.232.76.31])
        by smtp.gmail.com with ESMTPSA id m19-20020aa7c493000000b00458dc7e8ecasm2823435edq.72.2022.11.06.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 07:56:29 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang He <windhl@126.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH] clk: ti: fix typo in ti_clk_retry_init() code comment
Date:   Sun,  6 Nov 2022 16:56:25 +0100
Message-Id: <20221106155625.3476564-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "not" with "node".

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/ti/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 1dc2f15fb75b..40ddd73b2bc5 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -263,7 +263,7 @@ static LIST_HEAD(retry_list);
 
 /**
  * ti_clk_retry_init - retries a failed clock init at later phase
- * @node: device not for the clock
+ * @node: device node for the clock
  * @user: user data pointer
  * @func: init function to be called for the clock
  *
-- 
2.32.0

