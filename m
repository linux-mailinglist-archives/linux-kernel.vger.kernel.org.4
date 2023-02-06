Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37468BE89
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBFNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBFNoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F53E1F914
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:09 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so10376181wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFwznKCeayr2WD3soqgUqkepaQfJ5RmftUu8mIvFKwU=;
        b=pBZ2a0GgWpOdfqVM0qZtjZLpuqEBEy3wnvrNML3WQOPCmkRI8axWjbvCPCRA8aI54I
         t/QW+oljN27dEotnNiReBAjDoNywMbYgi4xS9Yv9l99bAKQ19bUGyhcMphpPAc5hZ8/r
         gr+2IAcXvzG2wBgPTy+cs4DULno5EsCRVhHxxBLjReinhQelgS+0O0AF2cgCjTZUvrMn
         vGuS9b5ycff6HgOHV5k0aSIUtBZ78a1UIP+eoD2a7XxF1eevuaihGnlqF0VgH21GW27+
         VG37IBR7eSbXQ5MFJf0AK3OWN8UjctXHvhV158+0jHEvgUZosmRU9bxYHwNIUTqa3QIt
         GjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFwznKCeayr2WD3soqgUqkepaQfJ5RmftUu8mIvFKwU=;
        b=BQrV2dS6lcSMhzrMaFYmgfIhT4i6sqCffRT3O1C2RW1tJTAnPX4uklS7V9XvIkmwQ+
         8hOa4XzCSVKv7JyhYaGbG/lpsnNfQiTLTdT0o4W7BV09PpeT3QbQRY9JOhCFcGbF+0Ox
         6Df4spPUwBBobqhpmljHbFuthTt/Tcj0SyW4Hx+qIjCGZ6FSlXABeUkhzUYhVu2YeTtP
         Wi/xcoJR6TLkzACXDbrKYRfnxzPcqne5F+GaEjLT8/sAx+olPNWIT2vmQMyt6cjOFgCO
         XQxxN6VsBceytrWP3vx2p4AYTRm38eUPabYs8TxSuv6zBMzswk0ampHST9FuEhW7QvQK
         o/UA==
X-Gm-Message-State: AO0yUKWYO9ViwWadP63eBeYtwNy1/3xGfERjhGK8hCFjxH5H5HWpd21u
        xOwwa93fhUCKX4atFMBjVImKnw==
X-Google-Smtp-Source: AK7set+GY52KL+G87rnx+qvufVRFJD0pAhZNeWiT/1yRg+dVUpn0cCsAOfo61byS6xDEAG8NOx4CsA==
X-Received: by 2002:adf:da49:0:b0:2c3:b765:76ec with SMTP id r9-20020adfda49000000b002c3b76576ecmr17436731wrl.55.1675691047928;
        Mon, 06 Feb 2023 05:44:07 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:07 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 04/22] dt-bindings: nvmem: qfprom: add sdm670 compatible
Date:   Mon,  6 Feb 2023 13:43:38 +0000
Message-Id: <20230206134356.839737-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

