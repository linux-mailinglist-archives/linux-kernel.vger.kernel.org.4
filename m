Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C346627176
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 19:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiKMSHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 13:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiKMSHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 13:07:25 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8DF11A3A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:24 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id 13so23468960ejn.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywf6b+IbFOVLTjHv9G0JoUs4QJxVF9RbJDvY4hkSgIA=;
        b=hin9Lr5Joe5vd3olZvvUG7/wpSBZyrBXwsfzX6islosOI+AFu0EcoNnJ7sxEGWAwpQ
         OE+O8tdQNc87u3kdB57YvH05emhmk1ZJRl1gQT0GCLXNJZT3Mun+g1/EgWDxMzb5YIhB
         nm3bai4xCptl7uW/7jpUWCMWZaPhsdymxzqg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ywf6b+IbFOVLTjHv9G0JoUs4QJxVF9RbJDvY4hkSgIA=;
        b=YYGe7df+c6lDEtQhUvPR/Z0azLGSJPWOItq8GxktX9kaE3HuDDyFWdfOvABKYOWop0
         TbBxwYjQMT6bx/3LH8/r7918pFnf81hYhdT8nzo9IZfV9IjDVKZ0RMKso8XfDDuIClzR
         U59fDgAak44CxH2+GsanEGx+BpYcdaebK6CH3K4XNWA67MnJl6QbG0o4R1WMLchNCsRG
         fYXLX3A4A5EuEwBU02Ht3wYtwrha+t29sJG5NrL1YxRVzwzanVUVLBdlusCYBDxo6ty9
         u2K6wA68pJGfDvM0Ou/10pwxHa2RouMCDPoBsD5x6EXyiZ/UKabtxKgsPSVRekqDZ5aJ
         BPOg==
X-Gm-Message-State: ANoB5pnG2oH+hrdeOaJ5hCw8tXd79bW7Rd1tsLMYJA8UsGYek+vRDJqF
        vDzPOmLXRbinFFbtBkntReTteig5zpj1eA==
X-Google-Smtp-Source: AA0mqf5/5Lt0K9H+vpsJNjdcN/7weKL30uW/Mr4Sjk61dOE7gBRDMSYHcHTgHTZ6IFoazAgvOeEB4Q==
X-Received: by 2002:a17:906:bc42:b0:78d:7a4c:13ea with SMTP id s2-20020a170906bc4200b0078d7a4c13eamr8130192ejv.471.1668362842656;
        Sun, 13 Nov 2022 10:07:22 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-103-33.business.telecomitalia.it. [79.40.103.33])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906118b00b007a8de84ce36sm3171058eja.206.2022.11.13.10.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 10:07:22 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 4/5] clk: imx8mn: fix imx8mn_sai2_sels clocks list
Date:   Sun, 13 Nov 2022 19:07:09 +0100
Message-Id: <20221113180710.1625410-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
References: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
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

According to the "Clock Root" table of the reference manual (document
IMX8MNRM Rev 2, 07/2022):

     Clock Root     offset     Source Select (CCM_TARGET_ROOTn[MUX])
        ...          ...                    ...
   SAI2_CLK_ROOT    0xA600            000 - 24M_REF_CLK
                                      001 - AUDIO_PLL1_CLK
                                      010 - AUDIO_PLL2_CLK
                                      011 - VIDEO_PLL_CLK
                                      100 - SYSTEM_PLL1_DIV6
                                      110 - EXT_CLK_2
                                      111 - EXT_CLK_3
        ...          ...                    ...

while the imx8mn_sai2_sels list contained clk_ext3 and clk_ext4 for
source select bits 110b and 111b.

Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/clk/imx/clk-imx8mn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index b80af5d1ef46..37128c35198d 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -109,7 +109,7 @@ static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll_out"
 
 static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
 						"video_pll_out", "sys_pll1_133m", "dummy",
-						"clk_ext3", "clk_ext4", };
+						"clk_ext2", "clk_ext3", };
 
 static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
 						"video_pll_out", "sys_pll1_133m", "dummy",
-- 
2.32.0

