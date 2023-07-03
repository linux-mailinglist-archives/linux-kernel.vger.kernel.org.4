Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732A174621F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGCSUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGCSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:20:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEB8E6D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:20:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6b98ac328so70714441fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688408411; x=1691000411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fy3w9ZErCL0BlDSMy/TiatQjTzRvjJDARdwjHF/mGRU=;
        b=ek9UtWIyuD/xpwYcGqI4EunDqUcCaAWNiLpeyhz+ZMULa4FNYC7sST0/xUzjCygngD
         giHBd8zYriREYoXksKyQu4xx791sccc03bOeCKqlezEPXzJNUidbtqsBhNpJzDMXLdIe
         i6f4uzT84jmotiHcdQGD4Bkxxvg/aHHnbmSPyjQ45V1IvJI+HslmFLTisP9WpO00b9TR
         Gg1gnM+gk2IMVglhkYE5k7nReulDrDyHM4uf812PDasIZryMZNGEmFrcodZKXp+Elbn7
         Wf9ZIIHPzpctKH2vICPVFQo8i3l/uHuLCT6tT12eCduAuFE7s17mRx9H/Tk42+5yXnbu
         n2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408411; x=1691000411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy3w9ZErCL0BlDSMy/TiatQjTzRvjJDARdwjHF/mGRU=;
        b=jdIEVGDl8jfyK0J+EN3jcXseBVDWVyovMlCh7k8TYZp7ezUePjr1rlEsIOjeNxGCRg
         ADCJB5FrA9UcE2U2+NcnmxxJNc/e6Nu1QgVanYVj7r1IVrt0D+juQHiB0eW3znVZJQY3
         /gKwovE2ZKoKRSQ6tVXaLBbe3jStaxse8w4+K+L3/fU+Es+CB4/e1ytQyU1xJRGxt1IG
         8OIAFxGEicD+Bb6wID4lP/aquektcWJBcK8x35aeFiGHuVjR+DNUfu9t85B+A/htlFG3
         BFJvvMFPAqMSg5VI3/zyDM3727kV0DAwIvDvQfrurTpD5xYzoedohoKPrnEbm+/B1+QU
         jscA==
X-Gm-Message-State: ABy/qLYu/7cAJfgZQVJHLQarDkmRr0sM2vrdY+cNLmKtkfC33G8ucRlG
        RJE7TJpo+xw3vuaaAP2oExQZag==
X-Google-Smtp-Source: APBJJlGx1nDv8sasm5EGEl2d9Qhe+l2SypAeADNunMFolSBsGzdU03dykDNi04FE/qE2Cdm8GocpJg==
X-Received: by 2002:a2e:800b:0:b0:2b4:7380:230 with SMTP id j11-20020a2e800b000000b002b473800230mr7542739ljg.13.1688408410893;
        Mon, 03 Jul 2023 11:20:10 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e9c09000000b002b6995f38a2sm4946224lji.100.2023.07.03.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:20:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 20:20:05 +0200
Subject: [PATCH v2 1/8] dt-bindings: clk: qcom,gcc-msm8998: Add missing
 GPU/MMSS GPLL0 legs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v2-1-6222fbc2916b@linaro.org>
References: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
In-Reply-To: <20230622-topic-8998clk-v2-0-6222fbc2916b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688408407; l=1010;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JIx6npJcVBGixIBbPlj9ig6P9iKP6MTqkDy6Kyhia0o=;
 b=8hu0iu2JreuANFYEfJK59dDXmixKP/h9qapYapLFNzlQCIOJHewgI7ULe7OXOFQ0LcQX/dWsV
 8woRuyDsuBiDCY50v8hv6PjcrKEwXDb3uweqLT3HJJoWz/5gg/FkjcH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPLL0 has two separate outputs to both GPUSS and MMSS: one that's
2-divided and one that runs at the same rate as the GPLL0 itself.

Add the missing ones to the binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-msm8998.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-msm8998.h b/include/dt-bindings/clock/qcom,gcc-msm8998.h
index 1badb4f9c58f..b5456a64d421 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8998.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8998.h
@@ -190,6 +190,9 @@
 #define AGGRE2_SNOC_NORTH_AXI					181
 #define SSC_XO							182
 #define SSC_CNOC_AHBS_CLK					183
+#define GCC_MMSS_GPLL0_DIV_CLK					184
+#define GCC_GPU_GPLL0_DIV_CLK					185
+#define GCC_GPU_GPLL0_CLK					186
 
 #define PCIE_0_GDSC						0
 #define UFS_GDSC						1

-- 
2.41.0

