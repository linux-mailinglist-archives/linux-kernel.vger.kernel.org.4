Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB995F4AFF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJDVfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJDVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:35:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383554CA2;
        Tue,  4 Oct 2022 14:35:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u21so8583633pfc.13;
        Tue, 04 Oct 2022 14:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/Vqik77SL3I3/NXP/sTioYeVpnPjMqVXEOq2c5nfyG4=;
        b=bXdf33t+ohTAVmdHlS9rjjTVu/prwAolfEEqhdg6fCljkTPkK+JLSBtUcV9dWKmJd/
         PqA9KivMskCTDl3zZzsiIkaSKZgBE46RIkYjxBrKhZqV6gMa79EfNPc2nLmLMHmEr3td
         CMIKiobGrRPkyQvX28dfE4Xql1ojwfIp4lQ4wyDXh3Wamx5FBP0n7Mri9WBe3A1QVHJu
         gISU/ElrZLH5H3V1So4uTHjZ25qT6ZB5tCMh6WjEw585TRWmQe3oDYNHyBk4sSu8+cVs
         lnp2ZpndY6EJy4hywTh/OM0w/FMg/g4aovNvQLhwiFtX1uG29dh1xvOUi7IX8t7zWxg2
         ItOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/Vqik77SL3I3/NXP/sTioYeVpnPjMqVXEOq2c5nfyG4=;
        b=q/A4SvwSANoLqdoxCDtucEwqf7XSJHNpU70ozMZDqPSFdU6OXYB7IR4p8vYwQ2QklD
         50dZO6rieeeS+wH59jMunBePH4DJP5KSDH4EbBXah9wpsIxxNLpZqbDl46xk+6AOsDS4
         MJImrgC48mY5uitjFRf4dmoG7bDIwl0zUI/bXAo8enH41bqSvfgLSbnEuIg97KFgGyaG
         tlYY1QjpPIdswaXN0y0PaIU7JQgxmHECBTowqwGglMjEg5yRdhNJCjs2MzgxVqV/yWmC
         gLaXWDRv0XmwJ+nciAJKY320QAHS0KaDxY/nAw6xs8CNFsMF1uHKTXrCPY53a32fHnek
         Vjkg==
X-Gm-Message-State: ACrzQf0TN4lzgRE3x5exEIzIHAa8dc5GoKDfuowXFodGMN4wpCtFnLcG
        zLV+71/D3YfpTDuWhfASeeM=
X-Google-Smtp-Source: AMsMyM5LqPXAoVI8fWeYRjNjA42GiBjbPNwAn0Jca1T2ertWlUoQO1bP9GPMDx2/kvUajXGXght97w==
X-Received: by 2002:a63:fa4f:0:b0:438:e26d:5ec with SMTP id g15-20020a63fa4f000000b00438e26d05ecmr24658464pgk.361.1664919309184;
        Tue, 04 Oct 2022 14:35:09 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:978:a034:8ff4:b4b5])
        by smtp.gmail.com with ESMTPSA id y187-20020a6232c4000000b0055f209690c0sm7675219pfy.50.2022.10.04.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:35:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: omap4-sdp: fix LCD reset line polarity
Date:   Tue,  4 Oct 2022 14:35:01 -0700
Message-Id: <20221004213503.848262-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
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

The LCD driver (panel-dsi-cm), when performing reset, starts with line
set high, then drives it low, holds it there for a moment, and releases
it back to high.  This means that the reset line should be described
as "active low" in DTS. This will be important when the driver is
converted to gpiod API which respects the polarity declared in DTS.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 9e976140f34a..77e99b77a0c5 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -669,7 +669,7 @@ lcd0: panel@0 {
 		reg = <0>;
 		label = "lcd0";
 
-		reset-gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;	/* 102 */
+		reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>;	/* 102 */
 
 		port {
 			lcd0_in: endpoint {
@@ -695,7 +695,7 @@ lcd1: panel@0 {
 		reg = <0>;
 		label = "lcd1";
 
-		reset-gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;	/* 104 */
+		reset-gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;	/* 104 */
 
 		port {
 			lcd1_in: endpoint {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

