Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167CE5F7FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 23:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJGVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJGVcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 17:32:47 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6925E868AD;
        Fri,  7 Oct 2022 14:32:46 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e205so4625165iof.1;
        Fri, 07 Oct 2022 14:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=prbAkun9u7iY1eavFiLQf4ems5vJrPZ3IiDkA/7Hvvg=;
        b=bWtvuxDzA7MBCqMplymx7IMu+yz/OKPpGJCEfZIcj2fDhSYAytuJeqPvQgA6jCsnvh
         RNyM/cC+uWHE3xkiaJ0gYNJkpvP9MjkEWVeAvFh0vOPSreKj1/UdcAejnoriB6EXsfvz
         X5Hx4raX6nAPWmDuCGG5YgBf1tx5RlG/FLc4UEpbOmfESupB/BkpxIHBrstJ6qKqYhFx
         o0CbMBeiHk5qgInlpAukBG8d1jcqgyVJ212WeTMe59zYWv2RPuQfH22y9lfimM5TPiVU
         NiIyX8YWQocp9MG2mXi373+RpUVuoPtyQ2FQoMIgzjY5pCij+2QAud398EUudlHVMQXX
         lL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prbAkun9u7iY1eavFiLQf4ems5vJrPZ3IiDkA/7Hvvg=;
        b=nzNu1kGByb2Idj9QhtTQyaTjv2ut1UpyUu2hYUjUDi1t1vlYH0J2Ybz9yMUqQxeEH2
         C/SD7iwJwjNfGHCmtKZ0e9VZW+F4MH0xW9iyJQ4BfGxN3X1GmoEo+oF8x6FOqVxoCvgV
         dih4Eiym9lV99GdEgpabXVSjAtZW4Df8z0De4uXyU1xIiSO5YAY/2pBGVk4bDIWQInVM
         Wzb5pITf22Jbu3wgTAFCpn3xrquNHbC+2MG2y4HuRZoEAUVKU9FCoQryWx/993f5HldE
         WD3XE70TwXGrGvY9VyfXV7PiIc2hkczj+xCwvMh+sjnz3dc0EZQ5KkajkiO/5UyGRMnR
         NIGw==
X-Gm-Message-State: ACrzQf2v6GF1Grr4FIP0Q7PsonQhLJQODlmGWBOcyizuyQgIuZZwEGQ8
        Z53hvbIJPaUAPtmillJdRtr1YsVXROfBwQ==
X-Google-Smtp-Source: AMsMyM5V/t1Q1i1fMOwp4Xe3Yq+XNbjBi3h5A2JWWWMaqrJW6kQmweB+M2y6t0wMKWgD78f1fhiUhA==
X-Received: by 2002:a05:6638:3f0b:b0:35a:76c8:5d3a with SMTP id ck11-20020a0566383f0b00b0035a76c85d3amr3703831jab.220.1665178365321;
        Fri, 07 Oct 2022 14:32:45 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::b714])
        by smtp.gmail.com with UTF8SMTPSA id x13-20020a026f0d000000b003636cb862d0sm588574jab.42.2022.10.07.14.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 14:32:44 -0700 (PDT)
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
Subject: [PATCH v9 0/3] SDM670 Pin Control Driver
Date:   Fri,  7 Oct 2022 17:32:38 -0400
Message-Id: <20221007213241.84962-1-mailingradian@gmail.com>
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
 drivers/pinctrl/qcom/Kconfig                  |    9 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c            |    3 +-
 drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1345 +++++++++++++++++
 5 files changed, 1483 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c

-- 
2.38.0

