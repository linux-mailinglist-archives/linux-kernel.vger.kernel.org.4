Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686A05F71AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 01:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJFXWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJFXW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:22:27 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9295CD5EC;
        Thu,  6 Oct 2022 16:22:26 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id g13so1789740ile.0;
        Thu, 06 Oct 2022 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+TEoWgEKTvbiJtOYsEhCaZpzROl8ImC9jVpcIpr9rdA=;
        b=LEsNljBht9CfS9iP7WzSiemiu4S4Ct90L/IXFPTsG4ClZiwQXJ/ciE77IUb9WwHnuy
         cK33AT6sQ/tdrC2P2Ho4kmtNjz1wg59WoVdUKLz6ifwvt7tmHmyUFE74w874P8zaUoI2
         Agg6Yrmtx++jD2bHy+A8jbYJz83rYOo5cBR3kCFwpwQhdncBDFhhRsaCKLl7+IrpZkqG
         fykMxH4NCIfT1sb8TFnF1e5e2w8kdM1LsZ5XguU23xmROGVVujwKFAvV6S9rO8HX47KZ
         ylEj57zmvpCLUTGuMFp8x8JJBxRqGTIBYz5xOwdXolQkyZCwbaJPfhjMCqSCA64RIle7
         ATJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+TEoWgEKTvbiJtOYsEhCaZpzROl8ImC9jVpcIpr9rdA=;
        b=AeMW6HFFAPhrfz3Dnu+HtLAZad4ERcyEIXvFjKzXAmqP1mVfykZCNSqF9X+2wKhEvU
         k5lFB8HhZE37w3vhU4rjKSkqSv1Hs0Q6r0V4jP/vDlIROqmgLs6/3AYf69osJAO88KSK
         v+wJ6BVeoszY7Ee1S8pLJJEcyEFPZKUo5e7OXdSQ40BWew62T8XRGg5kt9iHV+zdG+9D
         6Hj0zAKTYrk+U7eb193WTuiC+I/wTAy/1FYY3TCFVZvHk8ezR/AY6QYJqS1wQQcs1ehk
         YISagq0Gr9U9DdZ2xZxWcgeiR5B4+3NOj8cplbceuRCy7uAIDQuz6aI4jwXyZWjfkYVv
         I2KQ==
X-Gm-Message-State: ACrzQf38AYFQkM+nV3+MZDxa16nfAA2XPd7ZyRCBHc6s6wZ/EjXxqiIg
        VdySaDqL77JPg7sPFLtpXPZV6DUuwxbDsg==
X-Google-Smtp-Source: AMsMyM6AWsot4DhUoPLqLnJu+BQTwKSnXw48oIotZLDAu/blMk9OHITtBJMVXWE9n9kR37uL2drMHQ==
X-Received: by 2002:a05:6e02:164d:b0:2f9:46bb:6ffb with SMTP id v13-20020a056e02164d00b002f946bb6ffbmr945606ilu.320.1665098546112;
        Thu, 06 Oct 2022 16:22:26 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::d5cc])
        by smtp.gmail.com with UTF8SMTPSA id x94-20020a0294e7000000b00363455b779csm264890jah.159.2022.10.06.16.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 16:22:25 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v8 0/3] SDM670 Pin Control Driver
Date:   Thu,  6 Oct 2022 19:22:16 -0400
Message-Id: <20221006232219.37505-1-mailingradian@gmail.com>
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

 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    |  129 ++
 drivers/pinctrl/qcom/Kconfig                  |    9 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c            |    3 +-
 drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1345 +++++++++++++++++
 5 files changed, 1485 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c

-- 
2.38.0

