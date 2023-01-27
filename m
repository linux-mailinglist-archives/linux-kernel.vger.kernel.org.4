Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F267E309
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjA0LTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjA0LSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C57820E3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:21 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so4704215wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqGZUK/PAWNz/mZK4i7tXcj6pHw7p2uGsp/RVkZwTiQ=;
        b=yB4M/QJlnzlGuZpCo+IrNxansYcElG4gUKtcZw9BcChtoOZN6IyN8QEMuRzUkvgakf
         FdA52e9uiPWZaOJcHOgYJamdk5EZCfEaZMOQm3kw8vwhphGSRGVVggcP0QfOweoC2eZ4
         NRiusnfHwzcuCtGTcRY0q/JH+wPYHHA4QYc2PfE2sBXfyYZmbdgQaeTYEc0HheJ4pJzK
         rF2f2FJXzcwIAy8J+tqIkcdViBN6Zq8/YbwNwdvjTynJS0gxxspOxaJeyhe8owZPV95b
         4UFAkn3e852XVZ+MoYpnRgpcMxAIUJmVe++xYMVFAnzmC6nG73Gxde0AnKwUmiCcmA62
         V0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqGZUK/PAWNz/mZK4i7tXcj6pHw7p2uGsp/RVkZwTiQ=;
        b=wjx5jP8aCH/sEfmyncOqVgUEvpW9mD2y7d2MqK6kqy++KakGkPRTtXF5+72UKwuiK9
         fpUPQqiRe2Fs9M9vk8hIphGwRlxjmdnTbZXFCdND39V6hQ/BnN3tXj6u3Mhz8/K0+Yy4
         xBsFPXvI39UMUASzgrZ8+1p8mRjPiTWYhRIGmXKeEgdB+JiO85BqTU/TkLftHXPgLn+p
         ExVModNIaMhO2QaZtYN7I/E0s925IZx1WtUSnK02zrAdQioiJjPwIwTb8aVaBCS2+dH6
         /u+am6JsRjAtrBA8dpw0BIh/YZpPtJcQ+79Y8QRpuiiRgFjJBpGPafIOeQRaGRdnGOhx
         U3og==
X-Gm-Message-State: AFqh2krbXdPdhooY4xJUssJbU6jEa7sFdFKAGE6WyhPlZ68thrhip6KL
        2XtbpQWkrQ7XG8PczHHSh56lGA==
X-Google-Smtp-Source: AMrXdXvMybZnDrqnnItlhEuqmDDsSXY9Y6Q1pyLZIIAmHBY7ljvPQROfQVSAP529qwQh0e1AwfNMXg==
X-Received: by 2002:adf:b509:0:b0:2bf:9465:641 with SMTP id a9-20020adfb509000000b002bf94650641mr20246551wrd.65.1674818299048;
        Fri, 27 Jan 2023 03:18:19 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:18 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 29/37] dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
Date:   Fri, 27 Jan 2023 11:15:57 +0000
Message-Id: <20230127111605.25958-30-srinivas.kandagatla@linaro.org>
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

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in platforn-name. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
index 5a0e7671aa3f..714a6538cc7c 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
@@ -61,7 +61,7 @@ properties:
     type: object
     additionalProperties: false
 
-  platforn-name:
+  platform-name:
     type: object
     additionalProperties: false
 
-- 
2.25.1

