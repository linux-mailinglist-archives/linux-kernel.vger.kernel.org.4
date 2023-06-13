Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7072ECB0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbjFMUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjFMUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:12:57 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98A61BFD;
        Tue, 13 Jun 2023 13:12:38 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33d269dd56bso24792935ab.1;
        Tue, 13 Jun 2023 13:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687158; x=1689279158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOZIQBDKy2phoYWlHea2hom6JZXMO/IHjZv2PzErzXs=;
        b=GyGf1dxDnZk0TcdSmIPkgD6lybFBS70ptDVsO7MxKMG6TYOe0VQEUMbnJRnMfHKoZk
         C0TTzsNlSABc9DdD6Rv62qSowElEneQdQC5+BQsktP41wyPYtYgjaD9FE2sVsFvOsVsa
         GSE+t/R+Tawls5KUVeMBPXrZDAL98t1fsc+Ar2G7xzWaajj4j4n4+0WxHi4goQfcBgOt
         qMpy/ApZFCF8VXXu2CUp2J4LSgLJf7grfg7baKuPYGn2vZuZRHhH8QOilFMDiM+IbskB
         R1G/ZTiJP5HX+0+fN/ZPzi2zJKpr7gHiHQm+XEr8r+01nObV/wktdVjG0tgVzVEQF3hO
         mHCQ==
X-Gm-Message-State: AC+VfDwmoAgct8kPpGMpBn2mVWfYeWqSmA7MrFmhge0assm6K+oszxl4
        vLj2GWE0LEcy0V8SCY/flw==
X-Google-Smtp-Source: ACHHUZ6t5H6H+OiQsJB+7wKd39zkkt23zsP4+mprng2W1w1AX/1fk0KlPe6jzlgXwI5G282HoUsx7w==
X-Received: by 2002:a92:7302:0:b0:33d:3b69:2d28 with SMTP id o2-20020a927302000000b0033d3b692d28mr10183276ilc.29.1686687157940;
        Tue, 13 Jun 2023 13:12:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p13-20020a92da4d000000b0033549a5fb36sm4100057ilq.27.2023.06.13.13.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:12:37 -0700 (PDT)
Received: (nullmailer pid 2826488 invoked by uid 1000);
        Tue, 13 Jun 2023 20:12:35 -0000
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
Subject: [PATCH 1/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add missing type for "linux,keycode"
Date:   Tue, 13 Jun 2023 14:12:29 -0600
Message-Id: <20230613201231.2826352-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The "linux,keycode" property is missing a type probably because it was
confused with the common property "linux,keycodes".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
index 286dffa0671b..6052129bf852 100644
--- a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
+++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
@@ -103,6 +103,7 @@ properties:
       wakeup-source: true
 
       linux,keycode:
+        $ref: /schemas/types.yaml#/definitions/uint32
         default: 116
 
     required:
-- 
2.39.2

