Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538015BE70D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiITN1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiITN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:27:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6E64B0F6;
        Tue, 20 Sep 2022 06:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9BFE3CE13DA;
        Tue, 20 Sep 2022 13:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CB7C433D6;
        Tue, 20 Sep 2022 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663680451;
        bh=emZ0PSvN7PdJPmfg7UowvInfJkjTANIHUiCWV15huMs=;
        h=From:To:Cc:Subject:Date:From;
        b=euL0dHN1z+HxNswXUDd143M2jKANlGQv+76sWsqypWhASSucurFxAkg4GzKyKDdmp
         wdJQsg5o/1RDQMELAs5PVDbtl3EcL7RkSWjhVnUvPE3Vw1l5rh2mVQh5TGDiM+hUBQ
         pWv5Wiv3mEurVDQLV83VKKYRWL05qFAYeuS60ZMbDa7KfD/lJHTmQPGS85zN6f44Js
         LatCP3mq6iIeCZvrTAlRtlKeUSVY3CzM7fws/xGAVXRjKNaQb3tuDzl8mUP2GYoNu0
         FXen0Tq5HXNQMEfrzzf+iAngb9maU0QvpQWNTOV2ZD4eec0sNxyW7YqIRIVipx36DP
         v4kVHR1lrDFQQ==
Received: by pali.im (Postfix)
        id DA93D97E; Tue, 20 Sep 2022 15:27:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/5] ARM: mvebu: Add audio support for Armada 38x
Date:   Tue, 20 Sep 2022 15:26:43 +0200
Message-Id: <20220920132648.2008-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add audio support for Armada 38x. It contains commits
from Marvell linux repository

https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/a1d70444cb0476a7524273274ca8e6d52ce6f1fe
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/f365c93237787c7a64f2617da9425eb01e09e71f
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/b645bfa9121214d6456de3df6b8e577f2c01c6b3
https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/829c96c206f2930e5323064cef57158bd780730d

first two squashed, rebased on top of the current linux master branch
(at v6.0-rc6) with additional patches which adds S/PDIF support on
Turris Omnia - A385 board.

Marcin Wojtas (3):
  ASoC: kirkwood: enable Kirkwood driver for Armada 38x platforms
  ARM: mvebu: add audio I2S controller to Armada 38x Device Tree
  ARM: mvebu: add audio support to Armada 385 DB

Pali Rohár (2):
  ARM: mvebu: Add spdif-pins mpp pins for Armada 38x
  ARM: dts: turris-omnia: Define S/PDIF audio card

 .../devicetree/bindings/sound/mvebu-audio.txt |  14 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts |  27 ++++
 arch/arm/boot/dts/armada-388-db.dts           |  69 +++++++++
 arch/arm/boot/dts/armada-38x.dtsi             |  24 ++++
 sound/soc/kirkwood/kirkwood-i2s.c             | 136 +++++++++++++++++-
 sound/soc/kirkwood/kirkwood.h                 |   2 +
 6 files changed, 269 insertions(+), 3 deletions(-)

-- 
2.20.1

