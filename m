Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7928961EEFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiKGJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiKGJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:29:37 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF915807;
        Mon,  7 Nov 2022 01:29:36 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt23so28356241ejc.7;
        Mon, 07 Nov 2022 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeRjTdKZuVcd4geSfmVx+hLppnod+v8Q60h8FnReYds=;
        b=SUw+WmxmfTgWTqU1ZbVTw4omEu3cA/sjbVF3oE2A54z3kf61zsIUqijg1GMo3B4V7v
         IyTZlHJhihRPrEpoOKuFvUrJ4UyQIgglDWqYUuqkzePlpQBH+ij/YvTxmvQSxr5/NfRc
         6BLfzHijtr1YJ/H3qGBxwCiy7ECIzdmWRgca5KaO4tX3fA4TDs3e2cjDihYt3TRhoTXi
         aO6nWNWZAueAN3G6ngR31OGYQV2oNxVBGJUKQ5QsDv41gOPKlitFL0yOcNbSect3IOJP
         9CLwvrwy4nbIKIZwkqKiE5E/KXhcSPUhQxKsiTK3A83w15IuQYLkF7Mi0h5C53yjAt3q
         ZYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeRjTdKZuVcd4geSfmVx+hLppnod+v8Q60h8FnReYds=;
        b=4OciHPQc4dlU0Y/MYNKmmM54rVMISw7n4kiksOR/5dqqs9mLV0wpw6Z3G37e9VQKI0
         C1Qr4wj4F3axh70Aia+nNPllXR0VN52ndwH3WpPoAVnfFmIbaLiN/qWQjf0JUFouucEd
         Ko+12/RfxeVPao/wInKQ6wm2IcsMzjuNPQ87Gn6x20OrVCrhrjUrWuDjC3UPHoTLIBmS
         zfMs04j26kh3Voj/+m985L81QF9hiKkGc92/5LXqfuVURscuKUqddsap2EnhjcaczMmL
         fWWOHLphP+vO9aU3lLV0cMsVI7ldALe8QX/FCUsmWYGAhF5bRBwAlcU4ZrIbCd4QX5K9
         /TUA==
X-Gm-Message-State: ACrzQf0VtskDsXYBAQUArDz68ouJaQ+rm/2iWc8aZQnIOmRS7jhDWn91
        gss0PGAx+A/yI2bjolBW6FM=
X-Google-Smtp-Source: AMsMyM7D8aj6QDvTKE9KzdGkeeJY1rAJnc6L8MO5dTbQIhiwxuV0onATWy3ZaInFJopLMgA+Q+Zmtw==
X-Received: by 2002:a17:907:763a:b0:7ad:e517:246 with SMTP id jy26-20020a170907763a00b007ade5170246mr34992210ejc.128.1667813375081;
        Mon, 07 Nov 2022 01:29:35 -0800 (PST)
Received: from fedora.. (dh207-98-26.xnet.hr. [88.207.98.26])
        by smtp.googlemail.com with ESMTPSA id u10-20020a056402110a00b0045b3853c4b7sm3912837edv.51.2022.11.07.01.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:29:34 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/3] arm64: dts: qcom: hk10: use GPIO flags for tlmm
Date:   Mon,  7 Nov 2022 10:29:29 +0100
Message-Id: <20221107092930.33325-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107092930.33325-1-robimarko@gmail.com>
References: <20221107092930.33325-1-robimarko@gmail.com>
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

Use respective GPIO_ACTIVE_LOW/HIGH flags for tlmm GPIOs instead of
harcoding the cell value.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
index 262b937e0bc6..651a231554e0 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
@@ -5,6 +5,7 @@
 /dts-v1/;
 
 #include "ipq8074.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
@@ -39,12 +40,12 @@ &blsp1_uart5 {
 
 &pcie0 {
 	status = "okay";
-	perst-gpios = <&tlmm 58 0x1>;
+	perst-gpios = <&tlmm 58 GPIO_ACTIVE_LOW>;
 };
 
 &pcie1 {
 	status = "okay";
-	perst-gpios = <&tlmm 61 0x1>;
+	perst-gpios = <&tlmm 61 GPIO_ACTIVE_LOW>;
 };
 
 &pcie_phy0 {
-- 
2.38.1

