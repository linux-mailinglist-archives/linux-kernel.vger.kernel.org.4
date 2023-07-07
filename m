Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8725D74B5F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGGRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjGGRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:42:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08819BD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:42:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso35368061fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688751766; x=1691343766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=zTQr0TfMcC4DlfkbUXm72Nl/XQ082bNObmI1yt8HMIW00TtkJeshukWttKsGR+I+8f
         3R2/dEQx2lxEUYIQMjps10V3ctk1wUJZlPQD4GBQnnHBxVaUIs8t3HAzyTGVsH9pDn/B
         sjpIygG3CckbYb9qVtfQ6n88mWrvy6v7fTw6xpLMgZxofqyneKD63sfi0EplDCc6mO4G
         vyLLAljhYZLmuRw9VkeS7YfIryYvhHTHWKttrK5yTA1eMSh2tn4Ox2XgXhq+KyfrtuHT
         4TfQwB/IEL5bdLLE6npGDdvVkIGm8UZpcejWnlAJ1kIdLFvxkdZeglH7MuGLySBZ8fMZ
         ndVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688751766; x=1691343766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=XxozsswKC0RL/BC97fV+XVIwEymRx6xU6S6YkPCAokGMs44ucIE7n6IfvTa94VuspU
         ecGj66LY0I1VahkJb4hfIenTETSF84AtCsJ3zVvPatia1zUcKy0BRyBG3BibZYu8VuBP
         bHectLQ7bMkUNLP0wnmTVMcj78x6VJg3e7AabZEIpSKqqCr8eyUjJagvXnq06Av5SVeJ
         ghS2o+sXj/ey2inn2ujEu3Dzb0wzfqHZEah5XvysnwjQnwzmz10Z7sam+gZ+mMh7dV0l
         kQ2BeMjw2UrTZPb36AVhNmTJVcvA0IEraLjdX+5geqQ9M1AC7YZjZkCKK57zZQukaWyG
         QVeQ==
X-Gm-Message-State: ABy/qLYJm40HXaaeJfJ9/8f7beQORED2ut1Mn0UZ7eSe358MRQW8hxjI
        p4jpfKaW6OPC2LBc864/IzoUZQ==
X-Google-Smtp-Source: APBJJlG58ikAkD6LHQBmGvRh+KpXB7nKpIJUjW3R2c4WpdveO+EhTkm4mWQdrN4UErqYnbLF5zcjQw==
X-Received: by 2002:a2e:9a86:0:b0:2b5:86e4:558e with SMTP id p6-20020a2e9a86000000b002b586e4558emr4641825lji.38.1688751766423;
        Fri, 07 Jul 2023 10:42:46 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 7-20020a05651c008700b002b6ece2456csm859163ljq.121.2023.07.07.10.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 10:42:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 07 Jul 2023 19:42:41 +0200
Subject: [PATCH v3 2/2] ARM: dts: bcm5301x: Add SEAMA compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230707-seama-partitions-v3-2-6aa9391b46bb@linaro.org>
References: <20230707-seama-partitions-v3-0-6aa9391b46bb@linaro.org>
In-Reply-To: <20230707-seama-partitions-v3-0-6aa9391b46bb@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SEAMA compatibles to the firmware partition of these
two D-Link devices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts | 1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 555fbe41dd8f..cf3000b07eea 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -33,6 +33,7 @@ partitions {
 				#size-cells = <1>;
 
 				partition@0 {
+					compatible = "seama";
 					label = "firmware";
 					reg = <0x00000000 0x08000000>;
 				};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
index d945a20b06e0..3551f855ff20 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
@@ -149,6 +149,7 @@ partitions {
 		 * partitions: this device uses SEAMA.
 		 */
 		firmware@0 {
+			compatible = "seama";
 			label = "firmware";
 			reg = <0x00000000 0x08000000>;
 		};

-- 
2.34.1

