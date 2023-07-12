Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0425750647
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGLLii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjGLLi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:38:29 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D961994
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=ilnQAzhkzQbHlzdI76gswcqDlW6Rxu0S5Cd2vxmIpbY=; b=F2UijB
        020gDZg0aQdUbhqDiFJbrOXtXLrgwaqr+1aQ/phqgDQcveY9q5C/zH45ra9P9YWv
        33HOfZJ8RGHw1dmaZMtXvEco5AzsWUg5bq50e6Y+eM6cJegEpahKp1+I42wR9zvC
        VIa/y3DSQlSAN0CM4jreD9mEch6wiEOsst2mKzv69KEgtBgv4uHG93eEzWMAaYMX
        73cKJo5sR8n7PNVQ7iItn48f7lN7TmPsUP4D9HMoTRujyeVd7TnRQnOr89uXpwBS
        u19i3hq+Sq1jutTzC1l+iCc1FedqgVPmYW3K/f0asARqnJBoogvsgtX1dLjeObol
        E/BU/BfYFdZOFT5g==
Received: (qmail 1596815 invoked from network); 12 Jul 2023 13:37:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jul 2023 13:37:45 +0200
X-UD-Smtp-Session: l3s3148p1@NN/tpEgAVqUujnvL
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: gnss: u-blox: add "reset-gpios" binding
Date:   Wed, 12 Jul 2023 13:37:30 +0200
Message-Id: <20230712113731.3306-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
References: <20230712113731.3306-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed to enable this chip on a Renesas KingFisher board. Description
copied over from the Mediatek driver which already supports it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
index 4835a280b3bf..8f6992b97ca6 100644
--- a/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
+++ b/Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml
@@ -41,6 +41,12 @@ properties:
     description: >
       Backup voltage regulator
 
+  reset-gpios:
+    maxItems: 1
+    description: >
+      An optional reset line, with names such as RESET or NRESET.
+      If the line is active low it should be flagged with GPIO_ACTIVE_LOW.
+
 required:
   - compatible
   - vcc-supply
@@ -54,5 +60,6 @@ examples:
             compatible = "u-blox,neo-8";
             v-bckp-supply = <&gnss_v_bckp_reg>;
             vcc-supply = <&gnss_vcc_reg>;
+            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
         };
     };
-- 
2.30.2

