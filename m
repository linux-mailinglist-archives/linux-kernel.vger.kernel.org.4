Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2694D608062
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJUUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJUUym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:54:42 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E6A2CE13;
        Fri, 21 Oct 2022 13:54:39 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2528024otu.7;
        Fri, 21 Oct 2022 13:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lphddxkNoZDL8Y2telQIcmqQFZtL44QNsGbFg6V8vGQ=;
        b=Tz5C6eHkxBF+nXJLL0kFyALRMVobGAE4HVP2gSnbZjAS1dvwoTyJ21kE9pwdtxAnJm
         OPbIuV/i3NTjeyZ/3DYpwtq2VUCvL4ZfpAhp2NSNY50v3+nC3iWWyba18tifIomHhCeu
         XZH6city9FhZwhITxoycIeHMVHjCxlFX3z3tjloVglMEjk5YS/zxst5EbxNAKgDrDVqp
         IXbyy+9EzPfcoNawyEPk3Q1mmH7Mg/6lp/iVV7nPR5DZxbPytSwSYWX3GA82hv8yPiKP
         z2K6wHLWajd24gl7cgzMMhVMR4+lcUK5MbDb1S4AmTqvOO54gWxBY9Rn1xzgbGgA7Tjm
         rmgQ==
X-Gm-Message-State: ACrzQf1D2nPm7n/NN9nMBb9fGwj9pPy0zQoOtkRGaOi1DJ/rmd8nnj4H
        WpiLRXDOlITa5bjOgnS67w==
X-Google-Smtp-Source: AMsMyM4J0jsICzG6PLSszDHGXgcCVxk4Dtro0+PHiqqqPZnGRwHQVzDkBl7+pXWAIsyOLBqyL55tWg==
X-Received: by 2002:a9d:64c3:0:b0:656:d706:1df with SMTP id n3-20020a9d64c3000000b00656d70601dfmr10394439otl.212.1666385678708;
        Fri, 21 Oct 2022 13:54:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870149600b00127d2005ea1sm10848827oab.18.2022.10.21.13.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:54:38 -0700 (PDT)
Received: (nullmailer pid 304654 invoked by uid 1000);
        Fri, 21 Oct 2022 20:54:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: Add 'cpuX' to 'linux,default-trigger'
Date:   Fri, 21 Oct 2022 15:54:28 -0500
Message-Id: <20221021205428.304422-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'cpu' and 'cpuN' to possible values for 'linux,default-trigger'.
There's 45 cases of them in upstream dts files.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/leds/common.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index 3c14a98430e1..f5c57a580078 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -100,6 +100,7 @@ properties:
           - pattern
         # LED is triggered by SD/MMC activity
       - pattern: "^mmc[0-9]+$"
+      - pattern: "^cpu[0-9]*$"
 
   led-pattern:
     description: |
-- 
2.35.1

