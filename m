Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3091B6F9BD1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjEGVT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjEGVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 17:19:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21189100C6
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 14:19:23 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso4311587e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683494361; x=1686086361;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7M6ub/NmPwBZXz6BefX6rH5VtXUTAlDRqSeqfc1qlxg=;
        b=EsAGTRj4To4BnlSeJPHuQ6zLtRUgWkHzrZG3B2PmWYSFLmEvY/OCEu/yuc2F8AtK82
         /OSXzCpBPOQGFMw+g1cqRYA1gS51dfuMHx+IsN1a4qsqhUJlO0THP8/1rscWRTQiQQN1
         SUbhDJVLQZPbRkCKZcdFulgZpMs6h/brht98wBzdimvW51IcqLh+M5xH5zJL7/Q0h0ph
         dR7hRuSXpn5nLr41KfQBq77unyiZL6lQmBG+LPH1Ml0GTNZ8kqntxU8UCoTMMLfgsbS1
         8BalEB+UDuc7452mxBLZBr0VN1v1pdw6ex3KXsNvbhEfKyB+Hyh5t+kxO2jwQ/3Snyxw
         kCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683494361; x=1686086361;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7M6ub/NmPwBZXz6BefX6rH5VtXUTAlDRqSeqfc1qlxg=;
        b=PC6MddLdxnR7FSmoRqpFh0ew+7YTPDv5lESZSU5XlOfkgGdl7j/+2S+OtMzVw/xQ2V
         zJ7Ho1TEedWL5p9WMD/VMSayBnqRkMhDjv/vqQZ0Ig9Xe2fXrW6n42Hb0Lj+GaXHqRbq
         zoahfjgu2UTUNuXOEGNgeybxAUX+oQ10RXVfo1/ExIOVRmA+zb+VNinmhkh56e18ZfK9
         5/XLFBMHDen6ezr3D06aXcETNB+oQq2z9C4mt7hA3vmmoXGqo5+MMBNQDDQCrRVShd3p
         SGL4d+UxLnk19+bK6OIdWieKkOLm+a1HThSME8GxnCrnrumkBetGEunsLIKf4dzZ5BwD
         5gug==
X-Gm-Message-State: AC+VfDzW1CgX4ibtZ+4z/IMqjnDctZGOWXvtoLFQdaZnv8HIXUiEFbLy
        9/iU684TnCCagRGGGBoFqbUlqA==
X-Google-Smtp-Source: ACHHUZ42PhnxOTSa9MUk+fDi4qwQQ2n7hdg3WYajR6JoHgqh87ZZbsxPnSWkcYDti3YOqkZNiHTpUQ==
X-Received: by 2002:a05:6512:2185:b0:4f1:1de7:1aac with SMTP id b5-20020a056512218500b004f11de71aacmr2169073lft.20.1683494361230;
        Sun, 07 May 2023 14:19:21 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id c27-20020ac244bb000000b004f195cc3918sm623424lfm.176.2023.05.07.14.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 14:19:20 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 0/2] STMPE device tree bindings
Date:   Sun, 07 May 2023 23:19:18 +0200
Message-Id: <20230426-stmpe-dt-bindings-v3-0-eac1d736e488@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYVWGQC/32OOw6DMBBEr4JcZyMwJJBUuUdEsfgDK4GNvBYKQ
 tw9hiJlyjejp5lNsAlkWDyzTQSzEJN3CcpLJtSArjdAOrGQuSzzSt6B4zQb0BE6cppcz6DKqn5
 oXRcoG5G8DtlAF9Cp4TB/worTePRzMJY+5+a7TTwQRx/W88Iij/Tf2iIhB2mbGxbWWqXxNZLD4
 K8+9KLd9/0LVFwtENMAAAA=
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the missing GPIO bindings for the STMPE port expander
and converts the existing MFD binding to YAML.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Update to review feedback
- Collected some ack/review tags
- I guess Bartosz should apply 1/2 and Lee should apply 2/2.
- Link to v2: https://lore.kernel.org/r/20230426-stmpe-dt-bindings-v2-0-2f85a1fffcda@linaro.org

Changes in v2:
- Split off a separate GPIO binding
- Updated the MFD binding according to feedback

---
Linus Walleij (2):
      dt-bindings: gpio: Add STMPE YAML DT schema
      dt-bindings: MFD: Convert STMPE to YAML schema

 .../devicetree/bindings/gpio/st,stmpe-gpio.yaml    |  51 ++++
 .../devicetree/bindings/input/stmpe-keypad.txt     |  41 ---
 .../bindings/input/touchscreen/stmpe.txt           | 108 --------
 .../devicetree/bindings/mfd/st,stmpe.yaml          | 297 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/stmpe.txt    |  42 ---
 5 files changed, 348 insertions(+), 191 deletions(-)
---
base-commit: c712a112ed4e91afab1cc7c978af228c77a4fb13
change-id: 20230426-stmpe-dt-bindings-c3479dd71a28

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

