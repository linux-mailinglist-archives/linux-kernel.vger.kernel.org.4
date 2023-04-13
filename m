Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2530A6E140D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDMSX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDMSXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:23:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A165FDE;
        Thu, 13 Apr 2023 11:23:52 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-251.ewe-ip-backbone.de [91.248.212.251])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64B11660321F;
        Thu, 13 Apr 2023 19:23:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681410231;
        bh=ceCvJVoRaeOT7KtfXBOMzQenfXD9/YcDHtgkd0grO5I=;
        h=From:To:Cc:Subject:Date:From;
        b=V7dptM9E0HGv6p1NV98J9w4RK9Ya0ZECp3BZfgwBAI6ZXkHy+BswJiqcA1ruuNVr8
         9GuybvbDaFC2+Jd2RsxTK1lsIAmqAjxkxSoql56znB+2eE1/T9Ru5EQR9wIMt9vlRh
         tdAyw1bwnHZfDWrQ7RumJ3ncS6ov4lHh9qnvFdEH9d27+hhr/bPV5pi6M3gskuWXBS
         7Xy/uv40SUvVjFZwliogCmO9pUCpIJ5MFKOTObDRbMK+670ka6XmKDDyFIJa/b2ynJ
         Lv+JDFimRO/ymRIeOiRhafdAGgQEEZj+lCTwsBQuP96uwheTtzXz0W+vYacLp4Jh3O
         gjXrv/TvSaIgg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8812A4807E2; Thu, 13 Apr 2023 20:23:48 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 0/5] Add RK3588 SATA support
Date:   Thu, 13 Apr 2023 20:23:40 +0200
Message-Id: <20230413182345.92557-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This enables SATA support for RK3588.

-- Sebastian

Sebastian Reichel (5):
  dt-bindings: soc: rockchip: add rk3588 pipe-phy syscon
  dt-bindings: ata: ahci: add RK3588 AHCI controller
  dt-bindings: phy: rockchip: rk3588 has two reset lines
  arm64: dts: rockchip: rk3588: add combo PHYs
  arm64: dts: rockchip: rk3588: add SATA support

 .../bindings/ata/snps,dwc-ahci-common.yaml    |  6 +-
 .../bindings/ata/snps,dwc-ahci.yaml           |  6 +-
 .../phy/phy-rockchip-naneng-combphy.yaml      |  7 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml |  1 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 44 +++++++++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 90 +++++++++++++++++++
 6 files changed, 149 insertions(+), 5 deletions(-)

-- 
2.39.2

