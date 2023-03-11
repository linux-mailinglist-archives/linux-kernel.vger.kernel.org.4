Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB68A6B5774
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCKBXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCKBWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:22:32 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF714B030
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:22:02 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s20so8924470lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWBEe8kPBRuVaSeo3KUj1LPWAhTY3fH+g6fAbR9xigA=;
        b=xOgG8N/jOFt1JhfEQIWOOagrVIkQ1KCMKAFmCOKMQudz1TUC4OOfghlrwCR5cEhYkQ
         0U4/pnZz6cQ9tLYG6FhljBxMIYJxCKewLIRCP1JmEaQt6fhaLENISGp3tYNMiauqNsu5
         yGIHXM9RnzD8LtibIjja0vySCqRdbd45ratkzrD2LmwO+YXupDscvlXd5nId3x1jRsm7
         32TsSV2ubevfrcpH8QIulGQOQL+WqJGFv/V1eWaWoa0I8c3eHNNxc+d4aXQutmz5JFJ9
         Ea6zxb1IiduQWGBERgyIdC9ZhE5hunI4zhwgdiDC47xAKZamt8ubVSM4mrlg0p+Za5Wb
         REew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWBEe8kPBRuVaSeo3KUj1LPWAhTY3fH+g6fAbR9xigA=;
        b=vFUjbkYeEwysti6IjCKv8ij3I1ED2jKCCFp55e8AXAa/mLQ8ISeX2CB8bDJy2iCD9n
         pVprAjkL6zN3hQogz+dCnRzIFAXufCLJvdhMYoA1oKRg7UmWEOBr2xTCeKAvB41HwZHX
         UcKAlItuJQCXNnda0bIzc+YuPejZ3VzvHON8aycofVqI2SQeueT/Iq6E934YeG351RtJ
         AlJJkQNls57iO1d5BC1DVx5ccOmc5XuVcBuzuzjqSjmhWI/50+v0aRnTlV7pJuVoNDnJ
         2BRGBzJ+IsrO8ILYJyXV+oo8Ld+X0K2Ma5rtnSHXrWsI3DgIXKT7PcQYo6eigRYNLitP
         M/cA==
X-Gm-Message-State: AO0yUKVeonZUaydw6P1EjIgjgNeYVrUUGLdTN+C+ZcErlfllm4vXON/7
        jHkF79Jkd/+kaJ4WN9SA40E5fw==
X-Google-Smtp-Source: AK7set+j/JfjBmH6O84DslS3fAEDJgvhUOACbzPkF60tHFmEppwfkKhUiXaGfMeN4fw4Ylh2O7Dv0w==
X-Received: by 2002:ac2:4905:0:b0:4e7:dd1e:e521 with SMTP id n5-20020ac24905000000b004e7dd1ee521mr7618770lfi.9.1678497722251;
        Fri, 10 Mar 2023 17:22:02 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:22:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:44 +0100
Subject: [PATCH RFC 14/15] ARM: dts: qcom-msm8226: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-14-e9c2094daf09@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=676;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=X//p+EAvfaYkfnQGkepCnHSCFQcO8V7D+hwM2GgOKNQ=;
 b=ehWwwV1rjYINrV3d566MBYztx6AM1eWUynSPqRdp3Vi8XV1yu//sGgqu2TVtrH8sBuohe3Orh1Pc
 QBfXrBGVDslORaY6CbN1uGeGA49THKvipuuOn9Aq4926ZJYS+kkD
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
 arch/arm/boot/dts/qcom-msm8226.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index c373081bc21b..b4fb6749fdf8 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -587,7 +587,7 @@ frame@f9028000 {
 		};
 
 		rpm_msg_ram: sram@fc428000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0xfc428000 0x4000>;
 		};
 

-- 
2.39.2

