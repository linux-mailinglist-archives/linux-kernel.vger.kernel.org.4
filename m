Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC69B74EEBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGKM0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjGKM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:26:11 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9219B4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:25:45 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso89541601fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077971; x=1691669971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAnqUE/WHV036dx6NEY6D3p5kApQ1y3z3qzTH1W8xaQ=;
        b=uzLoKddos5zRyt4BzSBDOjkRGPZL0rCy09oarN2v4QLyGWFmZ/dKXZyT0s/Aq+awVZ
         LS+GzAbZXZBKY0Rk4KneajlEirkCJxcbeXq1tA+b3xE913fKd6XwC9YZQxbFU4Ix+5PT
         hhwN5769ed9EXuTlJa3YoChQYIxuswSs20NUQX3PFzJROVwe1b8NxPgfdIFxj4yAeMCU
         WIOgTbPUXgn69aI+UsRcuso8YSlfECB6PhO/SdEEjh/kcPECcc/cF5zYmK+/H+/l28PR
         zYvrLJU6EgcUFjgrw2/cAnb5QTnHhhLp/lzvA9uW7H68mZH93YCDQbWIu3Fl6SHGqDeC
         6k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077971; x=1691669971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAnqUE/WHV036dx6NEY6D3p5kApQ1y3z3qzTH1W8xaQ=;
        b=aR4aOA6qtYDDh62alh0vXJ99jo6Dy2lxT10zeOUgNK2PFy8f421McNNce5gPKusBew
         vHygoA64d5FGsRuCqYtugVhC+CxV8ZY4GKp9rM2VvejpBppQlM0ndn/pQHxmYJKQoRVK
         j187PM2dkOJ+dpX8UfujNTqW+PRtp2Fyww4wbtI3w7lM7QLFwDjFxPbXGVx4ayfNAMk5
         dWfi9fvTQ9I4ctkFaTLLjA+jxzfDJMzdQXGLn2Bzl+bwqcd227ylpzwnf4MOPZve2dpt
         SJZArxSnDwin81IMvpVOObmz4vVv59WdXBBH4rhTsGLmgYjZJxDwG2edEAU4fqdnUet8
         08jg==
X-Gm-Message-State: ABy/qLaG1bgyZX5W8rvxQjTrcRkVOn5FnwVQZI5gbeliiN0Rw86xhe3B
        Oa/acaZ2PWmi7O9NNPaNjt8mZg==
X-Google-Smtp-Source: APBJJlHkKTM9ihSn8V3T9xMNbl03fyANS2QLVE+ICIFcS1RM0++00HN+HZZQ1KnCKxZq4VFyL6y+Mw==
X-Received: by 2002:a2e:9455:0:b0:2b7:29b:d5a5 with SMTP id o21-20020a2e9455000000b002b7029bd5a5mr12393829ljh.34.1689077970895;
        Tue, 11 Jul 2023 05:19:30 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:30 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:48 +0200
Subject: [PATCH 49/53] arm64: dts: qcom: sdx65: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-49-b223bd2ac8dd@linaro.org>
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=652;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=QPuW3Rel3JulR94tJfYoeAL03RliO6PUnmcXiEkxKJ0=;
 b=opllT+GF9a/Bed6/37yPX0plczgSYkuJUB3jZRB8+yo4DeCEiTP93/R6hdGMr7/rzPqNVd68W
 wutnZ86z2tyBySDI8bN7TTvFabHscB2+atTO98lTHMANJcn9Wutslt+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 1a3583029a64..7efdcb2a7a0e 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -795,6 +795,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 		};

-- 
2.41.0

