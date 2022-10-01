Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0995F1FA7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJAVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJAVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 17:07:33 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA460F8;
        Sat,  1 Oct 2022 14:07:30 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h18so3767175ilh.3;
        Sat, 01 Oct 2022 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uUNFDcaL8MebU4GzPEEc+siVKONQVYVPRFWvQj9K+LQ=;
        b=AV432ZPUJCVbB+dMQHMsJuJzzx1dVrD+0/AroUEfsyP21ZAS+GzRnTrQctuVK2aYez
         aP6LMsElY/rKRQiH6i2sW2vrRKysMgO0yUP/Ds7sJZZICEm21Ts6JlCh84EZowZ1snQ5
         M//lmKXQRGEPNTygX5pFFK23DWbV4SRCA4FfhplrkYe+EhDkaJn9GqK0a1+zUl5rxkTU
         iA4oI+QXtUtiZB+vhR6UpDE2UApadaoUEQgqveFsGRhTbr5ctXspi9zkMNcuyzU6FrBe
         aINJx6e+fqv8eqhMvbEBDtCODm733l+ZqMUknWTVG7mWFQOi2Mn17JsmJurAWuPLev8M
         /mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uUNFDcaL8MebU4GzPEEc+siVKONQVYVPRFWvQj9K+LQ=;
        b=e9VzB6jLxUOaFyYtAhV92prpYEd6Pp4jyqh/nqIyiOu29J/6sUSHqHxLbzVTI2EP7I
         pLsser+BQs4fXTcVWrLuqB8OsqqdvI3PXzHW4dp7k+ZFlTs+1YpWxfjr7+pZZtUmFptb
         BHFxSSUUFy6NaLFQQ/Es1uvaxBbjUqNKsnxiPVnUBEhifB7F2nlJ0VMuFnkG1g65mIwN
         z5HjzHpuGXlh5qQWnYJlrkfZq1lZ5fAqKBCrzRcbxuL8QLXgwL1EYhlclgB155jRnjdM
         gsPoHyleP4Bnsi8QV9k2wk3NpeiTsM+8Nhz2SJRJHUyFrQN5QT+KXWlWoru6SpF8ET5X
         LyVQ==
X-Gm-Message-State: ACrzQf1Bdix5YDpGhMx50cbOxOhZtCucAh21pZqPEtx1iQD9m7MgEB7f
        ebkrefsrLFCW9oLrvFAQlDjYgAwPaTRmcw==
X-Google-Smtp-Source: AMsMyM6qMcngEsSewBtYPhXB8P7xqcCr0x/7HnyxqKHnIOmhKaQqLEujxBGsNBg9aDhXd3Er4Mx83g==
X-Received: by 2002:a05:6e02:1706:b0:2f1:c2ee:7fea with SMTP id u6-20020a056e02170600b002f1c2ee7feamr6927174ill.40.1664658450024;
        Sat, 01 Oct 2022 14:07:30 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id l31-20020a026a1f000000b0034a58483060sm2369377jac.56.2022.10.01.14.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:07:29 -0700 (PDT)
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
Subject: [PATCH v6 0/3] SDM670 Pin Control Driver
Date:   Sat,  1 Oct 2022 17:07:22 -0400
Message-Id: <20221001210725.60967-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
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
  pinctrl: qcom: add support for complementary reserved gpios
  pinctrl: qcom: add sdm670 pinctrl

 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    |  129 ++
 drivers/pinctrl/qcom/Kconfig                  |    9 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c            |    5 +-
 drivers/pinctrl/qcom/pinctrl-msm.h            |    4 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1373 +++++++++++++++++
 6 files changed, 1519 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c

-- 
2.37.3

