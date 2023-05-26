Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E506712D85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbjEZTaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbjEZTam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:30:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFFBE52;
        Fri, 26 May 2023 12:30:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3063433fa66so726128f8f.3;
        Fri, 26 May 2023 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129432; x=1687721432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ERaIn3XiM9AIriWrH87W8nbH2+a+3f3XJN5bHFdNCI=;
        b=JKJD1wuk4YHOZSdOUr8su8W8qcR+Up9+mzSoD+/THLj9ZgrkNZ4nSQd8siJMy58di4
         t9d7YYs6xvJIx9OeCpHLn2++aij2793ZT+frMFFZ33BNgIgJiZlCRqlL0emyaTMY0QP4
         b30v4qF6ZJUL7fFhmaip5t5N53xYIJWh2b99T1xjXOU+8SoRFvfuFVznHvU0mImoCVFg
         6JIL99g2u5n/53WvDQgr0rsezSSDsaBwNYZAaxT8BC3L5i/BC7PlYboHJFb9DBJdmPY4
         J3kObv66OhEHrK7SAZwfBUz4+i16w52DVm2B6kcJ7R1aQFKDcj8o70fOvDM9KgsqpVO5
         Z8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129432; x=1687721432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ERaIn3XiM9AIriWrH87W8nbH2+a+3f3XJN5bHFdNCI=;
        b=EiY88tac455nJw2r3i+p3pYJVhY1a55KxwEPRruCqYPXeSbUfL4z4MWkE2lVm6HHju
         Q0zZIXyPeTNgmXKSLS79eB8N3zCH9hlIEdRtGFwkdj8HPzSfXlP80qae9O10VckFznru
         bVx16GulsUJhmadcA01c6yoEvDvdvRN3veLlMtAY9sIN0i3do+EwnuCc/r5w22wgumUR
         Om7JqvWi84ur8OHPj36Rm3+gf/1MkKyt/j/8eosI/ClIZ5nfdoWBS3IgzGvspKULqX80
         W4sjuzHSeZDvmem502FMrdYXYfjyw6oeRG04uA/wogFpGTLSdLg16gDRLQmrQ8XDj2j5
         swpQ==
X-Gm-Message-State: AC+VfDxLdtsal0nVajrVkGmhcW+EnHt74sinYMEseIBRYi0nehORUAQ7
        Ku8If1H/aFwk4C6ctjh0EY8=
X-Google-Smtp-Source: ACHHUZ5Y9BIEgY6hh1+MgryrEo4ZPwrKPM/NN8XtiDO/UoAeb+EK13SSKGfwPgFuJXDetLcX9KUPbw==
X-Received: by 2002:a5d:658d:0:b0:307:aa7c:58 with SMTP id q13-20020a5d658d000000b00307aa7c0058mr2111159wru.40.1685129432014;
        Fri, 26 May 2023 12:30:32 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d618a000000b0030631a599a0sm5956295wru.24.2023.05.26.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:30:31 -0700 (PDT)
Date:   Fri, 26 May 2023 21:30:30 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM: dts: bcm21664-garnet: use node labels
Message-ID: <e9f1ac2e9aa0ef7e880b1c152cbd56ff6b151955.1685127525.git.stano.jakubek@gmail.com>
References: <cover.1685127525.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685127525.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use node labels instead of nodename@address for BCM21664 Garnet
to simplify its DTS file.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm/boot/dts/bcm21664-garnet.dts | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/bcm21664-garnet.dts b/arch/arm/boot/dts/bcm21664-garnet.dts
index dead91d97b63..8789fae178bf 100644
--- a/arch/arm/boot/dts/bcm21664-garnet.dts
+++ b/arch/arm/boot/dts/bcm21664-garnet.dts
@@ -15,33 +15,33 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+};
 
-	serial@3e000000 {
-		status = "okay";
-	};
+&sdio1 {
+	max-frequency = <48000000>;
+	status = "okay";
+};
 
-	sdio1: mmc@3f180000 {
-		max-frequency = <48000000>;
-		status = "okay";
-	};
+&sdio2 {
+	non-removable;
+	max-frequency = <48000000>;
+	status = "okay";
+};
 
-	sdio2: mmc@3f190000 {
-		non-removable;
-		max-frequency = <48000000>;
-		status = "okay";
-	};
+&sdio4 {
+	max-frequency = <48000000>;
+	cd-gpios = <&gpio 91 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
 
-	sdio4: mmc@3f1b0000 {
-		max-frequency = <48000000>;
-		cd-gpios = <&gpio 91 GPIO_ACTIVE_LOW>;
-		status = "okay";
-	};
+&uartb {
+	status = "okay";
+};
 
-	usbotg: usb@3f120000 {
-		status = "okay";
-	};
+&usbotg {
+	status = "okay";
+};
 
-	usbphy: usb-phy@3f130000 {
-		status = "okay";
-	};
+&usbphy {
+	status = "okay";
 };
-- 
2.25.1

