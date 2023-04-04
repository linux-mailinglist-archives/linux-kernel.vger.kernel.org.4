Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1283F6D6A81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjDDRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjDDRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337971BC0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so133796669eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bSrBEoUzAuZwnOgxeNQWaMOoCVfz/jZ0vkkcRtm1gA=;
        b=tY+wb8fM9wCLUsGutS9E+AjiYzFE+rr9xd//J5RYqYgdBrGj7pwXkg4gfWCbXQcHCd
         lHxJMc/2Fts+QvCZxhxQ8LbKEl7A1qcbWimTq0FBHMDcgQ94fniWG0uRCS3DccSq0m85
         8wzRVdCha0Q2vSYC5rNabmwvDmfNAJQk7ZS8ttKmDZZTZ6Waq0XPveo7piJGoTUrgLCS
         HiQXC3T7avLmlyZnHPq6uKu02drGPIewLh8zsMdx5DqZfVBblFXbsKI5+2+rYTEInpda
         1IG4okTNnx6/yN3haKRmo7oQKf06lqaa6ZNUjoENq3WfahjDzqQR1Q7roQ/d0k2Vthdq
         qTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bSrBEoUzAuZwnOgxeNQWaMOoCVfz/jZ0vkkcRtm1gA=;
        b=FTrdB4buG3gti9roLHYogKIzR1Om1oy8nmBzx9FbrzxgcK6ohzgpybV0U+42A/zjjg
         kra4iaAbLUKBpE1DILbltcS4jHDcjeWxgDQK07xQEyggdYPGnnyieqYdQlgG1k38Z3/A
         VCi+VTY9x6pAt/dUi0i0hSsAwZFX3BxZEKdl5jm4POs5M3enLS5Ls7PgRxo67Rkrsirm
         uWc1rIKZlo61hQc35+nyBk5YTMF8Vp+vSbmPLUmfeVnkuywHD+kM0i5WjvNRHwRUHXn+
         szc3YMjHrHU1HxoDyoSnzzKRL+qxmF7+oaptaMqadSbXnMLTN7VpWgwjYFPfxjpeXBku
         cR2w==
X-Gm-Message-State: AAQBX9fzsC0p13gcTtWYHnOZCaXip1IJrcw26R4fv2xjGJQWvnprfnWB
        5kRo5E9UVYtRtKyl5N9ycrBhEg==
X-Google-Smtp-Source: AKy350YQOncoISSUhSMcMV4SChsXiVpPlZ5linPuEZKQ5XFkkvBxORLO8YfeDp9KmZfQ2bGZk6sAFw==
X-Received: by 2002:a17:906:9250:b0:8f6:88b7:73a7 with SMTP id c16-20020a170906925000b008f688b773a7mr88133ejx.7.1680628988850;
        Tue, 04 Apr 2023 10:23:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 33/40] dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
Date:   Tue,  4 Apr 2023 18:21:41 +0100
Message-Id: <20230404172148.82422-34-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot's "ethaddr" environment variable is very often used to store
*base* MAC address. It's used as a base for calculating addresses for
multiple interfaces. It's done by adding proper values. Actual offsets
are picked by manufacturers and vary across devices.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index cbc5c69fd405..36d97fb87865 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -50,7 +50,11 @@ properties:
 
   ethaddr:
     type: object
-    description: Ethernet interface's MAC address
+    description: Ethernet interfaces base MAC address.
+    properties:
+      "#nvmem-cell-cells":
+        description: The first argument is a MAC address offset.
+        const: 1
 
 additionalProperties: false
 
@@ -72,6 +76,7 @@ examples:
             reg = <0x40000 0x10000>;
 
             mac: ethaddr {
+                #nvmem-cell-cells = <1>;
             };
         };
     };
-- 
2.25.1

