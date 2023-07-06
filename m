Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021087496F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjGFIAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjGFIA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:00:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB871726
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:00:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc6ab5ff5so3907475e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688630423; x=1691222423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LzHyhZ3766ra+sxcNP/ExwsumD2y82rPN/8KknPtQQ=;
        b=ZSgCD5/Xzqc6ohe6XCBNIU6cfiQLO6qfelgjYmIgVMH6wsNy7tcTIGIiMQb342DpJ6
         VbLBQWfsvvoBKjjJUp3sckHi2+4Jf5B1XgNFM0LIBKQXRDvwatSv62qKfIanzq4jlmXx
         IEKf9O831C0xkuzXpIo+89mvBVfi9hMOH4noDfAemSUE4wskxb5IkcTN5sXX5KWu6jzB
         luBPMmTPSvUbsASCMPkA/eIUx4zXo1UJaQEppXXRUK6oSo2bjyaWlc5uA2IXmGPn5DeJ
         84mF1V74XLx2Z4cl954Q9+Xq1b/CHScc+Tm/Y71Qib8E/CWJ/+3joAxQzOR24mwRu2iW
         pM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688630423; x=1691222423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LzHyhZ3766ra+sxcNP/ExwsumD2y82rPN/8KknPtQQ=;
        b=Ia9tSw39LY1Jio4AFR1qnzHYdq31hT6SpSu70BZrctRwA9XjAph8VUCWaBa9BGQlt3
         Epn+2ylK9brvTNX97tj45jP9dlH0Ac6cuzha6j7YZMQKapA2Gq7MMJjmkS+0Njx+R0lN
         K6RMKYWWxxye+54SVtwBdx3CfLGJYyhXkRIqwbXE3yW/feSJZ8aPf92k1Wgah2jv+Kag
         N4Ncxp0KVj6WLyDFOM/rneewLIqX4gjA+mYrrQp9AjDdV4eXdJFkUykPcQ39AmLH9R0V
         K7eQyxZfUl5oCdCjISab5W1WGrJxQDhcGlr+tmjrcZudJzzpVX1ySJhmdIBw5+JhIQNh
         UT5g==
X-Gm-Message-State: ABy/qLZ2j5PMNHLsa6A0EsQ5l8OO9QkodrGdErvteh5cSR+BiLJO1GIu
        ldItD73ElNdSGDQNybF1PqgKaQ==
X-Google-Smtp-Source: APBJJlGe9XBa7Qp5BI30NOFwdvROYBJIKr2+P7IwtfymzU6PMiAIhnzVSR0r4JA7sctPv67fYXpfiA==
X-Received: by 2002:a1c:ed07:0:b0:3fb:d68d:4c6f with SMTP id l7-20020a1ced07000000b003fbd68d4c6fmr735323wmh.14.1688630423141;
        Thu, 06 Jul 2023 01:00:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b003fbb1ce274fsm5587375wmn.0.2023.07.06.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 01:00:22 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 06 Jul 2023 10:00:19 +0200
Subject: [PATCH 1/3] arm64: dts: amlogic: meson-g12b-odroid-n2: fix usb hub
 hog name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-1-63ed070eeab2@linaro.org>
References: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-0-63ed070eeab2@linaro.org>
In-Reply-To: <20230706-topic-amlogic-upstream-dt-fixes-take3-v1-0-63ed070eeab2@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wn8G9m9VDqCtr/Okvn3AKh56BVrmR4ClWOMn8WHW110=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkpnSUB+oLOF9akswI4NJw72dITuS/RSonHhGvRoy5
 gV/fRbmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZKZ0lAAKCRB33NvayMhJ0dYnD/
 9cZOf8YLC6qO8huvFBeEB2BlULKccOvHgjcA5v8Y4ThC8O6ljFtGTOyX+3g1LuH3qmVH0L6UxePztA
 G4tc1L+I5R6NA/obmIRMEo0sL0lNguMhGgIYv6xdrtLpA4vj9tv5yl7yl7jcOnCHMFVDA0vUnkQZDM
 WlASAMt+TIbSmtl+8UWoASGYX79nAPGtwoThSGj2K7mIb5Ru53S2JMnu/154qfenPwIsIi/dXYS0Xk
 9QgACEaVR6ryPsAFAV32V36nJ0gOcfYWy7XIb/eWsbD3q7GlC1iIwav2GSeCN2O8N63VEyBUaqDqAw
 WoHPbqTFqrGCGzEMgEUelo8/Zw2IYLFKkdjUPOOt9lhfIpEL4MueecfRS+KQCnrgODguNOf4x+jUT5
 3yxuP96489pIt6l9S1+t2WDizbuNv1q8F9otDpSLzD6Jku+DANbhkQVv9ya5VGM07oL7hJpOOkavH8
 vPiUd/SaU0zp896cT7IZt8QH1VraYL3cWHnPXIlXbf6v9a1umYlQexli1k92HOMLSkC6MEMkEZ3qS0
 /T5wcbOfC5djNlNaE+lrIWt/peIdcL8sC2AVNuKEz73KzWY6v+byczo5IvWZOMdMm7Z4Fk/WlK3ztK
 uuzX5slsMVN8NPRRkAGtfTvfgvD70281Z+PnwPZ4CE6NdW7Iya0hsxXme4wg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following dtschema check error:
arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dtb: pinctrl@40: bank@40: Unevaluated properties are not allowed ('hog-0' was unexpected)

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 24d0442dffb2..a0b6646f73e4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -241,7 +241,7 @@ &gpio {
 	 * This signal should be handled by a USB specific power sequence
 	 * in order to reset the Hub when USB bus is powered down.
 	 */
-	hog-0 {
+	usb-hub-hog {
 		gpio-hog;
 		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
 		output-high;

-- 
2.34.1

