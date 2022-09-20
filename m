Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5488B5BF028
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiITWaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiITW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:29:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19D6193D0;
        Tue, 20 Sep 2022 15:29:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id v1so97476ilq.1;
        Tue, 20 Sep 2022 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IsAY5Uo5fDObS9RzecYH3SXOEEVbvv/Ubv7Rcm4k0lo=;
        b=kF6yUboWGeZiaD+NaLksG94RjMC7NqAQ5zhGBBf/N7P1VOc/EoxTR4VZ8mvIHTG7B7
         XB31W2QF5sSEaf/p6W2Z9W1KmqpU3d4OVsV7YlYG0KaBkEPPdgNA4CNOZ+He2USVfJ7l
         jvIUTT7M0BwlYXjJWuc0YL81XK9BvQWorML1jShuuT8XQkfNGsN/fK24QuHJpy3+U3HA
         UY7BoIp/V5Mqhd8Y1Xfb/vLCnswbxBA0ovCEmbHd9YVBCdO3n80tYiVyaB7HLCkb3cZw
         5vHx8VOPg9OYkWkdlw6jHml4CEGhVXZWJINPpygjDHkHwUKHN1dbthHJ07jxMdFWan96
         +VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IsAY5Uo5fDObS9RzecYH3SXOEEVbvv/Ubv7Rcm4k0lo=;
        b=pBimZp1pr51rr4cNp7GWAL+wMmF8omIcZBCUxpWzs9zUMlqivS9jDNLOCnKAfjNTld
         Of4CiU4pPpFd2A81Sj8r4DsclRdZnDMtzMfDfBoWBSnsg4G9evfSFrtX/Zsoc7O7bcdq
         XdNaEVzp0PHxjQPoUNuvOoalOWLGm+hUQKab4pljbd0pr8a7KdZmjxklusHuAK0Qr6dW
         RfkeFGV9D2ZRy7gMvYRZxffSyTZyUFVO4QTGVkHuU8lsZuayGMjJhllrL+gtjNVN/7ha
         uotpDcE/qi/O2u8GjQZ3vWjvNlvJaO9Qz5sqrdg0edu1bIdDJCF7ksOr8pRxCIyzugTN
         Nntg==
X-Gm-Message-State: ACrzQf13lUO4sCPkzJwGhVGOpIKiOechQfaywOBZKGlrtDcm3CwAzADp
        sIUecqZSm2xVGED/WrIeMeuyLzJeORs=
X-Google-Smtp-Source: AMsMyM48oeG0rQgjmTE+qios6zV3XacotpQ0dH5oGHh9yjzuOouFUVRx1gAg1TdnXwJhjecRjh97yQ==
X-Received: by 2002:a92:da4b:0:b0:2f1:525a:90e7 with SMTP id p11-20020a92da4b000000b002f1525a90e7mr10817197ilq.307.1663712992078;
        Tue, 20 Sep 2022 15:29:52 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::a533])
        by smtp.gmail.com with UTF8SMTPSA id r8-20020a02c6c8000000b0034286300316sm361448jan.166.2022.09.20.15.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 15:29:51 -0700 (PDT)
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
Subject: [PATCH v4 2/3] pinctrl: qcom: add support for complementary reserved gpios
Date:   Tue, 20 Sep 2022 18:29:38 -0400
Message-Id: <20220920222939.150330-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920222939.150330-1-mailingradian@gmail.com>
References: <20220920222939.150330-1-mailingradian@gmail.com>
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

