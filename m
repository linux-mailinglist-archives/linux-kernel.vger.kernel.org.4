Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349874EE98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjGKMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjGKMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:21:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D3F19BE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:11 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b702319893so89303591fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077959; x=1691669959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V7PIgAp3e9OzKKcu+9DEgLawk9vSlyfAdloqW5xIZPE=;
        b=rb2eqLzMyPowvQydSZAKsa4tE7xgx2HK+piNpPl+c142180UXSSAP0CZM8UPq29NsJ
         E1kXvMsMzJVzR0BPspMCFUolGplvI+uWgtsBwk3STmGA3ZYw228Cjy0Uk9NlLbpquLsB
         DAcs3ML9TxoxotbAYbMupJQg27QHvsjeifwlqiyY1XEoqIyrkv4mb2clImqLX0Gw24RA
         5TBo4ajaappxa1VHP0fBYEhPMxyrDNLz5F+ej0jqSopP3kadcqc6ctE/+MqTDslqwLTi
         Nvc21l69DnUkZWnt11/Z3ppIV6GRWURhBixKkEkhNP3+CpSB+lSPeg8748AbJTFvFGK2
         5Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077959; x=1691669959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7PIgAp3e9OzKKcu+9DEgLawk9vSlyfAdloqW5xIZPE=;
        b=hoDNh+1ki5XGcBrIm9rU0OHWSgqFpiBw/aEnKOvON6OYSq2mEfiTDFoy7AZcJicvph
         nOcz558U5THsUgV1zaWLxCx9g7lKADmHJtB0MbrE9gA1t9PZPzo60svRrtw3Yy/dowPt
         4IJ7ipAoiguDaqJ9hITpGcMP7NVqYTi1SVBz7YQLg9XHkYb3mrnkcxeqHVRb7lhCJrER
         aJ7+nqxpUyYkbrEKwvrc1Jx4cf3mMfukUEuRtN1AZYx8LUNa/kZDgzktpK3/oiUyZ7JG
         17ZfaZuUo7qng+uI8aGf/6R7X5b5qT+H/JBx8lYImI7PJe3Qb4WQbCI0uPVfH+SMgEiU
         HLCw==
X-Gm-Message-State: ABy/qLaJMxOB0bud7tfxs8NNR/1MlebQ1lNXRe3/EHTMJKsA+4s15dCF
        r6lNt2Q9DkkZZucrkhVnyfsv3Q==
X-Google-Smtp-Source: APBJJlH39BSC3oxdxluViBIlLqHBe02rhLvZ88xnOKpeR0xFV/NYTTVPmgj7i9LIgHLywRq39YKs1Q==
X-Received: by 2002:a2e:9194:0:b0:2b6:e6cc:9057 with SMTP id f20-20020a2e9194000000b002b6e6cc9057mr11591328ljg.51.1689077959542;
        Tue, 11 Jul 2023 05:19:19 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:39 +0200
Subject: [PATCH 40/53] arm64: dts: qcom: sdm845: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-40-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=1017;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FtWJXYwgz7AFS7yftzfhIEpRiM9nqdnApDQ7r1Yxt6E=;
 b=NFHseIjlf47+cZ7Y6inhcqRB3z2xw6piO4cnR2TvPF9RTvIX0K9ceVjHDtw1I7mK95oxWRDkf
 121F9bjlnUEDmKoJMmA69oNbSbvnO6A6uOwcOntrUzTwqLmTS4wZsxc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 02a6ea0b8b2c..afe0712ad808 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -5142,6 +5143,7 @@ apps_rsc: rsc@179c0000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

