Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAC6B577E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjCKBXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCKBWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:22:34 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4439B13FF1F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:22:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i28so8989617lfv.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KIqSc2t7NngJlPq/HWXnzKGommQkk1M1A0PRz32Zx8=;
        b=KWpP0adBvC9yncDvlLcj0mP/BwYbBcR9g0gH6LamE39LUqvLEYjZtcAaA2hiljh7UE
         am3MA17nfYuOd63acEd4Yci3RwL8YseNa7xTQRC9P5s4mJG+BX+6bCcgkwd73u8Adjg4
         KIVBTn5/xOKi93CdOvkPbTS9fLoJQBjhRlH/vs1UYf6o73gP3XVavKR//I0TKgbb4PLA
         /EnULDJ2vnKQ1cvKYRZTSP4ngTnuakUYjZHwFxPz2VGOoNhXgUNxJJhU5Skx5v+1Y5pW
         qaDLQb0GuUM3rGQZZ41YUjIryNCTJoHemjLcPAPV5hk6xEjmnoPIG5Y79RSADOXGPWN7
         NnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KIqSc2t7NngJlPq/HWXnzKGommQkk1M1A0PRz32Zx8=;
        b=iBy8EywTrIj6PlDt6PbpwNknRZlihDk9r2Mc/OTI3o4HcQCFM02YvO4X1XuQu3dsLr
         Aq7d+rVenkDtlBBMFh/Ujny0FW8MCvEXkgvRZgm2ofqiuUwb6dhyDTXTweiwby1yhJ/q
         io54LANEaXp4Miob8VBJOXZm0wHTx4BZVY9xUOt6opkY290MgwAra4FoKoMpwfC11Or4
         iqBHq3lKNUvz1VwTK9unfpAbDk9237ePf28O3drIXkz8p0wx2DpA2vh70IzKv6+2Liby
         1FLR7dxexRM+BNOiRxJS8QFuunTHi8PWI5WK0Wp8EVTbpWFM7kR27de3nZSSLB5o+76s
         86tQ==
X-Gm-Message-State: AO0yUKUWhLE0Op+LDIX02e/QvEvGBignJJIT4LZrOLRXDQXK8S2fXDIH
        CamDpS6S31gonZzF4wN26wLozA==
X-Google-Smtp-Source: AK7set/3na98oh9lVWvchOVyv2tdVwvC13q4zhW18AdjSMGNzOlcsnougvj42UGjB+o/peW+yJKMgA==
X-Received: by 2002:ac2:4836:0:b0:4cc:85e5:2f5a with SMTP id 22-20020ac24836000000b004cc85e52f5amr7536286lft.9.1678497723839;
        Fri, 10 Mar 2023 17:22:03 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:22:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:45 +0100
Subject: [PATCH RFC 15/15] ARM: dts: qcom-msm8974: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-15-e9c2094daf09@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=694;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=C524Np26HdyMV4CYeyeY1SR9toCCuIhd0/YtkRmyuJA=;
 b=wl5NJ1vnGIq22mq7G331oiUnLDlegcJf1KyUdrvmz4G6JnL7TfOEVcYm0XK8omaHIGHBR2kSgMUh
 wY8JPxqwBq4fFRKuqEmtUjsnBVUEguNbkTSuNMX8zXH+aO+Lz3hK
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
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 834ad95515b1..fdc0522fcc0f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1064,7 +1064,7 @@ gcc: clock-controller@fc400000 {
 		};
 
 		rpm_msg_ram: sram@fc428000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0xfc428000 0x4000>;
 		};
 

-- 
2.39.2

