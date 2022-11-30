Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A663E17F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiK3UMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiK3ULq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:46 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F34E682;
        Wed, 30 Nov 2022 12:10:24 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z4so22181486ljq.6;
        Wed, 30 Nov 2022 12:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZI36fDcXOdBjV+BrFI2iVTCVlIJAblM9KI9TL7sAns8=;
        b=TLnqAXll6nYU3/cRmZ9Qb5BrSLih5PKDpNI/nN0IqYBT75P7ZTfcaSxQ1vzQCOphf1
         4dH78gHGmendt1LXrbeD4+DgE4L5Q1Ar+dpwrJTJMLQoLLsfPNSXb3aLBhgIo2QXxUIl
         z2EHmQR9O+O9Fg8sPELylItlPE2bC+O3x2pQWtdtBbdg8MHUolxP0hjRyK8m1z3Y1EET
         sQMvyqPamW2HGY3/x76DRMZILwQ9/RCxhVcN4en3dfpiWOo+DoydkfsH17u5YcVTIdaj
         DN1oVmz6ath7K/OXtf+KBHb9dGM8mYbWxhNJs3RT7M0HOFbjak8fiQp/42Njrl4Z/GiB
         NcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZI36fDcXOdBjV+BrFI2iVTCVlIJAblM9KI9TL7sAns8=;
        b=7CfZvg5G49sT84Wo0UOzcIbDKoD4VH7/fE4+zSxwHXtM1qkBem1sYwJzKpW5fAGvHS
         qY40XuQMVx1uzBJOMqsKpoAersVe9s6nVfhqnsY/LyIYAt8axdTEhLqXzbh5pQPKsfuA
         zQDerYF1ChoA/HJlQgZ9CtrDnC854ITr0cbxLIwB/ivk0IWAgZDcR+RaQGpNih0vVidD
         6zuc+EnLDIn4IMrIuz7H86nLvNZL4fFoNMkFthrpPho0e3mwvmjWYmN0xipDGyn4kVZU
         DvWtOU7fnIHUHUvsmke+/GyDHE8GbGD8zZM6ISuXDeSATrHce22q+SUsiUk2V65NhqIt
         cEhw==
X-Gm-Message-State: ANoB5pnLLMsLowr1lQIVTWfHs15cJtEWiFdCNMen/sEivuAWwC01Osbe
        gD3CR0z/aS5I6BTAFfgNe1Qvg/4Ii4I=
X-Google-Smtp-Source: AA0mqf6fR/tKq40y1o1ew89Q6kWJtu3M42/4bXxdpMmVeT0mXXt9SSBGrAf8yGd0Pz6k3OUuLYKWqA==
X-Received: by 2002:a2e:be08:0:b0:277:857:87ab with SMTP id z8-20020a2ebe08000000b00277085787abmr13626350ljq.442.1669839023684;
        Wed, 30 Nov 2022 12:10:23 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:23 -0800 (PST)
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
Subject: [PATCH v2 12/12] arm64: dts: qcom: sm6115: Add smmu fallback to qcom generic compatible
Date:   Wed, 30 Nov 2022 21:09:50 +0100
Message-Id: <20221130200950.144618-13-a39.skl@gmail.com>
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

Add fallback to generic qcom mmu-500 implementation.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 38b903592a57..572bf04adf90 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1233,7 +1233,7 @@ dispcc: clock-controller@5f00000 {
 		};
 
 		apps_smmu: iommu@c600000 {
-			compatible = "qcom,sm6115-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0c600000 0x80000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-- 
2.25.1

