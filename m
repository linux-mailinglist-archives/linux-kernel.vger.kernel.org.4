Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B092D69E459
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjBUQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjBUQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:16:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A42BED5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:16:57 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g1so19084244edz.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qgw0AmK1U/4XFxqdFWiQIcUFoLtC2XE6pEAKu9xLso=;
        b=LJSdGxHeUbOJh5U+DsxiFxsrIX3cVHr+d1RJVcSe0QOWIDaV93zgRapt7edtgUr5fW
         oRy2G7cDsC09eRWCi5qi71T+63CORBkYYYWp5CrJeCEMEdp7ZRkSd+SnUC6h1ryRMrOv
         eDfby1Azg52z0oEier9px/RFumgPzfQiVOOPDYrC26fYiAclHB6hkJLKfxMSCuieEDEt
         CNe9YgFWhQbm6IXv9cMLLckIIZ4Pqq0zDCyeYvMZ88bIapyHKdDC/ALnvWi3SRBLFjOK
         0Ju+OaWCS90KOOyB2Zer0fqA7C6sj+l72t9LBSi6wJJtZE5FTrwLFTRSDWmjSAHfElTq
         Gumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qgw0AmK1U/4XFxqdFWiQIcUFoLtC2XE6pEAKu9xLso=;
        b=sAKSA6JfVIc+OOrAD21LXa2Dgv6BMbVjOF1+TKsOfU/W2oGsZU+mJoyrB4lj61yEYF
         66XKdRkEfUjs3nWLO/HEq90X7E/ODug8tG+RoWV3q56ozmxjnRi3egJDwpLFD/q7m1Zj
         SnENC5NEpXVuL2lacxWTy5GNMVXF1w00BD9Vkd+mQtZKcZmqGuT1kCjozGLe3eh4t3KY
         UeDWoGS385IZlUOcPYWibOytxbW2x2ZhqBPXCVzmO9t4A+gnptq3lamf2dVHnm+I+Udi
         /cApA6pao13RRDHJKk9ww/8WovN5fBSOvFiXiJhsYseRcl4vyTKjSV+O7lQCFPh8sTCE
         yFRw==
X-Gm-Message-State: AO0yUKXs1KJ+/kfLU4F5cXykBd5hA43QZt8qHHAiXosKgQQCdaaQyuoz
        Xb83XoaaJQciZb6uJdSo//ywmw==
X-Google-Smtp-Source: AK7set+SrGXKa800i2OrNT3P4t5/TYlN3PTGX1m1S5tM2ViaZoYAl/YYdcJwK5AnGRzLxmUpcqDPrg==
X-Received: by 2002:a17:906:11ce:b0:88a:a27c:c282 with SMTP id o14-20020a17090611ce00b0088aa27cc282mr12626034eja.47.1676996216447;
        Tue, 21 Feb 2023 08:16:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h21-20020a50cdd5000000b004af5968cb3bsm643322edj.17.2023.02.21.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:16:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: exynos: fix MCT compatible in Universal C210
Date:   Tue, 21 Feb 2023 17:16:53 +0100
Message-Id: <20230221161653.56574-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When desired, nodes should be disabled instead of changing their
compatible to a fake one:

  exynos4210-universal_c210.dtb: /soc/timer@10050000: failed to match any schema with compatible: ['none']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 20840bd0d062..1acaa6dced99 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -513,7 +513,7 @@ &i2c_8 {
 };
 
 &mct {
-	compatible = "none";
+	status = "disabled";
 };
 
 &mdma1 {
-- 
2.34.1

