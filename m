Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E43746239
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjGCSUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGCSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:20:35 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D430A10DC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:20:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b5c231f842so70378371fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688408421; x=1691000421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMGOdp2WrmK72JlLnA4GZHmaTpxK++joMT5QYp1sllQ=;
        b=lhTdDtnHM8h9ePa+Murs4OHPWVomZDeXPgOpnX3OehH26YGjrpqtm70lui0AjPvQtG
         jaYtgTl041ICwg0AI4Wu/6jmusMI2Acl+N7AmDGsFWGtT6866CWdY9kiiszXiQ16XoFs
         A9Zwi3qrscx/QnLuDmfkzMKizuAqL6rk2AEMpLN5mHtsCFBTZgXwn4nB87wANtHhph1C
         l7rty66I47+ALpGD0xCaWOQTSslViZZL5N2vJizbzhkoKG/lHLx6vaQJ0VTebvOFmOcS
         LgOawt1ww1e0qSzzYnBdCVMLj+ZkF2SfC34Lw2HJJ4ZnNaZjhR/zsnn7qh5S1pPQbFPi
         da4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688408421; x=1691000421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMGOdp2WrmK72JlLnA4GZHmaTpxK++joMT5QYp1sllQ=;
        b=YSjVCs5IY5OLcjggNQB2w0c/5aFQ90/45xKkfS9S9n3U+BmkjN/qVk9NEnXBPy9Wi5
         BYmOAeYqtGu7lJzFEpvXxdNZ1RpGiS6kL1hvT3VBgel6nSKxdX+3BoJJx91WuHZhSWbA
         6TJB29T08HikGXpbCVhFr0w+Gy0lBqbtzhyZThwkp+oIwpI+Bz1LE4KSFhIYc9eGgmWt
         Ncr6FBHpk17ElvoSVdzy08xYGXQiXoHOjmCNX88Fb6IKgLM3JQqC5yuDU5A+GUpiTvp8
         /7ZJTxVKmWXFVgJaPvRXYjUU9MlNUCqlo3PkHWb1rXC+gHzEV42ayKDPeiyCnDyp1MXP
         p2hg==
X-Gm-Message-State: ABy/qLYre8rK+qOdkgQTh93qXrVB6MU4UN994bwcqWqujqj+bMUyMkC/
        9Dy4HpawwqkPMQ7/LVw7K91t8Q==
X-Google-Smtp-Source: APBJJlE8ny5kSPTUjmQmeDKziqPR0/TUc/91ONsaWaWWKJ4df8Y71rdn6WYsPZtmTayEdfW6z7X7Fw==
X-Received: by 2002:a2e:850b:0:b0:2b6:ba00:f733 with SMTP id j11-20020a2e850b000000b002b6ba00f733mr8333259lji.18.1688408420733;
        Mon, 03 Jul 2023 11:20:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id s9-20020a2e9c09000000b002b6995f38a2sm4946224lji.100.2023.07.03.11.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:20:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 20:20:12 +0200
Subject: [PATCH v2 8/8] arm64: dts: qcom: msm8998: Use the correct
 GPLL0_DIV leg for MMCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230622-topic-8998clk-v2-8-6222fbc2916b@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688408407; l=1108;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=rcLA8twyqUlcJD4D43vneN0vw2noKKbjZxFdyfHDJZM=;
 b=J9qF1k7V2CcK1QdJjF8lyl9xKqY04T25afPjuYYxmly9bH9mpvemJtiRXtaKrrEaWRVNontZE
 8X79xc6aeF3D7pgVQuJGJEZIkWOOAAtyaan6pgi66L4r5buBBT1lL5i
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

MMCC has its own GPLL0 legs - one for 1-1 and one for div-2 output.
We've already been using the correct one in the non-div case, start
doing so for the other one as well.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 74bd05579796..c4faba092368 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2718,7 +2718,8 @@ mmcc: clock-controller@c8c0000 {
 				      "dsi1byte",
 				      "hdmipll",
 				      "dplink",
-				      "dpvco";
+				      "dpvco",
+				      "gpll0_div";
 			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&gcc GCC_MMSS_GPLL0_CLK>,
 				 <0>,
@@ -2727,7 +2728,8 @@ mmcc: clock-controller@c8c0000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>;
+				 <0>,
+				 <&gcc GCC_MMSS_GPLL0_DIV_CLK>;
 		};
 
 		mmss_smmu: iommu@cd00000 {

-- 
2.41.0

