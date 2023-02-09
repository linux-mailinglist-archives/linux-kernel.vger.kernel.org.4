Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60943690A98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBINlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBINln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:41:43 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49752F7AA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:41:40 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so1772650wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UH1FxS+Al9Ybgi+KxNoTC8ETohhFHsXFP4JFZVHRAP0=;
        b=vxbXh9gBJBoppO3MqpRAXQW/7ZH+O8sim9MSobZQaBaFondUXzPawxgSuBPQaN2wrb
         RgH6EIGOf+5RYo1trbIsCz1pDvu+vSRZs4qUsxruNAnFAb6q8wQfqBWVEC8zrKuDKsuD
         03Y73sP1G7tUJdPTgpWHlzswtkdal8lR0UKzEHdGsq3pifb3SO6jd1PQKiHb+sp5jYy+
         Jmi2BgzO8OVnP7CqjE3tgtW4miPWHhEqWwY9kCtbqUu9vFIX683v0LfT1xsMe6QT3PJv
         ncsXvwALgD02ttdiaWIuwMFe30kUIT11tRKmG9XEHX6FzRGq2kcikxGQCGlG4fqWxfx/
         xXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH1FxS+Al9Ybgi+KxNoTC8ETohhFHsXFP4JFZVHRAP0=;
        b=bsRrrJQMaMmEQ0e2AO5ioiU1G70048IT83oLm8TI8bdKIRs6sptD9F4T1i0lQBoDKQ
         jdLPKGnMErUIpakLZFBVx+YSgvi81EsyfAB8G3k1EDoebQOyMeCco4l4AD0t7XX59arJ
         +ruCKVjOdL6xhlDm0CQgiOqb2ftkxTG6ltmZzsmIB+b2FtHBoPjBJf6m8s1d5HgzE4YQ
         vSP5q20CZMW9PLqL6ouAd9dg69dsoKdZZDiXt+gLIulx0C4/ljan0RCCrxZvQOCYuwne
         W1QtUj49l7vXFB/GW0lViTF1kGQBxfcXPcfa/q1+MLcQp4m4466mBK+ULI7+I6pefdj5
         DqyA==
X-Gm-Message-State: AO0yUKWo/7QdqwHNlAu+qQ08wk00CAHfjM7yyYbVtE0ZafHfTYkz591f
        5sL8P9V/4Nv7ILC8Qfw3bcyjQtn97v1QgBwSfKo=
X-Google-Smtp-Source: AK7set/L6y9JA47P+Wg2ntnqmghlLGsbHSVJ+ZSuNq1ygPmrpHcbyzAjgS0I/MTMc7LZME9xNa9X/A==
X-Received: by 2002:adf:f212:0:b0:2c3:ebc1:30a9 with SMTP id p18-20020adff212000000b002c3ebc130a9mr11324485wro.23.1675950099211;
        Thu, 09 Feb 2023 05:41:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id k12-20020a7bc40c000000b003dfe549da4fsm4946991wmi.18.2023.02.09.05.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:41:38 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/6] dt-bindings: second batch of dt-schema conversions for
 Amlogic Meson bindings
Date:   Thu, 09 Feb 2023 14:41:36 +0100
Message-Id: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABD45GMC/x2NMQ7CMAwAv1J5xlKSMgBfQQyO66QWwUVJqZCq/
 p2I8W6426FJVWlwG3aosmnTxTr40wA8k2VBnTpDcGF0wV0xnpFeZcnKGNUmtdyQF9ukrrjSUwJ
 KYEoX8ezHBL0TqQnGSsZzL9mnlC7fVZJ+/+P74zh+xut8logAAAA=
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Batch conversion of the following bindings:
- rtc-meson-vrtc.txt
- amlogic,gxbb-clkc.txt
- amlogic,gxbb-aoclkc.txt
- clk-measure.txt

And in addition document the System Control registers top node.

DT fixups will be posted once those conversion are fully reviewed.

With this serie, the in-review and applied bindings documentation, the
the following arm64 compatible are yet to be documented in dt-schema:
 ['amlogic,axg-audio-clkc']
 ['amlogic,g12a-audio-clkc']
 ['amlogic,sm1-audio-clkc']
 ['amlogic,g12a-tohdmitx']
 ['amlogic,sm1-tohdmitx', 'amlogic,g12a-tohdmitx']
 ['everest,es7154']
 ['everest,es7241']
 ['ti,tas5707']
 ['linux,spdif-dir']
 ['gpio-fan']
 ['pwm-fan']

For reference, the following bindings conversion patches are taken in account on top
of next-20230208 tag :
- https://lore.kernel.org/r/20230208093520.52843-2-jbrunet@baylibre.com
- https://lore.kernel.org/r/3ffd1889-1966-47a8-9504-d44e452d5a31@gmail.com
- https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-7-e28dd31e3bed@linaro.org
- https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-5-e28dd31e3bed@linaro.org
- https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-4-e28dd31e3bed@linaro.org
- https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-3-e28dd31e3bed@linaro.org
- https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-2-e28dd31e3bed@linaro.org
- https://lore.kernel.org/r/20221117-b4-amlogic-bindings-convert-v3-1-e28dd31e3bed@linaro.org
- https://lore.kernel.org/r/8cae0b08-8040-ef7b-da0e-92d9b3695249@gmail.com
- https://lore.kernel.org/r/5b83767e-c53d-316f-df10-45a39dbd9c88@gmail.com

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (6):
      dt-bindings: rtc: convert rtc-meson-vrtc.txt to dt-schema
      dt-bindings: soc: amlogic: convert clk-measure.txt to dt-schema
      dt-bindings: soc: amlogic: document System Control registers
      dt-bindings: soc: amlogic: convert amlogic,gxbb-clkc.txt to dt-schema
      dt-bindings: soc: amlogic: convert amlogic,gxbb-aoclkc.txt to dt-schema
      dt-bindings: soc: amlogic: update sysctrl clock-controller subnode type

 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |  64 -----------
 .../bindings/clock/amlogic,gxbb-aoclkc.yaml        | 120 ++++++++++++++++++++
 .../bindings/clock/amlogic,gxbb-clkc.txt           |  53 ---------
 .../bindings/clock/amlogic,gxbb-clkc.yaml          |  51 +++++++++
 .../bindings/rtc/amlogic,meson-vrtc.yaml           |  42 +++++++
 .../devicetree/bindings/rtc/rtc-meson-vrtc.txt     |  22 ----
 .../soc/amlogic/amlogic,meson-gx-clk-measure.yaml  |  40 +++++++
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 122 +++++++++++++++++++++
 .../bindings/soc/amlogic/clk-measure.txt           |  21 ----
 9 files changed, 375 insertions(+), 160 deletions(-)
---
base-commit: 5b1c3cf237da1dec2945694a6b7e5a0b66272d53
change-id: 20230209-b4-amlogic-bindings-convert-take2-e2caf8e1c13f

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

