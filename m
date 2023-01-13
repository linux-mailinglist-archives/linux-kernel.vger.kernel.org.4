Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0525B669B50
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAMPCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAMPB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:01:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42148CD6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:52:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x10so28596981edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WAr0+GGD2fGKXixnjGetPFkT6Eo1APKb/W0QbrZH4w=;
        b=L4RrN52zCJKYL1jiHwq1+vrvXGFT6X0RHamF2kVAYzBo4JYR3ecxto2emyBCKZzuYV
         4FL/8m1YtbF8bw5hwM+6AsTOt/ki0VAoYqbm1VQuNfHg3nPxCOgj2g2/5KxAuJwjx1/1
         LoPAmFulKjx6DFqjSXN5CdwHHQIFutzKi1ZzhjfvGSqyHGmQZqHW9h71F/nW5k1LIuFl
         OYYi+1FoV26aCCe1eyiQtxThbO8izc5GsC3im+cHVu+jSZ4gXBPrge/OXkR3V7OPxRTx
         Xw+JC9fO0Hk+KLNcVKs88sqg1Ahb2OMFBqj96QzT48YMJM6eU7sqMWkyKN7OUqZNF/MK
         YUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WAr0+GGD2fGKXixnjGetPFkT6Eo1APKb/W0QbrZH4w=;
        b=GprO+bokqOu2v+A52XhJqLjcdQZyZdOo4i1DTEeEamy6PxT4sv3uHimUVTsms0LZGU
         SKkxTEE79LwC4nk7HNbOR8aVF5CdURKz3a2BDEdqxCqHyfByvPJJGN0ru8ezQgnCeO06
         voG4kVGmaF16RxdEs/v73vevhkxG8hjnKQ2yxc4gr/dDJmfngCvWwEsx6eT+6tgWCB5i
         PVS0zMywnQpv+p2BMSqaP3giqGzKBkaP4jVSqIF6rdfG2MfSzXMTYxI8Uhl7VHj5gtHx
         Sc8Ua7U1bA/poHeCSTtc+QfLtau1H38ZDAT1rhDffZ6S6R3rutyJ3UwV3GsqanOlPdLB
         w7Qg==
X-Gm-Message-State: AFqh2kqjIEG3EfjEurXpEvrFFNUbZrReymbfEAnUbkjdW2CPYRQrX8kE
        Ylfp0U09kuj1zjKzCU+rXmLkSQ==
X-Google-Smtp-Source: AMrXdXt41dKLuKsr/HD9byrt3GJ9NMGhr3Ts+hQl35egSfG6rvmepDKGJ8yFUAyyEga9Wze4VkG+Fg==
X-Received: by 2002:a05:6402:3712:b0:499:70a8:f918 with SMTP id ek18-20020a056402371200b0049970a8f918mr18053606edb.16.1673621554339;
        Fri, 13 Jan 2023 06:52:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7c0c4000000b004847513929csm8284250edp.72.2023.01.13.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:52:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdm845-db845c: drop label from I2C controllers
Date:   Fri, 13 Jan 2023 15:52:31 +0100
Message-Id: <20230113145231.79280-1-krzysztof.kozlowski@linaro.org>
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

Geni I2C Controller node does not allow a "label" property and Linux
driver does not parse it:

  sdm845-db845c.dtb: i2c@a8c000: Unevaluated properties are not allowed ('label' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 0d935c928148..6b355589edb3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -506,14 +506,12 @@ lt9611_out: endpoint {
 &i2c11 {
 	/* On Low speed expansion */
 	clock-frequency = <100000>;
-	label = "LS-I2C1";
 	status = "okay";
 };
 
 &i2c14 {
 	/* On Low speed expansion */
 	clock-frequency = <100000>;
-	label = "LS-I2C0";
 	status = "okay";
 };
 
-- 
2.34.1

