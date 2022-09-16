Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963595BADAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiIPM6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiIPM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:58:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E5585A84;
        Fri, 16 Sep 2022 05:58:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z21so31375554edi.1;
        Fri, 16 Sep 2022 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=IG4b/9qkVqXv7kLI2B6K6D4fsAXw0d141JxQKyJNYJk=;
        b=NTTHo2e/DLNQhPAGpNTyU4dy3HZlapFC+TotD6eGY2iPZWGaQKNtP+zZNY6b8s3nNM
         6VflsjiW6wsi/Ez5G42TUhdjM9bxVNHHgBsUs0SgIv9rDGlcqSJ9XdZszt3SbJKCiXTb
         IjWkYFXfsrnjsKJ4iKBK/cp17oyHgREi0y7O40gMwt9H3GJPxGYN60SCS2hX/Afcyegm
         iOZZpXbm0Ak1JndAxZlTMGFRAzRq+GqdZh6sMSsdf8wBm03VuXXUl6XIdH+JhJxAqX5M
         cznDeN8eLwa5yc4gjy6hcyBP5/Nti0JD6LEgZoRt7cEE+qxiMjfYCE/UMglfooyZMIgy
         aNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IG4b/9qkVqXv7kLI2B6K6D4fsAXw0d141JxQKyJNYJk=;
        b=oMfaxuhIp5/PhAPZpER/ipGISFVUhjxbz+x770nyQHig/hm9rcm0ca8gcY1ewzbIro
         Zkg7Ow7FJqKReDPnKRIHHXuI1t4SRDf/+1JoK/k8jmowstebfckQ15RdQA4YRgmBqnhl
         ey1QhID7CgCh3d3edZmbvO3moVLOl93JMqVXCDA7Ak/Q+jG9NilV6+bS/jye7TgCOWX1
         cumUFHuGVb9Oj1mSnVzwNYInEm6m8ggPTejWcw7q9zq12ZvoiZiB53yJG5pZ7xDAa0my
         Hgfjjh7pi2Etppc9qEqpVR4TAF2gy3fyeLsiK2TfKwscFdVxp2SBYCUjNsldVHXSZ7zV
         9oCw==
X-Gm-Message-State: ACrzQf0XhWbb82jTRc8+W2Wa7QjnVewUQVNlNCF+dSvloVyHyvTgObI4
        Jmg0xEakrv7uIFFVhPB2n4yvm1qwEi32Ur+z
X-Google-Smtp-Source: AMsMyM5CExtLOFCePMl0RMPVGwK3oViHoN7dQl3B8bnKvLCi6yrSzLlQag+b8ZIbNeRC9aLaK3v99A==
X-Received: by 2002:aa7:cada:0:b0:452:5b04:efd9 with SMTP id l26-20020aa7cada000000b004525b04efd9mr3877637edt.84.1663333094399;
        Fri, 16 Sep 2022 05:58:14 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id n8-20020a056402514800b00451319a43dasm13358711edd.2.2022.09.16.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:58:14 -0700 (PDT)
Date:   Fri, 16 Sep 2022 12:53:27 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Add sata version of the quartz64-a board
Message-ID: <YyRxx4zovhMMeQYV@lab.hqhome163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Quartz64 board is built upon Rockchip RK3566.
Rockchip RK3566 has two combo phys.
The first connects USB3 and SATA ctrl1, and the second PCIe lane and SATA
ctrl2.
The second combo phy is hardwired to the PCIe slot, where for the first,
the hardware on the board provides both the USB3 connector and the SATA
connector.
This DT allows the users to switch the combo phy to the SATA connector.

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile                   | 1 +
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 97ec6c156346..5c82881a92d3 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.usb3.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.sata.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
new file mode 100644
index 000000000000..8620df7ec01e
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.sata.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3566-quartz64-a.dtsi"
+
+&sata1 {
+	status = "okay";
+};
-- 
2.34.1

