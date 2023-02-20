Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6364469CA7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 13:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBTMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 07:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjBTMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:08:43 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A936D50E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:08:41 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b13so1903790ljf.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JL8S79pZmvWgV7qwFqlM7bRr0tK+jdMcMIVg+zahXW4=;
        b=xD39Or7bW9DgBSJLIi5SpdIhQ5k5E6dINKE+OgyryZJ+BqPgNpJwE+qPOYYyYLg+L3
         /m22Ude7GD4WO72wt4PiBXNGI0K5mPQ4PJ7GXs0aSt1Q9c7ioxFCALKz5XrxEwgmULVA
         zcP8MA+sbLwwQQxMpIg889txsugEmMOp2XqRgbwPxI9gBGt4xN2q2/gzRW6aFHjnP8Nm
         fd3YP3V0A6qhhnQqT/fSqBbmkvIk8IxPxMGo9XXyyYpynJ7hcDfe39BTOX+Srz1g1AT3
         O6wHsw7UhSIoVzSyPt1AMMzZRTMTmZ/iAd8H7PxTOptaqehWVjvP4cQKR7BQToA1m+32
         5btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JL8S79pZmvWgV7qwFqlM7bRr0tK+jdMcMIVg+zahXW4=;
        b=U7xvwhvU4QX6NKpBhFTcIQERaZSDw+bmmIgoONDvdrd32vN/CrACGEZIOeqZRCC9MV
         yZtaPMbSyKAyjhW8CfcaAMiYd6/BwebxqlR7cyN5W88dHhoth9+J+++LTz9tibZ23KD7
         njziN/RzBhynA7I2HH8sDH5HW8ikVcznauhkqM05AQ22slQ73pi0qGiBm7jka6mwuGLi
         gXi5/2hbQsTtOxwfnp4gm60yY6HzrOtx7/UabSXQHbagm1cgWySs3JFRZeI/GAntiMkX
         ft5XVEOIjlc443ku18DXq79alPt51dYQFCGrq4Z36Y+hRMlsvd6wjH21FBx7K/VQVZxv
         w3fQ==
X-Gm-Message-State: AO0yUKU6TGVjGNaK/LICXCy+VTezdGbJldCW8aCGxr+Vo16PAVJhktcS
        M7AlZSh8ARUHqpScEH+XjjYfxQ==
X-Google-Smtp-Source: AK7set+vhV/IbCiIxMxKR2t6lRDxsby85xnzAcCA+pIxw1IkfsaH4TAT7A4R9R7IDPG3aMxjM3jYuA==
X-Received: by 2002:a2e:9a87:0:b0:294:70ba:1f37 with SMTP id p7-20020a2e9a87000000b0029470ba1f37mr129019lji.3.1676894919128;
        Mon, 20 Feb 2023 04:08:39 -0800 (PST)
Received: from localhost.localdomain (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id d11-20020a2e928b000000b00294e89cfed2sm593113ljh.111.2023.02.20.04.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 04:08:38 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom-apq8064: Fix opp table child name
Date:   Mon, 20 Feb 2023 13:08:31 +0100
Message-Id: <20230220120831.1591820-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The opp-320000000 name is rather misleading with the opp-hz value
of 450 MHz. Fix it!

Fixes: 8db0b6c7b636 ("ARM: dts: qcom: apq8064: Convert adreno from legacy gpu-pwrlevels to opp-v2")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 92aa2b081901..3aeac0cabb28 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -1260,7 +1260,7 @@ &gfx3d1 30
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				opp-320000000 {
+				opp-450000000 {
 					opp-hz = /bits/ 64 <450000000>;
 				};
 
-- 
2.39.2

