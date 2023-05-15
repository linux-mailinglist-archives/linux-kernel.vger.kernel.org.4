Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F7703E80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbjEOUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245335AbjEOUSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:18:40 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A522D13C2C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684181877; bh=jEBoYmuGZw6R38I5tsonVRB7fSpXqSHBWIu+bqGhF2Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TKzN8LosM65KfRJTs+hh+FxEqmrp4uZbDojyhP89SZZC6P4ndSNAj7bGOCOqPcc5PgDcXyJ3iCCLzWbbs/SXXCedhlVnfJbViE2yvjoIB3iH4weynLfE/p/ASFVd0f1HTCr/eyTvImobCUDm6Lu2J40zJU9j1t/c0fTvoyMC5V9Dj32wawU4UeHqVuc+LLQtP7qCx14AsVxO6f1aVD8wYv616kS8S8eSskOgeWJKiOk54H5UmbztAafGo/42TMiVisvo5f2cAH92u68w+D6aJCYM76UZ+QZiWXqp1lBQXuY4Ppg62fehfAtZPvkkYOdykiy+kfd2aYFWHbzJqUAyQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684181877; bh=z1MWPX9N9Ze7lK43Aded5OrML3qZlL5e/9G9x1AmnTI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=T4wN4+xabuk64OHB8hkT2h4M45XVMCAUyixcM8uJ4ol0bMeLmu9baIUCOwaNVIwCbPe/Og6CxK+pcIbINwiTw0b2Di22XiAgq1oPnyQE4bjA+cCuTqnjbQi7p6lQMvDH0lL1WtCkDfs387QElt25A654wjNlV80iHwaGd1x5sSyvWe7W94KgMLNFfVLWn5jBvmCookY1uGfOfBYFm1rkQhh65k26Nu0Yf6ZM8Kjc0kSy/A9mzSLB2ofuzh+nuKZ+PUGLRlae7qW+cMcptMOgJxdHtYWX3A7UeSKai4ZcGhHyhyYUwYyrEf4U/DqqaJbjT1SabaZAmGDYII3x2A89OQ==
X-YMail-OSG: bVDn_HkVM1m7cbailOR5hswwOnN35CHaMlXZST1TMrnSS1bDZxwyN9yjB2_YCsb
 wLiUsTWlXGQNDiHhcvgUCpuxgdHVqwIxpB_msnG80MerYMYbP51SI9JNui5KwXnoBSBKA.Au.rVY
 8OiAo5vX2FpJCbjPabsG8tZhoFcPx_g9Fjb_P70YeduIOvB_AUmb.0HiwBaqr2.SCr.unoZYnNd8
 OEBiF.g4HPWwJNeafHxnM8EWyU_cAZYltedQpW5yP5BwpskhYh3qhVH9qvR9kcbVWyGNAHwuyI.t
 bLY2IYjKWrjSninX3.GnnuKy6Vk3mqMr9MpapXq37xKdevlPJeYq1tttE0EqlZzWGSpG3iPUD_qh
 vx.5u5GvXF2sLelw4VGm4Pt7G6_8sHaNIj4MMc8boeEuPYiZMm7opXBxjCCn74kpUwQCau4M6Cb5
 _gfmS9uLrjcoIDn87tBq8XxPspE5GBZVWGqWQg4jcxaYj4a1COBrNWYHJnshJo8GmnxcenKcdcPh
 u22SUQi4RD2mryP8m5RWGmzUQrx.XgrdXkC_yBb32H5G8a4.5flJK5n73Y_Qqgdjinf3XKOHoW0t
 jGIt__cVhWPSujuOBmLqBt7yJghrczIQtzv_IXqJFnG2BAj4D75E4BlKFX2pKqzy3gEhAnJSZIOm
 V8u7PIaesYi6zqRW7hPaKFNtTTFdfCRWztPyKByG1Hq8U5eZ8XcbLH_ddpQCMHiES8iRSEL1zMPc
 FaKGEn98zMIJrbuoS27U44lFRLGn8exZbYZNHGlevaokdL1JLvTQekmivuNxTXSPyPmSJ2uQB1OC
 UuSDfN5fBjYmja0eYb.cSk9Pwkomyzn4ALXSS5TVPocHPxcuGD9JrB7nd_CjGuIPIgpkfLA8tfJN
 _XdO96kdWejdWUE1EpEC5M7ogob61xvRr6t8AfsrHMuQpbHowLo.KDzKYpN2gzS3NyVlCMDhqcT6
 z6X9fodXqW3SL.XjrJEbLgmiHbV1R3UZNHt.7GFoQ7gWasVeevNcxy7WXwtmIY7YyxRTgskC7JSw
 yKE0VYGCGI3QEJdErlQk7FrS3ZFxYedRQJmBKry9u9mm.Bk65kgj6AZrj0gEFCDuQa9NmwEf_BDi
 R4xOuTjf4Ti2D4gQGOyGj9OkLs8W2PBbQO3GAHNiPMzg2y_iciTqjYyvJI.TAYpBS7m.3KpcyClB
 ZbPP78A1LX2MkISBGOeVolSldeWYi7WMKjn7UZ5Wk12kMElXJSke_aVaFi0srwDup6RI8.2DKpzp
 pmeJSanuoWyNg8tFjC.h8I4q6imA48svjgjwwFx4cG0wMmHr_ti2.fBqscPBPZYeLCntxF509Mve
 4XoloWZTvaXMihZl.vLVPzyfjKybl4b7O2u8c57wNSfcXNrC_Ell2Wsz6Dk4cO_fxNbu9JbkT2ot
 thDnyuKhDy6Jx6Sn3vu8OoyH.TZJblQ0X1w5g9DYZhLnVsK9GeDNf6SnpO16z0MTQfpwTR7NIRQZ
 NmWNAzC4dBNM2Pl0q5_WUU_TJLnDk_OKgX5Lbc522cOp.0wFUNbx1uzXZ7KoGxkwTkqSRFjZ6omj
 rgLsiJfG0EendCVwBUi5ExhPkOMxHvPMvYC.pvpki_PvQ5Yx1zS4xXGh8toemcna4VNjzT6sQUwQ
 9CHFfxiLoo1bwrby1K22nLSJHDPHzbs7ec7rozRBeV4lgoglL_VsKblV5zFfsGprsWsuwo2Dmute
 lXQxU_KTWr3sVBUB43NNGk8I14I8G6FmpHI.R_6zNXS55yEFeoa_tfi1nJ7gBvXoLqCIPO4icz.l
 ELAtOhD42vT8qJ7HwejmsikIAmjeu3oas3LJAR2z3nzeH_aUkirH8BHOMDqezs4Iez177E2E97md
 4fxH3.F5VBlrxWynrqUO1ml0p7aClGhTSy_c.LvbSsYI4qxFbC.HOYOHVAf_5JCP66wcghjJiwy8
 TliEeSLNXZI6nZG_.nlWaDtQyo9Cs0KUY7Mat1lX4.8Ejp5yRgV0eKnCEvXPHVMfivTUtn29vuK1
 xPYEvCzBAQPu6BK9KVCgAKghCCfdQ_KA0TOY_LaN7_h.NgSw7_Gq6Q2SJM3G4_v3tcNTZEn9ePiT
 zikkoZljJUQWZnONpvc2lZzUMcidoIRpTmqEdrzP4L7ZwW2N_n_nWlL2QRdzh7L3bY2zHRDyxznm
 9b.GZU8hTa2uH_pTLx6UsNdQ29W.INVRvUz5KrBVUqQyYO6BgenAsHAMqkvqlPA9jxjbU2LDLAUM
 bv.eOFRdCH_THP8tT7Jz5FiNvyNFQ8tvnw3lQonnOxS4R7ErcLjZcwZw.nUcpzbN6N4x2ZHvP8O0
 quFUA7lZfC.CBXL9CL13X9_WjWKQ-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 0cc3a068-384b-49e5-92c1-cd7962690774
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 15 May 2023 20:17:57 +0000
Received: by hermes--production-ir2-7867f454fc-8nkq6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID cb456a1ee9275492b492c35f2e11856e;
          Mon, 15 May 2023 20:17:53 +0000 (UTC)
From:   Jakob Hauser <jahau@rocketmail.com>
To:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v6 09/10] dt-bindings: power: supply: rt5033-battery: Apply unevaluatedProperties
Date:   Mon, 15 May 2023 22:17:11 +0200
Message-Id: <20230515201712.30124-10-jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515201712.30124-7-jahau@rocketmail.com>
References: <20230515201712.30124-7-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additionally to the already available ref "power-supply.yaml", replace
"additionalProperties: false" by "unevaluatedProperties: false". Otherwise,
when referencing rt5033-battery in an example, message "'power-supplies' does
not match any of the regexes: 'pinctrl-[0-9]+'" will be returned.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
---
 .../bindings/power/supply/richtek,rt5033-battery.yaml           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
index 756c16d1727d..b5d8888d03d2 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-battery.yaml
@@ -26,7 +26,7 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.2

