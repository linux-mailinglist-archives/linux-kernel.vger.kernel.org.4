Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFA674EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 08:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjATH43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 02:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjATH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 02:56:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1B4C0D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:56:25 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d2so4055673wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 23:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUADaIFSKnQf+0SoHIzKkUQFN+SsRrz208WuulVyoak=;
        b=VzXc8gHt0v1Iy2HIVuJLp9hhp9Azx8FYGaD2i4vCsD9eIgUTDv/yok0aYcmPQtkEZu
         S0ecNiUw7RO4DYS1xYuBM7GNSmue7XVeCLo3t/uqH1IwK/Nan/K3eBYI3UGe7gGd3Yhs
         0nlEsio2m5AqBLNPOri23PxcwJyZDrsQx2XaL/K81Jf5Gt+nZlrNVv9d9isRJI6cdEFl
         unYYMbJ5OLMSYHJ3km2I6sR/+t9Vk9kLn5FDtTPVlhV38uqG+i7gvQ0w1UUtTpbequll
         EPd/IknSq18eDkDftrWv/TlPrrk9GkeI/62SRyHhW24F9dev97+NAYt2n7lg17obB4L8
         /hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUADaIFSKnQf+0SoHIzKkUQFN+SsRrz208WuulVyoak=;
        b=JwHGYIIFBeOuIJiqtesAIJi3aySW7TvXV5f234iw4Esdxi//UBf9A7VEr5AF8MBKkX
         H566jAskauTT1D5jQ3YIx+sI4ZKyQQegPZx3kCYm5Ho1KpfTe5i8LUq3zST+nyVMZHl/
         G9gvshrvQRojSGCQIg54F90uXpLU1qnm2mI1TqEhjjqO2RTyVN8zJVQKxkXeKGUn3lul
         Wky0CjYT+NNAnpbsbkc7OUc3td935kmurdRT21lEoQzRI/9Mbtx6/WGRKfW097HFduDX
         YxJiwspZyEbI/r+Hknvy1mmRiPQ5SXybwjp4nUMBgFSjYwafFangtpJIEI6kxnq1rlAy
         x3cg==
X-Gm-Message-State: AFqh2kqd9R7X7hJedSKleVrElUFqEHEfWVOPcdDZux3HInxy0DdosgVB
        YsS9ZxRL0GsSYIFgN4PC5YUiFw==
X-Google-Smtp-Source: AMrXdXuk0XpVWWB7iKPpaTnxrfqEpVje1+p9N+X/GMB3aJy0mMUZZDjU7nb0e92eT+NhovPhkY0ULQ==
X-Received: by 2002:a5d:67c3:0:b0:242:8af9:b987 with SMTP id n3-20020a5d67c3000000b002428af9b987mr6985970wrw.13.1674201383929;
        Thu, 19 Jan 2023 23:56:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d5-20020adfa345000000b002be546f947asm975622wrb.61.2023.01.19.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 23:56:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: document lineartechnology
Date:   Fri, 20 Jan 2023 08:56:17 +0100
Message-Id: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Document lineartechnology vendor prefix, already used in SPI dev.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 38edfa65fde8..bbf710b6e4c9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -735,6 +735,8 @@ patternProperties:
     description: Lichee Pi
   "^linaro,.*":
     description: Linaro Limited
+  "^lineartechnology,.*":
+    description: Linear Technology
   "^linksprite,.*":
     description: LinkSprite Technologies, Inc.
   "^linksys,.*":
-- 
2.34.1

