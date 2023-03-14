Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5436B88B6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCNCpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCNCpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:45:01 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839928ABC4;
        Mon, 13 Mar 2023 19:44:59 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id a13so1577242ilr.9;
        Mon, 13 Mar 2023 19:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678761898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uL9K160y/sGe6aJSZRSqc6tSWBuvSQu9o5Le2ydkv3U=;
        b=lxySSmNObprtDRo5tCy4GeJ+tbgiAN5HwlW4ZBow7bReCFWOKrhwK/7xuqnwCjN8nL
         SPw07sc5SHYJT5J8WIjXYjM1Tbrq71vymSPESabbrGcQ8nD+hpAZrodg+aXu6ZJc7apl
         Ll20WYHiEuPLd09Tu7iBM2XujLmyumxNzGx7KpJACzh3Va5Q8SnzCkft+O5JJLTbc91V
         T3wDnnMTAAnP4T2W/tmDAtSDRRocDLKEzLW1nvOOmvxh79iRcsTYXaPC733Dzqafzi/a
         sjS/s6YspRRCdPPHbM7hgQXDvnrjXMHOayt9meY3VaE6PDbHMPGycOsajuFD2F5Wcl2F
         5V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678761898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uL9K160y/sGe6aJSZRSqc6tSWBuvSQu9o5Le2ydkv3U=;
        b=5+/vvJbTCIUKMfgQt/xluBo5gsQQdZfaOS0HxVEePN3BaV6w7jvj0Vl5+g7YARGLyA
         i8CxESwWCtiBhphpp6TWf3uvyNPs4q3EKx7B+V8m7XdpiV8UaAfYqeJOFKb6q+S2qNFd
         miq3zCj19tbFkpnaeAdrPtDGXtMYVwMEctEeT+o2EOX18J8izXd9tB0XTHeQnakkgMpo
         cM2x97ey5wz85a57w+OoxmN/Mm5J5c3LlaVYCXKcXYzfZkj6kr+pzjzDz2WyWkxCrWcL
         ipA82OzDWKZBRmYJGSlRYzjNSYnghBgZ+M/Yoxe8KFkznSvqJhqcNIod4UufZ12yJCGd
         clyA==
X-Gm-Message-State: AO0yUKXm6b9Qb6yRzGINEaTvJGHg+HHRUhGMc5G1iERUIFj5XNBgMoi+
        A2/UuEsL/gykjeDF/oUhTYEtm8g2bZk=
X-Google-Smtp-Source: AK7set89TywbWImMZQTYoKaekvnwnBXYL3FZ90VeUeTdQCi5/3wo8Avs1WaTK9DVARNWmpN1Kw1JFg==
X-Received: by 2002:a92:330b:0:b0:323:891:6f3a with SMTP id a11-20020a92330b000000b0032308916f3amr990011ilf.4.1678761898378;
        Mon, 13 Mar 2023 19:44:58 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:897f:c3af:15e4:6ad0:548])
        by smtp.gmail.com with ESMTPSA id s13-20020a92cc0d000000b00323094e480dsm457499ilp.7.2023.03.13.19.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 19:44:57 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     peng.fan@nxp.com, l.stach@pengutronix.de,
        Adam Ford <aford173@gmail.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC] clk: imx: Let IMX8MN_CLK_DISP_PIXEL set parent rate
Date:   Mon, 13 Mar 2023 21:44:49 -0500
Message-Id: <20230314024449.50151-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the display pixel clock needs to be evenly divide
down from 594MHz which rules out a significant number of
resolution and refresh rates.
The current clock tree looks something like:

 video_pll                594000000
  video_pll_bypass        594000000
   video_pll_out          594000000
    disp_pixel            148500000
     disp_pixel_clk       148500000

To enable CLK_SET_RATE_PARENT on disp_pixel, a helper function
needs to be added called imx8m_clk_hw_composite_flags which
can pass the additional flag to the clock controller. Letting
disp_pixel set video_pll_out rate should actually lower the
clock rates of video_pll_bypass and video_pll as well, since
those clocks are already configured to enable CLK_SET_RATE_PARENT.

Signed-off-by: Adam Ford <aford173@gmail.com>
---

This is an RFC, because even with this patch, the video_pll_out clock
does not drop to 148500000 like I would expect.  The video_pll clock
is a fractional pll, so it should be able to generate a significant
number of optional clock frequencies to facilitate video.

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index af256ade554f..a116cc40d7d0 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -470,7 +470,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000);
 	hws[IMX8MN_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mn_dram_apb_sels, base + 0xa080);
 
-	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500);
+	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite_flags("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500, CLK_SET_RATE_PARENT);
 	hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
 	hws[IMX8MN_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mn_sai3_sels, base + 0xa680);
 	hws[IMX8MN_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mn_sai5_sels, base + 0xa780);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 689b3ad927c0..9977b512845b 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -414,6 +414,10 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT)
 
+#define imx8m_clk_hw_composite_flags(name, parent_names, reg, flags) \
+	_imx8m_clk_hw_composite(name, parent_names, reg, \
+			0, IMX_COMPOSITE_CLK_FLAGS_DEFAULT |  flags)
+
 #define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
 	_imx8m_clk_hw_composite(name, parent_names, reg, \
 			0, IMX_COMPOSITE_CLK_FLAGS_CRITICAL)
-- 
2.37.2

