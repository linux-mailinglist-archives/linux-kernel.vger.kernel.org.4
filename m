Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F916765FB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAULYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAULYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:24:07 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BB91ABDB;
        Sat, 21 Jan 2023 03:24:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id az20so19950973ejc.1;
        Sat, 21 Jan 2023 03:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhM5qJGPxBSYXZ+6kwCdfI+MuMuQZtYYh38bbR24IOU=;
        b=Gp587WKzuBhzbJhcj2m7SGcQd430qD8dtMKAnx6sj6O0QsE49WPZ1CPsvrGhDEqN21
         qZXip/tEt+qMo970kUUQvXWWB3wjqXqdeQgawc7EjAes44cIbsCLGYzj3ra2k2sS5rfd
         O92kJd2s2nwdDUUPHfYKP+f/3WEuaKXaFA7TRQ5G3UBZvYrKxZ+pttGoSCe5hE2LJtyA
         Vuuf/f40XSE2OqBh9cXCmO4ECeONQlHvPPkeGnJHqecelzlyX6hfOjhSZir4frM+9qD6
         FaHNJ4W5LITdhuoo+CFuKFQ3RGri0eMxQb7YhUFmC1t8myqzwX00tRugt0xglht/g7Q0
         I1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhM5qJGPxBSYXZ+6kwCdfI+MuMuQZtYYh38bbR24IOU=;
        b=7EQxvRaOSuE5YUb7AdIC5rahMG6CVmyvFhIMWLy0XT7jdKoohgL5pKSPtyXcYauKwP
         A5jVUF7fNiyzzKqQuCaN90ifM+SFfu4BS192mpwlHs49BIKYyrr2rKOaFjk1p/TBfO6/
         okE9WwgcuUgLNpB1EPr0OjgkzMGTMTJE7u8OqZCGD8npyeNmFo33D0TztVoT2TY3Dm/s
         OTsNfSS//pzpnJsBFaEtyZQErxrbvc/jEWgs8/g+yHBIBgVKmblSUBA5oYkMR6g+EOSM
         dc8EdTk3vPcgOBHj/DnB6k+adYWV4zq5eR1Aivg/FttHJ637Dn7f1aAPoF1WsF8iOaRX
         /h9g==
X-Gm-Message-State: AFqh2krIxiVIo5CAjPOomByGwqFHvaUOJwukCkls9rEbSRIQVw34uOKj
        vzHjnjW/F7dkd9ZBnGBYaY+DqAXEY2dRXw==
X-Google-Smtp-Source: AMrXdXvwl7/IUyQSLPnO8/fs43tA3D0HTUPptMDflSGlEf2FKRnxs/R6MtyJxYwhRwDPtZQ34ME4Aw==
X-Received: by 2002:a17:906:26d7:b0:862:11f6:a082 with SMTP id u23-20020a17090626d700b0086211f6a082mr17533322ejc.17.1674300243568;
        Sat, 21 Jan 2023 03:24:03 -0800 (PST)
Received: from fedora.. ([188.252.220.152])
        by smtp.googlemail.com with ESMTPSA id 21-20020a170906319500b0086faa5b06d4sm9236365ejy.181.2023.01.21.03.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 03:24:03 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq8074: add QFPROM node
Date:   Sat, 21 Jan 2023 12:23:58 +0100
Message-Id: <20230121112358.52216-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121112358.52216-1-robimarko@gmail.com>
References: <20230121112358.52216-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ8074 has efuses like other Qualcomm SoC-s that are required for
determining various HW quirks which will be required later for CPR etc,
so lets add the QFPROM node for start.

Individidual fuses will be added as they are required.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 8eba586065a3..f29491f647fe 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -301,6 +301,13 @@ mdio: mdio@90000 {
 			status = "disabled";
 		};
 
+		qfprom: efuse@a4000 {
+			compatible = "qcom,ipq8074-qfprom", "qcom,qfprom";
+			reg = <0x000a4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		prng: rng@e3000 {
 			compatible = "qcom,prng-ee";
 			reg = <0x000e3000 0x1000>;
-- 
2.39.1

