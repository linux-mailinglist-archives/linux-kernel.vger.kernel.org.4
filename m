Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40AB5F4B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiJDV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJDV61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:58:27 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA232F39B;
        Tue,  4 Oct 2022 14:58:26 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q83so11572026iod.7;
        Tue, 04 Oct 2022 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=x7g8tltWiAeeqLkP+P8V7gTslq6NcC+9P20gpoyHgqE=;
        b=AuSwAvZT67EorWf+bxf360MhRjOrWMKmtWnLaNLv+fTe0LnWyVbm8Wecti+3WL3BB1
         bYhwhZwNmz7hQuMoAvrV+0BcXUPVfXHb4M6BtQQ2Y78/w3E0KFvgYbIcvt57T4pK6RmM
         KbHq+MK4mrjNQ5so85jiyrnr0lw1nO9SCEbN60rLKWjfuymsVW0Af5c8jxWV7LUouVdE
         JbNkixOAdDTMLxwk3PCfxXFMgFBBAPlRFapqyZoXXDHnFUJ1lsYnbdz9dK1OE3E8Iplb
         bpQZjsrw9bt+N0I5hWfI5welc9p8zgzk2oU2L08rtreerYUsIvY4cuSrYbn5XIC5ecLL
         EG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=x7g8tltWiAeeqLkP+P8V7gTslq6NcC+9P20gpoyHgqE=;
        b=tANUCNvtPPaY9tNsrpGNQapeCPJeCU9+g+p0/JK4yU6VUn3kSdnsg+8ixXAlfQCXkm
         qrK/MCBF+ExVU7mHkNLLtw1Zzwx8ZvJiJcvRwJw+aaFur5oi7zBAAhQ2buM4bcURT9vV
         4BKyh0w2eRwW0db4W3Qpb5xO9af7jnUusNbtMNG47J1gBaqg/YdRWygtQG9EcxeC+eaM
         iQBKtqhxbthNfrjfYf0TVuK5ocdYAVICxtJMH8mCMROWTTKn3+dCfLlX5irkY3KZB6DZ
         vR5alFl8oakpqyZEceotBiUoeA7L9lDYByFB39BivvGafqbCwM/MXINo//M7wHAndiwG
         YBtw==
X-Gm-Message-State: ACrzQf0hgXk8hKDCJTpcq7+guVEut+MJJhhgRfaMYd635CcJ7t1s3oar
        tNCbd7t9i2OzePtb1nFtKj3/K2IuTHioiw==
X-Google-Smtp-Source: AMsMyM4LKWPdrGbyCr1p0dof+/nhxpw9oyP3vbR2kIfJXH+q4YNtCGPHTfwAmhu/wt+1hlEFCj0eJQ==
X-Received: by 2002:a05:6602:483:b0:68a:b5f2:a508 with SMTP id y3-20020a056602048300b0068ab5f2a508mr11701359iov.97.1664920705395;
        Tue, 04 Oct 2022 14:58:25 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id f19-20020a056638023300b00363547bab30sm633852jaq.8.2022.10.04.14.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 14:58:24 -0700 (PDT)
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
Subject: [PATCH v7 0/3] SDM670 Pin Control Driver
Date:   Tue,  4 Oct 2022 17:58:11 -0400
Message-Id: <20221004215814.11694-1-mailingradian@gmail.com>
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
 drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1346 +++++++++++++++++
 5 files changed, 1486 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c

-- 
2.38.0

