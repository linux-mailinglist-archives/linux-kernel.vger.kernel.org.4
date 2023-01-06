Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767D965FFB8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjAFLor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjAFLol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:44:41 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825D728AE;
        Fri,  6 Jan 2023 03:44:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id y25so1605594lfa.9;
        Fri, 06 Jan 2023 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGXbQDgVE0UpM54kZDE3FWO38LNW+xtw1R1SGBRDg1g=;
        b=YsTNByG+CwDkfZkmwptl1UPf1jKLfs+A8yjolRN49Isf/pKhKSe8627hD1XSuycUXP
         OVYH2kPuQBlcybz0+ovsyO6EaPbWBSF9Xv3Ia5vZz+E05Hk65qNRoY+z+rpg+4Wotd8t
         x9GR9vOmNqzBRFFB9UwFgQvpx9vMkJXp/V8fgfcVyEjXd+n4xBWpypGpD3avMM2fFutW
         ti/qPpGHnEzuRt1Htisrkhq2xN1a2swO57Kto3Pkd4IB39xFVrk+V1LuyPVjG3ewKOfC
         zPZcRQqa09k9ZeSSpeIcJPtGSJd5zWHVY03hJ8m8J2d4wcj9gRx2xl/2g3BGFrBNq9WG
         mtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGXbQDgVE0UpM54kZDE3FWO38LNW+xtw1R1SGBRDg1g=;
        b=voUDulLGLLcjZuKzTz3dbnozVMJi26plQPOufSMjEm2BB5nfTY8IBBZaJVb2oRmxlO
         IaXpeFsLx6BYKePuCUchIy/kJRNC43EEtnkvJAixiQTdLweQegzcjFIlbKH/eUY0wwQl
         CW0dKaH/cZh+hCILt060cZvtztTX9hOVIhogwzmYtrk9FQCfAlntHx/S6IktmT5nWxB5
         u/cwRJT8w74O1bebiAtqTg5A0Pzv34ZJeN43MZCuVgtcdQrLJJi/CK8/gtvRLeVVGolZ
         WMNH5oDhK94xrVMORlaPv2n9eGflLoAavaKr/uaqyCoC8jizmnV17Hh855aY2onqDps5
         jt4A==
X-Gm-Message-State: AFqh2kpDH+11Bi+2syraOp8xkKQxKvIfUrrhbWZEnOBl/1nyQaotau+x
        odW2m1GLTfxgV4cXkI7i90qkSK4xqfKzyQ==
X-Google-Smtp-Source: AMrXdXvOMxtOCkoCo6teMPBIKq2YPYMTBa7D+w8lsn1c9jTWyzJPWZfcP8OaUKQQoDcHy230XK4sKw==
X-Received: by 2002:a05:6512:25a2:b0:4bc:a66e:9aa7 with SMTP id bf34-20020a05651225a200b004bca66e9aa7mr14452924lfb.6.1673005473956;
        Fri, 06 Jan 2023 03:44:33 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id u3-20020ac258c3000000b004b5872a7003sm129747lfo.98.2023.01.06.03.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 03:44:33 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pinctrl: msm8226: Add General Purpose clocks
Date:   Fri,  6 Jan 2023 13:44:01 +0200
Message-Id: <20230106114403.275865-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
References: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Document the general purpose clock functions that are found on MSM8226.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 .../devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
index 3b79f5be860b..6e3808065845 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -66,8 +66,8 @@ $defs:
         enum: [ gpio, cci_i2c0, blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim5,
                 blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c4, blsp_i2c5, blsp_spi1,
                 blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
-                blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0, cam_mclk1, sdc3,
-                wlan ]
+                blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0, cam_mclk1,
+                gp0_clk, gp1_clk, sdc3, wlan ]
 
       bias-pull-down: true
       bias-pull-up: true
-- 
2.34.1

