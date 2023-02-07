Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EAD68E494
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBGXrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBGXrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:47:46 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727037F15;
        Tue,  7 Feb 2023 15:47:43 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-169ba826189so21166022fac.2;
        Tue, 07 Feb 2023 15:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJ2eOS/XFsVle72C4v0NKkwAHsXsOjaJ9annmYtNuRE=;
        b=eOVOhySU/PPq/sZ1s90m6by42Qj30Rb/OtbuAp6LROQhRb+R6XgDdcvhjG6+QDamZU
         rumMCo98/HcH8O9X0SA8cAeL3MEbnaYrWHwt/17g0FdzpQehT1LXaQVsFOb5wFRrFDy+
         vh3Mxl6YAqohhj9ntLLDH69YggF0Q8EH9q1645exT9FARoEhLh82wkvq7QenE7exY7yv
         tkGCF30xUKA7lMXr66DvZz38a91jHLxpMOmdcVJrrHNWqlqLERnYorbzWJ+2s2XkivAd
         O53KqhcQBSfC1l48SkLpEvSLh6LtOjoFRLZiCP96vBDn7ZwZQpPKrbbSKPCEk+VALap1
         WlGA==
X-Gm-Message-State: AO0yUKVEqLn0WH0TYQgqdR/m2sxXaSOlbz1H/MLln4El6WxC8LqcR+HO
        cc0YffHlEQCHWX6rw8C/sITVn7ccgQ==
X-Google-Smtp-Source: AK7set/ZIqj3PmZgqPokyzqN0iJQ/O0C7nDqIxDgd6T/JpL9OkJYVSCwBouvGXMu4XwUwnkN+TBfNg==
X-Received: by 2002:a05:6871:214:b0:163:b347:22f7 with SMTP id t20-20020a056871021400b00163b34722f7mr2677367oad.28.1675813663173;
        Tue, 07 Feb 2023 15:47:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i5-20020a056870220500b0015f83e16a10sm6032790oaf.44.2023.02.07.15.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:47:42 -0800 (PST)
Received: (nullmailer pid 202027 invoked by uid 1000);
        Tue, 07 Feb 2023 23:47:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node name
Date:   Tue,  7 Feb 2023 17:47:35 -0600
Message-Id: <20230207234735.201812-1-robh@kernel.org>
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
 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
index 8107d120a8a7..2f9ab6b4a2c9 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
@@ -54,7 +54,7 @@ gic: interrupt-controller@3000000 {
 				      <0x00d0000 0x1000>,	/* GICH */
 				      <0x00e0000 0x2000>;	/* GICV */
 
-				gic_its_ap0: interrupt-controller@3040000 {
+				gic_its_ap0: msi-controller@3040000 {
 					compatible = "arm,gic-v3-its";
 					msi-controller;
 					#msi-cells = <1>;
-- 
2.39.1

