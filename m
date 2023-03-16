Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D586BCDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCPLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCPLRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:17:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0152C48A0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y15so1850536lfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678965432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYPQdqinhymXQj5uTyuhOZ1fYw2hicDkmhnGZjiMqrM=;
        b=aArFmhoat88k0PfZZ/bO45ZiZm5sPftg/jyOhYcfRo8lthz384vnWJ+sVGlRMwnYQL
         qPw6XTK8B/h2FEWDK2bWrEsKCpkuSqv5KiK/+wA2HYsyM+ljZML3UF11Ui9TNQNUSRZ7
         58RML51uj+hdqSb1YaLiYFoj3r5Jvrto6AtfOtbLcVqPmoYmgXrkkA/lDBUDHezDUM4x
         8qNm2EzDqBQl3oE4cgwh8AXaiWcI2rth57xLwdq4+LrboMT48F/zu3/Dw6UohVuWesLI
         QJn+wRAWLKBTtLjzCcQZ944U4p5jDIfzw9RFUfX4JYxiVTW0OqTeRPaSTFYE7cRXeKj9
         yvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678965432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYPQdqinhymXQj5uTyuhOZ1fYw2hicDkmhnGZjiMqrM=;
        b=oCo5yhfzxgrHJqP8HU+i7o2UoAwdZbxeo7lQJagVKrQgl4mdOHvkhmtyopHoqWIEwj
         6F2r77IqSsagJBIhtbBxShKLPXErr5o78CdCY8cucPbqlpLl0gXS97yhV4SkFSRfWbP3
         38OMUnOl75QmYFZCtygB5kqEvB4/DUmEi5bqu540gvXPC03zRQcGj/4bZuajfxcFOyFl
         ymZYbV2Y/HDmGf62CJMJNRCLjb9l3mlF84+D1Yj3F3SZM5CG5xRrby1Hqd27RB5rqEP0
         etutJ2+5DHeJJSK37eu04LwdBvc3HLofM0g1uLyFlPx5C25SWxFuscMI/4h3tr6iWfyZ
         ekmg==
X-Gm-Message-State: AO0yUKWOovxL6Do0LJ7mUHiKrtKGY2k1LOkTWPoBgBd7aVKgNOr9enAW
        n9paoXP2a0ZnbNfIVrbaeoKJxQ==
X-Google-Smtp-Source: AK7set9GLUXdjcnR3PE7bAXhezoiQ1MuqJNJ6Sn4uWrHhyDakwWBsyE4N9NnlJWJ74w27vLtB4JveA==
X-Received: by 2002:ac2:5097:0:b0:4b5:9e70:ca6e with SMTP id f23-20020ac25097000000b004b59e70ca6emr3205389lfm.17.1678965431919;
        Thu, 16 Mar 2023 04:17:11 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u28-20020ac243dc000000b004db2978e330sm1194222lfl.258.2023.03.16.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:17:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 12:16:58 +0100
Subject: [PATCH 3/5] arm64: dts: qcom: sm6350: Add QFPROM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v1-3-a74cbec4ecfc@linaro.org>
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678965426; l=963;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=j4PNB4+G8/dM10UVcLzfnSLHfKZoes3Hu7z8kNdTYNk=;
 b=aCZnPj85u8/se75uEUhkWctyNzjU2/Ra7v0a5zk57RGX680lQLtOrnw3OoAMYSJ/+JsQUtaAIbPy
 XzJhpZBzCPjhiyvXGT6gM5aUV8LebqK2/rseDzPG3lhVJxfgkD/f
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add a node for the QFPROM NVMEM hw and define the GPU fuse.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 523c7edfa4b3..60b68d305e53 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -637,6 +637,18 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
+		qfprom: qfprom@784000 {
+			compatible = "qcom,sm6350-qfprom", "qcom,qfprom";
+			reg = <0 0x00784000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu_speed_bin@2015 {
+				reg = <0x2015 0x1>;
+				bits = <0 8>;
+			};
+		};
+
 		rng: rng@793000 {
 			compatible = "qcom,prng-ee";
 			reg = <0 0x00793000 0 0x1000>;

-- 
2.39.2

