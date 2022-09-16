Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8925BB0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiIPQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIPQFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:05:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF590248E4;
        Fri, 16 Sep 2022 09:04:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dv25so50380624ejb.12;
        Fri, 16 Sep 2022 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=rWlVk7ot5GMMn9gnnexE4i/HZ7oMWylQw+SYWISjb7w=;
        b=KQWlDVekylhNECjjWL5VUYXDLjrEGnEgeePRlJ+fcRz4TxVe/yd9XiR2/7cdBLsaC1
         S+qIUcORifWveIn1x0utE+U5BRA0gT7weoY9MvGbupg5M4FYDlTFE6BYKXgwfKX5DI0L
         7UMUK/L4CSXIVa1KX9McEpI3+WJF0fOPS9be+HcH8xXOPD0KFyVTuii5IkRnXFVaAKtO
         dbe9xM0Ryt+FXrscbsqYc2mjwf9atXNt7YSroeAC/j2BhTleaMllP2EK2Iy0BSUoGOR3
         yKqFit7s4nzMOskG897V1l1sfXve5rXMUacH8NNo/1Wc6uuuW+qOQiCIbn+XYLaC5yBq
         7tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rWlVk7ot5GMMn9gnnexE4i/HZ7oMWylQw+SYWISjb7w=;
        b=S13fSLPRcMdVrVtC3YutbaW7vpePm5/rJ9mQ25Xm8LWuLImqcTm8SGQN+foLruIqSe
         hNnAUfevh+9lrZk8VYpfmrhgYPfnk1zuYm9xJ2WDF811WYw7VnhWBz9WuTO/gt9aH8Zq
         GtXwEFGd1RayXU2zbiVtQGrQynDVMcSzm7lQWTBIXMt+ldnqLn72D/qOilCcoWZc0nnj
         c0S9cOIit7j16sbhq4fAoctnctWnoxMckY0MGrL06z2RZrRU9G/Wb5a1quZJBBgYLe0t
         8vvy7K6t3w5ukERH/qK1EzO6rmpzlAuxR6OBTXUTiW5ILWOTTap1YPsUPKhScErvOLh2
         IqmQ==
X-Gm-Message-State: ACrzQf2a2qJBkCMY555AFm6iFTPWzc6qV0Y5Jb77a0T0H3LOdZhlk6II
        j1mGMQYpiAA3NHTgijIOacU=
X-Google-Smtp-Source: AMsMyM4FoBNxwSDfv/emZhgJyQZb8xhjBq8mKQJiagaeNUBC68wRS0o0c6l8zzYJ1GrquinfXrE74Q==
X-Received: by 2002:a17:907:3fa6:b0:77c:3420:ab42 with SMTP id hr38-20020a1709073fa600b0077c3420ab42mr4192729ejc.141.1663344294022;
        Fri, 16 Sep 2022 09:04:54 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090631c400b0073d6093ac93sm10859434ejf.16.2022.09.16.09.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:04:53 -0700 (PDT)
Date:   Fri, 16 Sep 2022 16:00:06 +0000
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: rockchip: k3566-quartz64-a: adds sata
 variant
Message-ID: <YySdhiqZgXpl0q/g@lab.hqhome163.com>
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
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 8c843f6fc3cc..1d5dd91d1a34 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -60,6 +60,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-usb3.dts
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-a-sata.dts
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-quartz64-b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
new file mode 100644
index 000000000000..8620df7ec01e
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a-sata.dts
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

