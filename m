Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDA0642E9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiLERYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiLERYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:24:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87212629;
        Mon,  5 Dec 2022 09:23:56 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-096-035-193.ewe-ip-backbone.de [91.96.35.193])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B826266023A1;
        Mon,  5 Dec 2022 17:23:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670261034;
        bh=qlnzhQ44iCK3pxL9XYC8nPs32bPPQp/Y7GvWZaFXzdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbF0Abxj1jmFaw9yhf7VPP9X7K0LkWxknlkfrdIjPR7q+fW0DDLOWlqSHBfdmVzJF
         +7HNb1SS7zL95+VKK5tk1NC5A4Y0xPoudbih0FS3WhLFepHpe4kDHGgpT233eH2r99
         iI26tKAqNnWytHuodjMcWMerrMCq17TNXQJHwvzresPUGB2CV7QONSzEH5vJz675hw
         Bu1d8FQrcVPmkwd6beT+SdsMIVmBrSWvHcWqTY2I1/T4msBvQIxtFtZDoen+uLHZI4
         dnV5xvO6xnzcjXR+biwEYABiSSgibDDElyTL/7S6Dvd13RjJ5fEOC87oJevOvdF0XH
         A+Ge4TKhXldOA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6B419480108; Mon,  5 Dec 2022 18:23:52 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Rob Herring <robh@kernel.org>
Subject: [PATCHv5 1/7] dt-bindings: soc: rockchip: add initial rk3588 syscon compatibles
Date:   Mon,  5 Dec 2022 18:23:44 +0100
Message-Id: <20221205172350.75234-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205172350.75234-1-sebastian.reichel@collabora.com>
References: <20221205172350.75234-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IOC and PHP GRF syscon compatibles for RK3588.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 2ed8cca79b59..e682b407a383 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -20,6 +20,11 @@ properties:
               - rockchip,rk3568-pipe-grf
               - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
+              - rockchip,rk3588-bigcore0-grf
+              - rockchip,rk3588-bigcore1-grf
+              - rockchip,rk3588-ioc
+              - rockchip,rk3588-php-grf
+              - rockchip,rk3588-sys-grf
               - rockchip,rk3588-pcie3-phy-grf
               - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rv1108-usbgrf
-- 
2.38.1

