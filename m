Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D46725BEC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235532AbjFGKsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbjFGKs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:48:28 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C691BEC;
        Wed,  7 Jun 2023 03:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Cc:To:In-Reply-To:References:Message-Id:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
        Reply-To:Content-ID:Content-Description;
        bh=m/m3GNG5btyZLcdgz7M/oh1QiNI+Caj/wVSUN2s9dRs=; b=OqGEw6wmJukeS+Z1mPVvx5f4Uf
        1xLmwq2No+M4uLGmFiepO42WJoqYcLzT3f4DV2Ji4ybkPN7dUn6uuuNf26J2QDjvG+JQDl30ivTK0
        s7y71haYbFzVRou/aioAH9DCusO0HNet5w8QbkRbP4LbasoZtvIYSTk+bYobUjFHWLJRVuuZujXXT
        VQk4TylNTeOP3WRebJiPcu8o68lKiB5pe5xxexgV40eOPTr75zRIYc9jT5VZi7KrFjaY4hsnKisAJ
        s2X+r5K340LgMB5P7DrrS9Riyc7KLWmP7D6RPG5MHeuXugkZzCSvWikR+0NlECbyIS4HQAqy5dHv3
        WZ5ek/Bw==;
Received: from [10.22.3.24] (helo=serv1.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1q6qi5-0069NL-SA; Wed, 07 Jun 2023 12:48:13 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Date:   Wed, 07 Jun 2023 12:47:48 +0200
Subject: [PATCH v5 5/6] dt-bindings: thermal: qcom-tsens: Add MSM8909
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230508-msm8909-tsens-v5-5-5eb632235ba7@kernkonzept.com>
References: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
In-Reply-To: <20230508-msm8909-tsens-v5-0-5eb632235ba7@kernkonzept.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8909 uses the TSENS v0.1 block similar to other SoCs like MDM9607.
Document the "qcom,msm8909-tsens" compatible in the existing schema.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 8cc9488686d7..f95aae81ba69 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -30,6 +30,7 @@ properties:
           - enum:
               - qcom,mdm9607-tsens
               - qcom,msm8226-tsens
+              - qcom,msm8909-tsens
               - qcom,msm8916-tsens
               - qcom,msm8939-tsens
               - qcom,msm8974-tsens

-- 
2.30.2

