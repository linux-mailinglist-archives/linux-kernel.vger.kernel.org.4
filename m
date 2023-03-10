Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE166B381D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCJIIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCJIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:08:01 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFDF4018
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:07:18 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so8179077pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678435621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgAEq2s7iMlbLDxdNRhT9lNYrm8LggtjQqPTG8eY/FE=;
        b=DZhcMW1fEDrbIYeXA6hBDwWykDnCGQmiS5/tpSuR38yKQQUV/fl2YVYMpla0ewtyDa
         MrcswTApW1pTBeDqroTw9jkItVjOtuGBMDt183ddiz32QP9liAYss8s1ekJ7iFbmgn2S
         ZfJcB729GNNhAxN4FXG4XPnYWtqyuPRYu0kT5yyAL0AJiHBIAqXxNOOmxhs9cwg69vpE
         OxevCu/Vj9aKZeaUEFy/eeO3vRRkz0ufrCMKVAUSXhQqFWWYi8r3gVz3ppyLz4hYBXt2
         lJNIoB5MXRA+fOyEwc0Uvd/qXEXdiZtH4li26bfDqm/FnFytqnLGpRX3ZL08deyKPm/H
         tl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678435621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgAEq2s7iMlbLDxdNRhT9lNYrm8LggtjQqPTG8eY/FE=;
        b=xr4a6onhdvwkygWN6WS4vEUWT0Oc3WhobJW4YHDqJSnh0UIwaRkw9NSHJwq4F9M8NZ
         uSUK2v7sPiP6ykKHO49ZEYTTX+16XSDRz63U4cB55rbsHmyZo9h17WaqvvU/qX09+nJE
         YTs7crqo2SF/iQwbEdV6K/yPZuzXj2KT4DeoGj2GuWmM51mThZSTXs5pc+pW2bXa6rsH
         X0zb6m68kOGXGl3XDnuu+o7jifV0h1VoFE3eTuOTqFsuBkPQe5z6AY/0e0f6FC708izz
         lqxshMXYC9GLulL6yZOwl85FLm1L9icW1d4OVhWuLm+EsTr70ygarsPSWa+4u9wId6vi
         vw+A==
X-Gm-Message-State: AO0yUKVGpPLZuQynokOadvuaRrP1vhFjAJMcFXzsXc54oSpPoXtTk3Lh
        q1lrOZIopptVBdb1lswwhDfndvcH1o3zuQ==
X-Google-Smtp-Source: AK7set/RzZBwkpuAlDo9eTtYVvzCQzENiI5KELozchIm6TwKX2V7RgRD6y4IFUtro9JJapJyM0cr1Q==
X-Received: by 2002:a05:6a20:6914:b0:cd:fc47:dd73 with SMTP id q20-20020a056a20691400b000cdfc47dd73mr5472406pzj.2.1678435621339;
        Fri, 10 Mar 2023 00:07:01 -0800 (PST)
Received: from uu22.. ([137.184.7.236])
        by smtp.gmail.com with ESMTPSA id n65-20020a634044000000b0050300a7c8c2sm759980pga.89.2023.03.10.00.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 00:07:01 -0800 (PST)
From:   huyinhao <huyinhaodd@gmail.com>
X-Google-Original-From: huyinhao <dddddd@hust.edu.cn>
To:     joel@jms.id.au
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyinhao <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH] drivers: soc: fix dead code in aspeed_lpc_snoop_config_irq
Date:   Fri, 10 Mar 2023 16:06:30 +0800
Message-Id: <20230310080630.1021959-1-dddddd@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
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

From the comment of platform_get_irq, it only returns non-zero IRQ
number and negative error number, other than zero.

Fix this if condition when platform_get_irq returns a negative
error number.

Signed-off-by: huyinhao <dddddd@hust.edu.cn>
Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8dfbeb..c4a03b3a5cf8 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -167,8 +167,8 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
-		return -ENODEV;
+	if (lpc_snoop->irq < 0)
+		return lpc_snoop->irq;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
 			      aspeed_lpc_snoop_irq, IRQF_SHARED,
-- 
2.34.1

