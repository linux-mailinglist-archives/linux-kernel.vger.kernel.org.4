Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F7A6D2759
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjCaR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjCaR4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:56:05 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56D236B6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so14412540wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680285345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUmOIxvTfzN/vGXSwBwDqutiowJ/QbUaHMK8ehs6bJ0=;
        b=BKyf4eSl5Ij8A5Gk9OSRlQSn2pRoCFWyIYl/CqoGNZgbm3sTj4Tv8ezZYERUqYV4H1
         E1tGOiKM2FrLCEMFlUDF+++sbqxg6jwnfy7ioW0/ojVLifPGBvdW5KgQLCzYuiEwXwX0
         OSzdSY/7ZXbyoUv8KFlPcEk8X8pX01Hn/Gz1FFf/q4L47pZUJI3IJBPtkig8cOlDWBkU
         BWn6+tFIo+bwR8hfGYIpG6Y9zN3JHnAZp/CG24sYy++/NfHClaO+ydkH8IQ3vghuQfQ1
         7ssCO7pPDXB4WISTBpVwKX8tjFzYwOXsEcSRptT+0BQMh2wy36HPaEMmH1H44IUU+/xm
         H25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUmOIxvTfzN/vGXSwBwDqutiowJ/QbUaHMK8ehs6bJ0=;
        b=iD+aPlDMYcPrIPgRVdt0heMqFS6hoIx0HA2fIdWiSxfBHtLBOI3Lg+pGsS5lXXf1BD
         kM9x71nj3t2YAUrI8HbW9Hd2XKHNddN8KkondF+FCVRNWFOVFtWWK+ZRH+6jSDMNurUx
         dAolX0Tw0LeovxmYWsmEWOgc4QNOsoxR1aVXBQiTLft5IzaM1b0+nydqfWr4aPa+CKRe
         T7k7p7bAxxMYmOqm23pP3PKQfhTWbgrdj3qwhR3ts8YRNiZo7G60h4HY3t0PYixSpVxc
         clMb2/l/0SNw0DPtjbyC4YObxMbY4guZ0eTUJ5/U4wBdEgkjh/bU4A9yshyhtJTbNyqt
         QPJg==
X-Gm-Message-State: AAQBX9fizTyEuSezmUq61iK9Q7gbLvxPnsKb1oaNF8eRnNMXDKSXEXPx
        Dgm2+3EiiQgvqxKtD3+VDmaxnA==
X-Google-Smtp-Source: AKy350aDtT9OhmWwKzPH1TmxBtMFR1n4CYep02Ck+wMXTMA4wIXwTafKEFqAvJeirbWtYd2GUvRhJQ==
X-Received: by 2002:a7b:ce83:0:b0:3f0:4428:9445 with SMTP id q3-20020a7bce83000000b003f044289445mr2085101wmj.14.1680285344904;
        Fri, 31 Mar 2023 10:55:44 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c22c100b003eeb1d6a470sm3370171wmg.13.2023.03.31.10.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:55:44 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:54:54 +0200
Subject: [PATCH v4 10/11] arm64: dts: mediatek: add cpufreq support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v4-10-5cffe66a38c0@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=thd5AdegnYYpCr5cvUhR9vmXYqLF1bam1m97/2vSMvw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJx6Ukn9Y4BN12qGraLtke2CiqXMYiKZyMbME2Gl/
 1edfSjuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcelAAKCRArRkmdfjHURSc/D/
 wNDoxeQEaf93XmF9jGY8jY1y7xJyADP3nrf5Z2y2Lt8wFIMZpE+JGGU146cxaQavq53zD0qB2u2eTs
 Eu0JHbahVSK0SaUUnev0u/HQzkVs+FFk7zIiKxYMe8AHp+SpZEval+8zoCJAvw9nc/hA39qSqASTDp
 V8NExTLbMJSOEftHExDxGl2LdyJ1a8kDVKO9hCmLEIY+XmyJn8a7bTYw2rKoKB1BWI/xRyQDpwZ0dj
 vGrvZgO2HvWGtZt8CDuh+uMdRNdrH7WXdA/Clr9Qttl7FEeoEM08DKqMp1nRDCOdSMFLDeNUQtqLwd
 KxnnbD3YrCz8mcMtACdKSoUR/10eIdrqPGNt2nlvE1Wyn4OUkyT0ndFSvbdkXhjI/t9R9WYNZKie/E
 LQ2qlXA9Tzbp7CO+fgktZvXfRH2Z0USTVM61r2upgfKsMCVp5lun3LvxfkAxqRVoxXnj3KhykCzQnq
 4bQOoKnsHPBBz6Dx5V+GtIv0rq0Gjo2+XUrnSdn36u7qPkkU5GJBKyMSsMlaxiIyqYp65pPGZvTw7/
 qSlpRtdxNNXMft9G9QHAl+XV/R0mpMYKiTYoWdJz+tNqGCoCpEg0xAnBmGgtCyMevnP/t8x0NoNXD8
 DR/iIp3h193YRUPY0Emb7nks6pTaHoMWVHB0SnbG8jlEOkr7Wp/5RMT/ersA==
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

In order to have cpufreq support, this patch adds proc-supply and
sram-supply for each CPU.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 431078f8670e..d723838ed49b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -88,6 +88,26 @@ optee_reserved: optee@43200000 {
 	};
 };
 
+&cpu0 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6357_vproc_reg>;
+	sram-supply = <&mt6357_vsram_proc_reg>;
+};
+
 &ethernet {
 	pinctrl-0 = <&ethernet_pins>;
 	pinctrl-names = "default";

-- 
2.25.1

