Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68663C9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbiK2UrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiK2UrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:47:07 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9F27B3C;
        Tue, 29 Nov 2022 12:47:04 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id z4so18663279ljq.6;
        Tue, 29 Nov 2022 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4V4btdZ021QBWvTUZ+qLEZ0zz7lZW+zNWyf+w01hNLo=;
        b=EgnIx1O2QIPIuC0LwlxMAf68zqiD0+BC32rDwGwQc7QHDUyP5aiXahCnfEN5jMqlDF
         VIvG7rLtwo0+oXpoz2eIGYdAMQT6dAeGzyYfYTUqiIulQttebwhBtMWug/a20Mlja7Kk
         yzFzN8TnqOvkBRMnUnn1sYDbYNCip53wPfQvGyG5aAGAzeawp439DxlYeEbSevLDBXF+
         uOxvxshIeN/0bMv5hhLXyV3xP9iDE+TWm7hEh5eji1F9gGpitRGjdPNjbvle2bZFziGR
         elMaY0PyZWbVc+q/wxOIRWIbZDGjh0ZfDCRdGbZ9lv3y8V7MC5PeNBRP739eiUEy6IbW
         jHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4V4btdZ021QBWvTUZ+qLEZ0zz7lZW+zNWyf+w01hNLo=;
        b=GPFVkD5m3tFs9247mLtdTdoxrGkBRJQg68iJV/W9ZKWHglSiP0rdbJ3iyqQfG7CYP3
         ohv9F0bjkSYox716/hbZzBMBKYnEGlJ6C08SOkI4RVg9PPT1czHWraT2wsHibGbYk7ed
         qygEuZ97guH+nb0nn2sKvRSkPKFls8yQcilKWgdbLzHYAnvlgUAvYC6A/ZrHbxva2F8E
         s43bjIh+ToLYyGmuef37ONUa4Bkq7X48RvOUo8ftjssWkOUNyztkkXbY5z13xiHxG2yU
         1GddBnJlChoiY2VCuH1bfvQ6+fpfbkUzlDzVFdtwcch5jKK9Tep2O8C/Y/YTxBSB5Kpw
         Jdng==
X-Gm-Message-State: ANoB5pkFrr2MJUm1UVchVLd1EsVY2HeDyi/PZdLNtG1ExYX4Mo2BImNV
        4u5aUA8Sx0IdHyEO3OFrT13dyGuQEvw=
X-Google-Smtp-Source: AA0mqf7eNNhkr2pDGEbrk1tEPverJ+Gcl1qRU601XnJDNyP+wBq3uZ21nEQAFL+J2MakL9tZLwE8xQ==
X-Received: by 2002:a05:651c:b99:b0:277:c41:d44b with SMTP id bg25-20020a05651c0b9900b002770c41d44bmr13480690ljb.326.1669754823149;
        Tue, 29 Nov 2022 12:47:03 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:47:02 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 05/12] arm64: dts: qcom: sm6115: Add PRNG node
Date:   Tue, 29 Nov 2022 21:46:09 +0100
Message-Id: <20221129204616.47006-6-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221129204616.47006-1-a39.skl@gmail.com>
References: <20221129204616.47006-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the PRNG to enable hw-accelerated pseudo-random number
generation.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index decbf7ca8a03..04620c272227 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -497,6 +497,13 @@ qusb2_hstx_trim: hstx-trim@25b {
 			};
 		};
 
+		rng: rng@1b53000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x01b53000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
 		spmi_bus: spmi@1c40000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x01c40000 0x1100>,
-- 
2.25.1

