Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648EB68BFBB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjBFOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjBFON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:13:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4E2B297;
        Mon,  6 Feb 2023 06:13:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D0BD60EFA;
        Mon,  6 Feb 2023 14:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D68FC433EF;
        Mon,  6 Feb 2023 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675692785;
        bh=41eF3avSY5zNeD+zG7bcEF5Wk2RSA9m0ufmBlr18Ssk=;
        h=From:To:Cc:Subject:Date:From;
        b=VIqk8eZOvLdFgK6TAUtPyBUOMuQo2cBvpTs0zs+rgEfFZyPjLMbe268c2aHtXvuwl
         JxGHGxpQTu3hbfJ1wl0jm5yvKit2gH0qRyuXY9MOMy7+Kru1ad+o+FU3JPp56UmgkS
         ChDVllV1jcGvwlZCKExC8Hq9CJYPo/Oaglvdn6DJd2xncae4tAwq/aZeBHB3Lh8IBa
         4qOOBcozGZ+tbAD25lBzgoBzECai+n5jSI8i7Ih3YNGk1MwvNmateb/0PIKZ+6675R
         Ej+BF493DwhPUZ9/Yfls5gQXR3mQjFQmD1QtV1E5gPwzF1vIXgA5BWjoJmxc1v5Kz6
         lthzgSXjS5ZCA==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.3
Date:   Mon,  6 Feb 2023 16:12:00 +0200
Message-Id: <20230206141200.9789-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 6.3-rc1 merge
window. In contains new drivers and misc tiny updates. Two of the new
drivers are in immutable branches (qcom tree pulls SM8550 and QDU1000 DT
header files). The rest of the details are in the signed tag.

All patches have been in linux-next for at least one week. Please pull
into char-misc-next when possible.

Thanks,
Georgi

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.3-rc1

for you to fetch changes up to 7bf0008a52930e4d11ff1d6083cf13d9879bd2d0:

  Merge branch 'icc-dt' into icc-next (2023-02-06 15:40:42 +0200)

----------------------------------------------------------------
interconnect changes for 6.3

Here are the interconnect changes for the 6.3-rc1 merge window with the
significant part being new drivers.

Driver changes:
- New driver for Qualcomm SM8550
- New driver for Qualcomm QDU1000/QRU1000
- New driver for Qualcomm SDM670
- New driver for Qualcomm SA8775P
- Drop the IP0 interconnects and migrate them to RPMh clocks instead
- Misc improvements in the DT schema for some existing drivers

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: interconnect: Add Qualcomm SM8550
      interconnect: qcom: Add SM8550 interconnect provider driver

Bartosz Golaszewski (2):
      dt-bindings: interconnect: qcom: document the interconnects for sa8775p
      dt-bindings: interconnect: qcom,sa8775p-rpmh: fix a typo

Bryan O'Donoghue (1):
      dt-bindings: interconnect: Exclude all non msm8939 from snoc-mm

Dmitry Baryshkov (9):
      interconnect: qcom: sdx55: drop IP0 remnants
      interconnect: qcom: sc7180: drop IP0 remnants
      interconnect: move ignore_list out of of_count_icc_providers()
      interconnect: qcom: sm8150: Drop IP0 interconnects
      interconnect: qcom: sm8250: Drop IP0 interconnects
      interconnect: qcom: sc8180x: Drop IP0 interconnects
      interconnect: qcom: sc8280xp: Drop IP0 interconnects
      dt-bindings: interconnect: qcom: Remove ipa-virt compatibles
      dt-bindings: interconnect: qcom: drop IPA_CORE related defines

Georgi Djakov (6):
      Merge branch 'icc-sm8550-immutable' into icc-next
      Merge branch 'icc-qdu1000' into icc-next
      Merge branch 'icc-ip0-migration' into icc-next
      Merge branch 'icc-sdm670' into icc-next
      Merge branch 'icc-sa8775p' into icc-next
      Merge branch 'icc-dt' into icc-next

Konrad Dybcio (1):
      dt-bindings: interconnect: OSM L3: Add SM6350 OSM L3 compatible

Krzysztof Kozlowski (4):
      dt-bindings: interconnect: split SC7280 to own schema
      dt-bindings: interconnect: split SC8280XP to own schema
      dt-bindings: interconnect: split SM8450 to own schema
      dt-bindings: interconnect: samsung,exynos-bus: allow opp-table

Melody Olvera (2):
      dt-bindings: interconnect: Add QDU1000/QRU1000 devices
      interconnect: qcom: Add QDU1000/QRU1000 interconnect driver

Neil Armstrong (1):
      dt-bindings: interconnect: qcom-bwmon: document SM8550 compatibles

Richard Acayan (2):
      dt-bindings: interconnect: add sdm670 interconnects
      interconnect: qcom: add sdm670 interconnects

Shazad Hussain (1):
      interconnect: qcom: add a driver for sa8775p

 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    2 +
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    1 +
 .../devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml    |   70 +
 Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml   |   73 +-
 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml  |   46 +-
 .../devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml    |   50 +
 .../devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml     |   71 +
 .../devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml   |   49 +
 .../devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml     |  124 +
 .../devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml     |  139 +
 .../devicetree/bindings/interconnect/samsung,exynos-bus.yaml   |   27 +
 drivers/interconnect/core.c                                    |   14 +-
 drivers/interconnect/qcom/Kconfig                              |   36 +
 drivers/interconnect/qcom/Makefile                             |    8 +
 drivers/interconnect/qcom/qdu1000.c                            | 1067 +++
 drivers/interconnect/qcom/qdu1000.h                            |   95 +
 drivers/interconnect/qcom/sa8775p.c                            | 2541 ++++++++
 drivers/interconnect/qcom/sc7180.h                             |    4 +-
 drivers/interconnect/qcom/sc8180x.c                            |   38 -
 drivers/interconnect/qcom/sc8180x.h                            |    4 +-
 drivers/interconnect/qcom/sc8280xp.c                           |   25 -
 drivers/interconnect/qcom/sc8280xp.h                           |    4 +-
 drivers/interconnect/qcom/sdm670.c                             |  440 ++
 drivers/interconnect/qcom/sdm670.h                             |  128 +
 drivers/interconnect/qcom/sdx55.h                              |    4 +-
 drivers/interconnect/qcom/sm8150.c                             |   21 -
 drivers/interconnect/qcom/sm8150.h                             |    4 +-
 drivers/interconnect/qcom/sm8250.c                             |   21 -
 drivers/interconnect/qcom/sm8250.h                             |    4 +-
 drivers/interconnect/qcom/sm8550.c                             | 2318 +++++++
 drivers/interconnect/qcom/sm8550.h                             |  178 +
 include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h           |   98 +
 include/dt-bindings/interconnect/qcom,sa8775p-rpmh.h           |  231 +
 include/dt-bindings/interconnect/qcom,sc7180.h                 |    3 -
 include/dt-bindings/interconnect/qcom,sc8180x.h                |    3 -
 include/dt-bindings/interconnect/qcom,sc8280xp.h               |    4 +-
 include/dt-bindings/interconnect/qcom,sdm670-rpmh.h            |  136 +
 include/dt-bindings/interconnect/qcom,sdx55.h                  |    2 -
 include/dt-bindings/interconnect/qcom,sm8150.h                 |    3 -
 include/dt-bindings/interconnect/qcom,sm8250.h                 |    3 -
 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h            |  189 +
 41 files changed, 8071 insertions(+), 207 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/qdu1000.c
 create mode 100644 drivers/interconnect/qcom/qdu1000.h
 create mode 100644 drivers/interconnect/qcom/sa8775p.c
 create mode 100644 drivers/interconnect/qcom/sdm670.c
 create mode 100644 drivers/interconnect/qcom/sdm670.h
 create mode 100644 drivers/interconnect/qcom/sm8550.c
 create mode 100644 drivers/interconnect/qcom/sm8550.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sa8775p-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdm670-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
