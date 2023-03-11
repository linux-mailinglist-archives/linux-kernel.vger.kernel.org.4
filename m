Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B46B575D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjCKBWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCKBVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:21:50 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2512EE5A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j11so8907349lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHsRYK60LcXQOFi/Sh5A2+o9skV715DP+OzWGmH0MAQ=;
        b=gqRJxRY3cctDc10JwAfiBnkU5ps2D9iLWp1qx84k7FNUc7t3fQq7QnhwNK7fPZp2B7
         P8VqwzPct3zXpToXPPseTfO0ewNgQrCttsPDpEuPtvDrhe9Qax+rx4WAUow3+rvfN01g
         4RzYD78Jt+5SAezIK8OJyqVEkH8sozLit5/0kyzr533OS0c6T9tJ7vPFE7UTUMjvMQZu
         L5z22WxEDKmlx2ixX3f6DAlhuleMfeEh10/eudtUe86WInUfhg9wiVFC4JMid2YJMVFI
         u8/w05xZ6mxfnV9KA9ePPrXFWk6bN6m0lABM1tWaFBxnaaypIRrMn3EageILBW3YY9Uz
         FGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHsRYK60LcXQOFi/Sh5A2+o9skV715DP+OzWGmH0MAQ=;
        b=4QanZpYJL554UJ8vp+IfupWdLUC8LeuMEYZjNQqYLAuS7KoY7uPz1iPqBbPkngcFUg
         oapZhHbFA14HlDuXlQ04GoQdJc8mgH1sS+zuBQjfbQNdFcduJtbEe9VNAgJxXzbV/cYu
         9+GRDPm2i2zedSjGIgeBZJIpGoIlU5JfK2EleAMmlVwBg/IM7JsDmN1iHbtWN4f067fj
         nSIpIbsGs+LhptF7Xm603ne+B2bALE4BQPmBUephAE9bQP6tA6hcvqtnK/5bg3Hsc9bJ
         1q4mVNM2s+RhBeHty1YreFU4wVFG/MCFq4TQOx1YgXywHPYKqq4w78cq/nqniPVNPka8
         2PsQ==
X-Gm-Message-State: AO0yUKV6OeRWLbvCCvrt0B8tsqgI7yJ+cdzPPFGjqFbtsol29whafl7+
        4NoNPLVhI3di1dHRxk50vB5K+Q==
X-Google-Smtp-Source: AK7set9A1ldVdCpAq3Ap10aPwnBe6PrH5Qu4mhd0o9k/7a8q8cwwrFWcgwKwPFZhqDuroUVstlG3OQ==
X-Received: by 2002:ac2:529a:0:b0:4e8:220a:3d4 with SMTP id q26-20020ac2529a000000b004e8220a03d4mr3393282lfm.29.1678497706115;
        Fri, 10 Mar 2023 17:21:46 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:33 +0100
Subject: [PATCH RFC 03/15] arm64: dts: qcom: msm8953: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-3-e9c2094daf09@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=700;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=81J8dmWG9PE6nDx2pdXRDttZ5gLqaSjlpZPPbppvqm0=;
 b=2ArKCHywO9Xecx+ZZGNWjwUrv/Ya/oEPRp5RsaxStyPLUdW3Hw/d9OzGl3vx4heNqXWtbWHlAj6B
 roH60JRVCXn/T4wCAjpYn+cC3pPYYzZHbecqsmfM/4GzxUJCRIDW
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
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 610f3e3fc0c2..2a8201ab0c37 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -351,7 +351,7 @@ soc: soc@0 {
 		compatible = "simple-bus";
 
 		rpm_msg_ram: sram@60000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0x60000 0x8000>;
 		};
 

-- 
2.39.2

