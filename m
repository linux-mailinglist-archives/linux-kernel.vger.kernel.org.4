Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EE6B7DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCMQea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjCMQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:33:58 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197AE2CFCF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b13so13254854ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678725192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jvLqw/iUmqFEw7pDvRYLLaTw8rrTc1/hAIGay/5Ppo=;
        b=oQL+5IH9ybn9A6+ZLkz+sQrqEmrho9NhJP+j24JCbc0aCuLCawT7oJ1RWAJIi1i1Wr
         Kb8Xm+MpFEDruMaBBSYJn4QBNONqEczs3qxtUhWPdHyEacZRhlpK3F4fVCEummNAGrM2
         74geHM7i14d3FU9R40CE7NE57E7qQ/Kw4Tg+h/+Tp1XpPMyaaPtCd2Q6hp7Iqb6SocNI
         GluzkzC1MKw3XBuGA4HQ2jaLwAr46YbIUslnw9UngOgmDP61RnwkRGS99JROHXt4Bva2
         DghOoo44YLVQtoCZRKRdmZPtyKtErSzJaONGvkDJz4XZurniiyJG+JP4GKYeEFASKGDX
         Xigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jvLqw/iUmqFEw7pDvRYLLaTw8rrTc1/hAIGay/5Ppo=;
        b=5xJbKs8B86DsaU3eqf4o1y6csmDdVJhqZS8rf3iFtFYTlybEW2Nov4mmJpBcSXhZBI
         wZNpheRNu1ukQMYbY3DS9hdCXvFDGrbT9tULPyYxV1nPRhusDXNzFGQBKYRdpQH74ew/
         zg24HwGJe9xib/0mcsR6ygpDRDOdfbkU7Cwsl7cVy5BLXdG+P3cs+Nmo6Y7Zh6ck6B6h
         NfzLIAt2u++hmUwC7ob8UnWiE5z7gEJrYeRNJhME1R0vQqg66COKYOuPrC7WRM3G+MrU
         uqYL0p6bdyUi1G6F14n8LgN9wsPETZLjXqK/EBDw+SxcmR4OIVf5yDtHF4Hdbr0w8mzA
         ngtQ==
X-Gm-Message-State: AO0yUKX7WOdoqyf+2Dfm7S6ex/HYAf529uvKiyqKt5QE3eTlGKLSh4QU
        f9YC/FRCjGjgEtCxxbwX96wSfg==
X-Google-Smtp-Source: AK7set9cs+olZsMDJhYN/FFOOOMxduVVYOdU33uPJTTkr58zQgr9pP3zfK6fEQmWC/15jGWXYfGrgg==
X-Received: by 2002:a2e:9996:0:b0:293:530f:cbc with SMTP id w22-20020a2e9996000000b00293530f0cbcmr10006252lji.24.1678725192141;
        Mon, 13 Mar 2023 09:33:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q62-20020a2e5c41000000b00295765966d9sm57417ljb.86.2023.03.13.09.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:33:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 17:32:40 +0100
Subject: [PATCH v2 5/6] arm64: dts: qcom: sdm845-tama: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v2-5-37ececf43770@linaro.org>
References: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
In-Reply-To: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678725183; l=887;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sfOcCjF/CfP30Au7ZmpvkwMbP27lT5DjZVeGjKXyRIU=;
 b=qWsv045+fAZiWcr3fNE2t4L9MEh7YDZUNR+DDA0Q8m0h8f/XVJd62ROIICONhiuQkgn2v6PvzfAe
 0i1GLTgvDODQVpxV1Fxh9i0lkvX1vgcS/pwhniHuGTPXVeoRiz9p
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Enable the A630 GPU and its GMU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 68faf46540b0..6a3da19c6b36 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -416,6 +416,19 @@ &gcc {
 			<GCC_LPASS_SWAY_CLK>;
 };
 
+&gmu {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sdm845/Sony/tama/a630_zap.mbn";
+	};
+};
+
 &i2c5 {
 	clock-frequency = <400000>;
 	status = "okay";

-- 
2.39.2

