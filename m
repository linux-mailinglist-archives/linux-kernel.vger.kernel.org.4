Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE86D9C41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbjDFP0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbjDFP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:26:04 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82919EF3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:25:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c9so40867180lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680794755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAB3+2xcGrU0pF4LSXRSi1oDyzJFHW2gf+rxyYWg9ig=;
        b=rj5Xf7lz2Utp/UPdj9ooBPZ9PiTbHpRewdUpW2BDtZi621IsG595648hxKFu8yaI0G
         OtBMeUJ9YvoZX6xsmqlW2xJasEbH+DljASm+b+sbmEBd1/h0M1Vo5/zlfghI4ShJRDlW
         7BTs3ZQL7AcEsqnnzX6RmJ83ULMQ+Kzk9Eju3yJgHj9Fne+8G2PG/rbvbVXkO4+cO2eX
         OoR8FAJIxX5kQWs/vPHTmTnftbaITp970HtLsHBeoyusSZ/fHFu0r7bCkY04OlIMeMVh
         yplzTPMLnGLrId2Kh8j0H4dhaeOSghRrDDBg5ZMBJcHhFUxFPMVw6Dh0oOanLFPhgeaD
         ExxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAB3+2xcGrU0pF4LSXRSi1oDyzJFHW2gf+rxyYWg9ig=;
        b=D5slXX6vBaA4djVk1slfprxtNJW3zL1T7o2Fgb3XNO9Sy6GGr2zX+eEYNXgTCdPqud
         oFzoQ/M6woFp788NK0dlRsellOBxIauPj2pNL9CSBUX755GR771F3Xz2TtAzyRe4jIXZ
         7N0qFseDwHqhtNi096N8DpziMFb3OeyOMc07/ZhdAYICHtsaVBjqPD2tLfkqbl8uhRu5
         kw4+KNaW1J5PlS2MjfICuDhV4DP6QwNEtMwjqwEocJtwFp/zuYFLzkTCb3eaqVbzZ39j
         2qvWUL9vPN3tHxOHuxXkiTUeHEJSMt2E8KBM/k88LRN7nKFrVVFPeDJxOVdGY3ZzroqY
         cFEQ==
X-Gm-Message-State: AAQBX9eccYX598unapV/4JCRzZcJp+rG9xBQ19dw5HGWw0RS+S7Nrxot
        7WBgwiqsGrtQDB6KQ6U+eqH2VA==
X-Google-Smtp-Source: AKy350b+ugxCJMsryA6T/LW0LprAnp6n7K/sK2Y52HdOe4jJkNDwJO8Svc5w7QiV37KjzQaWbwX8Jw==
X-Received: by 2002:ac2:5613:0:b0:4e8:3dc1:70f4 with SMTP id v19-20020ac25613000000b004e83dc170f4mr2856731lfd.34.1680794755355;
        Thu, 06 Apr 2023 08:25:55 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h4-20020a197004000000b004cc9042c9cfsm300103lfc.158.2023.04.06.08.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:25:55 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 17:25:52 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sm6115p-j606f: Enable remoteprocs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-lenovo_features-v1-3-c73a5180e48e@linaro.org>
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680794750; l=981;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FZjBtkKQOHkQiYQcm1yhCjVdMS+pk+EROsCIeDBCZMQ=;
 b=vSd4K2uXsru7HwJY6Hu5Q4w4zy51ZBaLLasX3//rS7zsGPtPPvx91S7cvkH2pV7A1QJ5p/XUXROP
 Tb/f28OKDCtUIQ5R6CHNkPJIt+CPlc/bOiZQFxo84F7nmd3OHaWs
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

Enable the [AC]DSP and MPSS and specify the firmware paths.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index fd064899791c..2aac25171dec 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -89,6 +89,21 @@ &pon_resin {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sm6115/LENOVO/J606F/adsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sm6115/LENOVO/J606F/cdsp.mbn";
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sm6115/LENOVO/J606F/modem.mbn";
+	status = "okay";
+};
+
 &rpm_requests {
 	regulators-0 {
 		compatible = "qcom,rpm-pm6125-regulators";

-- 
2.40.0

