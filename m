Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FED5B8953
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiINNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiINNnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:43:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE2932062;
        Wed, 14 Sep 2022 06:43:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bq9so25795019wrb.4;
        Wed, 14 Sep 2022 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=55t9oy9rYO6atteB92gtH+id2YSq0wuOjEorCfNnfh4=;
        b=GbW7z5KA1KjxzU5iLaNR5B7UrSRboHeExbipwRQeWnRS+XZaDEZPSv5gO6g4WjE+eL
         s56ngNetqHmuPMLBo8dYT4Y7E/xDELeEkCd1U1TXKspkEQTZVhYH55ePPFF/w4Q/Nrz2
         h6b/RLruWCbVIJUJBL2zGzB23nb+ybn9FgURJdJ4S1SVKEcGhGSaTn3ZWI+6cFmAdCrE
         CT6DGhIyxsX/hzYQfXvIMCXPFdGp2vezqxXmpqjWYM9WFX2OC4HI/uvNUPEy+aBV3Qea
         ml1dB6Zh2kLfcFIObkxp7nAyt50oiE6U9/YGd4rV5/5IQPkYfU1otSSiME17HCeHCo6T
         EBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=55t9oy9rYO6atteB92gtH+id2YSq0wuOjEorCfNnfh4=;
        b=dyewdwVVCQ02TRa3VhpulcBaBJjNy642B2He3SQudPgGPm0W42KWJT84qoOgUTVO91
         GXMqYYXTKYm56lo+xdpK4Mr5taEA/PDeufrnnfiNstvODH4+iP8/4ycIjkBomfTLeUG3
         lvZfivIc+eXkY8AN+pAxjiFc3lnrAHcSy6+bhw684etfLRLwaXF5dtUDLPERaJD1Q+I2
         MMaHWS0VBPcD6wisGo7+imzIXa1m9XRdBoYlS5maO0fDAMJjJA1GmGfceJxLZMMCcNHM
         hxXkmsyhsHZfmEpUNq7Jc3jBnpHPcD7yQP5d5GvFn/1wnuvfxv4KXi6Su9eCnxi91w6J
         vLyQ==
X-Gm-Message-State: ACgBeo0WggYeF80x1ij6TeN28ZMXaxeeIAXoOnP1ppCzdUBqTsnvlTaf
        QxGmpsFDNiEwxYx5eIsLMsRsiWFrCoPpeg==
X-Google-Smtp-Source: AA6agR7D1czQQSxadf8/PUV5e13WLA+bS4TjuUa+TJHym7+J47uajM1/m+Dnn7Lmquh8MiQTRYtN9g==
X-Received: by 2002:a05:6000:1090:b0:228:a963:3641 with SMTP id y16-20020a056000109000b00228a9633641mr22115365wrw.289.1663162983253;
        Wed, 14 Sep 2022 06:43:03 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc6e:cfa1:9281:3490])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b00228dbaea941sm13567207wrq.26.2022.09.14.06.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 06:43:02 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
Date:   Wed, 14 Sep 2022 14:42:11 +0100
Message-Id: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

WDT CH2 is specifically to check the operation of Cortex-M33 CPU so
don't enable WDT2 by default.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index cf3b3d118ef1..2a0feb53f0dc 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -263,8 +263,3 @@ &wdt0 {
 	status = "okay";
 	timeout-sec = <60>;
 };
-
-&wdt2 {
-	status = "okay";
-	timeout-sec = <60>;
-};
-- 
2.25.1

