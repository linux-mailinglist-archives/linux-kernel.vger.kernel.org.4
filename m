Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B215F3DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJDIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJDIIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:08:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A71F60D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:08:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso7053723wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=FGkwToaEY2/oWxxoPFSmgbzFTRsRAd3NEFRgk9zoGZE=;
        b=APG/eZ6CUVX2MDUjQXHEG18l1HVsNHWeyRsWKHjW4lIGCXsTCw3vj8DW8a70ZAa8qO
         3ChKndlanZfZtlZ3qA3oOvB0LbhhWfQPDnQlH0UsCE2bLxw76Q1ZQOdC6H3LbWf916en
         qm/2B5HtKgFXlAIyhwv6ojU7NyRVI2EXppvVWfDy7jJw/d5I5ClvPUzDA1jsvxzrbKj8
         SZ+KI3nG8sZG2ceDR0vDsUBirlIzz2+VjwdtM+ar2UebOP9iYXSFrHuTmkTnDTErjxUu
         1JLm0iTKNRY8SMWVnol7S/HrVQYF+ixyDBcNeuvIOX3ayUsB8DNSdOA4e86OjMLhVUge
         l3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FGkwToaEY2/oWxxoPFSmgbzFTRsRAd3NEFRgk9zoGZE=;
        b=BvTKRVG7pWJ7H8iSBdE97/QASsdD7oBFrU+IUCfZk5g4G56OX2kvasH4M8C0EblUv5
         2qekn+nWGaqCp1Dg0fPfrckWQT0jWYp47ur2olvsSK8Mq3Ozy9P2uA9fF7AV0CfPytA6
         RP9BGjW8pqj94l5kS0s3L0MM+uuFcD/jxed7UKaYid8b3nouIYxvuPmriC23PY6nd7LQ
         dQl+peqHqojBr2Hsfg28Lyo0uRMsqUz4XiDfAGI3yo9gAySpssmhTzTkffwdPSlcKCtH
         o72/sA5BxEXkAF4Ni/tPMEiQG0fg6oAgKZL9xn3wJOyShlysvjDn4I2CwsEZbtrFBz/l
         JpvA==
X-Gm-Message-State: ACrzQf2Ds/edG5iZJo9tU0POAXTVmpnp0hqTpG+UfcK8Q6i8+1wL0iAh
        2r7pAHcRMn9aj36owlQGbX7skg==
X-Google-Smtp-Source: AMsMyM6NRV3/N5v2bN20Kv0/bQJ1IPPY0qQ6BbXOkruyXpdbZKMuMgM2d5S4Hx/sDp/QC0jD542lig==
X-Received: by 2002:a7b:c389:0:b0:3b4:a67a:2ef7 with SMTP id s9-20020a7bc389000000b003b4a67a2ef7mr9250243wmj.180.1664870915410;
        Tue, 04 Oct 2022 01:08:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003b33943ce5esm20228866wme.32.2022.10.04.01.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:08:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 04 Oct 2022 08:08:26 +0000
Subject: [PATCH v2 10/11] arm: dts: qcom: mdm9615: remove invalid interrupt-names from
 pl18x mmc nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v2-10-87fbeb4ae053@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v2-0-87fbeb4ae053@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This solves the 'interrupt-names' was unexpected dtbs check error.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 366241dee522..9d950f96280d 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -325,7 +325,6 @@ sdcc1: mmc@12180000 {
 				arm,primecell-periphid = <0x00051180>;
 				reg = <0x12180000 0x2000>;
 				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "cmd_irq";
 				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
 				clock-names = "mclk", "apb_pclk";
 				bus-width = <8>;
@@ -345,7 +344,6 @@ sdcc2: mmc@12140000 {
 				status = "disabled";
 				reg = <0x12140000 0x2000>;
 				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "cmd_irq";
 				clocks = <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
 				clock-names = "mclk", "apb_pclk";
 				bus-width = <4>;

-- 
b4 0.10.0
