Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A160A4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiJXMSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiJXMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:17:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD681689;
        Mon, 24 Oct 2022 04:56:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so6448945wmb.2;
        Mon, 24 Oct 2022 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axn3aaHBRF7DrwO9saARJ14Bo7kXLQznomx3jTXdStk=;
        b=PE8V9kp4GRfFmpdgzcTNucrSZO+RuGeyG6fjbleBbN2wJO78dFFNVo2Hi+PEme81j+
         ub8R2aNIn6TNimRhD6oR1OvHWvh/KFrpuq7lTwtrVC3vaJWyS+JktzRuGqvZ9Wuzhi+G
         vrI7EJ2Y36LebfU4jr2GTPSCvakZry8uULHKSZB1DCZBKTdNFWDQrBuNQfqZRzP4BwfL
         jNCZwLDEgWGV/yDps2ssHF7OD9mhJ6bocRob2zsKYwp8rauluXUpvox7FIdOZbYp0Mlq
         JJmg2Eej4pbejCcKErL0GCGAqtm+U1E1u7tN0prhs7Fz+nwlaoZjG8nNt1aySi2p7rFc
         sXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axn3aaHBRF7DrwO9saARJ14Bo7kXLQznomx3jTXdStk=;
        b=7t7F8LWgSOjARfTgfV8AQ5dIiwNQhoBtbHN/GgqOcASon82NFCTSC21iPXZtVt/5y7
         A0U1YR6aFf2Jt0hRONhgQAbTnUOrsMnqcyhvopgld2cX6U7mC5IjRlLE1c01w7d83cuy
         UtYV2oI/6dgqMJ/dVjxoiG4V3KdZWXium13GIiD/WVODE+goZrKuJrFxR2ObDRosxFgO
         rbYWhcphJCQGVQJBPAKdqJVZCz7h+UQ2GRZl/KXCEvYWYiq17u+bsWOFdsFQqeIc1HVt
         sU/alUn0Q9SRO/ond/DnTu1K7r/Dva7Rl+ZnQ+Dyze3LIc841XMTnQ8rpfAe0o4Arz1/
         V5Rg==
X-Gm-Message-State: ACrzQf01uVPEYXJUsq59Z5KyGyOvXnIAngtuL8og7dA4VDZwqEp3oW2d
        wTW9hORdJKe2fMBSiTm8fHVQ/mi6oGM=
X-Google-Smtp-Source: AMsMyM5HFklmeyYv6QSh8a0HERpkOwctcpnTPGXOReiJCofIUhPFcGm9dv3UDFvMDErEsK3dBD0MkA==
X-Received: by 2002:a05:600c:502c:b0:3c6:f5ff:e089 with SMTP id n44-20020a05600c502c00b003c6f5ffe089mr21918323wmr.108.1666612485200;
        Mon, 24 Oct 2022 04:54:45 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003c6f27d275dsm8484971wmq.33.2022.10.24.04.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:54:44 -0700 (PDT)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH v3] arm64: dts: imx8mq-kontron-pitx-imx8m: remove off-on-delay-us for regulator-usdhc2-vmmc
Date:   Mon, 24 Oct 2022 13:54:30 +0200
Message-Id: <20221024115429.1343257-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With that delay U-Boot is not able to store the environment variables in
the SD card. Since the delay is not required it can be remove.

Fixes: 5dbadc848259 (arm64: dts: fsl: add support for Kontron pitx-imx8m board)

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
v3:
 - Improve commit message and explain why it is a fix (thanks to Fabio)

v2:
 - add Fixes tag

 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index a91c136797f6..21442e04a632 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -51,7 +51,6 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 };
-- 
2.30.2

