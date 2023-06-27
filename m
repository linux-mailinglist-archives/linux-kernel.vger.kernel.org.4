Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0500B740224
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjF0R15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjF0R1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:27:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E6F213F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:27:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so98891e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687886872; x=1690478872;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmZJiDmHOXzvcLFH+CkhF2O0s1JxneKrl7S3B3Km+E0=;
        b=Fyn0Ss8gJ8W6qSjPlecef0bZzi7ZB9ieorBxH9HOeRgTh+B/aUiYlF8+KP3lLXb16i
         T250EE7wyU4Kd0IGzXrBgcwZ7415ICLHKkJgMcbT2Dv5TkppDrtilDiFJsU8EFmYeE2b
         jOGXnhGlvrcD5bgN/IOlWeAjH3up5wC+NZbkHjaMYvUgf+/0sWHw3UvRb8RfXwxso51k
         UCtNg0qCuFmgCV3xnOFIyEtqApWbTynT1AxpKteOGVX0En9mrpnrzCTJ4X7OjgauTI3Z
         9Y4RDvuv5fEd8Hue6RDQAvTvUvTcq7XHir9fWCgb16UqvUTOhNTuAzmLlQdSdvtr+zC4
         kUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687886872; x=1690478872;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmZJiDmHOXzvcLFH+CkhF2O0s1JxneKrl7S3B3Km+E0=;
        b=Atk4VIDCAyOt0y/37psZeyLhcCVoIok8AgoakOAEV5m7O7CFkvvPlt2qavlun0tEM9
         z0yURyKi8CZwtX1vHCH53LAkFmg8e+fMx8Ul8ZkGeM5jTnHvBMlqW85Khd4Bx3LgoL7M
         EFXNKwJAieil28DS5pyrdHcpPL2ft7SBydp2UoaHbwtjzBJkn3CMx3KgHYpNxAhsh2kX
         ZrPJ0rl5bhtU/4KfHC+1pOHzF++7wsdL8hdoEEEsulLKHlzHHbt35cgo0BEcteb5i5p2
         L0F3yScCzNu68y+0wHFf6cWb8KF0NgH+4yzFDQiUXPd4S8+td2R6+8oVLNNJF7GhykTe
         3JmA==
X-Gm-Message-State: AC+VfDxpkoW1h95KMa6jnvAcCQGqZ6QvhFs6138o4F3S/ElzpVaRDUqd
        r/gsuVtk5OFAk0aW/gwkJCD1hw==
X-Google-Smtp-Source: ACHHUZ5LaGYkAhyL0dpMACDeHX5aYWtqtvQR+IG35bXYLVEDGrqoxcFFhUHoOet/x6v1LF9Co/9Gew==
X-Received: by 2002:a05:6512:1046:b0:4f4:7a5:e800 with SMTP id c6-20020a056512104600b004f407a5e800mr13600022lfb.10.1687886872054;
        Tue, 27 Jun 2023 10:27:52 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id o2-20020a056512050200b004faf6a87d63sm1269391lfb.38.2023.06.27.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:27:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 19:27:50 +0200
Subject: [PATCH] arm64: dts: qcom: sdm845-tama: Set serial indices and
 stdout-path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-tama_uart-v1-1-0fa790248db8@linaro.org>
X-B4-Tracking: v=1; b=H4sIABUcm2QC/x2N0QqDMAwAf0XyvEDtwLH9yhgjjXEGXJW0ykD8d
 8Me7+C4HYqYSoFHs4PJpkXn7NBeGuCR8kdQe2eIIV5DF29Y50UZK33pvZJVTMSDELd9kDt4lag
 IJqPMo3d5nSaXi8mgv//m+TqOE0wjlYB2AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Martin Botka <martin.botka@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687886870; l=1226;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=OBDDr1WmWttJM5U194JqyHQ0vF5NSbcT7U2XPb0GAGs=;
 b=buLOIZs9qbugz1J6O7Lhd9xBGRuR2FKNodxTjcZw6z3FR9enD2zgxgp6lHOV58pOy+hoaFHIg
 cKHHdQYax02B3napZ07N8Kin/lIMOUO65KRa4NfYydBjlCh/Y/1Y/C1
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

UART6 is used for debug (routed via uSD pins) and UART9 is connected
to the bluetooth chip.

Set indexed aliases to make the GENI UART driver happy and route serial
traffic through the debug uart by default.

Fixes: 30a7f99befc6 ("arm64: dts: qcom: Add support for SONY Xperia XZ2 / XZ2C / XZ3 (Tama platform)")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 3bc187a066ae..7ee61b20452e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -15,6 +15,15 @@ / {
 	qcom,msm-id = <321 0x20001>; /* SDM845 v2.1 */
 	qcom,board-id = <8 0>;
 
+	aliases {
+		serial0 = &uart6;
+		serial1 = &uart9;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 

---
base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
change-id: 20230627-topic-tama_uart-bacfeac1d0e9

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

