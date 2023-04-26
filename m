Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044446EFA85
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjDZS5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjDZS53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:57:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F58A7B;
        Wed, 26 Apr 2023 11:56:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-504eb1155d3so782816a12.1;
        Wed, 26 Apr 2023 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682535411; x=1685127411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIRwizkBlsL+ifd8FsbkRK/NdvO25L/3LYIQ1whi6m8=;
        b=iQViXoJSnBRS387pYZ2Uoxdt6y376s9PMxxA7oQEPsb5RTOV2toAcjzikM5NhxG0Jo
         yxg1mbXWan8zXLsHw3BUaePoMKBBqOnCmzYljgceDUeNhq4eQQxoQvb7x7VJC3Bc9e8e
         wZw0z48eyzE7uER+ncDOGELSmqYRhrS/3eOOz8ZX6+CxsrU1DJF40GrYF9ZMkN1SpTmP
         trvR9zno3ZeFccOHyzjQ1OtI5Unw8Hv+x1QNDE4sOcLxPwmrXV1dZwYoD/z28FlNxBsU
         Y0TOXNZrSFX1zt6wEbP6bscdUKqO9C1hqQ9u1eDckhhI1etFwKwMJJzCRaTklqW+Y6eN
         J0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682535411; x=1685127411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIRwizkBlsL+ifd8FsbkRK/NdvO25L/3LYIQ1whi6m8=;
        b=JgQ46j9943MBfWFLeQZejzFJoXbzKuCmRipdhio+4l+dC4VgqIxR0ugpAsUKbpPa68
         neeaYMgG1HzIdHQID9IquRxhjIw7/sQ7CMvFgR7TFTHiu8367th/hfYK3fNjpNS1d5gO
         mQmTU2838Sgo7DkKi0e2cof+vY7Bf67U8tVWAr0oscTCdconLS5Ohn3ahp/fQcO8ZMOy
         JiA6J+RnQcRrf4fujrgUo3oObJiYHiO3jVyDCzHwpIOEXl1p6ZoMkx5c2tYIFygZWKg4
         ZTUV+unBsPzYkeqggzletkuSmDUbwS79jlgnGS56rDp2uyL6J6Bhafd7ehKnOF0a5dPP
         meBw==
X-Gm-Message-State: AC+VfDzFbmons6aS8YFhQFY4E4L8YD9vV9AgsJmzmY6LZzubCWcet9yX
        wZ2ygqTVSEUy8uzZttpUm8k=
X-Google-Smtp-Source: ACHHUZ5zDTZfGl4gnFj8hI971RkQcX3E0Eq/1CIGPwLFd3QdP/E7NCuX8auzUcLCJtXt+rudRRdmYQ==
X-Received: by 2002:a17:906:eda6:b0:94e:6edc:71bc with SMTP id sa6-20020a170906eda600b0094e6edc71bcmr3201176ejb.25.1682535410890;
        Wed, 26 Apr 2023 11:56:50 -0700 (PDT)
Received: from fedora.. (cpezg-94-253-129-198-cbl.xnet.hr. [94.253.129.198])
        by smtp.googlemail.com with ESMTPSA id qt2-20020a170906ece200b0094e1344ddfdsm8501348ejb.34.2023.04.26.11.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:56:50 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: qcom: ipq8074: Add QUP5 SPI node
Date:   Wed, 26 Apr 2023 20:56:47 +0200
Message-Id: <20230426185647.180166-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node to support the QUP5 SPI controller inside of IPQ8074.
Some devices use this bus in order to manage external switches.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 64c2a30d9c25..4a682e3442f8 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -774,6 +774,20 @@ blsp1_i2c5: i2c@78b9000 {
 			status = "disabled";
 		};
 
+		blsp1_spi5: spi@78b9000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x78b9000 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		blsp1_i2c6: i2c@78ba000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			#address-cells = <1>;
-- 
2.40.0

