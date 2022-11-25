Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A69639188
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKYWeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiKYWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:34:42 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9224E230;
        Fri, 25 Nov 2022 14:34:40 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id j2so4092445ljg.10;
        Fri, 25 Nov 2022 14:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=niMavHIx/AWaO4yyhWp984rwBKsNidh7Wk+Ub6Q559A=;
        b=KJJmGGxbxWMugMPePN2a3OVTaDG+dR0vMeor/ObZacim+FpRkzQsgYz/xz5WhrFbta
         zT7zAaeyc9tM9xA6mMhto4IyBv2zqrhCCcF68qFhegdZduEvV7q5MAwiCtUBsDqPk+vH
         IHaqxdxk+wUiZQNmPS9j6KMEpo2ZdO461GwungT2DlPuomfuh+9a/e/tEuLU4SnYwQy4
         gtGVt0dKa4/0Qwcu6EfQn7kcGECOV/RZGgqm6BKUG3ONTtqs6em7hf8Xa++K+oST/cTM
         wBjOAfUTa5CMMoWa38W84KSBKcSFW4j4TnBs8ejEoq2DfL2SLleqXYDqohvEMRmo7DWb
         Br4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niMavHIx/AWaO4yyhWp984rwBKsNidh7Wk+Ub6Q559A=;
        b=ZV6WYIEYpTAh/XFTCTcgIX4wxr2eY0P7+YvFjQziywpwS+eSw0raV28t6fkH0l5ena
         Hv/LCjO42f5j+JZMkwI/xkUFKZBFirt3vV2+YlYhEviJgRw9HUlhOCzt96TsMnpikBNA
         Ilxt83uE3dVynh+jZwyzrmPIbyQXWKDaHtMqp/C6MZ8OCUvL7gRkXQc4kPcVjT09cthN
         4al9MKWy0tu0w2WULNaPCiUjE2lElmpVAOIX5ztB5HsjAZacp4BX3c7DxjuuedlGhJ++
         pLjGHFAV5ocqMmSh3SM0E3M9ZjTO2yf6/hG7CYMRrIrYrm+bdD6SFGf9/iKbnciW42F8
         uMJg==
X-Gm-Message-State: ANoB5pnz48ja6zGceVD+t4vy3V3PW7hCWVdHj0kdkqFVuBBf8D6zzex2
        eTKWGXbZ3IBcMFZy6Ifd/GC5f32dFXHBmg==
X-Google-Smtp-Source: AA0mqf6s6qDidC9qRW9J/WhddlUa/IBPQVUJAWLmXF5Grr7aIHh66El1D6eDfiMgD/tNRmIeMFYN/w==
X-Received: by 2002:a2e:7306:0:b0:279:9104:d60c with SMTP id o6-20020a2e7306000000b002799104d60cmr2017396ljc.163.1669415678801;
        Fri, 25 Nov 2022 14:34:38 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id b4-20020ac24104000000b004b4b5bd8d02sm668945lfi.78.2022.11.25.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 14:34:38 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable ADSP
Date:   Sat, 26 Nov 2022 00:34:00 +0200
Message-Id: <20221125223400.94515-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Configure the reserved memory for ADSP and enable it.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 1c52337af560..859e91c16c61 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -133,7 +133,8 @@ wcnss@d200000 {
 			no-map;
 		};
 
-		adsp@d900000 {
+		/delete-node/ adsp@dc00000;
+		adsp_region: adsp@d900000 {
 			reg = <0x0d900000 0x1800000>;
 			no-map;
 		};
@@ -169,6 +170,10 @@ rmtfs@fd80000 {
 	};
 };
 
+&adsp {
+	status = "okay";
+};
+
 &blsp1_i2c2 {
 	status = "okay";
 
-- 
2.34.1

