Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB90C6FB02A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjEHMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjEHMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:35:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1580236CC3
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:35:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f22908a082so1967587e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683549310; x=1686141310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Tij+FFEbWqrbKwhf0iTLPcsRvrr4KB1dAOlPPk6qZw=;
        b=wa7C9rAOstOw/5YMYkwIrZD9AyXDkGskPOdNCBBPLMHxliZf5UP99ea1QrUA2QmtAz
         AIdjUWTfi3Am4Lh0jGXuA0M7JLIs+2NIOhPNfyUlzTap1GPq6CB4Scqujhnw9GemclAT
         qOcbsMHfPTYkHKEut6y8H1Xl6ZFC1KC73nUlkpiR2xZqlG5jBmpoWN8PgWzur7GgtgMo
         X00Q5mrg5iWwFy8Ndg0jJuwr+qmWdjb0pZ+h1/BpYI7tXSiXm28/GYp1x5rzqDmjwqvt
         yeaXou2SVUsanLoq97h3wcd7NKH1AnhR4vcxP9+vdtCVd5EstqM7octIp5LlVwHf5o7r
         42vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683549310; x=1686141310;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Tij+FFEbWqrbKwhf0iTLPcsRvrr4KB1dAOlPPk6qZw=;
        b=SjS5e5VvEoawTettfmf21t0YUnBi4Cyi0FBCR4NTIzNyePlhQia2w5iLqIoBxX6Fkl
         sEDEfu6UG54+2HTL2r/oZ/DMJ0+7oYndclOk+8cjsnekEtOmQ8l8KEIkntY3Qhmm8Xvu
         2JkjriTN9jqYAH2NXz21h0J1wsRNoU9pKaFPwArl0d6A+lZhdJcClkxvKCoGzEzo5pR+
         u6I0cNN90slrd7kqOatF+kJDKKWCyzMe/vY1RPRf5oNfGTRDFC06uKbODNA6x2az6euS
         NKtkYRCAvD6hwlol4ujwga/CTVlUaaLI5T8Ao5MW2aaiXcRapklVga+AEBCDVlCXqUdz
         tNbg==
X-Gm-Message-State: AC+VfDyWgc9mk6HWwcj1WoZiVZYzB2RA+CCbyQ6W4peDWl9Y8IabW32u
        mY6BOf2oce+RTfZjncB5/1EEKQ==
X-Google-Smtp-Source: ACHHUZ5PEoKAODGoxQPkaW6DFt7BHyOeFUvreaKIu5ClJBbNppYj6RHHJeg1uV0h/uP2qk8jrz+xXg==
X-Received: by 2002:ac2:4890:0:b0:4f1:444e:6c5a with SMTP id x16-20020ac24890000000b004f1444e6c5amr2752347lfc.8.1683549310301;
        Mon, 08 May 2023 05:35:10 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q2-20020ac25fc2000000b004b55ddeb7e3sm1289593lfg.309.2023.05.08.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 05:35:09 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 0/2] STMPE device tree bindings
Date:   Mon, 08 May 2023 14:35:08 +0200
Message-Id: <20230426-stmpe-dt-bindings-v4-0-36fdd53d9919@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzsWGQC/4WOQQ6CMBBFr0K6tgZahOrKexgXQzuFSaCQlhAJ4
 e62LEzc6PL/yXt/NhbQEwZ2yzbmcaFAo4uhPGVMd+Ba5GRiZiIXMi9FxcM8TMjNzBtyhlwbuJZ
 lfTWmLkAoFrkGAvLGg9NdIj/ACkOf7pNHS69j8/GMuaMwj349XlhEan+tLYLnXFh1gcJaqw3ce
 3Lgx/PoW5Z0i/yrkFGBoAtTywpLpb4U+76/AdGZL/8WAQAA
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the missing GPIO bindings for the STMPE port expander
and converts the existing MFD binding to YAML.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Make the GPIO bindings a conversion: there were some old
  text bindings for the STMPE GPIO, we now delete them as
  part of the patch.
- I expect Lee or the DT binding tree to pick both patches.
- Link to v3: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org

Changes in v3:
- Update to review feedback
- Collected some ack/review tags
- Link to v2: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org

Changes in v2:
- Split off a separate GPIO binding
- Updated the MFD binding according to feedback

---
Linus Walleij (2):
      dt-bindings: gpio: Convert STMPE GPIO to YAML schema
      dt-bindings: MFD: Convert STMPE to YAML schema

 .../devicetree/bindings/gpio/gpio-stmpe.txt        |  17 --
 .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    |  53 ++++
 .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
 .../bindings/input/touchscreen/stmpe.txt           | 108 --------
 .../devicetree/bindings/mfd/st,stmpe.yaml          | 297 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
 6 files changed, 350 insertions(+), 208 deletions(-)
---
base-commit: b777e950b1e0b9112418e7669c8b6d96915df778
change-id: 20230426-stmpe-dt-bindings-c3479dd71a28

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

