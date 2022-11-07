Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4A61EB8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiKGHQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiKGHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:15:38 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460F13DC1;
        Sun,  6 Nov 2022 23:15:22 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id hh9so6404499qtb.13;
        Sun, 06 Nov 2022 23:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WqsFSiWhAXKLtxEGv9T2qWq8Rj1RrgI4BxtPmJfTh8=;
        b=Vq7W7a9tH+aUa4C8Ht8OEn7/8isNlhDTLWLa5BshC+U7eTr9QWIsX5EXnC9C0IUaZ6
         U2rEcOPn/iNrdQVRVrYOeQOc6OuGlHqfClD9u2lthZJ6iPkIlsSFsZDezOG0RPWjHcdq
         y0RqGKQvEvJWQ1/qh62PdmiavhR1V+rZ3DclqdWMJDc6nEM5noDucfvz852j7yFArSI1
         u3Z8spp50r5diKr4ExinAReb6souTy9f0j3JgPR4wEugGJZpToUsclqvma5iwNlgoboa
         SqTaDc1pxgC3vqBxa+pGoVqFEpqr3uMsjBeaXkotHMUNfVDYke1v1AyC884GM8r5WXxG
         NFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WqsFSiWhAXKLtxEGv9T2qWq8Rj1RrgI4BxtPmJfTh8=;
        b=EKDHiJht2KsmLqgxIh/28eLUhEO6h7ohHwwyT5eiBDHD4mqeJLaBchhLDhPetLFF/S
         QkWj/3XnMbKoZplFB7H9HKnrO74IgxX1ZqGyWwjJ7ChXVvAaNIgtB5wiNdHHIM6/8LIv
         iQQXYBpIv9nVH2CdsP9/c61+ljxaZ02ENX8eQftrYzjtRC82dGd74OXwusY8F1uG3shP
         WItUiWngFFOwY+4T65CGzKVvVLza+Cx8LRuagucpPj/jYj/7I74Ywsp4/E74XIKpw0vo
         grFdC4woAB/hzgy957evkp3O26YNkGszQRM97sbtLUP28TYLoi/0OivAHPaDqaFqzmzr
         Yv0w==
X-Gm-Message-State: ACrzQf2Mz65UX6WPNXNaWf1zUGJC01BJQtfaSm+CsRbDy0ycmOM6jboU
        vE9676gW3/h9bkiktBm2aPs=
X-Google-Smtp-Source: AMsMyM5+Yxz1cZBd3oZ85uNjKE2OMO+zcROUXfy/cED4jucG1cnUad0oFyhenJNJtZY1ZiDqA+6JSA==
X-Received: by 2002:ac8:724f:0:b0:3a5:28f5:5d15 with SMTP id l15-20020ac8724f000000b003a528f55d15mr30025366qtp.17.1667805321378;
        Sun, 06 Nov 2022 23:15:21 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (pool-108-26-185-122.bstnma.fios.verizon.net. [108.26.185.122])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006cf38fd659asm6318428qkb.103.2022.11.06.23.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 23:15:21 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, sboyd@kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com, fugang.duan@nxp.com,
        Mr.Bossman075@gmail.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v1 7/7] ARM: dts: imx: Update i.MXRT1050.dtsi compatibles
Date:   Mon,  7 Nov 2022 02:15:11 -0500
Message-Id: <20221107071511.2764628-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
References: <20221107071511.2764628-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused compatibles from i.MXRT1050.dtsi.
Change GPT clock-names to match documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 arch/arm/boot/dts/imxrt1050.dtsi | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 03e6a858a7be..8d79de239046 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -29,7 +29,7 @@ osc3M: osc3M {
 
 	soc {
 		lpuart1: serial@40184000 {
-			compatible = "fsl,imxrt1050-lpuart", "fsl,imx7ulp-lpuart";
+			compatible = "fsl,imxrt1050-lpuart";
 			reg = <0x40184000 0x4000>;
 			interrupts = <20>;
 			clocks = <&clks IMXRT1050_CLK_LPUART1>;
@@ -40,7 +40,6 @@ lpuart1: serial@40184000 {
 		iomuxc: pinctrl@401f8000 {
 			compatible = "fsl,imxrt1050-iomuxc";
 			reg = <0x401f8000 0x4000>;
-			fsl,mux_mask = <0x7>;
 		};
 
 		anatop: anatop@400d8000 {
@@ -83,7 +82,7 @@ edma1: dma-controller@400e8000 {
 		};
 
 		usdhc1: mmc@402c0000 {
-			compatible = "fsl,imxrt1050-usdhc", "fsl,imx6sl-usdhc";
+			compatible = "fsl,imxrt1050-usdhc";
 			reg = <0x402c0000 0x4000>;
 			interrupts = <110>;
 			clocks = <&clks IMXRT1050_CLK_IPG_PDOF>,
@@ -150,11 +149,11 @@ gpio5: gpio@400c0000 {
 		};
 
 		gpt: timer@401ec000 {
-			compatible = "fsl,imxrt1050-gpt", "fsl,imx6dl-gpt", "fsl,imx6sl-gpt";
+			compatible = "fsl,imxrt1050-gpt", "fsl,imx6dl-gpt";
 			reg = <0x401ec000 0x4000>;
 			interrupts = <100>;
-			clocks = <&osc3M>;
-			clock-names = "per";
+			clocks = <&osc3M>, <&osc3M>;
+			clock-names = "ipg", "per";
 		};
 	};
 };
-- 
2.37.2

