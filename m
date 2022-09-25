Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D915E9331
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiIYMsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiIYMsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:48:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A02317C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:48:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 10so6984590lfy.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nabam-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=k0LfxC9fXdLeVg8llNzyGQ2aBnuToclD1TAWlwxISbg=;
        b=2WCPKE4YIUXioVBIwaEN+GiNbb6cBHV2hWd/nOKEiVQeECh7yUNLrsZXUmj356yc9Q
         PrmP98W9mY0koDEAPY9WWhT/DDHrM+CgPmRBX8pK7eHA79Ytaxxwk0dcbrHX7ZmggZdU
         FV1K/dedeI6DzbIut3OULpJ0RZ+ij1/n+0URvI0Kr0pypvW1FODBCfvSBM0j1+SfoWrh
         gTZ7/+a4C32JDSiUNFSWAtoG75x8KZfhenj6xdZQYzbvaxuTuNo4ngAZp3VuEmvatXq4
         zqFqRsiggVqezPpAnCONNB3ycqvG5/kBAy+ZE0stuc6pcDSWuu0pi846f6sA/4lk/IiV
         CYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k0LfxC9fXdLeVg8llNzyGQ2aBnuToclD1TAWlwxISbg=;
        b=uWMc2xuSaczrEtU/RA48U/SFRFg6t+oTHiG7FZRaQtBabZlUb59TSEinh17s2npbIM
         wr+myy5Bn4Tmnh9dr6t27MPOW1C7lXuzpY7kYyoa45GXqRYnzlODjDb4fw2K8zxQyDdI
         S6sI8x+2hGArNBptgsT7tfFtG4CceUQpJQoWGTQGm8y5ldXFol/Vnek8jWFbh9WMJhlP
         bdiDn04QPeWjSKSHX/5iZfmxJB1ASmuYSI1Ix1gm4zo3cysFj7+eS/EwI58Hb7zDRph6
         BirCeZVKcMkEsBNkLmkPkuseBqKsIWl0QxnSvLs5YGThN6sKzPciGeqXwL3huTwW3eF3
         Btnw==
X-Gm-Message-State: ACrzQf1UymFX0hmQPtxzLENtlh9/mrolS0qwxjRWd/sJ8KuUu+rcSgET
        xyhjKHaM/WE7WsB1jz6QJOXLhw==
X-Google-Smtp-Source: AMsMyM54CDUIlE64+P9Eriqk9a7+P7Az0vpqkB2ry9nh3ZRl44jQqzOS2CeqezxlCs4Jw71ozzWBNg==
X-Received: by 2002:a05:6512:22cf:b0:49e:860d:8f4e with SMTP id g15-20020a05651222cf00b0049e860d8f4emr6654780lfu.584.1664110114439;
        Sun, 25 Sep 2022 05:48:34 -0700 (PDT)
Received: from 16-inch.lan (c-7f0d225c.016-470-73746f7.bbcust.telenor.se. [92.34.13.127])
        by smtp.googlemail.com with ESMTPSA id q7-20020a19f207000000b00494643db68fsm2204936lfh.81.2022.09.25.05.48.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Sep 2022 05:48:33 -0700 (PDT)
From:   Lev Popov <leo@nabam.net>
To:     Dan Johansen <strit@manjaro.org>
Cc:     Lev Popov <leo@nabam.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: fix quartz64-a bluetooth configuration
Date:   Sun, 25 Sep 2022 14:48:24 +0200
Message-Id: <20220925124825.71786-1-leo@nabam.net>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <ce61fb9a-dcf4-27a2-ac03-62060a1512f9@manjaro.org>
References: <ce61fb9a-dcf4-27a2-ac03-62060a1512f9@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For "Quartz64 Model A" add missing RTS line to the UART interface used by
bluetooth and swap bluetooth host-wakeup and device-wakeup gpio pins to
match the boards physical layout. This changes are necessary to make
bluetooth provided by the wireless module work.

Fixes:  cd414d5ac1fdeecf0617737e688a1af00858253a (arm64: dts: rockchip: rename Quartz64-A bluetooth gpios)

Signed-off-by: Lev Popov <leo@nabam.net>
---
 arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index a05460b92415..91908081c5ed 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -740,7 +740,7 @@ &uart0 {
 
 &uart1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn>;
+	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
 	status = "okay";
 	uart-has-rtscts;
 
@@ -748,8 +748,8 @@ bluetooth {
 		compatible = "brcm,bcm43438-bt";
 		clocks = <&rk817 1>;
 		clock-names = "lpo";
-		device-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
+		device-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
 		shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
-- 
2.37.3

