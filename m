Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA67D68BE8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjBFNoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBFNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D21F4B0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ba1so6341978wrb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ+Rhyub7QdZQCx+PBV6POAj+tkBwCFqMXV8WoFTj5c=;
        b=OChgLe4ZJ1dox+jdQUl/heeyMhsmlL8/nv1cYk4sdWdaUTz/im5P84Mvk0I+Fh4+WI
         j9aZMBJh1cHyQqgpElp12GILE492J+R9GSpDj3P3XzmkulnvhzwXBahZmzbEvWsWbNdr
         sNZ8LuEQFR63b9jlIBXITgJoaGhNY33wZrF44C3v9aOR78OkTfPiPEkjDNxkMefoV2GS
         scpNEezlP9hzJdVZd7d7DVS5M/i1gmCXpNYY0Y/Y2VDhAMiZvoC/BvQUi5WTHzVMJUfp
         sWhlCnYYD+/5XOzeYfUukNc9ckbeYj0lx23aaVRV1GtZPLQyHK5jwxpVnvEZjxjLCPH5
         JhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ+Rhyub7QdZQCx+PBV6POAj+tkBwCFqMXV8WoFTj5c=;
        b=r58vh6mN7KCrvAFnKeKI7clJETz2oLpSWj1LJwbrp8N262JvZYclKioJy8Y510AYex
         eN39xnxq4dfh7yINaHGdbeyLS2Ny61qS4tRw1KyHVhmUOsSht1JNdLfEPjytB52Zj8i7
         bD0gXTR8u/h+zTHs33KpRXQm6/UiDe2te9APO4NUyIbUTYxedG8u/xfJeMW5sl+yk2wT
         4f8SQ16RnVejEn+5TwkBDxYOrg/CeBenwioYa3EZ3F6DMcG6Itgt81TztxUDReB8tQFZ
         nsD2tAKe8+LOfmO4uIZSQS8SCKrEEKj6veXLGzima+BJEjM/Yo+nww/2EIfWBBw1+njq
         VqUQ==
X-Gm-Message-State: AO0yUKXTV+y5jG4sUeE1WWOsxp5se/rQKOiTtdhmwYsUL3Q6bsEiX0/9
        HNAkXUqcgORTeybQKKXsP5cXIw==
X-Google-Smtp-Source: AK7set+X66bm1yfueEC08h0O6tOXAvErhlYe4QxeGIe3Jv5dgXFFC1gnbZs1EHKOU8AECwItDbna4A==
X-Received: by 2002:a05:6000:185:b0:2bf:b77c:df72 with SMTP id p5-20020a056000018500b002bfb77cdf72mr16820884wrx.25.1675691049632;
        Mon, 06 Feb 2023 05:44:09 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/22] dt-bindings: nvmem: Add compatible for SM8150
Date:   Mon,  6 Feb 2023 13:43:39 +0000
Message-Id: <20230206134356.839737-6-srinivas.kandagatla@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM8150.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index b7811bbb0e71..a248033026b1 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,sdm670-qfprom
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
+          - qcom,sm8150-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1

