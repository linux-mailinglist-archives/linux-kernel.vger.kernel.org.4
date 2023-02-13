Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DDB69530A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjBMV3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBMV3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:29:37 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BAD20D19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:29:34 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id sb24so11259816ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjFd6eQHGjjXlgB6ck7U8JqdjsspIM0KobnohlKdjVc=;
        b=OeLT+m1p9SztNidp6k9lL2bSH8EzM9THBHI78j8SDN5zIAckTW7y5PJRqOoktAsiTa
         D2/1dV300OW/pG/PidYtWMuoG99ZP7c/vYFjJD15yf81DZWzDG7Uh9O0eDUBho/lbSVd
         yECccjrxcRQDkyLrOr5RaTUU+g651eAKymc0NoUk9una5yaXLs7RcUmS9Ug8CC6x/2Qa
         4K6f3Fw7MapsMZafAJjTNRNtjb6eiqsCrPeJYED2bc3+/QisROmhr22sApObkNNuxkha
         TtCtiFamaIO0Gde1phwcsdikVO3CiEzwT9Ef0bPmtcT4UYRuF9UAkv7vpZx0wih5DbtV
         H3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjFd6eQHGjjXlgB6ck7U8JqdjsspIM0KobnohlKdjVc=;
        b=L+zfHWyDihgswCU5Y52OWz2r1Fx3TG81T2eahaZ+Btoz7FsmQ+tGRCMXMElapUYJFb
         1tpTp/74SkbCzpA7IovSOE6vNDnDXXiMLfLxpwBOqJtgJXhq7w7Nzum+Pq+JDsVpLLp6
         BxSKXj6ZXB6+QHQvFo/CQUjoVjriA3ycsT1bFdTbFVpAHLTp692aFA5/MZ0NOP9MWIf2
         GtyWd7O5nllWESvKwZEt7Bo+od8WlnRlXi0C/t9LbxvlXDa3dWOts0aGJmuylFWkHEEA
         gmjq9I4boWI85SFgdYtPFeHQKZGk7HqAW4VRUSXxc4WF4BjGI8syCOSGPxKRKvhQqROs
         teyQ==
X-Gm-Message-State: AO0yUKUp6ym7q3k3Z7BYgAERQvcbT/6Wk9+oo4eaIzqctbU9ezBu3rtv
        cW3v9xweNyeT8dSfhDvaXM+B7g==
X-Google-Smtp-Source: AK7set+icLqNrnDmLD3M5E5tWB/6wEHU+fexYbodEstBYLc2hkKeFHcn/dIQ7yzHG26g1MwlCxvPCQ==
X-Received: by 2002:a17:906:4e91:b0:8ae:d3c9:1db7 with SMTP id v17-20020a1709064e9100b008aed3c91db7mr338746eju.73.1676323772878;
        Mon, 13 Feb 2023 13:29:32 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id i16-20020a170906699000b00883410a786csm7293225ejr.207.2023.02.13.13.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 13:29:32 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: pmk8350: Use the correct PON compatible
Date:   Mon, 13 Feb 2023 22:29:30 +0100
Message-Id: <20230213212930.2115182-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A special compatible was introduced for PMK8350 both in the driver and
the bindings to facilitate for 2 base registers (PBS & HLOS). Use it.

Fixes: b2de43136058 ("arm64: dts: qcom: pmk8350: Add peripherals for pmk8350")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index 32f5e6af8c11..f26fb7d32faf 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -21,7 +21,7 @@ pmk8350: pmic@PMK8350_SID {
 		#size-cells = <0>;
 
 		pmk8350_pon: pon@1300 {
-			compatible = "qcom,pm8998-pon";
+			compatible = "qcom,pmk8350-pon";
 			reg = <0x1300>, <0x800>;
 			reg-names = "hlos", "pbs";
 
-- 
2.39.1

