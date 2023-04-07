Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D966DAD92
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbjDGN2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbjDGN2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:28:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1305586B0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:28:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q14so43539701ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680874120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qrp16+bclmc99syXIKvGh44pTCvLytsw1x/uNP3QSg=;
        b=MWDrv93HhCvSMJ+pWQEeXjME20LxtFzYPkQcZoitRui3tk0zoaCTeUS52qZHXvNde9
         c6lKH/GQM/PwpbqdAfcEs30OVirUSxfyRwfr9wVTomZUnWygA/s+OYksunrSJSR0vDHo
         3MFcK4fntuQdhsVDW57CWH5jZxgzGdnLjMHwT/zoEIZNs6eu3884a4j2tWhall3dsiRy
         6lwOVUbjUh7ceAyfBMTg5CaCDONNy2LMfG/4iSU8r1c1LUoyGUVU+OWNlAtBIGWCdWWG
         dHvgTq82Wuoj/AsonRdRypQq2qbLJmw1R3AW/1OPQwesS8kXt1julgGJFaJ1GRRs339R
         pLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Qrp16+bclmc99syXIKvGh44pTCvLytsw1x/uNP3QSg=;
        b=Z1/t1Q4OoxRKPQWeTsU8yMj1dFB97M65GVnFfaIyTQEcSArrNFm0eX/K73+TX7q6qk
         cq2zK9R3fZ2h4D31xOZaAfp0j1FkiE3mF7tYIVfMpdy2QsOBv7+SVsZAjD1Ua8NaOth4
         gO3kJug1LrReyUJeptHnvSNcaZSACKiL4ZwiD0m71ssUdAdejxaiht7TEmn8XBFaqXO+
         hME5FJ+nllVDwCJiq5fOMD/e2Grm9vAZVkAHN14p5ZgOpZbAQcgEBpROfop8BPQjT9tb
         RqJYdwo6dg+RiyYzVxvMj6+6771C1XugGsgkeLn8pKnApSzLwbR+ZN3te1NKOges8L6h
         JhFw==
X-Gm-Message-State: AAQBX9cWPp67iM1EwcM+571HX69XRZ4Vtwi7fSQAKa0K4y9RoOI7yE7N
        qi2kOBOn8GyRsiVb6RPp2EBOnQ==
X-Google-Smtp-Source: AKy350Y1Z3yUxBXAZndb/euEtaLZY2xRexNvc+IuXlQ4YmU+HvZDzwLaGFTqY5mjBTkP47DQL5F+HQ==
X-Received: by 2002:a05:651c:d1:b0:29b:d4d0:d3f7 with SMTP id 17-20020a05651c00d100b0029bd4d0d3f7mr488284ljr.26.1680874120450;
        Fri, 07 Apr 2023 06:28:40 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a2e3a02000000b002a618eb72b1sm811031lja.98.2023.04.07.06.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 06:28:40 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 15:28:35 +0200
Subject: [PATCH 5/6] arm64: dts: qcom: pm8916: Fix pm8941-misc node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-topic-msm_dtb-v1-5-6efb4196f51f@linaro.org>
References: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
In-Reply-To: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680874110; l=1099;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WG/ipbDMuDk+aHJosMLwAyE+K0gF2DpT2uf5CXcw2yY=;
 b=l6Ef1ydbm+TCxHakiS5bpJ536JObhvG96L9jm9ck1pZ87J3Xfuj6cPA3xSQDrNTU+XHEAEZNXwLp
 3xi2ah/ZCF0AOJ2EVoorgNg35Iqy+mIVCj8JSmaBr0148qNfmqRc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the node name to make dtbs_check happy:

qcom/apq8016-sbc.dtb: pmic@0: 'extcon@1300' does not match any of the
regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$',
'^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^charger@[0-9a-f]+$',
'^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^rtc@[0-9a-f]+$',
'^temp-alarm@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$',
'^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$',
'gpio@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index e2a6b66d8847..f4fb1a92ab55 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -41,7 +41,7 @@ watchdog {
 			};
 		};
 
-		pm8916_usbin: extcon@1300 {
+		pm8916_usbin: usb-detect@1300 {
 			compatible = "qcom,pm8941-misc";
 			reg = <0x1300>;
 			interrupts = <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>;

-- 
2.40.0

