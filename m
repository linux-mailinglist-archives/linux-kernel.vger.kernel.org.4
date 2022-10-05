Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485E15F5935
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJERoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiJERoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 13:44:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8783A483;
        Wed,  5 Oct 2022 10:44:17 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j16so15065469wrh.5;
        Wed, 05 Oct 2022 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J6AdrG61fFuk3qFrjsmnmW/v2lHEYSKDOmlc3Uttj2I=;
        b=jiMuHvxyLhrd3kGwgfpUsnOt7hf+tBiYex6HV/Mo3+9CfzkqQDf6kj0FOvI6w7IOgx
         8rOazqdOFH/IK4kOu/nGAE0Gwd6tz9zqFRiK5SfaUIJXNPBb+cLIiRxK/dzP8zBDbTh0
         bmJ+RXjS9uoWTvXUf6lO8s7sgUeuSv5Q/CzCWgz4PuqV+33o4K14FqNUgpr5tuaGFjwD
         9rRwMirpE+krkiGstEYsvIXsCx1PSUOdPjdDtnA1aNLOvgETT45mqxJRkjIucnOTEr7r
         HS1oYEmDw5gNgzR4CYmaL+LIiOyijjWsOWxkmgiROpWTPe/B7erVlKS7bcDDlOvOR1Yh
         +pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J6AdrG61fFuk3qFrjsmnmW/v2lHEYSKDOmlc3Uttj2I=;
        b=SdGY6ItuTb3cbmrXmLER4fxNqFXjSyexZzTC7ISTP0htYFRrCQZdx5YRMh81oNJE9t
         Pk2o4kCBVdKZFcH5NkjoW+DdtgiBJF4zAyZrAKlZshLf6b8SYJ9C6JJm6fXFbeLBTfMZ
         C+y+x/GsrYLuu6G3oHEV2EQTq3bVUiXWoSZ5ius8NKSCca/8Sx9arOOze9t1JKIQ5OF4
         3h2i0sYWOOqSCz3W5K9ZcleqhmjHIyQeW9qJG7m0TRziRDSRjHY/Kry6S4bklzSKUa3q
         j1ipanYpncy9+uA9qsjGPs74bKCnNCq/UBOelVWOjC7XZvoASwaBlaLGC8/HV+6cPl+/
         Yj+A==
X-Gm-Message-State: ACrzQf19mWLi97x56udYj+7wctpu0hJnE3jqVVzlL98MSmh3u+DoY4Kk
        dAU4TQ5OgCjcIO7NGK5+N/A=
X-Google-Smtp-Source: AMsMyM7LORL+FOnuDtH5sB3TJMSNlDx7UAQ83NOa0L/mNBleJUp+Cs/QLwJCYNTum2QiG1rzKE0y+A==
X-Received: by 2002:a5d:474b:0:b0:22e:3180:f748 with SMTP id o11-20020a5d474b000000b0022e3180f748mr520389wrs.504.1664991856242;
        Wed, 05 Oct 2022 10:44:16 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm16075491wrq.42.2022.10.05.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:44:15 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] arm64: dts: mediatek: mt6779: Remove syscon compatible from pin controller
Date:   Wed,  5 Oct 2022 20:43:34 +0300
Message-Id: <20221005174343.24240-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221005174343.24240-1-y.oudjana@protonmail.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Remove syscon compatible string from pin controller to follow
DT bindings and pass checks. Adding the syscon compatible to
the DT bindings documentation instead causes a different check
error due to the syscon document specifying a maximum of 1 item
in the reg property, while this has 9. Nothing is using the pin
controller as a syscon at the moment so it should be a safe
thing to do.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 9bdf5145966c..a6fa5212da4e 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -160,7 +160,7 @@ infracfg_ao: clock-controller@10001000 {
 		};
 
 		pio: pinctrl@10005000 {
-			compatible = "mediatek,mt6779-pinctrl", "syscon";
+			compatible = "mediatek,mt6779-pinctrl";
 			reg = <0 0x10005000 0 0x1000>,
 			      <0 0x11c20000 0 0x1000>,
 			      <0 0x11d10000 0 0x1000>,
-- 
2.38.0

