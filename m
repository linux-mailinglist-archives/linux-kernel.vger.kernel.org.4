Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9362374EE99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjGKMWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjGKMVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:21:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2371BCC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:17 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b698937f85so91827591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077960; x=1691669960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGY16j5dFZopf3fqhp0nExOr4gAGTapoNrzo7XeioLg=;
        b=pDq7+w+SWQCkI6+nEShRxNEtGCjtrQl5KtZ7oHlSdmsu3JgMT73x0vQifOdE42tTQl
         FsjZR4t4GhDOOWApa90xhVRxj5eERZKWmBT9OWburgqZ+T+NJ9nv0gVyURy/RfDoZGBs
         T47XzCfvyxIGsYS5LyamRu6I4d9RtuGP6domPKbbF4ZHhnqJDMOS8dyfz5Uf2dN0Kc9Z
         F2n5Vw7Ua+Ek+/2BaKVQv6OkWtBPFSWJQV8koY+CQikTh5mArOUmlgDLoQDjK9+EBIu1
         gsl+bSnt5uxiUZ5bUaEBJ+OCo+36+erXwFy7PN1WjGq1piG7nj+YyVRgghSNSUOBJuE2
         K8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077960; x=1691669960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGY16j5dFZopf3fqhp0nExOr4gAGTapoNrzo7XeioLg=;
        b=bMjkVc3WMs2w08nVeFR96qCKD0FujM/w5pcBgmpamraaRXJzFSb4iZ3zayeVeCU1gM
         6rbg/LJ2il8VBM/Ji68yLccfW0sxVXZQPV4xicucPxAdhtIMmyTlUQ7lHr2JXJLcxjI8
         wVQ0of0AOVrUMgjJeZI18YAMl2tKtJSOx1EKllkGzgjrIjTwBf8+ajORpSo5lOlgASCa
         KV6A6mfvsOBw/CkJMd72Dk8W1WxpoFlqlffgDYVENIE/7qlkJTmkPTXscgmo/aQaCcjn
         tfX89t1bsmgXy6LNdF0smOV9EvmLl6IyEtQTrAfJ0tDmaj0q/Cdqm10DKJyksWJcAxYN
         IaLw==
X-Gm-Message-State: ABy/qLZGOs83IE4trZ0tjYV1lXgcJ9Zm/Fw6pZPeu7KBgPniFzGzrNY8
        gwVwEpOg+DuqvBTBVBwFAsMcRQ==
X-Google-Smtp-Source: APBJJlHH1du20h2dGbFyCfXBkhu0RcGK1O4c+R+VQ49+VkH4LKSqs0anMfFjKgYXCmu1PgU+sxLdjA==
X-Received: by 2002:a2e:95c4:0:b0:2ac:82c1:5a3d with SMTP id y4-20020a2e95c4000000b002ac82c15a3dmr13236574ljh.23.1689077960776;
        Tue, 11 Jul 2023 05:19:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id d18-20020a2e96d2000000b002b708450951sm435563ljj.88.2023.07.11.05.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:19:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 14:18:40 +0200
Subject: [PATCH 41/53] arm64: dts: qcom: sdx75: add qcom,bcm-voter-idx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230708-topic-rpmh_icc_rsc-v1-41-b223bd2ac8dd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689077904; l=924;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=EOUtHrbyChcnQ5Qb2DspxglgtLr61gwWppeXGW3x820=;
 b=z+vn8kUSfJ9dq9Q3yWFJseduC5gaarOE21ft8/BpJ1DYsiiGJy1Iry2wojZWxxk5c6ozrLP54
 XHiO1PMI0YuDmRCGUL6rqp7lsMQT+e9vr33lkPKPEqerL6t1HY7Ma9k
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the representation and ease handling, identify each BCM voter

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index 7d39a615f4f7..ecb194aece80 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sdx75-gcc.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -635,6 +636,7 @@ apps_rsc: rsc@17a00000 {
 
 			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
+				qcom,bcm-voter-idx = <ICC_BCM_VOTER_APPS>;
 			};
 
 			rpmhcc: clock-controller {

-- 
2.41.0

