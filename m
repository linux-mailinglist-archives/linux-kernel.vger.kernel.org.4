Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4B5BB0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIPQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIPQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:07:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E7B5E76;
        Fri, 16 Sep 2022 09:07:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r18so50471256eja.11;
        Fri, 16 Sep 2022 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=X7BPGnF6bQ/0IRe6FDfv4l/ZtO8PuWKe/uq2hZ61y7U=;
        b=Jdabwp67LYUAW9I9VxvpApOfvHk68AjZMmlOdtwoeMK912DF3zdtPYzK7kgJ9Pnu1c
         Ur0EpX46LsFHclT6w3+VaiGR/EC9NHg+qYY6ePxdZ1fJAu4blA11vCT5y1TvM0h23j7F
         KBghYRSJfKem7P28MKbN/i7/6QsmZI3fgvIbOsqC/HiABX9XU0PTIQpki6pdmS3C5nfw
         +6Ctzf0gBuVcau1ypj260B5p8rN4APHrKwCAN5PrSSUo4XNIiNgfllbdEWtCW8VfiznC
         vQWGAoco7B4HlfxsHlv8xy7cySp/S+OLcSb0DX8c0QYYjWp085rdyCOLN03dIsMUEx0g
         PTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X7BPGnF6bQ/0IRe6FDfv4l/ZtO8PuWKe/uq2hZ61y7U=;
        b=hVvnW8hsa1LqLh7fFQBzNOPdlfaMP7u/12YlrXdn06YYsLMVoAOcH03w1QnvwMuw6Q
         zp68GcAz21KSisfrsBzDWA+9WfTJdCgTR7dvTq9T0Hp8jHexkVtgYMO33zbRwSeFkotq
         M5khACPA70wd3no03MmhL37Yp95xl8uTgV3uCqu9BeGkcjkKqJ6LR/x5hO/ilSBd+w4t
         w1xREhaglOPTy6qKcKRjQpaSMBNN+KoSYMw9qhvUEDJq6tBEbSqQKoDeHYOV5ICxThYn
         pyPUxzeTTO0AyxaRbJzlDR28TJF0eBo442YXmi/ZnoZkjZt13A8LkaPQB5USnyN1JiVT
         /Q7g==
X-Gm-Message-State: ACrzQf0cl9m+NSaZOUe8UC25QuYSWeHjkfiUbqvVDiuh4vVT7unSFGOJ
        eeg62LOUetEN+1qgQZYOsRE=
X-Google-Smtp-Source: AMsMyM4NMrkny7V6n7+dfQMX6Ljm9KhAyl+R5E60PQt4/m8P+4y5f90uayPLL6lGRpbQVAu1vwwIFA==
X-Received: by 2002:a17:907:dac:b0:775:58d2:defe with SMTP id go44-20020a1709070dac00b0077558d2defemr4080095ejc.231.1663344461400;
        Fri, 16 Sep 2022 09:07:41 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id e9-20020a056402104900b0044f2564c28csm13425046edu.20.2022.09.16.09.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:07:40 -0700 (PDT)
Date:   Fri, 16 Sep 2022 16:02:53 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: dts: rockchip: k3566-quartz64-a: refactor
Message-ID: <YySeLfQp5aXt0VY+@lab.hqhome163.com>
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

Splits DTS for accommodate the new versions

Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile                    | 2 +-
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-usb3.dts  | 9 +++++++++
 .../{rk3566-quartz64-a.dts => rk3566-quartz64-a.dtsi}    | 5 -----
 3 files changed, 10 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-usb3.dts
 rename arch/arm64/boot/dts/rockchip/{rk3566-quartz64-a.dts => rk3566-quartz64-a.dtsi} (99%)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ef79a672804a..8c843f6fc3cc 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -59,7 +59,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
-dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-usb3.dts
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-usb3.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-usb3.dts
new file mode 100644
index 000000000000..1739c00ea9e9
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-usb3.dts
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3566-quartz64-a.dtsi"
+
+&usb_host1_xhci {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
rename to arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
index a30b17fd3c27..f92675627575 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dtsi
@@ -788,11 +788,6 @@ &usb_host0_xhci {
 	status = "okay";
 };
 
-/* usb3 controller is muxed with sata1 */
-&usb_host1_xhci {
-	status = "okay";
-};
-
 &usb2phy0 {
 	status = "okay";
 };
-- 
2.34.1

