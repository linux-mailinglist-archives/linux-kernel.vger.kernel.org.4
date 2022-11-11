Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8190A625A19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 13:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiKKMCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 07:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiKKMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 07:02:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7C85443;
        Fri, 11 Nov 2022 04:02:12 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 910896602A69;
        Fri, 11 Nov 2022 12:02:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668168130;
        bh=e+ArDT2t4PV+LjnK1uWBh1mFJ4Qzmul7ZTkVo8z5z98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlA5/UYUHX3fh8NqK0XR1cDLL/WxVXxdhaegLR0hC6YACWUfzSW/ZFSWte+ek9LGU
         6+mfM4ZOA8RUHW/n1fE5uTfBIjkfSLidAwsJHsdQI1c+2B/+k5mVQLZPIkUnQVhFRi
         jGeESG3//lYsYssu1ivxUu/Bh0t6c0tJS6k9H/79J76n6gtOwAKJifJP3LWbDP/9ux
         ce7bWV5jVgCBjni8UTXUX9+z84M7dBzDcQaw0uqAvi+CaPHXqQL7oOyA2Bqk5h81O8
         N0SADlp8lbNjz3Jbi0Mcf6kP04j3zuX513qscL5igKFGm8PkEzYobNXIN/sQa1H/jy
         Oa6E//U6hR8xw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 06/11] dt-bindings: arm: qcom,ids: Add SoC IDs for MSM8956 and MSM8976
Date:   Fri, 11 Nov 2022 13:01:51 +0100
Message-Id: <20221111120156.48040-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the identifier of MSM8956/76.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/dt-bindings/arm/qcom,ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 8b1a0f43bd93..91633da5fcf6 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -78,6 +78,8 @@
 #define QCOM_ID_MSM8616			250
 #define QCOM_ID_MSM8992			251
 #define QCOM_ID_APQ8094			253
+#define QCOM_ID_MSM8956			266
+#define QCOM_ID_MSM8976			278
 #define QCOM_ID_MDM9607			290
 #define QCOM_ID_APQ8096			291
 #define QCOM_ID_MSM8998			292
-- 
2.38.1

