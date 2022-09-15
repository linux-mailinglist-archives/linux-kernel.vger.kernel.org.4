Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C946A5B92A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIOCZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiIOCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:25:21 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690032A72B;
        Wed, 14 Sep 2022 19:25:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k13so7304497ilc.11;
        Wed, 14 Sep 2022 19:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=2NoktbIiSlqGVXDfDsvBOUaqmFnhtIoGi/ubnjmPmw0=;
        b=n9+8j3Z+QrBs2/iOLNGP3f7ckPoQE6B8lPiep7Ltd6EquJAkn3H6+p0+c6TqYHBwRL
         nLTHYLfS/yUxT6MB5hERxmRNUW9cXGEqE1IhBatA6EaavxjGtPWNAvyF51A+hM1Ahrh7
         TNX/xc1qIwNfk4DwZkfnR/8yUpZ4rgpE09UlA5ZSKgQjsAMH76KvIJkfomlt1edO09XG
         Bw24kzlMEiBIuUZVfTEms/+Q0DcogO9u5YcKh9K2joIgTGVgbpkMz2EZqw5B3odnJBpL
         x2dMn9HG2JC50Ym+7vmeP6FnoYqlQYfA83NBAFvPgOfScbwV8XPpZ3pje+lnl1+o3ACs
         2kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2NoktbIiSlqGVXDfDsvBOUaqmFnhtIoGi/ubnjmPmw0=;
        b=YdN8tn5uAwSDepWcND2REU04JkuPXcpZeBg6yYOh5IQ8OZfozYEfMKqKAO9aIxV3zD
         cLUWrO5EaRsApd0CuvokushP2V4wclTt9ZBZ0PZ7BrOdQhD+pZfHfuv7PxI9KuCXDKs5
         DqnjT5iKFnQqNfmQUP2MYSeSnrWATm0zX3wrDMttkxY0tGVf6/dHtF+lOLYolZ8b2+2d
         QTUtk34rk5YCoJ+t26fdjOjgV6b0KZhHIK5d93tv7yiKP6/jbDWSll4xVm8whOYoAlFr
         a74Ru+DUNIm6bk7lJeafsDGxe26kceRf4m1EUK08z+K/uYU8MMsP8BzN1UVWnxn/r1W+
         kp1w==
X-Gm-Message-State: ACgBeo3QOcnbfaiWA6vVSgi5/JivQDDnQMM3VXRvqCU/SKQyYuMi6t3s
        HQBC+uWWAjOakJjAuXey1Lg=
X-Google-Smtp-Source: AA6agR4CbqdmJiT/nd3Gj9BxjZIEKPlErkGT+ql9DX2sJXmdOKYe8eBLeM6QlkOFEEHbAEpEdq6dgg==
X-Received: by 2002:a05:6e02:508:b0:2eb:543:bd66 with SMTP id d8-20020a056e02050800b002eb0543bd66mr16094275ils.207.1663208719754;
        Wed, 14 Sep 2022 19:25:19 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id g3-20020a056602072300b006a11760aebbsm7238461iox.36.2022.09.14.19.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 19:25:19 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: rk3399: Add NanoPi R4S Enterprise Edition
Date:   Thu, 15 Sep 2022 10:25:11 +0800
Message-Id: <20220915022511.4267-2-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220915022511.4267-1-cnsztl@gmail.com>
References: <20220911040628.13774-1-cnsztl@gmail.com>
 <20220915022511.4267-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only diffrence against the standrard edition is that the enterprise
one has a built-in EEPROM chip which stores a globally unique MAC address.

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../rockchip/rk3399-nanopi-r4s-enterprise.dts | 29 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ef79a672804a..04562f8b10ac 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -40,6 +40,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s-enterprise.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts
new file mode 100644
index 000000000000..a23d11ca0eb6
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s-enterprise.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+#include "rk3399-nanopi-r4s.dts"
+
+/ {
+	model = "FriendlyElec NanoPi R4S Enterprise Edition";
+	compatible = "friendlyarm,nanopi-r4s-enterprise", "rockchip,rk3399";
+};
+
+&gmac {
+	nvmem-cells = <&mac_address>;
+	nvmem-cell-names = "mac-address";
+};
+
+&i2c2 {
+	eeprom@51 {
+		compatible = "microchip,24c02", "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+		size = <256>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		mac_address: mac-address@fa {
+			reg = <0xfa 0x06>;
+		};
+	};
+};
-- 
2.25.1

