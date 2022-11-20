Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20B63125C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 04:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKTDDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 22:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKTDDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 22:03:30 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD2B4823;
        Sat, 19 Nov 2022 19:03:28 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a27so5500215qtw.10;
        Sat, 19 Nov 2022 19:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ecmtg8Xz1vo78RX1IEc/ka9eYTVT7RxfN8Rs3E8/0cY=;
        b=g2uGY9p5ZdSLTLsXOhHdUd2vdjxbsAfaQPLrYP/r7kpXa9ON0jSONjY1n+mhNMl/A1
         BtuX3Sr6Cxrz0PnlzAgHXk+HKtbe3NqHDWulqObV5JUY7QSYRd+p55aGqQyX1tGPbNsl
         G1HnKevwRSY2mQo05/1xUVOgTuPtyNfBGQRl9JatpjTQg4HtpvOBcmVOsR5dc0yocEA6
         YK8fujpmscdbONh0IfdPPQMbTGeJNuP+39soAVgVznt33g7+uwoXiDWk8mOdsMAmDIpx
         kDxqfPiOBPVi7rD9K3gUcgldmpzq8nNoNNMvHZofJSDUl7SA6y/fSoErkcOcXkfhw9g4
         ytlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ecmtg8Xz1vo78RX1IEc/ka9eYTVT7RxfN8Rs3E8/0cY=;
        b=uLPXTDbff9QNKC+8eD/WE0IdAGPWtkwex6I3wKjEifDmECavzzm26jlGrKTdcAAS//
         xUrriJGv4VoC2SmmE1bv7c3VYQckAoo+6oatGr2E/97KDkQwa6ao6cFCAesyeVxWfM+e
         1zVJpDDrHQVeQFYxeWL54u5pwx9+yvw7RZB4dc2QD6+CmRgsDbi4hDrTnqAO6vt8+PZr
         QuNGBbDk5JSH2B86lndRrLgktzK4NAP2118wHVMqkxMA4W4DkwfJ636qwO4IvWwrWX8Q
         jlTaP2m4h3uCxcX/b45ycogvEiXaH2FoHUU3OOI1Mb1Y6CvS5HTjeqBrGBCbLb6bUY8j
         OjaQ==
X-Gm-Message-State: ANoB5pmMYv6leJ5Ysb4TSITRYeIK4Hdu0YTVYm1Fg1HH40v6beveRNdG
        wRbjE4xnsqs5nyGJoP99/D4=
X-Google-Smtp-Source: AA0mqf6LQqwRM7kBSkQmtdPhpc0QfAcgBntu0c160jXag+6d6vSVgHQN9+PE7mk+8gHwagCB3zi7Zw==
X-Received: by 2002:ac8:5c03:0:b0:3a5:3979:23f0 with SMTP id i3-20020ac85c03000000b003a5397923f0mr12599783qti.216.1668913407408;
        Sat, 19 Nov 2022 19:03:27 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b0039cc47752casm4522423qtg.77.2022.11.19.19.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 19:03:26 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] clk: lmk04832: fix kernel-doc warnings
Date:   Sat, 19 Nov 2022 22:02:57 -0500
Message-Id: <20221120030257.531153-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
In-Reply-To: <20221120030257.531153-1-liambeguin@gmail.com>
References: <20221120030257.531153-1-liambeguin@gmail.com>
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

Fix syntax generating the following kernel-doc warnings:

drivers/clk/clk-lmk04832.c:189: warning: cannot understand function prototype: 'struct lmk04832_device_info '
drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'pid' not described in 'lmk04832_device_info'
drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'maskrev' not described in 'lmk04832_device_info'
drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'num_channels' not described in 'lmk04832_device_info'
drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'vco0_range' not described in 'lmk04832_device_info'
drivers/clk/clk-lmk04832.c:193: warning: Function parameter or member 'vco1_range' not described in 'lmk04832_device_info'
drivers/clk/clk-lmk04832.c:420: warning: No description found for return value of 'lmk04832_check_vco_ranges'
drivers/clk/clk-lmk04832.c:459: warning: No description found for return value of 'lmk04832_calc_pll2_params'

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/clk/clk-lmk04832.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index 7e01370fb6d4..57485356de4c 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -175,14 +175,14 @@ enum lmk04832_device_types {
 };
 
 /**
- * lmk04832_device_info - Holds static device information that is specific to
- *                        the chip revision
+ * struct lmk04832_device_info - Holds static device information that is
+ *                               specific to the chip revision
  *
- * pid:          Product Identifier
- * maskrev:      IC version identifier
- * num_channels: Number of available output channels (clkout count)
- * vco0_range:   {min, max} of the VCO0 operating range (in MHz)
- * vco1_range:   {min, max} of the VCO1 operating range (in MHz)
+ * @pid:          Product Identifier
+ * @maskrev:      IC version identifier
+ * @num_channels: Number of available output channels (clkout count)
+ * @vco0_range:   {min, max} of the VCO0 operating range (in MHz)
+ * @vco1_range:   {min, max} of the VCO1 operating range (in MHz)
  */
 struct lmk04832_device_info {
 	u16 pid;
@@ -412,7 +412,7 @@ static unsigned long lmk04832_vco_recalc_rate(struct clk_hw *hw,
  * The LMK04832 has 2 internal VCO, each with independent operating ranges.
  * Use the device_info structure to determine which VCO to use based on rate.
  *
- * Returns VCO_MUX value or negative errno.
+ * Returns: VCO_MUX value or negative errno.
  */
 static int lmk04832_check_vco_ranges(struct lmk04832 *lmk, unsigned long rate)
 {
@@ -449,7 +449,7 @@ static int lmk04832_check_vco_ranges(struct lmk04832 *lmk, unsigned long rate)
  *
  *	VCO = OSCin * 2 * PLL2_N * PLL2_P / PLL2_R
  *
- * Returns vco rate or negative errno.
+ * Returns: vco rate or negative errno.
  */
 static long lmk04832_calc_pll2_params(unsigned long prate, unsigned long rate,
 				      unsigned int *n, unsigned int *p,
-- 
2.37.1.223.g6a475b71f8c4

