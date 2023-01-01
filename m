Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4865AADA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjAAR54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjAAR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:57:53 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE4C26F4
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:57:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so62201802ejm.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DfiqceF+LdTWM6vdUk9wI6D8zoODeFMSPagFkfVzoU=;
        b=AIzTs2vSaEXUe50V8v8kYmMn59yf7UAHUi9pIpYv41LR+iQIclW+UFLOhHAEB+y6Y8
         9sFAuLlFjgcX/LhclHOoZ7UyRzmOOeZrHz+LsmYXNCGFArw2olR9eBo8wBfsunrR8wHo
         YHNaQSYyh22BzSnNaIiJCfiHb/gjA8yayO8Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DfiqceF+LdTWM6vdUk9wI6D8zoODeFMSPagFkfVzoU=;
        b=k4oEr16tSKBggmb65QOXh4J0Pkdk7J0hMbBiY7UxFwgnBnaA5RhAfUykI3nICWy+QX
         Z0m2FX0Lk/hVwERd3qPenCZHKIplgeVuyo9xa4klS7dRSUheknDpQMOWZr5v/E9Yoaj1
         jl/3RIU8brzRsMtD0radj0TyRDFXGp2XWBeY8PHm5ZXT3hwJ3PThPVrLhGMCbjVYFyuq
         c7NWZc1JmsjxSLW0EtrqOHFINgBuxrqkOwBfVKjO561xzjzt0+Xhvy37RWbvyp80S733
         LGYT+ouCw1WvFJC6YTE4eoRrpnXdj0TF9m+cgAh0DKtr3Ow5qUAeRajvK6LQU+6XYbdJ
         riCA==
X-Gm-Message-State: AFqh2krjAvOwIKjy9HkxJAAOuVVfs/ZAXf/ruBgrXAtSFWm/pMaMhnE0
        dOPsPfIPlsyP4ZfNVZF0Pq1uR95hr76pMdsGaMQ=
X-Google-Smtp-Source: AMrXdXsnEdz5bkXfRjqLPgmbJqUuZyYoOm7/8/fl3R00EA2q24xQMz0r/XGmVZ+40Z6ba8q/ljkABg==
X-Received: by 2002:a17:906:5048:b0:7c0:b770:df94 with SMTP id e8-20020a170906504800b007c0b770df94mr33606021ejk.63.1672595868343;
        Sun, 01 Jan 2023 09:57:48 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:57:48 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH v2 01/11] clk: imx: add structure to extend register accesses
Date:   Sun,  1 Jan 2023 18:57:30 +0100
Message-Id: <20230101175740.1010258-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
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

The imx_clk_reg structure allows accessing both registers that belong to
specific modules and those that are registered in syscon through the use
of the regmap API.
This is a preparation patch for the upcoming support to setup clocks
directly from the device tree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 689b3ad927c0..86538c990a0d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -89,6 +89,18 @@ struct imx_fracn_gppll_clk {
 	int flags;
 };
 
+/**
+ * struct imx_clk_reg - imx register declaration
+ * @base: the register base address
+ * @regmap: the register map
+ * @offset: the offset within @base or @regmap
+ */
+struct imx_clk_reg {
+	void __iomem *base;
+	struct regmap *regmap;
+	u16 offset;
+};
+
 struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
 				   const struct imx_fracn_gppll_clk *pll_clk);
 
-- 
2.32.0

