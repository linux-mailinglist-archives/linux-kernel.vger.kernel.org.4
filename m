Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42956648F71
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 16:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLJPdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 10:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJPdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 10:33:11 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A8FC77B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:33:10 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a7so7953683ljq.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exYMzaZr/kQLcbfHTOiS5XZ19wPMTGQEdFPGl9xrdn4=;
        b=IXuf0wukVUXjMtH7bbyeA7xFdEuqgfGgqdpeL5YbDYFg8H7iPhZjMMD9OrYDwfa2y4
         kfjYcBD07ByqpxqtC/aqe48rvyTS8tJbfFu5hnFOnDydTNU9I0wSD1Y3kkK726LN5lii
         pctk3FhC+XxJu4csK/wjkw3GcPzt/zCnyEbktfly88K/WYsXNPlxR3bDxwTd3lP+gHzy
         kqW3e6BMcF40H7H7pE17BAO0F97fOImvD+/RsA1mbwnDN/ZYLeRzODFiMqXH8zJjILlr
         TytdQDdqMfLwkvHlDZ5WzbRjOoKWhBaIfXeiOjV8Wafrxnyd5K1CKe4DBnaGi2Tuh+t2
         NB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exYMzaZr/kQLcbfHTOiS5XZ19wPMTGQEdFPGl9xrdn4=;
        b=uAeWxxULt3+Sgw7zuVcTYihLuIsBD5lsFrnNs1pFy1LQI90COELKs3O8uD3OnUUeQS
         hEEb+rIY5O2vLGtMDOpoBscxzQ09ZmhewmotmB8TQFntMvhshGRnGhjt4Ms856VAGSX0
         dpOrZNGfbWu5cFkUeLAp2vaelw72GYhIreGEFcHnz36sZRlEVW3gDcXYy6w91PThkYyT
         70UyP+Cb7fFg+SvaNjydXpvTbloY35WhfvPQrvcmnhHmzO+yanXF3aFwvmk1PUcxtdct
         XI3Pk7ccNH04CdCmCW9Gh3Nll4hCs8sW3RsSD4HhslxKAPH2wUFmR37DCBbvr13M9PIN
         OTHQ==
X-Gm-Message-State: ANoB5pn0Zogtr993reqk0wXG23R6pCFwzOwQk7h9rqr359j6iHTmswfY
        BqN3vccS3PAcKdDCja8iseB8mRXSROU5Wr+/
X-Google-Smtp-Source: AA0mqf5tLFh6y+G+uNwBq/GjqU92UxZqJke7DbSrFkOYhRmMXFbGl+1oNT08LMkkm1UzNoa+P65xXg==
X-Received: by 2002:a19:7010:0:b0:4a8:7434:65e1 with SMTP id h16-20020a197010000000b004a8743465e1mr2495041lfc.12.1670682332163;
        Sat, 10 Dec 2022 06:25:32 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c26-20020ac25f7a000000b004acb2adfa1fsm739912lfc.307.2022.12.10.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 06:25:31 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sm8150-kumano: Configure resin as volume up key
Date:   Sat, 10 Dec 2022 15:25:25 +0100
Message-Id: <20221210142525.16974-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210142525.16974-1-konrad.dybcio@linaro.org>
References: <20221210142525.16974-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marijn Suijten <marijn.suijten@somainline.org>

The volume-up button on both kumanos (Xperia 1 and Xperia 5) are mapped
to resin.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 9d667bb6f25b..d64f2b04e267 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -486,6 +486,11 @@ &pon_pwrkey {
 	status = "okay";
 };
 
+&pon_resin {
+	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.38.1

