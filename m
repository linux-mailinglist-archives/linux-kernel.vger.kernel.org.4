Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6506C62D984
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiKQLhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbiKQLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:36:48 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFF96A690
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f7so2107387edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5n89bNftvboEAVMXJ3mXkBUp/+egXvwFtqhI+l+Yrhg=;
        b=LwTHOR/e6UsL0qvDqKfYzZF8rhijfI/1z9hjlJs9jskIsV7PO/SX4Bag1gRZb2CFG9
         UYQLbHsuEHSsUuoI1DanZNzc/rYAcyFmjeDMSKy5qMZpTgrNsFyknnOHqJnNcX8Ms85+
         F48rET3GLypNDLOaMcnUHzrBYyhQ063Wqjih8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5n89bNftvboEAVMXJ3mXkBUp/+egXvwFtqhI+l+Yrhg=;
        b=LTD9WScFy3bAhFJJvtv8P14nXWRNRFAlzgPul1WdWsw3vdicQ4Q4LL1Wg4ZOGqmibr
         W2n7fzJCyCXdJ1qqIu1abyFhjdMM2Q4Vi+1dB4ddMumSX5IEcvlzHvJshqi+col3Fy4V
         AeHpXnCkk4RHirtQJJxV03aXuvVgC+hcDJGQWBxJ+OpoF+B6j2kpRZR/zki0+97Px+RG
         A+3IFMeauR40phZN9ieaMALTrsuEOJuguNVuUyIq22mP0M02PqV4m2YyXL1kLCrOJ2Tt
         7Shm1h8wX2syXdMpT0ytidYt3agytEnVEnb7RcaByoBVHx41G1iB5hUo4+DpjUfOzNY9
         Z45Q==
X-Gm-Message-State: ANoB5pmJQ2rhi/7xlQv92KIHiF2ElF3eq0Z1Fd22iEUaUGuJzvAqNudF
        /zyeoMj3gktCOiA8nHj5jet4LW7OYIV7mg==
X-Google-Smtp-Source: AA0mqf4YXBXOnH9OsK0TZEMc2PMrRe/jO9oOYIzciaRSm9223UfIZ4ifnE+9p2O77EQgbOCY8uqxKg==
X-Received: by 2002:aa7:c9cd:0:b0:461:891a:8162 with SMTP id i13-20020aa7c9cd000000b00461891a8162mr1721324edt.398.1668685003881;
        Thu, 17 Nov 2022 03:36:43 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (mob-5-90-137-239.net.vodafone.it. [5.90.137.239])
        by smtp.gmail.com with ESMTPSA id g3-20020aa7c843000000b0043bbb3535d6sm413897edt.66.2022.11.17.03.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:36:43 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 0/5] clk: imx8mn: miscellaneous cleanups and bug fixes
Date:   Thu, 17 Nov 2022 12:36:32 +0100
Message-Id: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
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

This series has been tested on the BSH SystemMaster (SMM) S2 board.

Changes in v2:
- Update the commit message.
- Add Fixes tag.
- Maintain IMX8MN_VPU_* constants to not break backward compatibility.
- Update the commit message.
- Add Fixes tag.
- Maintain IMX8MN_VIDEO_PLL1* constants to not break backward
  compatibility.

Dario Binacchi (5):
  clk: imx8mn: rename vpu_pll to m7_alt_pll
  clk: imx: replace osc_hdmi with dummy
  clk: imx: rename video_pll1 to video_pll
  clk: imx8mn: fix imx8mn_sai2_sels clocks list
  clk: imx8mn: fix imx8mn_enet_phy_sels clocks list

 drivers/clk/imx/clk-imx8mn.c             | 116 +++++++++++------------
 include/dt-bindings/clock/imx8mn-clock.h |  24 +++--
 2 files changed, 74 insertions(+), 66 deletions(-)

-- 
2.32.0

