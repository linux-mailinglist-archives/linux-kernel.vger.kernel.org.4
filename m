Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF6637E95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKXRvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKXRvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61634C1F77
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id cl5so3450530wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0J+ugIJ0lSNoX8rurDzNvXKfWJes9/BQo4T8s3+pWU=;
        b=pG5+Nx2wJu0RIfHviyjO3qsjpAE2KMJo+ZRThiMO566MYUtyjXI6moQyQvGMbHJpaK
         ikIxtMjGOsNTLKNcQ3exZW8a1LF5qVE+rA4rh7z0o1V7VqyIPGsvTBRViUozjpoJaKc2
         6o94FYbEQ/KGzLmJnrBUWInc/j5pYAi6I76ZAOIEA5C7jyJ2fABGquIDipLWTESpBpxN
         lwKj/3ym6HUQR4FgWDfdzulPunTqcHzCC5Lm849H7lWD03mygxIPvS8bJdhPckgB+yqd
         +0jEuVL375WtvqzRu7e0P4RLTZZ7wGDxMb8DkCAfResgU+FmW6MetMoNMtsONvs7+mR3
         C03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0J+ugIJ0lSNoX8rurDzNvXKfWJes9/BQo4T8s3+pWU=;
        b=sBZrBicoQJBOQfssW+AX6TU2eI83poSUy72ho8R4agaN7qxGssx6Kiwb6WPQPoVeAf
         BcHGcuTpBC32nPAP9M6bbA7kB2bE0yf3htR5+L62flI8NHGLdG+PWlccZSBeJY5U1owc
         hTi7E91sC85EIqziUNbZSmtBGwKFk4Y9wEmKps7Gdg+5rb5kxhH6L+BqOiWFxoltqVY/
         q+mr0iJOn2RNvfU001gj7iY+WVTlIB+8UA5bzBqQAxDPhpYoaJxr8L8VXX7QIzh1C3jf
         cjrw4INsYYIZ5VrflonkqqJoqB1R98Xj9tFd9aweISXagDSQU10wdxDuLH+Vbi3Q/SNE
         dgWg==
X-Gm-Message-State: ANoB5pmj5EeHHFFMqtiUDKwH6zmsg1xKHs+GfQ3xKIInOO1XNUiHFNjP
        nMJOghJgEPfX+B1RMGCXRkFoYQ==
X-Google-Smtp-Source: AA0mqf68gwP7ATKpznGpcyPgSw5e7j6U38AtVRozWrIz4lZoYnIk+ntkF2FdZitj0TY27w6TbDRTMw==
X-Received: by 2002:a05:6000:12cb:b0:236:62e3:6202 with SMTP id l11-20020a05600012cb00b0023662e36202mr20991346wrx.47.1669312299905;
        Thu, 24 Nov 2022 09:51:39 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/11] dt-bindings: misc: qcom,fastrpc: increase allowed iommus entries
Date:   Thu, 24 Nov 2022 17:51:16 +0000
Message-Id: <20221124175125.418702-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
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

From: Abel Vesa <abel.vesa@linaro.org>

The fastrpc components on the SM8550 SoC can require up to 3 IOMMU
entries, this bumps the maxItems to 3 for this purpose.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
index d7576f8ac94b..1ab9588cdd89 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
@@ -79,7 +79,7 @@ patternProperties:
 
       iommus:
         minItems: 1
-        maxItems: 2
+        maxItems: 3
 
       qcom,nsessions:
         $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.25.1

