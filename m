Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808A07058E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjEPUat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjEPUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:30:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559335A8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:30:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96b4ed40d97so421467066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684269044; x=1686861044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRBhEUf7CYGryet9ZxbEaGtt6QxEKGJuiA85AVv0BIk=;
        b=sCapp58iRDrRq6V4PfWOO/Y/fTUFnOlRvbDiSpey+KtmAWkC9JFwJmBuDkfFylP8d6
         otK/LRYiFKzgMrzWcjPRCgUs48TFvAbuXlm9p0KWQja1flK7g+C72QsTptxIsjifZsE1
         aX71kT9Fdspb1EX2SKJpf9jgyfWQrJQ6uJXPbyjxqAfT4x5SWuf8NL3xO8IkFOFwiHX+
         xrKcq1bhJ7OQ7WkgBoQrGtuW8+O3ZuK+eNuyNhQ9DIwQ7ATUhvstsU8DhyaJVgpKTN4p
         W/nYCXdaqf1ULP5VtwTpLDayN/9adJeSvlSZGVvhmMiWIttbM06X8/PNYad70pW5RwN9
         MiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269044; x=1686861044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRBhEUf7CYGryet9ZxbEaGtt6QxEKGJuiA85AVv0BIk=;
        b=QuHgPuaO7H1qK+WprjSXBuDCKNbULTvamDhKB6IBmR1plq+a1omeuJKLL/ivhEEVzC
         uG/SHDxgOlewHOcZnU5Kj7vVwPY/tQmh2jo1mSofiZICUDBpWe8yocoYyawnIqV4MHHx
         7Dp9vPS2u0pzm2RmXdn5D3hsF6bW2gwxnTDDBkQokVOKpO/NFsHW6NLFFnysDuLk73oh
         wgBP0pfKlfBMWGzp+iHy/9M9fiHb/GRnTKX12YOoxvaOAea7czkydrcpWIOXCZE73rvG
         pLqq3uGQqDRnSSUiSEn6Yd92Bnf20sgvKiXXILYDpjAhS6fXB/jfTnE/sW5+CsWJfozi
         K0iQ==
X-Gm-Message-State: AC+VfDwqq8B9AhZRwnkIIxlRAr3JI2n5QwCPX/MzKrgkao9JfsXVA40T
        HaUaQvndth+qHWWme8Qy30v4EWP96BA=
X-Google-Smtp-Source: ACHHUZ4jgUHMzCjzMXjjFQWpF0nsFR8MOJrzw2we9iCGlm41WxlkZ/izm+GYAl4PBL9qUtWr0EUb3A==
X-Received: by 2002:a17:907:928e:b0:96a:8412:a43d with SMTP id bw14-20020a170907928e00b0096a8412a43dmr16563797ejc.33.1684269043970;
        Tue, 16 May 2023 13:30:43 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c47a-4900-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:c47a:4900::e63])
        by smtp.googlemail.com with ESMTPSA id ci18-20020a170907267200b009659ecdf29fsm11304715ejc.1.2023.05.16.13.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:30:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: [PATCH v3] ARM: dts: meson8: correct uart_B and uart_C clock references
Date:   Tue, 16 May 2023 22:30:29 +0200
Message-Id: <20230516203029.1031174-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Meson8 uart_B and uart_C do not work, because they are relying on
incorrect clocks. Change the references of pclk to the correct CLKID
(UART1 for uart_B and UART2 for uart_C), to allow use of the two uarts.

This was originally reported by Hans-Frieder Vogt for Meson8b [0], but
the same bug is also present in meson8.dtsi

[0] https://lore.kernel.org/linux-amlogic/trinity-bf20bcb9-790b-4ab9-99e3-0831ef8257f4-1680878185420@3c-app-gmx-bap55/

Fixes: 57007bfb5469 ("ARM: dts: meson8: Fix the UART device-tree schema validation")
Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net> # for meson8b.dtsi
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Changes since v1:
- move the link to the original report for Meson8b to the description

Changes since v2:
- use CLKID_UART1 for &uart_B (thanks Hans-Frieder Vogt for spotting my
  typo!)


 arch/arm/boot/dts/meson8.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 4f22ab451aae..59932fbfd5d5 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -769,13 +769,13 @@ &uart_A {
 
 &uart_B {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART1>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
 &uart_C {
 	compatible = "amlogic,meson8-uart";
-	clocks = <&xtal>, <&clkc CLKID_UART0>, <&clkc CLKID_CLK81>;
+	clocks = <&xtal>, <&clkc CLKID_UART2>, <&clkc CLKID_CLK81>;
 	clock-names = "xtal", "pclk", "baud";
 };
 
-- 
2.40.1

