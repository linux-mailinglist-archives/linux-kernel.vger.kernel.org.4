Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2C372CDD7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjFLSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbjFLSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E5E0;
        Mon, 12 Jun 2023 11:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B86862CC9;
        Mon, 12 Jun 2023 18:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B7CC433D2;
        Mon, 12 Jun 2023 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686594214;
        bh=0ia4DOXRQlpxbsvixuJZP92w3Mu5z3zc9q4s1AOUnDc=;
        h=From:To:Cc:Subject:Date:From;
        b=iQqK/iw2pw+Igfn7d9j8xQ8+HbK07/0/uCJLT6erT9jqHOqpdOn9NLk+g8CuYNCIp
         zRILIyb9jt7Um7NA0jf1/018qJ4cHKP1K1XrZ0Bkgo/LsXFh9e0Uvq+r19R+DXvCup
         Dlcnn1YvVWcA2gELwVl+8UOR4Ha3nbFT1G5z2KMXTcqYdypN1w06bu4jkz/HXT+8bh
         UbUnn6HR8NBceZEsdxxBIOr06jf6DxbTAUE8ggsN3wHzYYBRY8mvHuHSLYB1DjqtDf
         9qxjQrPiAmiq+t55MDSRr7UVJm2Yew0Zu7NhzEaNSwwz5YDeWt5UcMFZZNcKZCMIIH
         5lpIh0hQ4acuA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Jian Hu <jian.hu@amlogic.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] clk: meson: a1: Staticize rtc clk
Date:   Mon, 12 Jun 2023 11:23:32 -0700
Message-ID: <20230612182332.371003-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse rightly complains that this symbol is supposed to be static.

Cc: Jian Hu <jian.hu@amlogic.com>
Cc: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Fixes: 84af914404db ("clk: meson: a1: add Amlogic A1 Peripherals clock controller driver")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/meson/a1-peripherals.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
index b320134fefeb..75dfae210fe5 100644
--- a/drivers/clk/meson/a1-peripherals.c
+++ b/drivers/clk/meson/a1-peripherals.c
@@ -218,7 +218,7 @@ static struct clk_regmap rtc_32k_sel = {
 	},
 };
 
-struct clk_regmap rtc = {
+static struct clk_regmap rtc = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = RTC_BY_OSCIN_CTRL0,
 		.bit_idx = 30,
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

