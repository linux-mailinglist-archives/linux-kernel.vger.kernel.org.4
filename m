Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C562784D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiKNI5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiKNI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:57:15 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157B21CFE7;
        Mon, 14 Nov 2022 00:57:12 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 145B910000A;
        Mon, 14 Nov 2022 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668416231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PH1TaWI18OK/TWX9eI82Zyj07sQxLoh1aLVV4ESIk3Q=;
        b=FV57343RzuyqV9ECyUhRuzb68q4wvUf5r1ZryMT9Dt7M4PUKQkEeIDh+jygW8G/vs+L7QC
        /MCMF3ryQ7SkLtfi8WU3GFEUiuF+ttd2DiNkzcZnaJe1rr64eopFLMmcNqgrT0Mh4M8Fsl
        sxeJPEAKqUIR7zy6xKBzvnvLz02BlBH83RwK5zZS/6WDD4As/SWh5pRpU/tr00/4bt2kVw
        68POKZpO+svRrphqzjVmvslf+x0vdIyw1VxZoFKBji+LzKIw8thflRaroEmPJpncQo7Vdf
        YAUVytnUYt2sC6gMmmNt7ywjJNBrl5Gr839gQOyFgp11F2Kbj0wnmobsB7BChA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 4/5] dt-bindings: vendor-prefixes: Add ONIE
Date:   Mon, 14 Nov 2022 09:56:58 +0100
Message-Id: <20221114085659.847611-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114085659.847611-1-miquel.raynal@bootlin.com>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described on their website (see link below),

   "The Open Network Install Environment (ONIE) is an open source
    initiative that defines an open “install environment” for modern
    networking hardware."

It is not a proper corporation per-se but rather more a group which
tries to spread the use of open source standards in the networking
hardware world.

Link: https://opencomputeproject.github.io/onie/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6e323a380294..65a74026cf2b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -927,6 +927,8 @@ patternProperties:
     description: One Laptop Per Child
   "^oneplus,.*":
     description: OnePlus Technology (Shenzhen) Co., Ltd.
+  "^onie,.*":
+    description: Open Network Install Environment group
   "^onion,.*":
     description: Onion Corporation
   "^onnn,.*":
-- 
2.34.1

