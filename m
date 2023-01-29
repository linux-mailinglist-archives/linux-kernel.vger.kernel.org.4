Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B93267FF8C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 15:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbjA2OcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 09:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjA2OcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 09:32:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E7A5DF;
        Sun, 29 Jan 2023 06:31:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mc11so2755321ejb.10;
        Sun, 29 Jan 2023 06:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIsYvjDlZhXseIBbB+cVw5ndep5LtZPlaWmi5dbOsTU=;
        b=MG0zYJDEuwdAIPlKTrUz/tAIjgDecO7da5aOjlPCt7ezTnZ3WgOceJliclMU9Pazqn
         L5dGHo3y0fEB15rgAiisrsMFa+3jXGtLedc0ONf9sBkC0778amcL2vHCDKkUxC4jdhMT
         L0rdAhvn8wVieQsB1oAkRsDJ3Nm+CF1BtUuyHf7VPOdNSRzLqHzgv/SclP4Frd+cOG6i
         X2ENBpIDZWQgCSXsc7QISY2Rh49PaEbED3Zf2tNTKbt5TzReV7RmffSXlgodgbATqjEb
         MHDIrbXq6HkYyWVfAE2XkUFSTeoREPo5WWPDuDI6ENlcV3w93U76jE0ms0yYIo2l/e8u
         a3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIsYvjDlZhXseIBbB+cVw5ndep5LtZPlaWmi5dbOsTU=;
        b=eNZ/LPmy6Syn9HfFVfk18QKFSYvwkMcqaERiZO7XwFXfzZh5Xz0wNuAudieDZBuIQ6
         7NiTt4BrRZp1C1COF5eLqQCIlpjgfvzlowH2X9IqE2zMWh0gnLuY1uPitWenfO44B1Pz
         72nZU3gIAVT4C9vdwXnArva6ND1zcOJ+qjOpO+6/PIbCRbPS3kWNUxV4r/d7qtkMpv/r
         K1OqBmaiXk+ChYDkKHL+A3HY4MfB9A/kMTuwT81oN5HuJzdsC62gycCJ5ftoxhca6NRb
         A0gF1lWsY6ZyzK6Nr8zYjDJ2UNGjoU1lOHyX3vKkrU6kNPAc8J8rolIBt4mFA8nc3PWJ
         KVXA==
X-Gm-Message-State: AO0yUKXCWCB+00PJ54V3h4DYqWPAqKh4Gq7KAPBXGoM0bkXHg299flOq
        HihDs7DcBC4nB/Vlgox8ou0=
X-Google-Smtp-Source: AK7set9Opdxx1Q5nZgj4I7SG11bJhP2LKEKpWGGYInJD7QBsb0eZzG8RWYkwDjUBL0J/cY+nvl432Q==
X-Received: by 2002:a17:907:6e90:b0:887:915d:7502 with SMTP id sh16-20020a1709076e9000b00887915d7502mr2229039ejc.31.1675002717970;
        Sun, 29 Jan 2023 06:31:57 -0800 (PST)
Received: from localhost.localdomain (83.6.123.74.ipv4.supernova.orange.pl. [83.6.123.74])
        by smtp.gmail.com with ESMTPSA id jr23-20020a170906515700b0086f4b8f9e42sm5410128ejc.65.2023.01.29.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 06:31:57 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: Add display support to Odroid Go Super
Date:   Sun, 29 Jan 2023 15:31:41 +0100
Message-Id: <20230129143141.173413-4-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230129143141.173413-1-maccraft123mc@gmail.com>
References: <20230129143141.173413-1-maccraft123mc@gmail.com>
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

