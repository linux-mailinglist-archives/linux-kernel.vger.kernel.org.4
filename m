Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232275B8D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiINQcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiINQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:31:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5695AC63;
        Wed, 14 Sep 2022 09:30:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c198so15440435pfc.13;
        Wed, 14 Sep 2022 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XG0NA6F+eDAVLr8bsib3Qih5JV86DCgoeajyw8wEyJ8=;
        b=nz1XBVOr4C4bfulfop2fNmem7a849NeMssVVb/58LI8PMyrVa5QeqDrZE47bs6+AOa
         cf6U0WIld5fLwkzKPKedEVZNraZZvO8I5Jm9n6e+PoPcQfoM7oQDxkykRhSkame76rQC
         0njTtr+hR+W7CrRjzKgMzf9Ead28h5YpTkqCMv12JOZVfSotd/SqT5BvXfjBvS6JRzJf
         YMtALPUua0z4BGOtcsJMaDDlsndbv8kNw/ImKLKlnXdIdCLmOTnap0uICLGMxg/Eo/nP
         c/xUaOdJxkuHmlk58by53JRMGd9pUsEbd8rAlEcVTa7nzWZk6wDGoahCZwLgv1tIdZNS
         4TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XG0NA6F+eDAVLr8bsib3Qih5JV86DCgoeajyw8wEyJ8=;
        b=U1Smjxcwh7zeUK8NEqliXugHjZ9MwhVow31TOpfJ5/RN7FisTWfNKxBrRpF9YOA7WM
         o2PpSsx94tTzDTnPbCD80MHfiRE5ZTPBYEWXKnvJB8iOFjJQxyTvqAy8QISnlXc4inW6
         NLR0GHRgPUMFJfOdI9cNfH4ZXJME5HwU6jrg2nSjhODhSU526EpUIiAKoNNQ4izB92mA
         BKl3LoFkoYhBU8nRMGXu8Sib77o60+XwTCAbyldavEfw3NOxHFL5gP8scoDKHDR9Nhup
         E4g6KGytkcuwXhTIiQpEzMxtHZh5sx218J+7D+ngy0Mr/thwkBXrySYkfz5QhBOqOzmM
         J/SQ==
X-Gm-Message-State: ACgBeo1aGH3vOtz4DJXI3F1U5WOslfz1fZvoSYF2vzPUeoWtvMnPuans
        prBAqa9AcmbVFc4c2LBRZwI=
X-Google-Smtp-Source: AA6agR5nTLxIWrZaloOtmtA3LJ8R7sYaTwq4Is5hdNvclGaqfP8GNVCINjQC/uF/aDotzWmU/HFQJQ==
X-Received: by 2002:a05:6a00:4392:b0:541:eb2c:444c with SMTP id bt18-20020a056a00439200b00541eb2c444cmr20430388pfb.63.1663173023095;
        Wed, 14 Sep 2022 09:30:23 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-145.dynamic-ip.hinet.net. [1.171.4.145])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090af8d600b002031264a864sm1899991pjd.41.2022.09.14.09.30.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Sep 2022 09:30:22 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Add Richtek RT9471 3A battery charger support
Date:   Thu, 15 Sep 2022 00:30:12 +0800
Message-Id: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

Since v5:
- Remove one line wrapper.
- Merge header content into source file, remove header file.
- Remove 'charge_term_enable' sysfs entry and merge it into
  'charge_term_current' property control.
- Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
  Following by the below discussion
  https://lore.kernel.org/all/YxAVAt2eWB3NFlrk@google.com/
- Recover all the change in sysfs-class-power.
- New a sysfs-class-power-rt9471 file.
- Remove 'charge_term_enable' sysfs entry, directly integrate it in
  'charge_term_current' power supply property control.

Since v4:
- Remove the line for the owner field in driver.
- Add the documentation for sysfs entries.

Since v3:
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2:
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.
- Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
- Specify the member name directly for the use of linear range.

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9471 battery charger
  power: supply: rt9471: Add Richtek RT9471 charger driver
  Documentation: power: rt9471: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power-rt9471 |  29 +
 .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 937 +++++++++++++++++++++
 5 files changed, 1056 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c

-- 
2.7.4

