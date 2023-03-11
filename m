Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2786B5758
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCKBWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCKBVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:21:50 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD212FD35
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:49 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d36so8927078lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcpvnc2Ywl8vUYg6SRc72CWrWMEdDF3G4rO3tFQwydY=;
        b=ko2AgNRU2UfYU5QxeWmuNJOy/ZAXJ7B5eqrwWdeBzCYp8AkKT2PCcFKB5qPUH2jUEG
         EqlGoyFnmQISk/Qcv9mgonD2tO+RENUQdEF3CbfiKHQdE5t4jTeGKZ8c1LtfR7mJcw/E
         3OdY4MvsPJBa6qpNSsE+ah/glvHTTA/mD4t99aOUTZ46Xji66JjI1W0M/M6noRFEcJDJ
         v0qLRUQ8DI3bhUoviMat2em6+Ag5taeKwMqc3kDGjwpnG9kecejN6DT+zcX5RintT2kV
         ghS3V+bx2upXRTNqFxflU+YnjrKzfKIPtgtZFNsDNLcRW/W0cO7VfpjYh2vxeHGWtlEb
         LDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcpvnc2Ywl8vUYg6SRc72CWrWMEdDF3G4rO3tFQwydY=;
        b=jld50IjSiCNCg2bLIOnaicapuoa4xVg/aTPNBBBAVZzTgP1AtPZOR75QMPkbYePxp0
         sS1UbD9QskzTCHxEts9PvkrA/TkkwXW0QifzsEwrWCd+LwxJ2b2PXidQ5gDUnfSKLIEy
         Wi/qDaS/oRjFZM6ynGbV3SAIQpjI9ZycUezVbHmono51NfGtAq2YeGtRUVaKtT5z+CHQ
         hEJX42lXz0lOt30MlR5e9LhA51pep7EJ+97MjFJ+GNIcmGZPY46DiKFL+kYcpo9YJmw2
         xwTklVA9dFCj4qv07rQM+WDil3RqZnRwAZhEfjtIw1ftHNdkFarRZRlEEf5sa17nkVo9
         Zygw==
X-Gm-Message-State: AO0yUKXBpK3gx6h28Z5dKZRe3eMgEeDRg6nGnOh6FMMBoRQ33Ag1MGZ2
        3Qhr2gAPgjh/5ILCYwAKJCGejg==
X-Google-Smtp-Source: AK7set8UIv4C2TWzdMr6DnqqwpoHlIclfuU0iSpQckm1zv5EoNVa3SccwZNGILdk4EGV4Ur/IHzGmA==
X-Received: by 2002:a05:6512:15c:b0:4dd:985a:1dd3 with SMTP id m28-20020a056512015c00b004dd985a1dd3mr6837942lfo.15.1678497707530;
        Fri, 10 Mar 2023 17:21:47 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:34 +0100
Subject: [PATCH RFC 04/15] arm64: dts: qcom: msm8976: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-4-e9c2094daf09@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=678;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=KJeqsfRcZkKd46OjzMZkh5RzY4N6BisQownadcTP+Kg=;
 b=j/3J+USO+/G+xmlIm7/O3SWaUQKDslEMcMBXCHfAA8iyE37pcXVDSt3ele6BB84GL5DwYpv0rt9P
 i/pndZhHBCY1SFRx+vr8THTAd3m7np5nJBH2Wr+YvYkO+i30k+xm
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
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index 2d360d05aa5e..93871d975fb6 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -457,7 +457,7 @@ rng@22000 {
 		};
 
 		rpm_msg_ram: sram@60000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0x00060000 0x8000>;
 		};
 

-- 
2.39.2

