Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD47738312
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjFULWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjFULWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:22:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDCB18C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:22:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b45a71c9caso76582941fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687346529; x=1689938529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5svf0y49iFXl6tCPU4tCiE5qdu/qPBXugBRnB6M4sU=;
        b=dzaORKqnlaCe8mDFwctHfLl3pq+3Kjr0ZUSkvXvNh9+Fw50pyfwMVQMcHKhhIV1BXx
         z5RxoZ0ns3F8hu80G1JVa/sIAieZ9QyLAx0za+khMk5YFdYFaimgRX6aMfLalHg4IRf/
         38XNAndWhrs3psgsglp9fugQmWgmf7YLcMK7X5LWc3mBxxgHdiUcLm4EJ/APQd2Unqs/
         dyTdu3NZ5TPFwNb122lFFxBl1sj7rY1omayxeJhfrjMODWO9aRiq2n3TCUFZtGPTn6Fq
         q4X98DEq6LDltb3H9PfxR+qU1g4ZEqdzfARB1+NkfEkhqX2QTfdqbw6UdTtc5qBx3+PV
         e1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346529; x=1689938529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5svf0y49iFXl6tCPU4tCiE5qdu/qPBXugBRnB6M4sU=;
        b=Tvibm074JI2lw7CzF4J9T8f800fvPBkZBS8Ys6gDiSe0Hj9JpLSjEYHRduR8vnJQ89
         kT1v54t/boWCQM35+q8DKXdUnxj/2+LPv5tCqXPZ85hUBghWuxFof9wePZsEle4XVuhr
         Xzxr/g1OEsBECBo1HyBD0YnWLuCBx2dlXBi9u+SVPiGCPsgi+QpEGoP5TLZeCGhTKeAf
         OYbHUaE1tkYhBkOatjCRUIXRvElXXZQlkdYU27lMJ0zPVv8y0AORCOugqGXwjqEkDAUb
         eYx25bt5M2BuJS3LTbGw6v/iZWpp/Pcm8ooksN64rkvFrNG52bZsDKri0BBB7UM10h0V
         3NQA==
X-Gm-Message-State: AC+VfDxsRlZpkHnR+SmjQCxwaDpxkpf0QWLuPkcUug8X3I00S/QATHhl
        8lf2T65gsQXkoRcaT2Qb+5smFw==
X-Google-Smtp-Source: ACHHUZ7ciufMQ/dJ7gqGalScfywlOZ8vCDuVpSbiKH0JhcIt7gFqcwArF9KwKDChnl597oe46QHnmw==
X-Received: by 2002:a2e:a0d5:0:b0:2b4:5cad:f246 with SMTP id f21-20020a2ea0d5000000b002b45cadf246mr8953910ljm.7.1687346528903;
        Wed, 21 Jun 2023 04:22:08 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id l4-20020a05651c10c400b002b22a1a21easm866171ljn.110.2023.06.21.04.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:22:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 21 Jun 2023 13:21:54 +0200
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm6115p-j606f: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-gpu_tablet_disp-v2-3-0538ea1beb0b@linaro.org>
References: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v2-0-0538ea1beb0b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687346515; l=789;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=p5lGH6ZqC7qAByANHSO++aGN2K1HVaeDyoGsIsR95Vc=;
 b=yVRn2AAV9MNjd+/TpTKLv2PRDf0pOPSDD27LwmDBbTlRBRG1OksmhMLf1mM3r5WxUbDhFB1gt
 enCdryhw9k/AdDup6ZmE9xrW018y+x6NpY+cX9jBj1RE0nHRf3Z+/1g
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the A610 GPU and provide a firmware path to the ZAP blob.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 667273ae0553..c2d15fc6c96b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -65,6 +65,14 @@ ramoops@ffc00000 {
 	};
 };
 
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		firmware-name = "qcom/sm6115/LENOVO/J606F/a610_zap.mbn";
+	};
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.41.0

