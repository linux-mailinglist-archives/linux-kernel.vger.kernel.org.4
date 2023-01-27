Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6632567E317
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjA0LUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjA0LTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:19:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565B26854
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h16so4628844wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEBwyInNQj4T9UrPWpH8IzyU0lvHzwvDqekdsT+4wvM=;
        b=z7e8RXUuZeE00PLqOhHKOz0P69AIOZTSzpm+kqpGmfF6mHnKuPV5t15AsXg75C925N
         psoTn023JsDFVkzzMc4HZv2SKq8OXyDS7GycUVKTKdLTvzabBOKD/0Z/5cJupMRP4S/R
         F+W4/lVrWtvaIO+rg0UZpeKiTztXkZ1yOyKf3PvB7y+FpFGyF6AQVYNPJgRKxoLgJJCh
         hYjHRTTapgmumijfAvoE7V5fs4FkGlv1jY+AqCKQBP9AoVrFb23pG86j4bVGgfpb0yGh
         mEw8bwaA0J/LfF095c506KMzyOxMok0FKTNQGhpoGSYdKiK2wNwwSyVrh+BaSeIuEn4/
         7UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEBwyInNQj4T9UrPWpH8IzyU0lvHzwvDqekdsT+4wvM=;
        b=lXQpReMTQy3o2GExZ6sn/damntIIi/I4W1GQHO9CUjrr2Lbc8p7JZyCxzoIFOBPcF/
         oE4cBs3xpYhkVSiXiza6ukzZql86vWqZhHbKdtJTccQ7P1GV7RVkMJeQCdFc5+B7OOUU
         npzM61N16GnH/BuPKwrfbraCLVEbMufmlEayhXXuDNpkg9AW9288vbH0QcvN7DoeJxd2
         n5wRjHVY8a9DKjRuieNBglqLu9voCVAixlpH9B9BnNZnQkxdR2wd/hQgUtbBd4WZxKiE
         tJn+RJ+s7PrD9jNqdxhK43hm/K40LtZi+1sG4a38sKBQ/T8bHpbbzYRI5H/08T9rALZk
         bVdw==
X-Gm-Message-State: AO0yUKX8zhpBuUPomUiepNVBsdRi9m6FNtCM44aIC/elJft5Ol8JVS8G
        GVG/Pm9o+eCyzMpi0XTedvB5sA==
X-Google-Smtp-Source: AK7set8uC6qMVkxiolhjH4EnLs5z79vBpMsBZjcP+sMg3d4Bh8L66lmco8uElpd6hgIkwxiPkmQMhQ==
X-Received: by 2002:adf:f504:0:b0:2bf:bf4c:3f9c with SMTP id q4-20020adff504000000b002bfbf4c3f9cmr7391975wro.5.1674818308881;
        Fri, 27 Jan 2023 03:18:28 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:28 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 36/37] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Date:   Fri, 27 Jan 2023 11:16:04 +0000
Message-Id: <20230127111605.25958-37-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

From: Robert Marko <robimarko@gmail.com>

Document IPQ8074 compatible for QFPROM, its compatible with the generic
QFPROM fallback.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 9ddf3cef9e84..2173fe82317d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq8064-qfprom
+          - qcom,ipq8074-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
-- 
2.25.1

