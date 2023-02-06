Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90AE68BA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBFK2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjBFK2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A603193F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z13so814952wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcQCOTgzaeE74ZCuxo4/3CNeOTAuJvVOxPA2T7IDx74=;
        b=HNf48O+edFL+gd+ac+iZW3IHmiMPWW3NDTqvAg7i34SAZqgSZwRyHRqwma2XWEilq1
         2Q0PyACyhMI/qtgCABSYB8VxQ+hi7z4gM7+SlqZC7TiiV5rWGqCU5HisubW0xaD5umg3
         WG/6zXNxVtjRa3y3IOWlYIsPLYXJvKW2pyPRCjffh8+ad5+tj40KVwLaDNlp1yncsDvk
         1skE2zbUpHhNjYdqzzB6o9USBd6rHYYMbU/0Qnv4fBxw/dnn0ztRf/GJGqztAaEnGUxw
         eM6DC6KbnjHZxUCN4rnnNJEeQ46kkhOZ4yoso32x6YVJb8XeIeIVpekeNhZ2nSaB6rX2
         g4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcQCOTgzaeE74ZCuxo4/3CNeOTAuJvVOxPA2T7IDx74=;
        b=o5shlnUC3D1ofw5UlIyKMPCY5Mk1Wdq4vwCSxN7zprAYfZO3DuMjTUwBcJ0/J2JZXV
         4cBfE15MrZ9XoxnT0z0XTtdIyaj4HlIUuDZQ6DYCkytSlVuJ5/6U5cDZ6Y3e4C75up6U
         itz8cSOHhmWACL/mJ17KuVksNsSrNriXVRnGixWWfhwebAjbTGahzZRhCX8Q4clNPoqq
         iNHeWFa4xMWcdmIifeQKwWYedXn7ipUYUTZVQoltDW45fqYdumnxCRkHGtARWlWQ+Pz0
         s4MnlKmT5Htuim0dHDXJA4QvOGWT3t7QimymQOEd3pjHAve3uFPkX7pqh4dik1CjMM5y
         wSjQ==
X-Gm-Message-State: AO0yUKX/+UvUeCaKwNeHPiiorsgalQ+cwG/urQ3BI3R+4FzGU56EkFx6
        PVcutoaI4bfwxxyde7tuROE6fiiZLqUQrAL8
X-Google-Smtp-Source: AK7set9N9UlgjBlUtK94Npw5MlrwmU2iwLDiAGGUIS4SGNz5eYQ+0ngbtv76cNziDtZkzEC8BOA6qA==
X-Received: by 2002:a05:600c:c0d:b0:3dd:a4ad:ae45 with SMTP id fm13-20020a05600c0c0d00b003dda4adae45mr18523531wmb.12.1675679300986;
        Mon, 06 Feb 2023 02:28:20 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 06/37] dt-bindings: nvmem: Add compatible for SM8250
Date:   Mon,  6 Feb 2023 10:27:28 +0000
Message-Id: <20230206102759.669838-7-srinivas.kandagatla@linaro.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM8250.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index a248033026b1..9ddf3cef9e84 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
           - qcom,sm8150-qfprom
+          - qcom,sm8250-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1

