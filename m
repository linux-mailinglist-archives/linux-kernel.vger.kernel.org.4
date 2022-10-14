Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E785FE632
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJNAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJNAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:19:59 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAA813F0B;
        Thu, 13 Oct 2022 17:19:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l127so2716951iof.12;
        Thu, 13 Oct 2022 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YfgeDHldJKIaGyJyuYC9kZ/QabK/ImTm8OEsJ6qFS0o=;
        b=aPIKMzgB6NoaYto0JY7M6cEv04s4uoxll747l+s3rrQ1ZP3iVQY6mKdbR4UK/WhO6Q
         zFDFH+JiCuN10nCLAO1N8cz6FbD+2UY6wJXlXpvG2lRXf5djAmm7Hx8o9lYxWo/hto3V
         u7gQcwYUo3s0eCu+tQu36lHOPPoakCc/nhDiVNm6+547dbYD9OinMk18raK6OcxtZgza
         i5S4GPGR2BUamhR5HHOCDMLWERHtiFFbobW3QUU9dF1JwgyOZVUkit6Fc/wvADVs8sp6
         QFWgghjjMzY1oB5VZbMBnjUSWe7gwzSRSKYIp0YSuv2BOzndtGJWX3aTYtNFWAFuAiK1
         9MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfgeDHldJKIaGyJyuYC9kZ/QabK/ImTm8OEsJ6qFS0o=;
        b=RsxQwV+QE7o4QTiXSPb9RbtbpaAeRsAVth8Of1uAKbZuBTv1We3EB9+nfjMgfhhol0
         10KM9hAz86RFP359G8Jnlaata+AmCUR38gLWh9WKxNUeezilgjg0iVGMGiQyCeJRtoem
         4ZgBdBGY1p64FYvbrkHT9CuSR4CoHcIw1qdSw87Ph1P6kBd/OKZtbkPcDrwd5n4ApOw3
         yraoOw3uzMLdFqtIi5teuJLBB63Kw1KZ0iT5aF2nRklqWMUyP3HLsuBLu9UplfyIwYrv
         MlAjkxCKTt2mgi5SEMLKlZUWS6/LnENBpu5xuyG0GjSvZCbfn9NaM1yBuBbkDvKB6SSN
         77qQ==
X-Gm-Message-State: ACrzQf3d+hyDO//IjfE2dKEq1/syzGoV3F6yqMYrzNLpqJhRzjEFo/li
        oMCdOaJ/qm/ntmjTaBrCga0ypw8mtI59Tw==
X-Google-Smtp-Source: AMsMyM7ZVf8gntYC9p76yImA3xbiGj1OFGQZpFzMdTZXI8Oy3h87wPBSpKtQ7PU0LeSajwZsc/LWfw==
X-Received: by 2002:a05:6602:3c7:b0:6a4:334d:3344 with SMTP id g7-20020a05660203c700b006a4334d3344mr1087894iov.21.1665706781353;
        Thu, 13 Oct 2022 17:19:41 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::3fc2])
        by smtp.gmail.com with UTF8SMTPSA id j20-20020a02cc74000000b0035672327fe5sm520116jaq.149.2022.10.13.17.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 17:19:40 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/3] SDM670 Pin Control Driver
Date:   Thu, 13 Oct 2022 20:19:31 -0400
Message-Id: <20221014001934.4995-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Changes since v9:
 - add arm64 kconfig check (3/3):
   https://lore.kernel.org/r/20220925112103.148836-1-krzysztof.kozlowski@linaro.org

Changes since v8:
 - change dt schema description (1/3)
 - change comment (2/3)
 - remove reference to generic pinctrl (1/3)
 - change to double quotes (1/3)

Changes since v7:
 - remove complement_fw_reserved_gpios from patch 3

Changes since v6:
 - remove bitmap_fill() call completely (original commit was 4c0efbfb2669
   ("pinctrl: msm: Add ability for drivers to supply a reserved GPIO list"),
   original author CC'd)
 - group some entries in pingroup arrays for less lines
 - accumulate review tags

Changes since v5:
 - remove function requirement in schema
 - change "-state$" regex to double quotes in schema
 - drop quotes from qcom-tlmm-state ref in dt schema

Changes since v4:
 - accumulate review tag
 - use --cover-letter
 - this is effectively a resend

Changes since v3:
 - constrain gpio-reserved-ranges to 1-75 items
 - proper indentation in dt-bindings example (actually tagged this time
   instead of an outdated commit)
 - remove unnecessary commit reference
 - rename complement_fw_reserved_gpios -> complement_fw_gpio_ranges

Changes since v2:
 - remove quotes from pinctrl.yaml# in dt-bindings
 - constrain gpio-reserved-ranges to 1-76 items (includes ufs_reset)
 - indentation in dt-bindings example
 - cite downstream kernel source
 - remove MODULE_AUTHOR (most imported pinctrl drivers don't have this)

Changes since v1:
 - add a field in msm_pinctrl_soc_data to accomodate the needs of the
   driver and device dts
 - apply changes made to existing tlmm dt documentation
 - add reserved gpios array
 - rename device tree compat string to qcom,sdm670-tlmm
 - remove dependency on ACPI
 - move MODULE_DEVICE_TABLE macro call up
 - add missing pins (fixes most of the debugfs problems)
 - move qup0_pins down
 - add whitespace between UFS_RESET macro and pins array

This patch series adds the driver for the Qualcomm Snapdragon 670 TLMM
(Top-Level Mode Multiplexer) and introduces a new field so that SDM670-
related device trees can reserve their own gpios.

Richard Acayan (3):
  dt-bindings: pinctrl: qcom: add sdm670 pinctrl
  pinctrl: qcom: do not reinitialize gpio valid mask
  pinctrl: qcom: add sdm670 pinctrl

 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    |  127 ++
 drivers/pinctrl/qcom/Kconfig                  |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c            |    3 +-
 drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1345 +++++++++++++++++
 5 files changed, 1484 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c

-- 
2.38.0

