Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5068E497
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBGXr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBGXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:47:57 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D106A37F15;
        Tue,  7 Feb 2023 15:47:55 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id v15so6905219oie.9;
        Tue, 07 Feb 2023 15:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL2rT8laHFrNHHzc0odSdyPcsgeRUMEPIV17VsWonL8=;
        b=emrDFWTNba9MqG1BFPIoi2okPSxFzhbtKBlhYLfKkXqS5h5tDZdWX7YlfPXVBY8OGD
         fff+ZTgipH+f17M2x6MnH8tkWGq8JsNQhzO7wMZ4zQ3tIYvow4/95A5UaapwYyh2tpQN
         CRns8p3ldYSebSyO6V9bp+/JXb+Ezp3fcBzzgQXgZBfanghlgds/b4qJlErYF54qQzSB
         WV6lW4RKjgeAp/Yle2cdVif+ZR56Tfk7CYz9MDJ8k3kveVv3WX2/Y2KXIy8LV4SGO+CP
         UogmgVfLj9NMzP/5kCy8R5gR0Hshwg6yb3w1TEvK5GfiMBG4wuMZ5aMncWj781KUwGg/
         ObDg==
X-Gm-Message-State: AO0yUKXUmRe5v+iw1M1X746kjs+PtHpVMfKy2EW02ft/Xq+nGkQrrtt9
        MJI3WhKwVr80a29OYxS1pg==
X-Google-Smtp-Source: AK7set9mEgjabLC+0YQc+pN4njFP8njRI1lxOsmHIovGnu2s7Rd5IBpIQyY9cx/D1mgwiIugZh4B3A==
X-Received: by 2002:a05:6808:408c:b0:364:c9b7:bc with SMTP id db12-20020a056808408c00b00364c9b700bcmr2077193oib.56.1675813674986;
        Tue, 07 Feb 2023 15:47:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v4-20020a056830140400b0068bcadcad5bsm7199442otp.57.2023.02.07.15.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:47:54 -0800 (PST)
Received: (nullmailer pid 202269 invoked by uid 1000);
        Tue, 07 Feb 2023 23:47:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3399: Fix GICv3 ITS node name
Date:   Tue,  7 Feb 2023 17:47:49 -0600
Message-Id: <20230207234750.202154-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GICv3 ITS is an MSI controller, therefore its node name should be
'msi-controller'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 4391aea25984..588e1509e423 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -552,7 +552,7 @@ gic: interrupt-controller@fee00000 {
 		      <0x0 0xfff10000 0 0x10000>, /* GICH */
 		      <0x0 0xfff20000 0 0x10000>; /* GICV */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
-		its: interrupt-controller@fee20000 {
+		its: msi-controller@fee20000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
 			#msi-cells = <1>;
-- 
2.39.1

