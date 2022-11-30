Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C58463E16E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiK3ULw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiK3ULL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:11:11 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB6299F47;
        Wed, 30 Nov 2022 12:10:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d6so28637725lfs.10;
        Wed, 30 Nov 2022 12:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzD7os1oJWrCvebMO8GXHUfDeNhMiacSWupEc4fuFFA=;
        b=QnJ+vVMOFzp8a0jFKo+gCEpS6x8aMNyR9uo+trjRcjKqNgIr+R0ElC2RHVjYQpGOwq
         d77HwxlmyEox3Dgk/aMoSIpINtcmSsrrEHCqvCd/B/K7Hy6jzJhgfUk0KDedMeS3C7LX
         +6mpblslw6FnBOZcL+T/oSaazMOl+6xQT9IzYtaHYhiA3kuc8NxjONSkLm+8gf5W68JA
         TXceDOADJLLxJGiFgMt7mX251pTQKJQzd4XJYs7UwMMeHiJ6I6vvyIWJNXcFIWEDKiUs
         CWI51GNVD6rMtJb12ieXHqBLIl7uqQwdi2LfM1G74bBeGYFjK9H0Tencrh/1NE7VVwdq
         miiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzD7os1oJWrCvebMO8GXHUfDeNhMiacSWupEc4fuFFA=;
        b=Rc9uuouPXx9dV2USybZHvRVLkf9EKvc4FevHETE72d5f3IxulOWrXnXMppsPD6wKPp
         EwP3nvRclu2TTl5OjUcQ5+sZqx27DWKuf+b2gwV3kEyfWDXFQpZv0tgQ811TuY69CsfZ
         nPrCHibTpjYwJhTVK9B1xzRdI/d+ae0kPCUOD3eCiTWtQWK77yc4qlORY0sx+Ato5wNl
         b+t6foAOko0wsTdar6FQstYZz+/THAgli8dALnPBgXAdU28xly2uZ6h6xEnNbmDXU+Su
         CW3I3r6qYt0zPVV+fS0DrIJjaykE3/qc9lSI1RRFU0Sl3FobHuNl53oB2j7gfySKepU2
         uELQ==
X-Gm-Message-State: ANoB5plKlP/8/a6lQWTwxSohEgKw85Q7nMuQQNrWwM2tuX7briczCmFG
        +mFbXa7LcG/MSZ92xpV2lEb5O9RphpU=
X-Google-Smtp-Source: AA0mqf4LbHHujIm1MRFMjViBtA0LkeUiEaUyGqRj8qITqoI1Es3DWJCLZVLzB0RQwO+ut6NVczotDQ==
X-Received: by 2002:a19:6b1a:0:b0:4b4:3313:feaf with SMTP id d26-20020a196b1a000000b004b43313feafmr20707007lfa.365.1669839007666;
        Wed, 30 Nov 2022 12:10:07 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id a25-20020a056512201900b004b4e9580b1asm369754lfb.66.2022.11.30.12.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 12:10:07 -0800 (PST)
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
Subject: [PATCH v2 05/12] arm64: dts: qcom: sm6115: Add PRNG node
Date:   Wed, 30 Nov 2022 21:09:43 +0100
Message-Id: <20221130200950.144618-6-a39.skl@gmail.com>
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

Add a node for the PRNG to enable hw-accelerated pseudo-random number
generation.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index a2ac06f4693b..6f4c36f3da40 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -505,6 +505,13 @@ qusb2_hstx_trim: hstx-trim@25b {
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

