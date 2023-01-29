Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6830267FF9B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjA2Opd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjA2Opb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:45:31 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE31ADFA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:45:29 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k16so6437498wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 06:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3+adTROaQB+gYcBuJMg8idTi/GfFjWlX30uDggGK3g=;
        b=yJxkCDePAZSNSiIp6Ms3j0H9NQgCYu0j0f/BHOuZ1GzoQUXsOC1ppbl7Cmtiznrzx/
         wA0MYkuEXDU68p1lIApL1j6GWw1IbUlUelnXiHdEZl/lnRF6Eo0qTQL0Wy9RcHt0sJI+
         xMx5F+lGstj/0SBWuyNU2iTvHhI/+EEjCrSY3CieBUsYJdjHMbYe7AwPuXTZDJjjA5cr
         SM1WlRgwnnz42D9K30xYafCa+rhT7s8Q6MePm3fEUaq49Lf8kRbM3bIKwXgA9TWcAhhW
         4MKQGgKoeJtVOMo3al7o4fqVP22O4z5AmRL4oxZSq/gl27QYbnxIIb/18kr4wkcH+fOX
         KH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L3+adTROaQB+gYcBuJMg8idTi/GfFjWlX30uDggGK3g=;
        b=PI509FGO+scKWzEnmTNEStiGFRQY+gU4erXWxiUVekYfBewgaavZSL2bjh5+imnROz
         Rtbofeiaa8ozaz09j5f9wXMl0jgeF563Px2xCK2XYZGTVGOaznQWZvhqdEt57+2AEXbm
         IXTVVZOsPoCrZS335+q4/pjTTkVhSztSWcfCkGqzITevHvS2uY9A7ou9680+GSvFsBrL
         BROIWAHWCJH5ww4rS424yX9M/03N6GRllrfzMgxTt2TMNbYuevRFzu/ytDx4HMpQ9nRR
         LYUWfZjC6D04H6dxwYJMt8yM116YRK96wBn3xwpPZIJPlpz7FmpJZnojTONsCDX1iRNm
         pwcw==
X-Gm-Message-State: AO0yUKVOe8h1z8oS21tykdvfYfc2DpbXxhf3w6aTCVt5GvE+FVtpfD4v
        +SZvJidTW2jJ0yBx8dItl5A5bQ==
X-Google-Smtp-Source: AK7set+Sx3rrx+oc+SUEi1ahvM+ewtnnrVP7wTBDdd9hcsB+U6I5HSbLvhQ0mvSzwuidc+pojB60Yg==
X-Received: by 2002:a05:600c:188a:b0:3dc:506e:6559 with SMTP id x10-20020a05600c188a00b003dc506e6559mr4061076wmp.37.1675003528361;
        Sun, 29 Jan 2023 06:45:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b003a3442f1229sm14950038wmq.29.2023.01.29.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:45:27 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] arm64: dts: cleanup for v6.3, part two
Date:   Sun, 29 Jan 2023 15:45:24 +0100
Message-Id: <20230129144525.5802-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cleanup of several platforms, not picked up by maintainers. On top of previous
pull request.

Best regards,
Krzysztof


The following changes since commit d0931f1d5e9c1655cfa8128edd14e813b4044801:

  arm64: dts: hisilicon: align LED node names with dtschema (2023-01-13 11:38:56 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt64-cleanup-6.3-2

for you to fetch changes up to 9f2c9170934eace462499ba0bfe042cc72900173:

  arm64: dts: amd: use "okay" for status (2023-01-28 11:16:00 +0100)

----------------------------------------------------------------
Minor improvements in ARM64 DTS for v6.3, part two

1. Drop deprecated "device_type" property from serial nodes (apm,
   amazon).
2. Align UART node names and OPP table names with bindings (hisilicon,
   realtek, synaptics).
3. Use "okay" for status, as expected by Devicetree specification and
   dtschema.

----------------------------------------------------------------
Krzysztof Kozlowski (8):
      arm64: dts: apm: drop deprecated serial device_type
      arm64: dts: amazon: drop deprecated serial device_type
      arm64: dts: realtek: align UART node name with bindings
      arm64: dts: hisilicon: align UART node name with bindings
      arm64: dts: synaptics: align UART node name with bindings
      arm64: dts: microchip: use "okay" for status
      arm64: dts: apm: use "okay" for status
      arm64: dts: amd: use "okay" for status

 arch/arm64/boot/dts/amazon/alpine-v2.dtsi          |  4 ----
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts   | 16 +++++++--------
 arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts   | 24 +++++++++++-----------
 arch/arm64/boot/dts/apm/apm-merlin.dts             | 16 +++++++--------
 arch/arm64/boot/dts/apm/apm-mustang.dts            | 16 +++++++--------
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |  1 -
 arch/arm64/boot/dts/apm/apm-storm.dtsi             | 16 ++++++---------
 arch/arm64/boot/dts/hisilicon/hip07.dtsi           |  2 +-
 .../boot/dts/microchip/sparx5_pcb134_board.dtsi    |  2 +-
 .../boot/dts/microchip/sparx5_pcb135_board.dtsi    |  6 +++---
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi           |  6 +++---
 arch/arm64/boot/dts/synaptics/berlin4ct.dtsi       |  2 +-
 12 files changed, 51 insertions(+), 60 deletions(-)
