Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF95F1FA9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 23:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJAVHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 17:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJAVHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 17:07:35 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D8260F8;
        Sat,  1 Oct 2022 14:07:34 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a4so3762568ilj.8;
        Sat, 01 Oct 2022 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IsAY5Uo5fDObS9RzecYH3SXOEEVbvv/Ubv7Rcm4k0lo=;
        b=fojKoLrX6ZfpgNmnMY3yEC85FsT1ZjQI71IliFadtXLvKtFMCCRK5avutHyNAzzA7a
         ohiMismhwSvlBcDAqxI3swnFCZ3gBwCZInV4TfEwFFOpmfPKSIOtT55fZJNRUK0IOX98
         qdSivtL6OkQ8TJm8Npqkjxz5YUB1wJlQGA51enpTi1lg+uccSOXrBzTD63D4cQSbk2hX
         HQMkbsUKQF4fOxLohN5VPV+e658HcJhpIGZ0kdKt+Ox5FkejHuyH78ZCd5PmMbE17QhF
         oXGgyjjFemV96ANfOSDYBr0d3mmtfx2NW64+3DTuVHchDgPBnmGaS3A9UB0nwOiWiSCl
         vSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IsAY5Uo5fDObS9RzecYH3SXOEEVbvv/Ubv7Rcm4k0lo=;
        b=UV4Hav6J6h+pBQxdye40tQdVQT3jK6q1y7gUUSX1Gr3c9bVXFuasO9tnrpNM+eqbNg
         It6mekw23IjPmkpL2XaTWsr1qxr5rBnftrxTcjArv4Hs5yXb7e8S/p3MGOVZI21qZy3x
         QQvqTdCT2IydY+fDHG6kbWqRn70mVSMNTtIBJq29U7tPqZVdLOffEjoTJUFI4xpfDRNW
         cZoytFwLQLdXrFc7+sRyhL/ogNgdCbD0utEOO2e9rTPGOlPMB26Zs29tBrRyckxT2roS
         mPzpeA4hMp09fSSzdav0dhZ4FfoTTxYXi4NodlhN+enivvi34jBXkwP1QUBhaKTmA4A/
         i/XQ==
X-Gm-Message-State: ACrzQf2hjg1swjSHp0qqE68vAHBc6M13i2BU5twQNZ75sa/fCjomk5C9
        a6p2CzQOnf6qkwGvGormj3//Xt/mtwQPnA==
X-Google-Smtp-Source: AMsMyM4T78QDgC4u1ydAysq6v4Lg+8Hz+LbzAh1ZBfib27pUamf4mt9EiryXtryZlMt543ZbTO5rTQ==
X-Received: by 2002:a05:6e02:180c:b0:2f8:5d3c:c436 with SMTP id a12-20020a056e02180c00b002f85d3cc436mr6594163ilv.162.1664658453558;
        Sat, 01 Oct 2022 14:07:33 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id n9-20020a056638110900b0034ac4b215c3sm2399744jal.102.2022.10.01.14.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:07:33 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v6 2/3] pinctrl: qcom: add support for complementary reserved gpios
Date:   Sat,  1 Oct 2022 17:07:24 -0400
Message-Id: <20221001210725.60967-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001210725.60967-1-mailingradian@gmail.com>
References: <20221001210725.60967-1-mailingradian@gmail.com>
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

The driver-provided list of reserved gpios normally overrides any valid
ranges provided by the firmware (device tree and ACPI). When the driver
defines dummy pingroups by itself, it should mark these as invalid but
should not prevent the firmware from specifying more reserved gpios. Let
pinctrl drivers indicate that the reserved gpios list complements instead
of overrides other lists from firmware.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 5 +++--
 drivers/pinctrl/qcom/pinctrl-msm.h | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2abfe987ab1..cea1d2af8c88 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -687,9 +687,10 @@ static int msm_gpio_init_valid_mask(struct gpio_chip *gc,
 	const int *reserved = pctrl->soc->reserved_gpios;
 	u16 *tmp;
 
-	/* Driver provided reserved list overrides DT and ACPI */
+	/* Driver provided reserved list overrides DT and ACPI by default */
 	if (reserved) {
-		bitmap_fill(valid_mask, ngpios);
+		if (!pctrl->soc->complement_fw_gpio_ranges)
+			bitmap_fill(valid_mask, ngpios);
 		for (i = 0; reserved[i] >= 0; i++) {
 			if (i >= ngpios || reserved[i] >= ngpios) {
 				dev_err(pctrl->dev, "invalid list of reserved GPIOs\n");
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index dd0d949f7a9e..734fe7b2a472 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -128,6 +128,9 @@ struct msm_gpio_wakeirq_map {
  *              function number for eGPIO and any time we see that function
  *              number used we'll treat it as a request to mux away from
  *              our TLMM towards another owner.
+ * @complement_fw_gpio_ranges: If true, the reserved gpios list from the
+ *                             driver will not override the reserved gpios
+ *                             list from the firmware.
  */
 struct msm_pinctrl_soc_data {
 	const struct pinctrl_pin_desc *pins;
@@ -146,6 +149,7 @@ struct msm_pinctrl_soc_data {
 	bool wakeirq_dual_edge_errata;
 	unsigned int gpio_func;
 	unsigned int egpio_func;
+	bool complement_fw_gpio_ranges;
 };
 
 extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
-- 
2.37.3

