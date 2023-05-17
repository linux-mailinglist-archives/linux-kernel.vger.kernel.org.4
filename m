Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9E706F04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjEQRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEQRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:06:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDE9E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:06:28 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f00d41df22so10833175e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684343187; x=1686935187;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=og0hsJoXEFVx3efB5FODxK2pf896iJgKo0hqpFS+xEk=;
        b=Izd4OfR/cZVVa6jm16BXFsbMImZWXXer2Qnu+k8jmmXOhm7jTLrV2Rgxkdbaw+7rcy
         2kNKLL8SWU2mMVafy4Bq0184tqik++4c3B2gE9C5+oEK+zylzBZ04VevNCscg0saGdxI
         DCZ1PJefFBXyI1pL05Vx6lv+woXpn9U8FBAQ2fiDon9iX52ud83lQfK59gzyR0LjTviZ
         UIUozbsPgA2VE4zJbNPXXAeXu/8vEkRNZLn5RL/OT87Tj43cfIy3vLr7p6U7o9GW0Hyo
         jAEKPPsQYTQQmDww8+4GXZFda3KL58envD0I4h2H6Ixv6PMmUgkCvSHvY2GwIUp7XE+z
         +BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684343187; x=1686935187;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=og0hsJoXEFVx3efB5FODxK2pf896iJgKo0hqpFS+xEk=;
        b=JZvzNJNSo09euSqnG+Gb4lNIj24ZWoTr12kfIGs1MHoH0K72gcVqrtv01K9tdXG8oH
         sGfDXmX5rGPGRRg1lTTitTTZokvKhf09wUDrIvwf3N3JgYLyNlIAV2TS+tFITXsEgLrP
         ZYeRY6u5JlyzlpzDvtw9cgCBk3f9CbaPtMz58p9TbHEhJKBFIYHL63sX8AXTdnuojdN3
         KbvEtNKP35FHi7zREYKWa3G2dSmwUUGJzQPLV6V0zJXtQwxTewS44dpWNoPNgLIEIMhl
         hexMPm5gL9RQOzLhD3xLU9aJ9f9j+ZQtZEi1PDycvgMGg+gq693aFwr9pJXoDbXNMbud
         jjkQ==
X-Gm-Message-State: AC+VfDw/D+vpxDKJOa2tU11KdI6MCQYtQElkERGrKCRi5Tn1EZ/BhZ5v
        ie34XwME2CMEqHIpAEFzmCb0Pw==
X-Google-Smtp-Source: ACHHUZ4+gFI5gTsdKetBT14w02XAkJZ7Borindj8eNyRbJ33kzcsirKSsUL0VBKNNxmGI8y3E15c8A==
X-Received: by 2002:a19:7413:0:b0:4f3:77f9:2bbe with SMTP id v19-20020a197413000000b004f377f92bbemr73382lfe.3.1684343186992;
        Wed, 17 May 2023 10:06:26 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id q29-20020ac2515d000000b004f392625952sm455063lfd.26.2023.05.17.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:06:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 19:06:13 +0200
Subject: [PATCH] arm64: dts: qcom: sm6375-pdx225: Fix remoteproc firmware
 paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-murray-fwname-v1-1-923e87312249@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIQJZWQC/x2NywqDQAwAf0VybsBV+vyV0kN2N9aARslqH4j/3
 tDjDAyzQWETLnCrNjB+SZFJHcKhgtSTPhklO0NTN219DGdcplkSjqsZfbF7K42MmdP1cuKQY2j
 By0iFMRpp6r3VdRhczsadfP6r+2PffxP0gBp6AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684343185; l=1166;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DTVsdGoGsh/nIq5nmbWuoZKZZThDi5uvXuBGVZaqfOk=;
 b=zN13rcZUGWPTLDGX8vkBcLaA7svDsokxyXOsHA+XZXuc2mhqHEGDb6p/uszwyuKLw+eT167sO
 rsMTu/Pr9QGDLzZN1HTAUMCVkiO5A9AjH9rat51mUg8HOXP4tt57mb2
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

They were previously missing the SoC name. Fix it.

Fixes: a2ad207c412b ("arm64: dts: qcom: sm6375-pdx225: Enable ADSP & CDSP")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index 8220e6f44117..b2f1bb1d58e9 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -178,12 +178,12 @@ &qupv3_id_1 {
 };
 
 &remoteproc_adsp {
-	firmware-name = "qcom/Sony/murray/adsp.mbn";
+	firmware-name = "qcom/sm6375/Sony/murray/adsp.mbn";
 	status = "okay";
 };
 
 &remoteproc_cdsp {
-	firmware-name = "qcom/Sony/murray/cdsp.mbn";
+	firmware-name = "qcom/sm6375/Sony/murray/cdsp.mbn";
 	status = "okay";
 };
 

---
base-commit: 065efa589871e93b6610c70c1e9de274ef1f1ba2
change-id: 20230517-topic-murray-fwname-dec986e1db13

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

