Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2426F3052
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjEAK7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEAK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:58:54 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B9210FC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:58:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1aaea43def7so9435025ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682938732; x=1685530732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOc5TkBBFvhPYDtl6ktWA3NEqkqqyBYzt0eDjS+Sk2A=;
        b=OLxTFE+/bHywEhGnTp0KfaxlPToVPdkVvcxEKvTctVIEVcJ/+CEwwcB/FOgPdaPoyC
         mrlb17WqnqVIxwUt/W0bDwZWotaHH9xwvmZTYagJDqjx/z7ZCSqgWkkHLGxCUJERqayC
         s3qPgGrxNrXEAXR2BIc0GAWjPSmf7CZzwxT8NRQFTqVcPzQ/tRZMwJQSjuHuQm8SUY47
         1LP8IqqwUD/SmF5q25gmvkf1GEhmCsEU80t5ohvkphdyq6mwe9XsJzf4Zhu80YaG2oIW
         gK91bD4kzDY5pvaz9zBXb2CFaOwagEsKjfDhXr/jkAUoAONh9RlRXK5ZH9lAqmmAGlN6
         eu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682938732; x=1685530732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOc5TkBBFvhPYDtl6ktWA3NEqkqqyBYzt0eDjS+Sk2A=;
        b=BkSx2F4qrdo9Io6CiaCE9lpDEqzj5U0PGv1PhWW7zyiPABpvpvVcn4qt8GjFn4gsFa
         5tsqFzlSmDZ1vRan1qnelgFlvqQMmsZH7I1NlV+Llpxkn0eVVgveYXa8SYw0UCm7j0J8
         618YoJajf59TMmARHFliBNET/G2PPJno6E38SMtwd9GV19vxNZLqgRsndiq7f8e2ILYB
         LZUQkXPzrwRU1rrg3TskFOiHY80Q19HFKyx3u7bHesu8x5Sz2PNVNcDTrbgwHI+QixmN
         /CxtvwhZECpFAHSlACQ2o3c5V4fsXz/eJZjWHsNGJT3z+p0hdRDpaIxGHkhoz2h9QIt+
         uoog==
X-Gm-Message-State: AC+VfDxeM+qQ/Q6SiNgmubNlkf4uUrOAwSiMRvcA+ZPc9llq8RZ+izlC
        uZ2bUUYXcikWuelG3ER1fo7dkQ==
X-Google-Smtp-Source: ACHHUZ5kWIDXe2cVbE/Bd06XNCjBzznw8QhrgiL632m4i3Uexc/PgFAvw+SP6c1fY13CnkxyOv+0ZQ==
X-Received: by 2002:a17:902:d4c7:b0:1aa:e6ff:d978 with SMTP id o7-20020a170902d4c700b001aae6ffd978mr6779153plg.48.1682938732570;
        Mon, 01 May 2023 03:58:52 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3b:58fa:39f6:37e1:bb9a:a094])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902849800b001a50ae08284sm17569516plo.301.2023.05.01.03.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 03:58:52 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and cDSP remoteproc nodes
Date:   Mon,  1 May 2023 16:28:32 +0530
Message-Id: <20230501105832.1185477-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the aDSP and cDSP remoteproc nodes on Qualcomm QRB4210 RB2 board.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index bff6ba1d689f..3ab46499d3fa 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -34,6 +34,16 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	status = "okay";
+	firmware-name = "qcom/sm6115/adsp.mdt";
+};
+
+&remoteproc_cdsp {
+	status = "okay";
+	firmware-name = "qcom/sm6115/cdsp.mdt";
+};
+
 &rpm_requests {
 	regulators {
 		compatible = "qcom,rpm-pm6125-regulators";
-- 
2.38.1

