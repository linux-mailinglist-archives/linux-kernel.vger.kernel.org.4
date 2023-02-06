Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6B68BA19
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjBFK2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjBFK2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A871556A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:20 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z13so814870wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFwznKCeayr2WD3soqgUqkepaQfJ5RmftUu8mIvFKwU=;
        b=FbqJDAJZ1kby56nnCTayJZWR1BNT4f4ynEC4N/FoiW+49sYjqmGbSVmZGtVvvaNOBL
         E2/Tdu8Tvqc5sCNVVnse9vS/VPI4KCmqDGasrzlwlus9DpyI84V9dlXgLpLDWIh7nt7x
         mfTzlg9ewYJrAL4xJy2i1pyHkeHDHYOKxNoEtA61iC/uRMAGpQGKDAzNDCa6comUVP7l
         0nMD6uXJHWney5HLc+OXzo4gFuzfUvUBF7CHWYlXmZwEIqTOQqc+dGzJlldASr2xFURG
         Ev86I5345CoSyITcxnetvSlsYlBu2HQJXiKq5wPBDOdK+iW+IEeNN6VOnNzC/irgLDTn
         4GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFwznKCeayr2WD3soqgUqkepaQfJ5RmftUu8mIvFKwU=;
        b=OquH+ZaOXSrlNs5Ns8BE5WWgNMaMvQWebOhVo2G/z/QhZvB36YZ3tPT88C0dRghgr8
         qwuH8OIRAgGDw9O5/7ToTYrCvvx4FbYXMlXRd903d+g5k3ZgQizkQky8uDEVgcv4grE1
         KtWHtnMRxJMNJnE6p3cRnXp0+MGJuqWzQGvp7sVv5GBPckqtYcx1F2C5QX1/Ij0NrVpK
         gnz1Nxn/xIW5IXxdRwageGvzSvh2kwoSd3xIqkbECh+apEVCBcnD5HMG/6CLTWJz0xp5
         QsHmqM8bo6frxpvmswNGRKbm3z7zALvT9qeta3XcQUCqMTwFnBisP+rqFkDjOvj0VWb0
         limw==
X-Gm-Message-State: AO0yUKWCCYMKS78DzkcxFB1TdFlMbn2tP9iEX9leyaPN9K3QK3HoZzGP
        vnA3XQ90gqiRTCKy07gLiMV1I5/kMj7OFuiR
X-Google-Smtp-Source: AK7set+xSzpRJ6YEqbbW1xynvrbj5F+W9zLRaZ5lV8oTQBeA2msHd0K0h24IQR14AxY2eiwSxm+wrQ==
X-Received: by 2002:a05:600c:16c4:b0:3dc:eaef:c1bb with SMTP id l4-20020a05600c16c400b003dceaefc1bbmr18516189wmn.35.1675679298561;
        Mon, 06 Feb 2023 02:28:18 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 04/37] dt-bindings: nvmem: qfprom: add sdm670 compatible
Date:   Mon,  6 Feb 2023 10:27:26 +0000
Message-Id: <20230206102759.669838-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Acayan <mailingradian@gmail.com>

There is some configuration in SDM670's QFPROM. Add the compatible for
it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 48cfec0c9ece..b7811bbb0e71 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,sc7180-qfprom
           - qcom,sc7280-qfprom
           - qcom,sdm630-qfprom
+          - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
       - const: qcom,qfprom
-- 
2.25.1

