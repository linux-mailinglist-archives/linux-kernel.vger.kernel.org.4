Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1769CF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjBTOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjBTOeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:34:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD141EFE4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:34:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E11BB80B19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 14:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C0C433EF;
        Mon, 20 Feb 2023 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676903638;
        bh=LpxzHapXz/xcZOtE7DHGPWH8nHuyytcqDwctZRMfPfs=;
        h=From:To:Cc:Subject:Date:From;
        b=npLbWlsCCXVND4/nlx35G4W+tqBCZqwIoASZ+/Aw+wKFxn/rr97mitWBU7sfeVSUC
         OkY57zxTJMhn7TBUm210DOIx4EGOmXXPTUCqafa5+jf5Fb2AdnrFeqBnxeTlOy6GsT
         /Evx+Q4WUH6uczZiuTA8McF2YoHx4HAnGNtQjO+eOTAHjDaqBeoeU9RlPD+uRyVlFR
         8vlTH/Jcx5xyM4D32hybpFfMV5DYM8yngAWpUFRkkCKiCi/MRyta0BWF0ue5XYQv85
         vwfIn77cKrxtF/e27dDIgwtGWTSQIleaNsp5TICYkfkNgVfzm3zsakjwM4y2dK5uHI
         p35An0ljo2JkA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.3
Date:   Mon, 20 Feb 2023 14:33:49 +0000
Message-Id: <20230220143357.C38C0C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.3

for you to fetch changes up to 7f62cb8861190e7cc1018ff37597fc49b2eaafa8:

  regulator: max597x: Align for simple_mfd_i2c driver (2023-02-16 15:54:02 +0000)

----------------------------------------------------------------
regulator: Updates for v6.3

This has been a very quiet release for the regulator API, there's one
new driver for the Maxim MAX20411, some DT schema conversions and some
small tweaks and improvements but really nothing major at all.

----------------------------------------------------------------
Axel Lin (1):
      regulator: max20411: Fix off-by-one for n_voltages setting

Bjorn Andersson (2):
      regulator: dt-bindings: Describe Maxim MAX20411
      regulator: Introduce Maxim MAX20411 Step-Down converter

Cristian Marussi (1):
      regulator: scmi: Allow for zero voltage domains

Jerome Neanne (1):
      regulator: tps65219: use generic set_bypass()

Kees Cook (2):
      regulator: max77802: Bounds check regulator id against opmode
      regulator: s5m8767: Bounds check id indexing into arrays

Konrad Dybcio (1):
      regulator: dt-bindings: qcom-labibb: Allow regulator-common properties

Krzysztof Kozlowski (1):
      regulator: dt-bindings: fixed-regulator: allow gpios property

Luca Weiss (1):
      regulator: dt-bindings: qcom,usb-vbus-regulator: change node name

Mark Brown (2):
      regulator: Add Maxim MAX20411 support
      regulator: max20411: Directly include bitfield.h

Naresh Solanki (2):
      regulator: max597x: Remove unused variable
      regulator: max597x: Align for simple_mfd_i2c driver

Neil Armstrong (1):
      dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema

Paul Cercueil (1):
      regulator: dt-bindings: Convert active-semi PMIC docs to YAML schemas

Randy Dunlap (4):
      regulator: act8945a: fix non-kernel-doc comments
      regulator: fixed-helper: use the correct function name in comment
      regulator: mcp16502: add enum MCP16502_REG_HPM description
      regulator: tps65219: use IS_ERR() to detect an error pointer

Rob Herring (1):
      regulator: dt-bindings: Convert Fairchild FAN53555 to DT schema

Uwe Kleine-König (1):
      regulator: max20411: Convert to i2c's .probe_new()

Wadim Egorov (1):
      regulator: tps65219: Report regulator name if devm_regulator_register fails

 .../bindings/regulator/act8865-regulator.txt       | 117 ----------
 .../bindings/regulator/act8945a-regulator.txt      | 113 ---------
 .../bindings/regulator/active-semi,act8600.yaml    | 139 +++++++++++
 .../bindings/regulator/active-semi,act8846.yaml    | 205 ++++++++++++++++
 .../bindings/regulator/active-semi,act8865.yaml    | 158 +++++++++++++
 .../bindings/regulator/active-semi,act8945a.yaml   | 258 +++++++++++++++++++++
 .../devicetree/bindings/regulator/fan53555.txt     |  24 --
 .../bindings/regulator/fcs,fan53555.yaml           |  64 +++++
 .../bindings/regulator/fixed-regulator.yaml        |   7 +
 .../bindings/regulator/maxim,max20411.yaml         |  58 +++++
 .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 ++++++++++
 .../regulator/qcom,usb-vbus-regulator.yaml         |   2 +-
 .../bindings/regulator/qcom-labibb-regulator.yaml  |   6 +-
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/act8945a-regulator.c             |   6 +-
 drivers/regulator/fixed-helper.c                   |   2 +-
 drivers/regulator/max20411-regulator.c             | 163 +++++++++++++
 drivers/regulator/max597x-regulator.c              |  52 +++--
 drivers/regulator/max77802-regulator.c             |  34 ++-
 drivers/regulator/mcp16502.c                       |   1 +
 drivers/regulator/s5m8767.c                        |   6 +-
 drivers/regulator/scmi-regulator.c                 |  16 +-
 drivers/regulator/tps65219-regulator.c             |  24 +-
 24 files changed, 1269 insertions(+), 323 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/act8865-regulator.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8600.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8846.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8865.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/active-semi,act8945a.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/fan53555.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/fcs,fan53555.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max20411.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
 create mode 100644 drivers/regulator/max20411-regulator.c
