Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77C6F7B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 05:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjEEDaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 23:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEEDaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 23:30:02 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8DE12082;
        Thu,  4 May 2023 20:29:50 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-190d4f2f943so1105735fac.3;
        Thu, 04 May 2023 20:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683257390; x=1685849390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGh96GpF1w56WRuG0KE+CcOTucEJsJno0dq0Q6fCK1s=;
        b=T3NvdgDhoeAZ30aCa2LPOAm5ncCOOF5IyuAQcNZWEOqPxsq1uV97pTf89ZnM2NMfdb
         /+cL8NprZa+58wceS/2LlmYrmxKMXJHRrSXF1LeoNIEA4G9ABtexVKhzUXcaLBbXGt96
         n2cb7fWJGR+xAwgvrXedSJDThGiwZ3htE1San+Yr9RwARoz18ueU+v8DQ3tScR+t3GVl
         BvPDKpKORuCWmSrqJn9WyjOx0S8tvhrsVM8KO1B9wepVfCoqoUPxYKNPLXbwDF+/fmkT
         3lZUcofVuKmQW2YHCdPl4iHFTJWDU/knYPILK+aPIcAM6hrClKDz7+h0bqU9i54P5nJ6
         Z65w==
X-Gm-Message-State: AC+VfDxXIby/Fd3gUKvnBmPOO7/RzJrAApUrUTvsxhcHwd1s+7ri7mzp
        ojONvrIJPgH+kXmxuXEoWw==
X-Google-Smtp-Source: ACHHUZ6Ouk9QsRDuY7RaJWgtUD36KbaZon3pr26YZGtdSnAszI68UGDhoFcHEim9vKKLP4+HdIV7bw==
X-Received: by 2002:a05:6870:a484:b0:187:c830:92d with SMTP id j4-20020a056870a48400b00187c830092dmr162785oal.27.1683257389747;
        Thu, 04 May 2023 20:29:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e1-20020a056870c34100b0018449ae08cesm1366705oak.13.2023.05.04.20.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 20:29:49 -0700 (PDT)
Received: (nullmailer pid 1056846 invoked by uid 1000);
        Fri, 05 May 2023 03:29:31 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 04 May 2023 22:29:26 -0500
Subject: [PATCH 1/4] ARM: dts: allwinner: Use quoted #include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230504-arm-dts-mv-v1-1-2c8e51a2b6c4@kernel.org>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
In-Reply-To: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
To:     soc@kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to move .dts files into subdirectories, include
sunxi-h3-h5-emlid-neutis.dtsi from the current directory rather than the
symlinked include path.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi b/arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi
index eedd5da5dc2f..35e71f46c197 100644
--- a/arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi
@@ -8,4 +8,4 @@
 /dts-v1/;
 
 #include "sun8i-h3.dtsi"
-#include <arm/sunxi-h3-h5-emlid-neutis.dtsi>
+#include "sunxi-h3-h5-emlid-neutis.dtsi"

-- 
2.39.2

