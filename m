Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354AE6C37F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjCURNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCURNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:13:34 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0A953286
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o12so62499476edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679418761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEiCCUJNc1PR3pnogvghUdnKOx/0EJRU/1ZM2vOLkNw=;
        b=A7ZBdDyPrIJSe9DoJVUnw26hPeuSrdWVxTlX/JVvaDkkwVbU22O+pG/nq7kZR1ujjw
         8DRIxgNeX33Qe9e5MQzfqOGVejcgaDUKUWg+toZwanqvVYAm1P+2TTwWbLO+q1x6EEGK
         pCAASaoyw6WioSPqhUGhq0vub9Z/WUfcXkUKN/6p0T6yGX6VSsy+90eOx/n4vzn+cSJJ
         7PDF47V/+uVj6QtnRMB+AmlAtY1mUJ7WyxES2yDIsWQza01C+QFZNk4rijttoqmEnO3z
         Gtge0FLZ3iyzp6DuLWMvUK1BZwcwwYRpgXtlwBwICqfDytP3nMOlX7o1ocMcn9/TKXQz
         397w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEiCCUJNc1PR3pnogvghUdnKOx/0EJRU/1ZM2vOLkNw=;
        b=y+gcXOkWHM8vkm3LEKMSvh95gbt7XcCm+2i2xwTGhwJbzEZspWoGuONBbItWnNPtKq
         fy+7EgyCaSHlldRP03u47LfdNcUPbd4qvcOR5Ek8WPSodcI1MDuH/Wdwd9YpwLB3jBHM
         iC8lMou9sUBHHRgIi/fCMfEVX8z66vEjh0zUCUSArMq55gQj0M5xZKVDFUWxHiVrtCkA
         +AYYjEmKDMYvol6Ng6WPQKoFlOWAenkK7Vx7gzCkcr01eOYh10mjrb1XhB6VHA+FDfqH
         MCS6V66csqeaieZ2ybDsYmFdwjKnyfUa0JVBd4V4fsDrqr8CZaTQfnrWJ8KSenjUhRxE
         1t5Q==
X-Gm-Message-State: AO0yUKXxKWwGaxxPkre9Pdei1EcwxDUjJUELHvBIKzd37iTAT2xEJ3gq
        DrXDSA+0Em1qhUgrmBSoQRw=
X-Google-Smtp-Source: AK7set8afY/2gmlDmp2cFlcf4MZXIdXvWAy082uU862wFq1pjHBJp6vvtG7fppI+TC5a+m2aSINmuw==
X-Received: by 2002:a05:6402:35a:b0:4bc:f925:5dbe with SMTP id r26-20020a056402035a00b004bcf9255dbemr3611171edw.42.1679418761356;
        Tue, 21 Mar 2023 10:12:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bc57-1c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:bc57:1c00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm6474959edf.63.2023.03.21.10.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:12:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/3] ARM: dts: meson8: add the SDXC_A pins
Date:   Tue, 21 Mar 2023 18:12:12 +0100
Message-Id: <20230321171213.2808460-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
References: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pins for the SDHC MMC controller which connect to the SDIO wifi
on some boards.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index 4d18bb4e3c33..4f22ab451aae 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -506,6 +506,15 @@ mux {
 			};
 		};
 
+		sdxc_a_pins: sdxc-a {
+			mux {
+				groups = "sdxc_d0_a", "sdxc_d13_a",
+					 "sdxc_clk_a", "sdxc_cmd_a";
+				function = "sdxc_a";
+				bias-pull-up;
+			};
+		};
+
 		sdxc_b_pins: sdxc-b {
 			mux {
 				groups = "sdxc_d0_b", "sdxc_d13_b",
-- 
2.40.0

