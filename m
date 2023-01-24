Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF247679C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjAXOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjAXOl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:41:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33004A1E5;
        Tue, 24 Jan 2023 06:41:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id b24-20020a17090a551800b0022beefa7a23so1989525pji.5;
        Tue, 24 Jan 2023 06:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33aN1+zq+dtGXTv8s+/MpRCqjJHz2bZNw6EwNpZ5/gs=;
        b=BhAq8289U6wER4oxVUwDFI+iIP2XtZn5swOHIkiuj1jaCNmYY7M+IDySdLJwtR5rZK
         lYnKQeus4tOmSpiK5AWjiE3W4Ni28fF9Vjl3TcRkk5YuzfdRWyuoHSQ2PDDCwEp4aPys
         ebdXNVADra5P8pkTYdwwZDTgbyW36RMOyT8p1bLeCoJAT9LGDttVdNlqxzcyTAcLWR0y
         IOz0PA6aBO/F+Ltn5L+X2btYKDn4SzlvuDUoFEoa4lgUZnt1fXLhPsYvny1AihFSl+Do
         qIVNOAtm0XRff3HO/tZTy3bwcVobPwqNeEAe24pCTjTnRm/nTMluo4oIMbhntbqPegVm
         yCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33aN1+zq+dtGXTv8s+/MpRCqjJHz2bZNw6EwNpZ5/gs=;
        b=eO0VKZqdVnNPhQtSK+8Ts9iMPNc8BPkFhRbW+QYe0//p54vRv0OOkw3LSPn9L/Aqoc
         SlH4ucxZjYDgfJt7yP0z5n/7SLGnAORCeNWo+ZpA38MCEDA+X7AUh9fARi/B49tgRS6f
         ptxPcWD3MxTkRd6ef36mlxgttCv+t41tY0Hb5qjfwPzSIUq5bMizcgHf9dinl2E1RTYt
         7CG9gtLknXg3UD5XPugUGLK/A9quzBgnNGxGTgRsUpjeFPDrNWbPWr0E9qKsc9EP6vin
         omN7vQGgA3KobCbm59XbElOrquLkbmKFJaK7DcQPF+5fEBC5JI4R8ej5v7NHmKClzcFr
         kc6g==
X-Gm-Message-State: AFqh2kpnKqsHtmRPANqlUHIXsmuzloMi8yJCb9VbO5BU8ZWX9qOb8LOL
        WLg9Tl46iHZwNfAQxqL3J8s=
X-Google-Smtp-Source: AMrXdXvR5KO0pDQjOoqXOD8PZrIKLdoBFPKCA5RuJmzdb0dvnYq7x2pEJXees0I00dMjkY0gJ7vWvA==
X-Received: by 2002:a17:902:ef45:b0:189:cc58:7784 with SMTP id e5-20020a170902ef4500b00189cc587784mr33380515plx.45.1674571281264;
        Tue, 24 Jan 2023 06:41:21 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b0019602dd914csm1747865plc.180.2023.01.24.06.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:41:20 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux-next v4 2/4] arm64: dts: amlogic: Drop superfluous dr_mode in usb node on odroid c2
Date:   Tue, 24 Jan 2023 14:40:51 +0000
Message-Id: <20230124144054.13556-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230124144054.13556-1-linux.amoon@gmail.com>
References: <20230124144054.13556-1-linux.amoon@gmail.com>
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

Drop superfluous dr_mode="host" as it is the default in meson-gxbb.dtsi

Fixes: f24859bbec8a ("arm64: dts: amlogic: Used onboard usb hub reset on odroid c2")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 01356437a077..70b10934a811 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -399,7 +399,6 @@ &usb0 {
 };
 
 &usb1 {
-	dr_mode = "host";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.38.1

