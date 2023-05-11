Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AFA6FF743
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbjEKQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbjEKQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:10 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152357684
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:07 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9661a1ff1e9so1002409966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822605; x=1686414605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rp1+YNqwHNM+RyCFbekDJNKtYIO0hDnKPiZFvATcjlg=;
        b=15PRW0yUiatX08i12bpIGK6YN/oc9Gpd78Dd+Pgy1W0XoyRAE61kH+qsTIxjO4hm4r
         jKkXjSVJFqm2oTPpOJVgLdACqrvfwJFYJnnFcVzSnq0TxlqRs2sSCxXcCMgJHUb8t1Uy
         fUpNvZJT4AsXd5OT1zVxFwANFxh0Oq/rA8CoGDZxYBAusYu5p4ReYYnJIkNAgXAdNi7p
         GTBl0926/h/RbyaQ9FJzoZhME9exF0y4dVhFnu+Xf5Tp/AuMBBEBvfzfZA99jI0hMq3N
         quSRdSYKyIyY7EVJ9z/Yac/0NigO2SYANsT/1LYzsXbstqPrL35k7WE0nfEXa4tg/jnQ
         cjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822605; x=1686414605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rp1+YNqwHNM+RyCFbekDJNKtYIO0hDnKPiZFvATcjlg=;
        b=cIo0MlWveMTHw13RL3AW+H2ltQQfbbfw8HxYtUfA9J2a7fPBrZ4uVtoj7VP3HYrQm3
         RRyg9C1ijNIwEJYYXIZ13w1qpd4lZHjXU4RfA8TGGXYOpD0lTWmiRpSiLu66c3CfNG6j
         9uVnQMxpdzbxbTgrahPsRLgTf9J5ysOtTYzB+i9WAHRAQS1veCFPZQLKla58q7P1ya86
         NkWNH9xn58YW6x3SGbqPE+qhOh++wxsZ+FNkzzZIUmgG71QsGh+/56czJU6emmDAIl+E
         qebKXxfD1h/wmg/ZKG6nNcCTQMY8cd3hF+j0ZwosD5e5dXCFcIEbQyw4JCoQ2qILNWaR
         JPmw==
X-Gm-Message-State: AC+VfDwlRTfrc41/CTbHoGVWOkq0Ral7qRfaZfJ9oBamoDmv9z0t6jff
        SMk2XgvrseeUPHKxe8Ot0Fh/vvqkiyvPhMZek/c=
X-Google-Smtp-Source: ACHHUZ74Mg83gHGhdecC6kdyn/4GZxQb79hJ6u4Q8eJUkKz/Lr8NOxZ6nrWVqBv4U3b7ejy+QUAtAA==
X-Received: by 2002:a17:907:6e9e:b0:931:ad32:79ed with SMTP id sh30-20020a1709076e9e00b00931ad3279edmr24167339ejc.12.1683822605186;
        Thu, 11 May 2023 09:30:05 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:30:04 -0700 (PDT)
From:   amergnat@baylibre.com
Date:   Thu, 11 May 2023 18:29:26 +0200
Subject: [PATCH v7 06/11] arm64: dts: mediatek: set vmc regulator as always
 on
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v7-6-98cbdfac656e@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=905; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=cUc4DzZIiD+nDf33lWao3J8L/XHyfRxCzPKkh1j5Cr0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgEKlLyJAJVOnWxuOHYSHXwHxiJ3AQcPZcHsQ5r
 oMa68dSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBAAKCRArRkmdfjHURR/WEA
 CmCC3nenF0nsD7hbh9tpUTtmwZ7/GFhcqCUV9wFwj1yxZKLLQliINuuKh5n5gKSXPxH7xzGCQLggOV
 bpmlzXTBSSDCi27xYwp5FuMrs4MsEA1GhUkWRgPDI8vpiRkyQYw//QHLHY3mWb12AbXwhbdxBdNRHA
 bOxn6E1DmhVPdmAt1wYX/QU3HInZ0pk2LF+eGY4FjzawTJ62IoY+9FjRm6pjJT4VhYy9OhDWFSnLA5
 KnwYLchxEL48rZHnzTNXhNWlSF9eto/W/U/9nWXvl3du/b91kphS1hJ3TUc2oR1Jauwy/8U1+oJEW2
 udhn7Fave84NhMw3qHRQJXcuD/6/EORK8xm618yF+q554tBnKyTbA/UWpPjmdwO6FmGaRHy+owwheh
 RI6qmdQ4ZaIZcXkAYfP5FH12qcQRePbRck74zI09tGzmiu4kxDj6mDLqG96cMrm7KsHAArSd3EAzJ7
 cXYNJbhT9rxpaHSveRK9lM4ry66rYe8WLHby9XeZhwRbRfwg3Br6Pm69PWjlsAVMoSwJKxJNXotOm8
 HYY5UwPlRJq5gyCjFT7pLdAG9bkRBmniYfpCUg6lsZJZ0eR3NOZv8T7w619nMTY9Xx9GCK1ijlSD/X
 BOYZZHRL7Ag3F3IEb8yVxltEboADLZhMEfnEK9UYuZRxOovyc1IsLw+i13dg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

On downstream, we observe that the MSDC IP (used by the emmc, the micro
SD card and the WiFi) isn't working properly if the VMC regulator is
shutdown.

Make sure it is always on.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 752007d0598e..5d69b39c8746 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -137,6 +137,11 @@ &mt6357_pmic {
 	#interrupt-cells = <2>;
 };
 
+/* Needed by MSDC IP */
+&mt6357_vmc_reg {
+	regulator-always-on;
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {

-- 
2.25.1

