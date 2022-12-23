Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A9654AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiLWCLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiLWCLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:11:00 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFE72678
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:42 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so3364886wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKsehGcz374PW4Oaqc03FTNTJ/WJN4Esos64GXOFLAY=;
        b=KqX6xba6VOUJRQxcYuFyEl5MN4OTC9/YLjFnYM0y/Ui0ySu7xqgoC9GSHDhuXm/mRw
         YEXsFzPYaHbqF7TKKNCqDhovflrGgVk/qeR0nHTI23mjSYE5vbCI8k/ZJjPlD7CogxNf
         d0vlgZXivD3fovR3fnB5nos+ppvWUrGbfCR0Q9SQsVN04rzVOl1HikdzB4CssH7x6x0N
         fv0X6DCJWEnZD6qLRglYHVlF57fM3t3XC6nkc15AixQVTYW/RJfdwNDY1asiYkCUzzYi
         6yp/nf7tKf8ZkxHNmbCV6eKShSKwNZJjtzFZIZFEh4e70AW+MqV6YXaO4RYY1ySY9YkG
         7bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iKsehGcz374PW4Oaqc03FTNTJ/WJN4Esos64GXOFLAY=;
        b=ALmtW851viByFdRS4eULhj9Hf2dYL2lgW8kL8dtQmAZ+/uPUTB1j/cX6dx8rDNbVlq
         vPC/Lgf5FRJWkxaJxxc4UmYxZRsV1TiPvalJQImcgwRHpic+7u6uSTwKB4ps/iAqfHsH
         iKd3snK8wgakkJw8LxS6OTJWZgv4FJawxy42c0hIugMZmr5iMblwa75PeSnrBXA5C3ji
         rdW2lRu1t8P5/GIwPsqlrFN04Qsa+stQ7luA/FgZaCX2U81nnX3d65SyUiZlmrxUqQMl
         utPXqCWcQpnIMn7zjjLkU7bxxOczcR6Tu2s81cizTGnriXdyVyyb5I2pSFev4GxZial+
         AaCQ==
X-Gm-Message-State: AFqh2krWgY1E8p+dqQW25YC+DnoOFp5IId2o/43Hvr1y/Bs4RdlXyC21
        jPqIEtYRyy9OepNL8TbFE9izhw==
X-Google-Smtp-Source: AMrXdXvWx56tSgEpdKCB2SaaRbSQnrH+JXmPG0KIWD3R7yqr3hjdlUPj3/q3h8C9oxFJyCPhFEawPA==
X-Received: by 2002:adf:de0b:0:b0:256:6553:5878 with SMTP id b11-20020adfde0b000000b0025665535878mr5547805wrm.58.1671761441333;
        Thu, 22 Dec 2022 18:10:41 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d452b000000b0022cc0a2cbecsm1849725wra.15.2022.12.22.18.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:10:41 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v6 12/18] arm64: dts: qcom: msm8996: Add compat qcom,msm8996-dsi-ctrl
Date:   Fri, 23 Dec 2022 02:10:19 +0000
Message-Id: <20221223021025.1646636-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
References: <20221223021025.1646636-1-bryan.odonoghue@linaro.org>
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

Add silicon specific compatible qcom,msm8996-dsi-ctrl to the
mdss-dsi-ctrl block. This allows us to differentiate the specific bindings
for msm8996 against the yaml documentation.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index d31464204f696..c6d8371043a9a 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -989,7 +989,8 @@ mdp5_intf2_out: endpoint {
 			};
 
 			dsi0: dsi@994000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x00994000 0x400>;
 				reg-names = "dsi_ctrl";
 
@@ -1056,7 +1057,8 @@ dsi0_phy: phy@994400 {
 			};
 
 			dsi1: dsi@996000 {
-				compatible = "qcom,mdss-dsi-ctrl";
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
 				reg = <0x00996000 0x400>;
 				reg-names = "dsi_ctrl";
 
-- 
2.38.1

