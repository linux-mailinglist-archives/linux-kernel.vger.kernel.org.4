Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C096A8ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCBUuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCBUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:50:43 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA089100
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:50:41 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bj30so221827oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 12:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1677790241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOc++n2L0f0xB181spyzmZCpRYCJrprxU4ITd13vOYU=;
        b=WhUXHGR/ArIIxPrVZMgKWLucuSEyc5cbQ6Xktv1nsIyGKvwemcWMA31LhCp8e6pnPb
         NpYk+IF1izdZCIkGaciKcreFzhWjMSUXKZfadv+4CzRRJmk54zd+TD7NkN5qf2DPnsYE
         VCxDgcHrDBHVrK+4K6jn5yH4QaE+hAwI3ZCSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677790241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOc++n2L0f0xB181spyzmZCpRYCJrprxU4ITd13vOYU=;
        b=7y0iRhZ2mEOCpPE4zY5AyKDD9chZ7ltHexDxZOUTF/TCgazRsJJHtefiVqHLC3xBjU
         JmZP0HFk9AzmZIU8ccdSCUskerr4epoYqduM1D2jpmBsj24AC+VndNd26WbcbDsyHYHk
         qrA1ODeg5taktQLkf3rHAYqPnb69H63hznEMk8T+aImd4nyvH/QjhlvQCzotzeCwXUYr
         BAdEUzJo5WZj36CIXkGCc+htbComx2Uq4cAcJarORCuc00qUTcjJmXGhbZfeSM2O536P
         cdRC3UKDX7jYFACVIDvtl22z7tAimyMVRtsUwFbTzmsBCA1mR2kg9OD2KVKDcvRVZP5G
         kDFA==
X-Gm-Message-State: AO0yUKVgmOW6n4wPFe3ZN0ElP/K0yLJeUyLcramCrv+3EJ7nJshbpClQ
        W86NluXjjtcyMp/5MW+m8xn+3B838sOV07KpnUs=
X-Google-Smtp-Source: AK7set+i0tziWtCp1HSzqwlVl2wNo+KJ3lOgxv82aNICcUu83MKsIIf/K014eWcx/WuvPjj2dD9hHQ==
X-Received: by 2002:aca:f0a:0:b0:35e:b863:1cfc with SMTP id 10-20020aca0f0a000000b0035eb8631cfcmr1816520oip.26.1677790240870;
        Thu, 02 Mar 2023 12:50:40 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-87-2-94-251.retail.telecomitalia.it. [87.2.94.251])
        by smtp.gmail.com with ESMTPSA id k124-20020aca3d82000000b00383e12e20c5sm104729oia.24.2023.03.02.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:50:40 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RESEND PATCH] clk: visconti: remove unused visconti_pll_provider::regmap
Date:   Thu,  2 Mar 2023 21:50:28 +0100
Message-Id: <20230302205028.2539197-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Field regmap of struct visconti_pll_provider is never used. Remove it.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/clk/visconti/pll.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/visconti/pll.h b/drivers/clk/visconti/pll.h
index 16dae35ab370..01d07f1bf01b 100644
--- a/drivers/clk/visconti/pll.h
+++ b/drivers/clk/visconti/pll.h
@@ -15,7 +15,6 @@
 
 struct visconti_pll_provider {
 	void __iomem *reg_base;
-	struct regmap *regmap;
 	struct clk_hw_onecell_data clk_data;
 	struct device_node *node;
 };
-- 
2.32.0

