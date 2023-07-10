Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF774DB87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGJQwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGJQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8237112E;
        Mon, 10 Jul 2023 09:52:32 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1AAD96602B7B;
        Mon, 10 Jul 2023 17:52:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007950;
        bh=ABpJQ8z918e5OZkfpgP7HwSnXWU4EFxL3SvzflDiHoM=;
        h=From:To:Cc:Subject:Date:From;
        b=nGNYDGcxK+5wDcCrAZ/2csXrrZCAaOWFOOyDfwc5T7vkrETYIb+QVrafuclahWIxr
         IXE4pd4C+FGuT3BMPNyTVUw3r+bsP5f/dv74DqIUF7UJEPwL48DzCq17O2Yz0kPVJm
         PjA2aBVKVCp5jrI/sElqItEyFPAjVWBj9qENQcctAYj62vGaXxXQT4vGi41pTVnX8i
         2PQAe1Y9dy3EiqR2qiU1z/AZeeY06iEfOhJhTrRG+t3aurbv266IAsu+5F3ezmW76m
         /o9IBSDGg40IAn8IcbLBeeUgWNgxXNM5oQwZhJaUzLW+hIsAG3IYTk3VFqVZq1uXWQ
         kVcv8eJO1TtPA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1980D480592; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 00/13] Improve Rock 5A Device Tree
Date:   Mon, 10 Jul 2023 18:52:15 +0200
Message-Id: <20230710165228.105983-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This brings Rock 5A on par with the Rock 5B. All necessary driver
changes have already been merged.

-- Sebastian

Lucas Tanure (1):
  arm64: dts: rockchip: rock-5a: add SD card support

Sebastian Reichel (12):
  dt-bindings: vendor-prefixes: Add prefix for belling
  dt-bindings: at24: add Belling BL24C16A
  arm64: dts: rockchip: rock-5a: add PMIC
  arm64: dts: rockchip: rock-5a: add vdd_cpu_big regulators
  arm64: dts: rockchip: rock-5a: add 5V regulator
  arm64: dts: rockchip: rock-5a: add status LED
  arm64: dts: rockchip: rock-5a: add analog audio
  arm64: dts: rockchip: rock-5a: add I2C EEPROM
  arm64: dts: rockchip: rock-5a: add vdd_npu_s0 regulator
  arm64: dts: rockchip: rock-5a: enable I2C interface from DSI and CSI
    connectors
  arm64: dts: rockchip: rock-5a: add ADC
  arm64: dts: rockchip: rock-5a: add fan support

 .../devicetree/bindings/eeprom/at24.yaml      |   3 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     | 586 ++++++++++++++++++
 3 files changed, 591 insertions(+)

-- 
2.40.1

