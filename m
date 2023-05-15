Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3C70317F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbjEOPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbjEOPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:24:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB80BFC;
        Mon, 15 May 2023 08:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6140862651;
        Mon, 15 May 2023 15:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DED9C4339B;
        Mon, 15 May 2023 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164271;
        bh=TOYagaF2OGRnswyh28jqySIaCoaZNMX7ZtxpN/6ZW4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlZp68+dEDaJDBwLsJHJrfG7G5nP96VM+syGAf5B6w7O5ESdeNbuMgY19mwuHPI7I
         VBqbc3WMtkgj/G+pmssyh59OmJFajE1+7+gUlJCanH4TttBQf8PDqP8/+3lX9XBlvu
         Y/FfVwyAbXqZbb2vv2raN4GU1oBFh1J7pgUD551wZS4bYnCmhaQTKd9Mjfebcmok7u
         bFETCw0/c3xdRPkCz38urceAQDaSAHTFNXKIPVSIEm3GZoof/BMNptH/t4sYRFfYio
         tDo6DAPEJmHpGKIeHsUqOs6d5Idjbu1M0Bea41a88K0XNMLQrTtl2FLhrtR+KLqVa5
         b2x0E4PaLNhBQ==
Date:   Mon, 15 May 2023 16:24:25 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [GIT PULL] Immutable branch between MFD, Clk, Input, Pinctrl, RTC,
 Power, Regulator and Sound due for the v6.5 merge window
Message-ID: <20230515152425.GV10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tb-mfd-clk-input-pinctrl-power-rtc-sound-v6.5

for you to fetch changes up to 924764aa5f2e705f46f548611e6a9d6b986ae880:

  pinctrl: rk805: Add rk806 pinctrl support (2023-05-15 16:21:01 +0100)

----------------------------------------------------------------
Immutable branch between MFD, Clk, Input, Pinctrl, RTC, Power, Regulator and Sound due for the v6.5 merge window

----------------------------------------------------------------
Sebastian Reichel (9):
      clk: RK808: Reduce 'struct rk808' usage
      mfd: rk808: Convert to device managed resources
      mfd: rk808: Use dev_err_probe
      mfd: rk808: Replace 'struct i2c_client' with 'struct device'
      mfd: rk808: Split into core and i2c
      mfd: rk8xx-i2c: Use device_get_match_data
      dt-bindings: mfd: Add rk806 binding
      mfd: rk8xx: Add rk806 support
      pinctrl: rk805: Add rk806 pinctrl support

 .../devicetree/bindings/mfd/rockchip,rk806.yaml    | 406 ++++++++++++++++++++
 drivers/clk/Kconfig                                |   2 +-
 drivers/clk/clk-rk808.c                            |  34 +-
 drivers/input/misc/Kconfig                         |   2 +-
 drivers/mfd/Kconfig                                |  21 +-
 drivers/mfd/Makefile                               |   4 +-
 drivers/mfd/{rk808.c => rk8xx-core.c}              | 352 ++++++-----------
 drivers/mfd/rk8xx-i2c.c                            | 185 +++++++++
 drivers/mfd/rk8xx-spi.c                            | 124 ++++++
 drivers/pinctrl/Kconfig                            |   2 +-
 drivers/pinctrl/pinctrl-rk805.c                    | 189 ++++++++--
 drivers/power/supply/Kconfig                       |   2 +-
 drivers/regulator/Kconfig                          |   2 +-
 drivers/rtc/Kconfig                                |   2 +-
 include/linux/mfd/rk808.h                          | 417 ++++++++++++++++++++-
 sound/soc/codecs/Kconfig                           |   2 +-
 16 files changed, 1464 insertions(+), 282 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (71%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c
 create mode 100644 drivers/mfd/rk8xx-spi.c

-- 
Lee Jones [李琼斯]
