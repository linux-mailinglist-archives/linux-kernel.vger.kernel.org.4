Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4F7400E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjF0QY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjF0QYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:24:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E722D7D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f875b267d9so6780952e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883082; x=1690475082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYGwW56BAscqG/0XM30LcNKT0W+nOLB99DFPYLoa8h4=;
        b=sibabZov11lA3Xz8hfW0CnXHL9Af+u9rZK5RCzkJFaCiw551/f9xZ8opO7gjVBdEuH
         4SIMesrNMaC72EWkZteivG5Mie8GpKa4ThW5V7hjw+/vbcF9jf3VlvaT+8jm5ehZHwMH
         jFEqhqLxglmtYkjRwWp0OxkupmtoUhVTMcGNMHbmDKaJ5WAQ5QC2SQuX4nowPy80xWS9
         8wRjmPXVOvdpRotfLb1w7oPL3+nDltxYij9cog3TMkkUlnFeOempPVVcUI4MxTNn3tLv
         OV3FN3H2RA/C8m4TNL1jQMauQWyhBuwzdh2hd+IV6khyZR4+hVIvIv8TC/K8oBljMk82
         f1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883082; x=1690475082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYGwW56BAscqG/0XM30LcNKT0W+nOLB99DFPYLoa8h4=;
        b=eheLogVcSOeRTq0/BZ9+VUBZohbD7zp+nneIsLwIzWGwdqDWpx7BglcprqxYOeen0p
         5J7A8DW/busFISmL+zuzvdbMq1/+5x1vuYaAtBU6kJGXFaj0h6c9UWboHVxSQ/0HKFSU
         X0504nQzLd/f5jsnh+QajtuVzgleEGCYsnECbuOSRATQr0Rs/f6WnX92QO0myv39eN5T
         Xc99STE8+TKHsBBn+oWg5Vt3wwEaq+E86/7m7Z5Q6hIuHWzZAYiAzrc0/eJCfi/Tbb8c
         TYfY4eaZm1i2c5N5AV/AttCYsGmrTst0MM/AfwBAUP7xJshwwJMZ1PSfu6iExOfWAlJg
         0Tsw==
X-Gm-Message-State: AC+VfDwP7FqiRTYQl69HQSnkRKlvDxdNDHSnpVQB4P7BygsymXK8G32t
        9PjytG/cYvJnC5I1dfwYHjuSMQ==
X-Google-Smtp-Source: ACHHUZ6lX9HpYxBjrECJJ0g2VIDJjeuZFhbfBiepWtS3n4v5ytBlMzMZaWyOH3hpcvldbLNDqBOUIw==
X-Received: by 2002:a19:4f46:0:b0:4f8:767d:9b98 with SMTP id a6-20020a194f46000000b004f8767d9b98mr13266735lfk.37.1687883082651;
        Tue, 27 Jun 2023 09:24:42 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 18:24:18 +0200
Subject: [PATCH 02/11] arm64: dts: qcom: msm8939: Drop
 "qcom,idle-state-spc" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=1417;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KPBhSzTOaGsAxteWT+99n4sapq26eBljMzOXJq+YN8U=;
 b=7EVfTk09owESIRFxaijnEfMskf7M1hyXNYPlsteOAdqP/jSMvA3awlLrUye0s9uVnU2WKwmNh
 nJELXr7ZA9QCRbfxrzR6dCs4sjLsMeuIeTO+P3N6fWRU3Zb/sUlBmU4
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

As of today, the only cool and legal way to get ARM64 SMP going is
via PSCI (or spin tables). Sadly, not all chip and device vendors were
considerate of this in the early days of arm64. Qualcomm, for example
reused their tried-and-true spin-up method from MSM8974 and their Krait/
arm32 Cortex designs.

MSM8916 supports SMP with its arm32 dt overlay, as probably could 8939.
But the arm64 DT should not define non-PSCI SMP or CPUidle stuff.

Drop the qcom,idle-state-spc compatible (associated with Qualcomm-specific
CPUIdle) to make the dt checker happy:

apq8039-t2.dtb: idle-states: cpu-sleep-0:compatible:
['qcom,idle-state-spc', 'arm,idle-state'] is too long

Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 05d8abbbc840..38fc22e66bda 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -155,7 +155,7 @@ CPU7: cpu@3 {
 
 		idle-states {
 			CPU_SLEEP_0: cpu-sleep-0 {
-				compatible ="qcom,idle-state-spc", "arm,idle-state";
+				compatible = "arm,idle-state";
 				entry-latency-us = <130>;
 				exit-latency-us = <150>;
 				min-residency-us = <2000>;

-- 
2.41.0

