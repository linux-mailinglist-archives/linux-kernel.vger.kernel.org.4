Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9421694B62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjBMPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjBMPid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:38:33 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301C2193C7;
        Mon, 13 Feb 2023 07:38:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id rp23so32845112ejb.7;
        Mon, 13 Feb 2023 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIsYvjDlZhXseIBbB+cVw5ndep5LtZPlaWmi5dbOsTU=;
        b=A9a0MnNqLSnDTjUV3BMuhDgKa9mn8HK7dC3csSgPGempi1XhOQa/iwu1Fk4B0rLFCN
         ZZMSpoitc06llBvwJdhNOX5JDRpYjr7GW+ygqn91Goe/CkBJ6XPyW474YSLLWH+nj0HO
         lFJDWdXVLYymR5Jd1gUvZGCKXXIANGsGiAdxcojlVZxMcVN75HbG+nwlyNhaZGOghYEj
         gWN++UaTIawQ72Or0PdWLvlBJSx6/DLqWelbUTng8nfHc5O8SplofmbzqJRaNRUDZYqD
         Dd5lMxaRB8174aJk7IgE8knfsBAihtBk/1NzpkkOzn1Lz+Wu1O9ngXpBNyMPYp4n2QYO
         U7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIsYvjDlZhXseIBbB+cVw5ndep5LtZPlaWmi5dbOsTU=;
        b=VcDMcKSE8iyzjmNslJrmiraVp4UcDSJ4hLhoNdoLj3uchtukUHxn8/Vwqfu9o3tlyK
         4hLUSQh4BnVmi5wC3CvJALanIgdHmIEOSFUk5lckyUeaiNPL34lB+aSLBdr4zS+MPv9U
         Xob+F2qmnAl8S1eFAy04s7IN7GgLkv92XKKnfeNaw9AxgjCn9gWmWMBH9DDGzc+QpQ2D
         3n8/kCBv3tHyhT1m/i7f0G7uxL1irkwQi3+HlZjktPn6pSRY3ai3F4CB4VqNXxZm3GHu
         fiUtTRZtcrOg1Hx3CrWxS0MrsrQRHG0YemKsM2u5YtbnygEV49AafhCPMSVLgbtSIapm
         VmsQ==
X-Gm-Message-State: AO0yUKWv1RVjaJNXWn1JNmLEcVBPnidjOP/vFj0H2bXNiQ9/wV/BtU7i
        oge3hugAVE6DsAPKqqW2w/c=
X-Google-Smtp-Source: AK7set87GQS2ld20hEQYMLoM8dgrjAorL+q0TYeQEhQF8NHsEgUt1E1X7QFkO+0UKyjOOv+II8NPxg==
X-Received: by 2002:a17:907:801:b0:8aa:38da:4547 with SMTP id wv1-20020a170907080100b008aa38da4547mr29512562ejb.70.1676302710836;
        Mon, 13 Feb 2023 07:38:30 -0800 (PST)
Received: from localhost.localdomain (83.24.145.108.ipv4.supernova.orange.pl. [83.24.145.108])
        by smtp.gmail.com with ESMTPSA id gf17-20020a170906e21100b008b12614ee06sm115901ejb.161.2023.02.13.07.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 07:38:30 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     heiko@sntech.de, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add display support to Odroid Go Super
Date:   Mon, 13 Feb 2023 16:38:16 +0100
Message-Id: <20230213153816.213526-5-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230213153816.213526-1-maccraft123mc@gmail.com>
References: <20230213153816.213526-1-maccraft123mc@gmail.com>
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

Note that orientation property in ST7701 driver is currently missing,
And that ST7701 panel driver uses different regulator names compared to
driver for Elida KD35T133 driver.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
index 842efbaf1a6a..1b9769ccfdeb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
@@ -142,7 +142,9 @@ button-sw22 {
 };
 
 &internal_display {
-	status = "disabled";
+	compatible = "elida,kd50t048a", "sitronix,st7701";
+	reset-gpios = <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
+	VCC-supply = <&vcc_lcd>;
 };
 
 &rk817_charger {
-- 
2.39.1

