Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259CD6D25D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCaQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjCaQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:41:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D2F22214;
        Fri, 31 Mar 2023 09:38:17 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-136.ewe-ip-backbone.de [91.248.213.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9FA476603196;
        Fri, 31 Mar 2023 17:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680280696;
        bh=NwhmvCgwedXgOKj8QGZBS+73nuAtMHCK1PojwIJNulc=;
        h=From:To:Cc:Subject:Date:From;
        b=oafzbk93J4uWJGrA9/BmPIM36HVvrENIrRLm0OJLN1bmjubK13Cs+iIQLilL0M3TV
         DSMo+5ZTLRCNjhWZ4wTW6pbHZ9feIGRfIcAjGfG5Tz1xCahHpwGnxbLsmCrfL0PR8n
         Yw9Znw7Alolt1kp1V1MeUrkWhF1P0B0+tIHF4D0vpagFzVfhDxKcIh5sIC/G3W5TCA
         MU9kIGi5L6v/XC9V/EhE7Vaxz2/AB6GpU+IxhCpWfCKVYO52WIrZ0PctpDHxrE0wQu
         stIcrAjGbyHXnwHZ5ljVnzo2YIMq9gu5ulHWwhGbdp296IrN44fvu9PZCqBAndaDo8
         XnII8Tfp/r61g==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E6B104807E1; Fri, 31 Mar 2023 18:38:13 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 0/3] phy-rockchip-inno-usb2: add RK3588 support
Date:   Fri, 31 Mar 2023 18:38:09 +0200
Message-Id: <20230331163812.6124-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds RK3588 to the Rockchip Inno USB2 PHY driver.

-- Sebastian

Sebastian Reichel (3):
  dt-bindings: soc: rockchip: add rk3588 usb2phy syscon
  dt-bindings: phy: rockchip,inno-usb2phy: add rk3588
  phy: phy-rockchip-inno-usb2: add rk3588 support

 .../bindings/phy/rockchip,inno-usb2phy.yaml   |  21 +-
 .../devicetree/bindings/soc/rockchip/grf.yaml |   2 +
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 214 ++++++++++++++++--
 3 files changed, 220 insertions(+), 17 deletions(-)

-- 
2.39.2

