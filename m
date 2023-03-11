Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D236B5773
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCKBWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCKBWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:22:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1BC13E51F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s22so8925154lfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIcmVIkTFiS02jdUnW4srKhGjTggtf8vvt4tMYwVq5M=;
        b=mAjGI3Mm1geK4Sl7dS1DhnAOgovUsa/L12+zzv1c95PbO4Q5vMgJTl1mhDu/F1YmuC
         wIKW6zzxTSOEyJwjw0aDTT1ahNfG5tOMk+qZ/v5kcDXW4yCGECytmxiJtu7zONWUuoRq
         U0Jq6zntj8bTLu7mDQjA9rWOlojC3HlY+br77BmTXqNN6wf6KAxjjb8VfZ4QUXKBoWnE
         sNWTmzQTWba9AnEzPbhpHnKmLDUWD3Ioge1FeClfuLMQpRAu0n1fwIS6JXCllADjLJXp
         INrSe5fLRW14dCVwMLv38TlZWseoyPlyhm518UG9f0fogIhbXLhzKa3gAX3v9h5kGUF5
         PaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIcmVIkTFiS02jdUnW4srKhGjTggtf8vvt4tMYwVq5M=;
        b=Kg1Jc9eV95pfh/oL4sTHFVoph7l26ibV3BR+IjdxpVk3qbDeBf3hj9vjGQw4UTTEQ7
         WVr/7gnNJKNQuJUIrj0YDRVS1VRMwQtdz1znzHMrYt/FL8UKoqYc7kHX9ZCR/45kjud6
         0b0w7V/1i0vLg5V9kuh3QlQP2a99qFe8psREzmvzA3B7GzJtMRblqgu/0lwa26xcQ7o4
         2xtBEIXuVUjpvDysr2prjb+8OvJL+9Rk/1xn6/N3JTzrKekgq8jCfkt1sLKZfjHDoZg3
         CxKIEop7pO5/OHGRShQfo/sg2kiWeci7Nmz2Y8QYLyR6wtCPRw/7ZfsGDC79dwA6HQrz
         sPHw==
X-Gm-Message-State: AO0yUKWgp2YCM9/p/02VvfieysObgQ3UMZOcWjsQR81xFKBi/ZPAUZ6G
        mb9UadHQ84rqFEmmdu74PaVcJg==
X-Google-Smtp-Source: AK7set8MX32bpUmeMSTGZNR/9iyXv7MkjDlIOepRlUcth1p1+vgLplVMt2xvfXj0SmbPcRAlDzpWXA==
X-Received: by 2002:a05:6512:24b:b0:4e1:46e9:ec3e with SMTP id b11-20020a056512024b00b004e146e9ec3emr8204401lfo.61.1678497717106;
        Fri, 10 Mar 2023 17:21:57 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:56 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:41 +0100
Subject: [PATCH RFC 11/15] arm64: dts: qcom: sm6125: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-11-e9c2094daf09@linaro.org>
References: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
In-Reply-To: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=689;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Ug8dotJhVt42zmZ84HhY4n+C/jFSeTNX53IoG/XWkSA=;
 b=zgp6HUpys9owURrcUC424Ip4bTYsDF5IUPrNxvlrrf8jmHEyCoU3oXzRmwstzfi0LNyOcNBTYey+
 SVIVIZMUDKGr2j7SEN+8YLEWAPNLMQ3Uuq7nOcvYwELrbMto3w/X
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing compatible to make the node compliant with the bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 65033227718a..fb3cb9c39daf 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -678,7 +678,7 @@ hsusb_phy1: phy@1613000 {
 		};
 
 		rpm_msg_ram: sram@45f0000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0x045f0000 0x7000>;
 		};
 

-- 
2.39.2

