Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069FA63E188
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiK3UMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiK3UL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:57 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7136B4E695;
        Wed, 30 Nov 2022 12:10:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so28626483lfi.7;
        Wed, 30 Nov 2022 12:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl/3SGuHbTcYjE9iJ013a/3EaSM7R9xbs2RtmEvdhEQ=;
        b=d7+XlVBSwBY+ZiIBpLruH0rFJsWnlvo36ZFWMTYSz74Q6ZWLHCmxV15L37rHyB0Y7r
         V/yGQfdJYJQWTo1jyFhwxHtBGjPt5Ms/A2lA55kT7YbwtQMX8DHZ6bc1VkCbIaiHFge2
         jhq61wHyX9yirfvn0cPejhSXWVnjaYy/zCcf4mgGgetkK3ngZT7kvTMw9MRWLALsiEC4
         ovJ+zffrL2e67TsCR3+fwDojye+URTKg8dN32ZXx49kHi9TYHccT0uvgSykVpOpXkRwK
         8eBIJFBdyC2OYq1vgaLuhNjwUAOUEPaQwWhtF2NSEJlDh6+GdLv4o+1tqTS5T0xOWxIG
         0MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl/3SGuHbTcYjE9iJ013a/3EaSM7R9xbs2RtmEvdhEQ=;
        b=Iu7uE3pSJ0b1qhJuENDcO/cMvj8iLw0RCmuY6Y3ptmuYFJ8UT9xlJ+u1oh/norSC6N
         LPWFc8ujThwmOrKqMJCTiuenOywT3IUN6IkAuezFS0C8fTOufHf0JUhAdypb0D6j2VK8
         UJ3Sij9oYYOpdK4SQy86MOe9ETc5/gzqyI5iT8moy3eaMpIhuAB4oOVm7pgEnzpmabH8
         USSO1L4h5iJV6+QYXvyULDSOepdreg2R/1PekTmlY4eK1k37TrZV3LmpKHujUcdlHP7R
         vYz98w+4az5bWpTIkZM/g6rdZO4spcZOBK0aWSxDU6sqe9SOODpwxB+MEqUeQE+7TBqa
         0+JA==
X-Gm-Message-State: ANoB5pm697Mhmv+/TBIwCWU5K0lX4U6DjFj/IduHJDvW6AtyfYV65zQk
        a5fchsz+UIxn6QaG1olBVxCUcQAS+Sw=
X-Google-Smtp-Source: AA0mqf644QJvev56npSP4QlSbyhAGHSrmJ2DoQNntdwawNAV6VsuVJn1PqO1Jz566QtYo218WOTEPA==
X-Received: by 2002:a05:6512:21d:b0:4b5:d60:fd11 with SMTP id a29-20020a056512021d00b004b50d60fd11mr5935872lfo.124.1669839021394;
        Wed, 30 Nov 2022 12:10:21 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:21 -0800 (PST)
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
Subject: [PATCH v2 11/12] arm64: dts: qcom: sm6115: Add WCN node.
Date:   Wed, 30 Nov 2022 21:09:49 +0100
Message-Id: <20221130200950.144618-12-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130200950.144618-1-a39.skl@gmail.com>
References: <20221130200950.144618-1-a39.skl@gmail.com>
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

Add WCN node to allow using wifi module.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index e676b9d117e3..38b903592a57 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1305,6 +1305,28 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0c800000 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+			status = "disabled";
+		};
+
 		apcs_glb: mailbox@f111000 {
 			compatible = "qcom,sm6115-apcs-hmss-global";
 			reg = <0x0f111000 0x1000>;
-- 
2.25.1

