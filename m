Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30206CD59C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjC2I4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjC2Iz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:55:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6584C2C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y14so14860104wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaQQlVVIoxOU6TqfrFJ+lVhpnQLiZR5hTcBoQn1zAF4=;
        b=14LgrvXb93pcxdiKRp8jWxGjngm6XDWzpsH3lY9q0okYQZ/ORVz804xdiuYRRIrZ3W
         DEX9qbErrDi1ZNfzKACV71rrciT6x5OYEk7Ok6WZT9CpSWbll5TwhN9W/nfWIwJa938j
         +Lq0yVM9V0ABsSy/PqSugW4XrUpwhrvUZtJpyhRco4l3sU+o36pAEL3UXfdMyOSz3hIt
         3Rw155qO0oCTiozn8pWUXsBnIKrcQUWMgtq1NTU1GwjFl/ntrLlZtiQEf3yqmHNAKbP8
         7dQlVPmSaROvQU7WXc0PJT9lIYXLvROFkG5zowAFDtyRYA0aevWGKC34VOEjfnrlU6g3
         P3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080109;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaQQlVVIoxOU6TqfrFJ+lVhpnQLiZR5hTcBoQn1zAF4=;
        b=4pmhwzSHEYkbTYWhK6/4mDolj2Yb2XsRZqZm35LBgrfZyqS9qEugW0f4fJxZoxrgPy
         H58dZ0nT++N1ewjKKfmQEdZ3vjmhD2ixaZ1dHh2FS3MUPx1EY6AyL0HiFl9qbJ7MqBVU
         ElXuZ/nhBnh+4YYXb9kGvI/uGgY+BJA92rLfcC+1tveiec/TRb5DDAS7JzLn/Qkdsp+B
         EkdUGZ01FjoX9kfRccFknlWzQuER2EZ3uOrOBHtkVH4OdOb2WecAf9DlnitOF7EDqJIj
         l62bOojRZCwYrNZyfNjbwk7kT1R7aY51XmpmK8EI8LptnQlG3Lji2NBRkzTlx9cZMdQg
         Uo/g==
X-Gm-Message-State: AAQBX9fB9liiaiNN6NvsauThfLIlaCM85nl6IvVNLIu0Z5fxddovb8kR
        XjMx49n0lz6Q4D2C1GlY+1/XLg==
X-Google-Smtp-Source: AKy350ZZliyPaqooFuppqqg2/DsSnh9Bxa6DNxbgwJrsU6knkvhi1VU0jHFRf0cX6pfwLbWeAwukOw==
X-Received: by 2002:adf:f201:0:b0:2e4:34b:92ad with SMTP id p1-20020adff201000000b002e4034b92admr525518wro.64.1680080109030;
        Wed, 29 Mar 2023 01:55:09 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:55:08 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 10:54:35 +0200
Subject: [PATCH v3 14/17] arm64: dts: mediatek: add OPP support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-14-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3612; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=c7vCtSe/WVuWGbMdmeJCSd1Y1OoLrA8MO/iUibZvpck=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zcVAd04GxdvqrTsshWoMC0P7pVbCtaqpw6neH6
 gd1tDuqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP83AAKCRArRkmdfjHURerWD/
 99fkruLqpde97Gh1UYS1jyEF41IRtXrAWgi4oLczd/OUaX66pUklUQQ+e5MkhREu9y+vfGJ8458iWL
 CI+nrtd/fB4QGtNu+9PU7+ACIama1KcADk9hCMbaJo0Khb3dnBuliCaXAz6wZkjvXX9pJOW7hHlErc
 03uBPoALBsJOaRSdi3II6RJnC+e8JKCriw0O7wp2uX5Jq4Vd6Ztx/JDFaFyJlZ/Vn0GcTCNY0m12fY
 k8Ilx7k4TY8Hp0shQif0js5jXgWwaKm/Isqyecd+eXrkUuDE+/40G4BssuJZX4oAyihPK+1e4QsyeK
 yGnZnNiIIMfJaWnAxNsxBDtAYK6txvUFIahe8G0HxLDKXsKKK0mEitI25ZQytdq934k+0uBIBvZFDg
 X0s3dL9s5umf0KxCSkpuibTuY2eK0Vjlo7GdWtKRCCdPjuT5H+EAHm6IgS+qzLwc41FYUKJKhmk8s8
 QTLgwR0+jPzUzTNaxx5+Egzy75Lb7Ce5TNu5nU5bwrrdVN2UiMbHfjFyFemMHeL6Le5z0/cI4boDA8
 9+/m3qig1NT651s4Iy0YCZ9+MxGLa4JNaD4de3qKYMVqLDG8QUDCYl3AArvLH3yOpJ2hs7lVn02Qr+
 zZcuOZPglZCXsF+7ngx6ZxfDJOZ8veiLBFbSVfndghxU/2QDirkMLK5A9aDw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to have cpufreq support, this patch adds generic Operating
Performance Points support.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 85 ++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 394a5a61be59..c3ea3cc97a47 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -20,6 +20,75 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp-850000000 {
+			opp-hz = /bits/ 64 <850000000>;
+			opp-microvolt = <650000>;
+		};
+		opp-918000000 {
+			opp-hz = /bits/ 64 <918000000>;
+			opp-microvolt = <668750>;
+		};
+		opp-987000000 {
+			opp-hz = /bits/ 64 <987000000>;
+			opp-microvolt = <687500>;
+		};
+		opp-1056000000 {
+			opp-hz = /bits/ 64 <1056000000>;
+			opp-microvolt = <706250>;
+		};
+		opp-1125000000 {
+			opp-hz = /bits/ 64 <1125000000>;
+			opp-microvolt = <725000>;
+		};
+		opp-1216000000 {
+			opp-hz = /bits/ 64 <1216000000>;
+			opp-microvolt = <750000>;
+		};
+		opp-1308000000 {
+			opp-hz = /bits/ 64 <1308000000>;
+			opp-microvolt = <775000>;
+		};
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt = <800000>;
+		};
+		opp-1466000000 {
+			opp-hz = /bits/ 64 <1466000000>;
+			opp-microvolt = <825000>;
+		};
+		opp-1533000000 {
+			opp-hz = /bits/ 64 <1533000000>;
+			opp-microvolt = <850000>;
+		};
+		opp-1633000000 {
+			opp-hz = /bits/ 64 <1633000000>;
+			opp-microvolt = <887500>;
+		};
+		opp-1700000000 {
+			opp-hz = /bits/ 64 <1700000000>;
+			opp-microvolt = <912500>;
+		};
+		opp-1767000000 {
+			opp-hz = /bits/ 64 <1767000000>;
+			opp-microvolt = <937500>;
+		};
+		opp-1834000000 {
+			opp-hz = /bits/ 64 <1834000000>;
+			opp-microvolt = <962500>;
+		};
+		opp-1917000000 {
+			opp-hz = /bits/ 64 <1917000000>;
+			opp-microvolt = <993750>;
+		};
+		opp-2001000000 {
+			opp-hz = /bits/ 64 <2001000000>;
+			opp-microvolt = <1025000>;
+		};
+	};
+
 		cpu-map {
 			cluster0 {
 				core0 {
@@ -50,6 +119,10 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +138,10 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu2: cpu@2 {
@@ -80,6 +157,10 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		cpu3: cpu@3 {
@@ -95,6 +176,10 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <256>;
 			next-level-cache = <&l2>;
+			clocks = <&mcucfg CLK_MCU_BUS_SEL>,
+				 <&apmixedsys CLK_APMIXED_MAINPLL>;
+			clock-names = "cpu", "intermediate", "armpll";
+			operating-points-v2 = <&cluster0_opp>;
 		};
 
 		l2: l2-cache {

-- 
2.25.1

