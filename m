Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0978260A013
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiJXLTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJXLTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:19:14 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244F55FADE;
        Mon, 24 Oct 2022 04:19:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n14so2102965wmq.3;
        Mon, 24 Oct 2022 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9Og1Bhh2bPvi33i8y4Dsk49533We0YoMqqbz5hm+8M=;
        b=JSZ/D9LJz3EPYLXgCbuPaNozobsTWB47bQqIsr/mYgHl4ZQrjllxFONi8ji3vTW+1d
         81ghNeyT5Y7WawBFsk4ygVrWc26+YPTRPQy04aaoQSHoo4rpC5b0zHiBSOUi3JLKuSk6
         9cJeLJdvSF3mjyMWYB6OmZpwS9xjqEgqaHD0/047U3WKa9FK6yyPG1xcnlmQ+hCpMinj
         8NGie93yj9IkaWs4yjrBHBI93J8RwC+RFH12WZaYIFqIaCb96a+6Va3cW0ubUT++rUK3
         Piq4UMFyusddY4hEH28fKsNnyiTxegrZv7wcDNF2ZOwf8nToLCHr6Bq7HlA2WZsK2Jr3
         m5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9Og1Bhh2bPvi33i8y4Dsk49533We0YoMqqbz5hm+8M=;
        b=YNrCboYSVBXUqF/7dEUhaggyNiijBUmh/FNJTwHFzS7Hl5c7obu1Oe+NPumuz9F+KO
         BkLWKWxDAKjrNleX5c07t+Nd2OWoGun4ABcZwIy8W6v6qNzE+KFSUi+BOaREZDZ3ch/k
         SdAuKs4pjQaC71td+DcXmkxLZ7dGBMElbpaNHE+czTy8++JU4Y5Rjmnmae9ismNQ+14p
         nyR9v+ETbf8L/8X2bBTgSlFIWJIonbLmj5PeH2FQT5H3JBYmk4XYI+D6aZ/QhvSZVSR+
         pM9DoFnekiS1hiIRG+YXzUlNOXArv5VVoYf+VbxZxrlOFIivZfH2NgHhqU8SeAU/9S/p
         UulQ==
X-Gm-Message-State: ACrzQf0yAwU7JE0WRDSXy7+lFXuZ41XAFCPaU1A50qjhVGqaQeFIZlFF
        htnsqw/7VJKXfoDTs6KrRUy9VOf7WVs=
X-Google-Smtp-Source: AMsMyM7r2J1thdAPMMS+PYa0Swa0dQWh4z5N6XGCOIAKASh26MhIYalfw9ar6YorAC6ulyp6x52OkA==
X-Received: by 2002:a05:600c:4448:b0:3c6:fb65:2462 with SMTP id v8-20020a05600c444800b003c6fb652462mr21990994wmn.39.1666610350954;
        Mon, 24 Oct 2022 04:19:10 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
        by smtp.gmail.com with ESMTPSA id l185-20020a1c25c2000000b003b31c560a0csm10490336wml.12.2022.10.24.04.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:19:10 -0700 (PDT)
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
Subject: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove off-on-delay-us for regulator-usdhc2-vmmc
Date:   Mon, 24 Oct 2022 13:19:03 +0200
Message-Id: <20221024111902.1338095-1-heiko.thiery@gmail.com>
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

The delay is not required and can be remove.

Fixes: 5dbadc848259 (arm64: dts: fsl: add support for Kontron pitx-imx8m board)

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
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

