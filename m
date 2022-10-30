Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80624612C15
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJ3R5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ3R5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:57:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22337B1EE;
        Sun, 30 Oct 2022 10:57:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f7so8958722edc.6;
        Sun, 30 Oct 2022 10:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WsP8+DXscm/t85TslAuKjCRQIjALf87Dw9LpXBm7BY=;
        b=Tj7gRAxfx2tCeYq3GmSeIs7rACKSORmxBFRS8ospvesCwJmlAlMP5hbtBEHH35GOp+
         m0c5oMOkqCr7vAB5wmR25KwaRHcZsPeOJxYUW18HOW6F2fKChgj8pHqwZA0EpRESEtCX
         qCWPep5nCmOnezSDQ2nohkFJT9SaWNQNdf28BktYVWwUBFWWRY6+IGRFgATMLMgD6y22
         nbmx4iWTqfPA89+INZY/FS8W7M3gDBoJC/jpuNHXuKRjqZXAI5/lp1wHJjfKenGg5gfX
         5sXQY+jCKe1D5VWX6c4xQ4ZMjdvNNWiuscZK35dPAfTpIeTyY4Diyg66e2LjO0KHLn4/
         uQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WsP8+DXscm/t85TslAuKjCRQIjALf87Dw9LpXBm7BY=;
        b=3O3O3MICVFRW6uynwWVteos5kOb+bo5U7iIzWBQ+Wu72LJsj/qRQHmA2oKVrPGzvmD
         kKbfL6BeLqUYxmB1b1HPOociuCVvV1+XiefIJ3LbP8sJcFdwLd+CqyrJBeZK40zc3tq+
         rlxraCtbPqAyCAEqizdMCGbcxeLwm49BwJ5s607w0+Gc50dSDrmC2Sh2G/qVYoetVQk5
         9tEaB213kjlW7RhgsDQa3maxjyYuvVk7LiuYMhYgyuLeb7ooemaQgOAbfA/cgaxqzlcr
         kyvuyTn16puViAP3Kr31ZCkmGbB4Ppwik84aNfvUZbSgpzmjd0cOcDeM1tyQ7CXV93Oa
         LFSg==
X-Gm-Message-State: ACrzQf2m558nVI0PvAV+Ckw2F2S7DsOVPS/ftyyJJ4YOfO/hmqUo3MoI
        F1CGEJqp8HfxalYv02zah5o=
X-Google-Smtp-Source: AMsMyM7EEHOgtDUUFDtcGVGNNho6sZXSzKmxB5Tbcmm6wZzI5hZz2QceXOU33wX/f7Dj/jruud6Z/A==
X-Received: by 2002:a05:6402:847:b0:453:943b:bf4 with SMTP id b7-20020a056402084700b00453943b0bf4mr9845953edz.301.1667152629689;
        Sun, 30 Oct 2022 10:57:09 -0700 (PDT)
Received: from fedora.. (dh207-98-142.xnet.hr. [88.207.98.142])
        by smtp.googlemail.com with ESMTPSA id b24-20020a17090630d800b0073de0506745sm2053029ejb.197.2022.10.30.10.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 10:57:09 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: ipq8074: pass XO and sleep clocks to GCC
Date:   Sun, 30 Oct 2022 18:57:03 +0100
Message-Id: <20221030175703.1103224-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030175703.1103224-1-robimarko@gmail.com>
References: <20221030175703.1103224-1-robimarko@gmail.com>
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

Pass XO and sleep clocks to the GCC controller so it does not have to
find them by matching globaly by name.

If not passed directly, driver maintains backwards compatibility by then
falling back to global lookup.

Since we are here, set cell numbers in decimal instead of hex.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index dcea8ec6a160..4b99357a02e8 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -438,9 +438,11 @@ qpic_pins: qpic-pins {
 		gcc: gcc@1800000 {
 			compatible = "qcom,gcc-ipq8074";
 			reg = <0x01800000 0x80000>;
-			#clock-cells = <0x1>;
+			clocks = <&xo>, <&sleep_clk>;
+			clock-names = "xo", "sleep_clk";
+			#clock-cells = <1>;
 			#power-domain-cells = <1>;
-			#reset-cells = <0x1>;
+			#reset-cells = <1>;
 		};
 
 		tcsr_mutex: hwlock@1905000 {
-- 
2.38.1

