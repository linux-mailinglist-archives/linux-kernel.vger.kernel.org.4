Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926A272905C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbjFIGsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFIGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB911FDF;
        Thu,  8 Jun 2023 23:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DEF865418;
        Fri,  9 Jun 2023 06:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1E5C4339B;
        Fri,  9 Jun 2023 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686293280;
        bh=qHylMj+O05wPU2VW1GAa6GYS/uQ6kFv5HBrVK/YKR0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AxvpGWngHVM0reEcrMhJ4OZJ30v4PAc+Z5PEHVsC14WimGkcAZJLXyiqiNTSbCi2+
         0KM3Xm36YYR4YnABIZsWqjBXYQb1IQWkOacgpZxVAl4xqOF8jeWGxbOxManjlUzfug
         ck9lims1kEwL0PRwf28WkaPG50YXGmLYr00j8I2cz8mlkfCoLTedC+PsaAfrsiH0u/
         0q6quWtaAu3+cqJ9QaI2OcaRyXW7UkLlwOpBNqS3W0c9JcRndP+M7JVLLtbccZ713f
         o7iVFkOHwKJELhH+3Yrs3vMJgyqbSnC1ag5tIL5w9Xqxg55BA01J6LzeEoGOLwlxRL
         J+1CAvpaRiUmw==
Date:   Fri, 9 Jun 2023 07:47:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [GIT PULL] Immutable branch between MFD and Power due for the v6.5
 merge window
Message-ID: <20230609064753.GL3635807@google.com>
References: <cover.1684182964.git.jahau.ref@rocketmail.com>
 <cover.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684182964.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-power-v6.5

for you to fetch changes up to b54185c1e3b02c91e4a190ac5c346ea7bfb0de93:

  dt-bindings: Add rt5033 MFD, Regulator and Charger (2023-06-08 18:18:13 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Power due for the v6.5 merge window

----------------------------------------------------------------
Jakob Hauser (8):
      mfd: rt5033: Fix chip revision readout
      mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR defines
      mfd: rt5033: Apply preparatory changes before adding rt5033-charger driver
      power: supply: rt5033_charger: Add RT5033 charger device driver
      power: supply: rt5033_battery: Move struct rt5033_battery to battery driver
      power: supply: rt5033_battery: Adopt status property from charger
      dt-bindings: power: supply: rt5033-battery: Apply unevaluatedProperties
      dt-bindings: Add rt5033 MFD, Regulator and Charger

Stephan Gerhold (1):
      mfd: rt5033: Drop rt5033-battery sub-device

 .../devicetree/bindings/mfd/richtek,rt5033.yaml    | 138 ++++++
 .../power/supply/richtek,rt5033-battery.yaml       |   2 +-
 .../power/supply/richtek,rt5033-charger.yaml       |  65 +++
 drivers/mfd/rt5033.c                               |   8 +-
 drivers/power/supply/Kconfig                       |   8 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt5033_battery.c              |  38 +-
 drivers/power/supply/rt5033_charger.c              | 472 +++++++++++++++++++++
 include/linux/mfd/rt5033-private.h                 |  64 ++-
 include/linux/mfd/rt5033.h                         |  24 --
 10 files changed, 762 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5033.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt5033-charger.yaml
 create mode 100644 drivers/power/supply/rt5033_charger.c

-- 
Lee Jones [李琼斯]
