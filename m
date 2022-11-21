Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C99632548
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKUONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKUONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:13:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A393D17891
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:12:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g12so20009915wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5k67QuDo1Qk0X7jO0qY2yfVnKcc1QrEolrR5Lw2lro=;
        b=wmd/Oi2SwzCm8Keu+nwhMNN4DJifRZBg++Z5GE6yRvbpKhw/BH5OjbRLuEzs+d/qyb
         kGxdb8pnKL2myAQixV6RdwXasmr3988IYpCelAJar+n8PiWSUX+ydgbRNlEoqDtkI9wx
         DzmYpOs5tHbqW/f8HNE2yxVGaR5OkZtYThkUTpIgZa8zpzCPChoo9ImNdT+sFn/ASEQM
         rCscish+YLIpKe5ptyQTyTBWIxGFNza33e9+sLNsjsZDDS/C2npCMKs/Uit25lpwm0zY
         WNEU/JPLF2B8HW0c9c/Veo0d4Aqu6L2j+v8UNVjz3zp0baeD+/D+ERZ5OEFQu0+pTbEC
         jk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5k67QuDo1Qk0X7jO0qY2yfVnKcc1QrEolrR5Lw2lro=;
        b=LYBBxZH9UVmVaWOuAjRvgd+MITzrorn7cFV7C9VTx+JlEDk8C/ccuMsUnZoQyBFdk1
         90kf842aZ5h7rn9OuR7p2dojTOzwQiXgv4KncfL1DyNxjHM2pG28Ta5KgTixUkrorF8t
         fX6PrylA/iKTaLgW56TvCgl5/xzRI2sUJ7pU25jG+2ZKBClf36vwtOb+qs0Pj25Z7gu1
         k3aesFUeoVHG1tK41y8OPmsqOMNaYHvMfkQ4KsPzi0aijgB3k0dPDpAUsnWVyJcdwrjv
         tlqC04gYSislHrXuywJ2OQXulPNwC1UQrA/2+PUSYFuAjyag8iLqfLIz2kPnZzsk1YLV
         FJAg==
X-Gm-Message-State: ANoB5pkFWuQaqaU5v38w1YpJ5tqOtEWQUN5zdDVX6ri9T7rmiOyWX5y1
        Nw7apWNurN1s9Xf5WsRYAmBCBA==
X-Google-Smtp-Source: AA0mqf58mwifqP2e1UjF/uOXp7hCZjSjbDMwDPJUQTGkFcI7q78UUtzTd3pP03SKz6RiOBVlopYUBQ==
X-Received: by 2002:a05:6000:18c1:b0:236:5d8c:97fd with SMTP id w1-20020a05600018c100b002365d8c97fdmr11444879wrq.473.1669039920066;
        Mon, 21 Nov 2022 06:12:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb12000000b002365730eae8sm11248151wrr.55.2022.11.21.06.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:11:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 21 Nov 2022 15:11:57 +0100
Subject: [PATCH] dt-bindings: pinctrl: semtech,sx150xq: fix match patterns for
 16 GPIOs matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221121-sx150xq_bindings_fixup-v1-0-e754f183b611@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current pattern for SX1503 and SX1509Q with 16 GPIOs only matches
"gpio0", "gpio1", and "gpio5" instead of "gpio0" to "gpio15" included.

Fix these patterns to match the whole 16 GPIO line names.

Fixes: 29c10bcec50a ("dt-bindings: pinctrl: convert semtech,sx150xq bindings to dt-schema")
Reported-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Sander Vanheule <sander@svanheule.net>
---
 Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
index df429a396ba3..0719c03d6f4b 100644
--- a/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
@@ -140,7 +140,7 @@ allOf:
           properties:
             pins:
               items:
-                pattern: '^gpio[0-15]$'
+                pattern: '^(gpio[0-9]|gpio1[0-5])$'
   - if:
       properties:
         compatible:
@@ -176,7 +176,7 @@ allOf:
           properties:
             pins:
               items:
-                pattern: '^(oscio|gpio[0-15])$'
+                pattern: '^(oscio|gpio[0-9]|gpio1[0-5])$'
 
 additionalProperties: false
 

---
base-commit: b6b904083dfcffadc06928b46f7a6416beba0031
change-id: 20221121-sx150xq_bindings_fixup-5ec9e5c2375c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
