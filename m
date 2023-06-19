Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E84735C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjFSQzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjFSQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:55:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D407127
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:39 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76257c11363so191404085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1687193738; x=1689785738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=fbehQPIELgMVuXKfNJ14ftlH1Mu99NGxZxmpav7OC/ejP2ZFu0DfrtcQSHiuGYciyl
         tH35FlqjRv13W3FryjHB+CgK9dBSRixA2OFqEyIJpPpFixhBr5rLl+n7IHU5g3U7IfSp
         px1owPuMpfK+cfi67OBColLfqKhxm6jvxVXoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193738; x=1689785738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jBqOeBntw2+ThpWf4KE8BMuMRq2HYj3RR0u0oHiddc=;
        b=SfNbNDfdVV977F2pPQUNoW6w6L9FxPu+fUDvq1uVvW+ocRb6lNzuzTzOeJx9Y1Ya6g
         r2f+GGVF/PN7Hq/zXo5ZxIuW11zwxiZ/0WfEA5Qh7NPiSEhr7cZdoYFv5HKQ4OUQEvGP
         fTkcTJDHSLYcJsV+IGiHrL3gAvDxeelXsZqSRRytn5taRPlalUzfcYRchz3Yp6rm+aB1
         gmTQZ6rQHQEi7FO7lunkQPSMdW28nVJJmF4Li3BT5tU98IV8ks7Rjd/Qup9QlGr15JHx
         SuvRs3rU2WObM2/qZmw2Q9bip31PNYZWNaXydjbKg+ALNWjvzBhHsa2R2PR7VlHWKWGO
         +nAQ==
X-Gm-Message-State: AC+VfDxAo6hayGmnXL4Bd6ng/sXj1DvGGCEaAYjPYA64um5UUv0yWe/O
        QFeswfLP39J8P3nWYrVBi5cGT+mItL3SIODps44=
X-Google-Smtp-Source: ACHHUZ7s9mMwA0UYhOrHV96GHITp2mcagElZVTFGi4BdgoRv2nHLvaYcNEfGRjJJhUoLnGeLKw344Q==
X-Received: by 2002:a05:620a:4055:b0:75b:23a0:dea4 with SMTP id i21-20020a05620a405500b0075b23a0dea4mr12989246qko.34.1687193738121;
        Mon, 19 Jun 2023 09:55:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-79-25-27-4.retail.telecomitalia.it. [79.25.27.4])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a15f700b0075d49ce31c3sm109103qkm.91.2023.06.19.09.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:55:37 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 1/6] ARM: dts: stm32: add ltdc support on stm32f746 MCU
Date:   Mon, 19 Jun 2023 18:55:20 +0200
Message-Id: <20230619165525.1035243-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
References: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LTDC (Lcd-tft Display Controller) support.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/stm32f746.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746.dtsi b/arch/arm/boot/dts/stm32f746.dtsi
index dc868e6da40e..9c4ba0b7f239 100644
--- a/arch/arm/boot/dts/stm32f746.dtsi
+++ b/arch/arm/boot/dts/stm32f746.dtsi
@@ -507,6 +507,16 @@ pwm {
 			};
 		};
 
+		ltdc: display-controller@40016800 {
+			compatible = "st,stm32-ltdc";
+			reg = <0x40016800 0x200>;
+			interrupts = <88>, <89>;
+			resets = <&rcc STM32F7_APB2_RESET(LTDC)>;
+			clocks = <&rcc 1 CLK_LCD>;
+			clock-names = "lcd";
+			status = "disabled";
+		};
+
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
-- 
2.32.0

