Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A98C72ECB2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbjFMUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbjFMUM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:12:58 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFE41FC9;
        Tue, 13 Jun 2023 13:12:41 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3408334f13bso2682305ab.3;
        Tue, 13 Jun 2023 13:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687160; x=1689279160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oddYJI1Au0Bn0ZcRmQ0kDRSxDhbPMqnSUlKHFev/jqs=;
        b=J1DhJortaFpgNWtZdvjLDY8qwculWGy8KriBhCkX3CAjLgc9NdFl1A31tJ57vUgSpX
         mITPh34O7747QQy2pZO5Oa6Pm7eTdBn/rRpKF/j4jssoUY+SkQ6zUpj/IPcRVnwbCAWp
         7s9fNQ2Cc1roE7RhfZqCZ5M4WL+s39F9Duq6ObTsFx8zSTOy2hUzE3fXM7bKobv3zl7O
         zkgEt51LAHcM6mDOnhKHD7mcuKQsN5mrjo7om5AwrKSJq/x7qGVy1sXGsR7BIszq0P2+
         0x/qdfKe12NiAbijzFWsL9/brgVb1VAy/8+Sn3Rpo++vfO5/EB7JlufAEBvLsTtx2LDQ
         Xazg==
X-Gm-Message-State: AC+VfDyCb8ela5eye5oSlMmurim2KW39PidCI6ClaTF0Su8eeVHsW61I
        LV2mqGnbdYSWg8pmrAvLMQ==
X-Google-Smtp-Source: ACHHUZ4ZjlbQhnvd4WwCh+2VWWgPQoAi0uSYLDOAA6PeQNVESD2t3GfM/OUN1AVNWSmf6dqcFZZQVA==
X-Received: by 2002:a92:ddcf:0:b0:328:52d1:6415 with SMTP id d15-20020a92ddcf000000b0032852d16415mr11477350ilr.15.1686687160314;
        Tue, 13 Jun 2023 13:12:40 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y10-20020a92d80a000000b0033e23a5c730sm4021994ilm.88.2023.06.13.13.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:12:39 -0700 (PDT)
Received: (nullmailer pid 2826527 invoked by uid 1000);
        Tue, 13 Jun 2023 20:12:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add "linux,keycodes" and deprecate "linux,keycode"
Date:   Tue, 13 Jun 2023 14:12:30 -0600
Message-Id: <20230613201231.2826352-2-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230613201231.2826352-1-robh@kernel.org>
References: <20230613201231.2826352-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "linux,keycode" property is non-standard. Add the common property
"linux,keycodes" and mark "linux,keycode" deprecated so that the mistake
is not propagated.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
index 6052129bf852..e879bc0be8e2 100644
--- a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
@@ -105,6 +105,11 @@ properties:
       linux,keycode:
         $ref: /schemas/types.yaml#/definitions/uint32
         default: 116
+        deprecated: true
+
+      linux,keycodes:
+        maxItems: 1
+        default: 116
 
     required:
       - compatible
-- 
2.39.2

