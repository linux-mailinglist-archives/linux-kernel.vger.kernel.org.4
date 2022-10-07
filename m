Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2CB5F7869
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJGM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJGM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:59:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203081082;
        Fri,  7 Oct 2022 05:59:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u10so7205941wrq.2;
        Fri, 07 Oct 2022 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM8Nu9TmydtHxxHyCRFHEwcP9qh/lbeNGXh9Me0s3WY=;
        b=UayFlbTHQyH39G2geEKKMjf7ErZvT0CWj+MP2JMdCMWjqrmSxSPmnbItg69T/JTUek
         Br6PWhYKAFppnX2F8lTkShSZTJ1PzFMqY87+vkpFQt5K3PhqKMraPRT0Ah3wzydrK+q5
         3KILQJcvsSjXNzBggPu5PTipoUzC03LHqqmsJU2BivTQvWXB0AHeHnrGFfoEI3SynHr3
         gCMYBdzslZiGreEnlInuQwohFdlsqRKdkjNGkXrrreX89MnC/tVWYfsk5jnETibAE2ky
         edtgkuGUWyeyIKSpXGkJjwJsY1Y8pvpgTnzt6QRRqaJW24ln1JAQt3Y/IqprKUYG8hIg
         6f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uM8Nu9TmydtHxxHyCRFHEwcP9qh/lbeNGXh9Me0s3WY=;
        b=My8TZcRK70tneVtHBc0YuccjdxoJ/P++iX+mlWDr2AcOXOwZP0iXR+DIQr2Ng3xRrY
         Bq+F/tkgAMHcGrmaKWoj2bosb//j+Xzf60hTa10coTrIa8CDuILp2lB3C/QTBS0nFOGD
         B8pxW25XHXcITAyYLDxwfS3ALjmQ+2Qwoy9We+/TwtyiNaWbl93Hpz3DUxBYqGWaG4ka
         DdfeeTGpBcoNTFySPlMmQAA+oGIauzv1ckk6W8XTfr9Z2JnOCwh+dOod50g5wLItySpK
         Dj41+JN/aDXhvGUYq/t55EQZegqled++ubOQAzhxH9K5d8YgGKuLM3BitB+URAjHCXcH
         RSbA==
X-Gm-Message-State: ACrzQf3KMeXcNQikDyF168Xj66vEDTbXQ4q2kQffEwMwtC3WrfGhpd0w
        rZfeIrzehNOaonCquLcWiQGEgAxpXK+i6Q==
X-Google-Smtp-Source: AMsMyM7vRJlGfejIvx+TmqyrjdUCwPe4WDimT9tPv8ja63b0eB0KKV95LL096zQ/z4T00xXP0AA3+w==
X-Received: by 2002:a05:6000:1a8e:b0:22a:f55a:94d6 with SMTP id f14-20020a0560001a8e00b0022af55a94d6mr2997464wry.606.1665147575437;
        Fri, 07 Oct 2022 05:59:35 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00223b8168b15sm2008243wrs.66.2022.10.07.05.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:59:35 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 01/10] arm64: dts: mediatek: mt6779: Remove syscon compatible from pin controller
Date:   Fri,  7 Oct 2022 15:58:55 +0300
Message-Id: <20221007125904.55371-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007125904.55371-1-y.oudjana@protonmail.com>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
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
in the reg property, while this has 9. This pin controller has
never been, and will never be, used as a syscon, hence it is
safe to drop this compatible.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

