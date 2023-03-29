Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3F6CD592
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjC2Iz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjC2IzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:55:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C274C19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so9049770wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoTSIHWCMaC55e5uUwc/Xt3kUwKDqCkH1f0U1BWd1Rg=;
        b=cM1dYwxKoMoBPx4ir88db9bhtpRtAuAwvkrO1K2goIG09KJORNvZDhjjo26vPGEK7A
         tx07C4sDpHEpspDdm7DePNtX/yvzaW1AcAaj956grg7Ss5Zu0ptJ6nbdFgdnuUW/NiC8
         ssG1kbKpcppz/3L7cvkY6v6FiFZyX5uJ7uzo3qpVg/Ce6ATKmhyoxU/6tLQcXR1XzPvf
         ooAssGlJ25T9eLa7rfUXjwABJr5sQJV6Zg4van4Rb0ik7H4igGY1qhzq2X6YNSSpZYpf
         mnG0TS84+sNw/umm3h8lrmLWQHcd7l+ptNuzOZSWjHE5ECIrBZND8AGyVMxp/aJQ0OFd
         /3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OoTSIHWCMaC55e5uUwc/Xt3kUwKDqCkH1f0U1BWd1Rg=;
        b=eSx+o1lT+HSkBxMuj3g1XH/RJpietss7sV1C9bNdEL26GiXM/cxGUAKmvkaCHFI8LW
         4hH5PNDT9DvxhL3eXmpwFVlZ1ZbS9hxfgkrYzxnCbDzqncYAmxHSAcKOi3/cK6ew6TPt
         omcxRxtu3OWJnxYqVJTN8a7hR0vULHIuRSLbEBKhD16CbgWPqvHVxOVa1bHTsx3StVKO
         npXevyaMBGD2vrdVz/x70RAGZmm0lZvmOApltAH76glrENsMIhB8uL650zSNdRk59ALo
         mtVP4LIxs/KhCvjPoNCu13/TPDpw1fuz5C+9M5GUEdN8caNwu1mij5xHrNLReX5R1iqL
         nrpQ==
X-Gm-Message-State: AO0yUKWdh/a3aT7VNckXrJcYPh536Ri7Md3zv3V9pktwr4wtIZb8sC0y
        SY1o01mqbyWCEBaBe+TxoJTjuQ==
X-Google-Smtp-Source: AK7set86EYENK4NSOAScRj3krY9Lf0QXLGnpUu/f6vUEdOr1Dk5CcEjrVpKpFJzz0cui5O75amYE1w==
X-Received: by 2002:a1c:7319:0:b0:3ed:31fa:f563 with SMTP id d25-20020a1c7319000000b003ed31faf563mr13248678wmb.20.1680080106823;
        Wed, 29 Mar 2023 01:55:06 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:55:06 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 10:54:33 +0200
Subject: [PATCH v3 12/17] arm64: dts: mediatek: add ethernet support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-12-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=7cNEQ8Z3d2N18bBB0ySn0ca/dVK3FcA8H0h1LVefyV8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zcQ2qKeCqrMP79V92+YPoOhtlDtftApPNzGkg1
 h7TrO5aJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP83AAKCRArRkmdfjHURV3xEA
 CSZoyscKEYe7T0Ft3YDPl9VOZdvmX7yZyAEWVJhJzppyb+HSz55wTp/dK6K4/pDgWPFiDbwjBMP2q6
 d0kIXSdFnhCj39ysnro6ODeo1eOA5LOdGXmtusno+AxlJV1/UWe9QrRSa8BKEk6vfsIm+E8LbnXl5g
 4mVExdV/iF1G6trhPMEC7stxu51G+/R/NtEyQyqUHFYg1ZbAOnnXz0uLsaYO2+FBVWdp/HMAPj4cQo
 pLFJoN6WOII2P07Q2zxJpTjmUmfnzL/1kvDxLwrbGVORNEQpBEpd5x/HVffMko7QpqQEociMMxu14d
 X3nznrGUwMMvPIZItAOVJvqDPh9qBRoAMFE6FxcPa7VfJ5zVwdUy7FbkNccmtJbPuJxL6l0Ji4MDss
 AQMCHekt9oagccrLYS0pspSaaeasktOsm59qcD403dys/j9gMinoHanal4YCtZG6u5ZpMOHFZGYBJF
 zIsO88urfOIeBY2WGcLLLifHEZwcgUmQoBsggt2iHjhlQiiTMyZ1f+1ubHnMym4KGk+TaG5qPPbAy5
 o3yEYKY+4BZEIyofINuqS3JrFWzowGZBgRh5N8dgZILCzIC76qB7h/L+8VqNo03gXXAniUdoMxNL5l
 cGQJ0WY1xPx89aOQzi+PWAm9KpoZs7L/ffDiRx4HHIVB1/HztjCbKuo2ES0w==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This IP is a 10/100 MAC controller compliant with IEEE 802.3 standards.
It supports power management with Energy Efficient Ethernet and Wake-on-LAN
specification. Flow control is provided for half-duplex and full-duplex
mode. For packet transmission and reception, the controller supports
IPv4/UDP/TCP checksum offload and VLAN tag insertion.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index a67eeca28da5..394a5a61be59 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -438,6 +438,18 @@ mmc2: mmc@11250000 {
 			status = "disabled";
 		};
 
+		ethernet: ethernet@112a0000 {
+			compatible = "mediatek,mt8365-eth";
+			reg = <0 0x112a0000 0 0x1000>;
+			mediatek,pericfg = <&infracfg>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_ETH_SEL>,
+				 <&infracfg CLK_IFR_NIC_AXI>,
+				 <&infracfg CLK_IFR_NIC_SLV_AXI>;
+			clock-names = "core", "reg", "trans";
+			status = "disabled";
+		};
+
 		u3phy: t-phy@11cc0000 {
 			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
 			#address-cells = <1>;

-- 
2.25.1

