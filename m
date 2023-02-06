Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9A68BA39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBFKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBFK3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:29:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311222A3B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:53 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id z13so815838wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqGZUK/PAWNz/mZK4i7tXcj6pHw7p2uGsp/RVkZwTiQ=;
        b=Y+ZESidaCkDm+EsJSUKlEK7N0XS6cmIv7zTzftwBnVlXBUZujVCpn5OgIJPxcXDQIE
         S4BSxw0Y3mJ8BQ3Zy9Vv2kSlVIH4wiEH7Its4sXZ0eERA1XiFF25s328957irGoL3cuo
         Z9OnOFVIrzru6Bt0vWlmM2y3u91lkQ/wmlxyizIkncnNDjNGC5Qk8hCzMx45qdVs5908
         uNj4p2EpHZ+AhEw9zEOntMSc2GAgTUbbVEpyWWCZHqpMN74LN5U4I+gx2C1pf/Gua8pj
         yK5qvp08Nc9gr4uvYyyJJqefWqicSEDtg9P8vAsHny+7SADj0XsLTWbC8KXvo9y4WtYt
         khuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqGZUK/PAWNz/mZK4i7tXcj6pHw7p2uGsp/RVkZwTiQ=;
        b=N8xlqTpMotuhMZ55cjSAz3NTMfp0OyW1cr6HdXFwRCySCTmOjdWuMAZJ28u4YW+ewb
         t+QHlIEepXFD8ZtrlOj7BTJSWZrGxI1y1JxPuDD0A9bN9HfxChAo1RkaCRaCgWc63OcS
         HCTkj8WRW0E0O0dxTDd3+5evklOCIlmfnNuC3FO8zJhrrSo/+qeceAOwWzag6GNYtJFE
         s8iXOL/yxJxrYu+jOk6+xwFAwz38j3+mZ587oe8Owv/brFUXw8lXMcdzS+A3OwB/CwMp
         miR48QCZHjMwkKfuSK5dMYXIyHzPAw2diM91MyJ74It11nb5kC/iwHNzQTOWKO0duttq
         D2tA==
X-Gm-Message-State: AO0yUKVTE4XxRfl/wfR9OaB0e7rl5u9vcIh9GRSfrJkCE+1IfY70j9NY
        zqCUt2dYi/td3CtcTquKUSkiMA==
X-Google-Smtp-Source: AK7set+qU/+uuPg/F7zsJLj4urFbwHwrV8mBi/Ig2ohlkJL08igQWzXBrls2C4w+KQWUjvJy8HseLg==
X-Received: by 2002:a05:600c:b88:b0:3dd:1ac2:989 with SMTP id fl8-20020a05600c0b8800b003dd1ac20989mr10264459wmb.39.1675679330029;
        Mon, 06 Feb 2023 02:28:50 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:49 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 29/37] dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
Date:   Mon,  6 Feb 2023 10:27:51 +0000
Message-Id: <20230206102759.669838-30-srinivas.kandagatla@linaro.org>
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

